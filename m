Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B473EDE63
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805789; cv=none; b=Xps3urygTYtpe2XxwYHudjeXT9WqwJ7LsaJTqh8cObqEJ2bFEUZ7QMRUG762b60R/pqOkaXDiPd5I+gxaetO0B5nbvDVrz862+jf4amYLvmgeZVxQMK8jhbJScTLd8038KG43Xnn7UDbDzgdA/WaUuBLymDSKwWOEksX1sKqNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805789; c=relaxed/simple;
	bh=SzR/0OEPKvCkiPLjKNVIAPDqQySrUHKMnRI7BY//8c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fz6eg8zTBnwTqa3RnXOhFCdUTTme4e54Vu0uZeCUPBigTwyo3M3lvJqtXrZBPLTgDH1DB2+NpHu4Ek3FBfLd2iXDL0G8IGm9fATtJfnhjGCHDuQaCVC+H4KGxgnejih0JFnBEKbLwXZExrAJB8hqZsjKuNEf2jtEvDMsTnlbkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGDxpVys; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGDxpVys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782805788; x=1814341788;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SzR/0OEPKvCkiPLjKNVIAPDqQySrUHKMnRI7BY//8c0=;
  b=ZGDxpVysaxk1bzMJu0A45QG8UGHQnoJbIrwr7LcvI4xrF0aeyjzpanrr
   O+LMGQ3wBcczf+R6dvNAPUvuILimlhMyUSfK9XtYohO5LpFdkWp+AXCoQ
   iN+68+vSjaD+ALGM8xku7YZjCOp6yoks1IjhEzBx0Zfp7i3DK4LvjWCjA
   kxKHfa97Xy3uB0H4AsumPgRB6s/FC/hW/CO2vhBVaOrdbp6IiZkdH0ThX
   8q6r8kO67nYIDtxraZg9uyj9p8BdgZmTDCWoCp+0LZB4aPNCpEiPjSN4A
   KsifbXUOQbUKdYDMEINpqV/Mu37Sf3vzOU1uVw8gbE8dCaO3lIYmYygLv
   w==;
X-CSE-ConnectionGUID: ASNJftBPSWOF52Bn9kUnYQ==
X-CSE-MsgGUID: tipZJJmlSSGNiYA8KnmJ/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="93867458"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="93867458"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 00:49:47 -0700
X-CSE-ConnectionGUID: SUq535XNSge/UOs+cDtg2Q==
X-CSE-MsgGUID: n9x3qRPTSqyRSIEK5sp1jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="252332480"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 00:49:46 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: Martin Hodo <martin.hodo@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/vrr: require valid min/max vfreq for VRR
In-Reply-To: <10218b5f-6720-4517-abf0-2ab7e8d4c9c6@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625131040.1051272-1-jani.nikula@intel.com>
 <10218b5f-6720-4517-abf0-2ab7e8d4c9c6@intel.com>
Date: Tue, 30 Jun 2026 10:49:23 +0300
Message-ID: <4056174972373bd293c34c2813967f2165056b11@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 26 Jun 2026, "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com> wrote:
> On 6/25/2026 6:40 PM, Jani Nikula wrote:
>> Ensure the EDID provided min/max vfreq are valid. Most scenarios are
>> already covered (by coincidence) through the checks in
>> intel_vrr_is_capable() and intel_vrr_is_in_range(), but be more explicit
>> about it. At worst, a zero min_vfreq could lead to a division by zero in
>> intel_vrr_compute_vmax().
>>
>> Discovered using AI-assisted static analysis confirmed by Intel Product
>> Security.
>>
>> Reported-by: Martin Hodo <martin.hodo@intel.com>
>> Fixes: 117cd09ba528 ("drm/i915/display/dp: Compute VRR state in atomic_check")
>> Cc: <stable@vger.kernel.org> # v5.12+
>> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Makes sense.
>
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

Thanks for the review, pushed to drm-intel-next.

BR,
Jani.

>
>> ---
>>   drivers/gpu/drm/i915/display/intel_vrr.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
>> index 5d9b11185296..bffbdee76ee1 100644
>> --- a/drivers/gpu/drm/i915/display/intel_vrr.c
>> +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
>> @@ -76,6 +76,10 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
>>   		return false;
>>   	}
>>   
>> +	if (!info->monitor_range.min_vfreq || !info->monitor_range.max_vfreq ||
>> +	    info->monitor_range.min_vfreq > info->monitor_range.max_vfreq)
>> +		return false;
>> +
>>   	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
>>   }
>>   

-- 
Jani Nikula, Intel
