Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794152740;
	b=BDXyYmtTwnK+SRGTtXbUw5oqTW9BWGlzf5KcmxcMkiRTHasyGyJ3hiRZfkVfr7hUTlRO
	 ZYeYrJEA1FrlwgVWUz+HlcyVOuULUOHi8cQG0RX3JSJjG8McNQCaaIW4CyU8iinmRcTVX
	 cEPbRsImDtnqxPRYNq3qI6guO8vfumr0jJ6aZlqmXTzKvYMgE/XeQeMell9AHjjI6rfA/
	 RHwjRlgoF4jPdbVv9khPxGuSVQIyVn4YQ/rb5doj/Di0Dd3CyuMQmlkHc1uzhj6Ibhlzy
	 ytLvQfNlSwYfgJLkiPnBLLdi6A7I64fXq7zVOs3IDOtYzDek8ZYPweL1zyFiJicSRIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794152740;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Qv6VqrmKg3FKau8lhcdKdMQGVPG34q5ibWj5i/V4Uxk=;
	b=QF9ZdRKpSMQL1giHRcxMiJh8JR4TyVJyi/rp6Fsgofsu/XGWhP99kYAvYNfkzt4Hc1jn
	 7GhNiYcm0faBFjNjq8JiuUbAwONDuS2+DMZDJ4VW5ukONSJ020eulFXVmNU9s+pCBl2gD
	 Xmz3j+A2CDdVx17kytCss21vh9atZqdcASAPvud4vY70/tGd9tVgATl0dskHFM1r6iXjY
	 z+NfkVNBUlNHBW8XwOZj3xOwZ5eKpOXd4psO2QB96SeBwJdsOUlzVwlFkA7hTu1mtROap
	 edNuHOTa9AL5OCJuAolQTaUmp7TVqCY8utd4s7Cri3lmxkE6oIUeaXgPDRu73jnjxxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4WU4ZOt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4DA0B606A31C;
	Sun,  8 Nov 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4WU4ZOt
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6081A1F0089F;
	Sun,  8 Nov 2026 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794152739;
	bh=Qv6VqrmKg3FKau8lhcdKdMQGVPG34q5ibWj5i/V4Uxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a4WU4ZOtyv8lhVPK2R69tPrAh+NxEEVRu8UMt4SZyMqr38wyOnfJOtIfT5REDEUn+
	 HXMsXb5UV6mK4xkBY8veUl6MU2kI0pFbxqjq20EwXI3h7s698sDZvjYO1d6U6YWQ59
	 t0aQjKxVasSN+PkO4868zqlWPlHrvYyDGyTynHZDPFMYwp7ysu4fvuiMyxcTFPeZyw
	 rkQ1uWKKNVC9yldAslb5wIdmqSWzQTOKoySgY3b7gdqJnc/QkyCS0+Tg/joVvXBsgG
	 NHe8TAKooSalQBBwxMTHu4N4rb9ctbMokq1Wingy44/mDIjKZSu9UN42wTlaXFNBSD
	 Vs66CIyximNIw==
Date: Sun, 8 Nov 2026 17:45:36 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: Protect pkey method checks against type removal
Message-ID: <avCZIMCsZ4um18e-@kernel.org>
References: <au3fT5HMq7IF-M3e@kernel.org>
 <20261108131417.77287-1-0xbeac@gmail.com>
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
In-Reply-To: <20261108131417.77287-1-0xbeac@gmail.com>

On Sun, Nov 08, 2026 at 09:14:17PM +0800, Yuansheng Yang wrote:
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
> Take key->sem for reading around each ->asym_*() call, and check the
> method again under it, right before the call.  While key->sem is held,
> the GC cannot switch the key to key_type_dead, so unregister_key_type(),
> and with it the module unload, cannot complete: the type, its module and
> the payload stay in place until the method returns.  If the type is
> already gone when key->sem is taken, the check finds key_type_dead and
> the keyctl fails with -EOPNOTSUPP, as it does for any key type without
> the method.
> 
> Otherwise, behaviour is unchanged:
> 
>  - The existing checks in keyctl_pkey_params_get(), keyctl_pkey_e_d_s()
>    and keyctl_pkey_verify() are kept, so key types without the method
>    still fail at the same point with the same error.  No call relies on
>    them any more.
> 
>  - memdup_user() and copy_to_user() stay outside key->sem, as in
>    keyctl_read_key(), so no page fault is taken with key->sem held.
> 
>  - key->sem is only taken for reading, so pkey operations and KEYCTL_READ
>    on the same key still run concurrently.  Writers such as KEYCTL_UPDATE,
>    KEYCTL_REVOKE and KEYCTL_SETPERM now wait for a pkey operation in
>    progress, as they already wait for ->read().  The in-tree ->asym_*()
>    methods do not take key->sem themselves.
> 
> Nothing else in the kernel calls these three methods, so the four call
> sites below are the full coverage:
> 
>  - keyctl_pkey_query(): ->asym_query() for KEYCTL_PKEY_QUERY
>  - keyctl_pkey_params_get_2(): ->asym_query() to check the buffer sizes
>    for KEYCTL_PKEY_ENCRYPT, _DECRYPT, _SIGN and _VERIFY
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
> LLM assistants, OpenAI Codex (gpt-6.1-sol) and Anthropic Claude
> (claude-opus-5-5), found this while looking for other cases of the
> KEYCTL_READ problem, and drafted this patch and this description.

This paragrah is no longer required and can be removed. I'll make only
sure that you know what you're doing. LLM is equal to a text editor as
far as I'm concerned, which also LLM is neither excuse for anything.

I think this is fine but there was a Sashiko issue left that
still needs to be fixed.


> 
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>


Br, Jarkko
