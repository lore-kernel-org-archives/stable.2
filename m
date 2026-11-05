Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916090;
	b=26FqR4nuPG/IVHSZe1DRNRMdJktqTMzsuAyuGCmZ578NtpOzyFW75Fe03Shmfm0BUa1N
	 tPM0A+b0O2WVCnkLnS+jkxcjwWwMyoLhf09SHUa62uD0dkKjIC9VkBLPvNNrWN2SY8vKq
	 IJvSCFoY2SZGmelLc4PjeGigx4/9FfgrirdO78S/6gZL4RitKbJ9vDH2eb9s25kXLmS4p
	 1SVDvFXk+MfDEYKOYacwL3Yf+VL942vHWuHwjsKfpb5odWnE+pO7BmQzHmWpQvTEcN5xX
	 qyEDe2vBQrgO87w2Nin2Nb9yQUnOfxwsMLB5hzJsKotNQm86CopaNR4tjoWlwpM/QWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916090;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=12xL8wyYYpPO9OJrv+WZpz6rGwzL1hqdDd1Wt9qoJYk=;
	b=NadwWHpo+PgUQWTkc+gd1R6fb7QlFVkKaDapB9pRRoSvp3ohvt50wsxKj2SpYtNNUz8W
	 fq9cXdRccr9AQ0ohjFSbVsRQvJMQdbR+CPQ2zH1Oc0/BduHmzXPiKEfzdgWTBlKl6oHOf
	 4XBwloxEveJz41x6KoxWjpVSPDlzcmQaYp+gAz4JEc+Px8RBKwNSAPEyvrZbcDpZxEli3
	 xW3KfFSrSf1HpGztxFA1ocltJzbMY1fwYuAjoBhiG+Ao22bTWz+bcAqpZqXkmk/kybhJB
	 W6lSBlGY0OtTETYouv5XuknkJdBprRsupHmVLs+LJhBn/IVH+vrnmXeZ/pmH17VPhrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V++ivCoO;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE1606A328;
	Thu,  5 Nov 2026 22:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28DE1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V++ivCoO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793916091; x=1825452091;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9+ryHHKJPD2rME9UCeDN6voKQm2+c7EVnxxDUlVg3fo=;
  b=V++ivCoOuHDulTirAndmr4cV0gLMAhGugq9pDvMc5th+6GHifUI4iyo6
   rztbn7QY+NzCUZa87+5pr+V2KZlQxcUzGG1D4DNhvBqiK8QxvpQu9xAjK
   pvPc89O0VSowQoChd4QbOjrQhgI6T3de1/aE+OUF5ueo5qoJpTPfH9pgl
   7XmzAbQNVhnLjyFB5EifrzICQkHqMdQOyWzm6uNZF++nnBI7YUMtiDpz2
   Bj/MFQTv7EvD19+ydGoaNFmBKcyLGyaCG7DoCrV/uyhT1mRbIiKmWktUA
   MIc2HE6QnWnqKdBzx49er5D0SxTgkUnRXyj/OHkp4B/Of0FaGu453Ebze
   A==;
X-CSE-ConnectionGUID: CAlzlrKQSk67f9IeefVh/A==
X-CSE-MsgGUID: +OxbLPOuSHCWwbrpZcrS+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2628190"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2628190"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 14:01:29 -0800
X-CSE-ConnectionGUID: fSPToNUxR1GOu0DVMInCZg==
X-CSE-MsgGUID: 0zxuagbKQii9PNiPQLDvLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7681814"
Received: from vcostago-desk.jf.intel.com (HELO vcostago-desk) ([10.98.24.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 14:01:29 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Lu Baolu
 <baolu.lu@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Set FPD when tearing down a PASID entry
 with fault_ignore
In-Reply-To: <20261104051059.1345010-2-baolu.lu@linux.intel.com>
References: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
 <20261104051059.1345010-2-baolu.lu@linux.intel.com>
Date: Thu, 05 Nov 2026 14:01:28 -0800
Message-ID: <87o6c3uedj.fsf@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Lu Baolu <baolu.lu@linux.intel.com> writes:

>  static void
>  pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>  				    u16 did, u32 pasid)
> @@ -253,7 +238,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>  
>  	if (!pasid_pte_is_present(pte)) {
>  		if (!pasid_pte_is_fault_disabled(pte)) {
> -			WARN_ON(READ_ONCE(pte->val[0]) != 0);
>  			spin_unlock(&iommu->lock);
>  			return;
>  		}
> @@ -266,6 +250,8 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>  		 */
>  		pasid_clear_entry(pte);
>  		spin_unlock(&iommu->lock);
> +		if (!ecap_coherent(iommu->ecap))
> +			clflush_cache_range(pte, sizeof(*pte));
>  		intel_iommu_drain_pasid_prq(dev, pasid);
>

I think it's worth documenting in the commit message why both of these
are needed, removing the warning and adding the flush.


Cheers,
-- 
Vinicius
