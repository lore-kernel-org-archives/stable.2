Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890FA1B652E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056968; cv=none; b=YybDCHKZTgID60rp7XWN6Qh5HW35x97VYn2Yd+GAMsSYaOxZBM+ZB/gwzyhExed3myljdqHBVqeUyc9m4UDdABzdkmfXobVGTmyLn9Q6Owjh2+N24gblscTVVzCgss8QciiTJx6QroNHPcIjR+PgKIqg45Tj2PwZlqWZuO9hlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056968; c=relaxed/simple;
	bh=kGrUP8lQtbXqNkfszgaCdmZayGooSU84mNcC1IzyPvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eE4zStg3Rs5LTqDH3XUxgFcpFh2BrA5SHGMMP9LrrQXO8pMXa7Bzy6iNdsYS2NwOQMPzF3Mt12YvzGCYrJGmAe2Jw/IosWLtBncW/cq1iWTkQGJLaLP27lq7xRAJ3LHwiX156L3FgrWWqP8KfgwhX0yYtLEpKO5DFQjjBxaRL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKFWodGF; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKFWodGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790056967; x=1821592967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kGrUP8lQtbXqNkfszgaCdmZayGooSU84mNcC1IzyPvQ=;
  b=WKFWodGFr9hwb8fMuC5QFy59pUh62BGViSiN17VE3rSzrDQj8P5fRpDI
   1vHPcSsRYf//CCDxC7gZmv2OpKGBau2ujp/uEX8P/KQ1GM3TcUyh+Mgs7
   Mae7Y4awdvjfOMH7e1EWtTKtXqltkaUb9RsdTmiiVAl0P9FFhfhrdGmPI
   ZM67RIQLwT6CuV/Xbx6mcu4bOUjTtVhI0WDUYGUvnlU0Ulbp7BS8NPMo8
   K+yUqr+srGOYxDy1UAhBRAtCYp/x1CjOKxRwf6fxgBGCcfbr4R9rKIynp
   OcetRgFQtp3aDyNdsOMlWZPGBkLTIRDDX1cuH+xNHYfadcwOf36VeS5WK
   Q==;
X-CSE-ConnectionGUID: Ob/rB1g4TDqVX23K3Sl5bg==
X-CSE-MsgGUID: MVkvr99vTCiN1vYwcri9hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1134727"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1134727"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:02:46 -0700
X-CSE-ConnectionGUID: uP2g1mAtS5W8rKM5ycBvjQ==
X-CSE-MsgGUID: j/2Iqo2cQYiYzRmpQt/klg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272182660"
Received: from jfedorov-mobl2.ccr.corp.intel.com (HELO [10.245.80.122]) ([10.245.80.122])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:02:42 -0700
Message-ID: <10240e7e-858b-4283-b7cb-d4af2459a341@linux.intel.com>
Date: Tue, 22 Sep 2026 08:02:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Use separate flag for job timeout
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, Jakub Pawlak <jakub.pawlak@intel.com>,
 stable@vger.kernel.org
References: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
 <ac09bf4a-2b65-421a-a5f6-87c5a89ba734@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <ac09bf4a-2b65-421a-a5f6-87c5a89ba734@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21-Sep-26 16:56, Dawid Osuchowski wrote:
> On 2026-09-14 10:43 AM, Karol Wachowski wrote:
>> From: Jakub Pawlak <jakub.pawlak@intel.com>
>>
>> Use separate flag to mark a job timeout as a reason
>> of starting context_abort_work. This allows to distinguish
>> engine reset reason and clearly adjust reset procedure flow.
>>
>> The flag is cleared in ivpu_prepare_for_reset(), which every
>> recovery and suspend path already funnels through, so that the
>> state is clean after recovery.
>>
>> Cc: <stable@vger.kernel.org> # v7.1+
>> Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of 
>> device recovery on TDR")
> 
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks, applied to drm-misc-fixes.

> 
>> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>> Changes in v2:
>>   - add Cc: tag
>>   - link to v1: https://lore.kernel.org/dri- 
>> devel/20260914082800.892044-1-karol.wachowski@linux.intel.com/T/#u
>> ---
>>   drivers/accel/ivpu/ivpu_drv.c | 3 ++-
>>   drivers/accel/ivpu/ivpu_drv.h | 2 +-
>>   drivers/accel/ivpu/ivpu_job.c | 7 +++----
>>   drivers/accel/ivpu/ivpu_mmu.c | 1 -
>>   drivers/accel/ivpu/ivpu_pm.c  | 1 +
>>   5 files changed, 7 insertions(+), 7 deletions(-)
> 

