Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2313ED105
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291748; cv=none; b=q0E7Q0XDR/7rxjImALywIcl+bxiUfuRmmV71hLFvrocCNp1ZsaFK1o9mAH27EO8CzgLl7kAVWlD+rSWLCDLK8W+QENiL+J2vHiAuxAe9zeail1zMoFUxHMMi93/HDFO4yYMP5anaxliH2pVBRC6qQhSDOM2N5QSsjyaghNGAQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291748; c=relaxed/simple;
	bh=NoYERio/mf4DLekWv4MCy7+mB4/+mSN3HNuFTWNN6Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HGFsz/o4psEbJlEm2lKCpIBsq4zP47aJcNGUewe6+W071wN3EElg5YVOkFcLN7HcRpOHPltzJzgMsQrEFZP92UHZaVkuZHvzNQ0EVtkTUOnlw29hmrYqq72buvVtfgWakeu7V/mnHkDr2lQcSZdhK+IEZ5T/K12pULS0w1Da7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7lrpT/z; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7lrpT/z"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ff20870ac7so58931296d6.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784291743; x=1784896543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMekRXzh3ZMunw4GPDw9aK7U0CvdM1LOGZ4vytcNb5w=;
        b=o7lrpT/zuAOqr9ryFmpbtQgOkh4N57dX3lbTLAoLMwaXUClfMhl7ROqowhGYMeGQcJ
         btxjcv7y7yHHlkoqdzpDylX5e6tV6kzEPuqvhGsUddmOWZv0SD9Xac7uqAERZTHB04fB
         j0yNFjt9NLiKiD3P/XEFXT1VdpN3RufdrH1MhOwdMXC4Xma41O422PI1xiT0EkE1RpkI
         9a1F+EOLYZJYF8i+oDtWH5vVObMm5xPj5GFvOsRGFv/cmB1+giREArwB2rQ/n8/3f3XK
         K44mzpglCrKJkflhOlrptCS7LwU7aqtM+Fth0dLvxgLdtqH6o0r51nI+hYTIcaWGMrJC
         wK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784291743; x=1784896543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMekRXzh3ZMunw4GPDw9aK7U0CvdM1LOGZ4vytcNb5w=;
        b=PxtVpkPPEqKQa1ZLlEd8GkIzN2bnIjh2ho6/6bObYJCVP960p0eogxakchHBq8BnoF
         A7Y3TxbG/a+J5x4oUbjfSfjGmgAXtC1frmGVe1+MzHyWiXSDMIMxDspZpr9jXhp6Wi1A
         jPxmXMfaV9A7B+TWQ3GguSPL7JQxxSz1dMxDM5AWeQcm65vWQSXa3W32Cj8ojET2e+9J
         PBIgbnz8Hxcx+mYuI7/AlBJUWPHak73eWmISdsU49iiRRP/KqWz6N0bjDcx7fRVkJ0jk
         484zKRfX+tcDNVJW+RbpVGFdP/aPmsL9doHH83Y/yryCEj4RFkKHT3xXGcyvqdxt5nZA
         oH7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqx1ifjLQPyYve9Vy4ItWPL8IrofLtyNwtyKD+QURogHE5OXNv/O5I659yp7FySQc5BMSjbLBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1FaElSIy/TLk6Y/xZCdfFRM2AT4ohosLUH7s9E7p0AfuDq1F
	ahlHqAnkxNwKO1DoLLT2ZUIcEMVDY73JmqkMsyRRyOTOexF0u37rTOk=
X-Gm-Gg: AfdE7cnu4bdpDoHKmfU1wTUbrsDX0S5xXBl85zAs0Puje63asFh3LRWx16F/8GaRz4w
	5b1T5QQ0izR8nsYRKkGDMjK03eqGnp0gK+JKz2Z3TBVjYGmtyNPAGNMjxyZGZQg2D1yAqhHKIic
	tfC6YhXL07FlmuOBraMKAZauAToSylpk4sW1gjz4c0z0xuHTR2LPTVTavV/L8TjHqAyaFFqNiga
	gnZrKEBXvuosnb3hnSVtac8WpXd3RFQLBgg/Jn7U34fgUBCnGHDrj20H0XdxkIe8NyXaL4ejtEB
	OhPx5hh2qKlLkKuXg8iP68k8aq4Se53sjmBZDhHnw9vZzkcl4I8O/4qrbLu/NMAaMW37AfjjMtr
	n5T1nq1PjgWuN8oWL1Jvic7Y2PmUFSU8q7mHQ8Vd/JpYM9TAAj/RCFa03Nt2IgR5T9yGLvXF8NG
	EqjPZG1x81Y/LA5M/LUYRhMRgrZtxAfFD3OggX9ptvzdmv7ss16zRzdWE=
X-Received: by 2002:ad4:5744:0:b0:8f0:3736:dff6 with SMTP id 6a1803df08f44-907784fd685mr29769246d6.46.1784291743174;
        Fri, 17 Jul 2026 05:35:43 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b21d6sm15558116d6.24.2026.07.17.05.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 05:35:42 -0700 (PDT)
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
Subject: [PATCH] serial: 8250: clear stuck RX-timeout interrupt on LPC32xx (PORT_LPC3220)
Date: Fri, 17 Jul 2026 09:35:30 -0300
Message-Id: <20260717123530.481021-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LPC32xx UART can latch an RX character-timeout interrupt while the
RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT (0x0c) but LSR.DR is
clear. A character timeout is only cleared by reading RHR, but
serial8250_rx_chars() reads RHR only when LSR.DR is set, so nothing ever
clears the condition. The interrupt is level-triggered and re-fires
immediately, so on a single-core ARM926 the resulting interrupt
storm livelocks the CPU.

It is reproducible when userspace repeatedly opens the front-panel port
(ttyS1): serial8250_do_set_termios() re-enables interrupts on unlock and
the handler then spins forever with iir=0xcc lsr=0x60 ier=0x05, tripping
the soft-lockup detector in serial8250_handle_irq_locked().

Fix this by doing one throwaway RHR read to clear the timeout. It is gated
on PORT_LPC3220 and only fires when the FIFO is empty (LSR.DR clear), so
no real received data is ever discarded, and it is a no-op on healthy
UARTs which never report a timeout with DR==0.

This is the same class of bug already worked around for other 8250 cores;
see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
which reports the identical iir=0xcc/lsr=0x60. See also
UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.

Cc: stable@vger.kernel.org
Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8c241ec7f4f2..20014f54637b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1803,6 +1803,20 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
 		serial8250_clear_and_reinit_fifos(up);
 
+	/*
+	 * On PORT_LPC3220 the UART can raise an RX character-timeout
+	 * interrupt with an empty RX FIFO (IIR reports RX_TIMEOUT but
+	 * LSR.DR is clear). The timeout is only cleared by reading RHR,
+	 * but the RX path below is skipped when the FIFO is empty, so
+	 * nothing clears it. IRQ then re-fires immediately and livelocks
+	 * this single-core. Do one throwaway RHR read to clear it.
+	 * Same bug worked around for other 8250 cores (8250_dw, 8250_omap, 8250_bcm7271).
+	 */
+	if (port->type == PORT_LPC3220 &&
+	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
+	    !(status & UART_LSR_DR))
+		serial_in(up, UART_RX);
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.25.1

