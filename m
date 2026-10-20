Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485011;
	b=LiIuZVMFPTfjvLhr4JoJJjk8H2LnB0JUCnjs0ShRBY12kODIj+UMtVoCcqnRLAWL/CMS
	 p69o6sSHXMnvfvIzHDPAUjvXB7Dn01hvg3UViRxvyEKI6Q09AfpAhBMAQ2GnB5QEEp868
	 MsLexk+zhyzyXmWocKrdcSXJrDlYggOkgEgO7kxI4xXiNRLJJfejOWOnNOU7j2CbN2J0N
	 TexEOu57gpRPTrx9ub1IEaP7CaSU9onnVz8ebts3+oaFfhgqMdATLMTQQgr14djfIIvhA
	 aKf66GzpvOqMVO7BIhC2jalffgqMzspb9SHQI+S+hXGIwJJ68virXt0hep4BM7+3/1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485011;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SH4f7kSSSOqRKPp383w+nJEtgT8hrei7yyRtccIHY5A=;
	b=c7IfCZRgCOznT+m69R+LRP93BhfBGEScHaWD2iWiqx2TQ+P7z/QM/L4vZQP5KM/wJ77z
	 4V13Yqi2mVsWhg1nMuCFZUGCL9IqfaYOf8NOb9O5IJctDJZRQ7qLqTRwNmnT4R/MhM//x
	 CW35D7L25y01UvXvIVHMz9n9J/WaS8cKINdyq6TInXbgHZ+Qr4fZTrxiF59KYfZnknZOb
	 3tL/95uW9V6D28+GG/NLQl6PF/pyOS7GdtWbQJN70yKzjMoXdi/ryACcLd8e5k++xSmxg
	 sfTGXi5hKywPXNkTR69ScsM8FRXC28K2V7YI7V3FvgugklpbMa+xTt2aKoZ96fTZDzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nPODbXxY;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135B606A33F;
	Tue, 20 Oct 2026 08:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1135B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nPODbXxY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792485011; x=1824021011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ut3G5c8rvGrpw6eB6UmvojAffaEPq4sehW3h0fIJ+hM=;
  b=nPODbXxY7Il0teIcZLDwt/h4KNPU4Ay8+nsevQnXMGq4Euwt1Ayj1BLe
   980zW91HImTS5UmBsCq0jHHbKNDs5sGMyJXsF+/IXtyXiLJDkDb/MCtpA
   9pDHjdjyfIANTrkXGONWVSunRxLDWZS4JMqubKC33ex6N+ehmXeieaG8P
   7oVEOrz2d76iuBbzivQJGI2JNNlPZ4k+Al2iftc+SsyeNZLzhM+tMR6O9
   JX6o79c7pbUGV0KylqczS42XOK6ofuL6sR63Gkfo7wfswddVkEEqRht5D
   t9m7GEmV24NIKMoEQVnRjj4mHkA2EFzHmCAaOgNUmLH5aOCOOp1j0nYEu
   w==;
X-CSE-ConnectionGUID: ORhGv6FtT9CDdGNvJspR0Q==
X-CSE-MsgGUID: pUSA00DrQK6dSTyLaFNEpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1075779"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1075779"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:30:10 -0700
X-CSE-ConnectionGUID: ff4tx7z4RauaHg52GK7m4g==
X-CSE-MsgGUID: OE45QHLrSziL2awgXk/q/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3086559"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:30:05 -0700
Date: Tue, 20 Oct 2026 11:30:02 +0300
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
Message-ID: <atcmiqfmoa6HoJpp@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
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
In-Reply-To: <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 05:06:10PM -0300, Vinicius Pedrosa wrote:
> dw8250_probe() installs dw8250_set_divisor(), which brackets the
> DLAB/DLL/DLH sequence with dw8250_idle_enter() and dw8250_idle_exit()
> so a BUSY UART cannot drop the divisor LCR write.
> 
> dw8250_setup_port() runs afterwards and replaces that hook with the
> dwlib divisor hook whenever it detects DLF. The dwlib hook programs the
> divisor through serial8250_do_set_divisor() without entering idle,
> leaving the LCR|DLAB write exposed to BUSY.
> 
> When termios changes while the UART is transmitting, that LCR|DLAB
> write can be ignored and dw8250_check_lcr() retries it between
> dw8250_idle_enter() and dw8250_idle_exit(). dw8250_idle_exit() then
> restores IER while DLAB is still set, so the value lands in DLH. The
> real IER stays at the zero written by dw8250_idle_enter(), and the port
> gets no further TX or RX interrupts while up->ier says they're enabled.
> 
> Do not replace a divisor hook the driver has already installed. Program
> DLF from the BUSY-safe hook, inside the idle section, through a dwlib
> helper that checks dlf_size.
> 
> Observed on an Allwinner A733 (Radxa Cubie A7Z), where
> dw8250_setup_port() mistakes the RS485 control register for DLF (see the
> next patch): the first interactive tcsetattr() during console output
> left hardware IER at 0 and up->ier at 0x07. The shell never printed its
> prompt or read input. With this change alone the same boot reached the
> prompt and echoed input, and hardware IER matched up->ier afterwards.

...

> +/* Program the fractional part of the divisor, if the UART has one */
> +void __dw8250_set_divisor(struct uart_port *p, unsigned int quot_frac)

Let's reduce amount of double underscore functions. Let's call it
dw8250_update_dfl(). Also call the parameter just 'frac'.

void dw8250_update_dfl(struct uart_port *p, unsigned int frac)

...

> +++ b/drivers/tty/serial/8250/8250_dwlib.h

>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
>  void dw8250_setup_port(struct uart_port *p);
> +void __dw8250_set_divisor(struct uart_port *p, unsigned int quot_frac);

Put it rather after _writel_ext() implementation, because it's just a small
wrapper on top of it. Or even make it 'static inline' there.

-- 
With Best Regards,
Andy Shevchenko


