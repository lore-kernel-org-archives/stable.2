Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583917;
	b=l9CbFA4ijf0H8vnu36RS3mitWyDJiRtWkbIAM9Rp7XVYHJSdAyPERm3Sbk3meiJTAcWr
	 J2hQIcLyyf5XmtMIrHLaZikEiOHc2DsRtCt4zkpecUU6eqAvScd3h5ceKzPhmNTbYieCn
	 ExVvAlHUP8f4ddQ2UsfelxWBzFsVUaRADKoewELN25X/JTBuDXAvttrakh1QDFtxMJuyM
	 1W/CFFp1fTNWCxF6Do6IHxkfX6YaqINF0ZfRsOYMq81luVUf5nEL5FXrQupvNaADsFwuD
	 +L28+SlJnR1gN8geos/f7XpKGv8QytJac8oJ1ek2GUgY1JDqD7gWjzEsaq/RlL/yLGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583917;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=p6U4UvH3Pw4D20nHXDtydVw0XH+yfLxZFNV1xTzs5Vg=;
	b=BKHfrqzKcilVp/CayqJHfIMgLLpzccT0EJgm8q7G3ccXIZJ3vQxkALK7SDPsG5dZ3UjX
	 YygShF3GzMaSMfLtRU/YkIiBxU++mxFzxFRfp47mTEfw5z8RbURWyHVf0dU0en7TTxrKw
	 zkECWfgeYyhcqmmSzm10uParJUtiJgWHJNneYEELdxmoUSkPBW4oT9C5MLFHfGRPkEaqJ
	 Hso0QDCBeQc118vrCqgmi6L7MBmNfvzM9m+4NTk63iuo7YPR31czVl2N8K9jPgszdsgt+
	 jsz0pz/ah2LwXSpDfot8advGsWaIYiTZmbankQqg/UrYlXTiy7CralVrtUfm26ZRC8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=EBarJT3B;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0106606A31B;
	Wed, 21 Oct 2026 11:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0106606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=EBarJT3B
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09B0DA039E;
	Wed, 21 Oct 2026 13:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792583913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=p6U4UvH3Pw4D20nHXDtydVw0XH+yfLxZFNV1xTzs5Vg=;
	b=EBarJT3B43MMcXoXnRmajip/ZQ/uSfaIEZtRKcxRisfJlCWAf922zhl9FQ76US5vhEdW8a
	W48X3/7QxDomjfO5r/zhGWp3fLpZlimeQA2zJmp5s4QYmHPxF8Y6gYEr1nqFXsoDzTlBse
	Umyv6/io/pvGoCUI3tePpk5mbQdMjc0+rleaTS24OFbb88nITfETCumksPF8Mdnu93icyx
	jMshxiMzyDIc2cOvozIu20QZjTN+kp16xEOGDZliRom39REBtSM1n6eCBnmg/1lgDQwKjm
	GfIXc22rlohX9xlqSWgx38cy+1+4tOiqVO/NOVAefODPfhewcIaQguhC2ZDHAA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Wed, 21 Oct 2026 13:58:28 +0200
Subject: [PATCH] serial: amba-pl011: end an RS485 transmission when TX is
 flushed
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
Message-Id: <20261021-devel-nbuchwitz-pl011-rs485-dma-flush-v1-1-65a78e1fe1b3@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNTQ7CIBBA4as0s3YSaISoVzEu+BlkDGIDpRqb3
 l3U5bd5b4VKhanCaVih0MKVH7lD7gZw0eQrIftuGMWopRglelooYbbNxSfPb5ySkBJL3R8U+rv
 BkFqNqII+kgmkrPbQW1OhwK/f53z5uzZ7Izd/47BtH055vh+JAAAA
X-Change-ID: 20261021-devel-nbuchwitz-pl011-rs485-dma-flush-5f69eafe5b6d
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

