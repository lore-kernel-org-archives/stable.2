Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BEA33F385
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729048; cv=none; b=p+2eQyzSsQPeCrpnOBbShHnda2cgirXzbGNQNFzF7PGyrgNIYLDxYcw35ZlMIeys5biJkpqU9X4fi+dpyq0t5+0nueZ8a5w4kaguCJ7bXxdGa0DKaG4D4WxaqNJXkF+Td4skHkRnXAyWioQu0g9o2d6NQHk9ig0ZFJ3RJEYOE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729048; c=relaxed/simple;
	bh=AT1iOZIgI0G2w/DsDzljkDDBTzqzwW8LnfeB4zK9+Io=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhNzJLYmBuAWvVd3tvz8creX6i75aNudOOoOoXzq5UHnxOSxh6mg5FRQHzZhxqUCDwt1j6OlPaZqdu+hJ9bUjQaSm5kjwARAnCuYJIUSet3id0YdPF0ohqLNEkbbD9Bnbt9MvPPWGU9LSUIFzf79yrKC1gY225q1TFQFuW/d1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvP5aSiH; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvP5aSiH"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66899c7b57bso508350d50.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784729046; x=1785333846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5h4UrmIJtTrB9KVtsD8cZwtpryJNbIzuhP6tvoigZY=;
        b=bvP5aSiHi9XyWSr1y7MShE4gcNxvpPnT6S8e2t0+628w/OU7VHfOMwUHhwWusvCATk
         1yaxlsShXC/7nci5eVTQD37y/WifQZoMW4MFeN7slv0bjQtfnsFF+Hi0Yxvn56qeum3/
         POeKFp/gpp+Wk+iy9dfxIUL/R/hHqSEr9HLkV3s9BF75eOObLcQwLUNrbLEdq9PoB9F9
         1ZOESZZEX/lk9nI9B2gkqnhexy8Jva6hfFj22+2Tcr50z1DZDSArQI1EDy3xNnUyp5i0
         T2vJLefGkb6a8zeTBBAgX2fecRFftQ/26FNC/gJnnOLynLgATR+VFECVJ1JqTGW0X0jK
         bDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729046; x=1785333846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5h4UrmIJtTrB9KVtsD8cZwtpryJNbIzuhP6tvoigZY=;
        b=gCkSTtBZV4ECyQNjlXcBl40OsfhBQgRDZpuIGnyWFMO8JTduREs6hUGGvGzMvQ3Ex/
         O6Jrt/ctkqu9mVUtM1y2BW0CMRspu9jW55xESOVZIK302S+eYjLwjqLxoMMx6AxAuikk
         rtC7/s0V2HyguhfbxoLdGzgn4Yo+njRqlijc9ODyPv9jfMqAjanPF042kwu55cSO6WYy
         EPFSeN3aC4kIjgU1KJEQQNrBm5LUP4VswyICzKN+Ul6uDyo3lQkCQri+gjW4BtU8Qxiy
         xrR0I6YQ8B2XwFoIZculzzMK9fjhlydl4F0yqHlgl2VqafSUehY2okKLSN5IBlAf3wHU
         WBYA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8I5erkGvGlgtWMBbRQ4e5HXTw/hZUhnuUrDISwNaf3paEPWO84MAOMmfhBzpXT78MaV5dep8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySoS2DJXHE4wiI+kJLh8WCgo44WFRIpaGZA4S5+6jyt5kOomsP
	qvamPmVG7GspNsaXhoHQGJeY1rfDIHvYlIOhqyUPOXG5fU79L+wSif4=
X-Gm-Gg: AR+sD110iieIql6gG6EzXDl9DYjmzpQXt6297U005y+XYBv43ZB34ZwNhxil5MIYzVj
	flMWiG2fs+iSahmBwW6IDgOWYMg06INFx4pOTP3KhEdEWuD0qrHONdcA0LxBvNGVhy9sZN12aJ8
	6dtp+qmIk7wRznm+XXhui57OOyq1m+uvMm9Rw1OgWrF/HJjRPlUzTYTx0vq3yTBqXLtynLg7HO9
	eWUhusuAN55wm42CgbfhVIpCWpP6tFQXNH6Fom638MkWZ/h7zaue6wcR9jm/EqMQPJcC1EiACWs
	ii1KlLOSc4DvFLr8d9Wxp1OM0SaIUNiD5PWcfQCRL9VLJ2taQh6C6QgbpKH5bTRM4yeDbbqiNWU
	f+YTZkgcDDGVRTPAltDauadEaVL8z1xARVUFmaAvlswp8/cWY4AuuEXFIoqULyjGYfRvIlssImT
	U7xtEKW9Fwo8skRtngG/A/PJBs36u9qEzXdBd5giRD8mukmk6L49YYI13ZClIyik9iMw==
X-Received: by 2002:a05:690e:4890:20b0:667:9d0c:5b80 with SMTP id 956f58d0204a3-6683bb61805mr4722351d50.28.1784729042080;
        Wed, 22 Jul 2026 07:04:02 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa296bcsm21512146d6.47.2026.07.22.07.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:04:01 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Wilbur <rwilbur633@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx
Date: Wed, 22 Jul 2026 11:03:53 -0300
Message-Id: <20260722140353.115899-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP LPC32xx UART (PORT_LPC3220) can latch an RX character-timeout
interrupt while the RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT
(0x0c) but LSR.DR is clear. A character timeout is only cleared by
reading RHR, but serial8250_rx_chars() reads RHR only when LSR.DR is
set, so nothing ever clears the condition. The interrupt is
level-triggered and re-fires immediately, so on a single-core ARM926
the resulting interrupt storm livelocks the CPU.

It is reproducible when userspace repeatedly opens the front-panel port
(ttyS1): serial8250_do_set_termios() re-enables interrupts on unlock and
the handler then spins forever with iir=0xcc lsr=0x60 ier=0x05, tripping
the soft-lockup detector in serial8250_handle_irq_locked().

LPC32xx has no dedicated 8250 glue driver, it's driven by the generic
8250_of. Add a hardware specific handle_irq for PORT_LPC3220, wired up
in of_platform_serial_setup() the same way fsl8250_handle_irq is
installed. The handler follows dw8250_handle_irq(): on an RX timeout
with an empty FIFO (LSR.DR and LSR.BI clear) it does one throwaway RHR
read to clear the condition, then calls serial8250_handle_irq_locked().
No real received data is ever discarded, and it is a no-op on healthy
UARTs which never report a timeout with DR clear.

This is the same class of bug already worked around in other 8250 drivers;
see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
which reports the identical iir=0xcc/lsr=0x60. See also
UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.

Cc: stable@vger.kernel.org
Assisted-by: Claude:Opus4.8
Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
---
Changes in v3:
- Move the workaround out of the generic serial8250_handle_irq_locked()
  into an LPC32xx-specific ->handle_irq in 8250_of.c
- Skip the dummy read when LSR.BI is set, matching dw8250_handle_irq

Changes in v2:
- Drop the PORT_LPC3220 gate and handle the spurious RX timeout generically

v2: https://lore.kernel.org/linux-serial/20260720131123.29840-1-rwilbur633@gmail.com/
v1: https://lore.kernel.org/linux-serial/20260717123530.481021-1-rwilbur633@gmail.com/

 drivers/tty/serial/8250/8250_of.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index f0537fb6ef4f..93db28a48dea 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -82,6 +82,40 @@ static int of_platform_serial_clk_notifier_cb(struct notifier_block *nb, unsigne
 	return NOTIFY_DONE;
 }
 
+static int lpc32xx_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int iir;
+	u16 status;
+
+	guard(serial8250_rpm)(up);
+
+	iir = serial_port_in(port, UART_IIR);
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	guard(uart_port_lock_check_sysrq_irqsave)(port);
+
+	/*
+	 * The LPC32xx UART can assert an RX character-timeout interrupt while
+	 * the RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT but LSR.DR is
+	 * clear. The timeout is only cleared by reading RHR, but the core RX
+	 * path skips that read when the FIFO is empty, so the level-triggered
+	 * IRQ re-fires forever and livelocks this single-core SoC. Do one
+	 * throwaway RHR read to clear it; a healthy UART never reports a
+	 * timeout with DR/BI clear, so no received data is ever discarded.
+	 */
+	if ((iir & 0x3f) == UART_IIR_RX_TIMEOUT) {
+		status = serial_lsr_in(up);
+		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+			serial_port_in(port, UART_RX);
+	}
+
+	serial8250_handle_irq_locked(port, iir);
+
+	return 1;
+}
+
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -185,6 +219,9 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	case PORT_NPCM:
 		ret = npcm_setup(port);
 		break;
+	case PORT_LPC3220:
+		port->handle_irq = lpc32xx_handle_irq;
+		break;
 	default:
 		/* Nothing to do */
 		ret = 0;

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.25.1

