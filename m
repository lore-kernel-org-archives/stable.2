Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB73346A0;
	Mon,  1 Jun 2026 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291584; cv=none; b=go+1Tv35nOyJfGeNd7jDniBEeJXI0cogYHMEGwB32G1saH01/Ke9NLZpCTEMCXuCLckjyfLvVOpA1L+aV5qOCigIBgzd+Bq8gECQUL2ZQMKCcvQ71gO5vFfo52OEzXZmJ5drsZ07+XmSBkR1RF817HltzQzH8HTGBVJuVbOk+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291584; c=relaxed/simple;
	bh=7Lno7VUT+W9NMyRxGJ35v8leg2gHPldFG6ujAfmnYzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rn8Q/ZV/WJ1A/MKbpr+JCBjYc61RSVEL5eJNjkCPTvE7CaTXNa02vOU9rZWaKwZQgw13ZBuGcj94LWm7MumTZMZty0TIFwoYZcT8GMJDJquKilhbASB+uGBBWxtVcETeMcqZoSlYchYAupXbXsJEGY4mNK6g72F1R4KDT8uRnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lECFPW16; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lECFPW16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780291583; x=1811827583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Lno7VUT+W9NMyRxGJ35v8leg2gHPldFG6ujAfmnYzk=;
  b=lECFPW16QGHKxiIt0H08J5AYTMvzjA6DshgLLTz9mSh7JHzXMIrJGPSj
   GO8wi8mEMBoqg0dtA8CzE0c8KEUt24OqYFAU3cC/L38NPjd38dQ917U+V
   BtywnlluJq2V+wDhe1iSTwXOJqAguCQrD1jMsG90yZE//hEAf1iwWqJA+
   Q7+AFmhM38yU9n95NmRX9l7HD1GSq8wSpZcDXpCz1uKOprETL50aUK80U
   TWCisQbnw34rOqJkBdEpMp7zG/OvrXRbTdYvnoeCG1yyxWwzcNB2zDKyt
   EQSdMtMrbH2JmeksbkFq99XsTAKmiK8sVjZhPZHRaK9ZmCh9g9y72adxS
   Q==;
X-CSE-ConnectionGUID: RCpdimDTSFiSzlQ/HsuODw==
X-CSE-MsgGUID: GmVRarupTNObKprNOCN0Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="68575624"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="68575624"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:26:23 -0700
X-CSE-ConnectionGUID: vaQiSiCGT+mrGjS1E/ejZw==
X-CSE-MsgGUID: K1ucyTREQ2qpeKq2ulR88Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="242412888"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:26:20 -0700
Message-ID: <b9696ee1-d502-463f-9925-f1a24fdcdbec@linux.intel.com>
Date: Mon, 1 Jun 2026 13:25:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Avoid WARNING in sva unbind path
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
References: <20260519052917.3729796-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260519052917.3729796-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 13:29, Lu Baolu wrote:
> The Intel IOMMU driver allows SVA on devices even if they do not support
> PCI/PRI. Commit 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when
> PRI is supported") modified the SVA bind path to allow this configuration
> by skipping IOPF enablement when PRI is missing. However, it failed to
> update the unbind path.
> 
> This creates an imbalance: the unbind path attempts to disable IOPF for
> a device that never had it enabled, triggering a WARNING in
> intel_iommu_disable_iopf():
> 
>   WARNING: drivers/iommu/intel/iommu.c:3475 at intel_iommu_disable_iopf+0x4f/0x90d
>   Call Trace:
>    <TASK>
>    blocking_domain_set_dev_pasid+0x50/0x70
>    iommu_detach_device_pasid+0x89/0xc0
>    iommu_sva_unbind_device+0x73/0x150
>    xe_vm_close_and_put+0x4d2/0x1200 [xe]
> 
> Fix this by bypassing IOPF operations for SVA domains on non-PRI hardware
> in both the bind and unbind paths.
> 
> Fixes: 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when PRI is supported")
> Cc:stable@vger.kernel.org
> Reported-by: Nareshkumar Gollakoti<naresh.kumar.g@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h | 11 +++++++++++
>   drivers/iommu/intel/svm.c   | 12 ++++--------
>   2 files changed, 15 insertions(+), 8 deletions(-)

Queued for linux-next.
