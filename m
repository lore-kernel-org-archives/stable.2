Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1542047A
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353788; cv=none; b=h8S2hJhvf4zRoXbCjLyB7WOl4ZJXyrGzu+5pLhBiClqxQ5kY4UTxdBapq+aaEkQZM2K4dVG3Y7MhzSZ8Kj4bQMNQi6iRaf+CcIOokaCr997lMIB3wfvTSsQbKebt8z5n+psbjIeLlFWVWsderYgFRI0rJhkkk40PkESFq/lFe8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353788; c=relaxed/simple;
	bh=C6qCGI2qGA411Ng26vRIk9uX1jrnXdhCZkIQPAI9qZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxkNbBzRSB+clYBiFDoPiaUjSNo0xl0//Sp0w+CgSnkia6+QB3pl6dVH14Grh8PUpa2ICUV8ASpmUoCogBNtxVjJ4FHBuRueFFtXked9kuWJf6j0f9uISXNvMJqtylfcIEUTat5F2xt3Am2TtHA2ngFmmaty2Hqw715u2PO49ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMtVWZe+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMtVWZe+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788353787; x=1819889787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C6qCGI2qGA411Ng26vRIk9uX1jrnXdhCZkIQPAI9qZU=;
  b=mMtVWZe+JK023l1DHrtZL0K1AWOap4sCMWN7+EBfWFo6WVupz4RPIzjA
   YOa+eZscydBHyqB5rA9UeuJpu1lqaaPIaNjTKy8vPQaoYu6sR3Yv79hfg
   atHrjLgHhcnKft6Qne4NnGMF6QHRP3JCsTSvcXaGYiSgAStAHTlwwR/qK
   l2OrTDjstgUtXGY5bfUNLvfJ84aDA6FJeLzP99Ihr8Zdote182Dlb7lip
   HhYekhNedaZFst5p8zYrCO0hVWSA/Jff1Q57LHpTepeHvyU0rnDuHQvCr
   /G5nQnxiSNViW7eCG86VliG76JJ2bdwbsEiMRsYJV24fWC+vyG3ePfzSM
   w==;
X-CSE-ConnectionGUID: fjiuAiI5R6GQ0g+xgNjgvg==
X-CSE-MsgGUID: Qagv6kggSZy5SVSPUJ1qFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92512451"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92512451"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:56:14 -0700
X-CSE-ConnectionGUID: QK8/ntriSQaS2qlnJ8yzWg==
X-CSE-MsgGUID: Zx4kBWLoSvSzHx9aSw3ciQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="265100199"
Received: from kpleskax-mobl2.ger.corp.intel.com (HELO [10.94.252.39]) ([10.94.252.39])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:56:11 -0700
Message-ID: <7568b4e4-a71b-4f94-8e78-f9795c372ffc@linux.intel.com>
Date: Wed, 2 Sep 2026 14:56:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/ivpu: Validate full buffer range in
 ivpu_to_cpu_addr
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Magdalena Schulfer <magdalena.schulfer@intel.com>, stable@vger.kernel.org
References: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
 <20260901125749.404338-2-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260901125749.404338-2-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01-Sep-26 14:57, Dawid Osuchowski wrote:
> From: Magdalena Schulfer <magdalena.schulfer@intel.com>
> 
> Add a size parameter to ivpu_to_cpu_addr() and validate that the
> whole [vpu_addr, vpu_addr + size) range stays within the BO.
> 
> Cc: stable@vger.kernel.org
> Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
> Signed-off-by: Magdalena Schulfer <magdalena.schulfer@intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_gem.h | 14 +++++++++++---
>   drivers/accel/ivpu/ivpu_ipc.c |  7 ++++---
>   2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
> index 0c3350f22b55..b1ae020a4fc2 100644
> --- a/drivers/accel/ivpu/ivpu_gem.h
> +++ b/drivers/accel/ivpu/ivpu_gem.h
> @@ -87,15 +87,23 @@ static inline bool ivpu_bo_is_resident(struct ivpu_bo *bo)
>   	return !!bo->base.pages;
>   }
>   
> -static inline void *ivpu_to_cpu_addr(struct ivpu_bo *bo, u32 vpu_addr)
> +static inline void *ivpu_to_cpu_addr(struct ivpu_bo *bo, u64 vpu_addr, u64 size)
>   {
> +	u64 bo_size = ivpu_bo_size(bo);
> +	u64 offset;
> +
>   	if (vpu_addr < bo->vpu_addr)
>   		return NULL;
>   
> -	if (vpu_addr >= (bo->vpu_addr + ivpu_bo_size(bo)))
> +	if (size > bo_size)
> +		return NULL;
> +
> +	offset = vpu_addr - bo->vpu_addr;
> +
> +	if (offset > bo_size - size)
>   		return NULL;
>   
> -	return ivpu_bo_vaddr(bo) + (vpu_addr - bo->vpu_addr);
> +	return ivpu_bo_vaddr(bo) + offset;
>   }
>   
>   static inline u32 cpu_to_vpu_addr(struct ivpu_bo *bo, void *cpu_addr)
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index 978bc3d8704f..8f69fb133e2e 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -79,7 +79,7 @@ ivpu_ipc_tx_prepare(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>   		return -ENOMEM;
>   	}
>   
> -	tx_buf = ivpu_to_cpu_addr(ipc->mem_tx, tx_buf_vpu_addr);
> +	tx_buf = ivpu_to_cpu_addr(ipc->mem_tx, tx_buf_vpu_addr, sizeof(*tx_buf));
>   	if (drm_WARN_ON(&vdev->drm, !tx_buf)) {
>   		gen_pool_free(ipc->mm_tx, tx_buf_vpu_addr, sizeof(*tx_buf));
>   		return -EIO;
> @@ -420,7 +420,7 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
>   			return;
>   		}
>   
> -		ipc_hdr = ivpu_to_cpu_addr(ipc->mem_rx, vpu_addr);
> +		ipc_hdr = ivpu_to_cpu_addr(ipc->mem_rx, vpu_addr, sizeof(*ipc_hdr));
>   		if (!ipc_hdr) {
>   			ivpu_warn_ratelimited(vdev, "IPC msg 0x%x out of range\n", vpu_addr);
>   			continue;
> @@ -429,7 +429,8 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
>   
>   		jsm_msg = NULL;
>   		if (ipc_hdr->channel != IVPU_IPC_CHAN_BOOT_MSG) {
> -			jsm_msg = ivpu_to_cpu_addr(ipc->mem_rx, ipc_hdr->data_addr);
> +			jsm_msg = ivpu_to_cpu_addr(ipc->mem_rx, ipc_hdr->data_addr,
> +						   sizeof(*jsm_msg));
>   			if (!jsm_msg) {
>   				ivpu_warn_ratelimited(vdev, "JSM msg 0x%x out of range\n",
>   						      ipc_hdr->data_addr);
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
