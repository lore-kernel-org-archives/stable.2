Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898689;
	b=CAwjylHQBMcSIJg1F4ask3TXd8HDKfyw9gsCE2o15KfVl+f0YJ2XXbOfQUlrFpCM9iZF
	 foBnOuTY/ZKSmQNmMPXohGmw6kqZtRv5ucElPtAxwwl9dVcn67g3OB0y29YASTOpkAdgN
	 dRTBTbds2vPbZ+gby/pKgYe6y6qRaucLygsk/0Zw7LMIpJLs9fUx4uS0+zogaY5IOYcrP
	 Dxl6ugiD3MqOYYbBZWugyAYhqdg5epDM5lPqFGyHOY0hIiT22YUzpXLBtW0Od7xPb6mTP
	 2PYOcOtUJZuxD/E0EY8iMkEj6ybYoYLqFBTD8CTBBRgxat12cFK9ftSxm//ekuBwktQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898689;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1lAUn012SAJPv8LzmMk8AiQwRTQDqHHs/lnV55r2DN4=;
	b=dcClK0vFhKtxJ0g5yukBJKHV+W0jLMgMWQnEB+vVJZfrsAp/lIVyorPQRpC7QdgYrvWt
	 HR2jgpYjftQVklpjTnEFJqcHxV8aIAZEvA8g+hY1dOHuZ41Fhw0zCSJVnm5POaISDe7p1
	 MT2UbQykf0aXuPV4AYwCuN+6dUMYoedg1nXd/lIkO8Wx+bOePhtY1dAdZyiHw5UrFoP5s
	 0m22h7IFjnEuEv1JP9T1cUu9fFBzBfMDXb38LPKRczdL76mK8d00uYiVDwM9oEtop3DHs
	 R3NGyoAATWRYcfJqyQLjyPUqdo4xH8swiMlORV6ffCcOI34Tqb87P9exYXmwrXRYBwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dRb5/iBo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EA983606A328;
	Thu,  5 Nov 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRb5/iBo
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 090091F00919;
	Thu,  5 Nov 2026 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898688;
	bh=1lAUn012SAJPv8LzmMk8AiQwRTQDqHHs/lnV55r2DN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRb5/iBoGD3GMdpCBoaOuagwLk9BSvn+YoVo5zTFnc27LRGk4YS98IPtqJkYKNlur
	 7s4xR1TumWv4s+UzeIUz7gTeL90ozi4pctzOh8h40XuIFuXs4nmXNji8p5iYXiOnZB
	 ylr5eeYa1uULnzBolzKbAeyDUxKjBYrBeOJNCdyGtCnTC3aIaa3vT6Y/1ditxwPF61
	 7xnQXxclgqs/hbtkFEG19EMkk2Hnxh6jNIoS0H2avrUbBxchHvEz1Qi9Kk9a/Ofd5L
	 jfl2WSKvQlQ1SPtDyE7JdkG38hbFZnKMf5Cn8zJCuohWm/nXAbaVTCe7BGjsivJagk
	 m1P0QqdNB+5lw==
Date: Thu, 5 Nov 2026 19:11:24 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/9] keys/trusted_keys: propagate wrapping key
 generation errors
Message-ID: <auy4vLV8CRJB2hKt@kernel.org>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-2-ssrish@linux.ibm.com>
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
In-Reply-To: <20261105144320.357260-2-ssrish@linux.ibm.com>

On Thu, Nov 05, 2026 at 08:13:12PM +0530, Srish Srinivasan wrote:
> plpks_gen_wrapping_key() returns a negative errno when default wrapping key
> generation fails. However, trusted_pkwm_init() returns -EINVAL for all such
> failures, discarding the original error.
> 
> Propagate the error returned by plpks_gen_wrapping_key() unchanged.
> 
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Nit: I'd put the SOB as last.

> ---
>  security/keys/trusted-keys/trusted_pkwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index bf42c6679245..422f752598e1 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -170,7 +170,7 @@ static int trusted_pkwm_init(void)
>  	ret = plpks_gen_wrapping_key();
>  	if (ret) {
>  		pr_err("Failed to generate default wrapping key\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  
>  	return register_key_type(&key_type_trusted);
> -- 
> 2.52.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
