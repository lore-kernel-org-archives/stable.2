Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536904;
	b=FvV+pKTv0O56oq5MzXOjx5W6aImnoX9npRcT3JXC+McjmYWx13pHo0+qulvOcB7GW7Lv
	 2nBVJp/c/R9TY8dLkFXzZ/iOD8GwNBhsVDAha3W0NHWLFgQM9MsZsp2YEtPKc66zjNscM
	 rK0CAUa6110MV0tpJc/6R7lG+QUuTliGr4w4qU6JHQw5rCYRPOXHkJpSawk4g+WevpYJs
	 lYaviL/8u87q6Qo8BdWMkWhNPAKXnhZBOJOsnr42WWeteASdye2c1NOfeQ20NwvIdtgQ6
	 Nr0aBJZa1FY7T5Sblm9hTHZnN9CezoUhtwmljfnA0C4ZHuS7OUN9PbizcrfZ+9OTxag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536904;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RHxkH2GPmLHXkPjsAXrLRFUU5jEfIe4Bez2JHqsh35w=;
	b=L8JRGhnrN0eUq8Z+EKg1E/N5hxsTjQXDhAD/qt2ilhJrCmaH8DOOVVZdKJlr2J+4knpA
	 bEYEGexl75rOhsot+jwJNjaJSUEquyA8g8sP45/pIdqfwNwfVeJqiVTBxhNlgc19u8cmv
	 k28NMGCzo4CORg4qcdklCOf6p/QpZ1d86FP6QwRTP/qNESjsRNIJVJJWS3AW3f3U/YD57
	 C0MMrXG5ZGsy00VItWiXfDwJgA+dgvLAU6pXZIQb8Fse2wlxJH3e7h3/+ESt7k36lBQHv
	 U7CeWthHvr7bBf66WFkVrt0A0CBnQhlO+lVM3s+ldZVnlgcrrH6qR0sGRGTBHPmoGDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iXy7Pq7a;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514F606A329;
	Tue, 24 Nov 2026 16:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A514F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iXy7Pq7a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795536904; x=1827072904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzeLX9ti1t+Ugv3vNdL2nbp/JIyeUWoVMA/riGO9I5c=;
  b=iXy7Pq7a+GkfKhe4xqhmXGFqRGSjflZqZmqqh+MT1glXz5UFrc97HZAc
   NII1oo5eHHrG5Hdh3Ivzb5gO9jBpRoeZM6jP/BHkyB+RebqXm564o/pAn
   nts3QhbzmAPzKFvSorUukWKkBinezrA3p6Y42+jJUvOpzLVccYpSJaVZl
   NuoMDEfhcVWIJyMExGqqPPjhNRpgLp+mE/AK9JfeHzQt8Kzp2lIXfOXt9
   AQccLYl730HGGpPdaNli9VgabFhG5tTHw5xnVNBBpix2Xx1QPLbWLi3lS
   KWKw8hBzvbcL4DwiaY8rgHH7du4LntSEtZySTeVuVioTgu+wQ5MTgAdKE
   Q==;
X-CSE-ConnectionGUID: XsDB5lUzTk62ZFBs4EhbOg==
X-CSE-MsgGUID: pCxl/m9hTm6KTeUf6KbsUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4388946"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4388946"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 07:57:26 -0800
X-CSE-ConnectionGUID: NwJ6pDnCSC+2M2hzQUs/qw==
X-CSE-MsgGUID: iETDdrhGQje3wBK/54+Hhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11894948"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 07:57:23 -0800
Date: Tue, 24 Nov 2026 17:57:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: WangYuli <wangyuli@aosc.io>
Cc: westeri@kernel.org, andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, shinya.kuribayashi@necel.com,
	ben-linux@fluff.org, WangYuli <wangyl5933@chinaunicom.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: demote arbitration lost message to
 debug level
Message-ID: <awWz4bggKK0EJAng@ashevche-desk.local>
References: <20261124125956.755858-1-wangyuli@aosc.io>
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
In-Reply-To: <20261124125956.755858-1-wangyuli@aosc.io>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 08:59:56PM +0800, WangYuli wrote:
> 
> On a MECHREVO XINGYAO 14 (Ryzen AI 9 H 365) the DesignWare controller
> behind AMDI0010:01 repeatedly reports arbitration loss on the touchpad
> bus while the system runs on battery:
> 
>     [162434.524491] i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
>     [162437.878670] i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
>     [162452.208445] i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
>     ...
> 
> Up to 94 messages within one hour were recorded, while the touchpad
> remained usable during testing.

What is the speed used for this touchpad? 400kHz?

> Losing arbitration is a defined part of the I2C protocol [1], and the
> I2C core already handles it by retrying the transfer [2].  The driver
> logs each aborted attempt before the I2C core determines the final
> transfer result, so at error level these messages flood the log.
> 
> Log the arbitration-loss reason at debug level.

With this on debug level the observation of the possible issue is made harder.

> The driver continues to return -EAGAIN, allowing the I2C core to retry
> the transfer within the adapter's retry and timeout limits.  The log
> level of the other abort reasons and all return values stay unchanged;
> in particular NACK-type aborts are already reported at debug level.
> 
> This follows the practice of i2c-imx (commit 1de67a3dee7a ("i2c: imx:
> Check for I2SR_IAL after every byte")), i2c-mpc (commit 1538d82f4647
> ("i2c: mpc: Interrupt driven transfer")) and i2c-synquacer
> (commit 0d676a6c4390 ("i2c: add support for Socionext SynQuacer I2C
> controller")), which report arbitration loss at debug level.
> 
> As a consequence, the arbitration-loss message is also hidden for the
> last attempt of a transfer whose retries are exhausted.  Arbitration
> losses remain available through dynamic debug, and the final result of
> a transfer through the i2c_result tracepoint.
> 
> NOTE: The cause of the arbitration loss on this machine is still unknown.

What's the typo of the touchpad? Or are there more i2c peripherals that also
loose arbitration from time to time?

-- 
With Best Regards,
Andy Shevchenko


