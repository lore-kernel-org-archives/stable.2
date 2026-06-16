Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255B47AF5F;
	Tue, 16 Jun 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631884; cv=none; b=E1JTEROV4ydsqU7m5lahwMBkXBPUCmzB3ASKHTcBvqexBsuTGZ/zJgFeYFnR4URQ3468pjFEpxXEyCCL0F209+CTYkhjSEWBpi0xKVx4MukxStrIQdcWBKSoLFIYg1hIDHU+1cHibtvOo6E2VOXHcqHIPH/vxUBZF7EfyMFRzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631884; c=relaxed/simple;
	bh=PQA145YAA2CJZfOtrtPtkSQEG98dC0r4HRCTF/mgdjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcdPOBlNPlDVdWm4qofedNpZNYSS+TfrY84NXwvi2tQQNn15jW7TinNDzBUCyn87VRd3g2oFQ0IcVErpyS9A2VGW870YrT2xihcWfRWnWtTzXb2+TlfibVmJIFDYDRqAEJLny461Y9N9lzIOabcEk5EmdxgzJVNm35CAwxVZifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StKcjs5I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StKcjs5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781631882; x=1813167882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PQA145YAA2CJZfOtrtPtkSQEG98dC0r4HRCTF/mgdjc=;
  b=StKcjs5IG/IaKGzMI+JeQgQZlKWmOIPcJSQV5mSCyiwAenSxVdnKsccJ
   xGDpdhwUmsQq9K/KxEvwKUsUprzarkokG68kjLdIKFVID2wBdDXnILhUn
   k2lUooQCdfFN6Nk0inuSVYdyA9k40G6OsHaKr5SQ2uGPfv+rW2pUvHq0e
   eSriDmsA1Nxh3DSyZLi4orSNVjC23cXR+RlYpNUSGE4rfnFNHWKf68rtm
   rtSnTo6w5Jdna7TgahFRuv/VgsDwGV5VS2LK2hCx0qfGBvzijdCNiefLr
   uCgKZFOfDTjUMQ8A18d6kMJyAGHck5tbr4uau7sAwcV+ZDslw6Jav5htE
   A==;
X-CSE-ConnectionGUID: HOGDe5ykTn+lxdAQhjCmxg==
X-CSE-MsgGUID: qJgcM1a5TZ6H3lJK1QHmbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="84971395"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="84971395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 10:44:42 -0700
X-CSE-ConnectionGUID: EGu9RFbRTzqgHkXWAdaN6w==
X-CSE-MsgGUID: tLFRqi/tTci1/3FLRF0UZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="271908495"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.111.91]) ([10.125.111.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 10:44:40 -0700
Message-ID: <81f90f2e-a0df-483a-af25-7eac7a19049a@intel.com>
Date: Tue, 16 Jun 2026 10:44:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl/mce: Validate memdev and endpoint before
 dereference in cxl_handle_mce()
To: "Dan Williams (nvidia)" <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, flavien@nus.edu.sg, stable@vger.kernel.org
References: <20260616004007.4186004-1-dave.jiang@intel.com>
 <20260616004007.4186004-2-dave.jiang@intel.com>
 <6a318b25443ad_199fc4100b5@djbw-dev.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6a318b25443ad_199fc4100b5@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/16/26 10:43 AM, Dan Williams (nvidia) wrote:
> Dave Jiang wrote:
>> cxlmd and endpoint are both used in cxl_handle_mce() without proper
>> validation, which can lead to NULL pointer dereference or invalid pointer
>> dereference. The notifier is registered in cxl_memdev_state_create()
>> when the CXL PCI driver first binds, before the memdev is published and
>> before it is attached to a CXL topology.
>>
>> Add checks to cxlmd and endpoint to ensure they are valid before usage.
> 
> This looks to be trying to band-aid the original mistake of having
> cxl_memdev_state_create() register a region-relative callback.
> 
> Move the mce notifier registration to be per-region and all the lookup
> lifetime problems disappear.

ok that makes sense. 
