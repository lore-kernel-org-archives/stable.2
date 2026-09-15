Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAB46AF27;
	Tue, 15 Sep 2026 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464555; cv=none; b=Gm632F5lY+SfBq40YhsC6TAtJqdHd8hWGBzsTEl7Rc0X/TXmD/9lpT6PqGAIE69lrKAe57/j87x9C8OEojL+YCoxktx2IOUbFnkaq5gXl9hTz+0OleYHTnpT5d8RqJ1V8hW1LcYBfwsaDEfXCryVPPXOQuIZI3D2aJHCLfozC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464555; c=relaxed/simple;
	bh=TG4jDHajX86XUzhzC1k6vGPJm2PIIE2nLR3965Hl3ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYMXkUyZ9w5SJWuMT17yhA9QaaUHyAdTny0WVzKbzvv/a5Ke3hcaie799eqFMwE/u7cz6sXLereXY3Q6aFZRkURuLXTh5zw628il+OTwExkROK0qvsK/GoMc3jqU5PhBxLxTXjHZglYc6UUCzqEu/qr2wCZ41Ug5eepiph5GaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2dJ/M5S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2dJ/M5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789464553; x=1821000553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TG4jDHajX86XUzhzC1k6vGPJm2PIIE2nLR3965Hl3ms=;
  b=i2dJ/M5SHeTnzPokGJ5Qs9Cb9Wu4tC7cw8NmuGK9lGsRL5vdGSNMgaOa
   LNSIXSVSBvOlNFj1jw3QiJ/RyGjjz7pftOmNnJIVvzDq8PaVI8oFIpxTJ
   SAOoujZTFLkQpONReux8NkpU3TLzgh+CkARvauCPMXVI713rri7O/4k0Q
   NktF7TggoYJ5ISpQhsEURTpJKBZjK+ed3sp3w5NLlOLADM/R6FcqE4oa7
   MHzK4tntqI1JzrDs/0at0V5xfvg99ciw5T90CjVX5pHSeuw/r2Ea0dhC6
   PTvoWnddLnwcQP8yWTa0WO4tyISLoLh6a3Q+w3FXnQTmMVSaRc6iJc4jX
   Q==;
X-CSE-ConnectionGUID: h520uirJR3Wv2ki90d8gJg==
X-CSE-MsgGUID: mHnP7KOlToKZlVs/LL/ysw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92331418"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92331418"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:29:12 -0700
X-CSE-ConnectionGUID: W4/xZ+Y7Qd2k75/ymqlpfg==
X-CSE-MsgGUID: 4sr2FUlaTYKvOPDH/9Ao2A==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.227])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:29:10 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D09A011FB58;
	Tue, 15 Sep 2026 12:29:16 +0300 (EEST)
Date: Tue, 15 Sep 2026 12:29:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Bingbu Cao <bingbu.cao@amd.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Hans de Goede <hansg@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov2740: fix power cleanup on remove
Message-ID: <aqkP7DLxJP1509TA@kekkonen.localdomain>
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

Hi Guangshuo,

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

Could you move ov2740_remove() just after probe instead of adding a
prototype?

>  {
>  	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> @@ -1207,6 +1209,9 @@ static void ov2740_remove(struct i2c_client *client)
>  	v4l2_subdev_cleanup(sd);
>  	v4l2_ctrl_handler_free(sd->ctrl_handler);
>  	pm_runtime_disable(&client->dev);
> +	if (!pm_runtime_status_suspended(&client->dev))
> +		ov2740_suspend(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
>  }
>  
>  static int ov2740_nvmem_read(void *priv, unsigned int off, void *val,

-- 
Regards,

Sakari Ailus
