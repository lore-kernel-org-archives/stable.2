Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F393DAAC2;
	Tue, 15 Sep 2026 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445222; cv=none; b=r+ACuHoThI2sHfxpUOCCiKyz9zmyxilLNTnwgFOom+i8Q5vBmgDl4hXQg9q9Cjzi5yy4RmY73UGlzF/rjIN4pVye56uVCwOH1Y0XV4SqUk/ATEAwe7LLea3Tp+Xr/z5nxxamuXL1Yj2+ZIWYuTKyL939vT3TGFD2FSfEBM8jxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445222; c=relaxed/simple;
	bh=7Fo7l6verIL/puW8eR53W5uNpEX8RrPVi8YlPy9tKG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTJaLW/L6YFw0OxS0QKtxxvMUIfBsXuNVZ2qw53t8VZ1zmxwEl5LvjJTdyW4uEVhEKKyH3s477UsvRGiBb870irmUa2++SsmV33D4RKB/tfCuIKNCWCuW9cgz5P/1Zt/kauFQIjDMeO6miBcrYx9GtqFR2QqI//jB11lES1I6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3WIY/JB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3WIY/JB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2E81F000FF;
	Tue, 15 Sep 2026 04:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789445220;
	bh=vfrtWY0UDRmyD3fJyuOsDkazcCTD6zqJGRqC5eNWrMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V3WIY/JBiLn5zBUujPIXZJV9+8gaA0NNbZ+rOc6ENkvfDuv0sFTmjs1lCzHkL1/ui
	 lPuXpNJNuEjW9AfwaFlijBxfD6d7SanFe5TtjPIABJ2zzeTd2fuuxs9puz7sY3d2P5
	 i4t82MzWaZ2WeHpbPt7y1uFZ9BCG48CLHaNniX8ezOzjNhMsYVP1WwH/ywwI6KvO5Z
	 Rt3fTi2PzqztX03Q1M3P2XzJMTY71Y46tp1J9vs3ZDPA7apvYtjTvyYSGVcZVkKDyT
	 PZw5BRAw+X6INDG2rh1/6SeZz2trA6u0AExjtto8M1YCLk7vaU2nlGwJ6ezIeTQm61
	 3M4CNdHqY9+Qg==
Message-ID: <34709b8b-71e9-46d2-8732-a802e544701e@kernel.org>
Date: Tue, 15 Sep 2026 11:06:55 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] ata: sata_fsl: Fix use-after-free of host_priv on
 probe() failure
To: Niklas Cassel <cassel@kernel.org>, Baokun Li <libaokun1@huawei.com>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, stable@vger.kernel.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, linux-ide@vger.kernel.org
References: <20260910171406.131211-7-cassel@kernel.org>
 <20260910171406.131211-9-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260910171406.131211-9-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/11 0:14, Niklas Cassel wrote:
> sata_fsl_host_stop() releases hcr_base and host_priv:
> 
> 	static void sata_fsl_host_stop(struct ata_host *host)
> 	{
> 		struct sata_fsl_host_priv *host_priv = host->private_data;
> 
> 		iounmap(host_priv->hcr_base);
> 		kfree(host_priv);
> 	}
> 
> ->host_stop() is called by the driver core through the ata_host_stop()
> devres action which ata_host_start() registers, so it is called both
> when the device is unbound and when probe() fails after
> ata_host_activate() has started the host.
> 
> The error_exit_with_cleanup label in sata_fsl_probe() releases hcr_base
> and host_priv as well, and it is reachable from the two
> device_create_file() calls done after ata_host_activate(). In that case
> sata_fsl_host_stop() runs on an already freed host_priv, resulting in a
> use-after-free and a double iounmap()/kfree().
> 
> sata_fsl_probe() also ignores the return value of ata_host_activate(),
> so probe() returns success even if activating the host failed.
> 
> Check the return value of ata_host_activate() and, once the host has
> been activated, leave hcr_base and host_priv to sata_fsl_host_stop().
> 
> Note that if ata_host_activate() fails inside ata_host_start(), e.g. if
> sata_fsl_port_start() fails, ->host_stop() is not registered and
> hcr_base and host_priv are leaked. Leaking them is preferable to freeing
> them twice, and this is addressed by a later patch in this series.

I would prefer seeing the leak fixed here too so that we have a self contained
fix in a single commit.

Or, move the leak fix patch before this one.

> 
> Fixes: 6c8ad7e8cf29 ("sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/sata_fsl.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 70b210afd291..2123da66dc3c 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1490,8 +1490,10 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>  	 * device discovery process, invoking our port_start() handler &
>  	 * error_handler() to execute a dummy Softreset EH session
>  	 */
> -	ata_host_activate(host, irq, sata_fsl_interrupt, SATA_FSL_IRQ_FLAG,
> -			  &sata_fsl_sht);
> +	retval = ata_host_activate(host, irq, sata_fsl_interrupt,
> +				   SATA_FSL_IRQ_FLAG, &sata_fsl_sht);
> +	if (retval)
> +		return retval;
>  
>  	host_priv->intr_coalescing.show = fsl_sata_intr_coalescing_show;
>  	host_priv->intr_coalescing.store = fsl_sata_intr_coalescing_store;
> @@ -1500,7 +1502,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>  	host_priv->intr_coalescing.attr.mode = S_IRUGO | S_IWUSR;
>  	retval = device_create_file(host->dev, &host_priv->intr_coalescing);
>  	if (retval)
> -		goto error_exit_with_cleanup;
> +		goto error_exit_detach;
>  
>  	host_priv->rx_watermark.show = fsl_sata_rx_watermark_show;
>  	host_priv->rx_watermark.store = fsl_sata_rx_watermark_store;
> @@ -1510,16 +1512,24 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>  	retval = device_create_file(host->dev, &host_priv->rx_watermark);
>  	if (retval) {
>  		device_remove_file(&ofdev->dev, &host_priv->intr_coalescing);
> -		goto error_exit_with_cleanup;
> +		goto error_exit_detach;
>  	}
>  
>  	return 0;
>  
> -error_exit_with_cleanup:
> +	/*
> +	 * Once the host has been activated, hcr_base and host_priv are
> +	 * released by sata_fsl_host_stop(), which is called by the driver core
> +	 * through the ata_host_stop() devres action registered by
> +	 * ata_host_start(). Releasing them here as well would result in a
> +	 * double iounmap() and a use-after-free.
> +	 */
> +error_exit_detach:
> +	ata_host_detach(host);
>  
> -	if (host)
> -		ata_host_detach(host);
> +	return retval;
>  
> +error_exit_with_cleanup:
>  	if (hcr_base)
>  		iounmap(hcr_base);
>  	kfree(host_priv);


-- 
Damien Le Moal
Western Digital Research
