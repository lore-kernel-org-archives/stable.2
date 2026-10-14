Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75305427F85;
	Wed, 14 Oct 2026 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977814; cv=none; b=n9kE9WUc0+XR1aAPJeVo5hyMQHpJsBo/IFMgfa5v/cEvWl2N45VuSh7VzHfF1/CNGlBIRG05ox2PT0Beo4WiY6dBdSYYbQ3/WFMfNqJwAPManj/FvW5IZzVGofP3Jgj5wXkKVNxFRoL8QuNLrRKKseVXKdQueufBus6+NAAJpfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977814; c=relaxed/simple;
	bh=XcyS99+Kbv5rn9cWJrGOJUyPFuI4EC7WqUd2AK9hx/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/BDEOVsdIpiGLko+6nhYM3zfliy8qM7fQaCr2YVR3yIoCVDwEySyh1MsbfU6AxY5AxP6Bm8D1JFHDkRFurJbNpS5YJEWa8QLjo1I3PYGHaa9RUgmzBS+zrzi+NbIfkEQNCKwKyaE7H/lKMRiFZ2Lajuo+hjIWrCSBveKlol9lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9jDLkQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9jDLkQC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7160D1F000FF;
	Wed, 14 Oct 2026 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791977813;
	bh=2chnn8IPO4J98ng+B05x9dDd9D8YofuIAg9VutH4Fuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A9jDLkQCmqWxePoe+Sh8KP209V3rLJeloSjICkwXd1AdJEpCH2mZDYRD9YuKioRmi
	 8xDiOGRYB+gwiKdcd66G+GB1ZhfYhTGuIgbFRQK4Q3GSegbkUkJlONP5CJy7HkImx5
	 FxAAVy/4zVPSogfqZsRUosc+xPi7x5FUIarlq9Li2Ghcfb+Xf2+OKqJ53OegGd3QrY
	 JRXzzeK/bzCbSxNoQ2ij/GVk4kJBb8xKq9UoTpjxhMhFrc5pmMQYWcgwFbvmy+hR+B
	 Tt02c3vAnJo9MB9WbugP6qMPCbwEQrG3QenaKaGBSmwYeb3LlsYMzfysZ4efkLrqN9
	 3Nri54iqqTdnw==
Date: Wed, 14 Oct 2026 14:36:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] keys: Serialize ownership transfers with key
 accounting
Message-ID: <as9pUYoOmLI2l5oB@kernel.org>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-2-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013090358.1178367-2-nicoyip.dev@gmail.com>

On Tue, Oct 13, 2026 at 05:03:58PM +0800, Chengfeng Ye wrote:
> Protecting individual accesses to key->user does not make ownership
> transfers atomic with accounting updates. keyctl_chown_key() holds
> key->sem, but instantiation is serialized by key_construction_mutex and
> need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
> an uninstantiated key.
> 
> The instantiated-key count can therefore be charged to the wrong owner:
> 
>   instantiate                       keyctl_chown_key()
>   increment old->nikeys
>                                     observe KEY_IS_UNINSTANTIATED
>                                     skip the nikeys transfer
>                                     replace key->user
>   mark key instantiated


Same here there's another below.

> 
> The key becomes instantiated under the new owner while the increment
> remains with the old owner. Negative instantiation has the same race.
> 
> Quota reservation can likewise run between charging the new owner and
> replacing key->user. It then adjusts the old owner's quota and changes
> key->quotalen while chown is transferring that quota burden.
> key_payload_reserve() can run during instantiation without key->sem,
> so it needs the same exclusion against chown.
> 
> Hold key_user_lock in keyctl_chown_key() across the quota and key-count
> transfers, state check, and owner replacement; locking only the pointer
> store leaves the preceding accounting exposed. In
> __key_instantiate_and_link() and key_reject_and_link(), hold it across
> the instantiated-key count increment and state update, so chown observes
> both together. Atomic counter operations alone do not stabilize the
> owner or couple the increment with state publication.
> 
> Hold the same lock in key_payload_reserve() from owner selection through
> updating qnbytes and key->quotalen. The per-user quota lock cannot
> stabilize key->user during a transfer. Retain the existing per-user locks
> to serialize quota changes against other keys owned by the same user.
> 
> Keep allocations, notifications and reference release outside
> key_user_lock, and release it on the quota-overrun path.
> 
> Normal updates through key_update() and __key_update() already hold
> key->sem and exclude chown. key_alloc() charges a referenced owner before
> publishing the key. Final key_put() and key_gc_unused_keys() cannot race
> with chown, which requires a key reference. Their existing per-user locks
> and atomic counters still protect totals shared with other keys.
> key_user_lookup()/key_user_put() already protect owner creation and final
> removal with key_user_lock. These sites need no new ownership lock.
> 
> This accounting race was identified by source inspection.
> 
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> Cc: stable@vger.kernel.org
> Assisted-by: GPT-6-Astra
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v4:
> - Include the reservation and instantiation scopes formerly in v3 1/2;
>   retain the same combined lock coverage while making this fix complete.
> - Keep accounting serialization as patch 2/2, matching v3. Include the
>   full lock/count/state/unlock scope at both instantiation sites.
> - Include quota reservation and the entire chown accounting transaction;
>   this patch can be applied without the namespace-reader fix.
> 
> v3: https://lore.kernel.org/r/20260927162528.943886-3-nicoyip.dev@gmail.com/
> v3 1/2: https://lore.kernel.org/r/20260927162528.943886-2-nicoyip.dev@gmail.com/
> v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
> 
>  security/keys/key.c    | 15 +++++++++++++--
>  security/keys/keyctl.c |  4 ++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index a438c4508595d..61dd991cee543 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -21,6 +21,9 @@ struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
>  DEFINE_SPINLOCK(key_serial_lock);
>  
>  struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
> +/*
> + * Protects key_user_tree and serializes ownership changes with key accounting.
> + */

Umh, why do you see this addition necessary in order to address bug? You
have to remove it because it is a spurious change.

>  DEFINE_SPINLOCK(key_user_lock);
>  
>  unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
> @@ -380,9 +383,12 @@ int key_payload_reserve(struct key *key, size_t datalen)
>  
>  	/* contemplate the quota adjustment */
>  	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> -		unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
> -			key_quota_root_maxbytes : key_quota_maxbytes;
>  		unsigned long flags;
> +		unsigned int maxbytes;
> +
> +		spin_lock(&key_user_lock);
> +		maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
> +			key_quota_root_maxbytes : key_quota_maxbytes;
>  
>  		spin_lock_irqsave(&key->user->lock, flags);
>  
> @@ -396,6 +402,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
>  			key->quotalen += delta;
>  		}
>  		spin_unlock_irqrestore(&key->user->lock, flags);
> +		spin_unlock(&key_user_lock);
>  	}
>  
>  	/* change the recorded data length if that didn't generate an error */
> @@ -447,8 +454,10 @@ static int __key_instantiate_and_link(struct key *key,
>  
>  		if (ret == 0) {
>  			/* mark the key as being instantiated */
> +			spin_lock(&key_user_lock);
>  			atomic_inc(&key->user->nikeys);
>  			mark_key_instantiated(key, 0);
> +			spin_unlock(&key_user_lock);
>  			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
>  
>  			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
> @@ -604,8 +613,10 @@ int key_reject_and_link(struct key *key,
>  	/* can't instantiate twice */
>  	if (key->state == KEY_IS_UNINSTANTIATED) {
>  		/* mark the key as being negatively instantiated */
> +		spin_lock(&key_user_lock);
>  		atomic_inc(&key->user->nikeys);
>  		mark_key_instantiated(key, -error);
> +		spin_unlock(&key_user_lock);
>  		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
>  		key_set_expiry(key, ktime_get_real_seconds() + timeout);
>  
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index c89a4d6efed40..e74fa0076ee0b 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1006,2 +1006,4 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  
> +		spin_lock(&key_user_lock);
> +
>  		/* transfer the quota burden to the new user */
> @@ -1041,2 +1043,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  		key->uid = uid;
> +		spin_unlock(&key_user_lock);
>  	}
> @@ -1060,2 +1063,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  	spin_unlock_irqrestore(&newowner->lock, flags);
> +	spin_unlock(&key_user_lock);
>  	zapowner = newowner;
> -- 
> 2.43.0
> 

Br, Jarkko
