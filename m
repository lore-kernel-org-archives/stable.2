Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262334078F4;
	Fri, 25 Sep 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347333; cv=none; b=SDVcsnR+WNyVSh0Sifs/5uJcVG7FmpvOH+ajM0+r4blTmVucf97OiX2MbWtGtTwZtjPIHWSfDI6uq3ae8tIYlaxIOceuZx/wuRHRj5Q32994oSXH53cwSilzuh9lQQPg8zD857tdTLK3PcNmbS7oNk4ExckQEVGq5z2puWuPfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347333; c=relaxed/simple;
	bh=ZgnS1uSsOKLV3yTpO+oxJvDOX9CJRo0Y1UrfD5oqtd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGXJMfH459AI2cnlxcixF0qnxCackeBCt8DEWMxAFuIBgXtbpFeCR7xTP0Mtyk7/DUAqM3BTIb8ejQ8+z03HW+zm5X+7pt98gJhcNyniCdAAk0uDP4V0y5Bo7bbVLMQKon3U/WjeFOULCnavOdXCHHFPAIcafgEbQE5pK2wmLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHwzq0sT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHwzq0sT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EB75B1F000FF;
	Fri, 25 Sep 2026 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347324;
	bh=Ck2/IRQO5EbPVSsCOLm10dPKfvHZkxDIrhiZ1koO7JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DHwzq0sTtnh3z3xN/JE86CFeLrIZtsWppDkoBQ4Zp0j6+FCy7q3f4rDQosslFH/Ce
	 yDWX+nhdM9N6GsKwNQbp/wWAy3Vl+mJYeEKD5kANaAom4PIJJUg/kxYfAc9YoRcYPt
	 GgQv4HOA8zQ3tyhLP6U/tobe9M+ovQ3u1YPZ8lBicvFdqBccEHUQhGM5UbAE4+QxHo
	 9A/lApUkUawOsjdt8StLmydraYm2CVO+QzBNfiZSGT4eW6mwtKlMZQV3N4dJjRWXWN
	 CYDLuKXsa5qu3Hfqe8LWTGG3e4wLJK4MhxWpVxtyDQ9cIHOjelocLcdB7H944tw2N+
	 v3LT0C1bM/3fQ==
Date: Fri, 25 Sep 2026 17:42:00 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: microfish <f13208471983@163.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
Message-ID: <araIEern4nSqmeFn@kernel.org>
References: <20260827035511.49582-1-f13208471983@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827035511.49582-1-f13208471983@163.com>

On Thu, Aug 27, 2026 at 11:55:11AM +0800, microfish wrote:
> On certain Lenovo/AMD systems, the BIOS declares an ACPI NVS region
> that covers a large memory range (e.g. 0xccc40000-0xccd3efff) which
> includes the TPM CRB MMIO area (0xccd35000-0xccd38fff). The E820
> subsystem registers this NVS region with IORESOURCE_BUSY in the
> iomem_resource tree.
> 
> When tpm_crb probes, it calls devm_ioremap_resource() to map the CRB
> registers, which internally calls devm_request_mem_region(). This fails
> with -EBUSY because the NVS region already claims that address range.
> 
> Fix this by adding a crb_try_nvs_fallback() helper that detects the
> ACPI NVS overlap using region_intersects() and falls back to
> devm_memremap() when the resource falls inside ACPI NVS.
> devm_memremap() does not require exclusive resource reservation,
> making it safe to use on NVS-overlapping regions. This approach is
> identical to the one used by the WDAT watchdog driver (wdat_wdt_map_mem).
> 
> The NVS fallback is applied in both code paths of crb_map_res():
> 1. When iores is NULL (no ACPI resource encompasses the target address)
> 2. When iores is non-NULL but devm_ioremap_resource() fails with EBUSY
> 
> Before this patch:
>   tpm_crb MSFT0101:00: error -EBUSY: can't request region for resource
>   [mem 0xccd35000-0xccd38fff]
>   tpm_crb MSFT0101:00: probe with driver tpm_crb failed with error -16
> 
> After this patch:
>   tpm_crb MSFT0101:00: [mem 0xccd35000-0xccd38fff] is inside ACPI NVS,
>   mapping without reservation
>   tpm_crb MSFT0101:00: of device registration complete, result 0: 0
> 
> Signed-off-by: microfish <microfish@kernel.org>
> Signed-off-by: microfish <f13208471983@163.com>

Sorry this took so long.

Mention the hardware that you remarked in the response and provide only
single SOB with your real first and last name.

> ---
>  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index ceb4100ba..c4e8b925c 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/highmem.h>
> +#include <linux/mm.h>
>  #include <linux/rculist.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -557,6 +558,39 @@ static int crb_check_resource(struct acpi_resource *ares, void *data)
>  	return 1;
>  }
>  
> +/*
> + * Try to map a resource region. If devm_ioremap_resource() fails with
> + * -EBUSY because the region falls inside an ACPI NVS area (common on
> + * certain Lenovo/AMD firmware), fall back to devm_memremap() which
> + * does not require exclusive resource reservation. This is analogous
> + * to the approach used by the WDAT watchdog driver (wdat_wdt_map_mem).
> + */
> +static void __iomem *crb_try_nvs_fallback(struct device *dev, u64 start,
> +					   u32 size)
> +{
> +	struct resource res = {
> +		.start	= start,
> +		.end	= start + size - 1,
> +		.flags	= IORESOURCE_MEM,
> +	};
> +	void *addr;
> +
> +	if (region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> +			     IORES_DESC_ACPI_NV_STORAGE) !=
> +			     REGION_INTERSECTS)
> +		return NULL;
> +
> +	dev_warn(dev,
> +		 "%pR is inside ACPI NVS, mapping without reservation\n",
> +		 &res);
> +
> +	addr = devm_memremap(dev, res.start, resource_size(&res), MEMREMAP_WB);
> +	if (IS_ERR(addr))
> +		return IOMEM_ERR_PTR(PTR_ERR(addr));
> +
> +	return (void __iomem __force *)addr;
> +}
> +
>  static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
>  				 void __iomem **iobase_ptr, u64 start, u32 size)
>  {
> @@ -565,18 +599,30 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
>  		.end	= start + size - 1,
>  		.flags	= IORESOURCE_MEM,
>  	};
> +	void __iomem *p;
>  
>  	/* Detect a 64 bit address on a 32 bit system */
>  	if (start != new_res.start)
>  		return IOMEM_ERR_PTR(-EINVAL);
>  
> -	if (!iores)
> +	if (!iores) {
> +		p = crb_try_nvs_fallback(dev, start, size);
> +		if (p)
> +			return p;
>  		return devm_ioremap_resource(dev, &new_res);
> +	}
>  
>  	if (!*iobase_ptr) {
>  		*iobase_ptr = devm_ioremap_resource(dev, iores);
> -		if (IS_ERR(*iobase_ptr))
> +		if (IS_ERR(*iobase_ptr)) {
> +			p = crb_try_nvs_fallback(dev, iores->start,
> +						 resource_size(iores));
> +			if (p) {
> +				*iobase_ptr = p;
> +				return p + (new_res.start - iores->start);
> +			}
>  			return *iobase_ptr;
> +		}

Now I recall what I had in mind, and sorry this took so long.

I did what I was unhappy about:

https://lore.kernel.org/linux-integrity/20260901142955.187856-1-jarkko@kernel.org/

It does not make sense to apply this change before my patch is
ack'd because it reduces complexity of this change considerably.

E.g., that helper function will not be needed given no multiple
call sites.

1. You pick my patch to your series. I.e. make this a two patch
   series.
2. We'll hold until my patch is accepted.

>  	}
>  
>  	return *iobase_ptr + (new_res.start - iores->start);
> -- 
> 2.47.3
> 

Br, Jarkko

