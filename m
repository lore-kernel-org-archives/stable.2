Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B73B8BC5;
	Mon, 17 Aug 2026 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953118; cv=none; b=untUQmatXFx3TpP6X4f159q9C2x6EjtJDcyPm/DlpCxNI3ZgkIF85/rIFW7qUD9pSD3ynSEfe370yaQXjd5e2aPa5YQ9P5TUC9UbN7vtZr7XcPHi85ykW+1jlqVlig1RwaMs+xmcMDl3qxErORtiy0SSLg6EP4DAQp728wQMRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953118; c=relaxed/simple;
	bh=LHfMDwPMoqylln53hn4Kdv4hVqChKrcPW44rdRIyNpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd+60fKBitjCPGB29UcVWDFWh/IIoUU1vcNv5N1Wce46uDg2CX+hoZMb8MsrxGgrMWKqmgnFwbcFEinihryjesQRoqeBkELdLs5NiJA4G5Dzur9qZ0Q8YhnclUIdeJE4C0QhRMIzgr8rD/2s5HFV8RNMt9tLRtIeuor4YmFTrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADKcZDyb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADKcZDyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786953116; x=1818489116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LHfMDwPMoqylln53hn4Kdv4hVqChKrcPW44rdRIyNpY=;
  b=ADKcZDybz3LmzqWMwZavvRuaCM+jw0LziMpEET87W47Hf3qPxtoKoMWV
   kCZe8c6c3rMouUixYm+EJUjpQG7dCFdVt6BxLXinYOlgVnVkUuwzcIDXb
   AabC3cTk6xtcAIc2KZYeiHEEl6u9ffMQjHm8aE5gQdtm9PvTpiB/UzFXJ
   nnZRMgbpI3naI8HCSqpUVkmNBpUqypHpgdMj0BKUOz7eo18Wxhpp1M73m
   eM8/p7AZ8LTlK0TY3u0NAHm0f9Y4rKwOlXNRJqU5CTLKwedaJNKBqrc1/
   dKp4JzKtZvs+fUTdKt7JG603gh1tsRjrj0+PSdQLXic4FB5N0P3tRYXyQ
   w==;
X-CSE-ConnectionGUID: 0mO727BjRtOvauQlTcQhKg==
X-CSE-MsgGUID: F03SA3+tTHSMypDbD6CjfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87630226"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87630226"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:51:55 -0700
X-CSE-ConnectionGUID: 3OZJBzbTRW6e/JjaWoteZA==
X-CSE-MsgGUID: diYnDrFaRRWNchO0KtSWMQ==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:51:53 -0700
Date: Mon, 17 Aug 2026 10:51:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v3] auxdisplay: charlcd: cancel backlight work on
 registration failure
Message-ID: <aoK9lOXf09rFbuZs@ashevche-desk.local>
References: <20260815105950.1109-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815105950.1109-1-getshell@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 15, 2026 at 06:59:50PM +0800, Hongyan Xu wrote:
> With CONFIG_CHARLCD_BL_FLASH, charlcd_init() schedules bl_work before
> charlcd_register() calls misc_register(). If registration fails, the
> caller frees the charlcd object while delayed work still contains its
> address.
> 
> Add charlcd_deinit() to cancel the delayed work and turn the backlight
> off. Use it for both registration rollback and normal unregistration.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


