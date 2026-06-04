Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078ED3D3016;
	Thu,  4 Jun 2026 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557969; cv=none; b=I++tR6a25J8QUUQdgHNpbQ6iJg0mj6cAzs6BN4p4Q3oTWQLntjl13Llm1giwHDBP+MX+6my7cfqawaPvIpF/vb/06y8xT/Lb/SCEESshmQvOVM+8K2WhrTYhq8GOGgiST/6qzVlJ2mR5LAb5uvGPOYYHciHkwpYauTo7l9/O82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557969; c=relaxed/simple;
	bh=9lfqJqs93hN9YXKOtmekrFKtsKQCcKLRN8VXdLaQfMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEM6N+zETMV7ygK1US/UVmF13FV2jmWqtLdSvVjvv0y6xI++A84rl8NmXDQbUt335kRp90+xL0n0MUoPLrYnZfI9bdlnUePR5nMmYlQ73+k3x8ae9fCc9vhFQUEAHlTckpxZNVG3EzT+ItmRNMY+T4jE9cCZEA3tFp6oUidufoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cY4DGOhs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cY4DGOhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780557968; x=1812093968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lfqJqs93hN9YXKOtmekrFKtsKQCcKLRN8VXdLaQfMI=;
  b=cY4DGOhsYLC2cgId8UAd8RMvDYcANcIuJjfWFgiQ/JiGoJekDb3OFkua
   6Q/jVrGqjeG0JyOZdbUBUcZLM40JXba+JenIRiL+biqiBGHVcJGU43qd4
   XNZfxRdjIGYQ8/WV684EutqEcQCockmNacylLKbT1+94RsL4xe9EHcT8Q
   lBaVJZHE42IGBgxkGQMs0BBIYfBT3P8IG8MKc8/SEBwDHwh7AcnCz7SU4
   Zy1l1hU7Quq9r1L6mez+iTLdgT/NzRgQzDrav/pEhT/+lvqNK3ASFjosx
   /2vRE/E3WuyM3e+aOkHmxOdEMrJzvhzn1PcL0WVaOtNiIMsFfWJN/9mv0
   Q==;
X-CSE-ConnectionGUID: fGmM27QaQqOiz9NP+MBo6Q==
X-CSE-MsgGUID: dxMU2ITQQmeAGiEBDYqO4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85233316"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="85233316"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:26:07 -0700
X-CSE-ConnectionGUID: u4lclCPPSU+lSYE1YK7C9A==
X-CSE-MsgGUID: 3yPvoYTtRf28rpL9VvQj3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282575058"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:26:05 -0700
Date: Thu, 4 Jun 2026 10:26:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, hcazarim@yahoo.com,
	joshua.crofts1@gmail.com, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: return actual error from probe
 IRQ failure
Message-ID: <aiEoilRNQuHR_dqb@ashevche-desk.local>
References: <20260517181042.668-1-sozdayvek@gmail.com>
 <20260518094311.2000-1-sozdayvek@gmail.com>
 <20260518163647.3b4966fb@jic23-huawei>
 <20260518164309.04ed238f@jic23-huawei>
 <20260603182345.5fdb66b5@jic23-huawei>
 <aiEoULtZmGpDd3cy@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiEoULtZmGpDd3cy@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 10:25:09AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 06:23:45PM +0100, Jonathan Cameron wrote:
> > On Mon, 18 May 2026 16:43:09 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Mon, 18 May 2026 16:40:48 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > https://sashiko.dev/#/patchset/20260518094311.2000-1-sozdayvek%40gmail.com
> > > 
> > > Does completely removing dev_err_probe() here drop the deferred probe reason
> > > tracking?
> > > While this patch successfully fixes the return code, dev_err_probe() also
> > > records the deferral reason in debugfs via device_set_deferred_probe_reason()
> > > when ret is -EPROBE_DEFER.
> > > Could we keep the diagnostic tracking by returning the result of
> > > dev_err_probe() directly instead?
> > >         if (ret)
> > >                 return dev_err_probe(&client->dev, ret, "IRQ request error\n");
> > > 
> > > Andy, what do you think?
> > Andy?
> > 
> > This is a change you might have asked for, but sashiko is correctly noting
> > that we might loose a deferred reason even if the print is otherwise useless.
> 
> Incorrectly. IRQ core prints an error via dev_err_probe(). Did I miss something?

I'm referring to implementation of devm_request_result() in kernel/irq/devres.c.

-- 
With Best Regards,
Andy Shevchenko


