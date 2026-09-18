Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AA3BE155;
	Fri, 18 Sep 2026 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717206; cv=none; b=hYDlk1cJH2VfA8mxfaBl8gcaZZlVtJ9dept19ql2gKBtzp8GTlafuYga3G4FLp4wSh+BY/AHt5GtptQYOIuC+uUOAvScHrWUfzZq+8KNDv21B2ftSltkVktJpS6z7EX2jBJH75frm4+u5HR4wVBWP6rnFeIVKuvSjhnQy6QCpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717206; c=relaxed/simple;
	bh=9HjgM9JbkGt1A3yefJhN4x6xA3Vg7LoR3hGeySb0Qow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeFfo2fQ5C/dcYEqvUuJ+dXQYu+ZmubxzEW9cM55fVZAREs4jiFOV9NZfI3rLp4K5q+TjSMioqeqZ8bevOX1EHvr5JekoPLitO+zFRVYNITxV9QMuwnr+z20UXWI6jcGno6QOvmoIpLb9k5JL24jDXpTvsw5VHZd4eKJdleGp04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRyltiK/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRyltiK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789717199; x=1821253199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9HjgM9JbkGt1A3yefJhN4x6xA3Vg7LoR3hGeySb0Qow=;
  b=QRyltiK/8VXtmYoDNqHqSA6+r/9gYRqGlcGdjn5gfRAhfQYAn5XrGY+x
   /+35p6LcSwkm7LHxQ0H0T7RP61tFADN8S0MIQBnpTXmqy1wJlBfBetV8D
   M0sM5sNh7CvD6aBqts1P3nYb3nGLGHE4yU652I33CC3bngi3TQwFTcxAM
   pP7c2U8bSt06+1+1/MKj2IhZGMSCRZDLIqtfLwiyHZoMUaLXo/e34lt73
   3eMaFW6VmLVdJy13a1YgT2W8h/AwUBXpEMCyuMjYl9a4V6QWavGhOpmcL
   LT+mt+THYI+YR8kQ1SogLaARS2dQsaUtbsHxCqQ4tDduzF5sjo4nlVIAA
   Q==;
X-CSE-ConnectionGUID: 9td86wudQRe8nBfvawUHFg==
X-CSE-MsgGUID: uZRVMeamQZSrFr1z7FHMXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89340112"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89340112"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 00:39:52 -0700
X-CSE-ConnectionGUID: EQSigIixQTGHBye9zTlPZA==
X-CSE-MsgGUID: SCwZTKvvQfmatyBz20cYNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297731196"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 00:39:47 -0700
Date: Fri, 18 Sep 2026 10:39:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentao Liang <vulab@iscas.ac.cn>, Miaoqian Lin <linmq006@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: imx: gpc: remove all initialized power domains
Message-ID: <aqzqvfbeh653jUce@ashevche-desk.local>
References: <20260918031323.3376849-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918031323.3376849-1-lgs201920130244@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 11:13:22AM +0800, Guangshuo Li wrote:
> imx_gpc_old_dt_init() initializes all power domains described by
> of_id_data->num_domains. Its probe failure path removes all of these
> domains, but imx_gpc_remove() only removes the PU and ARM domains.
> 
> On SoCs with more than two domains, such as i.MX6SL and i.MX6SX, the
> additional DISPLAY and PCI generic power domains can remain registered
> after the GPC driver is removed.
> 
> Remove all initialized power domains in reverse order. Keep releasing
> the PU clocks immediately after the PU domain has been successfully
> removed.
> 
> This issue was found by manual code inspection.

...

>  static void imx_gpc_remove(struct platform_device *pdev)
>  {
> +	const struct imx_gpc_dt_data *of_id_data =
> +		device_get_match_data(&pdev->dev);

No...

>  	struct device_node *pgc_node;
> -	int ret;
> +	int i, ret;

...and no.

The result of the device_get_match_data() better to be checked, in some cases
it might lead to NULL dereference.

It's better to split semantically different variables, also naming 'i' is not
good, num_domains is better. Besides that, why is it signed?

...

> +		for (i = of_id_data->num_domains - 1; i >= 0; i--) {

What you are doing here can be written in a shorter form

		num_domains = of_id_data->num_domains;
		while (num_domains--) {

> +			ret = pm_genpd_remove(&imx_gpc_domains[i].base);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					"Failed to remove %s power domain (%pe)\n",
> +					imx_gpc_domains[i].base.name,
> +					ERR_PTR(ret));
> +				return;
> +			}
>  
> +			if (i == GPC_PGC_DOMAIN_PU)
> +				imx_pgc_put_clocks(&imx_gpc_domains[i]);
>  		}

-- 
With Best Regards,
Andy Shevchenko


