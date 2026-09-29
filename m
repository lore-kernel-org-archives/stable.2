Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBA370D63;
	Tue, 29 Sep 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716830; cv=none; b=dgEUYtXd1pDQnHj7loDsktY4HDXiO7I1lenUbtYIHxuGotkgdF0OBLAvNK7B2ly+Wu9eblaIttJURNMCNIO8i1nIAZuzPEFi225968bx5cY0TTFxLPxhafNxMl7OdBZLCmPU/Uh+DY1xFQHBrcPaRDMRx13y9YKS1wNrSWSltUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716830; c=relaxed/simple;
	bh=W89NSarCMr1fFXyiX5Ed9mxGTIST1wbUoawyn5NghsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCGj1SMdelO5dEUeHQ8MIYLQFHbEYZ6wqPu1+btxxfowiwjUSod1HTSqApZCNS0JbHXeVIXvHGs4HNMV4sJaFXEIRMHNnop8loqsl/V5HpV2UJr059MAaWiKjInskKjiY/PtS9KPw48UrqbfpryTB3+m+NKvwR4qen9gQrHXaDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQo9U/C2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQo9U/C2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 955B11F000FF;
	Tue, 29 Sep 2026 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716829;
	bh=fmeytQI0jI8zXE1+oVgIXzegn50CnDCTxWxQUtmF2iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HQo9U/C2+QDlnij0STWLhDn+VrDkpiPB4oJY5KnBOuSe7juaWLbsTnirXC31sIag0
	 HlTYcjJ0LGXxubHOc6qaLMLY7vCVAjq6vD2BNpun+MCzsCN7lEo2BXpDnCKamw3KgH
	 Y2x3QzwbMcz89fFYKHV4m4f7R6PPE5Di684zeabzIReWo7ySGBWijNBqO4oc3YKHpI
	 CXd8zONlAuGlE/nb2bP4eTySOimogTGyr+IS4V0aPj59oFzQQFhmsGqwsVZDtmCvWS
	 9HIWT2uuGTYsUHXVTpXY555VGMILDKNEfzQ7a4RnUi+8BM1BBGh8kL6gAQLfLWKJTE
	 36dnlAG1Y66tg==
Date: Wed, 30 Sep 2026 00:20:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] keys: Serialize ownership transfers with key
 accounting
Message-ID: <arwrmd2IPBdr3SMU@kernel.org>
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


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko

