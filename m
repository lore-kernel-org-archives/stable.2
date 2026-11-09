Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236678;
	b=hpQOxCBnYF+1/uOLJD5f2A645W9K7Lm7ITvOmtR8dhFmw4g3WdZkC0eWkkZLCo+/Om9R
	 hAo/9JmHuITNX9yhykRHRt30MiBsBLBwr1xPJAZvN1d5PuKpBfGyl60qcyhBUVyy22my/
	 +IrWYKFJs1/B400fQajm9vbqdFR5GKMj1X/IsvDnnBQ8ZaPlHbdtwbYqm8rHdkiMW0WJV
	 NZTYlCnYeQjD8DIQ5VzYgnaPWadazMAlirFs9ZtYVVD24VwL+iqyHpvhw/BlZ6v/Z6PJ7
	 p7HiSio1I51VjKYWSy1pguIePd0l3FS+y7WD3aPa1tno69PA6J75XCmr3HCpwl1/zWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236678;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AOw3vT/odShBE5ztPjx0Ys+mmdhEKSOKxO5oIAfSNFQ=;
	b=OZuRaSsYc0KM81USbsaXpjoDXfjfXBZR6S0NbUDV8SuXfbfG3RC4eaqudsplimYQ+hiP
	 6pXBOkpfDPSS1ZZkN74gPsBa2U8S+s+k+2VFlBDTPRka7RLTw0F8P1LO82Jw/OxjPp5hB
	 28jB1RDi6N1OYoLS+vI7OAVqIN6qGPmIIGZPhXNcC2ytEtUtTRE2cniVO9v6U4Rpf3NV3
	 WicRQbh7s1EGC60uXs+GZF6tbyv/CVss6vhig5EoRZ1sd3XcSR9D+M8BwL3Hwhf3gWWNF
	 pEFy4IgsZvhd/Uf03uwR73JvwPPrXZqBby2dkgvqvjEO2rvq4kD/x45SrmUODCHGFyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fs7BBvJH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3492A606A321;
	Mon,  9 Nov 2026 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fs7BBvJH
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3FD5F1F0089F;
	Mon,  9 Nov 2026 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236677;
	bh=AOw3vT/odShBE5ztPjx0Ys+mmdhEKSOKxO5oIAfSNFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fs7BBvJHJxXUNi8wd5R78pN80+XswOfSsHH+ZD/S0oAXxxFfFwsxrlMMhVdKD6bux
	 /kwhdbcGfVAyVQXyZPRAnrsn+l9eqBpZ+6PfWG6u1vr15Qk0MLbqRaHQOTcIPGoxMU
	 HUCev9xZardaM41yPdFPQ/vqZmG5fjnp0qZ8MFUTnRrN5T3rza3z92M0pEYj19+yTf
	 +jwyjq/n3NbaT2uR6DNWMgbt2OVVINLz+fiKQUbZ/HU3Wz7YadOINcBfc6jvB8gcG4
	 VVUywzAdhsUESx6nTkd+GJf/OfNapxpZVE719Rk7nXFKRN4ck2blZT6x/Od1wvzZ4A
	 iA+r8F7odq6ew==
Date: Mon, 9 Nov 2026 17:04:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] KEYS: Protect pkey method checks against type removal
Message-ID: <avHhAv13pbc_hfoX@kernel.org>
References: <avCZIMCsZ4um18e-@kernel.org>
 <20261109055204.31673-1-0xbeac@gmail.com>
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
In-Reply-To: <20261109055204.31673-1-0xbeac@gmail.com>

On Mon, Nov 09, 2026 at 01:52:04PM +0800, Yuansheng Yang wrote:
> keyctl_pkey_query(), keyctl_pkey_e_d_s() and keyctl_pkey_verify() check
> that key->type has the ->asym_*() method they need and call it later,
> without holding key->sem.  A reference keeps the key alive, but does not
> pin the module that provides its type.
> 
> When that module is unloaded, unregister_key_type() waits for the key GC
> to process every remaining key of the type.  For each such key, the GC
> takes key->sem for writing, switches key->type to key_type_dead, whose
> ->asym_*() methods are NULL, and destroys the payload.  If this happens
> between the check and the call, the keyctl calls a NULL method:
> 
>   KEYCTL_PKEY_SIGN task              Module unload and key GC
>   ------------------------           ------------------------
>   keyctl_pkey_e_d_s()
>     if (!key->type->asym_eds_op)     unregister_key_type()
>                                        GC: down_write(&key->sem)
>                                        GC: retype to key_type_dead
>                                        GC: up_write(&key->sem)
>                                      free_module()
>     in = memdup_user(...)
>     key->type->asym_eds_op(...)      -> NULL call
> 
> If it happens while the method is running, the method is left running in
> freed module text.  In-tree, turris-signing-key provides ->asym_query()
> and ->asym_eds_op() and can be built as a module.
> 
> Every read of a ->asym_*() method pointer must therefore happen with
> key->sem held for reading.  Take it around each method call and check the
> method again under it, right before the call.  While key->sem is held,
> the GC cannot switch the key to key_type_dead, so unregister_key_type(),
> and with it the module unload, cannot complete: the type, its module and
> the payload stay in place until the method returns.  If the type is
> already gone when key->sem is taken, the check finds key_type_dead and
> the keyctl fails with -EOPNOTSUPP, as it does for any key type without
> the method.
> 
> The checks that keyctl_pkey_params_get(), keyctl_pkey_e_d_s() and
> keyctl_pkey_verify() used to do before copying the input were themselves
> unlocked reads of the method pointer.  Move them into the key->sem
> critical section that keyctl_pkey_params_get_2() takes around
> ->asym_query(), after the buffer size validation, so that a key type
> without the method still fails with -EOPNOTSUPP before memdup_user() and
> with the same error precedence as before.  keyctl_pkey_params_get() no
> longer looks at the type; its callers check ->asym_query() under key->sem
> before they use it.
> 
> memdup_user() and copy_to_user() stay outside key->sem, as in
> keyctl_read_key(), so no page fault is taken with key->sem held.  key->sem
> is only taken for reading, so pkey operations and KEYCTL_READ on the same
> key still run concurrently.  Writers such as KEYCTL_UPDATE,
> KEYCTL_REVOKE and KEYCTL_SETPERM now wait for a pkey operation in
> progress, as they already wait for ->read().  The in-tree ->asym_*()
> methods do not take key->sem themselves.
> 
> Nothing else in the kernel calls these three methods, so the four call
> sites below are the full coverage:
> 
>  - keyctl_pkey_query(): ->asym_query() for KEYCTL_PKEY_QUERY
>  - keyctl_pkey_params_get_2(): ->asym_query() and the op-specific method
>    check for KEYCTL_PKEY_ENCRYPT, _DECRYPT, _SIGN and _VERIFY
>  - keyctl_pkey_e_d_s(): ->asym_eds_op() for KEYCTL_PKEY_ENCRYPT,
>    _DECRYPT and _SIGN
>  - keyctl_pkey_verify(): ->asym_verify_signature() for
>    KEYCTL_PKEY_VERIFY
> 
> This problem was recently fixed for keyctl_read_key() by 925c84e3cc21
> ("keys: Protect the read method check against type removal") and for
> key_update() by aef3a8a4f988 ("KEYS: Protect the update method check
> against type removal").
> 
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
> ---
> Changes in v6:
> - Address the Sashiko review of v5: keyctl_pkey_params_get(),
>   keyctl_pkey_e_d_s() and keyctl_pkey_verify() still read a ->asym_*()
>   method pointer without key->sem in their early checks.  Those checks
>   are gone.  The op-specific check now happens in
>   keyctl_pkey_params_get_2(), in the same key->sem critical section that
>   calls ->asym_query(), and after the buffer size validation, so a key
>   type without the method still fails with -EOPNOTSUPP before
>   memdup_user() and the error precedence is unchanged.
>   keyctl_pkey_params_get() no longer looks at the key type at all; both
>   of its callers check ->asym_query() under key->sem before using it.
> - Drop the LLM paragraph from the commit message (Jarkko).
> 
> Tested on x86_64 under QEMU/KVM, with KASAN, lockdep and
> DEBUG_ATOMIC_SLEEP, on 7.4-rc1 with and without this patch.  The
> test-only key type module is not for merging.
> 
>   race_sign, race_verify: the module is unloaded while the keyctl waits
>   in memdup_user() after the type check.  Without the patch: NULL call
>   from keyctl_pkey_e_d_s() / keyctl_pkey_verify().  With the patch: both
>   return -EOPNOTSUPP and delete_module() has returned first.
> 
>   inop: the module's ->asym_eds_op() sleeps in module text while the
>   module is unloaded.  Without the patch: return into freed module text.
>   With the patch: delete_module() returns only after the method has
>   returned (about 3.0 s vs 3.1 s).
> 
>   func_asym, func_fake: KEYCTL_PKEY_QUERY, _ENCRYPT, _DECRYPT, _SIGN and
>   _VERIFY on a real RSA-2048 asymmetric key and on the test type; the
>   CASE lines are identical with and without the patch.
> 
>   errno: a type with ->asym_query() but no ->asym_verify_signature()
>   returns -EOPNOTSUPP before reading the input; a request with an
>   oversized length still returns -EINVAL first, as before.  The CASE
>   lines are identical with and without the patch.
> 
> In the forced races lockdep can report "bad unlock balance" for
> key->sem.  Its lock class is the type's lock_class, which lockdep drops
> when the module is freed, so any key->sem user on a key whose type was
> unregistered can hit this, e.g. keyctl_read_key().  KASAN reports
> nothing.  Not tested on Turris hardware.
> 
> v5: https://lore.kernel.org/all/20261108131417.77287-1-0xbeac@gmail.com/
> v4: https://lore.kernel.org/all/20261105193632.34363-1-0xbeac@gmail.com/
> v3: https://lore.kernel.org/all/9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com/
> v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/
> v1: https://lore.kernel.org/all/20261103032940.51826-1-0xbeac@gmail.com/
> 
>  security/keys/keyctl_pkey.c | 103 ++++++++++++++++++++++++++----------
>  1 file changed, 76 insertions(+), 27 deletions(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 15b6bf6399..5ac049b71a 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -100,9 +100,6 @@ static int keyctl_pkey_params_get(key_serial_t id,
>  		return PTR_ERR(key_ref);
>  	params->key = key_ref_to_ptr(key_ref);
>  
> -	if (!params->key->type->asym_query)
> -		return -EOPNOTSUPP;
> -
>  	return 0;
>  }
>  
> @@ -129,45 +126,77 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  	if (ret < 0)
>  		return ret;
>  
> +	down_read(&params->key->sem);
> +
> +	if (!params->key->type->asym_query) {
> +		ret = -EOPNOTSUPP;
> +		goto out_up_key_sem;
> +	}
> +
>  	ret = params->key->type->asym_query(params, &info);
>  	if (ret < 0)
> -		return ret;
> +		goto out_up_key_sem;
>  
>  	switch (op) {
>  	case KEYCTL_PKEY_ENCRYPT:
>  		if (uparams.in_len  > info.max_dec_size ||
> -		    uparams.out_len > info.max_enc_size)
> -			return -EINVAL;
> +		    uparams.out_len > info.max_enc_size) {
> +			ret = -EINVAL;
> +			goto out_up_key_sem;
> +		}
>  
>  		params->out_len = info.max_enc_size;
>  		break;
>  	case KEYCTL_PKEY_DECRYPT:
>  		if (uparams.in_len  > info.max_enc_size ||
> -		    uparams.out_len > info.max_dec_size)
> -			return -EINVAL;
> +		    uparams.out_len > info.max_dec_size) {
> +			ret = -EINVAL;
> +			goto out_up_key_sem;
> +		}
>  
>  		params->out_len = info.max_dec_size;
>  		break;
>  	case KEYCTL_PKEY_SIGN:
>  		if (uparams.in_len  > info.max_data_size ||
> -		    uparams.out_len > info.max_sig_size)
> -			return -EINVAL;
> +		    uparams.out_len > info.max_sig_size) {
> +			ret = -EINVAL;
> +			goto out_up_key_sem;
> +		}
>  
>  		params->out_len = info.max_sig_size;
>  		break;
>  	case KEYCTL_PKEY_VERIFY:
>  		if (uparams.in_len  > info.max_data_size ||
> -		    uparams.in2_len > info.max_sig_size)
> -			return -EINVAL;
> +		    uparams.in2_len > info.max_sig_size) {
> +			ret = -EINVAL;
> +			goto out_up_key_sem;
> +		}
>  
>  		params->out_len = info.max_sig_size;
>  		break;
>  	default:
> -		return -EOPNOTSUPP;
> +		ret = -EOPNOTSUPP;
> +		goto out_up_key_sem;
>  	}
>  
>  	params->in_len  = uparams.in_len;
> -	return 0;
> +
> +	switch (op) {
> +	case KEYCTL_PKEY_VERIFY:
> +		if (!params->key->type->asym_verify_signature)
> +			ret = -EOPNOTSUPP;
> +		break;
> +	case KEYCTL_PKEY_ENCRYPT:
> +	case KEYCTL_PKEY_DECRYPT:
> +	case KEYCTL_PKEY_SIGN:
> +		if (!params->key->type->asym_eds_op)
> +			ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +out_up_key_sem:
> +	up_read(&params->key->sem);
> +	return ret;
>  }
>  
>  /*
> @@ -185,7 +214,16 @@ long keyctl_pkey_query(key_serial_t id,
>  	if (ret < 0)
>  		goto error;
>  
> +	down_read(&params.key->sem);
> +	if (!params.key->type->asym_query) {
> +		ret = -EOPNOTSUPP;
> +		goto out_up_key_sem;
> +	}
> +
>  	ret = params.key->type->asym_query(&params, &res);
> +
> +out_up_key_sem:
> +	up_read(&params.key->sem);
>  	if (ret < 0)
>  		goto error;
>  
> @@ -230,10 +268,6 @@ long keyctl_pkey_e_d_s(int op,
>  	if (ret < 0)
>  		goto error_params;
>  
> -	ret = -EOPNOTSUPP;
> -	if (!params.key->type->asym_eds_op)
> -		goto error_params;
> -
>  	switch (op) {
>  	case KEYCTL_PKEY_ENCRYPT:
>  		params.op = kernel_pkey_encrypt;
> @@ -260,7 +294,16 @@ long keyctl_pkey_e_d_s(int op,
>  	if (!out)
>  		goto error_in;
>  
> +	down_read(&params.key->sem);
> +	if (!params.key->type->asym_eds_op) {
> +		ret = -EOPNOTSUPP;
> +		goto out_up_key_sem;
> +	}
> +
>  	ret = params.key->type->asym_eds_op(&params, in, out);
> +
> +out_up_key_sem:
> +	up_read(&params.key->sem);
>  	if (ret < 0)
>  		goto error_out;
>  
> @@ -305,31 +348,37 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
>  	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
>  				       &params);
>  	if (ret < 0)
> -		goto error_params;
> -
> -	ret = -EOPNOTSUPP;
> -	if (!params.key->type->asym_verify_signature)
> -		goto error_params;
> +		goto out_free_params;
>  
>  	in = memdup_user(_in, params.in_len);
>  	if (IS_ERR(in)) {
>  		ret = PTR_ERR(in);
> -		goto error_params;
> +		goto out_free_params;
>  	}
>  
>  	in2 = memdup_user(_in2, params.in2_len);
>  	if (IS_ERR(in2)) {
>  		ret = PTR_ERR(in2);
> -		goto error_in;
> +		goto out_free_in;
>  	}
>  
>  	params.op = kernel_pkey_verify;
> +	down_read(&params.key->sem);
> +	if (!params.key->type->asym_verify_signature) {
> +		ret = -EOPNOTSUPP;
> +		goto out_up_key_sem;
> +	}
> +
>  	ret = params.key->type->asym_verify_signature(&params, in, in2);
>  
> +out_up_key_sem:
> +	up_read(&params.key->sem);
>  	kfree(in2);
> -error_in:
> +
> +out_free_in:
>  	kfree(in);
> -error_params:
> +
> +out_free_params:
>  	keyctl_pkey_params_free(&params);
>  	return ret;
>  }
> -- 
> 2.43.0
> 

Thank you!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
