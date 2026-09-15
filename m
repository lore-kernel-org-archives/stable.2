Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1133065D;
	Tue, 15 Sep 2026 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464316; cv=none; b=VwaMy7GUmU11FWys0e8+byguTnADn1CBlwPOEdrj900gPu3pJxRH8a3LsQIXogUarJd6BU63FxR3oPE6DlfVzos8ffUu9g9Uw6bCVr3HO4ja4Md+JaVaJ+zDAmehw4VA5PxvllF6xInPD5e6A3XRmqv8y/kgOU83HYopq1LpmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464316; c=relaxed/simple;
	bh=kpB3SAVgIZOoK1y/EZ07VrHDFw4+00eyojP3H2DblKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5PzPtSIvKLXggB6uTrb7xXTrghnza67C85n6zeQ8X8H77OC8ROK0YfDnYVHl2zTe/7+uNyNFt47zsSIZVmy3tqatiWWMu9Gg1QAozV28JEG0T+AF0PFRO/H+Ny1BDCuTOjT5MHwGZ86v0GXZ1u/HNE5o7DbWcIGo6WmFOfPmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HV5wXS6B; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HV5wXS6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789464314; x=1821000314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kpB3SAVgIZOoK1y/EZ07VrHDFw4+00eyojP3H2DblKY=;
  b=HV5wXS6Bkwq4f1BH08/GI5A15HqQOH8eupTy7/EBETT0v4MXVF5fgkOF
   Iv+4gv7RnXTZ8vEzUpPn2XzdOTRCCVv8Eby5yGfQluX2raoDyCxplKO8F
   curB39Enm2GZ0nJrUuxv3PHXVfP77nQfColSTYBGyho8ZkXTbkPFXiTlo
   GSXAFGKn7iuQEUIbFF3Xg2lawoC1WaY6bFMsKPQqKTStoR6d7T39SG26k
   1ksLtswh9d33vNVXBL0mzksWLMxyDxCDLFre5Y9DBvmMgNKf2j3qUwD9D
   WWzmPDKc8l39pxZyiDhL3FFkm65qdH/YJvwMLKLsXhP0VjfA9/f0Kv7tL
   A==;
X-CSE-ConnectionGUID: jrO74pTBRnK+Sk9ZcKooqQ==
X-CSE-MsgGUID: +MUrYCVMRbCTRUqGiPqCQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89581627"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89581627"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:25:14 -0700
X-CSE-ConnectionGUID: DbiWeQEaRPe436dI3olGvQ==
X-CSE-MsgGUID: nHoWyeIaQ5SbzmFXY1h2Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1118026"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.227])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:25:12 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2C5E511FB58;
	Tue, 15 Sep 2026 12:25:19 +0300 (EEST)
Date: Tue, 15 Sep 2026 12:25:19 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx290: fix runtime PM reference handling on
 probe errors
Message-ID: <aqkO_5jknMbFe3IW@kekkonen.localdomain>
References: <20260915082229.2235439-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915082229.2235439-1-lgs201920130244@gmail.com>

Hi Guangshuo,

On Tue, Sep 15, 2026 at 04:22:29PM +0800, Guangshuo Li wrote:
> imx290_probe() takes an initial runtime PM reference with
> pm_runtime_get_noresume(). Historically, the probe error path balanced
> that reference with pm_runtime_put_noidle().
> 
> The change that moved the successful-path pm_runtime_put_autosuspend()
> into imx290_subdev_init() made the initial runtime PM reference get
> dropped once imx290_subdev_init() is called.
> 
> The longest probe error path, however, still falls through to err_pm
> and calls pm_runtime_put_noidle(). Failures from imx290_subdev_init()
> or v4l2_async_register_subdev() therefore decrement the runtime PM
> usage count a second time.
> 
> Move pm_runtime_put_noidle() to the imx290_stop_streaming() failure
> path, which is the only error path taken before imx290_subdev_init()
> drops the initial runtime PM reference.
> 
> This issue was found by manual code inspection.
> 
> Fixes: a92651b8e288 ("media: i2c: imx290: Avoid communication during probe()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/i2c/imx290.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 21cbc81cb2ed..c2cdb1557dea 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -1634,6 +1634,7 @@ static int imx290_probe(struct i2c_client *client)
>  	ret = imx290_stop_streaming(imx290);
>  	if (ret) {
>  		ret = dev_err_probe(dev, ret, "Could not initialize device\n");
> +		pm_runtime_put_noidle(dev);

Don't add extra error handling here.

Please do the same as for gc0308: drop getting and putting references
altogether, and call pm_runtime_idle() at the end of probe().

>  		goto err_pm;
>  	}
>  
> @@ -1662,7 +1663,6 @@ static int imx290_probe(struct i2c_client *client)
>  	imx290_subdev_cleanup(imx290);
>  err_pm:
>  	pm_runtime_disable(dev);
> -	pm_runtime_put_noidle(dev);
>  	imx290_power_off(imx290);
>  	return ret;
>  }

-- 
Regards,

Sakari Ailus
