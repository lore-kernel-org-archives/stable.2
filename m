Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ECD3F0747
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722224; cv=none; b=QU5py+Lttq3SrQQfEaETwqZU24K5Fp69Z/d7qetbGR6+6nO9UthNaPxTNbA7LTAfHBXaKEEhsy6+h0HzapyubZyMeQsAoFzQpH2bWm05+UYjaKv2mIjRmtlfpjJgqX0mIicDigfJeUTKBZJBn9fmaKNSRGz7T+KdWxENFczKP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722224; c=relaxed/simple;
	bh=yW4rE5Zr+InFVrJyY8OysXZwP625ZaE3tG8JAi/w1KE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YfsL/r5wSOGVDJwmHHHq/jFb4M706Tg8dxe4k3Lk2gnDOJ6N+6Ti8EaUc5ot0dOcDVPV9P3IgDRxpwBxDmpUKFcBJYkm7QuK21KhWWZEX0Pi9R7xvhfQ0sOsEDlYDY5wuWchkhPrywHHiwWVQgtSmG1SoUlVO34lx7xjVwvOhB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOUnnggC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOUnnggC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782722221; x=1814258221;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yW4rE5Zr+InFVrJyY8OysXZwP625ZaE3tG8JAi/w1KE=;
  b=JOUnnggC8fER4tptQj39CIdRUiQj6cqwdUtwIKFXLQBZ1SOGNP/Du0Gw
   rBB3lsxr+yWsOHeawWazRYylwOZWgxcccExLXWnJV/Sey4aaHvIPCRzSq
   g37c2q0H7f3stZ3ba751vDPu/O9QJRFGO+SDOMZX0Q56NOgSgQUyWAroE
   oZ+ubZT2FkTPmUC5L8fu4ZfuocNRuLPaIMy3O1m4b1Oetvp46jSD1P5rl
   YtIerCWWjrNikR4N+0E390G03Y8Ctv2OVrgF0Ol1sTB0tyPgo4SsdNgzH
   Y85lHK4OsCHqg3v8/qAQx+FoES/8SlMRXgsagoax1UhR13U5ScB4HdkL2
   w==;
X-CSE-ConnectionGUID: 1CBEbH/TQhKt5ik2Wk1AwQ==
X-CSE-MsgGUID: PdvYU/4dSJOPDA4SS0GoYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83174856"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83174856"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:37:01 -0700
X-CSE-ConnectionGUID: cThrWzkYToKtCL0Q7jJf5Q==
X-CSE-MsgGUID: ZTqd1/pyQK2hsN7TA3cjmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="250209467"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.253])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:36:59 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "Hodo, Martin" <martin.hodo@intel.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/hdcp: require monotonically increasing seq_num_v
In-Reply-To: <DS4PPFE901A304F2E6AD5691A968A6BA2ECE3EA2@DS4PPFE901A304F.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625104407.1025614-1-jani.nikula@intel.com>
 <DS4PPFE901A304F2E6AD5691A968A6BA2ECE3EA2@DS4PPFE901A304F.namprd11.prod.outlook.com>
Date: Mon, 29 Jun 2026 11:36:56 +0300
Message-ID: <6bfadde9120c6203f01a3b29fa2a1350b5a47904@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 27 Jun 2026, "Kandpal, Suraj" <suraj.kandpal@intel.com> wrote:
>> Subject: [PATCH] drm/i915/hdcp: require monotonically increasing seq_num_v
>> 
>> The HDCP 2.2 specification requires the seq_num_v to be monotonically
>> increasing, and repeated seq_num_v needs to be treated as an integrity failure.
>> Make it so.
>> 
>> For the first message, seq_num_v must be zero, and is already checked. We can
>> only check for less-than-or-equal for the subsequent messages, where
>> hdcp2_encrypted is true.
>> 
>> Discovered using AI-assisted static analysis confirmed by Intel Product Security.
>> 
>> Reported-by: Martin Hodo <martin.hodo@intel.com>
>> Fixes: d849178e2c9e ("drm/i915: Implement HDCP2.2 repeater authentication")
>> Cc: <stable@vger.kernel.org> # v5.2+
>> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> LGTM,
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

Thanks for the review, pushed to din.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c
>> b/drivers/gpu/drm/i915/display/intel_hdcp.c
>> index e88fec24af49..d097b478d010 100644
>> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
>> @@ -1798,9 +1798,10 @@ int hdcp2_authenticate_repeater_topology(struct
>> intel_connector *connector)
>>  		return -EINVAL;
>>  	}
>> 
>> -	if (seq_num_v < hdcp->seq_num_v) {
>> -		/* Roll over of the seq_num_v from repeater. Reauthenticate.
>> */
>> -		drm_dbg_kms(display->drm, "Seq_num_v roll over.\n");
>> +	if (hdcp->hdcp2_encrypted && seq_num_v <= hdcp->seq_num_v) {
>> +		/* Reauthenticate on Seq_num_v repeat or rollover */
>> +		drm_dbg_kms(display->drm, "Seq_num_v %s\n",
>> +			    seq_num_v == hdcp->seq_num_v ? "repeat" :
>> "rollover");
>>  		return -EINVAL;
>>  	}
>> 
>> --
>> 2.47.3
>

-- 
Jani Nikula, Intel
