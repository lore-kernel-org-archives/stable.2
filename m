Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042199;
	b=prvrzq9yUuHPYo50FdnDAmTvM7pfZX99bgckwoxxDvSIeuMi43304nrTN/NsQkp/G4NV
	 rLIw5KEOkfzNvn27V/4IDiwKxeN4N43goVQ9OtUW6MPefXlp6p/R+LBtpqO3ZMlm1tEOR
	 1jRP483qojSGtCGOm0xYRjbsWgsd9VzUi4df1SidbFlZ56Gz3RhyFzQnnaXsAbRzQ6Or8
	 9mXOn/AH6dzpGoFIen2QWCnmdABx0A0I8UJQSH6Q1z9x2UIMH/x+fTeECAuquny3gac35
	 jamNYMUgD0OF8hH4srGBDtLdU9+cLfVwfUU7bPR05nLnfDkXKfR7F3+5/jowsPvBovQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042199;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FscSg4jBgrWJT5gVgo6HfZj/41sVn0GqNpooWyzSB1w=;
	b=M/bbdbN5phN3ujnOeyN4CVdjRT5JhzXJHW0kL66XOLd/IRF/BptZyHJKrC0FlabNYRqc
	 VV/6jdTM+41i6hVKaBdLmRoHkFOXWrU8uIC45Q3sZl+vG3OvLAzuE8lyHL3vNO6rwsM87
	 s2vvKmInrXJeuxXFb3rFwq3L5Ng0d0Tu3hvBDZyvYKNRcGjaeMrYFYDFYJe4X8lgnp+Ng
	 3L3tgNH8ouDhrugCRcrQdVURNLBJ/RJLjYgmCCaef8ZxEMH/xLVWiw+2jdQRKO8buEeev
	 HsbrQhwjm84PYsrArBcjLoQx4YarDR8NikC0TL0/BTIyegd84yqovyn6LiuLiJkGgvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SY3FsSG9;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCC606A31A;
	Mon, 26 Oct 2026 19:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9BCC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SY3FsSG9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793042199; x=1824578199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7EGjiUNhjNg9QT4uBtE/DErh4iS/Q21zYfLXonFkvA0=;
  b=SY3FsSG9BlhiqFPG673f1skRHTf7oU4Pvf9dXDLe6VLKsLk8hAHERVqz
   fYfardc/egBoYa3o6OAdGC2YVMTZ6dRE4u8g3ydPqcDlrbkjdYiIUxHIL
   bKTQwyK3DoMUh5wNjoLRax5AXINdT5iCkMhc4pBMYJDtcA0cr1Kdar0uc
   H73A7ZH6zGIvOdE8W+rE2Q9jNX4jMMktzN/KQgzR6wuDiPCKrBaTrlqnV
   noYFMToGN0vwV2AML55DYvHmiTkpvDNCrxEw46maQV6EX5Uw3OnM3yNSX
   AWsTL5kQIs8zVjyb6nSpfDPM+HgjWGKLMawAUk2imX47TAOBttCUIvLfh
   w==;
X-CSE-ConnectionGUID: vyaNau6QQFmWCGC+eSZy9w==
X-CSE-MsgGUID: vHEz9+qHS6+QB3i59SoAsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1814776"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1814776"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:16:38 -0700
X-CSE-ConnectionGUID: YYtEKwWPQuOA3jHJuyO0mw==
X-CSE-MsgGUID: qlBeN9ifRxCHQn1ggRc0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4737914"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:16:36 -0700
Date: Mon, 26 Oct 2026 21:16:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_dw: preserve BUSY-safe fractional
 divisor programming
Message-ID: <at-nEUdDMYZpY7oQ@ashevche-desk.local>
References: <20261026-submit-serial-8250-dw-divisor-v1-v3-1-7dbd194e1f38@gmail.com>
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
In-Reply-To: <20261026-submit-serial-8250-dw-divisor-v1-v3-1-7dbd194e1f38@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 09:59:10AM -0600, James Hilliard wrote:
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
> has been confirmed, alongside DLL and DLH. Select the shared calculator
> when fractional divisors are supported, preserving the core calculation
> for integer-only ports. Keep the check for fractional-divisor support in
> the shared DLF setter so callers can use it for either kind of port.

...

> +	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
> +	if (data->data.dlf_size)
> +		p->get_divisor = dw8250_get_divisor_dlf;

Yeah, this will be the similar issue with layering violation that Ilpo pointed
out elsewhere. So, perhaps easiest way for now is to let it be as is here, id
est not assigning .get_divisor() at all. Otherwise we would need the same check
in there and the branch on what to do if it's not a DLF case.

> +	p->set_divisor = dw8250_set_divisor;

...

>  	if (reg) {
>  		pd->dlf_size = fls(reg);
> -		p->get_divisor = dw8250_get_divisor;
> +		p->get_divisor = dw8250_get_divisor_dlf;

Just add a static function wrapper that simply calls this, so we won't
change it here at all.

static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
                                       unsigned int *frac)
{
	return dw8250_get_divisor_dlf(p, baud, frac);
}

>  		p->set_divisor = dw8250_set_divisor;
>  	}

-- 
With Best Regards,
Andy Shevchenko


