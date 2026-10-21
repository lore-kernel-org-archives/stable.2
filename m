Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600685;
	b=r4Tvde4OfSbaz4mh+Cu8rzuwMz/AjBHQ3cfMcQccToll7V22PoJvywwVyXi3ZZpCyjq4
	 xQsEtrK8HEWRSnF5XTLfEbrFgPgbmCG7qNu4zCrTGWXvmwPEqBpO6vUDKsm9XimGAqwsf
	 UUkpBvq2fbDSjfSsqF+uQatDcD1PvMPzD3Fho8J5vDOzXOTUfOrN9gnKih94Y28OsC2AJ
	 R5Ve9tpHox08cmSv848tEv4JF/6o5h2VPeBdvYg1DFFXu4w4dc75DC44oXLwOFud7NfKA
	 xhu4tXPtlc5+iuAThwCzz++iikdfpsaN4nhwG4vNV9ucv3ALluK5IDFFa715lFRe+Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600685;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=McunKYpk3SrrPsRKqQvoEpYeFEb35U72fbcZI0hzJ2Y=;
	b=mOHFTYnalQMfTEtCbZAFX3Yaij840SaFMVpIzRjbDBZxPl260+K9v/L3gstfhmIFx1Sw
	 DFCDRkyt86BpUbyMYqVQDunSK+Y13mzRdserV8WEKO/aDqZre6TWKaIXY97BvjbSde0xS
	 j5yx0ad7w7GX0HGziHmlMv7PvEwAif4J5JhaEAuq0TWIMl7x21R1CYne0+EapSr1v0BL5
	 f7SQyMcgfFRwdUMABVlq0ysEAw87ybBLXpmZBNBzkrhXt4w1vFFQR/YH40zLFsFLwJ4FH
	 PRcH0NXgJHvWG2cLnFgbsL/93VI0pESbDQKS1vQqTKS0kTnrDS9drjCmOJx+XLA3RvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SFaKqm+P;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC83606A31B;
	Wed, 21 Oct 2026 16:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC83606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SFaKqm+P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792600684; x=1824136684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vMG801eKnNULxoZLCiadB9NVXk+XUs6yYYb1ZD5sjAw=;
  b=SFaKqm+PgJpRCIjiRVjeeLjlr500iLB/yKNjqtN5b8JXYzHsiMbQGIBX
   7tXcmUPeibM2P8PKzSNnjJ9GE4/0HVpiONZAeI7rh0iDcRU0zRQbwnqp6
   IEwXrq+kfpSySssmyPTcU5KcA6650gjMWW1bsF1U6dHdGjNdlVmTfNU7T
   SRyo1cCRczhmzeilaIkBTKGp5zxujSiqrXb4+68E1GaDU1KlZaqEsaV3F
   eF2rWyUxlbMAT1f8Ud4vZow5I4L4WD4ESLFq4+bOLUquCnJjWjGhE8y7B
   fYvP7bjpNIaUafNBsUCGjIBXHfOUVwagdOKvTt7qjt4dxBPCgklDVArCG
   A==;
X-CSE-ConnectionGUID: DvFrceVfTmGo7LJLUoTmdQ==
X-CSE-MsgGUID: /mI7qV6CTv+fAJzNyY2lDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1343769"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1343769"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:38:04 -0700
X-CSE-ConnectionGUID: +ylwMqJRRJyt1ssj5HrsVA==
X-CSE-MsgGUID: o0cne00uTyOdAzd0bOSipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3013059"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:38:00 -0700
Date: Wed, 21 Oct 2026 19:37:56 +0300
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
Message-ID: <atjqZPuAbHDdaexv@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com>
 <athe0QikG2mzCAtd@ashevche-desk.local>
 <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com>
 <atjB-BnXclL3FcUm@ashevche-desk.local>
 <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com>
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
In-Reply-To: <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 12:37:32PM -0300, Vinicius Pedrosa wrote:
> On Wed, 21 Oct 2026, Andy Shevchenko wrote:
> 
> > Ah, dw8250_idle_*() are already BUSY-functionality aware. So, what we need
> > is to provide dw8250_idle_*() callbacks via struct dw8250_port_data and
> > make current 8250_dw::dw8250_set_divisor() to be part of dwlib.
> >
> > Patch 1 (dwlib): Add callback definitions for dw8250_idle_*() to struct dw8250_port_data
> > Patch 2 (dw): Assign new callbacks and use them in dw8250_set_divisor()
> > Patch 3 (lpss): Introduce stubs and assign new callbacks to them
> > Patch 4 (dwlib): Use dw8250_idle_*() in dw8250_set_divisor()
> > Patch 5 (dw): Kill now duplicate code pieces
> >
> > Would it work?
> 
> Yes, I think the approach works. Two details from checking the call
> paths.
> 
> dw8250_setup_port() is skipped for Octeon (skip_autocfg), so 8250_dw
> would still have to install the setter from probe.

No, just pass that as a 'bool autoconf' to it, and assign those callbacks
there, while calling dw8250_setup_port() unconditionally from _probe().

It might require another patch, though (to make it a parameter first).

> For LPSS, I wonder if the idle callbacks could simply be optional.
> 8250_dw would provide them and LPSS could leave them NULL, avoiding
> stubs and a separate LPSS patch. The common setter in dwlib would use
> them when present.

I think it would be less flexible, also it will add an additional branch
(actually two) each time the set_divisor is called (not that it's critical
but just wanted to mentioned that).

> I'd still prefer to keep patch 1 as the small fix with the stable tag
> and do the refactoring as a separate follow-up series. Would that work
> for you?

I dunno, I prefer just a longer solution, but I don't know how big this issue
is that we need to backport in that way (and not taking the whole series as a
fix).

> I don't have LPSS hardware, but I can build-test the LPSS side.

I have Intel Galileo board that uses 8250_lpss.

-- 
With Best Regards,
Andy Shevchenko


