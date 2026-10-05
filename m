Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6B154425;
	Mon,  5 Oct 2026 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791166663; cv=none; b=cnW6cmH9O9C0AMpkOdWmOFZxQx/mnEptP9pEfSuTgzKZksH71De+tZUw1BhiOZOAcrVNALyuUxACcWc3Np1CRO9EMIQBn8I7K5XJ7BbAPrPaRtw/8tYnIeE5kfxT9AeBGuCa5MTv63NLENUp1Vi5Fma8H/ggWCXnAvPqwX/WY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791166663; c=relaxed/simple;
	bh=ylS8TTzsyrZM1GQKOw7m7unyXnN+OPv6+bY0H7Z7XjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5HdUB7ZmAjmi7lKxB3uJhOuRnMInxRpLLs9YLQB89pvVBjUXLTmDKtJvT8gwossuZBQbuVdhPNXiKCH7vPXC/5YYFCRxEvGluRVIMs8hRVfjiaYG2b4xXTCgWONpVMuFIt+FMkJhWsTZ1HjHZyWDsUj3ODKS6vjPpkWoPuoKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIbA6BcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIbA6BcF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5F8411F000FF;
	Mon,  5 Oct 2026 02:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791166661;
	bh=YODgHxeSs/DUqBefSwV60XuzUgb+9/IYbG0yXc4NXV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UIbA6BcFA7VhilW1+zO1fYqVop+Yxbyqyby1oAuBepvwk0gqeYnv8y4I0eYyYkFsY
	 ZLQIOAS6wLqn/obMkimWDnTFHWtFe078NNo0HHz+UoBX6KE6qw7oyoY3nwr7zLfQgw
	 GU0pAQ2YvpAE6UFE/68oDMC2oU67rxzGzrgcTJdZOtGxMCiHYJzu1SiO+BExQlO+tN
	 0yCmKSj5zoGrgoaLBIgRhExZbhrPyI3bDNyEZ5ydIyXoA5t6iB8f+FsIJiVHANjHkX
	 7W3MvJ/RQGSC8NF2Fqz5AYJzNsHR1658FvWL4fxsbHusTXiqUzPATq5+T3raCoMQ7/
	 NTJG1bU8pSDuQ==
Date: Mon, 5 Oct 2026 05:17:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] keys: Serialize ownership transfers with key
 accounting
Message-ID: <asMIwpXXWQaD3gAD@kernel.org>
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
 <20260927162528.943886-3-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927162528.943886-3-nicoyip.dev@gmail.com>

On Mon, Sep 28, 2026 at 12:25:28AM +0800, Chengfeng Ye wrote:
> Protecting individual accesses to key->user does not make ownership
> transfers atomic with accounting updates. keyctl_chown_key() holds
> key->sem, but instantiation is serialized by key_construction_mutex and
> need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
> an uninstantiated key.
> 
> The instantiated-key count can therefore be charged to the wrong owner:
> 
>   instantiate                       keyctl_chown_key()
>   lock key_user_lock
>   increment old->nikeys
>   unlock key_user_lock
>                                     observe KEY_IS_UNINSTANTIATED
>                                     skip the nikeys transfer
>                                     replace key->user
>   mark key instantiated
> 
> The key becomes instantiated under the new owner while the increment
> remains with the old owner. Negative instantiation has the same race.
> 
> Quota reservation can likewise run between charging the new owner and
> replacing key->user. It then adjusts the old owner's quota and changes
> key->quotalen while chown is transferring that quota burden.
> 
> Extend the key_user_lock critical section in keyctl_chown_key() across
> the quota and key-count transfers, state check, and owner replacement.
> Also extend the instantiation critical sections across the state update,
> so chown observes the count increment and instantiated state together.
> The existing per-user quota locks continue to serialize quota changes
> against other keys owned by the same user.
> 
> Keep allocations, notifications and reference release outside
> key_user_lock, and release it on the quota-overrun path.
> 
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v3:
> - Split from v2 as patch 2/2; see the cover letter for the full split.
> - Rebase onto current mainline and retain explicit reader-side locking.
> 
> v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
> 
>  security/keys/key.c    | 4 ++--
>  security/keys/keyctl.c | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index d0d583194b05..54c675b3b58d 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -454,8 +454,8 @@ static int __key_instantiate_and_link(struct key *key,
>  			/* mark the key as being instantiated */
>  			spin_lock(&key_user_lock);
>  			atomic_inc(&key->user->nikeys);
> -			spin_unlock(&key_user_lock);
>  			mark_key_instantiated(key, 0);
> +			spin_unlock(&key_user_lock);
>  			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
>  
>  			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
> @@ -613,8 +613,8 @@ int key_reject_and_link(struct key *key,
>  		/* mark the key as being negatively instantiated */
>  		spin_lock(&key_user_lock);
>  		atomic_inc(&key->user->nikeys);
> -		spin_unlock(&key_user_lock);
>  		mark_key_instantiated(key, -error);
> +		spin_unlock(&key_user_lock);
>  		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
>  		key_set_expiry(key, ktime_get_real_seconds() + timeout);
>  
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index c17924609317..83a9575b084e 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1004,6 +1004,8 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  		if (!newowner)
>  			goto error_put;
>  
> +		spin_lock(&key_user_lock);
> +
>  		/* transfer the quota burden to the new user */
>  		if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
>  			unsigned maxkeys = uid_eq(uid, GLOBAL_ROOT_UID) ?
> @@ -1036,11 +1038,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  			atomic_inc(&newowner->nikeys);
>  		}
>  
> -		spin_lock(&key_user_lock);
>  		zapowner = key->user;
>  		key->user = newowner;
> -		spin_unlock(&key_user_lock);
>  		key->uid = uid;
> +		spin_unlock(&key_user_lock);
>  	}
>  
>  	/* change the GID */
> @@ -1060,6 +1061,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  
>  quota_overrun:
>  	spin_unlock_irqrestore(&newowner->lock, flags);
> +	spin_unlock(&key_user_lock);
>  	zapowner = newowner;
>  	ret = -EDQUOT;
>  	goto error_put;
> -- 
> 2.43.0
> 

I double-checked this patch too given the concerns on 1/2 but nope, this
does not raise similar concerns as every critical section is strictly
related to ownership change.

E.g., I can be sure that the granularity is where it should be and locks
are actually needed in the first place.

Thus, I'm still including this patch to my next PR, and drop the first
one.

Br, Jarkko
