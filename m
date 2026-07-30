Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD945DF6B;
	Thu, 30 Jul 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428390; cv=none; b=Ebqnlupdm0+HOWwVIQ58QJmN58vkCRGvXypZJOMXQUxCPTQnkVtaSBQ/veOR7qnaINUrZQKttm2wFV17mhrIaVJFYqY7HDbnawFcmfWJwiizT+VMIcC1K/89G6D5tVjA9KziCZuFjrj39bOwoP2ChGz8YTEDK8TbAP56ztcfNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428390; c=relaxed/simple;
	bh=/8Gmc+Kbb0/XQLKCqebNoQ7Dtr6960LpYNAw8mvILVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd345b/PI4vq9i2WW5R2NefkGPrmE1CnkeATuk0tDkrrGdGPWlxShnV0+Kcxy7498LaC8RcOAariZKT+d8Wdtyb7Ft8r6EYmgnf/GFYK50l4cL0Mt1JqHqTVCDtasYR4LVwNzjPheONvzVvnqflE+AGODFL289vVP+OjPyVjzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Goncq/eK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Goncq/eK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DF71F000E9;
	Thu, 30 Jul 2026 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428389;
	bh=vasKG/U3NnZXeyvkgGUQtD05u+iOzdHRqhvwWEuPpd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Goncq/eKjsOZ3kufW85cp2/uniqx8J/CfCE/avwBtG1FdazftwOykFPFdxEWyCpQk
	 g6GOktTJIVQMinU2FJNVazruus9Jk/+Zeqg7FTSWc+AbrWdHUtjWNB7Kh05h8d5hnc
	 pDoXwVa+MWuzmYCS9zkzgF34eL4Omdi1DSf9kSDM=
Date: Thu, 30 Jul 2026 16:41:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryan Wilbur <rwilbur633@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_of: clear stuck empty-FIFO RX-timeout on
 LPC32xx
Message-ID: <2026073005-clubbed-spinner-9e9f@gregkh>
References: <20260722140353.115899-1-rwilbur633@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722140353.115899-1-rwilbur633@gmail.com>

On Wed, Jul 22, 2026 at 11:03:53AM -0300, Ryan Wilbur wrote:
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
> 
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Opus4.8
> Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
> ---
> Changes in v3:
> - Move the workaround out of the generic serial8250_handle_irq_locked()
>   into an LPC32xx-specific ->handle_irq in 8250_of.c
> - Skip the dummy read when LSR.BI is set, matching dw8250_handle_irq
> 
> Changes in v2:
> - Drop the PORT_LPC3220 gate and handle the spurious RX timeout generically

This breaks the build :(

Even sashiko noticed this:
	https://sashiko.dev/#/patchset/20260722140353.115899-1-rwilbur633@gmail.com
