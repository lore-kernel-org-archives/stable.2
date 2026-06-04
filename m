Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFED39769D;
	Thu,  4 Jun 2026 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557911; cv=none; b=lsAEIgdEuk9QZD4jjxuBa1oPcMXd9sxxpD5hMOC4FZGLKfVDcFS2MZ97awhUWrJWpt9UIhyWaFBKn0t2pBOFxd9coMorugjmLhSOTJnkMhQoJEL1HhmaKOEQL21hDZX3m04Ym4wHGUaxrMkLzhWw9ZJjoQJpUivOSGj+XtQdDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557911; c=relaxed/simple;
	bh=yvdnK45/2ULXuJ9loITvJK08YLsCQKIUuwOQgcGC5A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8djKLm1PyPzNDodCW988o7OUocNsfJtk4Wi7C658+tUkQSVk3SDsddgf8qQDs+Rs0uC1tzMqpw5jJ9FYEyLfPKUvxDs4QTEj9BzfwRhSvvgwWDiefiZyMcvpH5pl0Qtmk0xkVRumcUOmB5Etin+EReTpnrEcaHjrf0EbTFCJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5ANhH4J; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5ANhH4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780557910; x=1812093910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yvdnK45/2ULXuJ9loITvJK08YLsCQKIUuwOQgcGC5A8=;
  b=g5ANhH4J7VemSHZTNOAg6uBp4XvfXmKqTCtHOpxy3IW0SSgHffYzOSOU
   iRI8vwaVYvYCoENzr7W625bibejzSI6JsEOIrwMN2PbaV32joNKPc6YBu
   GXu55B5XIszLufX4Y9NX5LCxe25BpN5lB5/vi+HnY1XGErYTl1kIi2vLr
   Fdha3VqOFuAz/0rKUJyZtuyK50hi7BAdL4NGJ7nn70DG+QekufV2XsjKi
   D2ncGmk7/7huJUuo8PBz999sFRdHzSQU60J8N+V+Gil49mkIscsXSGbyt
   YWuO5WGlKP0uY1ptdWRmPbduniR7anmcs63OQSv29J3IUk/4LM6IBtMGi
   g==;
X-CSE-ConnectionGUID: h9UnxOx2TzqsJf/13xf1UA==
X-CSE-MsgGUID: aBLED/kIQZOkj9XNe0Jn/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92064263"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92064263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:25:09 -0700
X-CSE-ConnectionGUID: QL71U5ZSSlCQiHXUqQ9JBg==
X-CSE-MsgGUID: pzvzDjtxTYCdL51HOz8OIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241969511"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:25:07 -0700
Date: Thu, 4 Jun 2026 10:25:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, hcazarim@yahoo.com,
	joshua.crofts1@gmail.com, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: return actual error from probe
 IRQ failure
Message-ID: <aiEoULtZmGpDd3cy@ashevche-desk.local>
References: <20260517181042.668-1-sozdayvek@gmail.com>
 <20260518094311.2000-1-sozdayvek@gmail.com>
 <20260518163647.3b4966fb@jic23-huawei>
 <20260518164309.04ed238f@jic23-huawei>
 <20260603182345.5fdb66b5@jic23-huawei>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603182345.5fdb66b5@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 06:23:45PM +0100, Jonathan Cameron wrote:
> On Mon, 18 May 2026 16:43:09 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 18 May 2026 16:40:48 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:

...

> > https://sashiko.dev/#/patchset/20260518094311.2000-1-sozdayvek%40gmail.com
> > 
> > Does completely removing dev_err_probe() here drop the deferred probe reason
> > tracking?
> > While this patch successfully fixes the return code, dev_err_probe() also
> > records the deferral reason in debugfs via device_set_deferred_probe_reason()
> > when ret is -EPROBE_DEFER.
> > Could we keep the diagnostic tracking by returning the result of
> > dev_err_probe() directly instead?
> >         if (ret)
> >                 return dev_err_probe(&client->dev, ret, "IRQ request error\n");
> > 
> > Andy, what do you think?
> Andy?
> 
> This is a change you might have asked for, but sashiko is correctly noting
> that we might loose a deferred reason even if the print is otherwise useless.

Incorrectly. IRQ core prints an error via dev_err_probe(). Did I miss something?

-- 
With Best Regards,
Andy Shevchenko


