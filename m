Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410017;
	b=z9U4RkH0Vp3LOeOX4W2vbAMk8WKrxIwdrXIqL9hcNLQbrPuNgJvu1WywhpBQ8cw43bop
	 HOOgViAzNUda4Mpp9s1Ph/gcngtnwr9K00lZAmdjRigHHsR44wTFhpvSJ/5nBrvBCdPBQ
	 FEo3BQzWstI0u++HUAevhQ5Iyilc+S/rhw9AlYalkBtpLnMWJ3T+Dz9tBJTbV1FHr8zyy
	 ZWyC8DMsQ12iIlMZRPhX8zH4FzETg9DW8VWTMuXbZKSQi8nhErYy35rpu+j41I/56RitI
	 EAKFvU6mfrDmBANRe8CuWHWKWj6fPLlJDNSFLmxzEGJRMBS6cHOF415dhEeo+1zMyDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qwnmLYHgLBxCICKlViwlh1x9DELtdsvLO3tg8KyCJKM=;
	b=RBOmr6nbA5QR7HdvqgnIDwSIaJrFZIN0th1CetceZFuBPytJ/wGvq5xVDDpucuh8muqv
	 0Sm1VbWuHY1yEB3zLqy96Zdk+YyZZY4V6nS07/YD5Ben3B9lq041MhLTr45OEKJx2QntY
	 7rjekSKpvJNVrU5Lz0diYCyZonHpteJ0vxTDRreAbwVVPRtwelhRLKQuJ3k3Uv0otcUOi
	 be4o4+e6KV5oMwmRbc405g7zcxaVACg/20jbHhgX0GDjrEM+l0OSrGK+qnhtXACumNcKt
	 y/NrisdC/nmMr2UTDjGwUYvJNmg+idtNX8/EQKU+fwX+gR5v4dYQ/GV9uPo4K2SG2Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaBdkJ+9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C90606A886
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaBdkJ+9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB74C1F00A0E;
	Wed, 11 Nov 2026 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410017;
	bh=qwnmLYHgLBxCICKlViwlh1x9DELtdsvLO3tg8KyCJKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EaBdkJ+9RK3bXcXVr+zYSKi+wO9W6YuQ9eMnbJ3Cii5QXpPTHTC1HrhOIfTzqJSeb
	 P7zPqMtHzYTrFCgTMjAnOrG4ByD47qMuvoPUDf0H+42ul8rbOivv96w5QLlWnj1sWd
	 645GFw/VOgCA66vyDO0LMGR6rbYCODaIyCCoVort+q1n2zKalmkqkdhLKSStNi3dHj
	 9AwyMlu+p4aXKciGGDwSmcG7nEHclTBVGOd7v7t5kmw2X7Cfjv+GlXkdJB2Me/klle
	 5YeWg39PSM3TPdq6Ykdgd3C+essyCeWaEbma5MNscfAN4UMCy6sAqbOnJE5+FHVXcx
	 fF4RGu1+Nvu3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] serial: amba-pl011: keep transmitter enabled when disabling RS485
Date: Wed, 11 Nov 2026 10:13:34 -0500
Message-ID: <20261111151313.2472393-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111151313.2472393-1-sashal@kernel.org>
References: <20261107060610-failed-5.15-97f85204275a@kernel.org>
 <20261111151313.2472393-1-sashal@kernel.org>
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

From: Nicolai Buchwitz <nb@tipi-net.de>

[ Upstream commit 97f85204275ae4d7fb530e451f3acc65c1ec1155 ]

Disabling RS485 on an open port calls pl011_rs485_tx_stop(), which
turns off the transmitter. Only the RS485 TX path turns it back on, so
any later output stays queued and tcdrain() hangs until the port is
closed.

pl011_rs485_tx_stop() also checks only the hardware FIFO. If a DMA
transfer has started but has not filled the FIFO yet, the transmitter
is turned off under the transfer and the DMA channel never recovers.

When leaving RS485 mode, cancel pending deferred starts and stops, leave
the transmitter enabled and start any TX that was still waiting for
delay_rts_before_send.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Cc: stable@kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20261012-fix-pl011-rs485-txe-v2-1-e9bf7d218389@tipi-net.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Adapted RS485 handling to the existing rs485_tx_started boolean and synchronous delays, omitting unavailable timer and deferred-start logic. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7b21907cd14dd..3f74b96e7745c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2241,8 +2241,22 @@ static int pl011_rs485_config(struct uart_port *port,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(rs485->flags & SER_RS485_ENABLED)) {
+		u32 cr = pl011_read(uap, REG_CR);
+
+		/*
+		 * Leaving RS485 mode, which only enables the transmitter while
+		 * sending. Don't stop it, as that stalls a DMA transfer still
+		 * in flight. Keep it enabled.
+		 */
+		uap->rs485_tx_started = false;
+
+		cr |= UART011_CR_TXE | UART011_CR_RXE;
+		pl011_write(cr, uap, REG_CR);
+	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
+	}
 
 	/* Make sure auto RTS is disabled */
 	if (rs485->flags & SER_RS485_ENABLED) {
-- 
2.53.0

