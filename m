Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB043F39E4;
	Fri, 18 Sep 2026 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767855; cv=none; b=azkf0Zp1Ozr89/j14Fhz/lEqdQzAEkUJ7mlLnOYpbOjRQLywmVkW6c9+upmlG19ciKXqBVOiNZrem1qLboXZ82L4h2MdzVtAjuTmoTbHsg/VkNG1QAr/o/IF4zmCpcW4lA7QRHF/iuLbmDPRcLnd0pDRCToNH0y3C+Zr+IwIVmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767855; c=relaxed/simple;
	bh=lGcZs9Ya685F4IECF8X0D5dii1TMdSeuiUW9ZnB0SuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qM+P8wrSlh9v6j7TL3b7zr8P+wHZcC4xtkx2ByjKnggDdrfKz2wutT1EGyfZCILOHPGm9AhhRSaRLSsMm5YWMEkmsFjGA9Ry3SxFCvkE7CPAwzjMrM8WWGRyRQJYazrT6rvGVioRQ8DeoBq0eytbjqqJMRkKTbsAH2NpwHT8stA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIqIr83l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIqIr83l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC6D1F000FF;
	Fri, 18 Sep 2026 21:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767854;
	bh=j5IG9Rqy0v+njwZWEYcAlUJQDLI7QibMVy2LlvQ4GpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IIqIr83l9kya388yLaqvpfg+q9HbEyZsQDdFgpJFCLvoJxuY5G0bbsuOHd/Sb/RXP
	 3lrhoyKHdPCqQrl1eZ/Iwg+ykLzyYbCS6G4AZPbfgWh05ZUaT0YefFz64xtO7XrrDV
	 D0CvvVI7WqfcJMEPbT0/Xu55v/Y49I5mT/TWoy4y/zf68ZTM/gsh700Fm27aV3Hwf4
	 SKh8Qgwu1uXDR4dt0E7U4Fp8kuxdBEd146dnUPxMldoREWCuH+e1KDGg8cydrggAnf
	 HRYzsNkW2Zw178WBoEXmRiYeamu8tP3p2g/FQdnipYJG/Ru0dEC0en5K71uFBfPjIP
	 LNtUKmrOYgA6g==
Message-ID: <91b23d5a-b923-48da-9ab5-bf2aabe1afca@kernel.org>
Date: Fri, 18 Sep 2026 22:44:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: u-boot-env: Fix mtd reference leak in
 u_boot_env_probe()
To: Wentao Liang <vulab@iscas.ac.cn>, a.fatoum@pengutronix.de
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 rafal@milecki.pl, srini@kernel.org, stable@vger.kernel.org
References: <20260917123839.2151503-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260917123839.2151503-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/26 1:38 PM, Wentao Liang wrote:
> of_get_mtd_device_by_node() takes a reference on the returned MTD device
> that the caller has to drop with put_mtd_device(). The probe function
> returns early when devm_nvmem_register() or u_boot_env_parse() fails
> without releasing that reference, so add the missing put_mtd_device()
> calls on both error paths.
> 
> Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/nvmem/u-boot-env.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index ced414fc9e60..893fbd2a8520 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -52,6 +52,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct u_boot_env *priv;
> +	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -71,10 +72,16 @@ static int u_boot_env_probe(struct platform_device *pdev)
>  	config.size = priv->mtd->size;
>  
>  	priv->nvmem = devm_nvmem_register(dev, &config);
> -	if (IS_ERR(priv->nvmem))
> +	if (IS_ERR(priv->nvmem)) {
> +		put_mtd_device(priv->mtd);
>  		return PTR_ERR(priv->nvmem);
> +	}
> +
> +	ret = u_boot_env_parse(dev, priv->nvmem, priv->format);
> +	if (ret)
> +		put_mtd_device(priv->mtd);
>  
> -	return u_boot_env_parse(dev, priv->nvmem, priv->format);
> +	return ret;

consider devm_add_action_or_reset() that should cover one more case this
patch missed.

--srini
>  }
>  
>  static const struct of_device_id u_boot_env_of_match_table[] = {

