Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047706;
	b=oUCztefE/g1hUYdbHNiI6s7RZik1uz1afUzmSqJgFMMWce24qgI0s3EI8+jgJGhHfILj
	 eASFoUHY9GZD+GbRy9SErovH7y7z17alJn4cNcAoWvUXe+6bCmEMKcRWRnd4dfyKovqMN
	 urKApzIwy5JKP0/QLFyHDX6UQYOtuoW/zwVAI95qUX0EbR1hMNM1LijGEMUEf3aFZhEfe
	 e8qlH1xPviFIEVoFBYO5XYahPLIAdygLf/rvkNymylstOmr7/hIQU9+FZli3C3aNHJZvr
	 mz0TRYgipf/d+ngqgUQsTozqWOoaPYdnB8xNQnXM9eikXCrnT6idqE/YTV1X/QmhgrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047706;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GDmqHNtefCzJ7WG42aB8vznvLfBk3q0E/7td99UtKfk=;
	b=e/pud4GXp4DuVabT/lC6XmSgiKkz+P++ORU/K4hTQ8bJObxcuaBqfluNy1MQZ0ttJA5U
	 K4QS0ac1C/4iXbhMmWiv/wMBff615X3urMULlfno96WF7SHqY90kWmnuRtsKlkqN1E58D
	 KcSJWn2fibR5LWTMY82LS4K5SDhUSqnGrZ84I9KIXgxcQVHRQJYilQ7+y4xHiKf43xzAC
	 0nEJn+LqlZaOYjWM7GX0DHvuAQON6lWJKxaztI8QNzNCjNjuk5n/TPbNAp+6iyoQh/1WH
	 RilGL5Y6ZMeXYsPQ0C4F9tFDw5zKsOBZ92k7l0ugC/WFTC1xVYg7xlyc2WFdCI3KNvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6bS1PNN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66801606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6bS1PNN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BD01F0089F;
	Sat,  7 Nov 2026 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047706;
	bh=GDmqHNtefCzJ7WG42aB8vznvLfBk3q0E/7td99UtKfk=;
	h=From:To:Cc:Subject:Date;
	b=l6bS1PNNe9cbKLCPthyurqIygD8FlmLcDSKLJGIEBLdSzwMRZJ7DymmmURmf3EklR
	 l6iBXlAw1QmPQxsuZsGK9P9GFgoL7HRGRbe6LcBKfbxP5t26gvY65BzqnFAGEYlUtb
	 K1FovIH8+hWZc4kstxnhbdhi77aNt8FmBjo8beWfFuR9QLqb4cTsU1p3eYHmQET30a
	 H5U4c1n1n+dMFIoR1CnZ1fSPffotk3qGN1hT7FqNbE0VJgtIe7cakjZoldmoY9UjKj
	 bJGuDHXQZnidcJ/oLc0IHovSgKKg+pYLemjQg+WGhYSCWiU0BHthUtVvxmHi+kN9In
	 QOWaM8azn38fg==
From: Sasha Levin <sashal@kernel.org>
To: nb@tipi-net.de,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: amba-pl011: keep transmitter enabled when disabling RS485" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:04 -0500
Message-ID: <20261107053504-failed-6.6-97f85204275a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 97f85204275ae4d7fb530e451f3acc65c1ec1155
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053504-failed-6.6-97f85204275a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 97f85204275ae4d7fb530e451f3acc65c1ec1155 Mon Sep 17 00:00:00 2001
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 12 Oct 2026 16:23:50 +0200
Subject: [PATCH] serial: amba-pl011: keep transmitter enabled when disabling
 RS485

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
---
 drivers/tty/serial/amba-pl011.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cd8cbc9672815..3edd83ec73de1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2398,8 +2398,31 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(rs485->flags & SER_RS485_ENABLED)) {
+		bool tx_pending = uap->rs485_tx_state == WAIT_AFTER_RTS;
+		u32 cr = pl011_read(uap, REG_CR);
+
+		/*
+		 * Leaving RS485 mode, which only enables the transmitter while
+		 * sending. Don't stop it, as that stalls a DMA transfer still
+		 * in flight. Drop pending deferred starts and stops and keep
+		 * it enabled.
+		 */
+		hrtimer_try_to_cancel(&uap->trigger_start_tx);
+		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
+		uap->rs485_tx_state = OFF;
+
+		cr |= UART011_CR_TXE | UART011_CR_RXE;
+		pl011_write(cr, uap, REG_CR);
+
+		/* Start TX that was still waiting for delay_rts_before_send */
+		if (tx_pending && !uart_tx_stopped(port) &&
+		    !pl011_dma_tx_start(uap))
+			pl011_start_tx_pio(uap);
+	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
+	}
 
 	/* Make sure auto RTS is disabled */
 	if (rs485->flags & SER_RS485_ENABLED) {
-- 
2.53.0




