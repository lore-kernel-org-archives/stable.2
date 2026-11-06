Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974290;
	b=r8sdOLrvwRFXPwo5JzafdF3Li5ZtJXs2cWwuU1SymSbZfrursx2rRCsFO9DBKla9mM6H
	 6urD0z1MDKz8zBZafB2vB+8rZRHp1O25aO6j5yUya/PjgGmX5ETLtF+rhsZyJnOrLnEef
	 a2W7BDiEfLtutr+TGwPvE1nHFfLsBMZBcFM4sZG1TKHF8o9cVdaY6TxlGr20K/9Yf62Ah
	 0PLLzgdqisqpWGRVeLtWzs15AU4oorXmuvMA5xzGSfBcGT1OKtQBSk957eMdUDiKwRrH3
	 VxRSC8p0fqvTCfny4Z0wr7F7Q2jWptpbZXbas4d16GXGLN4r8seVg+cMkgkNrL+/8Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974290;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gtfqCNvLHDyiv4c2Kn29UjMs603cMC2xqAYSiEZDCwQ=;
	b=vUjZHus0sDAThMdgo+zI6kd9mlebesRXLBYJlL6xjPEwdatV6OEzCCF57kW5tAsWSya7
	 vfxeOs1crw7CWU3uIH8umRgbUN0kHET1kXFFMz26C9QmV2YTgDvszEHT4SHJtSVWw2z8B
	 j3rplIN0szgzwdgkGa2kQ/oftPkUrx5MSlfR+SPMBlZNLdrK1KZhVm1SJQ5D1kd5lJNEK
	 IHWwrPTn4SyZgfwgZ8WEkrU15bKFPyhwWDe+FnO+OTCbjkL6zU6cSvmCQExovrVGFWay1
	 LP2YjzJ9JfOGLO1cgdOkdK5tCbuZSOjajQCS6kdmtnoIgOU9997DDGij7y8dUJg2r8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N9n9RNs6;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BE606A339;
	Fri,  6 Nov 2026 14:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA6BE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N9n9RNs6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793974290; x=1825510290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/7bk55UzAnjm3jvyAi6pETmW+q2057bMcuWPbRah8w=;
  b=N9n9RNs6rPYr764EtwFlnKlCObv76cgQHOoT2W+Yx2oQksm6SekufFG7
   U5spSB2mE6pV6EvEjZu79x/vjxIsA5uUdvY2rF4fGU3jRB0o2kToM4Rbp
   o8308sBppJVpYIPIZ+5TSAx37fLN8SldiZy+mVuWikAs6uRBkl5yyVXax
   V8laZbzlBeuIcXDeH2/4D0mbzPMq8I6sfNHTHjfKmvNWj+7thEmenlaGl
   FI2D7yHTOh7yxCDTemmDtqBtjS+azaNzQlk5Exks/omVSO1MbRpsrOGrc
   FvSG+JiKMYos2xiNYFtuMsQIPJD8ABFFPZTZwwq/1bIoEDxDg22YEHMJ2
   A==;
X-CSE-ConnectionGUID: SCs+APNsSQSD4tPdveuVGw==
X-CSE-MsgGUID: VJAERveAQXe+pzjG19rBaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2701800"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2701800"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 06:11:30 -0800
X-CSE-ConnectionGUID: WXArV8rMQhK+JzOQM06/kw==
X-CSE-MsgGUID: 0TW+2K0kSbKmLYWykV5lDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9046669"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa011.fm.intel.com with ESMTP; 06 Nov 2026 06:11:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E346799; Fri, 06 Nov 2026 15:11:26 +0100 (CET)
Date: Fri, 6 Nov 2026 15:11:26 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: of: fix potential misconfiguration of hogged lines
Message-ID: <20261106141126.GG176724@black.igk.intel.com>
References: <20261105-gpiolib-of-hog-uninitialized-v1-1-fcaeaccefab6@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105-gpiolib-of-hog-uninitialized-v1-1-fcaeaccefab6@oss.qualcomm.com>

On Thu, Nov 05, 2026 at 02:37:52PM +0100, Bartosz Golaszewski wrote:
> In of_gpiochip_get_lflags() the local variable xlate_flags is declared
> without being initialized before its address is passed to
> of_xlate_and_get_gpiod_flags() when processing a devicetree gpio-hog
> child node. If a driver uses an of_xlate() callback that doesn't update
> the flags argument (like gpiochip_fwd_delay_of_xlate()) we'll end up
> passing that uninitialized value to of_convert_gpio_flags(), potentially
> misconfiguring the hogged GPIO.
> 
> Initialize xlate_flags to 0.
> 
> Cc: stable@vger.kernel.org
> Fixes: d1d564ec4992 ("gpio: move hogs into GPIO core")
> Closes: https://sashiko.dev/#/bug/linux-2bb44847-fd6e-406c-878d-9739da2cb8b5
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Mika Westerberg <westeri@kernel.org>
