Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B036197E;
	Mon,  5 Oct 2026 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182400; cv=none; b=OiqsjxgipCGJjmW6HmafPPoI4vq9xCwkNVTyaJga0PURtME+cG/KBIgaedcB0PDt7sfbf6Blq2/cRNkBU+nrMvMhW9HCIvXr6P/HEkKGr3U4F/M2WG/gJTZtxV5a1dCwtwGJi3l0nHnFNvQ0u3Q7M4yY+F2lDf1jz9GZIF8vBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182400; c=relaxed/simple;
	bh=kvZ8iK2XNg8Pj0Y1AckmPYP3vHm3VWgMIyBgcTgaZUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGih+ITm1wdfhfmlK9uOsvINzU1eMO3lIKur23C5sHUDyZT/qqxFGYPdBLGYBnC7sHmqoV3wGisnK708SiApXF0aO8/I1XFkDdmhPQyfEjTqM4jr9YaIMHWRkxkSukuL8mF3INvemqPaY7fBEjUgQANbEibM1A7PuellPsTYbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC4VNCLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC4VNCLN"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 248591F00893;
	Mon,  5 Oct 2026 06:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182398;
	bh=1d2EodIpxVWoMlO3htkWgV6Xs1hq7/mTcOa8KBS+yIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jC4VNCLN0EGBCCGXxGRHtcZCQgkf0hOYGVr0JAiiDy/iGBJkVdIByKI6uhNBdFKgJ
	 1bTYbeoBg3tSIb79WFo/DzKGIu+RTPuHUnfGlbP+MnveQdLuBtLUM2eExiwlEEG8JQ
	 zr4adR7xeuq5pwM/YbS+7udYT+q8QCyR5p0eDQa1IDUXqaTPBg650hOgXz7YC70S/v
	 mHi3O+UKtxXTptKantJLMA69VEMSjkE5bx3oC4Bjs/rp0sjjIDXtFbJKagRDgpJS1a
	 uYlc60NdmOOiLx3DMMhOY1sCA22/2qHyZOEhJ7fU4mA285Ysc6qacYebpC+JvI1Lv2
	 Rj8M0hbeIiKrw==
Date: Mon, 5 Oct 2026 09:39:54 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] keys: Serialize ownership transfers with key
 accounting
Message-ID: <asNCIs3OshLwGWrB@kernel.org>
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
 <20260927162528.943886-3-nicoyip.dev@gmail.com>
 <asMIwpXXWQaD3gAD@kernel.org>
 <asMQMzqVkmYhwgMB@kernel.org>
 <CAAo+4rULBiu6tOrdOjsgFcudjvyQO+DR9oZK=wms_3KxgFPNHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAo+4rULBiu6tOrdOjsgFcudjvyQO+DR9oZK=wms_3KxgFPNHA@mail.gmail.com>

On Mon, Oct 05, 2026 at 01:53:29PM +0800, Chengfeng Ye wrote:
> On Mon, Oct 5, 2026 at 10:49 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon, Oct 05, 2026 at 05:17:42AM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Sep 28, 2026 at 12:25:28AM +0800, Chengfeng Ye wrote:
> > > > Protecting individual accesses to key->user does not make ownership
> > > > transfers atomic with accounting updates. keyctl_chown_key() holds
> > > > key->sem, but instantiation is serialized by key_construction_mutex and
> > > > need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
> > > > an uninstantiated key.
> > > >
> > > > The instantiated-key count can therefore be charged to the wrong owner:
> > > >
> > > >   instantiate                       keyctl_chown_key()
> > > >   lock key_user_lock
> > > >   increment old->nikeys
> > > >   unlock key_user_lock
> > > >                                     observe KEY_IS_UNINSTANTIATED
> > > >                                     skip the nikeys transfer
> > > >                                     replace key->user
> > > >   mark key instantiated
> > > >
> > > > The key becomes instantiated under the new owner while the increment
> > > > remains with the old owner. Negative instantiation has the same race.
> > > >
> > > > Quota reservation can likewise run between charging the new owner and
> > > > replacing key->user. It then adjusts the old owner's quota and changes
> > > > key->quotalen while chown is transferring that quota burden.
> > > >
> > > > Extend the key_user_lock critical section in keyctl_chown_key() across
> > > > the quota and key-count transfers, state check, and owner replacement.
> > > > Also extend the instantiation critical sections across the state update,
> > > > so chown observes the count increment and instantiated state together.
> > > > The existing per-user quota locks continue to serialize quota changes
> > > > against other keys owned by the same user.
> > > >
> > > > Keep allocations, notifications and reference release outside
> > > > key_user_lock, and release it on the quota-overrun path.
> > > >
> > > > Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > > > ---
> > > > Changes in v3:
> > > > - Split from v2 as patch 2/2; see the cover letter for the full split.
> > > > - Rebase onto current mainline and retain explicit reader-side locking.
> > > >
> > > > v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
> > > >
> > > >  security/keys/key.c    | 4 ++--
> > > >  security/keys/keyctl.c | 6 ++++--
> > > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > > index d0d583194b05..54c675b3b58d 100644
> > > > --- a/security/keys/key.c
> > > > +++ b/security/keys/key.c
> > > > @@ -454,8 +454,8 @@ static int __key_instantiate_and_link(struct key *key,
> > > >                     /* mark the key as being instantiated */
> > > >                     spin_lock(&key_user_lock);
> > > >                     atomic_inc(&key->user->nikeys);
> > > > -                   spin_unlock(&key_user_lock);
> > > >                     mark_key_instantiated(key, 0);
> > > > +                   spin_unlock(&key_user_lock);
> > > >                     notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
> > > >
> > > >                     if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
> > > > @@ -613,8 +613,8 @@ int key_reject_and_link(struct key *key,
> > > >             /* mark the key as being negatively instantiated */
> > > >             spin_lock(&key_user_lock);
> > > >             atomic_inc(&key->user->nikeys);
> > > > -           spin_unlock(&key_user_lock);
> > > >             mark_key_instantiated(key, -error);
> > > > +           spin_unlock(&key_user_lock);
> > > >             notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
> > > >             key_set_expiry(key, ktime_get_real_seconds() + timeout);
> > > >
> > > > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > > > index c17924609317..83a9575b084e 100644
> > > > --- a/security/keys/keyctl.c
> > > > +++ b/security/keys/keyctl.c
> > > > @@ -1004,6 +1004,8 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
> > > >             if (!newowner)
> > > >                     goto error_put;
> > > >
> > > > +           spin_lock(&key_user_lock);
> > > > +
> > > >             /* transfer the quota burden to the new user */
> > > >             if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> > > >                     unsigned maxkeys = uid_eq(uid, GLOBAL_ROOT_UID) ?
> > > > @@ -1036,11 +1038,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
> > > >                     atomic_inc(&newowner->nikeys);
> > > >             }
> > > >
> > > > -           spin_lock(&key_user_lock);
> > > >             zapowner = key->user;
> > > >             key->user = newowner;
> > > > -           spin_unlock(&key_user_lock);
> > > >             key->uid = uid;
> > > > +           spin_unlock(&key_user_lock);
> > > >     }
> > > >
> > > >     /* change the GID */
> > > > @@ -1060,6 +1061,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
> > > >
> > > >  quota_overrun:
> > > >     spin_unlock_irqrestore(&newowner->lock, flags);
> > > > +   spin_unlock(&key_user_lock);
> > > >     zapowner = newowner;
> > > >     ret = -EDQUOT;
> > > >     goto error_put;
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > I double-checked this patch too given the concerns on 1/2 but nope, this
> > > does not raise similar concerns as every critical section is strictly
> > > related to ownership change.
> > >
> > > E.g., I can be sure that the granularity is where it should be and locks
> > > are actually needed in the first place.
> > >
> > > Thus, I'm still including this patch to my next PR, and drop the first
> > > one.
> >
> > By dropping 1/2 I found out that 2/2 key.c becomes:
> >
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index a438c4508595..de63120c51ad 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -449,6 +449,7 @@ static int __key_instantiate_and_link(struct key *key,
> >                         /* mark the key as being instantiated */
> >                         atomic_inc(&key->user->nikeys);
> >                         mark_key_instantiated(key, 0);
> > +                       spin_unlock(&key_user_lock);
> >                         notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
> >
> >                         if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
> > @@ -606,6 +607,7 @@ int key_reject_and_link(struct key *key,
> >                 /* mark the key as being negatively instantiated */
> >                 atomic_inc(&key->user->nikeys);
> >                 mark_key_instantiated(key, -error);
> > +               spin_unlock(&key_user_lock);
> >                 notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
> >                 key_set_expiry(key, ktime_get_real_seconds() + timeout);
> >
> > This type of interleaving should never happen in a patch series.
> >
> > Please don't rush your changes like this in future.
> >
> > Br, Jarkko
> 
> Sorry for the mistake, I should have carefully verified that the tree
> remained valid at each step of the series.
> 
> I will rework the locking on 1/2 to inspect if there might be any
> unnecessary coverage, and verify each intermediate commit
> independently before sending a revised version for the patch series.

No problem. I just wanted to underline this :-) And I will gladly take
part of the blame given that I also rushed and this should have been
catched and fixed during the review cycle.

So let's just address this, phase down a bit so that at least correct
stuff gets out (and as many review cycles that requires).

The basis of the fix is not rotten. It does address the correct
root cause and is going into right direction. It's just not taken
to the end.

> 
> Best regards,
> Chengfeng

Br, Jarkko
