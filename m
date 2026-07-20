Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CD3B811F;
	Mon, 20 Jul 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557234; cv=none; b=fOeyXWv3pDBDsE+1rbPb5u8scSSpjC/Njeqlzd1aQzzQP71bWCpeIzjWYTko9rDoCkV7RIffr4DQkXQ8c7CaLRVcsoDhlTZbKkd6dnmkIqxI+eUUWcOPemGzDDUE7I485TsE2FNdeb3R6Qza9imnVMerE39edRpYGZKnUZmFsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557234; c=relaxed/simple;
	bh=Q8pz/4VVBgfA8/bPEAei8MB8X/cmr7OAJW/v2eTprWY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jRS7queTh2bKI96eAQK+yrhdGZ+dXoIFdaQuhGqRclJhN+Ep7N4hbePSYTixEwbKo+GhJTf7md1rkFlxz5FfBGyx4/r2xzjsOMIJ+C6BWer8BIfBRI4FiYXS3F0ACQr7bR1mzC0uVGdBMSComot9KLPtW+H9v6WUCQTFYXvzJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+sv+/Is; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+sv+/Is"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784557233; x=1816093233;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q8pz/4VVBgfA8/bPEAei8MB8X/cmr7OAJW/v2eTprWY=;
  b=m+sv+/Isbu/7gPcaRz+WB29xzVuXH9XB+DQmtjp7QF9tLPV3ibyDECXm
   ol+7DF1T+mewaWkmuKy7Owza2OSLjknmqy3V7fP9Aow+qr7ZKldfy3Sfn
   rc3Om23zgfGsN1qJRV2KN+2phzbTg/rADKXYjlVzBReaEDLNActjh08od
   dY7JYnmUCr+B93KDtxOA5JKQJtu+g2ltK2NDOiGcldEKoQMgZI8TMRb+C
   +kzSRbbBaKyVqPgHFKgmDA0YF27OgmidO2cRTecc7FaKZD4+H6XdPJEaQ
   /BQ2dgDbcpjKUTZQQLh7wf+SLh3vRNsIoihWYfbPQokFrkZrbbpy7hQWr
   w==;
X-CSE-ConnectionGUID: wmg22aQrTaCD3Q5ht5bYEQ==
X-CSE-MsgGUID: qFhvJJ75TeO5RID9Ue6U1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85234572"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85234572"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 07:20:32 -0700
X-CSE-ConnectionGUID: dczVyWVuToqCpyunRsTiiQ==
X-CSE-MsgGUID: bzewl6LeRL+0kNv2nwbJEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="256290605"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 07:20:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Jul 2026 17:20:26 +0300 (EEST)
To: Ryan Wilbur <rwilbur633@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    john.ogness@linutronix.de, hvilleneuve@dimonoff.com, 
    m.felsch@pengutronix.de, linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250: clear a stuck RX-timeout interrupt with
 an empty FIFO
In-Reply-To: <20260720131123.29840-1-rwilbur633@gmail.com>
Message-ID: <c8a74142-5704-5ad3-3504-946bf3496cfc@linux.intel.com>
References: <20260720131123.29840-1-rwilbur633@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Jul 2026, Ryan Wilbur wrote:

> Some UARTs can latch an RX character-timeout interrupt while the
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
> Fix this by doing one throwaway RHR read to clear the timeout when the
> FIFO is empty (LSR.DR clear), so no real received data is ever discarded,
> and it is a no-op on healthy UARTs which never report a timeout with
> DR==0.
> 
> This is the same class of bug already worked around in 8250 drivers;
> see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
> which reports the identical iir=0xcc/lsr=0x60. See also
> UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.
> 
> LPC32xx (PORT_LPC3220) has no dedicated 8250 glue driver, driven
> by generic 8250_of, so it's handled here.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
> ---
> Changes in v2:
> - Drop the PORT_LPC3220 gate and handle the spurious RX timeout generically
> 
> v1: https://lore.kernel.org/linux-serial/20260717123530.481021-1-rwilbur633@gmail.com/
> 
>  drivers/tty/serial/8250/8250_port.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 8c241ec7f4f2..c63c4165105a 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1803,6 +1803,21 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
>  	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
>  		serial8250_clear_and_reinit_fifos(up);
>  
> +	/*
> +	 * A UART can raise an RX character-timeout interrupt while the RX
> +	 * FIFO is already empty (IIR reports RX_TIMEOUT but LSR.DR is
> +	 * clear). The timeout is only cleared by reading RHR, but the RX
> +	 * path below is skipped when the FIFO is empty, so nothing clears
> +	 * it. With a level-triggered IRQ it re-fires immediately and can
> +	 * livelock a single-core. Observed on the NXP LPC32xx
> +	 * UART (PORT_LPC3220). Do one throwaway RHR read to
> +	 * clear it. A healthy 16550 UART never reports a timeout with DR clear,
> +	 * so this is a no-op elsewhere.
> +	 */
> +	if ((iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
> +	    !(status & UART_LSR_DR))
> +		serial_in(up, UART_RX);

Hi,

I suspect Andy meant you should put this into hw specific file into a 
hw-specific handle_irq. That could be setup in 8250_of.c, it already 
seems to do something like that for some specific type.

It might make sense to put this code into a separate function that is 
called from those drivers. However, it also looked there are minor 
variations how each 8250 variant deals with this so it might not be that 
practical (8250_dw include check for LSR_BI bit and this one doesn't seem 
include that bit, not sure if that's an oversight or intentional 
difference and omap + bcm7271 did something different to workaround it).

So 3rd alternative would be to add e.g. UART_BUG_SPURIOUSRXTO but again 
there are the per driver variations. To handle the variations, one option 
would be add a callback which is invoked if UART_BUG_SPURIOUSRXTO is set 
(that is probably acceptable to occur from 8250_port.c's handle_irq).
It would be a bit more work and a few patches in a series but definitely 
cleaner approach than copy-pasting this code around.

-- 
 i.

