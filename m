Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71A2BF3F4;
	Thu,  4 Jun 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567441; cv=none; b=iQKfYp3yuSxp3aiSKdymH0Qt3E7BbubOeuDPwxAgwAx4Xt2vmJYiNQuTNPOTkScvJ9LVUDLbSedG7xKDn+JjKXhCZ9m5lpmLcOKBzQHymJc3R8RJcEiOzbX+sNluloF2mKcrgcoBjCfize5PVRaPvUojUpnTGUriY29GKeTNfzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567441; c=relaxed/simple;
	bh=vcg/q8QPQ363sZVmhpov0b4BLBC9751058fX8ZL4XGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ6FRR+JTxsHvtlIDxEr3HPxq9o267ndcA5WmMRNpxtALRbypOIorEALhI0fvH3ht44ssUCC4yXSaGn19YzeniFl+r2Vrp6KR5xnSYdct/ee/UXuEFnmjQhOYPV86MJRKRdup57Ue2OeoHiGzn8zwODK+eRF1y1LcL7uzOWClHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLuUZRGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLuUZRGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B3F1F00893;
	Thu,  4 Jun 2026 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780567438;
	bh=2ofRwHTLn/12l/fT2KWbpQRZ9Zj+qKy2X84oj6OTDoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nLuUZRGSVBsFqHiOE0OS7Na1bclGW0ulONzASXaRihd1Ov0+tSvKBr4ynRvzQ6Kkj
	 xW2uF48bC9wl4xI3zLvbuxsKCy/IuXsxgbUcQidCmczP73AT0vWM9FU9H+Ka8vgVTg
	 Sgeddng5pVcBkAwBCvdtTVivwPjgY6EEb0WrGgDLVUUdUva63+RZIVfCzuBWjX0o6L
	 KzFjzTPV4m7/Ie7ve3miCQs/AkPrmKyOBYtFlvQGEGUhcHZ8wCX7ipk9L+hGq3w9Ee
	 x1SZ8dJIMCxs+IJjmbHF3pJxs11edK0oczVuxlnEU/U9Ko9yv8I8THxbD85+g6FlKQ
	 MT4ucuuR+unQw==
Date: Thu, 4 Jun 2026 12:03:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci_brcm: fix reset refcount leak in
 brcm_ahci_resume()
Message-ID: <aiFNiWf7bs2pmPFh@ryzen>
References: <20260603102420.3735032-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603102420.3735032-1-vulab@iscas.ac.cn>

On Wed, Jun 03, 2026 at 10:24:20AM +0000, Wentao Liang wrote:
> When brcm_ahci_resume() succeeds with reset_control_reset(), any
> subsequent failure in ahci_platform_enable_clks(),
> ahci_platform_enable_regulators(), ahci_platform_enable_phys(),
> or ahci_platform_resume_host() leaves the shared reset line's
> triggered_count incremented by one. On the next attempt to reset
> the hardware, atomic_inc_return() sees a count greater than one
> and the reset is silently skipped, potentially causing data
> corruption or device malfunction.
> 
> Add a reset_control_rearm() call in the common error path after
> brcm_sata_phys_disable() and ahci_platform_disable_regulators()
> to properly balance the triggered_count, matching what the probe
> error path already does.
> 
> Fixes: c0cdf2ac4b5b ("ata: ahci_brcm: Fix AHCI resources management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/ata/ahci_brcm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 29be74fedcf0..38c63d73d210 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -415,6 +415,7 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
>  out_disable_phys:
>  	brcm_sata_phys_disable(priv);
>  	ahci_platform_disable_regulators(hpriv);
> +	reset_control_rearm(priv->rcdev_rescal);
>  out_disable_clks:
>  	ahci_platform_disable_clks(hpriv);
>  	return ret;

When writing a fix that has a Fixes-tag, please CC the author of the offending
commit. Note that if you use ./scripts/get_maintainer.pn on a a patch, it will
automatically include the author of the offending commit in the list of people
to CC.


Now you are adding reset_control_rearm() before disabling clocks to the error
handling in brcm_ahci_resume(), however in the error handing in
brcm_ahci_probe(), we call reset_control_rearm() after disabling clocks.
Why should the error handling in brcm_ahci_resume() not match that of
brcm_ahci_probe() ?


I am confused as to why the error handling in brcm_ahci_probe() is calling both
reset_control_rearm() and reset_control_reset().

The documentation for reset_control, explicitly says not to do this:
https://github.com/torvalds/linux/blob/v7.1-rc6/drivers/reset/core.c#L365-L366

And in libahci_platform.c, we always do either:
return reset_control_rearm() or return reset_control_reset():
https://github.com/torvalds/linux/blob/v7.1-rc6/drivers/ata/libahci_platform.c#L188-L193

Too bad that this driver is not using the generic AHCI functions in
libahci_platform.c.


Kind regards,
Niklas
