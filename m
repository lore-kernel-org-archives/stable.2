Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897733;
	b=HbYhKMbOAvpOFcHZ+uc8kepK17HBIQxaYy3V5lso1mePYGXZQ+hpg7AQHZWKM9m3cCGH
	 2ivJ4QxZ92U3jHWnJTIc6pBjhlRVJHXlqkvFxm8z0XzBtm6c5qHOIJOhPc9ofPED9wdaK
	 rlFOuUAOqTkxmZIDEJqHmH+prJl8gxYeZcMgoyWRzeY2nzdS7avc3w2HUNheGQCpWH2kY
	 3EovtJ/A+7ogA5JomaBXP380NHTEqMH6pa75N6D6y3yynCIMhYVd97o0UQ1ETUqO0pGPy
	 G/NFBiNdDblHzJEQ1yVyFHlJeKzQXDMvtt1AIEeD6/iZrZMtl+THuQbqAZZUfv7glqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897733;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SUDVvYxorptkD2PveS8qsN2gsLXR/qsNmAPJe5jYSL4=;
	b=HpxhKEoQ9cNHMe21SafNuMBh0rty9ZzTEJBPQmOAnAUwEXdyfWFrZ3sWTGvH3U0qheBc
	 2lM4UvAw/ItQB8aua++b+1r76wmVIUZln3I2zWTACbjJbJO1mUoUbajttFzbZk8MxC0LS
	 fbniLT42f+b/8PpVOhwRDgRMZysAQlEJxbmn2dNIwFFdeeMPvrIdMapXgbP0nnXXIfBC1
	 1d9P5DGWY4ASDbfwcWAEIQ74k8GhoxSSihndq1wgnajrvgUqWihuiDj2fHm8zObe1uX0g
	 dxTE/+KLrKV76T4jsU1Zyc8SxQHlBGizM3wgdZ8YVTf6gKOp/48lla0BwFS/0R/xSfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxV8wp6J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 835A9606A328;
	Thu,  5 Nov 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxV8wp6J
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 424731F0093A;
	Thu,  5 Nov 2026 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793897732;
	bh=SUDVvYxorptkD2PveS8qsN2gsLXR/qsNmAPJe5jYSL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cxV8wp6JmeU3XWHmE5oAaVkY2V4Rqt6nyU8p8GiSo8lpCeBi8wwSW0uN2r/wA2j/3
	 gvdI8B/vCXv+fQdrx5n51lzEHn2dzBiG6yjw4+idd78hzMNPmFOHLaDhU2Vr8/Sgg0
	 DkDg6YjRVhaesDv8tTlSZN9dh1FHnN1i9eI5YOzRuExnynkjJqmOJqLCvK97+0kWTd
	 hFUn26tOrndBfS0BKadmxCgs285JIWHYQSAGyhlV1gOp6qJBxwUJVfnNyKt9M/4Vgk
	 colZctUdJS684O+sad3StKzy/a62KGhcue2R5f1mo73Ryu5tRyyxbwJn9c6bXASmQa
	 oVexu1tWR43Cg==
Date: Thu, 5 Nov 2026 18:55:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: Protect pkey method checks against type removal
Message-ID: <auy1ANMSKTXZb8GE@kernel.org>
References: <auv35Ljgz1OA1zUZ@kernel.org>
 <9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com>
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
In-Reply-To: <9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com>

On Thu, Nov 05, 2026 at 12:38:21PM +0800, Yuansheng Yang wrote:
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

Look at this:

> Hold key->sem for reading around the method check and the matching call,
> so that the type cannot be retired in between.  Each keyctl handler takes
> and releases the lock itself; the semaphore is not passed out through the
> parameter block.  User buffers are copied outside the critical section.
> 
> This is the same type-removal problem recently fixed for the read
> (925c84e3cc21) and update (aef3a8a4f988) methods.

I don't think we should be making up random English words for
well-defined objects.

The first paragraph in this should be replaced with the description how
keyctl_pkey_params_get and other functions gets modified. I.e., how and
why they get modified.

Also "user buffers", "the semaphore" etc. are hallucinated words with no
actual meaning. Maybe it is just me but I do personally think that
key->sem is a better description of key->sem than "the semaphore".

In the second paragraph I would instead:

	This problem was recently fixed for 925c84e3cc21 ("keys: Protect the
	read method check against type removal") and ...

The commit message should be useful after the patch has been applied. I.e.
when a bug is bisected it is useful to check from the commit message what was
done.

The commit message is as import as the code change itself. With a random code
change you are 50% done.

> 
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
> ---
> Changes in v3:
> - Keep the switch, allocations and existing error handling in place.
> - Use one unlock point per method check/call pair.
> - Set -EOPNOTSUPP inside the failed checks; add blank lines before labels.
> - Use my real name in the author and sign-off fields.
> 
> v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/

This makes much more sense than the previous version.

> 
>  security/keys/keyctl_pkey.c | 47 ++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 15b6bf6399..40475817dd 100644
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
> @@ -129,7 +126,16 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  	if (ret < 0)
>  		return ret;
>  
> +	down_read(&params->key->sem);
> +	if (!params->key->type->asym_query) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
>  	ret = params->key->type->asym_query(params, &info);
> +
> +out_unlock:

out_up_key_sem:

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
> +		goto out_unlock;
> +	}
> +
>  	ret = params.key->type->asym_query(&params, &res);
> +
> +out_unlock:

out_up_key_sem:

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
> +		goto out_unlock;
> +	}
> +
>  	ret = params.key->type->asym_eds_op(&params, in, out);
> +
> +out_unlock:

out_up_key_sem:

> +	up_read(&params.key->sem);
>  	if (ret < 0)
>  		goto error_out;
>  
> @@ -307,10 +327,6 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
>  	if (ret < 0)
>  		goto error_params;
>  
> -	ret = -EOPNOTSUPP;
> -	if (!params.key->type->asym_verify_signature)
> -		goto error_params;
> -
>  	in = memdup_user(_in, params.in_len);
>  	if (IS_ERR(in)) {
>  		ret = PTR_ERR(in);
> @@ -324,8 +340,17 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
>  	}
>  
>  	params.op = kernel_pkey_verify;
> +	down_read(&params.key->sem);
> +	if (!params.key->type->asym_verify_signature) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
>  	ret = params.key->type->asym_verify_signature(&params, in, in2);
>  
> +out_unlock:

out_up_key_sem:

> +	up_read(&params.key->sem);
> +
>  	kfree(in2);
>  error_in:
>  	kfree(in);

Exactly at this site I would do just little bit more hygiene work:

	out_up_key_sem
		/* ... */

	out_free_in:
		/* ... */

	out_free_params:
		/* ... */

	/* ... */

This adheres with the  https://docs.kernel.org/process/coding-style.html
section conventions.

At sites having already out_-labels I would not do extra renaming.

> -- 
> 2.43.0
> 

Br, Jarkko
