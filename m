Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CF43E487;
	Mon, 10 Aug 2026 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389374; cv=none; b=e9xdiPKAqHS4gUrVktXG/QUx0JfabxDjAxF5FP6QmHbySiAjba37v1R8QLSc7nL9JmdiFjS82twgu8J/pdn71nL7P212Nhbcnvk+alrf/7cQPaL5Yp9kUY4pWbUNnZGDzHrv2nIFIc92XoqkP3XCqNX7k1pjUhL9rphZjcY1mF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389374; c=relaxed/simple;
	bh=mtFENE88hMKa6wmKPHxnZFDO1wgLoWRNPnGtHma0cn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt/kYQTOfGIfpu07zeuc9VbAESugadHxvTm0Rz0ZzWKEj35ZoJGtVoEyGLhXBECkO0/SIcIi3xqul3NQO4mhCfuJUKFGOM5VvjzhuG7LDFgnIXcxdzlput9Gir4j54ogbetYZUmKDfO2M+yMtx5WztGrOdc17YQQV+cvZNqL66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iArr3AhY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iArr3AhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786389372; x=1817925372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mtFENE88hMKa6wmKPHxnZFDO1wgLoWRNPnGtHma0cn4=;
  b=iArr3AhYkPvAA1jL87VAppjdbCVjOKhTepf+w5QXUHA1dDTCB2OFQneo
   MXCAhIdrvV6pzQmxPX6PcEEQnUtXtz4YbpN4YgcW2jAE8ziEINAL4xv2Z
   d5UUuHDymA9S3Hw7ARBMczYqs1YVzCcx1umEimPwNdiRlx3I0yT3E5H9O
   GqulKneYEroBZTdcG6QXpuUMBG1paUwi7GfD9x7usOL65VfP5F2zWawqS
   JcFlUPIQL4iU5oKwMUtNhm2Oxpck7e48iyIr5uJ7k/m03z+YKdR0Q3nc6
   k0rnGxCaCzBcDMFk1ppW2HOJ9BIi3lEirSZzv0s8Pb8mQLmLhQzfErimo
   g==;
X-CSE-ConnectionGUID: kjPbksVCQEGBiNlXHd52jg==
X-CSE-MsgGUID: XApNQVXZT7ON0Hx6fDQWFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86847837"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86847837"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:16:10 -0700
X-CSE-ConnectionGUID: HCUxOJ3vR6qi4x9TOs8jBg==
X-CSE-MsgGUID: Rrc/NPOfRfeBnA5lDnIb4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="256895324"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:16:08 -0700
Date: Mon, 10 Aug 2026 22:16:05 +0300
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
Subject: Re: [PATCH v4] serial: 8250_of: clear stuck empty-FIFO RX-timeout on
 LPC32xx
Message-ID: <anojdTKiNZrBoRGh@ashevche-desk.local>
References: <20260730193920.28954-1-rwilbur633@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730193920.28954-1-rwilbur633@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 30, 2026 at 04:39:20PM -0300, Ryan Wilbur wrote:
> The NXP LPC32xx UART (PORT_LPC3220) can latch an RX character-timeout
> interrupt while the RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT
> (0x0c) but LSR.DR is clear. A character timeout is only cleared by
> reading RHR, but serial8250_rx_chars() reads RHR only when LSR.DR is
> set, so nothing ever clears the condition. The interrupt is
> level-triggered and re-fires immediately, so on a single-core ARM926
> the resulting interrupt storm livelocks the CPU.
> 
> It is reproducible when userspace repeatedly opens the front-panel port
> (ttyS1): serial8250_do_set_termios() re-enables interrupts on unlock and
> the handler then spins forever with iir=0xcc lsr=0x60 ier=0x05, tripping
> the soft-lockup detector in serial8250_handle_irq_locked().
> 
> LPC32xx has no dedicated 8250 glue driver, it's driven by the generic
> 8250_of. Add a hardware specific handle_irq for PORT_LPC3220, wired up
> in of_platform_serial_setup() the same way fsl8250_handle_irq is
> installed. The handler follows dw8250_handle_irq(): on an RX timeout
> with an empty FIFO (LSR.DR and LSR.BI clear) it does one throwaway RHR
> read to clear the condition, then calls serial8250_handle_irq_locked().
> No real received data is ever discarded, and it is a no-op on healthy
> UARTs which never report a timeout with DR clear.
> 
> This is the same class of bug already worked around in other 8250 drivers;
> see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
> which reports the identical iir=0xcc/lsr=0x60. See also
> UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.

As long as this quirk is not anymore in the generic 8250 code, I'm fine with it
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


