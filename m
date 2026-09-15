Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA73B42C9;
	Tue, 15 Sep 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465610; cv=none; b=gUEy8V1SAqJUOMXquB7oTWH2owiGfG1lwswm9IvHAT354xOf3MIjr/hGgFu3hfacMrsyH4bhIj4a4ni7q+vrA8FvupkfMcH6jfIQW+bq9HsZMLrT2aSBzXbkyT7zIYQt+BPQ96/lWOEqhmrbOK7JsrS7UlAzxwvO3WIGLq71dpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465610; c=relaxed/simple;
	bh=1q5dv6Vrxtkj8evu/VjYKuCf2t54zRo341nxUJ7nfuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTQxKK8FMEHMEyHk34CpKlNzOlh44dp6d+zEKkMkBK7oAxrhBu77FSdWfywgWERNTMasxo5nsaTMTua2fWy3iYl7HhyOHtkXaKsxv1EL50FSuWTd2XRFp4indusfCZDsHhi8U7PIKPF3wFyuLqVRu2l5vTr757TDQEl7C9NwgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LndAkwqy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LndAkwqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789465608; x=1821001608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1q5dv6Vrxtkj8evu/VjYKuCf2t54zRo341nxUJ7nfuk=;
  b=LndAkwqyMXpssuOK44ue3J7tQJ7O5aCj772F/sRahill5/NDSH1TsZhn
   m8e4FTu71GTVOk7FdYGzR4GT89HO6qZN7wOg/Rliuvd7G/LoGe8kwEUwt
   W/uaazJFUFGBtf8BuzbU0VE61g9j8Jwsk2w3znRaKdoFUGcHXjCgWgdN0
   SQ6pA+zG9XAahzVj8Qb3DFrG5ght6zeF5AdEgewDbkZRVoH1zAg1e3UE3
   grymICBulBhhBIF+fJGZC2bWasYG5WXBVD0BqInunB6A6tWDloMBQXUvb
   uEqKh1/tUHOINR7zbGyf+SVnDvqp6zV7eRDV+OEnkBtTlBOq9VdSHG9ew
   w==;
X-CSE-ConnectionGUID: 7Qc1gvzzRJy75XUsKaAKsg==
X-CSE-MsgGUID: oB2VsmybQA+Qaeaj8LJJGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89838824"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89838824"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:46:47 -0700
X-CSE-ConnectionGUID: 8dio+FLkSQuOK5bw0BabTQ==
X-CSE-MsgGUID: XBIPLSyDQaa3gz7Op/8gdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270288882"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.227])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:46:45 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3C25311FB58;
	Tue, 15 Sep 2026 12:46:52 +0300 (EEST)
Date: Tue, 15 Sep 2026 12:46:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Arec Kao <arec.kao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bingbu Cao <bingbu.cao@intel.com>, Hans de Goede <hansg@kernel.org>,
	Hao Yao <hao.yao@intel.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov13b10: fix power cleanup on remove
Message-ID: <aqkUDJ03uWCAoSrh@kekkonen.localdomain>
References: <20260915084436.2329278-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915084436.2329278-1-lgs201920130244@gmail.com>

Hi Guangshuo,

On Tue, Sep 15, 2026 at 04:44:36PM +0800, Guangshuo Li wrote:
> ov13b10_remove() disables runtime PM and marks the device suspended, but
> does not power off the sensor if it is still runtime active.
> 
> pm_runtime_disable() prevents further runtime PM callbacks, but does not
> force the runtime suspend callback to run. If the sensor is active when
> the driver is removed, pm_runtime_set_suspended() only updates the
> runtime PM state while the imaging clock and regulators can remain
> enabled and the reset line can remain deasserted.
> 
> After disabling runtime PM, check whether the device is already
> suspended and call ov13b10_power_off() if it is still active. Avoid
> calling the power-off helper for an already suspended device to prevent
> unbalanced clock and regulator disable operations.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 6e28afd152280 ("media: ov13b10: add PM control support based on power resources")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/i2c/ov13b10.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov13b10.c b/drivers/media/i2c/ov13b10.c
> index b0d34141a13a..6d57da39c371 100644
> --- a/drivers/media/i2c/ov13b10.c
> +++ b/drivers/media/i2c/ov13b10.c
> @@ -1688,6 +1688,8 @@ static void ov13b10_remove(struct i2c_client *client)
>  	ov13b10_free_controls(ov13b);
>  
>  	pm_runtime_disable(ov13b->dev);
> +	if (!pm_runtime_status_suspended(ov13b->dev))
> +		ov13b10_power_off(ov13b->dev);
>  	pm_runtime_set_suspended(ov13b->dev);

pm_runtime_set_suspended() in fact also needs to be called conditionally,
depending on the Runtime PM status.

>  }
>  

-- 
Regards,

Sakari Ailus
