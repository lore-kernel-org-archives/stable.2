Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F444ACC69
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003005; cv=none; b=IOp8K6iKxq6dhAbpjw5zl4HpFUfu9Mu//9wFPo8XKVGFUDk8HbA6Xo1z4NfCTKnb+Z0qrboagdZQsPNTOaQIwQxVefWpxXLoDVVHbosWNWAtGP7l1Sx2sLV1oDNMbzt1Gd3ZLdeW8U5PmHaIga5gSKtovtTZvz44woAGQTw22CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003005; c=relaxed/simple;
	bh=IbeDwZ+7oz9OB+PaSKVwiska41rwL948uzX5PD1ESew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmOcYVJnkBljNPAPkIs4wu6Nw42q+HEHjHBevKb88aLsiCDwfwhUiZAWU0HBwSC3xYRGS/GJfoS8N0EUYWWMj4dCU3msDrMIQI1MDxKokqg8WYggYiOKS2n7GajU7oIYDZTLke93DmJ/kREsi81760DefkhYMhu6hDLx1QD1UKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4E3DtfF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4E3DtfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790003003; x=1821539003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IbeDwZ+7oz9OB+PaSKVwiska41rwL948uzX5PD1ESew=;
  b=S4E3DtfFGzoSNUjFmDedNjTHDX6dtXiunws1U41RFTi3GJUxI/1yQjGH
   wu1pwMu87lrZRJr0vZMUDNVUmtp9dTYvx+ZibjDze6wdTRTOMGmITgF/E
   C4mKrwwP1J7ODAxrCpWC6AEB7xXXqLXWB/G9K1sSXdGeJxECIewqhTXuC
   ak37iGt8N+jgdxQrn1Kq3UABygAaqs6clAQhKmGucbBoAoHDWx1/i/fhC
   Smi0T2qGouAP3GA0YmG7fEiRO4yFUYzmzDPPT68yIyZuWOJUUmwHFvbb6
   ChVV9pTVgXBrWx1czxUmPqokuBL0LmBDJheyPdk63qJh1nW2ZseQpK26Z
   w==;
X-CSE-ConnectionGUID: 3y6MXqtFT/2hSsQPeHuwIw==
X-CSE-MsgGUID: DEaL4nJnQw+RkV0Cuv7iTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90390345"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90390345"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:56:28 -0700
X-CSE-ConnectionGUID: xMT0kHaQTQyFmtHCXQakDA==
X-CSE-MsgGUID: QPCnh7EXTtiC7vJpJiW+Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3985532"
Received: from eoghanoc-mobl1.ger.corp.intel.com (HELO [10.245.112.245]) ([10.245.112.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:56:26 -0700
Message-ID: <ac09bf4a-2b65-421a-a5f6-87c5a89ba734@linux.intel.com>
Date: Mon, 21 Sep 2026 16:56:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Use separate flag for job timeout
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, Jakub Pawlak <jakub.pawlak@intel.com>,
 stable@vger.kernel.org
References: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-14 10:43 AM, Karol Wachowski wrote:
> From: Jakub Pawlak <jakub.pawlak@intel.com>
> 
> Use separate flag to mark a job timeout as a reason
> of starting context_abort_work. This allows to distinguish
> engine reset reason and clearly adjust reset procedure flow.
> 
> The flag is cleared in ivpu_prepare_for_reset(), which every
> recovery and suspend path already funnels through, so that the
> state is clean after recovery.
> 
> Cc: <stable@vger.kernel.org> # v7.1+
> Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of device recovery on TDR")

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
> Changes in v2:
>   - add Cc: tag
>   - link to v1: https://lore.kernel.org/dri-devel/20260914082800.892044-1-karol.wachowski@linux.intel.com/T/#u
> ---
>   drivers/accel/ivpu/ivpu_drv.c | 3 ++-
>   drivers/accel/ivpu/ivpu_drv.h | 2 +-
>   drivers/accel/ivpu/ivpu_job.c | 7 +++----
>   drivers/accel/ivpu/ivpu_mmu.c | 1 -
>   drivers/accel/ivpu/ivpu_pm.c  | 1 +
>   5 files changed, 7 insertions(+), 7 deletions(-)


