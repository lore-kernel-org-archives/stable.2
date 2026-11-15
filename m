Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794745823;
	b=0y5sjbwh3XGtE05AbFIOUri9LtS14ZYfp16lLss3YCrSCIL8Fc1lp9sRypIqyNWiHOC6
	 vjn1pClQaxjbhq/TzeipTla5F0sD6KaKs776bhAn8LHE9ttj3VynsXgU6D01dC09K5VRL
	 DMaCF5mBUT3kvGyoWRrmk7jxbd1DelUNSEBV3MRzOuDt8anDX+iqUE55nVuRZRkXI8pMy
	 4ZvD5m9Yfac1tmjw1UNLwDO0yorOrtZbmItZhE6zy//obukW+fIhE7oLRxn/kUmi8sjPA
	 oRcs78aW53bW+SifOSI+qlznuq7kILJHTYRHOJK64Gk/JLDSCrB/aqlucEe6K9cRqIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794745823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WZzFMt6N0oscpoj+ztiBIum+kpkhuZGDDxLOdqW23yg=;
	b=gdww3uOC+ket7XbcKaziv7pJNwrZMriGZEcfHkw659Nx35MeCOCB5Efn8XftZcYWAokQ
	 AsxEBOikvMfOGZ4tzYK132lYw+esMKwLaoBXogOZlMM0yvKHSzIpMGowip0wWNCzRNNr6
	 DELKQCBYbjwOPPn6oYGGBEoFYZcOLsWDjDOoT4GnmdT0slsAW+AeLR2+SdebzekL2DMl/
	 W8+TbLbC2I1sR/IqZs+Hj7I+wQQpXGSobSS8oWlUbM3aeXDjwfKeEVvf3T/prxBEj5tUO
	 Rx1Vs4CSCDg9BQIqfwlI0v9nxVGQnbAp/2SWeRcGY6m7d3thtStT+/0PEf10exd4KMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dS+jd/jP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 67454606A31F;
	Sun, 15 Nov 2026 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dS+jd/jP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7F08F1F000C4;
	Sun, 15 Nov 2026 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794745823;
	bh=WZzFMt6N0oscpoj+ztiBIum+kpkhuZGDDxLOdqW23yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dS+jd/jPYFvvjFIYV1vY92nmcfy4SWqh6EwhxguzUFdXqBRYEbQZMjtUhR6aXIHLy
	 p5FBwvEs8yxUSGeKfnio1PnHsFIvZZQKyBwx3aosQnuwSTg+jkSyc5UrgGqU/51RXP
	 BUMqVCFKF+WlIL3/oDyFh4F2DnnRATiQiDrnpEfBhz9BJ7cMgSSb6UjGM7hMvcfLKM
	 264nyox1JOjUTw7pji/E9iHdv4oxRW05p8AqPWf0AZh5KlefYzVl1oVMnxQdc4XKlr
	 7oC2Cv8gD/PTUI98jetFO4SQ059HkptFZ5aqxF/r3aN5HCVXBAvthDQUqW2PZE8Wsx
	 1jzm5AV72hsmA==
Date: Sun, 15 Nov 2026 14:30:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] keys: serialise instantiation against keyctl_chown_key
Message-ID: <avml2-lpRCJYlHOp@kernel.org>
References: <20261115121722.206-1-enscrpt@pm.me>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115121722.206-1-enscrpt@pm.me>

On Sun, Nov 15, 2026 at 12:17:40PM +0000, Sinan Turunc wrote:
> keyctl_chown_key() replaces key->user under key->sem, but the
> instantiation path reads key->user without it: __key_instantiate_and_link()
> and key_reject_and_link() bump key->user->nikeys under
> key_construction_mutex only, and key_payload_reserve(), called from the
> type's instantiate op, reads key->user once for spin_lock_irqsave() and
> again for spin_unlock_irqrestore().
> 
> A chown of an under-construction key that lands between those two reads
> locks the old owner's quota spinlock and unlocks the new owner's.  The
> paravirt unlock slow path reports the unheld unlock and the old lock is
> never released, so the next quota operation on that uid spins with
> interrupts disabled:
> 
>   pvqspinlock: lock 0xffff88800f94dc38 has corrupted value 0x0!
>   WARNING: CPU: 2 PID: 215 at kernel/locking/qspinlock_paravirt.h:504 __pv_queued_spin_unlock_slowpath+0x1dc/0x2e0
>   Call Trace:
>    _raw_spin_unlock_irqrestore+0xe/0x30
>    key_payload_reserve+0x230/0x300
>    generic_key_instantiate+0x47/0x230
>    __key_instantiate_and_link+0xbd/0x310
>    key_instantiate_and_link+0x3f0/0x490
>    keyctl_instantiate_key_common+0x246/0x410
> 
> The same unsynchronised read lets the instantiator touch the old
> key_user after the chown has dropped the last reference to it.
> 
> Hold key->sem for write across the instantiate op and the owner-record
> updates so that instantiation and chown serialise on the lock that
> already protects key->user.  key->sem nests inside key_construction_mutex
> and the destination keyring's semaphore here; nothing takes the
> construction mutex under a key's semaphore.  The acquisition is
> annotated as nested because a keyring instantiated into a keyring shares
> the destination's lock class; the key under construction cannot be a
> destination itself, so no cycle exists.
> 
> Reproducer: a request_key() helper that chowns the target key between
> two uids from one thread while instantiating it from another, as root.
> Triggers within tens of milliseconds on 6.12.104 and on mainline.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>
> ---
> An AI tool helped with the analysis and the patch. I reviewed and
> tested it myself: the unpatched kernel hangs within 40 ms, the patched
> one ran the same workload for 60 s with lockdep on and no report.
> 
>  security/keys/key.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -439,7 +439,13 @@
>  
>  	mutex_lock(&key_construction_mutex);
>  
> -	/* can't instantiate twice */
> +	/* can't instantiate twice; key->sem keeps key->user stable against
> +	 * keyctl_chown_key() for the instantiate op and the quota update.
> +	 * Nested: the caller may hold the destination keyring's sem and the
> +	 * key under construction may be a keyring too, but it cannot be
> +	 * anyone's destination yet, so there is no cycle.
> +	 */

:-(

> +	down_write_nested(&key->sem, 1);
>  	if (key->state == KEY_IS_UNINSTANTIATED) {
>  		/* instantiate the key */
>  		ret = key->type->instantiate(key, prep);
> @@ -469,6 +475,7 @@
>  				key_set_expiry(key, prep->expiry);
>  		}
>  	}
> +	up_write(&key->sem);
>  
>  	mutex_unlock(&key_construction_mutex);
>  
> @@ -600,7 +607,8 @@
>  
>  	mutex_lock(&key_construction_mutex);
>  
> -	/* can't instantiate twice */
> +	/* can't instantiate twice; see __key_instantiate_and_link() */
> +	down_write_nested(&key->sem, 1);
>  	if (key->state == KEY_IS_UNINSTANTIATED) {
>  		/* mark the key as being negatively instantiated */
>  		atomic_inc(&key->user->nikeys);
> @@ -621,6 +629,7 @@
>  		if (authkey)
>  			key_invalidate(authkey);
>  	}
> +	up_write(&key->sem);
>  
>  	mutex_unlock(&key_construction_mutex);
>  
> -- 
> 2.56.0
> 

Please review the LLM generated patch yourself at first and write
a commit message thta you can understand yourself.

Plus, remove spurious inline comment changes. I'm only then going
to review this.

Br, Jarkko
