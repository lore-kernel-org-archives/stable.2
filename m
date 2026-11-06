Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974099;
	b=VD6vCHuuZMDtj7jZTbaVIACg4qsCUQAFHyEDbyV26FjEeRNaTOum8CK4JiMoYULz6Kvj
	 tp/5YujdgfqRygXsE41T09vOdFz4bO61HD/65ezDPLhBCzoysJHSYJfkR7UC4xYGMqAjh
	 kmGxaadC5Mp4cbduyxu4ULJw9qq118saHqhsCq/vojIql9yw/Vj4zQKe9YmkesO0PxNMw
	 RIfOw2Vtz5JH/8z9hxT2eFDzg0OKWekStp1m2d9eYzPeNmogJkrUAyZz7bzicGLlXZUZg
	 lyd1Ko0KJD5zWfQXKUL9d/EpoxmMS9MphWLt9Upn+I7hVzNBkdV6wQhiSEMmuUbFYKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974099;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hrYX149OSdk3k+YOin/rIkohEIQs6jD419zibT9vgxU=;
	b=pKoPfBzQbcFXPRzioFIQRcrPDHiaSxxRMlVoGvKNgn4SrjGuw2r3ASvhPcxmv0TP/oY6
	 NCZ9uBTQvaZlRF5hqJ96MxhJD6Ud50rs7lfp8Ipw2YEkZTIwlZQDCpK2AxrAUTlbdMbqY
	 gkKtxbxGy+BamlF1OtritTmKeAX+OR1auxAWqyoGarsMZY+giEP4N4TGJY9DVVuKrcOLt
	 7K7Xqbt4dLpTvw4UMBSOx4UF7ecEo6AFlXWh56Ef6d9uBVRG33iRXCBoVLPIHP/EY/IzW
	 Mzl+QUDwZcH+3pprTD6q6Mfnk4fpqFZ404UE6RJ3xf7jgQfssUNU6WUTtAxnShOvFqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fh6r6JqT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4B2A3606A326;
	Fri,  6 Nov 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fh6r6JqT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6D1331F008A4;
	Fri,  6 Nov 2026 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974099;
	bh=hrYX149OSdk3k+YOin/rIkohEIQs6jD419zibT9vgxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fh6r6JqT9W8Hnz3tANti0KLpqS7sv0c9iueIpUquCp04Dn+y2973apbGc9JzFrcGD
	 w+35nlorw7FqrNrGtSpEuPFV6uzE2NXLVthgnSwTqVW4uFpAk7Ng+5J6g5PYwUG6+a
	 p/dKC3Rt9SGcj+/0SF7tnZj9WSWRN5Rp4h1xbWb47Z2O8kw3khIQnY3969bABkQLpN
	 sp59C0skZ56wF2+7VfZcZQv4Vb3USBtN6YJa01erKVQlZP8VF1LBcKND7C2AaVgFHz
	 PSQrFrUsWH5nNy02ZJPn0LlSgVQWBTXEEUReSTgvuQz22kf8T0dXAW6PpuRgJEWvwd
	 n90pRF9foNiNg==
Date: Fri, 6 Nov 2026 16:08:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: Protect pkey method checks against type removal
Message-ID: <au3fT5HMq7IF-M3e@kernel.org>
References: <auy1ANMSKTXZb8GE@kernel.org>
 <20261105193632.34363-1-0xbeac@gmail.com>
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
In-Reply-To: <20261105193632.34363-1-0xbeac@gmail.com>

On Fri, Nov 06, 2026 at 03:36:31AM +0800, Yuansheng Yang wrote:
> keyctl_pkey_params_get() looks up the key, and keyctl_pkey_query(),
> keyctl_pkey_e_d_s() and keyctl_pkey_verify() then dereference
> key->type->asym_* outside key->sem.  A reference keeps the key alive, but
> does not pin the module providing its type.
> 
> unregister_key_type() calls key_gc_keytype(), which retypes every
> remaining key of the type to key_type_dead under key->sem for writing.
> The pkey paths read key->type again after their checks, so a concurrent
> module unload can turn the checked callback into the NULL key_type_dead
> member and call through a NULL function pointer, e.g.:
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
> In-tree, turris-signing-key provides such methods.
> 
> Remove the key->type->asym_query check from keyctl_pkey_params_get(): it
> runs without key->sem, so key_gc_keytype() can retype the key right after
> it.  Instead, make keyctl_pkey_params_get_2(), keyctl_pkey_query(),
> keyctl_pkey_e_d_s() and keyctl_pkey_verify() each take key->sem for
> reading, check the key->type->asym_* method they are about to call, call
> it and release key->sem.  As key_gc_keytype() takes key->sem for writing
> before it retypes the key, key->type cannot change between the check and
> the call.  Drop the asym_eds_op and asym_verify_signature checks that
> keyctl_pkey_e_d_s() and keyctl_pkey_verify() did before memdup_user() for
> the same reason; -EOPNOTSUPP is now returned from under key->sem.
> memdup_user(), kmalloc() and copy_to_user() stay outside key->sem, as in
> __keyctl_read_key().

This is a transliteration of the source code changes. How this helps me
to quickly understand them vs reading the source code changes and 
skipping this?

I'd like to know what is that you are trying to do by doing those
changes, which is the higher leve question. You should know this
already. I see pretty much the same thing done for those sites so maybe
that action is what you want to describe. Action taken, why that action
won't cause any harm,  enumerate the coverage and address that it is the
full coverage.

The above looks to me as if someone had literally prompted "translate
this source code change to English". Neither much effort thinking  done.

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
> Changes in v4:
> - Rewrite the commit message: describe what changes in
>   keyctl_pkey_params_get(), keyctl_pkey_params_get_2() and the three
>   keyctl handlers and why, and cite the read/update fixes by subject.
> - Rename the out_unlock labels to out_up_key_sem.
> - Use out_up_key_sem / out_free_in / out_free_params in
>   keyctl_pkey_verify(); leave the other functions' existing labels alone.
> - No functional change relative to v3.
> 
> v3: https://lore.kernel.org/all/9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com/
> v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/
> 
>  security/keys/keyctl_pkey.c | 58 +++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 15b6bf6399..3e3253330c 100644
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

I'd drop this as technically it is not part of the bug fix and then you
have pretty much symmetric action. Helps at least with the description.

>  
> @@ -129,7 +126,16 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  	if (ret < 0)
>  		return ret;
>  
> +	down_read(&params->key->sem);
> +	if (!params->key->type->asym_query) {
> +		ret = -EOPNOTSUPP;
> +		goto out_up_key_sem;
> +	}
> +
>  	ret = params->key->type->asym_query(params, &info);
> +
> +out_up_key_sem:
> +	up_read(&params->key->sem);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -185,7 +191,16 @@ long keyctl_pkey_query(key_serial_t id,
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
> @@ -230,10 +245,6 @@ long keyctl_pkey_e_d_s(int op,
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
> @@ -260,7 +271,16 @@ long keyctl_pkey_e_d_s(int op,
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
> @@ -305,31 +325,37 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
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

Br, Jarkko
