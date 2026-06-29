Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FA426D37;
	Mon, 29 Jun 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746537; cv=none; b=RqG/JWzC2lJVeNRlCujfkUjJt4miJTzVAlAan0/dzvJ9tG5aQk5vVmaogkDNx/1XXfPY+D4UblgIGXwdrzxpm783sWeMPMbnDkQFnUuKTqkT+1chAwVvmmITVfRJBtKvWNJEMVDIEmnWdKKVy3tCGsJwPxXXjMpQz2vTaBQj9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746537; c=relaxed/simple;
	bh=3nhMqATbBpip5vicGHiYjtjkt6pG1SvW6hoLlNxb+lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m13JhX3WQch0uk+UT8zwtdsNGPqva6w2mt0LbyIf/MO99n+nMIJmoKDbSeN5wzvdGioon1lsALAkTYJ9GAKUiEADYJLt0d+QayXI2fG+YxUdwfM2atpysh4cks6OS20NTNLxMS0pY/0tzc89bYwyHejDeei+F8Ou8S/zkF1CfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjIVLW7y; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjIVLW7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782746537; x=1814282537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3nhMqATbBpip5vicGHiYjtjkt6pG1SvW6hoLlNxb+lM=;
  b=LjIVLW7yDAIyVf+uVp3GHci2+IhB+4FMsJyScbO3/sFPFlmjjMn/mwtm
   sfvrE+NEAhMIWejfs6s2gcO30vkgoGD8C5cmiR9sipIC0R1ValePnHqxq
   p24EsIQkD9XWtx3os9B3jA0SywvLJ7mJa8VEzKGShXYRGuoQW3woC/TGX
   lq+KHWJtdOYLVGph96ZD1M197E96mQVWc5a3nXNd6xgRGH9jvPWNveB5L
   4NrC/ku6H4hGy/QhNz/hviwYZRO2e5AeTYOuKzhp5W0n1tGLg2mX7pn3A
   YMZXkTvA+d2DCDaZ+iW7Nd09Qtf3Oe/7dYMWtQx6JyTMjvNxp7u1gX6QF
   A==;
X-CSE-ConnectionGUID: rgBCitxITpC28W9levB0Dw==
X-CSE-MsgGUID: qDS+S/tbStC1pvk6lPXtRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83315533"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83315533"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:22:16 -0700
X-CSE-ConnectionGUID: 4LWcxAVJTICeY4WckVwoMg==
X-CSE-MsgGUID: 6uew36sjSSirYu1kwU6bHw==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.82])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:22:13 -0700
Date: Mon, 29 Jun 2026 17:22:04 +0200
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, 
	Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>, Elgin Perumbilly <elgin.perumbilly@siliconsignals.io>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] media: i2c: os05b10: Use
 pm_runtime_get_if_active() when applying controls
Message-ID: <akKM6VhoLNep5UZB@mdjait-mobl>
References: <20260325114404.95188-1-tarang.raval@siliconsignals.io>
 <20260325114404.95188-2-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325114404.95188-2-tarang.raval@siliconsignals.io>

Hi Tarang,

On Wed, Mar 25, 2026 at 05:13:47PM +0530, Tarang Raval wrote:
> os05b10_set_ctrl() currently uses pm_runtime_get_if_in_use() to decide
> whether controls should be applied to hardware.
> 
> This is not correct for the intended behavior. If the runtime PM usage
> count is 0 while the device is still active, pm_runtime_get_if_in_use()
> returns 0 and the control update is skipped, leaving the software state
> updated but not the hardware state.
> 
> Use pm_runtime_get_if_active() instead so controls are applied whenever
> the device is runtime-active, regardless of the current usage count.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3aa9296a23ec4("media: i2c: add os05b10 image sensor driver")

A space is missing here after the commit hash.
See https://docs.kernel.org/process/submitting-patches.html

checkpatch will warn you about it.

with that:
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
> ---
>  drivers/media/i2c/os05b10.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/os05b10.c b/drivers/media/i2c/os05b10.c
> index e0453c988e4a..5da5b7d21f31 100644
> --- a/drivers/media/i2c/os05b10.c
> +++ b/drivers/media/i2c/os05b10.c
> @@ -531,7 +531,7 @@ static int os05b10_set_ctrl(struct v4l2_ctrl *ctrl)
>  			return ret;
>  	}
>  
> -	if (pm_runtime_get_if_in_use(os05b10->dev) == 0)
> +	if (pm_runtime_get_if_active(os05b10->dev) == 0)

small nit: how about
	if (!pm_runtime_get_if_active(os05b10->dev))

consistent with other drivers using this call but really not important,
up to you if you want to change it.

--
Kind Regards
Mehdi Djait
