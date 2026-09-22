Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B24D1781;
	Tue, 22 Sep 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058555; cv=none; b=iPLkGjCDNG+YgxTPG7aW3UtEk5V/exEm8vXrIXQin8xmIWy6YK9s+aUdVCCntLRutksqr9UAKMuLEaxtxqIr62j8Se8FCXkPX1l74o6J9LkZT1mfE/BfS0+OsLX9xgTYvGJMGA2N/4VIHmqVjiBjoFOyMe1pjVSu16eeJE7QzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058555; c=relaxed/simple;
	bh=LkiV3OX1ebSoOiEscLlD6+x3VZAcpOezOXBher5cmAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoqtiMOPiyh8ZygDe+Uez5/Nv/j8Y6ok0U0VxMMs5n3KBJRxD7kVdwCXSuj02QzBbod4NK1W2wcxpttlwrQEGJhcqzJtC/EeZ6yzeM5I1cmi8CPHI7fazdoRHzYhP7FQQ9iYlya+2nDyhMVx56F/on3PqB2JniOOdtKefL2IIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=iyCm68KY; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=YVMDen9O; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="iyCm68KY";
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="YVMDen9O"
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 09E7CA1CAD;
	Tue, 22 Sep 2026 08:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1790058051; bh=LkiV3OX1ebSoOiEscLlD6+x3VZAcpOezOXBher5cmAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyCm68KY35V2qPH9vjrIMteFboudGbzP5x95ss3BbUx+aRsUW79c15Mfe6AFTdR7A
	 JXSfXEK1AG0DsBos9S5f9sWXpL+qk1jezlHtfJ+ekBeZ19rbDdhnIbB2EC8f2IaV3s
	 eWS1r3hpNKKyYvGWN0EkmS3iJlXIF8Ty1gDlCObJjB6YWyS1yAS2guXTqM6Xc6qyLE
	 fGqBkOelgB02Tnlw63E3fkckDTamq9KXuG83pwCPv7KBhyETOvhD6wNI6XuVCJ6khW
	 Vxy8kxLqup417WAyrtI46DJxn/HzUf1gUGFnvcbon8utC1Tjrk1IHW7lOK/NsI3+my
	 9BHW4NSfzpqlA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBkPiVl4NJfZ; Tue, 22 Sep 2026 08:20:50 +0200 (CEST)
Received: from end (unknown [212.133.41.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id A98F8A1BC6;
	Tue, 22 Sep 2026 08:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1790058050; bh=LkiV3OX1ebSoOiEscLlD6+x3VZAcpOezOXBher5cmAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVMDen9ObhBkQiUbBjd8rCimOhZ2ABxDyRVt9hF+75SyrvljwrbRIcAnhHIGvoRF+
	 5/2mmnxLJup86xUIs9GAN3kVTEh1Wx+tTZ/cJm0Lb+8W4o4itD+m16eaEHSwUAr7d9
	 dAEhlks7r9Di5gWDHQDufgbaVhCg62sr2kGlsV00FUwKJhyU1JFBHKj2zgqIkKDU0q
	 /DBng+dUws0iMpgZlpfTsW0s6uwE+Mb/Arsib0f7h4gVsYzJivb9xYN0zhCPI5u7yL
	 qI6XrHMKzqn/PlFeB1J1ECqfmW1QmEOMIn3X6PdDr2PlH2t4n6LMnW40xOicDrZALI
	 akd02gN9dP4nQ==
Received: from samy by end with local (Exim 4.100)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1x8try-00000005oSC-1r1J;
	Tue, 22 Sep 2026 08:20:46 +0200
Date: Tue, 22 Sep 2026 08:20:46 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] speakup: handle serial IRQ request failure
Message-ID: <arIePlTEvuW_u5-H@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
References: <20260921075035.9393-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921075035.9393-1-runyu.xiao@seu.edu.cn>
Organization: I am not organized

Hello,

Actually, this is old dead code. I'll send a patch to request removing
it.

Thanks for the report anyway,
Samuel

Runyu Xiao, le lun. 21 sept. 2026 15:50:35 +0800, a ecrit:
> start_serial_interrupt() currently logs a failed request_irq() but
> continues enabling UART interrupts and reports a successful serial
> synthesizer probe. A later release then calls free_irq() without a
> matching registration.
> 
> Return the request error to spk_serial_init() and unwind the I/O region
> and serial state when registration fails. This keeps the UART disabled
> and prevents teardown from freeing an IRQ that was never requested.
> 
> A QEMU x86_64 test used a non-shared handler to occupy COM1 IRQ4 before
> the Speakup serial path requested the same IRQ with IRQF_SHARED. On the
> unfixed kernel, the probe continued successfully and release emitted
> "Trying to free already-free IRQ 4". On the fixed kernel, probe failed
> and no unmatched free_irq() warning was emitted. The IRQ conflict was
> deliberately injected to exercise the error path and is not expected
> during normal operation.
> 
> Fixes: c6e3fd22cd53 ("Staging: add speakup to the staging directory")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/accessibility/speakup/serialio.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/serialio.c b/drivers/accessibility/speakup/serialio.c
> index 3418ea31d..56efc76a7 100644
> --- a/drivers/accessibility/speakup/serialio.c
> +++ b/drivers/accessibility/speakup/serialio.c
> @@ -17,7 +17,7 @@
>  #define SERIAL_PORT_DFNS
>  #endif
>  
> -static void start_serial_interrupt(int irq);
> +static int start_serial_interrupt(int irq);
>  
>  static const struct old_serial_port rs_table[] = {
>  	SERIAL_PORT_DFNS
> @@ -106,7 +106,13 @@ const struct old_serial_port *spk_serial_init(int index)
>  	speakup_info.port_tts = ser->port;
>  	serstate = ser;
>  
> -	start_serial_interrupt(ser->irq);
> +	err = start_serial_interrupt(ser->irq);
> +	if (err) {
> +		synth_release_region(ser->port, 8);
> +		speakup_info.port_tts = 0;
> +		serstate = NULL;
> +		return NULL;
> +	}
>  
>  	return ser;
>  }
> @@ -125,18 +131,20 @@ static irqreturn_t synth_readbuf_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void start_serial_interrupt(int irq)
> +static int start_serial_interrupt(int irq)
>  {
>  	int rv;
>  
>  	if (!synth->read_buff_add)
> -		return;
> +		return 0;
>  
>  	rv = request_irq(irq, synth_readbuf_handler, IRQF_SHARED,
>  			 "serial", (void *)synth_readbuf_handler);
>  
> -	if (rv)
> +	if (rv) {
>  		pr_err("Unable to request Speakup serial I R Q\n");
> +		return rv;
> +	}
>  	/* Set MCR */
>  	outb(UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2,
>  	     speakup_info.port_tts + UART_MCR);
> @@ -148,6 +156,7 @@ static void start_serial_interrupt(int irq)
>  	inb(speakup_info.port_tts + UART_IIR);
>  	inb(speakup_info.port_tts + UART_MSR);
>  	outb(1, speakup_info.port_tts + UART_FCR);	/* Turn FIFO On */
> +	return 0;
>  }
>  
>  static void spk_serial_send_xchar(struct spk_synth *synth, char ch)
> -- 
> 2.34.1
> 

-- 
Samuel
c> ah (on trouve fluide glacial sur le net, ou il faut aller dans le monde reel ?)
s> dans le monde reel
c> zut
