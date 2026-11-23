Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469201;
	b=23ROtTY5C8y5VjvAdYLcdMRPjonCM2/6J5THSjZkMzjCXRltCdYVlAHLmvPsa/YPrSnk
	 x8rDSl8ZGwBOf2/VEXVxbQrviSVYAJ0v7ywPN5np+lybWLOsE7ENaruKFvsT6usc44K1l
	 NzL8ieCYOxvY7IH5mp+WbJKjUl0Cktcmmxq++VyOGuREjz2ug7ORGvIInzRxbJmC1VnQn
	 Wm/SaOnjQyBA8Pf79Xl7Wmwt2IuPAba1AzmnHG2RYj5FOtQzVHp7Lh1AGg9tMEoThrnXF
	 zUzhF7uiqnnS3VlUARFi8R7nhs0F2v+VXgSjTpUTqPHcT2Q9YQep20mlOtzAjZyqP+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469201;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2f4zLT/mLbzpdxNkBcyOmTZl9xYwYOy/bawS8EITYeo=;
	b=owMrsPZFmfIyMQQaJvQ/Mw21rQfM7ZoxQ55X6BW7AQPR7xffaKvsPq90bg875zF2tURe
	 K05Y8sk6xcwmoyZwkq+a0kLrXk4EZe+eymeSSmE7c0BipCYwoWeFrwGFK1YiwZn9X4ojn
	 Fw1GsSCSAqc/bs0JjCrJ3XHyJWIXDk7zH8zU4rvbtWkbuXDTm4oIcmVR8kuBoD3kUVqU+
	 60ojErUTHav4Z2k7uiaxMEVhs6aRngfry02zMRxsDy6ic5LxRrQpXpxFISRAWioKyVSay
	 FKkK+MspUKSkLCQuEpX2PWEqAeRWlNtCDSatmUPa0CcFW18qb0VzCXoNS7MlQADMh4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YC7xMOx3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 16B66606A6AF;
	Mon, 23 Nov 2026 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YC7xMOx3
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 500D31F000C6;
	Mon, 23 Nov 2026 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795469200;
	bh=2f4zLT/mLbzpdxNkBcyOmTZl9xYwYOy/bawS8EITYeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YC7xMOx37+OSsIvr60lVA5uVBO5GMxpGAmnQF8DNxlQOQDHQ/cdcqFrVEpdqU9c4f
	 2QpUFUB2HTeASpSIBOyeyyIEOiqER7KCVF8PWs4tc7d1RBXswuUixSRq7CiNj75PJ7
	 Do2E9gipcwMIgu7udhcafLcckdaOAuTNMfeehmltaPmU0EGkvy8awZb5Y/vlS4aByv
	 7zj0+GuaTc1bhiE9m+9fzO3cU9e7DK+SGTEfY2v0o5wcxyedhYkjdZx5NbphMEmjFa
	 f/Cobhx2nOpfjown0F3xl5g5h7+g5ypTspI3HkkVtRCLEineRbpJn/mLOHkn+Hj7ij
	 ZOSIONwMzTsfw==
Date: Mon, 23 Nov 2026 23:26:37 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Guicai Ma <maguicai@kylinos.cn>, James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: Fix asym key overflow in keyctl_pkey_verify()
Message-ID: <awSvjU7khM8kqWUP@kernel.org>
References: <20261123211959.4102708-1-jarkko@kernel.org>
 <20261123211959.4102708-3-jarkko@kernel.org>
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
In-Reply-To: <20261123211959.4102708-3-jarkko@kernel.org>

On Mon, Nov 23, 2026 at 11:19:59PM +0200, Jarkko Sakkinen wrote:
> While verifying a variable-length signature shorter than info.max_sig_size,
> memdup_user() reads past the end of the caller's _in2 and passes trailing
> bytes to ->asym_verify_signature().
> 
> Set params->in2_len to uparams.in2_len in the KEYCTL_PKEY_VERIFY case.
> 
> Cc: stable@vger.kernel.org # v7.2+
> Closes: https://sashiko.dev/#/bug/linux-dd9ad2ca-a846-4d0d-89d6-aa262ffd40f1
> Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  security/keys/keyctl_pkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index b5f82804b5ad..662226576954 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -176,7 +176,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  			goto out_up_key_sem;
>  		}
>  
> -		params->out_len = info.max_sig_size;
> +		params->in2_len = uparams.in2_len;
>  		break;
>  	default:
>  		ret = -EOPNOTSUPP;
> -- 
> 2.47.3
> 

I'll apply this with or without r-by's and/or t-by's but they will be appreciated.

Br, Jarkko
