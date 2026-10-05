Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896148422C;
	Mon,  5 Oct 2026 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206917; cv=none; b=of0mGpD+BalD80JUhZwQXqtezar+ooxMAN4qMl11dwrRO5qExyDrN2IY1fY9weMEAjGjY1oV87IafKa9i2+RYPfqR7ywlUVz16hcbXcnSzL4aoO08WqjC1za+eqxB0xetD3KiNkWdb7KThcsfJQXj0v6yzxRAzWYHAbIDP7NnHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206917; c=relaxed/simple;
	bh=LA6IZhE3Rb+EGOJa2cBrPZ/JWMp6h4v2CRmE7thuZs4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EKHu/oVTGi4KzAmnHP9o33kDZ3Rq/ebM8dFom4Vw7xLTnvEMe1qeau3T0CwkUHkR2yiRTGS0Rfr6IKWEQt6OZr2bjp7hk2aU56CdSOeJ5xenpGKd7raZP00mAHuxtU1ayvi5YrAM1zavLAOGexYdeYVS0yTA1oC3IXbdY6T+gpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xf9ojWwS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xf9ojWwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791206913; x=1822742913;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LA6IZhE3Rb+EGOJa2cBrPZ/JWMp6h4v2CRmE7thuZs4=;
  b=Xf9ojWwSkFuloqKnkUG6qsAKW4rfoRntoi94tURPIl5I0VsRRAoKzex2
   WJBM+A4S6hPJfNr9b1/UAQcDFjrvozom/reR7byKEBc8LpN+k2fhYxY5I
   0pXmlCJIwrhrZ2Gqi2fWg5unqEHPCudqdBKSG5RXI8TO8mvYppw0q/Nli
   +Xj+1L1GiakAUOhHWrMyJR0y9URNLSqg6HiMY4J31/o8pmN/vsVRtKsy5
   ii0Gpj+r/Dn4VPwN/EzYGjKtlUfcXp3Iy9wFBLmK1kmmduxNZOG8VdYzx
   4B++YP0WjJqN72QN8UNvehifU7qmjZ8KwE9FTaqTYRez7RqciguEZ7Rqo
   A==;
X-CSE-ConnectionGUID: pXnYqL+iQcmHcGvFPdpD7w==
X-CSE-MsgGUID: QVfmvjNZTmmgc7PfjWsc8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90826172"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="90826172"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:28:27 -0700
X-CSE-ConnectionGUID: opLLjo6uRXigo5QvTgElrw==
X-CSE-MsgGUID: VGcLgWKWQsaWiqJtebxxFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="314829811"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:28:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Oct 2026 16:28:20 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v4 7/9] platform/x86: hp-bioscfg: validate SPM state
 returned by firmware
In-Reply-To: <20261002191434.58529-8-meatuni001@gmail.com>
Message-ID: <cf163f06-b7ac-2353-a251-f678b3a5a802@linux.intel.com>
References: <20261002191434.58529-1-meatuni001@gmail.com> <20261002191434.58529-8-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 3 Oct 2026, Muhammad Bilal wrote:

> status_show() and update_spm_state() use the state byte from firmware
> to index 3-entry string arrays without a range check. A value above 2
> indexes past the arrays, and the result is printed with %s by the
> world-readable status and key_mechanism files.
> 
> For example, a state of 3 makes status treat whatever follows
> spm_state_types[] as a string pointer.
> 
> Return -EIO for an out of range state.
> 
> Compile tested only.
> 
> Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> Changes in v4:
>  - New patch
> 
>  drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> index 4d94e48c1..f0eb5c445 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> @@ -118,6 +118,9 @@ static ssize_t update_spm_state(void)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (data.state >= ARRAY_SIZE(spm_mechanism_types))

Please add the include for this (to the .c file, I know it includes 
bioscfg.h as is but common include handing all includes for a multi-file 
driver is undesirable practice).

> +		return -EIO;
> +
>  	bioscfg_drv.spm_data.mechanism = data.state;
>  	if (bioscfg_drv.spm_data.mechanism)
>  		bioscfg_drv.spm_data.is_enabled = 1;
> @@ -153,6 +156,9 @@ static ssize_t status_show(struct kobject *kobj, struct kobj_attribute
>  	if (ret < 0)
>  		return ret;
>  
> +	if (data.state >= ARRAY_SIZE(spm_state_types))
> +		return -EIO;
> +
>  	/*
>  	 * 'status' is a read-only file that returns ASCII text in
>  	 * JSON format reporting the status information.
> 

-- 
 i.

