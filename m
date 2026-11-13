Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579918;
	b=fbzU/UM6ia/wMPi5xdjImuuJVPGWTbTByS10re25tszlA9Vt/FOPj5Y2ks9do2j9XknU
	 hHPido4de/V49pLjAk+JkadpMvL4kQ0J06kia/RSJYhyy5NHUndE1ppU1mfyM5C10pt7m
	 F5H6f0dujMqIKRQfN1QbiHVu4D55MN2+ln4t+HoLMe/MBSOdJZMiyQBmieraMLcdjtNVC
	 DHT/lTGuvQUQT9pWns1Eu0vEWFxEbidhy52xpO6Lkf58GAD5ppL59X9hg7kk5cSsvGnNu
	 dDdU/cUEYWROWpjMzokHtCEkDaeLwEqxKdsuj3XuKR3S9o/1+fVt6IK+pxhf2+5dR7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579918;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cD+8/5j+s80eXxUWU3uswy7ltU7dsR22ebHIT3y7IeA=;
	b=sKSrqaFlZGl54Jjo43Yt42B5mpx8rs3mtZ0lzsVr77qr91t7ccXSeFg19nvqTN3ok0Cr
	 3ka6+zZ7L0QpJplsTW1OWWuVtX5Hex5sludGlzK3DAK6xyh4mckzyh8dREzaPlxYzeSd4
	 prN0R8nT/RO01IPoHbWGIaExDciMO1Fk0qe4kmqL/WZR7tBIcFRDwVb5VZ0nrCQpVKOmV
	 p/uq+sBV2TFuyH7+3cB2uH9u93iXaHltlaWrWQy9pD9eHbuE8zoaja6YYspQGrO/QDhIK
	 fN9kCO9w7d9b5RPysPyDUk3zGBEEEpelMg8hmZ3E5gLNyxy0/hM6fq1movGPaATo6xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KcXNQDQg;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165BC606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 165BC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KcXNQDQg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46CAA1477;
	Fri, 13 Nov 2026 06:25:13 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B80923F673;
	Fri, 13 Nov 2026 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794579916; bh=2j0QxDICHFIrkIIaIGMOtDjYnIsF+/h7KJXUYkgtaa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KcXNQDQgaYlnW5VwSqFDL0rxmzSnh6kL7DAxuZqBPfxa63nRZ7OqbRTHRZm8wd0x3
	 NYVcaN+eEQxg913DUTM4VclSV8tWfquXGIC06dr8lEI+EBCSpN+Ho057ykpTKQDSK7
	 fHFu8ruVekJXY4bq/fugpTzqPLhfxEcSI1Qzp/7E=
Message-ID: <e2158cb0-e8e3-4dba-9015-51e4cd47f57a@arm.com>
Date: Fri, 13 Nov 2026 14:25:14 +0000
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
Subject: Re: [PATCH 5.10.y 1/2] iommu/virtio: Clean up bus_set_iommu()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <jroedel@suse.de>
References: <20261109202719-failed-5.10-1f8efac19a08@kernel.org>
 <20261113033251.1042335-1-sashal@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261113033251.1042335-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2026 3:33 am, Sasha Levin wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> [ Upstream commit 19d3607c74bc0332f0ee3a2d54ead6e792c0dce9 ]
> 
> Stop calling bus_set_iommu() since it's now unnecessary, and simplify
> the probe failure path accordingly.

Wait, no - that "now unnecessary" is only in the context of that entire 
patch series (in the link), which was a fairly significant 
subsystem-level redesign not suitable for backporting. Applying this 
patch on its own will just completely break this driver.

Thanks,
Robin.

> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Link: https://lore.kernel.org/r/0ff6f9166081724510e6772e43d45b317cab8c58.1660572783.git.robin.murphy@arm.com
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Stable-dep-of: 1f8efac19a08 ("iommu/virtio: Reset device before deleting virtqueues on probe failure")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/iommu/virtio-iommu.c | 25 -------------------------
>   1 file changed, 25 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 81dea4caf561f..0aeed650f5366 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -7,7 +7,6 @@
>   
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
> -#include <linux/amba/bus.h>
>   #include <linux/delay.h>
>   #include <linux/dma-iommu.h>
>   #include <linux/freezer.h>
> @@ -17,7 +16,6 @@
>   #include <linux/of_iommu.h>
>   #include <linux/of_platform.h>
>   #include <linux/pci.h>
> -#include <linux/platform_device.h>
>   #include <linux/virtio.h>
>   #include <linux/virtio_config.h>
>   #include <linux/virtio_ids.h>
> @@ -1070,26 +1068,6 @@ static int viommu_probe(struct virtio_device *vdev)
>   
>   	iommu_device_register(&viommu->iommu);
>   
> -#ifdef CONFIG_PCI
> -	if (pci_bus_type.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -#endif
> -#ifdef CONFIG_ARM_AMBA
> -	if (amba_bustype.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&amba_bustype, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -#endif
> -	if (platform_bus_type.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&platform_bus_type, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -
>   	vdev->priv = viommu;
>   
>   	dev_info(dev, "input address: %u bits\n",
> @@ -1098,9 +1076,6 @@ static int viommu_probe(struct virtio_device *vdev)
>   
>   	return 0;
>   
> -err_unregister:
> -	iommu_device_sysfs_remove(&viommu->iommu);
> -	iommu_device_unregister(&viommu->iommu);
>   err_free_vqs:
>   	vdev->config->del_vqs(vdev);
>   

