Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE93FE660
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211292; cv=none; b=YNLTgxDGNV6SA4/8gDF/vbrgeuUwmXUYF0Lsl+vxBOhgaITNp+2Q4fScpQ0IWWXXsIIBgqBjkoiGevO1/4IDWO9ABms5/sYvazMrZ9CZyoVKpemPDL8pJj5/nmG/MNJR6jKqALnkUjqpR9ZOWMuWztnG9MMCWgRj0h312JvLVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211292; c=relaxed/simple;
	bh=YQAPQWmWz/3OrSr530ix1sQ+fmG8yXCRffCqgVo239A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+/DMSlGetJKEBrElFx8tpsF/5Za1LBWne0VTMAdlnhHC0tP4XWdLT/RxlV0JFRO7pYLN2YZCygkytOhgP92I0JAGuRhDNm4HlNvGpqoeGlWB9fRLnxmZj7mhNF/MhLpzJ3BaDcxiNXTCbjW/Mfz56ZSdY8GO6ZOprcJR+fwWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+8Rvhp7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+8Rvhp7"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c1805b8a7so68519961cf.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784211290; x=1784816090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pmk/g9SiBCrADp6cJenF/T+4BKrTMq79lxGLF4pXWNQ=;
        b=g+8Rvhp7I0EMrm2+JEH8xWvnzZqSc8Eald2WJi/Hog6zhkheEgzbvPL0EI6VkDMreM
         wO7PkhNm6oT1VcDO4cATsMw5ZiQ0V+Qe4i73tTEgsYfpSf8Ig+M7QJJ7v2HRX7pWIC/1
         ju2OEVvRljnYiiF3hi4IKf/7R56cDYIOPptBJsJAw1ZNHcETweuPthsvdtB3NrdhL+r1
         fXHqB5WpgQLezoc9tdjtOlwxQa7eoICEFG002JCHZmtjOgdn1hrrxTZ7jayomNqzqEa6
         GHhLriKa9AA82w3VjUj76q7lGVaTcajnmOPMXiRfQe7pdRfg+Am8HI1wcsPX3B2toI7D
         ugaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784211290; x=1784816090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pmk/g9SiBCrADp6cJenF/T+4BKrTMq79lxGLF4pXWNQ=;
        b=sVkN9WE/8ESe9gyl4xXnATDzYaA7RHYsDYElgCZdd19L1hB7gqZFoijKddTxl+yzGD
         eoO3MRsL5a3iC/353UoL72Vqrpoj+3m7LALP2TASchaHCMbDa3yVO9QGOFf9nF2IhY70
         nKDWJZNq2XXxYuBg06rMYd5eltCh7C82ZaN1+Yn+g7TmmMIRArCN9Oxk0M77SLsCPbAF
         +gMQiRWrgSvLlODFLjpD1il1CCcphFAKacWV1ysyPA8AE/ZHaBvGHMqP+smhtObNtJU9
         b9rBLQWt9v83NHGUKTglxvI2wjzqgvEy1R/0uxEuB3iDQUR4VHQggiUcn3FRXt0vOtJk
         SYjw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3ewzYHSz5OOq1tgZAPyb6rAYitX6mAJYw4XDNyu5kwrqrQ+YziiijTFoJIn6XXwYIWnCH7OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9srSAoLrQWb8mtDg8sCxIQZZcNYYMxWi4uqd1z8jG0y4ZTSYJ
	pXXfGuie/JNW6vmZCyUYMJpA/L6mM9AD2IAHrurJG1AbjxmK+u0JE/0=
X-Gm-Gg: AfdE7cn72y7ciImT8Ufk2swK6qwnGj3dvseAzhvr4sM+GdVWn17yRsrblW1fGSvViiZ
	IVwxRO6fbEgsU5cF5+zh1iHK0uqIO2aya8GKhdBDFZd6GYDwpqurNCbg0wXK99vyS1u4q73j0wG
	tF9Q5t7Wmz3kj2mEUs2hMEekg/Yg2JbG7MgQFJ5kFt4VLX4DiicwcPnbwdUO7hTpq/WAesLvlrR
	32oITF7K5/YE6I1SewG9Phy+pZ4WyATdqKYzQU+K0n2kutrrGVYlvKefY/RHpYGr49qvT8hgMJx
	iuxrsY7PYmqDBthz5sffXHaL/ZEKjCsD+uSXEzbgOy5yKzGqxvtIm+4e+Dw+IlF7DS71uOx23zL
	3koxYkevAP0b69i6FETUk6+2nvKk1UojM5zhuGp3Xtt4LCDon0tgyVRHAtJ2pxFsG6ZcosMSQbc
	OoHvD7UAB89wdRJN3+M7f6/AyM3nkxWpZugRzYCW+gWTJW5E0faGaInI4=
X-Received: by 2002:a05:622a:2287:b0:51c:7b12:5fd0 with SMTP id d75a77b69052e-51e4f128b56mr81990261cf.76.1784211290125;
        Thu, 16 Jul 2026 07:14:50 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-902de1fdb3bsm193431606d6.23.2026.07.16.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:14:49 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: ryan.wilbur@nautel.com
Cc: Ryan Wilbur <rwilbur633@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] serial: 8250: clear stuck RX-timeout interrupt on LPC32xx (PORT_LPC3220)
Date: Thu, 16 Jul 2026 11:14:41 -0300
Message-Id: <20260716141441.426598-1-rwilbur633@gmail.com>
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
index 8c241ec7f4f2..d1d91e7ac6d1 100644
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
+	 * this single-core. fix: Do one throwaway RHR read to clear it.
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

