Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121554;
	b=aAxOMtAxo6pyRqZ6KeNhJvUou/96lLq6AhmvUOos1Tv41MHPUVLeONuyIj5peGGpmKou
	 xiCHMuYUYZQ6evwB+pbejtUjIoicqQm0uRGcspI7bhQ/gaM5yOtRbwJs3XtT1Bw8DIQo3
	 zIuCuM9zLZ5PeofQcGz6xGHR20RMK6PbttmlkTDH8eCttaigPg04Sxdnsibvs7AjVqBaZ
	 5rcYmV6bAKe9Fs/rIO27lqbz4KeAfFLbX+rT28ePRyU0fSRCsTbyp6/TcZJfD7rb5K+HT
	 5eOT5ojRJJ0PQHJz6QyK44NemDYr+qHM1Mf7S41teRQ1H+Yvn2i+W6OZsOPIfuvk8Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121554;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cSrg6NBPs4OxW0ByENrjDj0gmJZd10gVh7/LEVuJMSQ=;
	b=OEK4DuyjuPBvPD0P3ZmBcxwjJOSCpnKw3QXcTvWkEXawojEz81bQ+hOke1F7aMqi7mOK
	 7e3m8lUTuprf5au+v8JgJh5otDOoWW57f60xj15cUa1a7md3y8giU+e8QZl1z7xPDFvUL
	 lXHaBpc2fJdFH+rFgnfg0kD5StPv9hK8eJSyciL5LHbRhUYwtev+74dUdn281htzkWmhO
	 TMdGxJFxMHjQYv0OS9vvjdiKgsU8sismLESArq4cRagdX8HbTOE8BlNg+RNcLsrWVzdjI
	 EQYwUl+Aa39BhdQMOiwirp1o4hPFqBMamoZzmg+Se/kETogotOBgki1yHeWhBdmBnkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PZ1q7ivx;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B0606A321;
	Tue, 27 Oct 2026 17:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F10B0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PZ1q7ivx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793121554; x=1824657554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c9GHjwW4yGy9CVebczoWEs3FT+LhSFTW3AuuS+H21eo=;
  b=PZ1q7ivxh0r/N9Bo58iQtovxr/mo8kDqu/YlMZuHfLLTkRVCvP0Wg8+x
   T9ns/o/pKBbVRyQBsGW9hyynT+sikEAsTdVq0O5f5BS2hGzMhODgzmZgo
   KPMmgeCer5EqhWrf/5yMnr/lrTNwQ4kyaaBouKIhfHPsrY2zVHAlR+lCN
   3Ip+hr8mBGRPRspcmc11foH+ZJWpRgPUYjlVEaZskZULBXHdeMuyVMXCX
   WI3xVcU3/zkqULxhp1kUIqsarR56IoYFamQmH2eG7mbgwjUFV/qpdpMyl
   0fbxXiYya0dH3EugwxYWuisQUkJsj+USdpGa41tKOTKvxCKxXr0+Xon2z
   g==;
X-CSE-ConnectionGUID: O1ZPXph4QT+DBOOZcmoobg==
X-CSE-MsgGUID: 8wAtPDxBSOmkd28S7pzm0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1707346"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1707346"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:19:14 -0700
X-CSE-ConnectionGUID: GiZX1EfKTSSDqOKchVDQVg==
X-CSE-MsgGUID: asKxwfa/SjOk7nJk9kRCAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4549329"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:19:11 -0700
Date: Tue, 27 Oct 2026 19:19:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] serial: 8250_dw: preserve BUSY-safe fractional
 divisor programming
Message-ID: <auDdC5TzlrYEAfWT@ashevche-desk.local>
References: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
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
In-Reply-To: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 11:10:57AM -0600, James Hilliard wrote:
> dw8250_probe() installs a divisor setter that makes the UART idle and
> checks DLAB before writing DLL and DLH. When dw8250_setup_port() detects
> fractional-divisor support, it replaces that setter with the library's
> callback. The replacement writes DLF and uses serial8250_do_set_divisor(),
> bypassing the divisor setter's idle sequence and DLAB readback.
> 
> If the LCR update fails to set DLAB, the subsequent divisor writes can
> reach TX and IER instead of DLL and DLH.
> 
> Expose the library's fractional-divisor calculation and DLF write as
> shared helpers. Install the BUSY-safe setter after hardware discovery and
> use the shared DLF helper to program the fractional field only after DLAB
> has been confirmed, alongside DLL and DLH. Keep fractional-divisor
> detection and calculator selection in the library, preserving the core
> calculation for integer-only ports. Let the shared DLF setter check for
> fractional-divisor support so callers can use it for either kind of port.

Okay, this version is good enough,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


