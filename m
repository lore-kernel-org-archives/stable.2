Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF509376483
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237732; cv=none; b=seKd2WJ+vL84XwB0uCffObgsDCv1LmGUXIk2pnKakEwiL9dQ9gS/drXLzQDwJKYKW/WFEt8mO3ztUavmLP9DmMXUBRF1hxHJeWimphSfxCX3g7Q8586WpgS+Jy6zqqKj45ZCK2Rcy5yCISVOpWYKmLTSepPlP4kZtYu1slYAHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237732; c=relaxed/simple;
	bh=zVYxDRb6NsEQEnfFti6BBh5FdF10/juErdJe2cvUI3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi2zYDek5urtIOpnorfq+ldhljy9DHwOSRKbVgzITiCUHUluecAGVWbCrMLbdd4hwyH9FKlsIl58NBo7G+tda/l4zXqGidyEerdwDUT++dthmSG2FbXwhnMjvJAiaBZkdOp5RaBYme84hU3JeqDTg4RRoPmmzvcl1fYcN6AAvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXMaMBCp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXMaMBCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2618F1F000E9;
	Thu, 20 Aug 2026 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787237730;
	bh=vIA7clHDxkjjGdc0HGDyshyGktxpNUCzZdcOGAB3+ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXMaMBCpd1VcacpoOVhbxUY64LIkC+ANrgp2ZklQeLSvL1pfAabpLf9KKp0Ib+gDh
	 O5oWlkDR5RWcVw5iOayE5vB03x8IAR1HKx474JFWysIl2/qTOOE6KNjJTZcgeJpeKD
	 d4k7apncZpWMp2Lz0OBxolNb1EMKTWI8ObcdXzFYv6GJAkp4vUIz/6hu9Qydc+dnXi
	 u0UtrFpFAlWvWLkWuwfntqqmXTvqFSPiNJ0d2wS7b5dP024ii1gDL8rEhI2OO6a2wC
	 AkQ62/RpY+UmRG3gFVhD0gFmzBby+4/hxslSTC8YjDuz5Ij90NspaY6/EX7wOk7mPY
	 CMw0m6Q1z78Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryan Wilbur <rwilbur633@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx
Date: Thu, 20 Aug 2026 10:55:28 -0400
Message-ID: <20260820145528.1944201-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081705-tug-surrender-1607@gregkh>
References: <2026081705-tug-surrender-1607@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Wilbur <rwilbur633@gmail.com>

[ Upstream commit 1423415471274abda87024967d7fe2206ceee0ea ]

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

Cc: stable <stable@kernel.org>
Assisted-by: Claude:Opus4.8
Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
Link: https://patch.msgid.link/20260730193920.28954-1-rwilbur633@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_of.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index e14f47ef11725..04a0d51dd9195 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -80,6 +80,44 @@ static int of_platform_serial_clk_notifier_cb(struct notifier_block *nb, unsigne
 	return NOTIFY_DONE;
 }
 
+static int lpc32xx_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+	unsigned int iir;
+	u16 status;
+	int ret;
+
+	serial8250_rpm_get(up);
+
+	iir = serial_port_in(port, UART_IIR);
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
+		uart_port_lock_irqsave(port, &flags);
+
+		status = serial_lsr_in(up);
+		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+			serial_port_in(port, UART_RX);
+
+		uart_port_unlock_irqrestore(port, flags);
+	}
+
+	ret = serial8250_handle_irq(port, iir);
+
+	serial8250_rpm_put(up);
+
+	return ret;
+}
+
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -163,6 +201,9 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	case PORT_NPCM:
 		ret = npcm_setup(port);
 		break;
+	case PORT_LPC3220:
+		port->handle_irq = lpc32xx_handle_irq;
+		break;
 	default:
 		/* Nothing to do */
 		ret = 0;
-- 
2.53.0

