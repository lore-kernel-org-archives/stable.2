Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356864;
	b=tDaBV5RzPIDZGtj/M3Eiu5DxF7B6yvpB3tF+j7ay6V6U38pDnuHx6AwIwnx7KG9xJYix
	 nDKL8jDdVwQ9UrwCcd6AzlDXWYjhvu1Wl+1jzuv2XJiqvDo+Bw/GTmGhfsVsPFg71rJG3
	 iGS2OM3HMTsC2Ss7ARRb1lCwLDogclkPJQGsbXywxggA/Gf8sJhCCqE9CAmm9tr/ZW6SO
	 EBHwoILla/jnDyzDrNMtWFh64/xBClKS3xRvBJbHbG9SA7lcyZqoWaOA0TPEg8Wa8SvBL
	 Z16BJbhzHy3tKiLctsCga+E3Xq1BdmT2QavXqYAHg/P6ZB7Cu0jFQ7s8SE5qrl9CWrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356864;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=OecWFWtnpeI+kxtFniab3JxKEVWTHzdquNuIUurozis=;
	b=dko609SEStSj3YXHUX8Azz4hAJP4y/G7UWPqCDMMxt+S3UY4SnPQd0pVpQ7Xqzv59thi
	 IT+HAH/inmWX3wk+rdONA8V/5IjaGtRM6rGnygvdB1EbfFlE/DQ7IsoXMshae1zzW1Fm+
	 sFy7+852Jwk9zoLwjfrUbprE6HIwiI30NbpR5QiU9I9oSykVSo/e1gi6Lz1+0ECd3MeLW
	 twMr8BQxykG5ifxUnBM3ChQ3Kt3S4fkRzOmSmutDvwoEjsC7k4+sPGj49PV67YgF5KOw/
	 IjbeEuOm9UBcfyXi+IYJQSpf31CFIlocmHWbeeVWqQ46sDbK/lUMAS7pCYeH11TYoxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iUTeqSZi;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F03606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66F03606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iUTeqSZi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793356864; x=1824892864;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=T5KXMNQ4RIOzej+TfuL+2Xe6pCzPNA+WHYz1J3vH/BY=;
  b=iUTeqSZit/m18rhGX2Z4BQmvPcwPlU10K6NYJbAQ/1QcRCiDFU70a/55
   bDRWdqUY69568jsbRCQXDz8bNgFud5jb7zfVt4j40irP3VQX+HUW729I+
   JSzECFGSWo/TvJdH4hnM9wEo0fhcHU75QItjvpEcNhADz89C23zlbwma7
   Ym03W+x3ZOPOBQQOPRttMxZxdR0c0Ww3g4UN+y5tJLu7poAyBfsWtoiKO
   CALw9p0+L3/N8kwLttt7etJQAnaby3vt9/W/+uzfWBIlYYVlkd7juqMV5
   CARv5+NJ40RkdTrRwtTUIkIO7x2w2EzRz6KuUnbXEMZIry626MbOXSKRM
   g==;
X-CSE-ConnectionGUID: SI6AZLhkThiA/IV+vW1goA==
X-CSE-MsgGUID: ekwCie7uRsCdMrvxFOR/uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2022596"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2022596"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 03:41:03 -0700
X-CSE-ConnectionGUID: f8auXAckQHChf9XFPNJZtg==
X-CSE-MsgGUID: wluOryQaRoGcAEOFWd+CcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7230603"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 03:41:01 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Mitul Golani
 <mitulkumar.ajitkumar.golani@intel.com>, intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v1] drm/i915/display: Allow port sync on PTL
In-Reply-To: <3918d7f2-2c8e-4c91-8de3-ae412acc75a0@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261012040402.3332398-1-mitulkumar.ajitkumar.golani@intel.com>
 <3918d7f2-2c8e-4c91-8de3-ae412acc75a0@leemhuis.info>
Date: Fri, 30 Oct 2026 12:40:59 +0200
Message-ID: <041969576ff0e2ef6abc03650e077e44669a2b72@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 30 Oct 2026, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> On 10/12/26 06:04, Mitul Golani wrote:
>> Some dual-SST tiled displays exhibit visual corruption on PTL, with
>> one tile's image vertically shifted or wrapped by a random amount
>> that changes on every hotplug.
>> 
>> PTL supports port sync, so allow it to be used to avoid these
>> display issues.
>
> Is this fix for a recent regression still in the "to review" list of
> anyone, or did it fell through the cracks? Or was this solved meanwhile
> and I just missed it?

Pushed now, thanks for the reminder.

BR,
Jani.

>
> Ciao, Thorsten
>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8991
>> Fixes: 05cffc074938 ("drm/i915/display: Implement Wa_16024710867")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
>> ---
>>  drivers/gpu/drm/i915/display/intel_ddi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
>> index a46ab5d3d70f..a0aff087fafa 100644
>> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
>> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
>> @@ -4629,7 +4629,7 @@ intel_ddi_port_sync_transcoders(const struct intel_crtc_state *ref_crtc_state,
>>  	 * From, xe3lpd onwards we have defeatured this with reference to
>>  	 * Wa_16024710867
>>  	 */
>> -	if (!IS_DISPLAY_VER(display, 9, 20))
>> +	if (!IS_DISPLAY_VER(display, 9, 30))
>>  		return 0;
>>  
>>  	if (!intel_crtc_has_type(ref_crtc_state, INTEL_OUTPUT_DP))
>

-- 
Jani Nikula, Intel
