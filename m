Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778761;
	b=HlR7zbiBpHAaaEmRLNXbscGYxrCMUMQbEeW7wdqEfbiphqUiPI3uI+SXFDcfxGAERSen
	 dLqlbr3SwcWtE/20z7PlLkx+njjVILLfbGVQDi7IL60LEzUxMuKQxuvhLAEqJNmNP6Mox
	 7u8QNmHly9b6VZfyhdx5XuDUp01+q5BDIyCyNjpuXo8Bhh6icLHXaqdF2ICYEDmbv4EgZ
	 nDRLGvMzRp+7591Ng/iVrHG5H06WW0mOmDzuKoj2nBELcCEF5yd08x6FUB6MFjG26N7Z9
	 JcIUuzGqjGEO3YW9K+rBwyXoYbbwts5MOvvuEuy4jD3H+jttlkdUK06FJF8kuJwvP/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778761;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam;
	bh=eLVQ+rkEWlZh9OyBCVyIy4A0a648+SPumOag+z0r0ZU=;
	b=fx5DuRwZTfEVmtnyZn9ElAGdcsyuXE3HrCepB+upc+rDd98Auea+G1K2U6Tp8a3Q0jnj
	 eUPFjMWeEn6wbumJfNGC0WkgCjSPeAbPDB0v2LX4BP6eA2H2sknNnWsOKdNiJm2ACt50h
	 RNc1UvpuhSF53kxC30Szu3mB+zcHkw7ZuUgxhEN8EqCBrhOqz38ucNFknSGy1bij36kRo
	 Su6ELB2wPPnq49CVMcVC9GKvPib3kZsUKlQbupim/N7+AUcknkRwc0P9sfk2QLUgWlxIb
	 WwGx5rZbVkKCibEyacwrrGDtuQ4aOTgxDugHzrQ9qKx1Nl+FbHwxGsPLlHl6n+cohlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=UYyPlg8i;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCC606A693;
	Fri, 27 Nov 2026 11:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DCC606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=UYyPlg8i
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 721CF4C992;
	Fri, 27 Nov 2026 22:25:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795778755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLVQ+rkEWlZh9OyBCVyIy4A0a648+SPumOag+z0r0ZU=;
	b=UYyPlg8itGP4fgTqP1IOg40UGBkdIEotSRL9E2JWfB6RSDVB6bw+wuVTP+5eQok4rwuI+P
	Q2v+Iz1cBATc6+scYKX8e0tJoimITPQmvR41gYqk4s3XhewD1wQ29Tj/FNi32tPLSyAEtm
	wV8OLBPxuoWAj2aSp0Unmk8p8Qnm8o9XAA62TNUjaATgOL2aXI+ZoKFyiFFSiTwEzJ9xYJ
	gRTejQpOWrc1Pz0DoQYL56/uUd0PDhcJxbV6ooxGTVsWYjZNqC6NGqzpuJ1tQze1ut3S43
	3D4beU+A/ihQjxivrgvBNwjIW8AFLKJjo8qho5KS6uO9pnLnDz0cv7TmPQbSww==
From: Alastair D'Silva <alastair@d-silva.org>
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org,
	Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Fri, 27 Nov 2026 22:25:55 +1100
Message-ID: <20261127112555.2585439-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

On Mon, 19 Oct 2026 17:06:10 -0300, Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com> wrote:
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
>
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c    |  2 ++
>  drivers/tty/serial/8250/8250_dwlib.c | 16 ++++++++++++++--
>  drivers/tty/serial/8250/8250_dwlib.h |  1 +
>  3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index eca02e8bd6d1..4c86aaf9c121 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -197,6 +197,8 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  	if (ret < 0)
>  		return;
>  
> +	__dw8250_set_divisor(p, quot_frac);
> +
>  	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
>  	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
>  		goto idle_failed;
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 9bb02a4ab11f..325793f20256 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -36,10 +36,20 @@ static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
>  	return quot;
>  }
>  
> +/* Program the fractional part of the divisor, if the UART has one */
> +void __dw8250_set_divisor(struct uart_port *p, unsigned int quot_frac)
> +{
> +	struct dw8250_port_data *d = p->private_data;
> +
> +	if (d->dlf_size)
> +		dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
> +}
> +EXPORT_SYMBOL_GPL(__dw8250_set_divisor);
> +
>  static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  			       unsigned int quot, unsigned int quot_frac)
>  {
> -	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
> +	__dw8250_set_divisor(p, quot_frac);
>  	serial8250_do_set_divisor(p, baud, quot);
>  }
>  
> @@ -218,7 +228,9 @@ void dw8250_setup_port(struct uart_port *p)
>  	if (reg) {
>  		pd->dlf_size = fls(reg);
>  		p->get_divisor = dw8250_get_divisor;
> -		p->set_divisor = dw8250_set_divisor;
> +		/* Keep a hook the driver has already installed */
> +		if (!p->set_divisor)
> +			p->set_divisor = dw8250_set_divisor;
>  	}
>  
>  	reg = dw8250_readl_ext(p, DW_UART_UCV);
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
> index 39fcb1b323ad..4bb0ccb3e8ef 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -99,6 +99,7 @@ struct dw8250_port_data {
>  
>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
>  void dw8250_setup_port(struct uart_port *p);
> +void __dw8250_set_divisor(struct uart_port *p, unsigned int quot_frac);
>  
>  static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
>  {

Tested on Xunlong OrangePi 4 Pro (Allwinner A733):
- UART0 (2500000.serial, ttyS0, base_baud = 1500000) boots to shell and
  echoes interactive console input at 115200 baud.

Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
Tested-by: Alastair D'Silva <alastair@d-silva.org> # OrangePi 4 Pro
