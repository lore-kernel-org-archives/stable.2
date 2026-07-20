Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77D41A79C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553090; cv=none; b=oTzItRBICvmhcLZxJ1tiZSIA3tCYSBfl9XzTK/gOO6xLuK3W6WEBvef+xQyc/ONTEVX0/08tO31R7U3f4wZ32M8KN2dtrzPRp75ONZ28aHwR+AqqkN+HNUBAUVP+uJvW1lDiwKrXtd4YLHWXlVKPmz8TiCKt9tFT+/S2Ii9kd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553090; c=relaxed/simple;
	bh=Ic1mjyhG74UKb3Y9WRfTc4sM8v6bo+xZ0k8sXMFYhoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b72poUaNdGtnpM22CAZU/Lo6QCNzTm4Ad1ammwFPu58i7XzkOSk0hvhbCl9Vh7XDQFZ2MF/WWvXQr3MJZpaCEbJduP1kAPalASpMi8XGSCebZpu1zl38gq0FSp/+l3OHi4wjhjxAwZwWG5wSDtUnqk5xv/OCi64BYnyNP8/AQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owFADj4T; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owFADj4T"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8f0d6853360so80511636d6.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784553088; x=1785157888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQ61Qwl4wNBqojEyy6dBtjcn4fhIUIzUAIvLJbLRdSU=;
        b=owFADj4TX2D5vwkBFt1J+Awop72VivILRED1280s76Ax62QlBHkZiIqnt9KBD9dRI6
         m/HC2iKKv2/NVTOJst1EykapER461asGimRonIUWJ0DAAGMAHuhV8rf0BHI64Dr5KgE6
         N8QBbw/m+E1WSl282ZP9JsP8xopn9guyWolwG/OawsP9H9O5IA9TdXXzjXRJ63VfZjKg
         qHLAAA5irBWs9GL1Rv67EB6y2EIrty06UbRyMbWmuViwqhn0romblAC4qSdnstPDlVLU
         wJaim0vIakFQIIomo2QYeesupnSUPXBXUu86u2bVaH4tQWOF6aU624gKTrhGgcP4ksqt
         Z1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784553088; x=1785157888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQ61Qwl4wNBqojEyy6dBtjcn4fhIUIzUAIvLJbLRdSU=;
        b=Z1NHrlowG/8afTOqnXRRAz3nITI7B2nU7ye+1HUc5wFD6TpfZqOjL/qV1HXY0x1pTC
         H/r38vV0KeNXVNLhDf6LGzwQAOwzVn8YPnGkZHCOqdwVmVEbohlq4r/oc6BtwNrexorl
         hyb2XzjHajYXbTNn+kuQFu/C3pfJXtwfv+z1Q7fWEhSyUTRVGqgCqCdvDaV5BrJlyfNo
         pOiMT20p/a3tMs7ty6XwNyv6QiDWTY9tNPBSLKS7jW9H1u7oyhjvCJ0AVbWU/7EJhc9L
         rVo0971VlAC40OwGa08SwYHB9T3jUOdsdzwwb1YDd01P+iTqc5aorEINWvoNyVLLisso
         NjHg==
X-Forwarded-Encrypted: i=1; AHgh+RpWdnj4Rtf1aQEh8SCe9FS/qFv4QYKWbDCR4LusxKOT+fUyca8jgtNJVMKmd16D4/NBc2QGWt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40fmE1h/I38ZvtCJKH56liXS5JIR8VRNtFHccnEDjnXUd1vp6
	DZJokiUCrYG5RdT/WDSiuUe7d+UBrj07to4Y7qXxWbAp3KHNVl5Rq64=
X-Gm-Gg: AR+sD11KeLN/KBhH/8bnxWN3o/Z+0voAg72ePDtFXWjb4XoynGDfgV9lsGLUAxyhtRB
	v49vus2LUVIsiOP930ycLaS+rXkMk0xlesTQrzHAovT4VP0W/53PLLip0HD4TXenWxHLTPJ3k0j
	mpJBWXUoAm8POuzv93dwcC0dsFAtsbafpujWd2MwxZIDEwaOm7wLI0cEFbVcBonwHSJYKROmNZS
	vt2sn8o19SqGdHJ1S0g4kbVZI9uoVHDw0gND6W7tgvqa4pQy1R1I+2GX8nUJaOpQUsBhVxg4KI0
	i0Sy1qyO0ikrvkLHF/wGWhh2BgZYshkqOOBI3YzCGQJTqsvVfmSO0NYzZFkhtLfi8lvfJiFgQmE
	9E8DbqQfLDbR0swLxqj0udgZWWgYjFz1WXZWhgzsCW7sGrw4LD3XCW8Y6egVfuLX4pQxYOhKk0J
	qh61Wx/LqXQhm3YSdnjorBG5p5LomnpZKqxezlsUU8z+DTVmM7XaL5kfw=
X-Received: by 2002:a05:6214:5886:b0:8b5:e126:e77d with SMTP id 6a1803df08f44-90778345ddamr154463306d6.8.1784553088200;
        Mon, 20 Jul 2026 06:11:28 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9078b6d8cd4sm61211476d6.29.2026.07.20.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:11:27 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	john.ogness@linutronix.de,
	hvilleneuve@dimonoff.com,
	m.felsch@pengutronix.de,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Wilbur <rwilbur633@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: 8250: clear a stuck RX-timeout interrupt with an empty FIFO
Date: Mon, 20 Jul 2026 10:11:23 -0300
Message-Id: <20260720131123.29840-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some UARTs can latch an RX character-timeout interrupt while the
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

Fix this by doing one throwaway RHR read to clear the timeout when the
FIFO is empty (LSR.DR clear), so no real received data is ever discarded,
and it is a no-op on healthy UARTs which never report a timeout with
DR==0.

This is the same class of bug already worked around in 8250 drivers;
see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
which reports the identical iir=0xcc/lsr=0x60. See also
UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.

LPC32xx (PORT_LPC3220) has no dedicated 8250 glue driver, driven
by generic 8250_of, so it's handled here.

Cc: stable@vger.kernel.org
Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
---
Changes in v2:
- Drop the PORT_LPC3220 gate and handle the spurious RX timeout generically

v1: https://lore.kernel.org/linux-serial/20260717123530.481021-1-rwilbur633@gmail.com/

 drivers/tty/serial/8250/8250_port.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8c241ec7f4f2..c63c4165105a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1803,6 +1803,21 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
 		serial8250_clear_and_reinit_fifos(up);
 
+	/*
+	 * A UART can raise an RX character-timeout interrupt while the RX
+	 * FIFO is already empty (IIR reports RX_TIMEOUT but LSR.DR is
+	 * clear). The timeout is only cleared by reading RHR, but the RX
+	 * path below is skipped when the FIFO is empty, so nothing clears
+	 * it. With a level-triggered IRQ it re-fires immediately and can
+	 * livelock a single-core. Observed on the NXP LPC32xx
+	 * UART (PORT_LPC3220). Do one throwaway RHR read to
+	 * clear it. A healthy 16550 UART never reports a timeout with DR clear,
+	 * so this is a no-op elsewhere.
+	 */
+	if ((iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
+	    !(status & UART_LSR_DR))
+		serial_in(up, UART_RX);
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.25.1
