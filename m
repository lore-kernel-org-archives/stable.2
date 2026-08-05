Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3C40BCD4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926013; cv=none; b=NPtfiHpHiCJ2F/zCR6/YUQqvIs+6WhVgmsoAmVp2KssmEJD+TJeiqMBXdzMqkF0YxlgUUEUF8D54aR/ug0bTUXGFje3/Xq1nnUsR6sVvR8giSnE9r9tuFIjWTKQIj+iSm1MK/rSj6WcJaNPJ1lx7ZnzdHMdIm5arhlDiPOnBw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926013; c=relaxed/simple;
	bh=yoYA04IoQA7jbFUcBhNJH473za9qOl/7JYDPgFmVd04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/QhyLEEy8kvRH1y53K6fNNSm8ZfaFeK2krdY54HF0lYp+RTSW3I5+Y2uBSusLsl9FQxuQBhqpDZvnxzqgtXDCLVv4TttWQeJlXgCMf/Gx/U1ioh2XWEvYidCR/hniV/s3CKv8+1P/1hFDLHJnyI3KxDICexiSg6Aw+kgMfdFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQEydVBv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQEydVBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785926008; x=1817462008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yoYA04IoQA7jbFUcBhNJH473za9qOl/7JYDPgFmVd04=;
  b=GQEydVBvfyC4mZs5wkkiDYBZIPFTQCTDx79mtfm4uv58AmihPtd36ubj
   DXWccqu0hZbih1XRRSFNlvSztxn8AqVTGOoZSfy0YiYKNlPWsD2Zd4nFZ
   hyDO/xr8R/sFsMyLi62rqspwdomePN2QBfID3KFYAGvCs8hEnhKPnK9dR
   vFVG4txV5auDqqJ6WEwQFAJHM5n4GSL+tOLCLYE0z80WpSP1o5lgYnD/6
   znBOO5S6bxSOb/GGViFKPkp/wkHAgCp3PVAF2vw98unwKj8dtw4fyHf2g
   y4Ulih8lYKH6LzgbJBOcQ5MaQDkAAssniDs+5VW10n3o1AIcD4ou+UrC3
   w==;
X-CSE-ConnectionGUID: tIEK4+bORSy8N7aX3e/jgg==
X-CSE-MsgGUID: l2zQurywR1qUpLm/0s4mCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86506338"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86506338"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:33:27 -0700
X-CSE-ConnectionGUID: riTWNnL5QVSqPFmMdAuiCA==
X-CSE-MsgGUID: i4J5FhNQTWuJQdFMjyfKdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="263762317"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.90]) ([10.245.244.90])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:30:47 -0700
Message-ID: <88b53afb-d7c1-4da1-9708-d0843be27b6d@intel.com>
Date: Wed, 5 Aug 2026 11:30:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] drm/xe/guc_ads: allocate UM queues in a separate
 BO
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, stable@vger.kernel.org
References: <20260804165057.129529-1-jia.yao@intel.com>
 <20260804165057.129529-2-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260804165057.129529-2-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/08/2026 17:50, Jia Yao wrote:
> Move the UM queues into a dedicated UC BO (ads->um_queue_bo) and avoid
> CPU memset operations on it, which eliminates the CPU as a potential
> cacheline-polluting agent and helps maintain consistency between GAM
> writes and GuC reads.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

