Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793434844;
	b=05Vkut1eaijooc55kEi26h7mephIFIwEoWs7f02VbeGBidkbQoMwAjzvuCDFOEfGfUH4
	 KAhdYHANrWE9CZ1ems7cRG9XbP2O+vF8x2RkxOBPuGiJ86M753AaODnZXSu/S9anXg8nj
	 Qx+mEbb4AwaA+BSeSrRrVqj511i17wnttlROW+D3xLc2U/ymY6Gag3120sphH74SuoFO2
	 stH/81VKYkP+ujX9IiCJ0J0mNBnUF4pZUDWDIk6Jj2Dz/OtSqw3U8qUtIEbqoT780+g4x
	 PMrs9aa46nm64ktSq+e8tkHtdAL2qQnj2EkiktfJxqlyvvRO8rH+4QyCDB9RB4BD9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434844;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QR9ZUM3+BAi7COqEi8WRxHv0xaeR1LV8PUZl/W0E5QA=;
	b=M5RYJGKkCET7155NN1LwM0OZ/7BZa4EE50tSyhbZ1NHJg783bM9LdlyWsxhP61PoE9wt
	 y54dj3ujtusJvvEVhKpcg2mHElzWjKr078ob9rc5AJ90H7Gz9BVuMrgMb/VSgjQBdRQ/g
	 uaEGfiaPmAjpEX+moYot6pkvEys2F4wTgndVbl/zLb0kY+h4hYO99ms4YJB72oe/+0n7M
	 Bl8Pq1F5ueU1FxI9Tn56dcKy9ZHTW4ng9JUOQHVlFeTSVz3i0mTCX8bE4K6fVEOtdcTqq
	 wmziE95KChbtsd+WsCT9Zt8SYzxasrmjdYd4z/VhGfit6ONI9ucr5a8+cCb0mAJjznQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfuOQ2Lg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4F73E606A31A;
	Sat, 31 Oct 2026 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfuOQ2Lg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 479AF1F000C1;
	Sat, 31 Oct 2026 08:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793434843;
	bh=QR9ZUM3+BAi7COqEi8WRxHv0xaeR1LV8PUZl/W0E5QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kfuOQ2LgNAmEchsDESHzYlxeovd2BxBGsYXDJoxQLW8WU7XY8zfHj+jQ9w6FFKyUN
	 gV1/imK8pMkuziUxMwhkffGOW5MRbABX11XgEhUeW5ImpYDJxyr3GkUVOsRzIw4+cg
	 7z2Y/RQFWpHXvLY1moCDbPUaHdObrAwfjkTLdajOQFRPpOIfGkFTKJ9I2riq3PFToK
	 HmywflqYh9SfsubCykmGoaRliWA+8OsE6T/Ei/LUX+TqcEkcQHg5Qv3NYPg4GCt3aT
	 XLzJC7Hmb/vtqGw5t0IoZs3j3HVX2vyzHVC8fxmX71adale8uXXG9R5EoRDtC7yfx0
	 OmGXi+LBQUsLw==
Date: Sat, 31 Oct 2026 10:20:40 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Anvik Loitongbam <permissiontogallop@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
Message-ID: <auWk2PAYDgQGXLqr@kernel.org>
References: <20261030173930.40948-1-permissiontogallop@gmail.com>
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
In-Reply-To: <20261030173930.40948-1-permissiontogallop@gmail.com>

On Fri, Oct 30, 2026 at 11:09:30PM +0530, Anvik Loitongbam wrote:
> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index e6ba2d054399..3de6c9160651 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -370,18 +370,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  			       struct key *dest_keyring,
>  			       unsigned long flags,
>  			       struct key_user *user,
> -			       struct key **_key)
> +			       struct key **_key,
> +			       bool *defer_link)
>  {
>  	struct assoc_array_edit *edit = NULL;
>  	struct key *key;
>  	key_perm_t perm;
>  	key_ref_t key_ref;
> +	bool link_locked = false;
>  	int ret;
>  
>  	kenter("%s,%s,,,",
>  	       ctx->index_key.type->name, ctx->index_key.description);
>  
>  	*_key = NULL;
> +	*defer_link = false;
>  	mutex_lock(&user->cons_lock);
>  
>  	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
> @@ -404,6 +407,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  		ret = __key_link_lock(dest_keyring, &key->index_key);
>  		if (ret < 0)
>  			goto link_lock_failed;
> +
> +		/*
> +		 * A restricted keyring should not take an uninstantiated key,
> +		 * the restriction has to be evaluated with the payload,
> +		 * which is only available after construction. Skip the
> +		 * provisional link and add the key with key_link() later,
> +		 * unless the caller explicitly asked to bypass restrictions.
> +		 */
> +		if (dest_keyring->restrict_link &&
> +		    !(flags & KEY_ALLOC_BYPASS_RESTRICTION)) {
> +			__key_link_end(dest_keyring, &key->index_key, NULL);
> +			*defer_link = true;
> +		} else {
> +			link_locked = true;
> +		}
>  	}
>  
>  	/*
> @@ -424,7 +442,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  	if (!IS_ERR(key_ref))
>  		goto key_already_present;
>  
> -	if (dest_keyring) {
> +	if (dest_keyring && link_locked) {
>  		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
>  		if (ret < 0)
>  			goto link_alloc_failed;
> @@ -432,7 +450,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  	}
>  
>  	mutex_unlock(&key_construction_mutex);
> -	if (dest_keyring)
> +	if (link_locked)
>  		__key_link_end(dest_keyring, &key->index_key, edit);
>  	mutex_unlock(&user->cons_lock);
>  	*_key = key;
> @@ -446,15 +464,44 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  	mutex_unlock(&key_construction_mutex);
>  	key = key_ref_to_ptr(key_ref);
>  	if (dest_keyring) {
> -		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
> -		if (ret < 0)
> -			goto link_alloc_failed_unlocked;
> -		ret = __key_link_check_live_key(dest_keyring, key);
> -		if (ret == 0)
> -			__key_link(dest_keyring, key, &edit);
> -		__key_link_end(dest_keyring, &key->index_key, edit);
> -		if (ret < 0)
> +		/*
> +		 * The outer search checks Link permission on a key it finds.
> +		 * The second search must do the same; otherwise a key that
> +		 * appeared in the race window could be linked without the
> +		 * caller holding Link permission on it.
> +		 */
> +		ret = key_task_permission(key_ref, ctx->cred, KEY_NEED_LINK);
> +		if (ret < 0) {
> +			if (link_locked)
> +				__key_link_end(dest_keyring, &key->index_key,
> +					       NULL);
>  			goto link_check_failed;
> +		}
> +		if (*defer_link) {
> +			/*
> +			 * The key may still be under construction, in which
> +			 * case its payload cannot be checked yet.  Do not add
> +			 * a provisional link to a restricted keyring; only an
> +			 * already instantiated key can be checked here.
> +			 */
> +			if (!key_is_positive(key)) {
> +				ret = -EPERM;
> +				goto link_check_failed;
> +			}
> +			ret = key_link(dest_keyring, key);
> +			if (ret < 0)
> +				goto link_check_failed;
> +		} else {
> +			ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
> +			if (ret < 0)
> +				goto link_alloc_failed_unlocked;
> +			ret = __key_link_check_live_key(dest_keyring, key);
> +			if (ret == 0)
> +				__key_link(dest_keyring, key, &edit);
> +			__key_link_end(dest_keyring, &key->index_key, edit);
> +			if (ret < 0)
> +				goto link_check_failed;
> +		}
>  	}
>  	mutex_unlock(&user->cons_lock);
>  	*_key = key;
> @@ -495,6 +542,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
>  {
>  	struct key_user *user;
>  	struct key *key;
> +	bool defer_link;
>  	int ret;
>  
>  	kenter("");
> @@ -512,7 +560,8 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
>  		goto error_put_dest_keyring;
>  	}
>  
> -	ret = construct_alloc_key(ctx, dest_keyring, flags, user, &key);
> +	ret = construct_alloc_key(ctx, dest_keyring, flags, user, &key,
> +				  &defer_link);
>  	key_user_put(user);
>  
>  	if (ret == 0) {
> @@ -522,6 +571,30 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
>  			kdebug("cons failed");
>  			goto construction_failed;
>  		}
> +
> +		/*
> +		 * The key was not provisionally linked because the
> +		 * destination keyring is restricted. Link it now that the
> +		 * payload is available so the restriction can be checked.
> +		 */
> +		if (defer_link) {
> +			/*
> +			 * A helper may have negatively instantiated the key
> +			 * (e.g. KEYCTL_REJECT) and returned success.  A
> +			 * restricted keyring must not cache a negative key;
> +			 * key_reject_and_link() rejects those too.
> +			 */
> +			if (!key_is_positive(key)) {
> +				ret = -EPERM;
> +				key_put(key);
> +				goto error_put_dest_keyring;
> +			}
> +			ret = key_link(dest_keyring, key);
> +			if (ret < 0) {
> +				key_put(key);
> +				goto error_put_dest_keyring;
> +			}
> +		}
>  	} else if (ret == -EINPROGRESS) {
>  		ret = 0;
>  	} else {
> -- 
> 2.56.0
> 
> 

I tried to go through the code change now as it is huge and there was no
explanation why you need to do all of this.

It is full out-of-scope changes. Please redo this just as a scoped bug
fix, and don't add any new flags.

Br, Jarkk
