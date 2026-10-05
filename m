Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3925D1E9;
	Mon,  5 Oct 2026 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791168569; cv=none; b=uB5FS3/L2g11Xz1arPlsdjZORGN1F5P4MORB82hv0RchmdniLYb0GAIMUfGzzQfSnQelvPG7Uo7VhypcTX03R/ndIcNKl/yDIAdnh2ot8mv74M3OYBZUBhoTyxVkYHZz7f6kVNjyfUfJQ6BEdctkiAGO6bI7okQpN0YX8DQIYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791168569; c=relaxed/simple;
	bh=bHcQHEbMxPpAZQkh1POf87FHyoRuYDVIl6LWCcl/Ugo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCGZPs/pFuZcBZGdpb3pBn6HjH7fIhrR1AUfz7VUtDsw83llaHqgybZnCResLn5Z68IcBvRAC9LAt3EaEGOJ78zN2cjYjrvf5DR1QU0A5KBCVKcIZc59OFi/CkcBQVwZOGuM3OmAvQkgnn6Bb/qf9DplP9oszWywwQUDJ+4Ixds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFI3GrbD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFI3GrbD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A48621F000FF;
	Mon,  5 Oct 2026 02:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791168567;
	bh=nJA/eoLkp5QJqnVOP24dmqXGkOpyJ/rD4WY4SmUd6i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iFI3GrbDyCPJY3vhQEi1yavMOhGcBqZvZexslRWp408/sLBPaAOwTUW+N47NQDFVe
	 NFm3yhc9X2WORu5VmfXeAZsTk7yn9UG7vp4uhBz2fCJEWILx3dBhZg4oE+HHHoeV7F
	 L5WoqYYTGDi/YUXfkTEMDmkAxolF46eAkeecsbc6DY/GGowDgWuq3NAu1fj0/BQJH7
	 pTgvK7wPLgsK6NCk3D9SQM0ChAxYHm585ug+jgrH95LbXbvhikDuvv7gfnaFrA0aiy
	 i2hehJppO+Jv5yn4sa3YPXzo/HbAdOec8hpipBsXBKv8YUfqI1ZQ/euNwUVr961uDW
	 9visofQaOG+Fg==
Date: Mon, 5 Oct 2026 05:49:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] keys: Serialize ownership transfers with key
 accounting
Message-ID: <asMQMzqVkmYhwgMB@kernel.org>
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
 <20260927162528.943886-3-nicoyip.dev@gmail.com>
 <asMIwpXXWQaD3gAD@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asMIwpXXWQaD3gAD@kernel.org>

On Mon, Oct 05, 2026 at 05:17:42AM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 28, 2026 at 12:25:28AM +0800, Chengfeng Ye wrote:
> > Protecting individual accesses to key->user does not make ownership
> > transfers atomic with accounting updates. keyctl_chown_key() holds
> > key->sem, but instantiation is serialized by key_construction_mutex and
> > need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
> > an uninstantiated key.
> > 
> > The instantiated-key count can therefore be charged to the wrong owner:
> > 
> >   instantiate                       keyctl_chown_key()
> >   lock key_user_lock
> >   increment old->nikeys
> >   unlock key_user_lock
> >                                     observe KEY_IS_UNINSTANTIATED
> >                                     skip the nikeys transfer
> >                                     replace key->user
> >   mark key instantiated
> > 
> > The key becomes instantiated under the new owner while the increment
> > remains with the old owner. Negative instantiation has the same race.
> > 
> > Quota reservation can likewise run between charging the new owner and
> > replacing key->user. It then adjusts the old owner's quota and changes
> > key->quotalen while chown is transferring that quota burden.
> > 
> > Extend the key_user_lock critical section in keyctl_chown_key() across
> > the quota and key-count transfers, state check, and owner replacement.
> > Also extend the instantiation critical sections across the state update,
> > so chown observes the count increment and instantiated state together.
> > The existing per-user quota locks continue to serialize quota changes
> > against other keys owned by the same user.
> > 
> > Keep allocations, notifications and reference release outside
> > key_user_lock, and release it on the quota-overrun path.
> > 
> > Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v3:
> > - Split from v2 as patch 2/2; see the cover letter for the full split.
> > - Rebase onto current mainline and retain explicit reader-side locking.
> > 
> > v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
> > 
> >  security/keys/key.c    | 4 ++--
> >  security/keys/keyctl.c | 6 ++++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index d0d583194b05..54c675b3b58d 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -454,8 +454,8 @@ static int __key_instantiate_and_link(struct key *key,
> >  			/* mark the key as being instantiated */
> >  			spin_lock(&key_user_lock);
> >  			atomic_inc(&key->user->nikeys);
> > -			spin_unlock(&key_user_lock);
> >  			mark_key_instantiated(key, 0);
> > +			spin_unlock(&key_user_lock);
> >  			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
> >  
> >  			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
> > @@ -613,8 +613,8 @@ int key_reject_and_link(struct key *key,
> >  		/* mark the key as being negatively instantiated */
> >  		spin_lock(&key_user_lock);
> >  		atomic_inc(&key->user->nikeys);
> > -		spin_unlock(&key_user_lock);
> >  		mark_key_instantiated(key, -error);
> > +		spin_unlock(&key_user_lock);
> >  		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
> >  		key_set_expiry(key, ktime_get_real_seconds() + timeout);
> >  
> > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > index c17924609317..83a9575b084e 100644
> > --- a/security/keys/keyctl.c
> > +++ b/security/keys/keyctl.c
> > @@ -1004,6 +1004,8 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
> >  		if (!newowner)
> >  			goto error_put;
> >  
> > +		spin_lock(&key_user_lock);
> > +
> >  		/* transfer the quota burden to the new user */
> >  		if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> >  			unsigned maxkeys = uid_eq(uid, GLOBAL_ROOT_UID) ?
> > @@ -1036,11 +1038,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
> >  			atomic_inc(&newowner->nikeys);
> >  		}
> >  
> > -		spin_lock(&key_user_lock);
> >  		zapowner = key->user;
> >  		key->user = newowner;
> > -		spin_unlock(&key_user_lock);
> >  		key->uid = uid;
> > +		spin_unlock(&key_user_lock);
> >  	}
> >  
> >  	/* change the GID */
> > @@ -1060,6 +1061,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
> >  
> >  quota_overrun:
> >  	spin_unlock_irqrestore(&newowner->lock, flags);
> > +	spin_unlock(&key_user_lock);
> >  	zapowner = newowner;
> >  	ret = -EDQUOT;
> >  	goto error_put;
> > -- 
> > 2.43.0
> > 
> 
> I double-checked this patch too given the concerns on 1/2 but nope, this
> does not raise similar concerns as every critical section is strictly
> related to ownership change.
> 
> E.g., I can be sure that the granularity is where it should be and locks
> are actually needed in the first place.
> 
> Thus, I'm still including this patch to my next PR, and drop the first
> one.

By dropping 1/2 I found out that 2/2 key.c becomes:

diff --git a/security/keys/key.c b/security/keys/key.c
index a438c4508595..de63120c51ad 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -449,6 +449,7 @@ static int __key_instantiate_and_link(struct key *key,
 			/* mark the key as being instantiated */
 			atomic_inc(&key->user->nikeys);
 			mark_key_instantiated(key, 0);
+			spin_unlock(&key_user_lock);
 			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);

 			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
@@ -606,6 +607,7 @@ int key_reject_and_link(struct key *key,
 		/* mark the key as being negatively instantiated */
 		atomic_inc(&key->user->nikeys);
 		mark_key_instantiated(key, -error);
+		spin_unlock(&key_user_lock);
 		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
 		key_set_expiry(key, ktime_get_real_seconds() + timeout);

This type of interleaving should never happen in a patch series.

Please don't rush your changes like this in future.

Br, Jarkko
