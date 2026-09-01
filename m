Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570373D9058
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273454; cv=none; b=X+MSsWa+kS0HEDxpVcWmbpKdOplFWH32RfBG3qDwoffNqA8KyyF7hsP9D0Pno7oWTTxTs7ku6Ba5PocCpRM7lr8lcDv7HIg+chVPm0Rw02P5/tHxr6uKpBf16q+L5yRgcIu9Hjc0n7CSK6V5ZSSzbZOpF8zzRxObSLpTlQO4NF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273454; c=relaxed/simple;
	bh=kSFkLCT4lP4vFeFSDVrix+7vF6mBascSgouocKOzfTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OCJzb4Il84vYOQFuhr5gmpFnLC7G4+0ey27Q1nSyBJK28RNLxzDZa/MdSDE4yrLc3blH3wvneNX+nU+jbacywr9pVZL+w758yAP2AjgrguxgqnTWVPtGrh8/fzQ5BdmLO43GqDNF6DsDago7C8C2quBMXvRyOefwu9By3BUSY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sG+pyP5g; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sG+pyP5g"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260901143727euoutp026cdab3e48ecaf50d42b373d7360a806a~ROTnm2kp10534305343euoutp02q
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:37:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260901143727euoutp026cdab3e48ecaf50d42b373d7360a806a~ROTnm2kp10534305343euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788273447;
	bh=FAsl/XQrs4VLbX74CG0t4ucPsDxZGFB9D3BoVTKBaao=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sG+pyP5gX3vW7whpHoWG3DUp+gs63BbFNPdCwBhiXaBVaDb158qx2qDyKQC8kEcQH
	 jBJKBW1/MhjcMc4hBRPeppV5zLZ/85/0relSASg00s5VSBDdeYLiOS4bElWHm5AlC8
	 WnVtE8WisOrFH2bjR8psBk/vdjPwOlFlfqThYldI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260901143727eucas1p1a5f14449cb713b428091c1dfedd6fdf0~ROTnTiDnv0625906259eucas1p12;
	Tue,  1 Sep 2026 14:37:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260901143726eusmtip1f872eae2510fdcd32a78e8c61018cf78~ROTmfxHEn0405704057eusmtip1a;
	Tue,  1 Sep 2026 14:37:26 +0000 (GMT)
Message-ID: <1a6d4f12-edef-4faa-b2e0-2ea711fb6ad4@samsung.com>
Date: Tue, 1 Sep 2026 16:37:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] iommu/exynos: Initialize lock before requesting IRQ
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
	Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Alim
	Akhtar <alim.akhtar@samsung.com>, KyongHo Cho <pullip.cho@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jianhao Xu
	<jianhao.xu@seu.edu.cn>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260901130527.3289245-1-runyu.xiao@seu.edu.cn>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260901143727eucas1p1a5f14449cb713b428091c1dfedd6fdf0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260901130537eucas1p274a55745ced68a1e157bd43cfd17448f
X-EPHeader: CA
X-CMS-RootMailID: 20260901130537eucas1p274a55745ced68a1e157bd43cfd17448f
References: <CGME20260901130537eucas1p274a55745ced68a1e157bd43cfd17448f@eucas1p2.samsung.com>
	<20260901130527.3289245-1-runyu.xiao@seu.edu.cn>

On 01.09.2026 15:05, Runyu Xiao wrote:
> The SysMMU interrupt handler can run as soon as devm_request_irq() is
> called. Initialize the driver lock before registering the handler so an
> early interrupt cannot use an uninitialized lock.
>
> Fixes: 2a96536e77b4 ("iommu/exynos: Add iommu driver for EXYNOS Platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Assisted-by: Codex:GPT-5


Sorry, but this patch doesn't make much sense. There are other things that have
to be properly initialized before the interrupts can be handled. To ensure that
interrupt doesn't fire before handler has been registered one should enable
clocks and reset the hw:
        writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
        writel(0, data->sfrbase + REG_MMU_CFG);

> ---
>  drivers/iommu/exynos-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 874d05f4b..e9feb83b3 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -735,6 +735,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	spin_lock_init(&data->lock);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	data->sfrbase = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(data->sfrbase))
> @@ -773,7 +775,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>  		return PTR_ERR(data->clk_master);
>  
>  	data->sysmmu = dev;
> -	spin_lock_init(&data->lock);
>  
>  	__sysmmu_get_version(data);
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

