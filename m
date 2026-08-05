Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF651EB5FD;
	Wed,  5 Aug 2026 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896174; cv=none; b=NMrPIyIFyID1pzo6QyxP1m8FD+szISGBiKt6YzxFGG/+0oJ+IA/rY52D/AV1n3nPXUDVWCBysGAKx2gXl8Jd/IgnCf5wTNL2CeCGNhGYaSDGRyLYb5141ivxKU/7akbxQL6668bke+fbogktAcZddHNdgFyKQbDCyz0G+e0lNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896174; c=relaxed/simple;
	bh=gx+ozbkHg0bMbjBHtrMlE8b4iuAACO9T36WKHNTw804=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tL0Li+DMu1JDsfv13tMq2R/tCSEfo2/C1SRVTzR8mO3HihG52+4DZd7+Oy/aE5venqK+wi89OiqjTBUUhN0GP+okX6UHhzaFx+YlsHrh9yAhfqONP42yGICtNApsBGfaTTJHnOGQrsGnQNSnxgYZXpKfNq6Nl4kDgomI4maE21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDitu7Yu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDitu7Yu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785896172; x=1817432172;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gx+ozbkHg0bMbjBHtrMlE8b4iuAACO9T36WKHNTw804=;
  b=jDitu7YuxzaHPkPeiH4uvnmeejP0pC7uuHNN+/OVecKwb+IxEsB89NJg
   1Cqpj3d9f8/iCZZEHAdJH9V35hp8NwDIk+UhH/tNRLi3CuuCHZMPegzQc
   0vx8bL6CytTopFs4+ogDxJrilFRqecKqS6p+lCflk8nc2eHutBajyuJbk
   yLKZl3VuzuKlZr78/2r7Ivtn21p5BX+RDZczKEx0T5TLx/w6eWGuC3S36
   mKFcNGL/I2a3ZDhxtVtYfbw7iM2I5oCnUgTO6lIjD2JQShZX1Gy3HYjeS
   p30VhqMRSnzYsIAGQD4nWFo2rJNyvPnRJqXgiPpkpbxgB26h9SxJQEZb5
   g==;
X-CSE-ConnectionGUID: dY3XkKdlRdKUHDUVPR+4zg==
X-CSE-MsgGUID: xou/JQSwQPKEWV+GOHXe3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85583758"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85583758"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:16:11 -0700
X-CSE-ConnectionGUID: P2yhYWCiRTi4y89kNuExtw==
X-CSE-MsgGUID: xqYbJnNWRfei82kL0awjKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259013512"
Received: from unknown (HELO [10.238.0.222]) ([10.238.0.222])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:16:08 -0700
Message-ID: <d0dde845-15f5-4dac-af14-e8c770273ffe@linux.intel.com>
Date: Wed, 5 Aug 2026 10:16:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, jgg@ziepe.ca, akpm@linux-foundation.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 albinwyang@tencent.com
Subject: Re: [PATCH 6.6] iommu/sva: move x86 disable check before allocation
To: albin_yang@163.com, gregkh@linuxfoundation.org
References: <20260803114039.319953-1-albin_yang@163.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260803114039.319953-1-albin_yang@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/2026 7:40 PM, albin_yang@163.com wrote:
> From: Wei Yang <albinwyang@tencent.com>
> 
> Backport of commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is
> set") placed the IS_ENABLED(CONFIG_X86) early-return in
> iommu_sva_bind_device() after iommu_sva_alloc_pasid() and kzalloc(handle),
> while upstream puts it at the function start.
> 
> On x86 this leaks the kzalloc'd struct iommu_sva (early return skips
> kfree) and a globally allocated PASID (mm->pasid wrongly set, never
> unbound). Move the check before any allocation/side effect.
> 
> Fixes: 240cd7f2812c ("iommu: disable SVA when CONFIG_X86 is set")
> 
> Signed-off-by: Wei Yang <albinwyang@tencent.com>
> ---
> 
> This is a stable-only fix for the linux-6.6.y tree.
> 
> The buggy commit 240cd7f2812c ("iommu: disable SVA when CONFIG_X86 is set")
> is a backport of upstream commit 72f98ef9a4be ("iommu: disable SVA when
> CONFIG_X86 is set") to 6.6. The upstream version places the
> IS_ENABLED(CONFIG_X86) early-return at the start of iommu_sva_bind_device(),
> but the 6.6 backport placed it after iommu_sva_alloc_pasid() and
> kzalloc(handle), causing the leak described above. The upstream/mainline
> code is correct, so this fix is not needed there and only applies to 6.6.
> 
> Please double-check against upstream commit 72f98ef9a4be before applying.
> ---
>   drivers/iommu/iommu-sva.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 611733c02b7c..a340b805b82b 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -62,6 +62,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   	struct iommu_sva *handle;
>   	int ret;
>   
> +	if (IS_ENABLED(CONFIG_X86))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>   	/* Allocate mm->pasid if necessary. */
>   	ret = iommu_sva_alloc_pasid(mm, dev);
>   	if (ret)
> @@ -71,9 +74,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   	if (!handle)
>   		return ERR_PTR(-ENOMEM);
>   
> -	if (IS_ENABLED(CONFIG_X86))
> -		return ERR_PTR(-EOPNOTSUPP);
> -
>   	mutex_lock(&iommu_sva_lock);
>   	/* Search for an existing domain. */
>   	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
