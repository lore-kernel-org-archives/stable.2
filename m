Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004901;
	b=VrFtNGZh0VM9IPqdLoyt6TNw5wF51iBUemFNBJP/s6kJ9o1Xk/PH6AZopljZOfWSDBvv
	 Q/4EAnj9ttazIH2aue6rTViD26oV2vn+H+ZYnuzHV4DkmpTH2TjExONXt5N//o+YqNaDK
	 aMXjewZLBbbvd5c/xNkGcaPtc1K7V6P2iAQp94BCl+XsBvDagOk4/Z1/Es2AhxcCg1ChW
	 KUVWhUNhvmbzxLj5cHBUYYG7o5OPm2Om2fy6LbbrMqSYE8a1sW9sW2a8X8WwvcStmwqB/
	 nvr80UTQ25w6oVrxXD1wO8YM51oPG1HyuPagLvD/2rE7Rk4kERnNjfSFo1t0BQsT9pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004901;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VmStxe3+tabZMwkcaP5qnKEOMdTvu6WflU0bEOf1Gt0=;
	b=kqvNGoO/MbDAm1HVguAE6yN2o8dBpXoLLL7mtHJoPpvrZaoFViuH+IyruXdwxcd0q3E6
	 /aQAlsOR4tc4OWUMvCjrWGfPD4ufb2n1hwa8Z+mV4Vk+1w8G6Li1A+tU0hbzRJYcH+/GN
	 N3UFXi6TT0X10Gcn2s2DHVx8SXPnPc4+93Rpg5vv9FgnC5uENxKyFkGzD6SWKyPaLXYq8
	 RkKNotMLiDhhiEG6TBo9YF2nqGlSj1keWkvF5zcIFsGOHF2l+pVtYOyz8i0x+LOGQ0GmM
	 GGGoO0zYEZks/Sw62DG4P3YgNBI1XerjhXNo1a8kKpnS0hDYcO2VaGncnnKsa+RRAAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AEhw4hZ8;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F48F606A333
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F48F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AEhw4hZ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795004901; x=1826540901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mc20LcFaf3kWRIkiRacLar+8BHTsGWeYePLFWeyR5Vg=;
  b=AEhw4hZ8glOYpIEVafD+cvb8sgLUeEu286Z8EEuvdBKzwzLrocm9ELBC
   cTAqdp/S5ajMWOj5UMm8iabQlVVdo6ol+t2vUECt7nvP9XPBKbXrL5u1V
   I59H6RTDRMtBKDM22hPyTaTgXS3rGuja1hUxn/N4TiJ95fvI1wQx9Lc2x
   3GHf9zLWPv7WPfT4kM/lQhfojVYaKKMfZ1qfxakpa0xbgYNEhwu0Lrjwf
   sK87RMdaPtbp/yitVdRbzx1jCQW05Dj1+WBsNq48P3tsTnxCrBREjxzPG
   UeZP95Lsytv9f4B850hFR7pk76z4HZ9kJAv7lCV4x2LMV1M6LP7w7erjm
   Q==;
X-CSE-ConnectionGUID: balgjO4ATdS3EM0bKGAeCA==
X-CSE-MsgGUID: Uhtvms9NRMuidSRBjiOreA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3825895"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3825895"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 04:28:21 -0800
X-CSE-ConnectionGUID: Ya8p6MlwTiuDQQA2IOFYmw==
X-CSE-MsgGUID: n6Ted8hGS8OT5ixoW5Mz4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10218657"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.244.206]) ([10.245.244.206])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 04:28:19 -0800
Message-ID: <9b3b3b18-27f4-4099-b495-1a44a77c00d9@intel.com>
Date: Wed, 18 Nov 2026 12:28:16 +0000
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
Subject: Re: [PATCH] drm/xe: Don't zap imported bo page-tables on L2 flush
 optimized hw
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20261118122011.487537-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261118122011.487537-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/11/2026 12:20, Thomas Hellström wrote:
> Invalidations of imported buffer objects originating from the dma-buf
> invalidate_mappings() callback may run without a runtime pm reference,
> and obtaining one from that context may not be possible. However, on
> L2 flush optimized hardware, xe_bo_trigger_rebind() would, also for
> non-fault-mode VMs, wait for idle and zap the page-tables and flush
> the TLB using xe_vm_invalidate_vma() in order to ensure the L2 cache
> is flushed.
> 
> For imported buffer objects this is not needed, since the vm_bind
> ioctl already restricts them to PAT indices that either ensure no
> data for their pages is kept cached in L2, or that are 2-way
> coherent, making a flush unnecessary. So, for non-fault-mode VMs,
> skip the invalidation for imported bos and rely on rebind on next
> exec, as is done on hardware that isn't L2 flush optimized.
> 
> The patch and changelog were prepared with the help of an LLM.
> 
> Fixes: 4e7ebff69aed ("drm/xe/xe3p_lpg: flush shrinker bo cachelines manually")
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v7.1+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

