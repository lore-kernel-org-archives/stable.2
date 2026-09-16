Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5381511180;
	Wed, 16 Sep 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566610; cv=none; b=AbKUMI6lcinyjzrxWdC0H14P7qUoodqBZmuEzhg0sxClFr1FLUzW7f7LQXhp/wQLyu+BI45zyuMSALf9iKFC0UGNJ2MmMgllPkNHwOamE5U5ErGhcNHENYa+fN4JTmIithlbBVm0DegiRLhwWvyEjIjy+d7SElgr+q6liK/Q6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566610; c=relaxed/simple;
	bh=5pYZ9PGA+B9Eq6LGQPPGxbLJGjGGDd2DFV19f6LgGe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbMFcAnGHvF6ndwVab2//q2a2mfQUMlL56mtjFS+aL8e2t+sBwYWlL1IHFC57ToGwHnfftgwMse3mAIpHaYQZVkmSh5L0xaZln1cYjzCgd1sNlTTwTK3Ea/kEmCwt2I3Vp60SFC64X+icJjnBOrxM62N9IqxRx2KbkfEWPGWDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc59F4vE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc59F4vE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F261F000FF;
	Wed, 16 Sep 2026 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566598;
	bh=eCM/AAV8GWx+g2kTtb2XKfnbB4PK5Qd6Q2Py7J3qNCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nc59F4vEzEOUurR7wabIMt7+yjK6wlLhP8FMLMKYAOX/KUX+imHMfXcr0O+b174Rf
	 ztfacsFwISbGPzsGNYaZk+XW8FSgYDsyX02fZt/8ZHQ9G2Kv7ufRVnkrNrT28acGDn
	 r08ASDl/byXLthDI6RxKiZWVmS3Mgdn3H74A+NidM1mgp1Sew48JSQILN7LJpLPQ/w
	 ZDyfn55DWaK1RUT5suxpNaE6pMY0SO8ezc52UV01jbs2CRziGNIyKpT5/udo7Edz78
	 08Xhgvcf+w9PsUzaZAd3CHuD7zFrf03qj3ZlY+yBXBjNJIVn52gZHb8iXkcsBNn64M
	 rkoE4PG/03McA==
Date: Wed, 16 Sep 2026 14:49:54 +0100
From: Lee Jones <lee@kernel.org>
To: david@ixit.cz
Cc: Thomas Tai <thomas.tai@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: wcd934x: Set DMA mask on parent to silence
 "DMA mask not set"
Message-ID: <20260916134954.GA1605367@google.com>
References: <20260903-wcd-dma-v3-0-d3920c6563c4@ixit.cz>
 <20260903-wcd-dma-v3-2-d3920c6563c4@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-wcd-dma-v3-2-d3920c6563c4@ixit.cz>

On Thu, 03 Sep 2026, David Heidelberg via B4 Relay wrote:

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

Already applied.

> ---
>  drivers/mfd/wcd934x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
> index 3a939e7ad3da5..fc17c39791301 100644
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
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to set dma mask\n");
> +
>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return	-ENOMEM;
>  
>  	ddata->irq = of_irq_get(np, 0);
>  	if (ddata->irq < 0)
>  		return dev_err_probe(dev, ddata->irq,
>  				     "Failed to get IRQ\n");
> 
> -- 
> 2.55.0
> 
> 

-- 
Lee Jones
