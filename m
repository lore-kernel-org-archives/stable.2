Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908A4F3927
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615140; cv=none; b=nDm+1qiH8HoY0ypRRfDjQ8V2EwBZ8CLnK7hpXKNoYUScp6yxKpK1zDwEkOC9nOHa2oKK0gwOWpACVQJcuaSOsYCzl/B/ga+JbYFtvyAdm6QdpAdBvVriPC3rt2D9gzea6atiHbcTvIuP620Yz5uvabmjCzsz6LqQpfLGlXAGXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615140; c=relaxed/simple;
	bh=Q8tvAWP6jumWUL42nIbZpr65seFVkU5veTcSD+6xbwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nijyDX0Kq7GL8b29JsiXJzdd1xUMV0uppZz6wEaq5miYX/30gGjI6Syg9AFpRVC8Plp1BzXdxkbzud+IT2J0NVJ56moz/sYJBohI8TXkT+7nRw1MyqtQWTb3DWTtMlVganm+Lhpp0wlHxtQjUD96i42Hv39r4yJQ7dCI20+efQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wNNPIt+G; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNNPIt+G"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d8facae850so1895ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790615138; x=1791219938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ban7nhZo4CJqKpPDdVZLRncSMRaeOxomE1+tyNWWrJM=;
        b=wNNPIt+GFacoYBYtokoiLi8p4Rx7Kc3b2gWlOD3Pctgbr1UnbUYG8Vgsq8OeUJL4rZ
         yR5OYDQZ5uo21dKPw1NklErCJztdNF7l4vJeYOH5moiQt8EtnslvLbD5znYuD8YTnyUr
         HLz/svizdOKePgg3e0seT0DOZcdm81P94qo9W9wXNSlBLWXVRt+HMJnB9rvYwuDtmzyZ
         wa2lTOl8esGikAaLZ+INPepadooUX90atssLQLlf5kubSkRlTl9HFvCAFfxQqKL92Q5o
         kL+qzmmHPWCcguBIcXBlmahKzHMKh5O7tB2YVomj6A/PoN8ZtpNFI/LL4UZjEjG9ufWE
         zbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615138; x=1791219938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ban7nhZo4CJqKpPDdVZLRncSMRaeOxomE1+tyNWWrJM=;
        b=Fb3cF1CkcuUgBvGExeIYKOv/Yua1qTCCjtsmf2yj41vu8aDgqtCL5ZeBbenv/UF2tv
         LwJBQyfXzlhv359Fz1eiKhR0NO5dC+EQhQ5ovxk3JeooktMC05A8xYiLUikx4AYv/VpA
         aEUHWW/zv43aATXYi8y+e+H9mw+hqeIahB2q7BzuAdTC89q27vbJ0dYjRCoyKjnYYogu
         KmDCa6inAVvJxgQVLpPPA2DUG79Z+JGdleIGBk4UwcH9z9pHyvQOj6DRy4VqXlmrEl/+
         QFSHwPT65PHG2O//0fMjnbZOorIlMWpTkNMvq5lJ0i3kch7TyZnYnU3sUHvFF/fP4/BB
         PpHA==
X-Forwarded-Encrypted: i=1; AKwUvBxea7wbSN4nFGzutxsMMmnokI56MdL2RMtTkKYdEN0VHKprvdYvRqUewPMm3T5YQkUGn+BPc1w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLELLxZr7X4uQQ0ssp644r/FLDINWiMK4Mc6QWDHmb73JWZY93k
	Ov8gQOMsziDack9orALi6YGAFrnT7WbYIRj6kXzzLqX9rQ85AiPaRYCF/PW2ojcJAw==
X-Gm-Gg: AYBFou0hnYHuVQtGd3HVFEL90IOu4l7INSYh9rqGX3V/adXHFtiFmNmbtXuktG/Uzmg
	HFJFoDL4e3ozQUhyRmfnfRjbgo/nP77VA2CaWquYLZl32FZT8QzaSvyaVUZBO/GTFa5Jre+K4Sr
	Yi0cECxfgiLOK8jmxaOT/Jxddw+modXucWRyN4oK+E0yPjCH+0TI40GGtwd4uz64TyBSTG1KVk6
	uD6tLnlvM2V8YDqhsGKPSdSTKotTecX4RHMmHG6q/XuR7gVdmWVjHKkd8g4YqeRfXZgCbdn7ifL
	Ip7Va2tm/OUv4sXWTRAJoDsKAUR1hxL3CdadrmoH7ZWNsC4NtdyaAucbLdSNd0ojQJZSZADAoLv
	EuzIh8FNiWFImfoQoK/KbxdBSXstlD/4HscWXdufA5INfHVBmwTZZlchbCQ3lH/8irZ2RDAs3Ot
	m72/VzK452Ahv9dmZRO/TpROemgD8Ox88K9/qSmo0PAtsdF0AJzuOO5eMsHCSl2UM9NvhbcNDl7
	oMkkdauDmvpKA9TS9isZa/V07vYK5+3uSsu
X-Received: by 2002:a17:903:1aa3:b0:2d5:db38:800f with SMTP id d9443c01a7336-2dfa6227507mr8287085ad.14.1790615137568;
        Mon, 28 Sep 2026 10:05:37 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142b00dsm45359075ad.49.2026.09.28.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:05:37 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:05:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 7/9] iommu/arm-smmu-v3: Populate the tlbi at the top
 of the call chain
Message-ID: <arqeWXL1jhz9R9-j@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <7-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:15PM -0300, Jason Gunthorpe wrote:
> Each of these have their own unique situation, populate the tlbi right at
> the top and pass it into arm_smmu_domain_inv_range(). They will diverge
> further when the iommupt invalidation scheme is introduced.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 21 ++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 54 ++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 15 ++++--
>  3 files changed, 51 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 2f76f649dcf1a5..faeec656da9e7f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -140,16 +140,19 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  {
>  	struct arm_smmu_domain *smmu_domain =
>  		container_of(mn, struct arm_smmu_domain, mmu_notifier);
> -	size_t size;
> +	struct arm_smmu_tlbi tlbi = {
> +		.tgsz_lg2 = smmu_domain->tgsz_lg2,
> +		.iova = start,
> +		/*
> +		 * The mm_types defines vm_end as the first byte after the end
> +		 * address, different from IOMMU subsystem using the last
> +		 * address of an address range.
> +		 */
> +		.size = end - start,
> +		.iopte_size = PAGE_SIZE,
> +	};
>  
> -	/*
> -	 * The mm_types defines vm_end as the first byte after the end address,
> -	 * different from IOMMU subsystem using the last address of an address
> -	 * range. So do a simple translation here by calculating size correctly.
> -	 */
> -	size = end - start;
> -
> -	arm_smmu_domain_inv_range(smmu_domain, start, size, PAGE_SIZE, false);
> +	arm_smmu_domain_tlbi(&tlbi, smmu_domain);
>  }
>  
>  static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b7c9cd074924e4..4062ef2e13fe30 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2801,25 +2801,13 @@ static void arm_smmu_domain_tlbi_inv(struct arm_smmu_tlbi *tlbi,
>  	}
>  }
>  
> -void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
> -			       unsigned long iova, size_t size,
> -			       unsigned int granule, bool leaf)
> +void arm_smmu_domain_tlbi(struct arm_smmu_tlbi *tlbi,
> +			  struct arm_smmu_domain *smmu_domain)

A caller re-using the tlbi would overflow the 2-entry range.cmds[], since
num_cmds is never reset or checked. Should we sanity check num_cmds here?

Otherwise,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
