Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293E379ECD;
	Fri, 17 Jul 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310849; cv=none; b=oo6Uie6YQX5ZneupDKNRZXuQa65jdsxcjWSuybaUeZfp6FP5KTVrsjfR82tVnSxel2FSCzjf6gwYjtSQ65Mjz/+wfRrfA4DWNvxATMkmXXcU7Fsz9WA22kvCT+i7zeD81Etq/U46ApsjsU4AFSy7Y+g0qYeLyyeTrKOtqb2hDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310849; c=relaxed/simple;
	bh=fVyo+aBDlkCO5YY4oF7PlSe29p3IKXJswtx8B0+nwcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHkmz7qfNZenHIXPy+BthnZwa9HCve+6TU56o9qd0dGqE4OFtvTID/Q3JoCerVFSkNd4wLorMit/L6G7fK4UTqTVCTpzyBFlVotOvhyB+bDe+dJgKEJW6MV5e/e/P5DjT2m5s9+1lWcAEQRJsjGcgGcye0LWPrOrJYZ8aZK9Fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWuN+WtD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWuN+WtD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784310848; x=1815846848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fVyo+aBDlkCO5YY4oF7PlSe29p3IKXJswtx8B0+nwcc=;
  b=YWuN+WtDepUXbajyzhqUBbb9HIm7PlqSn4awb98fCXpy19pXnShK2aUu
   NwcYNDxn/WmWHP9U5FefrkP+T1J0tmFISUAKPfs/cGD/xZ9gjXYLMtJ9/
   5rGoaUGjl1tKz2rcHXBYEKdjZA0sgbnWDl4x58Xcd3F9B9U0FGz2eSYzy
   pdlXB3CFSh0Pg0Ey91G3AUdAd4o9ncwQPExgxM11SBbCx8+YLOAAK5Rdp
   nOpk31Gn9MvO8jYIUYd6KJNhbZ4n93t3MNYyopm8D21+3bGHLSDA9I3tE
   lR0cyEeJJ6m97NQe71PqtPa9Jp9ifXBWzdpw3EuugPBtIidBUxhDDnmCJ
   Q==;
X-CSE-ConnectionGUID: V+50oMLnTDqL8iSEKcvFuQ==
X-CSE-MsgGUID: Dx4g1utCSxWYqm8O6TBOWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88663944"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88663944"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:54:08 -0700
X-CSE-ConnectionGUID: rU2XKYITTKqvg5UjJZhATA==
X-CSE-MsgGUID: MLNPqyruR/mPFEeeXBytSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="258845509"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:54:04 -0700
Date: Fri, 17 Jul 2026 20:54:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ryan Wilbur <rwilbur633@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: clear stuck RX-timeout interrupt on
 LPC32xx (PORT_LPC3220)
Message-ID: <alpsOr5ZVqa_eLs9@ashevche-desk.local>
References: <20260717123530.481021-1-rwilbur633@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717123530.481021-1-rwilbur633@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 09:35:30AM -0300, Ryan Wilbur wrote:
> The LPC32xx UART can latch an RX character-timeout interrupt while the
> RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT (0x0c) but LSR.DR is
> clear. A character timeout is only cleared by reading RHR, but
> serial8250_rx_chars() reads RHR only when LSR.DR is set, so nothing ever
> clears the condition. The interrupt is level-triggered and re-fires
> immediately, so on a single-core ARM926 the resulting interrupt
> storm livelocks the CPU.
> 
> It is reproducible when userspace repeatedly opens the front-panel port
> (ttyS1): serial8250_do_set_termios() re-enables interrupts on unlock and
> the handler then spins forever with iir=0xcc lsr=0x60 ier=0x05, tripping
> the soft-lockup detector in serial8250_handle_irq_locked().
> 
> Fix this by doing one throwaway RHR read to clear the timeout. It is gated
> on PORT_LPC3220 and only fires when the FIFO is empty (LSR.DR clear), so
> no real received data is ever discarded, and it is a no-op on healthy
> UARTs which never report a timeout with DR==0.
> 
> This is the same class of bug already worked around for other 8250 cores;
> see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
> which reports the identical iir=0xcc/lsr=0x60. See also
> UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.

...

> +	/*
> +	 * On PORT_LPC3220 the UART can raise an RX character-timeout
> +	 * interrupt with an empty RX FIFO (IIR reports RX_TIMEOUT but
> +	 * LSR.DR is clear). The timeout is only cleared by reading RHR,
> +	 * but the RX path below is skipped when the FIFO is empty, so
> +	 * nothing clears it. IRQ then re-fires immediately and livelocks
> +	 * this single-core. Do one throwaway RHR read to clear it.

> +	 * Same bug worked around for other 8250 cores (8250_dw, 8250_omap, 8250_bcm7271).

This is 8250-port.c.

> +	 */
> +	if (port->type == PORT_LPC3220 &&

Why do we have this then?

> +	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
> +	    !(status & UART_LSR_DR))
> +		serial_in(up, UART_RX);

-- 
With Best Regards,
Andy Shevchenko


