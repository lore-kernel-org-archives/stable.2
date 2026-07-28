Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454547142C;
	Tue, 28 Jul 2026 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265026; cv=none; b=UU+GP+JZvuGcLRCQrXTc4ZhJNwqGpKLc4exMbNY53zoAXZrhOkQrI+k/EO6WJJ7yb9L4m26Kkw0XWWWkjoP88RjAl6cJC0o6weaQAWieQj8eqQBNxCc50SYKbbCOyf5EbWr2uw3Loa3eac8Lg5w2PQChFFV+vMAkvJ/qG4W+RVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265026; c=relaxed/simple;
	bh=9cLTwVHMctlbC81lMRb3ehvoX4pKi6G/CGyNRApTdR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2a8uYgy4ZqgCtrSoOYvFpZck9mA1VlK93arO9vu/nbYe+DqcMkAtpxz6k04irpApI2m93J6E3iev5Qdr1/RCChOdfej+y/NK4SGjj+mslr6A/vDxf8OTjr/ii57N5uUKEf931U9blHZzYuWDa/U9CdoLaI3OMYrHG16b+/u5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UAV00hyM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UAV00hyM"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 965E940E019E;
	Tue, 28 Jul 2026 18:57:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lPpiw9-R7rSR; Tue, 28 Jul 2026 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785265009; bh=K8ANZvjK+WR77oAaS/Gnx0+rHuzltDRBEVrP/Com90A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAV00hyMEcTOSTCozT880pkOruXnrmEU6tCFYOVA5Es9+l7yx4N5b6tjjMd1WJFwp
	 Fln2lcET2WzsHdxZBY7bNNoB3mzgYFCiBBOUprPp8IrujR11/X5dei1DcmNJJQpv+2
	 SqKb/orzxSyc5C3YVLPn+OWUes4ztfI+WdlTNVlEAtelxfZ6zr98zCGarJ0/ojLuW3
	 WiGo1CozEl8Urvf29qf2Sw6uFSIAPXFV0LWVVa+zpiFHGTRsrX1ZvPDhGSbNGX3C6u
	 TujiIHkXfc62xXrYQSMf1HfgW+deBgt1XGv1QFX8G6azOskOa+32cWbViLGIpihs/t
	 gZO4t+Hb6yvijOsaXnP/ChdPdtB0Ap0QBiIZVfATGSyLck0VugkyFj/xpitPxKxV4f
	 Q3yBJ2KLMfucRWxU0ChGwKD9OsSVTAOljZ6NYNDi1OxK2rOV/M2+86os990kTP0KlF
	 1XjDgsfCxfAkeJd38W5AidH5OwmhttipCG7Np9j9D/XRUILHGbePxkEBIyo2hKoF9s
	 bvxAddfXp6oi4B6qWTIMN5zNtTBJZ+gIVodb0e6WghkpBo+jQr1aDYJOA9b05pNnNm
	 rsmCUoV/jQL5f7GWHHMoiRpbLssRr2YooMmSl9atX7T4UcjgTO09Hs51WOGAd9oVjJ
	 p8RINGQ2TqUZc6hnd6SigTFo=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAA1B40E02B7;
	Tue, 28 Jul 2026 18:56:41 +0000 (UTC)
Date: Tue, 28 Jul 2026 11:56:38 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: tony.luck@intel.com, rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/10] EDAC/altera: Fix NULL of_node dereference
 altr_edac_device_probe()
Message-ID: <20260728185638.GAamj7ZjiuriHIBjTw@fat_crate.local>
References: <20260727132416.807230-1-dinguyen@kernel.org>
 <20260727132416.807230-2-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727132416.807230-2-dinguyen@kernel.org>

On Mon, Jul 27, 2026 at 08:24:07AM -0500, Dinh Nguyen wrote:
> In altr_edac_device_probe() dereferenced pdev->dev.of_node and
> of_match_node() before validating it,

How did that AI let you fumble that sentence? :-P

> which could cause a NULL pointer
> dereference when the device tree node is missing. Check the result for
> a NULL and bail out with -ENODEV before using it.
> 
> Assisted-by: Cursor:claude-4.8-opus
> Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
> Closes: https://sashiko.dev/#/patchset/20260719211238.589402-1-rosenp%40gmail.com

So the AI review for this one here is this one, I think:

"This isn't a bug introduced by this patch, but can np be NULL here if the
driver is bound via sysfs?
If a privileged user unbinds and rebinds the driver via sysfs to a platform
device that lacks an of_node, pdev->dev.of_node will be NULL, which would
cause an unconditional dereference when accessing np->name."

Can that happen?

Have you been able to trigger it?

If so, then the mechanism how this happens should be in the commit message,
explaining why this fix is needed and why it is needed now, all of a sudden.

AI is helpful in some cases but I would like us to sanity-check everything it
hallucinates pls.

> Cc: stable@vger.kernel.org
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/edac/altera_edac.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 68846f583eeef..d6ca68d74f78a 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -710,9 +710,18 @@ static int altr_edac_device_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	int res = 0;
>  	struct device_node *np = pdev->dev.of_node;
> -	char *ecc_name = (char *)np->name;
> +	const struct of_device_id *edac_dev_match;
> +	char *ecc_name;
>  	static int dev_instance;

I know this is not something you should do now but let's pay attention to
this:

The preferred ordering of variable declarations at the beginning of a function
is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;
  
> +	if (!np) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Unable to get device tree node\n");
> +		return -ENODEV;
> +	}

Pls write it like this:

	np = pdev->dev.of_node;
	if (!np)
		...

> +
> +	ecc_name = (char *)np->name;
> +
>  	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
>  		edac_printk(KERN_ERR, EDAC_DEVICE,
>  			    "Unable to open devm\n");

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
