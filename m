Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603280;
	b=ho6MZH2dXqi+I2nYjtqMp3lpe75ltzDs0J40aJpo5AHKbeoZJ1k/buJhcdzrBfyyCIdR
	 v9dqRnUxaUkxqYj6mOEIQxGJZd840YL1PXBasJtO7RxhRqHxs9mKRWfFGD/pHv8qlK3Bz
	 jEV+pIV5WIZT5th68w50auLZb5r8gaP497K+eFBacy73ve7PjhISxe2ZYgxNKJLaMgah+
	 B2+oBDlIeqnlAgI2kB4iUknR4DK1RvZkKxCPCblXu3bdy9Yg7I0cRpH7xea9Z17tIYWdb
	 E+KDUc+9dGOsdF/4dKdfJLqCGM7iu/BkoyfFUzBdq086DbkenVZA9OJMMAPm7jwxlhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=aYnP9EzvQu5c7OzWw3Xivytyue2e+5YkT93F7KbL5/Q=;
	b=1fdQbJVgGIDSvuMDjQiAeRDAYiDDCnKYcdeSvVtmTyroM3/+lF6su6mz+S1tnMvrkYT9
	 vPBAAufuo9oA7HJp/nHkGoBvv4Q+R2Xa5H0PBUO7+WhHOxTUr+l5yrDzrLoz2CZMlAyP0
	 5TK50eyoyz8Xbml06M3A0g9q0OsArih+Gx9d7dLL2piyXZ8QBbcZ7FJwTeIhYhnFpPELr
	 U+ZnnAZ3js7/+xI1joKAoL+SuVhqOH4yYBWbdune//G8vAPxhxZjS7iR7HzjE/ZWA6l+p
	 e0B4CjKW8GSnEai9e8RHfbDYqVyc3Z0LbAdlPxPc2tPpsUzFXwREnNplWNvYg9Oz9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D2LCNvwu;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D300606A31D;
	Wed, 21 Oct 2026 17:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D300606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D2LCNvwu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792603281; x=1824139281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v7fSLTfyM6AlbgewY7IYOSHnM8YIN5meuZi9253LlHg=;
  b=D2LCNvwuOlF+wzPz9LdAodIh78N8/jFbepQ+fAC0lfzCLwzAGipagTcq
   BSPhFrG61TC0ojpij0RyeIKEjOScnuoUci7XDV33+UtrhqYcndU4U/hXC
   PQliKTkqcXz4S7cWuYHxHROfP5tn85t2yx1IL/pj9dlQqii3LLOqnrrz0
   B/svgvtFgYRJxh0InT1qV5lBm7+/B7M08KtrG/196QBCOzrHGM9LovJGA
   4qGWKeHkNLFRkhedkocROkOiMaEGaSbmXYTG+Crwx1/CMmg9oGUyCBjmm
   ct52SQmNSLMPtx8QaYBOOlNE7q8zXmceIQI4uC9vDSwinsum+U2ZXEozX
   w==;
X-CSE-ConnectionGUID: nWhcBqz/Ql6WIkni4RXEXQ==
X-CSE-MsgGUID: 9e/hdHWyQBK5JDYM38KQYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1344986"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1344986"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:21:20 -0700
X-CSE-ConnectionGUID: Z0kXF4sbQEeShgBC25pcTQ==
X-CSE-MsgGUID: ooYRJCglToWIM3GUM965iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="4939386"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:21:16 -0700
Date: Wed, 21 Oct 2026 20:21:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook
 when DLF is present
Message-ID: <atj0iRFTxHKmhxVG@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com>
 <athe0QikG2mzCAtd@ashevche-desk.local>
 <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com>
 <atjB-BnXclL3FcUm@ashevche-desk.local>
 <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com>
 <atjqZPuAbHDdaexv@ashevche-desk.local>
 <20261021170403.2052449-1-vinicius.eduardo.pedrosa@gmail.com>
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
In-Reply-To: <20261021170403.2052449-1-vinicius.eduardo.pedrosa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 02:04:03PM -0300, Vinicius Pedrosa wrote:
> On Wed, 21 Oct 2026, Andy Shevchenko wrote:

...

> > I dunno, I prefer just a longer solution, but I don't know how big this issue
> > is that we need to backport in that way (and not taking the whole series as a
> > fix).
> 
> On the severity: the IER restore comes from a7b9ce39fbe4. On the A733 I
> saw hardware IER left at 0 and the console stop taking TX/RX
> interrupts. I haven't tested this on hardware with a real DLF.

Yes. but is it only a single device/platform affected or a big class of the
devices? I assume only narrow part of them which unfortunately use DFL register
offset for something else in their RTL.

> Given that, how about keeping the small fix as patch 1 with the stable
> tag, and putting the refactoring after it in the same series? That would
> keep the fix independently backportable if needed, while mainline would
> still end up with the structure you proposed.

It all depends on the outcome of the above discussion. Maybe others can share
their opinions, but I lean towards a series-as-a-fix rather than a bit ugly fix
+ proper refactoring on top.

The whole approach doesn't seem to me like a pile of changes. The deduplication
patch can be deferred for later actually.

-- 
With Best Regards,
Andy Shevchenko


