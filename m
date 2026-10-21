Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590345;
	b=5PZ/3O+d6/Vlt6ztny6ns6kc0734Brzu4eybgI4xaTaPUPbCCjBQY8J3YNFZNRELtH7N
	 uK5IMMZ/iIG6xBjgz0QfeUa0xGNAWDhpb338lHdYvB4CtxrA5eEVsL7Ehq4RV+QIPOZxU
	 R2hVF3hUj0P1oV4pAfdLtQJMf/TTzjmGuIKr6bfgY3+nV0ACQvRemA/gz44p0wL19SD6E
	 VZt6WUFCylL/efwVDeUNHD2XhFbQyoKPHbp/SVtoOfGYpb+cUlLTEllT/EPeFIdjnDohk
	 QzIfKVwyWBJtlzJ7lvfQDyTYQQeV+HsbpyFYaeQmDrGyqRztdNM2kddFGGVFIpRxKhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590345;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=om8w7QXSdYKu02tw65tJ99U3eL+Sg+cuLsqMm6GZ54U=;
	b=YsPNZ0thJ+LJZC51XkLmCdP0/1PRD5QaYAcu8FcN0VEqt4a96V2izFv7T/yndvFt1gt6
	 4aOSGn4DCX+AvslIaKy87gHYY1RQm7BcsAgZCi0EEdIO1lhy4/2KzsWILZcjHgwC7XkN6
	 CAbZd0QlBM/oVXfNWPpeNnKdxj6Q5O5k68lbhYV5Hczo2hLf19mUXJ4kMF2gvjbSK+W94
	 xuo0le3VqOhz6Hne+U5lwV79CqfFmY0Kw++AZSmwpr8WWpV5U18JQNwivzliwFMx7EOvA
	 oLaZoDWCTJskSinDHpvNmoywipQe5+X+YKNvJncB7ZgxUgSc9b/zhnuycVW0/UNyfTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TPt6zR1M;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39F606A31A;
	Wed, 21 Oct 2026 13:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B39F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TPt6zR1M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792590345; x=1824126345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lUjLPWWlN6l1+ey7iJlAqTyXZpN23Ksa49kPyHEPupc=;
  b=TPt6zR1MIR0QDCW81Hj5vkUsr8dJlgA/P1+4N4EsgqzpjNJLxLGMJq8r
   ks4eo87T7Vazi7ykVsWWLIw0e6oLjrdgrf57wRdrMNgNW1U9e7w4R/EpD
   kdwGolUc+syPVGpy1v9HPUwo4TGDdBcf0FiloZGjnh5xudWUQoJnVPPvm
   EE+OjisROn07RSvkc7Iqbhrk7XW7FU+40OxTdapFSeg8yIdfNH3jDftvn
   Z+B79OgOY0zRsqgTJE12+TkM2j+Qz9ImMeuabU0V4t8u3tYrYwhQKcdkG
   pPPlaAxuJ4CublXVbhP7yOazsAJ9YS83fsTNIBvCdquZAyPZkc8zqXxzs
   g==;
X-CSE-ConnectionGUID: kauiS2zxRjOKOi0gIZjuSg==
X-CSE-MsgGUID: hHvYUJ3fR0OgujcRpenLPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1346850"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1346850"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:45:35 -0700
X-CSE-ConnectionGUID: +SSgAPUWSeqSj+QSQsE4OQ==
X-CSE-MsgGUID: Q5rODW1QRJ+XPjGyXAxLGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3036317"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:45:31 -0700
Date: Wed, 21 Oct 2026 16:45:28 +0300
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
Message-ID: <atjB-BnXclL3FcUm@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com>
 <athe0QikG2mzCAtd@ashevche-desk.local>
 <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com>
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
In-Reply-To: <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 07:00:49AM -0300, Vinicius Pedrosa wrote:
> On Wed, 21 Oct 2026, Andy Shevchenko wrote:
> 
> > Right, but have you read my second question in the above paragraph?
> 
> Sorry, I missed the second part of your question.
> 
> If I understand you correctly, since 8250_dw.c already has the BUSY-safe
> set_divisor, you're suggesting that it should have the matching
> get_divisor as well, instead of pairing it with the dwlib getter.

Exactly!

> The dwlib getter would stay for the other users of dw8250_setup_port(),
> like 8250_lpss. Is that the structure you had in mind?

8250_lpss doesn't redefine either of the _get/_set_divisor, so it won't be
affected. But I think that 8250_lpss actually lacks of busy support that's
why it uses simpler version of all this. Maybe we can refactor that (in
the future?) so that we will have dwlib to provide the IDLE version of them
for all and depending on the existence of busy functionality degrade to
the same as just current DFL helpers.

Can you check that approach?

Ah, dw8250_idle_*() are already BUSY-functionality aware. So, what we need
is to provide dw8250_idlej_*() callbacks via struct dw8250_port_data and
make current 8250_dw::dw8250_set_divisor() to be part of dwlib.

Patch 1 (dwlib): Add callback definitions for dw8250_idle_*() to struct dw8250_port_data
Patch 2 (dw): Assign new callbacks and use them in dw8250_set_divisor()
Patch 3 (lpss): Introduce stubs and assign new callbacks to them
Patch 4 (dwlib): Use dw8250_idle_*() in dw8250_set_divisor()
Patch 5 (dw): Kill now duplicate code pieces

(Some of the patches might be combined, but I think the above split is not bad.)

Would it work?

-- 
With Best Regards,
Andy Shevchenko


