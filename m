Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BF47532F;
	Tue, 15 Sep 2026 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789466407; cv=none; b=KMIjMGJ0uNoDaTAnXVgeIDicAGBAh41AA8bUEoK/hSyLajUzdXKpKCgIp4EunCsD4LaYr9qw/7eztTg5BH72pwJTvLVvJEOA2L6DHPCgg/2em+rnHyk7y1ihAvVknwkkjgXPbSC2NY59HTVdgkfR6C8TMwkJ1ltW0d9fLYtm+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789466407; c=relaxed/simple;
	bh=LiU/3F+j9Tm4C+3VL+M8nX1B9ZAJjIYNo3laMA7xP8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6/azosVA+kcDUWb6zKIJJk4SRYRhi36RQXrbVBGLj8CeMcvNAmfuumqDjUZltZyPSbjB9F3LyE438rp/XHHE8dgIRfmleH3pyEaQCccIBbrqcQwZ9NcRCM7jDiCEXJ3qJtE0HiDKqcYeTdbC53XN2gRYjwz47cnMiSUqNIvwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXirkans; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXirkans"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789466405; x=1821002405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LiU/3F+j9Tm4C+3VL+M8nX1B9ZAJjIYNo3laMA7xP8Q=;
  b=mXirkansGGyRjQRpN3QuUnF7PUWCpy5194S+2RhoH7P7xoVD+GKRyf8P
   OLlHpFM5Pwekg0YevhcBO1OjiUfwz++gTHxoEOgEchthpKHTo6WmxtNfp
   RX9skxdiaruPRa+bqXeY9CEE4iPZUwbQCxXSZjlstKuA132LkdOR5yp4b
   djSzrmSd8LJxJAsMHyovqgZ0O6LG0xHOtBUlICxH4Z3XWk3zJrntu76MG
   WSOtWkCwGLkeuyQ8sfWjZuVYs6JCgRlTyjVz5s3Gs3wKDf5vuzQXCPgOs
   hfRt6FWtfMqMNw39TgS1TAVcF9lb0HTHyTaNIEK5xSfpDZtJ2VHof251K
   Q==;
X-CSE-ConnectionGUID: w+21EhKHTw+KeEgxuj3hAA==
X-CSE-MsgGUID: vMrh7Ym8TdKPhkmUdmRmwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89585005"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89585005"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:00:04 -0700
X-CSE-ConnectionGUID: TsARHpq3SBSlzcPPc8Ra1w==
X-CSE-MsgGUID: WDXxPhEuQ/WMy+gmxc99ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1334482"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.227])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:00:02 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 82FD411FB58;
	Tue, 15 Sep 2026 13:00:08 +0300 (EEST)
Date: Tue, 15 Sep 2026 13:00:08 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Bingbu Cao <bingbu.cao@amd.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Hans de Goede <hansg@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov2740: fix power cleanup on remove
Message-ID: <aqkXKF8AW3k6LdN6@kekkonen.localdomain>
References: <20260915085903.2337086-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915085903.2337086-1-lgs201920130244@gmail.com>

On Tue, Sep 15, 2026 at 04:59:02PM +0800, Guangshuo Li wrote:
> ov2740_remove() disables runtime PM without powering off the sensor if
> it is still runtime active or updating the runtime PM state to
> suspended.
> 
> pm_runtime_disable() prevents further runtime PM callbacks and waits for
> pending operations, but it does not force the runtime suspend callback
> to run. If the sensor is active when the driver is removed, the reset
> and powerdown GPIOs can remain deasserted and the clock and regulators
> can remain enabled.
> 
> After disabling runtime PM, call ov2740_suspend() if the device is not
> already runtime suspended, and then mark the runtime PM state as
> suspended. Checking the runtime status avoids disabling the hardware
> resources a second time when runtime PM has already suspended the
> sensor.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 1a140854bc8c ("media: ov2740: Add support for reset GPIO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/i2c/ov2740.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
> index 39003c1632ad..a5346adf2281 100644
> --- a/drivers/media/i2c/ov2740.c
> +++ b/drivers/media/i2c/ov2740.c
> @@ -1198,6 +1198,8 @@ static int ov2740_check_hwcfg(struct ov2740 *ov2740)
>  	return ret;
>  }
>  
> +static int ov2740_suspend(struct device *dev);
> +
>  static void ov2740_remove(struct i2c_client *client)
>  {
>  	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> @@ -1207,6 +1209,9 @@ static void ov2740_remove(struct i2c_client *client)
>  	v4l2_subdev_cleanup(sd);
>  	v4l2_ctrl_handler_free(sd->ctrl_handler);
>  	pm_runtime_disable(&client->dev);
> +	if (!pm_runtime_status_suspended(&client->dev))
> +		ov2740_suspend(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);

This, too, need to be called conditionally.

>  }
>  
>  static int ov2740_nvmem_read(void *priv, unsigned int off, void *val,

-- 
Sakari Ailus
