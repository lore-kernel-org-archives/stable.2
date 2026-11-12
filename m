Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470969;
	b=ogdAn3Kw52m/hqrixEUCTVNrqtCt3MiTxuXflBDMUMaIek0lvAj77NZ5mLjIgzpfKuUx
	 ZivWoKQI9VLwRg+YNValMjKNmL9TFGFsrAasE5zUxak6POLNSeGIx4H2YINf5CfcMLqXi
	 ow0YYp8ynvtPIBfzRxAlPY7dkd4+34D5SRXJTTJoEgPQMRyZEuoX1Q1oDLCIfd8odiU/v
	 xS/QPbZqu02sC6RrgquxdaPxjp3Jnj04oNDTbTUQZITCCpKLrs8IsL/Zb/8dPdNT0ZncS
	 CvRNkdTgXz3mgN+g+pnKeAEtL2YKQvqIIa7OrLk4LwDTWVoe4GujetETckjMLatYA6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470969;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=988cFYCco2UVxhQOV932+iu6PadrqBML3ozuD8TRvus=;
	b=cFkBBkCfv/VmfTDgIQ0bYruFbCOn8rWAPmb0/XyQKXLH/eudNvYhex8H9l024+AITYGq
	 o49+QVt+fDzOR/8BphUx6MizpA5l5R9L4VijBlNpUswkPaMLdyNxR8e7h9MurHYOWBSBT
	 lph59IdGBY5KIWDvxcnD7eq/oIxyYx6oq16ZT1DauUlWRONBZqifPXc9K6JBHQQJVluo+
	 1Jq4QZq7urt+Rp+1LtogaCpwwyGD+b9GSa+pBQfkvsaQ7y7puV31ONttVeJ3ExA236YVl
	 o6Nq+qlG6zVAyLspwfdkN7t8c2AwTA3C8EpfnaJXDnfzULlKo4zyKGvPUMaaqCuRBbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=VSFkenfw;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953D606A89C;
	Thu, 12 Nov 2026 08:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E953D606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=VSFkenfw
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC874A1675;
	Thu, 12 Nov 2026 09:09:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794470967; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=988cFYCco2UVxhQOV932+iu6PadrqBML3ozuD8TRvus=;
	b=VSFkenfwKU44Z6vCXx0hx5yJkJUXNQ/2EWmT/nyBWeQSOZ8+mZ9wWJhw9nBZ6KNrYYekH3
	leIfrilpl3mS4MGcq2Lwxyf9C8ZDl5Lm8cQt6BY4alVFkjdvwQMmMkDdm4IziIlkRp6jrc
	1W3LMO4ZQsQ9xPATngXct2G5F/77lxgN2e+o05aFbEYUsW9Q+k1a296bndSi7Y0w2tf2wZ
	A92dhFgiMkh95J7QMbt/8hZHdjCX8ur9vlfDW/NOwVLF6atDerihXhOTeBifuk6Gblu5Wc
	pTUW814/UIo7sF74kYJZsczVCjVhn45N6YOroPSLANjFXPhc31/eow9ywmFqRA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 12 Nov 2026 09:09:24 +0100
Subject: [PATCH RESEND] serial: amba-pl011: end an RS485 transmission when
 TX is flushed
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-devel-nbuchwitz-pl011-rs485-dma-flush-v1-1-6b811391651d@tipi-net.de>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

A TX flush during an RS485 DMA transmission only stops the DMA. Nothing
ends the transmission afterwards, so RTS stays asserted and the bus
stays driven until the next write.

End it from the flush, unless the TX interrupt is still enabled and
ends it itself.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
A separate issue found while preparing v4 of the RS485 reconfiguration
series:
https://patch.msgid.link/20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de

Tested on a Raspberry Pi CM5 (PL011 on RP1 with TX DMA).
---
 drivers/tty/serial/amba-pl011.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 79776a882ae35..b21de1f2c7807 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -343,6 +343,7 @@ struct uart_amba_port {
 };
 
 static unsigned int pl011_tx_empty(struct uart_port *port);
+static void pl011_rs485_tx_stop(struct uart_amba_port *uap);
 
 static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
 					unsigned int reg)
@@ -874,6 +875,11 @@ __acquires(&uap->port.lock)
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
 	}
+
+	/* Without PIO the TX path won't run again, end an RS485 transmission */
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    uap->rs485_tx_state == SEND && !(uap->im & UART011_TXIM))
+		pl011_rs485_tx_stop(uap);
 }
 
 static void pl011_dma_rx_callback(void *data);

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-devel-nbuchwitz-pl011-rs485-dma-flush-5f69eafe5b6d

Best regards,
--
Nicolai Buchwitz <nb@tipi-net.de>
-- 
Nicolai Buchwitz <nb@tipi-net.de>

