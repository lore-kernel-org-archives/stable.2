Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBC43E083;
	Fri, 18 Sep 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725367; cv=none; b=EJHi0N+8xOOCYy1opQ7rxFGIbIM4PVJE/Sq1fHjhDpugx+IKuXpK1qgQSuZopsawTXuZaMWV7oKeYeXBwOVAZeLnITn8Y0g4F9m2CJDgdCAMI07FyWiseWZDm04jwqHJYwsKcNmtynzu0KYE7fRl6QNz4kxIrR0QOvxpWPp2aZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725367; c=relaxed/simple;
	bh=A/ox7ZE4vAif5kQLQDU5rNYE23M1iB2N/MfTE9UgpC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0+r3KfsXmDMnCIeB3kM1zfkQzkHiaKZS3XWMBHWuijrfj6zW7jBwI6Uc3iNSK+yMC3m1TkxgNDO1WiFo3n2EAfmwmFs85fJYCEw1SGZWt5J9+KXdTocchErZ2V8DN8N4dZFJ/6fT1oYv/dXCp0yJCOqsK/a/q8L/9+NnjqCC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0VnkkiP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0VnkkiP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725365; x=1821261365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A/ox7ZE4vAif5kQLQDU5rNYE23M1iB2N/MfTE9UgpC0=;
  b=F0VnkkiPtN8EHy9DG9gk0POzCVvZvrS/B+WqWOwoRUWlDFByWfMw6og9
   hvMybrr7DbvmpAlEok6YMIGVgsPk4rxsMGZp2cVJg2nq3fBcmEewtWkAD
   HHxtDVrrjccs7wxMvZ4obPWJeiTBIv20VHogugnSII5YwBsqhfBxadvMj
   mP0BvcrIK2loXosFBfbyH34MOiZxM0ONwAHvAGi1uPLLH65T+WDk0G7p6
   W+xJBctOn0g45Xyl79tTx7tDWF8YgPFBpT3KlqJ9iZu78xZnowvI+BXR8
   kddQHK1qlLlyNXHRUV6lv0OmShcU4X7Vx4j/Lz2ozpG1PYYU9d+TI/UUK
   w==;
X-CSE-ConnectionGUID: 2/DwYilwREOrlLudFNUKwQ==
X-CSE-MsgGUID: jibyqViZR/ORdUhKU0JWBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90086143"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90086143"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:56:05 -0700
X-CSE-ConnectionGUID: Qe9lG5lCTqyz1vefHD97TQ==
X-CSE-MsgGUID: 7mJg3ctFQcOJJehiRT7oHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268067818"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 18 Sep 2026 02:56:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 6902A99; Fri, 18 Sep 2026 11:55:57 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:55:57 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] usb: typec: mux: ps883x: add a delay after
 writing config regs
Message-ID: <aq0Krd3M5u2pbbYZ@black.igk.intel.com>
References: <20260916-ps883x-disable-usb4-v3-0-8f19386456d0@oldschoolsolutions.biz>
 <20260916-ps883x-disable-usb4-v3-2-8f19386456d0@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-ps883x-disable-usb4-v3-2-8f19386456d0@oldschoolsolutions.biz>

On Wed, Sep 16, 2026 at 09:36:33PM +0200, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> The connection-status registers need time to propagate through the
> analog front-end (PLLs, lane training) after they are written. A 30 ms
> delay after ps883x_configure() brings DisplayPort Alt Mode hotplug on
> the Lenovo 40B0 to a reliable success rate.
> 
> Tested with T14s G6 and IdeaCentre Mini with the 40B0 dock on the HDMI
> port with a Type-C host cable. Qualcomm firmware that programs this
> retimer from an MCU uses a similar post-config delay.
> 
> Assisted-by: Grok(xAI):4.6
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ps883x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index a5696aef054ee..15aee1d613b1a 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -7,6 +7,7 @@
>  
>  #include <drm/bridge/aux-bridge.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> @@ -184,6 +185,15 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
>  		return ret;
>  	}
>  
> +	/*
> +	 * The retimer needs time after the connection-status registers are
> +	 * written for the analog front-end (PLLs, lane training) to settle.
> +	 * Without this, DisplayPort Alt Mode hotplug is unreliable on some
> +	 * docks (e.g. Lenovo 40B0). Qualcomm firmware on platforms that
> +	 * program this chip from an MCU uses a similar post-config delay.
> +	 */
> +	fsleep(30000);
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.53.0
> 

-- 
heikki
