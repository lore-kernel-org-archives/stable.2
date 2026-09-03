Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C547208F;
	Thu,  3 Sep 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439785; cv=none; b=giBn4DS2UDtenB2BpEYApXr7Uq0IILoDajDYhoLL/onix+tSlJBd11CJ/jQ6gGYbiR7UzLuFnBjzscjaa3R8AOg/BPVe8ww76u24taCfSnwABgnTULlVBVXN9t5pm5oQDO1pTrTx4QEQXzY7yKE9t3w3St2et0/wGNfZZ+bABjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439785; c=relaxed/simple;
	bh=eBLWZdRUCJQkpc4ABvRVrT7yaZb3i/iKB43u0BEa12U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgLm2esbjszTa89g4Xltf2p7gmHVkJaAFGEnwFho959iuStFbOtksiCc90Z+GcYcN2IKvn88cel2SpPRnBpC7sWIPKZ3fIyShveaH0TCDYs8ISCxjTQCEG4EuwVOBbJFCRPsfZAM1Vp1+r1dV4U+NYl0MtDCDbFwXfUVRBF2r8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPdvRydi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPdvRydi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17131F000E9;
	Thu,  3 Sep 2026 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788439784;
	bh=F2FrWcK0uvS3ll2oLYKWcdBOi4hjBzbOPy6uKBeL6EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JPdvRydiv7M1DbZfJlF8/3lB/fClXPoZxOG6nvJr+SLEr0gfx6T7waiky4YVEPXrU
	 fejuyY9QilQiduOUvBiCCYFQTG4dYTKP57kS0fVHKuWksBdCpc6yOSYWPDJFIQmMd2
	 owBafAhkUHwFb+Cc/zFMJKcp2uxF+uEqH7nCEMTR1U7kSkJYIIeCZToWMzqUNZUs50
	 rHKE3cwzxHHR/CPViGpO/Iyr6eSKpF8KQpPi87auKUC9OfbrVwQdDuxjQfHXWBzEEf
	 KVndEppzPJHflv+yjPx+Z+tsqYoYdRLmJqZn9EkTR1nlxNbTJJPRIEDN4LDhzjPTiY
	 tI9jNnn+uNfaQ==
Date: Thu, 3 Sep 2026 13:49:39 +0100
From: Lee Jones <lee@kernel.org>
To: david@ixit.cz
Cc: Thomas Tai <thomas.tai@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: wcd934x: set DMA mask on parent to silence "DMA
 mask not set"
Message-ID: <20260903124939.GT2133376@google.com>
References: <20260823-wcd-dma-v1-1-95e44a315ccf@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-wcd-dma-v1-1-95e44a315ccf@ixit.cz>

On Sun, 23 Aug 2026, David Heidelberg via B4 Relay wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> The wcd934x MFD parent (a slim_device) never initializes its
> dma_mask/coherent_dma_mask. When the DT-aware children pass through
> of_dma_configure() this triggers the "DMA mask not set" warning for
> each child.
> 
> Cc: stable@vger.kernel.org
> Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
> Assisted-by: tencent:hy3
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/mfd/wcd934x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
> index 3c3080e8c8cf7..70ee13791d52b 100644
> --- a/drivers/mfd/wcd934x.c
> +++ b/drivers/mfd/wcd934x.c
> @@ -1,12 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2019, Linaro Limited
>  
>  #include <linux/clk.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/wcd934x/registers.h>
>  #include <linux/mfd/wcd934x/wcd934x.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -212,16 +213,21 @@ static int wcd934x_slim_status(struct slim_device *sdev,
>  static int wcd934x_slim_probe(struct slim_device *sdev)
>  {
>  	struct device *dev = &sdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct wcd934x_ddata *ddata;
>  	struct gpio_desc *reset_gpio;
>  	int ret;
>  
> +	if (!dev->dma_mask) {
> +		dev->dma_mask = &dev->coherent_dma_mask;
> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +	}
> +

Any reason not to use dma_coerce_mask_and_coherent()?

>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return	-ENOMEM;
>  
>  	ddata->irq = of_irq_get(np, 0);
>  	if (ddata->irq < 0)
>  		return dev_err_probe(ddata->dev, ddata->irq,
>  				     "Failed to get IRQ\n");
> 
> ---
> base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
> change-id: 20260823-wcd-dma-bd621ee39887
> 
> Best regards,
> --  
> David Heidelberg <david@ixit.cz>
> 
> 

-- 
Lee Jones
