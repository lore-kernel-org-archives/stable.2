Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D443CECB;
	Thu, 30 Jul 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428382; cv=none; b=qk3YL/A/Eb4NWd3OyglmJtw5WZQZjxlDjBPxy3gzVQ50tfTom7rR1W/ERQFSc2aq5vriBE9Q9sSCgmCbGejr2Ob00M9vUOrV7ocsU6G9cSP6z73uFGQqWRLeAKt3Pr82FjlGoUzqXo49YvYCSdx5PbiFN7a26wBImcoEkzbsdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428382; c=relaxed/simple;
	bh=En3zMfThbeqoJiPQP6KzgdBRHRFUrX037sc2sVTwGlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8uDfHSoMK6ztdAB/JvAIUeov8AiIP85nstmNl+RvBBIBMIrV98PtCDRhz6YoPdWnwBxWlwe50616YIvLN9bx6kJcbiDaXsjsAI5e/EM0YFGJagloP0g7NkhRearFH1P8JZ/TG/pz8/gg0FfrTPwExbHNIi1RZDVLWNmQ2EdemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AUAt6GJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AUAt6GJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE4F1F000E9;
	Thu, 30 Jul 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428380;
	bh=bNusTGEivWR3x+MG5vJyHtA//50WOXuUIYD++tVBKKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AUAt6GJSIwqaGmgjhbQLPaUps+8M5S5vHJDm7Cfc7uHfdzJTK1eq6bLMg4FZMPFj1
	 88PdWNbBxExS8RX/2UJuktKjPEgMlko7r/59UYY9jxZeUFdpA1S4Tl/KTd+4u+lKOO
	 3efrRFKs5vwWFzfqcvX36q6L2lrF4gMash45/nhM=
Date: Thu, 30 Jul 2026 16:36:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux@armlinux.org.uk, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: amba-pl011: cancel RS485 trigger hrtimers
 before removal
Message-ID: <2026073041-variably-jujitsu-411f@gregkh>
References: <20260721042858.3187311-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721042858.3187311-1-fanwu01@zju.edu.cn>

On Tue, Jul 21, 2026 at 04:28:58AM +0000, Fan Wu wrote:
> pl011_shutdown() calls pl011_rs485_tx_stop() when RS485 is enabled and
> the transmit state machine is still active.  That function may re-arm
> the trigger_stop_tx hrtimer via hrtimer_start() when the TX FIFO is not
> yet empty, or when delay_rts_after_send is configured, and the trigger
> timers can equally be left armed from a prior pl011_rs485_tx_start().
> 
> On removal, uart_remove_one_port() can finish without draining the RS485
> hrtimers, and devm frees the uart_amba_port once pl011_remove() returns.
> The existing teardown syncs do not help here: pl011_disable_interrupts()
> only masks the UART IMSC register, pl011_dma_shutdown() cancels a
> different (DMA rx) timer_list, and free_irq() plus serial_core's
> synchronize_irq() only drain the UART interrupt handler, not the hrtimer
> softirq callbacks.  Either trigger callback can therefore recover uap
> from its embedded hrtimer and access uap->port after the free.
> 
> Cancel both RS485 trigger hrtimers in pl011_shutdown(), after the
> re-arming pl011_rs485_tx_stop() call and before free_irq(), and again
> in pl011_remove() after uart_remove_one_port().  The remove-side
> calls cover paths such as suspend followed by unbind, where serial
> core need not invoke the driver's shutdown callback.  The
> callbacks pl011_trigger_start_tx and pl011_trigger_stop_tx return
> HRTIMER_NORESTART, so hrtimer_cancel() fully drains any pending and
> concurrently running callback without a self-restart loop.  As
> pl011_trigger_start_tx() may re-enable the TX interrupt via
> pl011_start_tx(), call pl011_disable_interrupts() again after the
> cancels to re-mask IMSC before free_irq().  The cancel site does not
> hold uart_port_lock across the cancel
> (pl011_disable_interrupts() already released it) and the callbacks take
> that lock internally, so there is no self-deadlock.  This mirrors the
> RS485 teardown pattern in 8250_port.c (serial8250_em485_destroy),
> which cancels both hrtimers before the embedding object is freed.
> 
> This issue was found by an in-house static analysis tool.

Yes, but a LLM obviously wrote the text here.  Please shorten it up a
LOT and make it more concise, as-is, it's impossible to read this
wall-of-text...

thanks,

greg k-h
