Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564952;
	b=27kinaX3vXBEj8Yzqs6XOnGIQdt7byTOTtNh4ES9URsTWi5flJiK/aKhZpMADvJak/v3
	 rTw+0Po8vkdWTefjI9kZa1JQCORxjaivAH9fEaOaQNLB+1K0RP0MZwtHwVRyMPFmHeqQv
	 OCMMZeqvJfwkPJzQUJWs/0uuDYDsujQkxXDLxqLanj724x8NDw0VZDCItQ4TvkcdTB6gB
	 SKFIA43mQzU3Hlb9QqzOESoUX8X50nB7jeFs1Ucq9vXFlTrqkoQ0017GhfVfwqkfE38Wj
	 EDA3Q2ozTp3lFXGaOWLFNxzFKEMg05FcEfZX2ZFd14C9Uf3Gin0nSfqAcFMwclDSUzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564952;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=xKvnDsvcrUclI7bmfx6XSwXsJ6fBbrciYsjEvfxco8Y=;
	b=IMmW4PmB/KiWw4LvDuyl7JXGP9C9Oqk7syiz23m+kmBQHireDNeWtNx79I2GS0RgzV6S
	 WrW/nBo9/H9Qk8ynOFXDoGqLYT94pRdi8Tz9whP5JecwXLNKIe2YOunsUGIjAeZVMjNDr
	 qvyyM7BDRAzHl9vL7aAoJn4U9WqSKObE4kg5/RmGZa6CIruNnnMz9lxpvOwewkR0qP06w
	 zecP4hm7ygZAQWxq/2UIw0DqMjH71bajTS4YGwEM0sADSo/zp5elH0hCOETiuU1KMtj4v
	 HXeAEnfxkmLTLa3E2Ns8edUteBgIG9yTK+hsBQ5lI+Ps9cHZXP89HH7izLuTpMapjtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="gm9Zci/5";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8BC606A31B;
	Wed, 21 Oct 2026 06:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB8BC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gm9Zci/5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792564952; x=1824100952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u83JnWYhV8tXdA0VeD7wuq6PNl1DjfWmUWC3duEyOH8=;
  b=gm9Zci/5WaqFocMzIscm17zBUWD1Q8qgP7xmT49eFc9s7CkglkN9viWF
   7bV3BBTnHdFHn9HEfIZYGvlmDwiVHGs582FAkfCl/COCxJWC1jxMetUx4
   39X0H342Y9CoASbiC80hMuajN9ZAXQS/qlzmh00zMcV/Ag0di50TVXj42
   0uzGVDaHGY+aJBn7yn05jLwlD1RoCH1AssKUwFiQQcZTPUVNtOAdTaPr6
   wkvQ0o80+vwAIHJMDmh7KcXw1zuHb2xi9/BEbOYTrszwmpt0zXtxaoS/g
   BSdFWybWQOOrLh5Yp+yBNpB7sU0bY072odaoeMQM3KJnr72y306IYSLzc
   Q==;
X-CSE-ConnectionGUID: ooLIIyOSTEyNqVtrdYIqxQ==
X-CSE-MsgGUID: vi4dXOAJTBO27ClPI85w/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1261929"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1261929"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:42:31 -0700
X-CSE-ConnectionGUID: a+ZzgIexTNKCA3Xwk92Tug==
X-CSE-MsgGUID: kakhjIkcTQSPqoihcgSIvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4809657"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:42:28 -0700
Date: Wed, 21 Oct 2026 09:42:25 +0300
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
Message-ID: <athe0QikG2mzCAtd@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <atcrpTI_R4kRM8pb@ashevche-desk.local>
 <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com>
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
In-Reply-To: <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 07:47:53AM -0300, Vinicius Pedrosa wrote:
> On Tue, 20 Oct 2026, Andy Shevchenko wrote:

...

> > > +		/* Keep a hook the driver has already installed */
> > > +		if (!p->set_divisor)
> > > +			p->set_divisor = dw8250_set_divisor;
> >
> > On top of my previous reply, why is this hunk needed?
> 
> dw8250_probe() installs the BUSY-safe dw8250_set_divisor() before
> dw8250_setup_port() runs. Without the !p->set_divisor check, detecting
> DLF replaces it with the dwlib setter, which is the BUSY problem
> described in the commit message.
> 
> > In the case of existing _set_divisor, do we want to keep the possible set
> > _get_divisor as well? Shouldn't we introduce a respective _get_divisor in
> > 8250_dw.c?
> 
> 8250_dw.c doesn't install a get_divisor, so there's no existing getter
> to preserve.

Right.

> The dwlib getter is still needed when DLF is present,
> because it computes the fractional part used by the preserved BUSY-safe
> setter.

Right, but have you read my second question in the above paragraph?

> > But now I see that we have same function name in two files. Can we rename
> > those in dwlib to, for example,
> > dw8250_get_divisor --> dw8250_get_dfl_divisor
> > dw8250_set_divisor --> dw8250_set_dfl_divisor
> 
> I'll also clean up the naming in v3: dw8250_update_dlf() with a frac
> parameter, static inline after dw8250_writel_ext(), and the dwlib-local
> helpers renamed to dw8250_get_dlf_divisor() and
> dw8250_set_dlf_divisor().

-- 
With Best Regards,
Andy Shevchenko


