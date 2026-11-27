Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787454;
	b=S47t3LZumjb0KyltgO11T8GHHLt13bhF3lP46NBvBb1u2cUd5Fg3JOES5IChZX0HUkQI
	 lMZeL7qpNZSVHxF1N+VYSSV91uaSYJJhg3kSnmTAe/ZlYDgOkDs0+4csA6+xlMJ3USw/f
	 EdI6bsyAMq8r3wyQXkJ4n6bO5AKnPDOwrx2s08xnehtiQ7sFckpEXqAW++grZGk6RXfqd
	 QAQGKVuVfmNCDRJrzCsxemM4NI3EFvz5JRJUMMTy/QoDX1nc6MbtWdR+upcZEHk6BbYFX
	 OTL6W/WcFVcHA3sJxykkrdEoY9SrC2n+O+OdMDS0IzFKVC1Lc5jVmBr0t95hXv0dx7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787454;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=W2BLdFCLXqqGzqgzzWL5ZjqtGuQVWcPcrvfmmj2AsEQ=;
	b=jKqSI4oDVoEP3hKqb7sY+V3Nn8c1QzS7BW2yfhNWquC/+qCX4hcC1tY6F/86JUfeJ1bm
	 G7Zcm88NLFQMBmCLWS9AhKHf2a0Hpqj5gaHGxPc2Exzbe5+cr/DYwePjl1WHCrZjnQggN
	 IbAuyH614gqyMmuoVw55l+4DDz1CSAgucJbIJEuoDz9s4SVY6u+laEBjQAHKM048ALBib
	 4rKEEp+NPNJZnKn7TnWR6Zs4VYraQVdun+xD239wuW/cl9K8FNsJxZXrtBBR8hh+Zsn2f
	 jV75zhBQcILna7bRWkLM4mT2cQlyixDgJ+90MLABBIkqTzlNpd94DRT9m/TZ05KtHMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G2i4MnW1;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93859606A31C;
	Fri, 27 Nov 2026 13:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93859606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G2i4MnW1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA5871570;
	Fri, 27 Nov 2026 05:50:49 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490133F632;
	Fri, 27 Nov 2026 05:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795787452; bh=InPRxVzDI2vjxwZEavNbuf666pud9/KmCUGG5pDASzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G2i4MnW1cdxQ9bbPd/ojeNKVpcA7dVi9RkhkGSConJ8BzgFbXeYBGNRCBGuwf61lU
	 ml0Lv82yEpVRg8e98RuLOswk6aoe1ZcEsrq2/a6sLK2R1Lphdv7Se62lzsAVVbdfBR
	 NuR2cdtvGeeGB+KPF3cGWTNfPUOmOQZ8f7D+YShI=
Message-ID: <f789bb4c-ad5c-455a-a51d-fc9fe67b1d13@arm.com>
Date: Fri, 27 Nov 2026 13:50:38 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/exynos: Disable runtime PM on registration failure
To: Zhiqi Zhang <zhiqizhangg@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 stable@vger.kernel.org
References: <20261126045203.62181-1-zhiqizhangg@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261126045203.62181-1-zhiqizhangg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2026 4:52 am, Zhiqi Zhang wrote:
> exynos_sysmmu_probe() enables runtime PM and then registers the SysMMU
> with the IOMMU core. If iommu_device_register() fails, the error path
> currently only removes the sysfs entry before returning.
> 
> That leaves runtime PM enabled for a device whose probe failed.

If that matters, then wouldn't the same theoretical reasoning also still 
apply to module removal after a successful probe?

> The same
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
> ---
>   drivers/iommu/exynos-iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 7c337ba96..18a536008 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -844,10 +844,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   
>   	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
>   	if (ret)
> -		goto err_dma_set_mask;
> +		goto err_iommu_register;
>   
>   	return 0;
>   
> +err_iommu_register:
> +	pm_runtime_disable(dev);
> +	if (dma_dev == &pdev->dev)
> +		dma_dev = NULL;

But what about other IOMMU instances that could have probed in parallel 
and already observed dma_dev to be set? Sure the existing code is not 
perfectly race-free to begin with, but this only makes the issue much 
more obviously worse.

Thanks,
Robin.

>   err_dma_set_mask:
>   	iommu_device_sysfs_remove(&data->iommu);
>   	return ret;
> 
> base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838

