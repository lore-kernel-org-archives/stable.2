Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35962429CF3;
	Tue,  1 Sep 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268819; cv=none; b=hyI0DpnjMekoNROmKAc7eqLDuMdCBYEMFur0KeiZIu3FfdKkrtib4/wDJ4xksTBWX2JiK1fcyirxSeP8wwJfpBDzW51i9DaVi9VVWB5rV0ySFmVw9MKbpA82BQ22BgNPxj9ffwrtDvib2HpSrszD9ZHfMeZDFq49OwKCDIx8TJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268819; c=relaxed/simple;
	bh=nenqtb/1rWx2Wc6vlwOfg7g3fX9Nslava+BW/4x7vh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUuSWncR5Lx0cszO5ieCjeCiGWE/XLSjgMjR07rBAdJOeL2t6lE1lsxqW3RDGs4nP89tdYwDaUm/npYnJxG+Ztqj39nriKzzUY4ZVPKi/GXvrjqoDhMRhfP17CEfkmr/0orsE53SbrNfM0S9IBiHfo1mip0U2/ahZBulbTLxcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tzKLefnu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tzKLefnu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B12E1756;
	Tue,  1 Sep 2026 06:20:12 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B1C13F882;
	Tue,  1 Sep 2026 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788268816; bh=nenqtb/1rWx2Wc6vlwOfg7g3fX9Nslava+BW/4x7vh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tzKLefnuBA7K2Sihm5EsIoRPnR7tt84b4HlzA3r6ntwk+h/pizCIhB6DoHKi0Oap4
	 NcimuH7tdrG7nmkmdsp/Ddt6kwbYO5dFp6IqX4SdbzLKacSqriv8YSnmg6ZCE0B2Hk
	 urDNCconsocbyOBB0rv0iG18tKFRDQ6vTan/R3Rk=
Message-ID: <0872f586-ce2c-41b4-9452-0b9c3052aea1@arm.com>
Date: Tue, 1 Sep 2026 14:20:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/exynos: Initialize lock before requesting IRQ
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, KyongHo Cho <pullip.cho@samsung.com>,
 Kukjin Kim <kgene.kim@samsung.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260901130527.3289245-1-runyu.xiao@seu.edu.cn>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260901130527.3289245-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2026 2:05 pm, Runyu Xiao wrote:
> The SysMMU interrupt handler can run as soon as devm_request_irq() is
> called. Initialize the driver lock before registering the handler so an
> early interrupt cannot use an uninitialized lock.

And what about all the _other_ data the handler unconditionally 
dereferences which is also still uninitialised at this point? If you 
think this (clearly theoretical) race is worth fixing then at least 
actually fix it...

Thanks,
Robin.

> Fixes: 2a96536e77b4 ("iommu/exynos: Add iommu driver for EXYNOS Platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Assisted-by: Codex:GPT-5
> ---
>   drivers/iommu/exynos-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 874d05f4b..e9feb83b3 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -735,6 +735,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   	if (!data)
>   		return -ENOMEM;
>   
> +	spin_lock_init(&data->lock);
> +
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	data->sfrbase = devm_ioremap_resource(dev, res);
>   	if (IS_ERR(data->sfrbase))
> @@ -773,7 +775,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   		return PTR_ERR(data->clk_master);
>   
>   	data->sysmmu = dev;
> -	spin_lock_init(&data->lock);
>   
>   	__sysmmu_get_version(data);
>   

