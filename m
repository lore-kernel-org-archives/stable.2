Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724638;
	b=lkUMIUiDc8/lS4Mgcjad3HKhHOyzai0AU5xo7tKdNMmoKB6qL6sGn5tkhwB2JXVGrKt5
	 Y1Iie9IPAJ1k/2QVu2qiIFJug0gffcjiSgMYYoRARMPXwCxunxkmlyP92UDWPLwELKAIS
	 OeUbpFq/1QbvXv/rWq8BZQFYgxpIu9asbhA4TFi9QoVi0dd6TXhq7G9GB9UB6XAu/UlGS
	 qThZifrluRHMunB+pj6yC7qyzVYnnEhHMsmOO0hpcPamPcABYQc1kys/buDDFIyPKEj+z
	 li/zXZOabdqq0G4THgVes2+W6CcUx7OaDfuybxzpDK9mg2o+2Iow1kKXD10Pb74Im3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724638;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=yzpk6VNzLkbdccrx6tz6Pvz7oZb/B/kBaeEMJzrRmQ0=;
	b=lKO16ZZV3P0clT+mboxTAgz52yBstMGLsbcEsmF1oG4TIvT8tqbB0ehikbFbX0NPijPL
	 gjtN+6iFmprBYFGrncY4b7fPtX++dSCxbUAI2IQyCqlOksSdFbID9oYIh7HmOZ40/IEl5
	 ALGY8dM/DqjexXLyIjR+wCsDq7hOFSd1hBtF8Fp6I3npQIGDrQ+eynLmdzuN7k9aG1p2N
	 yHWvcKHSoSs7W/KkAuJBdQmGUVhUpgGQsFIPQ5RN/4ykKIUwNacyFw176hgS/BJtxXEGh
	 i4Oe1Son84kyQMPpqvQ8wkz3JCripQaygLYHFfbyJFQPKowTH7qV625rTW2akyTRK8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M6dIAKJr;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94984606A31C;
	Thu, 26 Nov 2026 20:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94984606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M6dIAKJr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795724638; x=1827260638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WOXL6O59LdMbGTGemwzZEjIOHymjEDmtjogzgCmH8Ys=;
  b=M6dIAKJrC1EhOwydrjDMMGzFQmvAsvGxJOYJE/zNPRA9yi+Ns2QPgbCu
   ly236hs2s9zVoyYbm+80uUo+j7CoStEYYBWuEbuD40yEigfEezOnIgh+f
   6bg/HJGWhJ9lfD+uPaSLLewVF2CIInCKW9G4EWZa/4eBR4CwNB1dxzxFV
   p+6+2fK3fAI3fWn7TiUe7nDcndHbKpwcgITPUhxRg2fBvv3JCV843y0ad
   4oRm4Dx910r2NnLFqmD9Hy7NAwUUR7H5COzc6skU8afOXJhdgmbcW0xSV
   4+7x4dsSrrgT7AgaaQBwEu22MdYtswhcejQ0gsIVC6XammRMdwDokFtr5
   g==;
X-CSE-ConnectionGUID: UnBCbpiOT1W9W3XC8JHfWA==
X-CSE-MsgGUID: ANliMafYTou+ipluDJqAhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4483385"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4483385"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 12:23:57 -0800
X-CSE-ConnectionGUID: LXHBBSfrS1WYegUxgJOYcQ==
X-CSE-MsgGUID: GsgCpKKZQvu2Sa2XAiLQaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="14014422"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 12:23:54 -0800
Date: Thu, 26 Nov 2026 22:23:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Gary Wang <is0124@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Daniele Cleri <danielecleri@aaeon.eu>,
	JunYingLai <junyinglai@aaeon.com.tw>,
	Louis Chen <louischen@aaeon.com.tw>,
	BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
 GPIO OUT not function mode
Message-ID: <awiVWP3CN4Jc3L1_@ashevche-desk.local>
References: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
 <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-4-81d35c9ba246@gmail.com>
 <awhPbIZjDazImfBf@ashevche-desk.local>
 <awhQ0mvdzSw9NaVM@ashevche-desk.local>
 <42cbe8ff-cfe9-4720-8d5f-685e7ff1c560@bootlin.com>
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
In-Reply-To: <42cbe8ff-cfe9-4720-8d5f-685e7ff1c560@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 06:43:20PM +0100, Thomas Richard wrote:
> On 11/26/26 4:31 PM, Andy Shevchenko wrote:
> > On Thu, Nov 26, 2026 at 05:25:37PM +0200, Andy Shevchenko wrote:
> >> On Thu, Nov 26, 2026 at 11:09:47PM +0800, Gary Wang wrote:
> >>> The CPLD I2C pin mode setting through pinmux-select is not correct.
> >>> Should be set UPBOARD_PIN_MODE_FUNCTION on AANT0F04 devices.
> >>>
> >>> Set UPBOARD_PIN_MODE_FUNCTION to 1 to prevent a NULL pointer
> >>> dereference error on .modes[i] for any pin group using this setting.
> > 
> > Hmm... bit how the modes[i] can be messed up here? 0 is integer
> > and NULL is void *...
> > 
> > Can you provide a compiler warning or traceback of broken kernel with this?
> > 
> 
> I guess the problem is here [1]. It should triggers a NULL pointer error
> when you select the I2C0/1 functions.
> 
> His patch fixes 2 issues:
> - The first one is the wrong pin mode for I2C0/1 functions
> (UPBOARD_PIN_MODE_FUNCTION instead of UPBOARD_PIN_MODE_GPIO_OUT) which
> makes the second one visible.
> - The second one is having UPBOARD_PIN_MODE_FUNCTION=0 because of [1].

Ah, I see, but why not fix the [1] before this patch?

		mode = upgroups[group_selector].mode ?: upgroups[group_selector].modes[i];

Shouldn't it be

		if (upgroups[group_selector].modes)
			mode = upgroups[group_selector].modes[i];
		else
			mode = upgroups[group_selector].mode;

> [1]
> https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/pinctrl/pinctrl-upboard.c#L713

-- 
With Best Regards,
Andy Shevchenko


