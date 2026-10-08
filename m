Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF532EA15C
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468485; cv=none; b=bwenV4e9lr50gosfSnfawrA6TUIEtFxjHejUqQGQWgSur9pb04gdSoWJP4/l4ix6UafjPZjSVD5KfDGKNvB1dy0/A7PpVcFDM2bZqK3volQO8GLtt1qP0vHc83ZhKW+sfqxDTvD1F2YQiXMgXeA0nXQ/wkGNd9arQGyZpzpm6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468485; c=relaxed/simple;
	bh=s2uVbRXLVOSm9D7G8EeEgzSFVqTdnwqXhdPcnUoc59Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DFNUzWwHPOwZnjFi8zlfPz1LYThtvNsp9r1TYeJQV4M0V5tmCYVzTbN64YkST4HHa73C/TaM6gDSNOkvge3UrItDCBX7wyULdbnp1eOWzk3NzZ3Mh5kjInonJpMzvEt2TSa0I5c2RI1CvkhVTaAeiG7GFuwVQPDAr/+hECvzTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R95+pOmj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R95+pOmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791468484; x=1823004484;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=s2uVbRXLVOSm9D7G8EeEgzSFVqTdnwqXhdPcnUoc59Q=;
  b=R95+pOmjXrSn7J+1i5OXRkJxssZ+tbhF6XKl7XvhX8YaIxgzB1KRTECO
   AwWlI+iL7qAHODrV/xOFSYkPqchPrPQNXiZ30z7uEVI3w75XSVtazBBFe
   ehiUCpAgV2o2T16tU7aJEYdiI43KOQ6/Qq4KPROAKFysjY5tLQEmQXojz
   rFsxBMQEfbGlKhhyfrKcd49bHNuxeMMGnSDHS7qp12QJJpIdMOPFjGK7t
   sS4i+y7htJRWdG9j44BQjGuEWpJsaeCZFox2GZCroDKd4zKQZ3TChVUh2
   CBBXFM6k/rx4/lcvACc/47Ot1aCPNsblKxjhUV57R1eR++oZoihDz2hDh
   w==;
X-CSE-ConnectionGUID: ITvp/uw/S9yeKxCrO205Ow==
X-CSE-MsgGUID: B6hs65LhQtWH5Fkqg8UCjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="145852"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="145852"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 07:08:03 -0700
X-CSE-ConnectionGUID: CFfkPoUMSvSb0ENmxv5wBw==
X-CSE-MsgGUID: 3l4lkhvfQCCuHcrsL4nM6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="377535"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 07:08:01 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Murthy, Arun R"
 <arun.r.murthy@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
Cc: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/scaler: Prune YUV420 modes against the max
 source width
In-Reply-To: <DS4PPFE901A304F1782FA1CD962D6DDE3BFE3942@DS4PPFE901A304F.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261007070601.3611674-1-arun.r.murthy@intel.com>
 <DS4PPFE901A304F1782FA1CD962D6DDE3BFE3942@DS4PPFE901A304F.namprd11.prod.outlook.com>
Date: Thu, 08 Oct 2026 17:07:59 +0300
Message-ID: <013890ff0c99723aeb304a0a6997543ba646524d@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 07 Oct 2026, "Kandpal, Suraj" <suraj.kandpal@intel.com> wrote:
>> Subject: [PATCH] drm/i915/scaler: Prune YUV420 modes against the max
>> source width
>> 
>> skl_scaler_mode_valid() compares the mode's hdisplay against the pipe scaler
>> maximum source height instead of the maximum source width, so single pipe
>> YUV420 modes are pruned against the wrong limit.
>> 
>> Commit 3347b55f2c6c ("drm/i915/xe3lpd: Prune modes for YUV420")
>> intended to reject modes whose hdisplay exceeds the scaler horizontal source
>
> I think no need to mention  this commit since you already mention this in fixes
> Also 
> Cc: stable@vger.kernel.org

Yeah we have 'dim fixes' for this.

$ dim fixes 3347b55f2c6c
Fixes: 3347b55f2c6c ("drm/i915/xe3lpd: Prune modes for YUV420")
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com> #v2
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.18+

Don't put all of it in the trailers, but it gives you an idea who should
perhaps be Cc'd and what the stable target should be.


BR,
Jani.


>
> Otherwise LGTM,
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
>
>> limit, since pipe scaling does not support YUV420 for a source width above
>> 4096. Comparing against max_h makes the check far too permissive from
>> display 12 onwards, where max_h is 8192, and too strict on display 11, where
>> max_h is 4096 while the horizontal limit is 5120.
>> 
>> Compare against max_w instead.
>> 
>> Fixes: 3347b55f2c6c ("drm/i915/xe3lpd: Prune modes for YUV420")
>> Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
>> ---
>>  drivers/gpu/drm/i915/display/skl_scaler.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c
>> b/drivers/gpu/drm/i915/display/skl_scaler.c
>> index 7994b983d509..7e65c4fffbc0 100644
>> --- a/drivers/gpu/drm/i915/display/skl_scaler.c
>> +++ b/drivers/gpu/drm/i915/display/skl_scaler.c
>> @@ -145,7 +145,7 @@ skl_scaler_mode_valid(struct intel_display *display,
>> 
>>  	if (num_joined_pipes < 2 && output_format ==
>> INTEL_OUTPUT_FORMAT_YCBCR420) {
>>  		skl_scaler_max_src_size(display, &max_w, &max_h);
>> -		if (mode->hdisplay > max_h)
>> +		if (mode->hdisplay > max_w)
>>  			return MODE_NO_420;
>>  	}
>> 
>> --
>> 2.25.1
>

-- 
Jani Nikula, Intel
