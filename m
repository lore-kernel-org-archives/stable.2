Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512315;
	b=mHnXsorl6McbNLXy0285yfhomgitrzqThlwwLfnjQ2hkMno5ZafIcUtjtOnbxp9iFGpy
	 yn4uVNySzw+z9AJavTXOziL34rqyxs1cQh7IDFsVQoAbRperGUQrg897tYVq3q1L8fGR4
	 BskJatIrCMOfPs74EFVj46rJzjGk5t+zwSrwsHzLr2OHFPox+Q0oaiDaV7r9arE9hRgbA
	 I4r7o0RVxCdSRhqMgUr6M5OGmNvv17VeJb8t7nAQciBdpfHD1ZI9b86iRUpaxnjuKVzx+
	 hToCJAiTbb65caVNMMClg1zcN9u4LpzUW/lRUvOJAs/xroCv3NnQNbsPcaBo3kodktw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512315;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dLxgkF8kSB2RTpMkpmTwaaceB4lAL0xhonWTFjC6GmE=;
	b=i8fkXXZmVhPXLyFmP2UxE9AjE7EpJBjxYpwvhO3fKIu7x/F0aJq/Eo1neznzgcZC3V55
	 sDSTvSQ8Zo/FIlrtnHN9+EOnnOjsqArBvXbG0h4f73w9WUyFFouECt6TDZaMUu/sxLxNA
	 UpxuBKQlK6vXY5kDyEaSd6IetTjJXwWz+brqBe42QIfMdK3aSiGpetiTYyoHm+Zt2hPp2
	 tWabJaFYxdY5bnQTGf8mfWOPp134ccO8gxDsHx6/yQAnV03At5vH8voXiOgdzOHBPG+nV
	 9I2HmRGfvCtJjAkIsG9NPKz7wg+7iqqb0dgqS+VYAEXUO3kwO+BBZD3ifqbahkOZvVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m901xYFi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CA685606A33B;
	Tue, 24 Nov 2026 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m901xYFi
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 225F91F000C4;
	Tue, 24 Nov 2026 09:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512315;
	bh=dLxgkF8kSB2RTpMkpmTwaaceB4lAL0xhonWTFjC6GmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m901xYFivPLFlqRAoJB1RhhCoEumUaGmujKZ8Gb83Z7PcZtEllTILPK8fD13RO+m0
	 XwaIfddnS62WYaUDS2GjVkOHI4axEKg6Ql9ZJ/dCFepeTXgoGbf9oSZh61LVs6d3R4
	 gjMvwjRjGfCJ3OJivzYSPKdLs9kPsP+1sn0qutRc/qLc/meqQ/cC5AWiBcMGDYSEfH
	 lpfvjnMgqf126W95ENJa4C1wRj0blpg9eUq/3XQtm31kauAGpDTOFvKfRQp3xNNvSA
	 JbwZpxV7sQZWL7ICpfFFIMByds/8nWtuJYx1gtrVeB5Sf/VFZdxKeohnoqdNtOf7pC
	 6stHNF1GegTfQ==
Date: Tue, 24 Nov 2026 11:25:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] keys: fix crash on big_key read or revoke after a
 failed update
Message-ID: <awVX-N25GzGKK_Od@kernel.org>
References: <20261124025759.39344-1-bsdhenrymartin@gmail.com>
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
In-Reply-To: <20261124025759.39344-1-bsdhenrymartin@gmail.com>

On Tue, Nov 24, 2026 at 10:57:59AM +0800, Henry Martin wrote:
> big_key_update() reserves quota with the raw payload length and then
> destroys the old payload before instantiating the new one.  For a payload
> of N < 16 bytes that reserve releases 16-N bytes, so the reserve of 16
> done by generic_key_instantiate() charges them again and can fail with
> -EDQUOT once the payload is already destroyed.  big_key_destroy() keeps
> payload->length but clears path and data, so the key stays positive with
> a stale length that KEYCTL_READ and KEYCTL_REVOKE then follow:
> 
> kernel BUG at fs/open.c:1145!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> RIP: 0010:dentry_open+0x7b/0x90
>  big_key_read+0x141/0x280
> 
> Instantiate the new payload first and destroy the old one only on success;
> a positive key's reservation is already 16 bytes, so it cannot fail.
> 
> This issue was discovered by Tencent CodeBuddy Security.
> Cc: stable@vger.kernel.org
> Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> Changes in v2:
> - Drop the comment in big_key_update(); it belongs in the changelog.
> - Rework the changelog per the review below: the quota is released by the
>   removed key_payload_reserve() call, not by big_key_destroy(), which only
>   drops path and data.
> 
> Link: https://sashiko.dev/#/patchset/20261123165443.4092852-1-bsdhenrymartin@gmail.com?part=1
> 
>  security/keys/big_key.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index 268f702df380e..aa3e82ac93ee2 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -193,16 +193,24 @@ void big_key_destroy(struct key *key)
>   */
>  int big_key_update(struct key *key, struct key_preparsed_payload *prep)
>  {
> +	struct big_key_payload old = { };
> +	bool positive = key_is_positive(key);
>  	int ret;
>  
> -	ret = key_payload_reserve(key, prep->datalen);
> +	if (positive)
> +		old = *to_big_key_payload(key->payload);
> +
> +	ret = generic_key_instantiate(key, prep);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (key_is_positive(key))
> -		big_key_destroy(key);
> +	if (positive) {
> +		if (old.length > BIG_KEY_FILE_THRESHOLD)
> +			path_put(&old.path);
> +		kfree_sensitive(old.data);
> +	}
>  
> -	return generic_key_instantiate(key, prep);
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.53.0
> 

LGTM, thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
