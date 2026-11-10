Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280014;
	b=3x9GFZ+IOwJhp4ixk/7oLwPBFd190KdiSrxdR7wxVjyly1Bi/7aX9VdrvoMJfUFAEzBE
	 Bot5uEXyeKq0/yQj0sEEaOZ6HXdqTAfc/vGhKPAJCbHvgYY83G/d6g+uoy+rJo3NmTEN+
	 Ctg4ZGMNIBb+kdZnvjDgrntJmPbIDCtVCnURL9oqFFDK1E9bHtYHnzNv9/7E1m/v1l1Ny
	 NyStiJ+g2rgtyBsxuopbyeZ+XQ6L/csMpRqUReCyQ2Cc/wzcddQO+Sr1+Ps0jAwiOUgIB
	 IIL3wPFd5pqdXKUzHARf+xOTueXnd2grZWcZzZYCR1F+6/yty4fAeqqNQR+7O2/lQyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280014;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VpHh1kd277yKFf5MC/BkwYGydR5nOY8UTwF98UtBjBw=;
	b=AK/rtjEuCI+1rGnDu9vgSjjraE3NvmZLypPW4PakF+eN7AxeyZnjLdRLobr+hmbz7fUZ
	 MIEsM7M7pIHx7ZZXq99ms8x2BOtvfcnZtnjrLuZo6r3ulGUQyVNGIi6unPg/VtkgLWM2+
	 0EZWq0VwJjUgPTMzAjHnE4lWDxV5PKVOz+LfCrgUES/uPG2elZ2skG4TbMIstVSEz7K6W
	 gvEAJ0CggXaRSUqJgybUSQ0hZkJ4y/JYMVuAp+cV5azFFi/CYx4p2XSsYDYmZ+mHLBAQc
	 MdsbrUL6SOb9ReNisZLQwqeBsQuC8xQkKnJ8HRTi5AR7KQZfRTVSlhLXi94b3y7z1Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcH9hZDG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 28456606A31C;
	Tue, 10 Nov 2026 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcH9hZDG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6FED41F0089F;
	Tue, 10 Nov 2026 03:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280014;
	bh=VpHh1kd277yKFf5MC/BkwYGydR5nOY8UTwF98UtBjBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CcH9hZDGXg+xllmvR+wFdPTOdRsoO5R8qMO4ZSwLdgGB25PqgmO3lwWAenITs9Omf
	 EQBtDG1HblKbkyIOAVIJpSie8pmt5ILFWcJGBOymH7MIt9iyIs54j1AfGoVZB2/A9o
	 QOhZxt1OPizuTrw637T3AgLQAFEYyBHq3UA4F39/XzMNF/qcOgX4qnXOG5iSbaU/ld
	 f/LQpb5ah8MSS4YVfqTAwbwJitPF5Q3aqyZGvg1KqpwLl3yOM3ED1z0IovaUUKV77v
	 XdDzvFKcRmr00CP8Uu9s1aSBHeiLbRqdbE+Hvr1aveAfYjoIcf3Ltz984KYCK+70yc
	 vrFCwME6tWI6Q==
Date: Tue, 10 Nov 2026 05:06:50 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7] KEYS: Protect pkey method checks against type removal
Message-ID: <avKKSj0TeITLlZhp@kernel.org>
References: <avJ4KM-Erci0FkgZ@kernel.org>
 <20261110030252.9979-1-0xbeac@gmail.com>
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
In-Reply-To: <20261110030252.9979-1-0xbeac@gmail.com>

On Tue, Nov 10, 2026 at 11:02:52AM +0800, Yuansheng Yang wrote:
> keyctl_pkey_query(), keyctl_pkey_e_d_s() and keyctl_pkey_verify() check
> that key->type has the ->asym_*() method they need and call it later,
> without holding key->sem.  A reference keeps the key alive, but does not
> pin the module that provides its type.
> 
> When that module is unloaded, unregister_key_type() waits for the key GC
> to process every remaining key of the type.  For each such key, the GC
> takes key->sem for writing, switches key->type to key_type_dead, whose
> ->asym_*() methods are NULL, and destroys the payload.  If that happens
> between the check and the call, the keyctl calls a NULL method; if it
> happens while the method runs, the method returns into freed module text.
> In-tree, turris-signing-key provides ->asym_query() and ->asym_eds_op()
> and can be built as a module.
> 
> Take key->sem for reading around each method call, and check the method
> again under it, right before the call.  While the lock is held the GC
> cannot switch the key to key_type_dead, so unregister_key_type() and the
> module unload cannot complete until the method returns.  If the type is
> already gone, the check finds key_type_dead and the keyctl fails with
> -EOPNOTSUPP, as it does for any key type without the method.
> 
> memdup_user() and copy_to_user() stay outside key->sem, as in
> keyctl_read_key(), so no page fault is taken with key->sem held.  The
> in-tree ->asym_*() methods do not take key->sem themselves.  Nothing else
> in the kernel calls these methods, so these four call sites are the full
> coverage:
> 
>  - keyctl_pkey_query(): ->asym_query() for KEYCTL_PKEY_QUERY
>  - keyctl_pkey_params_get_2(): ->asym_query(), and the op-specific check
>    for KEYCTL_PKEY_ENCRYPT, _DECRYPT, _SIGN and _VERIFY
>  - keyctl_pkey_e_d_s(): ->asym_eds_op() for _ENCRYPT, _DECRYPT and _SIGN
>  - keyctl_pkey_verify(): ->asym_verify_signature() for _VERIFY
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
> Changes in v7:
> - Restore the early ->asym_query() check in keyctl_pkey_params_get().
>   Removing it was not part of the bug fix (Jarkko).  The function is now
>   identical to 7.4-rc1 again, so the diff does not touch it at all.
>   Sashiko flagged that unlocked read on v5; it is pre-existing code and
>   is left alone here, as asked.  The locked rechecks at the call sites
>   are what the fix relies on.
> - Make the commit message more compact (Jarkko).
> 
> Changes in v6:
> - Address the Sashiko review of v5: keyctl_pkey_e_d_s() and
>   keyctl_pkey_verify() still read a ->asym_*() method pointer without
>   key->sem in their early checks.  Move those op-specific checks into
>   keyctl_pkey_params_get_2(), in the same key->sem critical section that
>   calls ->asym_query(), and after the buffer size validation, so a key
>   type without the method still fails with -EOPNOTSUPP before
>   memdup_user() and the error precedence is unchanged.
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
>   returned (about 3.1 s).
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
> v6: https://lore.kernel.org/all/20261109055204.31673-1-0xbeac@gmail.com/
> v5: https://lore.kernel.org/all/20261108131417.77287-1-0xbeac@gmail.com/
> v4: https://lore.kernel.org/all/20261105193632.34363-1-0xbeac@gmail.com/
> v3: https://lore.kernel.org/all/9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com/
> v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/
> v1: https://lore.kernel.org/all/20261103032940.51826-1-0xbeac@gmail.com/
> 
>  security/keys/keyctl_pkey.c | 100 +++++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 24 deletions(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 15b6bf6399..e7121523b9 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -129,45 +129,77 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
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
> @@ -185,7 +217,16 @@ long keyctl_pkey_query(key_serial_t id,
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
> @@ -230,10 +271,6 @@ long keyctl_pkey_e_d_s(int op,
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
> @@ -260,7 +297,16 @@ long keyctl_pkey_e_d_s(int op,
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
> @@ -305,31 +351,37 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
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

Thanks for quick response.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
