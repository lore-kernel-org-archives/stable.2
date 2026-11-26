Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679569;
	b=QRnNtkZe1QlGs2sSZy/wdTyxE7dQDicz4SgLXv54XOxXd2K1VZ3ibipQ+IkClRMJdwJ5
	 Q8XPVdzGiGljionU5mE/4oTbec3XITfJfDEvMXp0LBhxfZRY2K++b0NEFrnwck8xBz1uF
	 RuuABzlc2cSU78CBJe9VVYJ3EvkhaO2kiseBmpK2Y+6/tUvrqGySMo+br7ffWWs0+E8kV
	 AOFjvTkHCj15mTIMIZLhCyJ0qd1TUcI3c3bQUtt+Z+9/hqJ8T+MecnhDK23C544xVinDv
	 goL4hutF+Tslk0mAJAue3E3bDJi8roV7LtMm3DV3lMx5Dmw/MjN3FbMP7Ju90RJuMNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679569;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=DPgtUnPt8A2Ex4gPVPYsXkQVGxN0nieCp/+AS0RsgRw=;
	b=ygaEDMhDr+VZ1qOEOmy4BNNJbJwYyKaOYtseBRuxvyXp8HfCIuNo9mWgtNHtSqw3n7Ej
	 a8RCvJa8+VVht3ZPBRlYz1lM0N4fqBYFu+YppvfpjBF1ksqM8pmAPdoa0Eb3aAsjz06Us
	 TfHOlywwVKrU95kONzGI0db92K0dkAgOmETh1PmdsKb/LrEmcnB+UGuq4q02tveO3f/eR
	 x8LXfrYPgWlAk1rpGIn9CHcMjyZROGDrKdgtqMW2WYT7N4oj4aPFTQLQxtRYO6fc+GnKE
	 1eV0ga5zAQxtmDmiQaCbhgq/0w83aHCs4beXamXyoz/+s56nVBZ/oSL+fmjl5M7aLfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=KKgfGU4X;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6231606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6231606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=KKgfGU4X
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261126075245euoutp01a509a67323cffbd2b57f23e13d0d3122~riQ0LbqGi1628016280euoutp01S
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:52:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261126075245euoutp01a509a67323cffbd2b57f23e13d0d3122~riQ0LbqGi1628016280euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795679565;
	bh=DPgtUnPt8A2Ex4gPVPYsXkQVGxN0nieCp/+AS0RsgRw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KKgfGU4XMr8bjSinXHAW9DLzalUCgCKOFZlrFuHucpVdilnQk62wv3U6upS7awWfO
	 UOd0JpOgVMu5qLUTdOl6hZYVHXOGBXbYlmyaahOAkslAgHVkiNgYBu1u08b2gNt0K+
	 iwTC1rjZufsBudqc5YWC74Z3b84yi5G46/LTjzqE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261126075245eucas1p1570c4ab21c1e2ed63e13386ba12430ed~riQz46jSB1345313453eucas1p1Y;
	Thu, 26 Nov 2026 07:52:45 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261126075244eusmtip2cc7fbf8f02e77449e3b2c6819c2ed33a~riQzFNlAx0282502825eusmtip2W;
	Thu, 26 Nov 2026 07:52:44 +0000 (GMT)
Message-ID: <27eac3a7-d5d3-4d29-a38f-8d22a3faf504@samsung.com>
Date: Thu, 26 Nov 2026 08:52:43 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] iommu/exynos: Disable runtime PM on registration
 failure
To: Zhiqi Zhang <zhiqizhangg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261126045203.62181-1-zhiqizhangg@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261126075245eucas1p1570c4ab21c1e2ed63e13386ba12430ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261126045219eucas1p11712605a6aec839075da6ff9bc9dfe15
X-EPHeader: CA
X-CMS-RootMailID: 20261126045219eucas1p11712605a6aec839075da6ff9bc9dfe15
References: <CGME20261126045219eucas1p11712605a6aec839075da6ff9bc9dfe15@eucas1p1.samsung.com>
	<20261126045203.62181-1-zhiqizhangg@gmail.com>

On 26.11.2026 05:52, Zhiqi Zhang wrote:
> exynos_sysmmu_probe() enables runtime PM and then registers the SysMMU
> with the IOMMU core. If iommu_device_register() fails, the error path
> currently only removes the sysfs entry before returning.
>
> That leaves runtime PM enabled for a device whose probe failed. The same
> path can also leave dma_dev pointing at this SysMMU when it was the first
> one to initialize the global DMA helper device, so later domain allocation
> may use a device that never finished probing.
>
> Add an unwind label for iommu_device_register() failures. Disable runtime
> PM there, clear dma_dev if this probe set it, and then remove the sysfs
> entry as before.
>
> Found during static probe error-path review with help from OpenAI Codex.
> The fix was build-tested with ARCH=arm exynos_defconfig and W=1 using an
> arm-linux-gnueabihf GCC cross-compiler.
>
> Fixes: bbc4d205d93f ("iommu/exynos: Fix driver initialization sequence")
> Cc: stable@vger.kernel.org # 6.2+
> Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>

In real world this doesn't happen, but anyway:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>  drivers/iommu/exynos-iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 7c337ba96..18a536008 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -844,10 +844,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>  
>  	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
>  	if (ret)
> -		goto err_dma_set_mask;
> +		goto err_iommu_register;
>  
>  	return 0;
>  
> +err_iommu_register:
> +	pm_runtime_disable(dev);
> +	if (dma_dev == &pdev->dev)
> +		dma_dev = NULL;
>  err_dma_set_mask:
>  	iommu_device_sysfs_remove(&data->iommu);
>  	return ret;
>
> base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

