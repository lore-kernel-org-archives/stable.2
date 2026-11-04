Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792055;
	b=Gjr5vDrXyxoosvnOwB76C98FXA2Sw+IjOzZdNhj+x9FOpF8QDP0xa5GuCqC4SxBTQ7O6
	 Aq17XtSndLYBOqvQ2SNVypxgxDQmgXPXQ0TwkYjygfzNL4Gj51ApKaGWky/6ngTmEGpNS
	 FgD0st67XZmzZWtpAnR1Bkrn2u+xYpTvd4CnE7qhHrNl144zQjBkaRqjZKwuWgBgk1LEB
	 hd01cwOw+Xzf+35pOtkZdbL0XeawIRpJArerOMeazn8hkBJzmFz6cb2wmlsI/KmIBqSjP
	 SklVOKGebhZFQyuKtZEAJfUivKUA2dfDFt5ejd1INbat5jvvhq03noZii3iAGKH1J7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792055;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RTHNRS3cuSeG5GDbUcMOi27y+OoEx5qcLeQYW+KCpYY=;
	b=ZozV0YheYO47yynG0rRamyV9bz8okKPPbb6ucdytDtWvfdpepKOaktXZoNdrmjtuD1Dg
	 Dt3y98xXTK8f75quuYeoqgi6oxkcrp6nXbGTpgIRnbXfm1LvtXep3ZlSpwNmZs21cPOXr
	 Zj5E2n3UDY05CwWX950nSqv/DJIV16GAaxqJbh/Dbni6DYQ/7AVAseTWLCl0vhYLBR7q5
	 oOfBCWWtiE3koWfOUT/ws4pwDEbvRb4mM2b+NrHjansQIQxjsfywfQ4eMrKtSpUdVmGzU
	 V+cD5vvNx10k6jSyI1tjv3JbVtifMcVSpXM4HvVq3GL5MRx3/cuY7mUh1192rfUqI9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lsI9xpDR;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A2606A31B;
	Wed,  4 Nov 2026 11:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E81A2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lsI9xpDR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793792055; x=1825328055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v9T4a1onP4WP8CqdupXINDZUewTsnnH+98JgAdSfLjc=;
  b=lsI9xpDRQxVhMNrtF1gA8l+SwWr6pVpJrWp/7RU2G1i4o6JG2QT3ADng
   1nHsw0k8rcFPA0ReAVU3vYIqc7nKPNaXhvH4NcqgTZ5MLzuFcZ8WSrefj
   5lt4D1aQEfkorTiGVK47Cp+bWcWUY50zjT18iSxgJvmDvLCjANeI3ypd1
   6Q4vzRUighUq01EDfTv0TCLR/PcmqQ1PPcd4CxUbTcScp5EMKw6uMTHL3
   wT4wEPjKEXLXUKCmD6mQDRl1zIr1Ng7H+hO6lrHzn4O8+2lxMg/5lOMFQ
   HBZfsfe95qbW4S+Wxq9fcWe7FNtx/ZEeVtncZDBrnK0i2x2Bh1vHnzJ7x
   g==;
X-CSE-ConnectionGUID: WD05TyRDSeeNEs8xwLH7YQ==
X-CSE-MsgGUID: szQmW1DaT8uZ6StiEbm7qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2440211"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2440211"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:34:14 -0800
X-CSE-ConnectionGUID: Bef6jIsfSKauaMUyVnm8cg==
X-CSE-MsgGUID: jW3Lgd7FTcy11iZ7JV6hTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7013601"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:34:12 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8FBB9121B88;
	Wed, 04 Nov 2026 13:34:20 +0200 (EET)
Date: Wed, 4 Nov 2026 13:34:20 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, Arpith Alexander <arpith99@gmail.com>
Cc: Lixu Zhang <lixu.zhang@intel.com>, Weibin Liu <liuwb@xiaopeng.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: ljca: Don't require data in write replies
Message-ID: <ausYPKtlMva6I94z@kekkonen.localdomain>
References: <20261103131435.21838-1-arpith99@gmail.com>
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
In-Reply-To: <20261103131435.21838-1-arpith99@gmail.com>

Hi Arpith,

On Tue, Nov 03, 2026 at 06:44:35PM +0530, Arpith Alexander wrote:
> Where the Intel Visual Sensing Controller (IVSC) is connected through
> the LJCA, as on the Dell XPS 13 9340, its initialisation fails and the
> camera behind it is lost:
> 
>   spi_ljca usb_ljca.ljca-spi.0: transfer failed len: 256
>   vsc-tp spi-INTC10D0:00: SPI transfer failed: -5
>   intel_vsc intel_vsc: error -ENODEV: init hw failed

Indeed. I can also confirm this is the case on Dell XPS 9315. I guess it's
the same on all systems with LJCA.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Mark: can we get this in as a fix for v7.4?

-- 
Regards,

Sakari Ailus
