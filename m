Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCB3EB801
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722261; cv=none; b=qYUjNQt3ANDzkJoLMKv/LMxyjGVSbBQTtJ+MZXMUbZ5LeQo4vKPK/bNFD4OTQ/jBTD15RA9RZPafG8VqyEqZlpwksAvleLwLHOZvkSV67WWsL/hDDUs03h93A6ErDgDR2b1rmQliUzJKmvw/a7YIJ9zDrDh3UWUBDBZESjvfpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722261; c=relaxed/simple;
	bh=npwcDl1Hy2s+m0+wVi0Quc/JHORszY3gdPIGD7SMNJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GaezpcmF+QDdORyyYk0zqz/kMupvYuPqYxzrVUbIuXqUMGlICDj56a61ltQTmlOqOtcWO01hfaBIvSXcP3ug58QDqqdrgk+AOrDueX2XNC89n5XsiipkCakE+I32UbE10qt8OUajnLrD+TXUTA1s/f28VcLQ/c2iU9VV7+iRcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJcCJLZQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJcCJLZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782722260; x=1814258260;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=npwcDl1Hy2s+m0+wVi0Quc/JHORszY3gdPIGD7SMNJY=;
  b=IJcCJLZQoVsltKaPJ+6YVoPmpVcSOkkHNzI5W04w3LZuIdVPctNqbaoe
   BbKKy05lPNjZo0nwfATajd4QDP9/aBN6WSLeEmXkJNzd4e7XOLsayCzp4
   8iqNCSdSp8BMAaHh74iHL7IhNXZJR3ZYwUPnb2XrAfMauBhAeY3MkL3Ts
   RKme4R1RRisyx7qO6FS1x/SIO1MIVeu052D9zmlKVj1edDmsWhlWVSEVf
   nPM31aH7mvH5s58tAsDkzRKZYirOF9VPBfYLudxAYahRRS5/HYHXdhK0W
   Jy2tj6Bpy1Zz3VFybKyodrKhTWWdV62c4Z66OR9Q2dEG/5pG1K6PJbGgs
   Q==;
X-CSE-ConnectionGUID: oXK+izOpTry15rNlhbHVuA==
X-CSE-MsgGUID: NBfxSu9XTuGIaaFdvGDGHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83281734"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83281734"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:37:40 -0700
X-CSE-ConnectionGUID: SBh23sn9QW2WxfZMj+T9ug==
X-CSE-MsgGUID: Ub5XMegeQnG2vLtGvjuvyQ==
X-ExtLoop1: 1
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.253])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:37:37 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "Hodo, Martin" <martin.hodo@intel.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "Gupta, Anshuman" <anshuman.gupta@intel.com>
Subject: RE: [PATCH] drm/i915/hdcp: check streams[] bounds before overflow
In-Reply-To: <DS4PPFE901A304F58021028E7F8F29EE9C7E3EA2@DS4PPFE901A304F.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625170304.1104723-1-jani.nikula@intel.com>
 <DS4PPFE901A304F58021028E7F8F29EE9C7E3EA2@DS4PPFE901A304F.namprd11.prod.outlook.com>
Date: Mon, 29 Jun 2026 11:37:35 +0300
Message-ID: <b7add5ab7a91e3a9aeb6843ece665334de80b6d8@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 27 Jun 2026, "Kandpal, Suraj" <suraj.kandpal@intel.com> wrote:
>> Subject: [PATCH] drm/i915/hdcp: check streams[] bounds before overflow
>> 
>> The data->streams[] overflow check is done after the buffer overflow has
>> already happened. Move the overflow check before the write.
>> 
>> Side note, emitting a warning splat with a backtrace might be overkill here, but
>> prefer not changing the behaviour other than not doing the overrun.
>> 
>> Discovered using AI-assisted static analysis confirmed by Intel Product Security.
>> 
>> Reported-by: Martin Hodo <martin.hodo@intel.com>
>> Fixes: e03187e12cae ("drm/i915/hdcp: MST streams support in hdcp
>> port_data")
>> Cc: <stable@vger.kernel.org> # v5.12+
>> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
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
>>  drivers/gpu/drm/i915/display/intel_hdcp.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c
>> b/drivers/gpu/drm/i915/display/intel_hdcp.c
>> index e88fec24af49..521786a75c42 100644
>> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
>> @@ -145,6 +145,9 @@ intel_hdcp_required_content_stream(struct
>> intel_atomic_state *state,
>>  		if (!new_conn_state || !new_conn_state->crtc)
>>  			continue;
>> 
>> +		if (drm_WARN_ON(display->drm, data->k >=
>> INTEL_NUM_PIPES(display)))
>> +			return -EINVAL;
>> +
>>  		data->streams[data->k].stream_id =
>>  			intel_conn_to_vcpi(state, connector);
>>  		data->k++;
>> @@ -155,7 +158,7 @@ intel_hdcp_required_content_stream(struct
>> intel_atomic_state *state,
>>  	}
>>  	drm_connector_list_iter_end(&conn_iter);
>> 
>> -	if (drm_WARN_ON(display->drm, data->k > INTEL_NUM_PIPES(display)
>> || data->k == 0))
>> +	if (drm_WARN_ON(display->drm, !data->k))
>>  		return -EINVAL;
>> 
>>  	/*
>> --
>> 2.47.3
>

-- 
Jani Nikula, Intel
