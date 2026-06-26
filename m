Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE83F58C7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481238; cv=none; b=O1zILlmbc7q09T0Q8ehYJgWOhGmrL6SXWJWFFJLxMRg5lv4LRvuCM+4m4rN797NmhTz4Ff/w/gtXrUvJ0m+YWcT13yM1VB3m3rz4DLKvhL+H0VYJM2ujX2DqdpNT7mSnL6z0SZ3o/XWCa/n7NJK8oNJ4u0yq23FGYAfBEh1L2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481238; c=relaxed/simple;
	bh=48Pim0lMg4gKLMN3rRL4MvTGI1hNae5Mm41LxYs+uF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge6NqA3atfINZU6it0Il4AAW01w/fxQccYkrERWbau8ydm17+fGYuxVMaLX1rIHtubH8YcwR+7uX2y+xKd3Dd3+g8AqscGcG98v60ZinEyHqPoSKzwcEqfaboAx5zb33XR10zAgF5xyglrI7s9QgOfpM/Kp1roQG2Tvk4jGuseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF+P0lST; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF+P0lST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782481236; x=1814017236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=48Pim0lMg4gKLMN3rRL4MvTGI1hNae5Mm41LxYs+uF4=;
  b=nF+P0lST1dtoQePvkbHpbCjmF/Xtmljs7fBOl9QmoktzVCigzv/vKi30
   B5oxZnu7irtQqX0X1+uhpq879jmINUpjg4BKsRtZwNQM4GDJ01wacYoRQ
   6uxKQt3QnasPuQtnvDJMQyxDbhJUAU9X9upJfhL1QaINfBbhauxbFNGY9
   OlbUw4Gi15CmOyVsxrIZrtA0ftMOmJzVSCbR5NEU7/av1e19EbFnTwjgh
   HSXUzBqMrgDCO8h1IaKnrDBPa/A/DrMHC7SB2IWIknXVwOXuRbrPzSxZT
   LpbXksdbqa0LJYkqTtvuS/VzWWfedqigBFBoMx+KZbNOKgGw7p73fq/aR
   w==;
X-CSE-ConnectionGUID: wCRnhsz5TAW0pRmrRzOnRg==
X-CSE-MsgGUID: TqFPvyVbRKWQT6X/CD+kLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="83407556"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83407556"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 06:40:36 -0700
X-CSE-ConnectionGUID: LracXZC9Qk6AejU5egDuDg==
X-CSE-MsgGUID: cQf+2PfYTruPG7dcR8SvbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="253241652"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 06:40:34 -0700
Date: Fri, 26 Jun 2026 16:40:30 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Martin Hodo <martin.hodo@intel.com>, stable@vger.kernel.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: Re: [PATCH] drm/i915/vrr: require valid min/max vfreq for VRR
Message-ID: <aj6BTiskgYhSUGYd@intel.com>
References: <20260625131040.1051272-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625131040.1051272-1-jani.nikula@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Thu, Jun 25, 2026 at 04:10:40PM +0300, Jani Nikula wrote:
> Ensure the EDID provided min/max vfreq are valid. Most scenarios are
> already covered (by coincidence) through the checks in
> intel_vrr_is_capable() and intel_vrr_is_in_range(), but be more explicit
> about it. At worst, a zero min_vfreq could lead to a division by zero in
> intel_vrr_compute_vmax().
> 
> Discovered using AI-assisted static analysis confirmed by Intel Product
> Security.
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: 117cd09ba528 ("drm/i915/display/dp: Compute VRR state in atomic_check")
> Cc: <stable@vger.kernel.org> # v5.12+
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_vrr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
> index 5d9b11185296..bffbdee76ee1 100644
> --- a/drivers/gpu/drm/i915/display/intel_vrr.c
> +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
> @@ -76,6 +76,10 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
>  		return false;
>  	}
>  
> +	if (!info->monitor_range.min_vfreq || !info->monitor_range.max_vfreq ||
> +	    info->monitor_range.min_vfreq > info->monitor_range.max_vfreq)
> +		return false;

Perhaps it should be the responsibility of the EDID parser to make sure
the range isn't completely insane?

> +
>  	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;

I've been tempted to get rid of this completely arbitrary 10Hz thing as well.

>  }
>  
> -- 
> 2.47.3

-- 
Ville Syrjälä
Intel
