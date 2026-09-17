Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F6572687;
	Thu, 17 Sep 2026 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653997; cv=none; b=U3/pKc0T91UspkXXidhuD40s/TMVZw0ZU4KzIqhANLLFbRXgL4Xtot984fLIIDDRX39WU9nXiNMgYDdGAumgOMvBKvqbEUrRB4LPiR5TTGVL1FsqfcH5Yn60u98RpSFpU4S2M0bq+n/yAh1OISMekpk5SRjh5MiO+wmcia6eEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653997; c=relaxed/simple;
	bh=FQGfNhonI7Ro9GxU5rUg0cisWgUGJrE6QQPHMIsklEI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UrYFm64/wbpD+mLAoBIp4/vceEKWcEuVTGAzO0tZUDkGUq/t5sPyN26D/wnkQfMFSSAPSe9JV9++j7OZ67QEYgdbPV9btY01LAJulv/nPTn1G9ehpq58VbKGI5vTG3V5uWtxHE6cuINvQ8c3F+edxcDWPGd/tdPeYwE+ktFzyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpAg5zjh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpAg5zjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789653995; x=1821189995;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FQGfNhonI7Ro9GxU5rUg0cisWgUGJrE6QQPHMIsklEI=;
  b=YpAg5zjhznyx5M7FRyUQ+DKRVovriUN9fwJ/K0YBiSemvBX1UAqbngmj
   OmHwlD0vc4p2u3mzyHltIFDs3E19n5DZTx+rEtd5D9mz+lX1PLn9mJJCV
   Xr7teyz3CSjYNHkT2CCNYSdnkpxh7ma+LaROXgNL1cXe3aJTpVzPVuGSF
   4N6ZZ0mk/Mz+CYtTWCTnWpTMRBiTDejlIyXDaYjo2MEdIrNf0z3b/+SJ2
   X3U6ExAzpEMU1E48shkuD2cMWAHefnJV+/CWBdcVrkuQUAIQcrb36OoSp
   ZCleNKT8X6+TROzYwNCQmbVBPHxVF6JaDuhH/+P2IaOD9P4+2d85MtTSr
   w==;
X-CSE-ConnectionGUID: 5tnMGA+vQ7iNHa28WNPm2w==
X-CSE-MsgGUID: YWTh6qzgRiO0dZmvYdtYIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100675082"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100675082"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:06:18 -0700
X-CSE-ConnectionGUID: rZSLyJ0xRfqsDLMm03x6wA==
X-CSE-MsgGUID: pM1JqcsQQMiu3F1hgHaAuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270127841"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.62])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:06:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Sep 2026 17:06:10 +0300 (EEST)
To: Wentao Liang <vulab@iscas.ac.cn>
cc: Shyam-sundar.S-k@amd.com, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/pmc: Fix RTC device leak in
 amd_pmc_verify_czn_rtc()
In-Reply-To: <20260917135854.2154187-1-vulab@iscas.ac.cn>
Message-ID: <f320a056-78a6-c33b-9d75-8298f140283b@linux.intel.com>
References: <20260917135854.2154187-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Sep 2026, Wentao Liang wrote:

> rtc_class_open() takes a reference to the RTC device, but all paths
> that return after it succeeded, apart from the final one where the
> alarm is programmed, leave the function without dropping it. Route
> them through a common exit that calls rtc_class_close().
> 
> Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index cae3fcafd4d7..f40e8d9b124a 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -569,32 +569,39 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  		return 0;
>  	rc = rtc_read_alarm(rtc_device, &alarm);
>  	if (rc)
> -		return rc;
> +		goto out;
>  	if (!alarm.enabled) {
>  		dev_dbg(pdev->dev, "alarm not enabled\n");
> -		return 0;
> +		rc = 0;
> +		goto out;
>  	}
>  	rc = rtc_read_time(rtc_device, &tm);
>  	if (rc)
> -		return rc;
> +		goto out;
>  	then = rtc_tm_to_time64(&alarm.time);
>  	now = rtc_tm_to_time64(&tm);
>  	duration = then-now;
>  
>  	/* in the past */
> -	if (then < now)
> -		return 0;
> +	if (then < now) {
> +		rc = 0;
> +		goto out;
> +	}
>  
>  	/* will be stored in upper 16 bits of s0i3 hint argument,
>  	 * so timer wakeup from s0i3 is limited to ~18 hours or less
>  	 */
> -	if (duration <= 4 || duration > U16_MAX)
> -		return -EINVAL;
> +	if (duration <= 4 || duration > U16_MAX) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
>  
>  	*arg |= (duration << 16);
>  	rc = rtc_alarm_irq_enable(rtc_device, 0);
>  	pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
>  
> +out:
> +	rtc_class_close(rtc_device);
>  	return rc;
>  }

I was expecting 2 patch series, with one which adds the DEFINE_FREE() into 
the public rtc header, not going back to the old approach. You also seemed 
to forget to increase the version number in the subject.

-- 
 i.

