Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296423;
	b=23kO7SE69o7yxqpO6AqvxK6xfmZ/XAY6n3+xVIMl4lHUeFCAc1FuliK3i/aueywtpMgb
	 uaunWGc5TinOUk7P94z+UycNONmP3qAlcTrhRl8bCLmwYE3NLNty5UBHHfD+z9xCLAAeN
	 r5bYwsk04ou9XN9RT1u1Wyen6EV6sd4k+YdlYQWa4OHD3mjQQSz7NdrQHCh7QnDoweIit
	 hPbwqMwoB7qZ4z9VtBUd5mQRJgKYnbJt8frI+rlf1gTRvz3WbtxkTS39HTTKZupU9YyyP
	 IMlDi0ldO7i/0SLKhOOyOx11GgFUfUSHUycdJsKV528qOxSk5EZkMrBhKQMEE9tNgEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296423;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SPioMWxnOdL+kHQp1jq1nkOF4l5e1JQvIQjfz7QTuc8=;
	b=abdMbtQRhRB8ZiGRSyUPlfb7g+KSggenhEr7EWk7m1GNLyLZ3WdDLrw6a/MYZrVYW+y4
	 cHpY4+hOGDlwEh+8kC6iu3AUgdqz0T6hRlUnAVaz5Towd/WaON0FAxVaHtP547MxeOAy+
	 /QhU/k6AG9typXnn5CPeBgvxQfsT8Ju2M2G1gLH9XF3+woxvMoFHyspzI+AkSWe/mlph+
	 cOBLH0UeyxiO5g5KeeQQ6eRcrtkIGMHyYBRFPi0s+ViqkRKGARND486a/PG3wtGsXY5z/
	 JsPLzKoGo88yeF5TSiPgX0H2p5qqh/nJMNhOfL8iBupjGo/Yk5xlvlr1LI3/j74Ynxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="eSzsyQ/v";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF22606A321;
	Tue, 10 Nov 2026 07:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF22606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSzsyQ/v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794296423; x=1825832423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tsMJE1u1zkJ1guWFYeYlwA88vKlxU9m6hwnX+/cYyKc=;
  b=eSzsyQ/vteLzUIqO3NfMtFg4PeflpBEQGzHXKRDwwGShtylmnJDhfgR5
   BOAUHnMxpdlcY5lbKQ5+6Zs2WL3DsKcHVh0zq8JUb1JnHvngBUxRrY9uw
   jviWXBg9QQfJoKM8PpMGmxWxgRaEXVn2mAyC5QAOOMDbuQG3HR8iCpYY6
   lYGLyRSbNC+E7njE2QrKPjI/Swg/mJLYLiDhyeUV+3dYv1/tP+yHLIrH2
   Ba+qrKKJ96X5af09mUvgfVCAz7duXnXUhViXFcVtdNBSy7gqBbApNF8AV
   mVImg1Yc8+kxo/dvDQJ5CVka14XPrAJ4j+r23gL1d7BOfB63nO8R3gzvh
   A==;
X-CSE-ConnectionGUID: tnT62/9YQ4SfY/21FIzKCA==
X-CSE-MsgGUID: cy17/cyMT56V+fVWJkfsLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3033782"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3033782"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 23:40:22 -0800
X-CSE-ConnectionGUID: 4NJFKSjrQo2YrxYyMR6ZYg==
X-CSE-MsgGUID: jkNbAVZPTtqzNkEWSS5nEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8409269"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 23:40:19 -0800
Date: Tue, 10 Nov 2026 09:40:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dmaengine: dw-axi-dmac: retain descriptors when
 termination times out
Message-ID: <avLKXWPp7Q4Z2uSH@ashevche-desk.local>
References: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com>
 <20261109-submit-dw-axi-dma-stop-pause-v1-v2-2-64adc48df793@gmail.com>
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
In-Reply-To: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-2-64adc48df793@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 08:06:01PM -0700, James Hilliard wrote:
> dma_chan_terminate_all() warns when the channel enable bit does not clear,
> but then frees the descriptors and returns success. Its synchronize
> callback only drains virtual-channel callbacks, so terminate_sync() can
> also report success while hardware still accesses the transfer.
> 
> Return the polling error before detaching descriptors or changing the
> peripheral routing. This keeps the transfer resources available while
> the channel remains enabled and lets the caller retry termination without
> treating the timeout as a successful stop.
> 
> Hold the channel lock across disabling, polling and descriptor detachment
> so an interrupt handler cannot restart the channel between the stop check
> and cleanup.

...

>  	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan, enabled, !enabled,
>  				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
> -	if (ret == -ETIMEDOUT)
> +	if (ret) {

Just noticed, this should be part of the previous patch.

> +		spin_unlock_irqrestore(&chan->vc.lock, flags);
>  		dev_warn(dmaengine_chan_dev(dchan),
>  			 "%s failed to stop\n", axi_chan_name(chan));
> +		return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


