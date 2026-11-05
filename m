Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898731;
	b=jPln7FSKGi8CTjaJCfABuOxeAIfQMapGvn3QnWIXbNSsfU8Kk4Q8ao2sXEIyvcnvskUm
	 V+sGtAkqXBZmM1tW0fO+smubqEQO3KqcGP9bj8W7jUZvjhbDxM96PIlqte78BJoYcKRd+
	 wBcHhtzYkL0nOF11iYxdzuUcTBsE5bvM9EMYBlYipQJIYpDwouuoYkrynSUccDSCmZeoM
	 1JXtaaK2V1Tn2w5YD3iZ/Z+1BtRBfPEN1uya8Yey6teADbm4lh+Dqx13Z/dNUgSR+NEKL
	 0fBTM2BwUFmDL3BWnR27s+oh9akzrvdncidM7C8OM8iroH+J416zEzI6uEHmMPBi0vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898731;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZqAa1Oh2nxpnn+KjGTMbK5AgLwQRuXTCVB+NqwSKOY4=;
	b=2p6GZrWJWxEDkzO6JhqfgrcubsH9XjzK7aYkGmQ2Pfn4yBvggEhDjAab7ZBQdAmX3Ucm
	 EWwz6RVsEXu0CPgVWOZENR95BS1zUaiLq0G6/UqFn2jvOQM32MBXQQcc7ryIlGYGxWCMy
	 HEU/j7fqJ8jzlgnfP32KFwKJD15aD7Txhtxyt3MF6sUEAmPQzLfkM+E996mKeMOF1vP8n
	 7UXkjCHDC+73jxC1ywR1583d8vWVv8HebyvVOJcTSxRUKgKkOlSuKpbseQPr99JK90KJd
	 Ivb8B5NwtT5u1pIzE95pWGt9u4yQ1fgE4QFsa+ccG/YC3pCfYD7XYkihFrfNlUYco4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WylgLfYX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 41D71606A329;
	Thu,  5 Nov 2026 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WylgLfYX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5C57B1F000C1;
	Thu,  5 Nov 2026 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898730;
	bh=ZqAa1Oh2nxpnn+KjGTMbK5AgLwQRuXTCVB+NqwSKOY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WylgLfYXMNgfJaoCNMKKBhh9tTUVD1IuXWiKkv50IDBAEvwtmZEzuuQh2CDX4Xe//
	 LapefWfcpr2gbP7YNzvTHHQijR1O959ivXYAgVFQ8y0dtQyZ3t9XvQU/PH3O37OAXR
	 qUddCpszSLEM5xvz9I96H45q4rl0OS95mslp5AY+qONaG95d/lB27I+aQRBTZzlZXf
	 jff7iOblQq38qXSIYUxfnv6ydArA8rODzGVlq9cBX0kyidlqgYrYRejThj2iDRCd+e
	 n5R+8GRpmODQjcZNv9Drmz/snqG4rcDXH2iMTs08mzTzgdOtBxMclWCNsFi6UkcC2h
	 8/gAshC4d0rLg==
Date: Thu, 5 Nov 2026 19:12:07 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/9] keys/trusted_keys: fix PKWM output buffer cleanup
Message-ID: <auy450SsVheY_yCz@kernel.org>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-3-ssrish@linux.ibm.com>
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
In-Reply-To: <20261105144320.357260-3-ssrish@linux.ibm.com>

On Thu, Nov 05, 2026 at 08:13:13PM +0530, Srish Srinivasan wrote:
> The PKWM seal and unseal paths unconditionally free their output buffers,
> but the PLPKS helpers can return without initializing those pointers.
> 
> Initialize the output buffer pointers to NULL to make cleanup safe on early
> failure paths.
> 
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> ---
>  security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index 422f752598e1..97ffec0ce1b7 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -82,7 +82,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>  {
>  	struct trusted_key_options *options = NULL;
>  	struct trusted_pkwm_options *pkwm = NULL;
> -	u8 *input_buf, *output_buf;
> +	u8 *input_buf, *output_buf = NULL;
>  	u32 output_len, input_len;
>  	int rc;
>  
> @@ -129,7 +129,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>  
>  static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
>  {
> -	u8 *input_buf, *output_buf;
> +	u8 *input_buf, *output_buf = NULL;
>  	u32 input_len, output_len;
>  	int rc;
>  
> -- 
> 2.52.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko

