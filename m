Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481355427F9;
	Tue, 22 Sep 2026 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080108; cv=none; b=hZItHC29q9SxtZO1jaJUlwzEn9WimZZ94FB7dB9hnT46eIDNaYiv3kQ4u2ALlzdH/HJE9a92w847WC1f7VANRp8XSxwS4baYZHI4Dl8GWqJwDrnn17NOgSoS9tDkjLoiizycYn5bia8pajXL9IpnBP30bMhI3b7/g31Ho9bqkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080108; c=relaxed/simple;
	bh=EWY9Bvnz8rYWx3ifpprjhjFA3DIBpRife5PllKzgFkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwDei5O2MMQi9mg+puv77jFBC95ZnzRDG+a3bgHa5cPQAbgVeBve/btab+Kyk69tZNdWbWEs/ldQqYCePf7mq7CidjMCN+Qm1+f2W5QKv1MLl9aQPkXvOnlBM9xOv9MJsV+tm9DirOudwG7gMC+GL+gCdD+u3A/8OiZ04PL8edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+2yrDeJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+2yrDeJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790080106; x=1821616106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EWY9Bvnz8rYWx3ifpprjhjFA3DIBpRife5PllKzgFkU=;
  b=Q+2yrDeJ4Cobb7GKAnbsaizErEIA6b+gu8/ypzYCfbgNM4fjk2FnlOCX
   8HYg3gjdB3d6XXHHXUfExMssdSloeHEHz0qA4s+70kjVhIOZHOYOziP0Y
   CXqY1xToGdR1+Oo/wUe5RY9sodbAHWd2fAnh8WPb/AWPWwsapRjg44Ozy
   4aEUHPga1vF2zjs3tDcF4gCrv/GlnwDQb68gfNdme8Nv4xAJg4UYshWOD
   rN5T3tiODiSGPuQhQm2bywCGe93Qvdo0SyakWYAoVdKqr5j2kLDJG+j2c
   5/jMD1THuEosM3IYjf1h9Nk47SFHeAZGwTVxfpaq7MvNVMYOaEOUwSNrg
   Q==;
X-CSE-ConnectionGUID: um6dUMjHSSKaEfMfSQoJ7A==
X-CSE-MsgGUID: eyV7aLxGQ/WIvJEoSNl00g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108175236"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108175236"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:28:25 -0700
X-CSE-ConnectionGUID: MSjZ7MenTlKCG44pM6XfDA==
X-CSE-MsgGUID: 9XqblcrdRCOZIhU9GkIf0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281172922"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 22 Sep 2026 05:28:23 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 3026C99; Tue, 22 Sep 2026 14:28:17 +0200 (CEST)
Date: Tue, 22 Sep 2026 14:28:17 +0200
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
Subject: Re: [PATCH v4 2/3] usb: typec: mux: ps883x: add a delay after
 writing config regs
Message-ID: <arJ0YRr5zhZU76Wx@black.igk.intel.com>
References: <20260922-ps883x-disable-usb4-v4-0-0a7b5b70cba3@oldschoolsolutions.biz>
 <20260922-ps883x-disable-usb4-v4-2-0a7b5b70cba3@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-ps883x-disable-usb4-v4-2-0a7b5b70cba3@oldschoolsolutions.biz>

On Tue, Sep 22, 2026 at 02:20:20PM +0200, Jens Glathe via B4 Relay wrote:
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
