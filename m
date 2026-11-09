Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229383;
	b=KVXVhGy5ebOiskDBdq+Z/Q7+n/r9iiF7go8pE8sDgJAXPGYtAJmNxhkkWNjagQ8gyOFT
	 XfD5V7HNyZfLczJYfwsJa+7aVHo13SFxqYt7omoQYDcwkDWQ354GEHpYwWcnlKp99qW0T
	 fDbNPd6O13TLgqY03uVewnXnj0/iXAHrREiJmOGEgFLrZPYYEkZeAYQfX0JuGv68ZI0HK
	 8fJukUS92n1vAirmmflH3mSLF33FCuvR/b7FYyNvP+oCTkNbVD/SZDBvyg7do8489ISyh
	 WCIF/zfk2MjCV6sR5bc8Nt4xIw2PYsWgnoCbOSWAmvUHovutxpdIYW8SJQtOLi91oHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229383;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vx6Ms7DaSLXJkW1vJMuP19hrsjj4bkb+6EJX49nS2u8=;
	b=wGPqxpHlmIh+SSRhQA5jH0Hr5DR6ptXUzsneERkAo2FCkASZz93xbUI28vVx4lAieGtK
	 51dswpEsNnCTqY9e3einAGSWOTdTmXwyI+yfJsL7Z9lszqgX8n6G9yoCttHUqYPLmZzFf
	 ZcSUnAAoJkPkoLINfT7saiYtHGkpoAsrlLrWIdYDoe/OPMD8NfGoCZQioYDUimXXtGEkX
	 CeOcnYIHowHPUrdQRAhfltSzcIQMZNsAaGxjg0aa/+WsZfHV1Zd0sFNhBMkfWH29VnF9g
	 D5DrvYlPrIRKRBtjMRPBk+v80boQTOYEWK16A93P5I6yG+r1vDeoQyZK1Vli/RbHk9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="h2fJta/Z";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951E606A321;
	Mon,  9 Nov 2026 13:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6951E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h2fJta/Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794229382; x=1825765382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=64RKfb+JM7ihLo+ucl0KWxre6Pov9mD8NahlY9fQh/Q=;
  b=h2fJta/ZDBSNvBodkwUMG/+dlGl2n4bc5EJ2KXRYOiJn1TqEl8GEOqjC
   Qty38acf9EYYZdG/9Wwe+N5TjXXjSCvjW6YYEuaDRYdPL9B0qnxqwsFj+
   r+VpDX0Hs0KIZwI1w2ty7zROnxIunMwHH8g/chsnkg6t1BPEkQiTSpCl5
   v15oAWC80/bVi8t1aR4rNfgj8Df4CGV6M9ua5l9LhYMvagKe12XMLwaHs
   mqKodgCf6LMpPcwRiEIrPQP53hgNe8EHKcoA8Pb4obHhMQP3vAYn/rlls
   UQP+9kmtxiyobV7XFJoRE5bBaju/sgaePCTojOTadagDAIqhMM4xGuByT
   w==;
X-CSE-ConnectionGUID: b25Oek+yS0iJMIInwnZpSA==
X-CSE-MsgGUID: j/UfINtdToaCKA1+6eKfjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2951823"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2951823"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:03:02 -0800
X-CSE-ConnectionGUID: BDl7lsweQBq86zMoWj4whA==
X-CSE-MsgGUID: lhfaR/UmQNqbEW9ClEKaJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8034179"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:02:59 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id BD4E9121B96;
	Mon, 09 Nov 2026 15:02:56 +0200 (EET)
Date: Mon, 9 Nov 2026 15:02:56 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: b.danias@tutamail.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Serin Yeh <serin.yeh@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] media: i2c: ov8856: Enable runtime PM before
 registering the sub-device
Message-ID: <avHEgEcEet-T9dmK@kekkonen.localdomain>
References: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
 <20261104-ov8856-pm-fixes-v1-2-1958b730ce66@tutamail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-ov8856-pm-fixes-v1-2-1958b730ce66@tutamail.com>

Hi Babis,

On Wed, Nov 04, 2026 at 11:42:48AM +0200, Babis Danias via B4 Relay wrote:
> From: Babis Danias <b.danias@tutamail.com>
> 
> ov8856_probe() registers the async sub-device before it enables runtime
> PM. But the sub-device can be used as soon as it is registered. On ACPI
> systems where ipu-bridge instantiates a VCM for the sensor, the bridge's
> .bound() callback queues a work item that runtime-resumes the sensor.
> If the work runs before probe reaches pm_runtime_enable(),
> pm_runtime_get_sync() fails with -EACCES and the VCM is never created:
> 
>   [  213.265894] ov8856 i2c-OVTI8856:00: Error -13 runtime-resuming sensor, cannot instantiate VCM
> 
> On a Dell Latitude 7320 Detachable this happened on every bind of the
> rear sensor after the IPU6 ISYS driver had probed, so the dw9714 focus
> motor never showed up. Documentation/driver-api/media/v4l2-subdev.rst
> asks drivers to enable runtime PM before registering the sub-device.
> 
> Enable runtime PM first, and hold a usage reference until registration
> is done, so that the sensor can't be suspended halfway through. Drop the
> reference with pm_runtime_put(), which also lets the sensor suspend once
> probe is done, as the old pm_runtime_idle() call did. If registration
> fails, undo the runtime PM setup. The probe_error_media_entity_cleanup
> label then has no users left, so remove it.
> 
> The problem was found, and this patch written, with the help of an AI
> coding assistant (Claude Opus 5.5). See the cover letter for details.
> 
> Fixes: 879347f0c258 ("media: ov8856: Add support for OV8856 sensor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Babis Danias <b.danias@tutamail.com>
> ---
>  drivers/media/i2c/ov8856.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index 988ce0310..f9bcdd412 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2425,22 +2425,31 @@ static int ov8856_probe(struct i2c_client *client)
>  		goto probe_error_v4l2_ctrl_handler_free;
>  	}
>  
> +	/* Set the device's state to active if it's in D0 state. */
> +	if (full_power)
> +		pm_runtime_set_active(ov8856->dev);
> +	/*
> +	 * The sub-device can be used as soon as it is registered, so enable
> +	 * runtime PM first, and hold a reference until registration is done.
> +	 */
> +	pm_runtime_get_noresume(ov8856->dev);

Don't do pm_runtime_get_noresume() here, instead call pm_runtime_idle()
after enabling Runtime PM, perhaps still after registering the async
sub-device.

> +	pm_runtime_enable(ov8856->dev);
> +
>  	ret = v4l2_async_register_subdev_sensor(&ov8856->sd);
>  	if (ret < 0) {
>  		dev_err(ov8856->dev, "failed to register V4L2 subdev: %d",
>  			ret);
> -		goto probe_error_media_entity_cleanup;
> +		goto probe_error_pm_runtime_disable;
>  	}
>  
> -	/* Set the device's state to active if it's in D0 state. */
> -	if (full_power)
> -		pm_runtime_set_active(ov8856->dev);
> -	pm_runtime_enable(ov8856->dev);
> -	pm_runtime_idle(ov8856->dev);
> +	pm_runtime_put(ov8856->dev);
>  
>  	return 0;
>  
> -probe_error_media_entity_cleanup:
> +probe_error_pm_runtime_disable:
> +	pm_runtime_disable(ov8856->dev);
> +	pm_runtime_set_suspended(ov8856->dev);
> +	pm_runtime_put_noidle(ov8856->dev);
>  	media_entity_cleanup(&ov8856->sd.entity);
>  
>  probe_error_v4l2_ctrl_handler_free:
> 

-- 
Regards,

Sakari Ailus
