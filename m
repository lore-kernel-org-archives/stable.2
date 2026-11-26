Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706755;
	b=jBOvo+QjUB7zswQk1vnEC2WwLEG1VuXPGi+XYeoeaSRBW2y12u3FLbEp6ntTp1WWR8EM
	 UTq3yj/X1WiHzqF1AmDO4DOiDlsGuivhoE3Uar/oDCFvxW83IC8RZLUhr9sfno8mRrVbc
	 eEpr9bNcGHYkklfIv9sBNrW1S+X/Rv0GRShBTxmY9EkLuN5cm9HgkQVeWc8FZt/GhnkY2
	 95NOiDd03y42cQNOjy/LvKebjEYr+elo+7R1UfA5WDOUClVnig7vdit96ZsB8yisrw16Y
	 r5t4PhokpWBvcL0rZ78wEFIqEJ4lAddXa+8JxwYHyTKSEW96I4e8Fehckb7QTZoQsag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706755;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=KMptWImjHXycMNTW8oPyt+TUsWhqT9gdSiNtzXrM0Gg=;
	b=WzyVrAviQRN8rvibIN3JLvucCLc/x8jQJoihpikYvQw0XpzuYYUO1AG52DbLUo+QbdV6
	 j7r0SQ+jXGHmEfcMil5McDdFjQOriKpXu0vuJ+Z+voJoeJdhKA/TJJ9vYsD7AH3dBwP9T
	 rELWMaYaO1GheItN2vBRhHvhDhOTPZOGulxQwrVcqMA+bRD2fomkG2qtvZU0QJ2evHtog
	 W3BSApBRRTfDaN7v9uUBoCnttZZ5j5qTzTorpS892nmUdExOph7S16qZyeMQZDqyGROXx
	 vlIV2FBjFHt+KshNaxO1M5+D8nxzlahpSx32h95xmMNezH9OCMMpL3kMJzaxFNU9oyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KbwvB+6R;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D048606A31E;
	Thu, 26 Nov 2026 15:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D048606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KbwvB+6R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795706756; x=1827242756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bge/QNbozAwSy7v+JU5WeK6/7O+gLlh/hdbIgD/7JVs=;
  b=KbwvB+6Rsmsq7q90idSQazzh+V3zx8OIU8gBnGMAmFp4UpVMDefcWRtt
   cPweaSDUKp+EUURxBJXru11BSgpt/e9Tm07ApmsVAj0+zDUS6RZKHLSuE
   Fjit+wVYyCIzPTcyRwNs8rnEkvz3mKpea7NuWCmGJGYcwG/C1PSX7ikBY
   nc0XUjgr4TG1amQcTWshJiET87DrN51u9FBtCRKEURzBMAWqE4jl18WZ2
   z9rqhXqieq0mrLGt5p5GojbQC4oFva11yqFKnoGlKy6+jo/AwwRmtfDxS
   FgmGEofgozGZkIXBuDQDDkr33MY0HvsbjqXQknlHtgiPndgRFt77URIMP
   Q==;
X-CSE-ConnectionGUID: fmx0hZR2RyWY6QGULaVO5Q==
X-CSE-MsgGUID: CCEjsPJgRh+a5BFXQFGueg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4525689"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4525689"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:25:38 -0800
X-CSE-ConnectionGUID: bFXaUQIIQAGwk6M3YJCFVQ==
X-CSE-MsgGUID: S7nUUpvRRVCk3tBXrynx8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12795244"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:25:34 -0800
Date: Thu, 26 Nov 2026 17:25:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gary Wang <is0124@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Daniele Cleri <danielecleri@aaeon.eu>,
	JunYingLai <junyinglai@aaeon.com.tw>,
	Louis Chen <louischen@aaeon.com.tw>,
	BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
 GPIO OUT not function mode
Message-ID: <awhPbIZjDazImfBf@ashevche-desk.local>
References: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
 <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-4-81d35c9ba246@gmail.com>
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
In-Reply-To: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-4-81d35c9ba246@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 11:09:47PM +0800, Gary Wang wrote:
> The CPLD I2C pin mode setting through pinmux-select is not correct.
> Should be set UPBOARD_PIN_MODE_FUNCTION on AANT0F04 devices.
> 
> Set UPBOARD_PIN_MODE_FUNCTION to 1 to prevent a NULL pointer
> dereference error on .modes[i] for any pin group using this setting.

...

>  enum upboard_pin_mode {
> -	UPBOARD_PIN_MODE_FUNCTION,
> +	UPBOARD_PIN_MODE_FUNCTION = 1,
>  	UPBOARD_PIN_MODE_GPIO_IN,
>  	UPBOARD_PIN_MODE_GPIO_OUT,
>  	UPBOARD_PIN_MODE_DISABLED,

This won't make it robust enough against shuffling. We better to assign
them all.

-- 
With Best Regards,
Andy Shevchenko


