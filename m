Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7D3A383C
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570445; cv=none; b=SW81YRUMJQAROYk/VGpw/g3XHY0eFkql26xZTej48po5ku0BgGJZlZoNbtSbdO8T9/imIwZpxA70JwWZYKg7D0DqgUhYQTLQv5ur0QRt54lx1QimZibsBOZnjjGgkCHUMbTDuadGiDaX4E4qsQbDzA9SSDBDAkS52LqXVE/S1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570445; c=relaxed/simple;
	bh=6NJelmOHvK74tRlLh8aE0CzzuC4Pv0g9599Yqud2kJw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cFbJijKcPC24Z5zQO7AMWCvzgU0VIuq9wc+CcKs0E1joehbHHyCK6TPSRIcoJ5XQbAxesiP9Ica0hc3RS1XcbkJv8uRPmBy5wNeN7ALRexLSfgVopUhJvYBo84pYMWVEFFneY1iAe6B+3/2CE9FGLpOyq5Jnr9m1ZF76cT2ntG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KK3fyRNZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KK3fyRNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013D31F00893;
	Thu,  4 Jun 2026 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570444;
	bh=IjAMNaFE20oA+LrVeIT6R10FaOpTxbczEqm4Oj2QVeU=;
	h=Subject:To:Cc:From:Date;
	b=KK3fyRNZgMXlHasGtHH7APj4TRMv8ehxENuRsXDcvJLZpSgtcv4PWk2qZ7Cj8LWV+
	 HwdWVkXCrLK66Zt/dIA3XAbN1X0Yd8Ch04PZY7y7QLwLb3wg6uYjQw84oclBQI4bVj
	 SsmxK645Lx2/4Cc/li1WNHwbhPBzE9HECTjWnar4=
Subject: FAILED: patch "[PATCH] serial: qcom_geni: fix kfifo underflow when flush precedes" failed to apply to 6.6-stable tree
To: viken.dadhaniya@oss.qualcomm.com,bartosz.golaszewski@oss.qualcomm.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:53:04 +0200
Message-ID: <2026060404-computing-retiree-825a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 452d6fa37ae9b021f4f6d397dbae077f7296f6f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060404-computing-retiree-825a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 452d6fa37ae9b021f4f6d397dbae077f7296f6f4 Mon Sep 17 00:00:00 2001
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 6 May 2026 10:15:21 +0530
Subject: [PATCH] serial: qcom_geni: fix kfifo underflow when flush precedes
 DMA completion IRQ

When uart_flush_buffer() runs before the DMA completion IRQ is delivered,
the following race can occur (all steps serialized by uart_port_lock):

  1. DMA starts: tx_remaining = N, kfifo contains N bytes
  2. DMA completes in hardware; IRQ is pending but not yet delivered
  3. uart_flush_buffer() acquires the port lock and calls kfifo_reset(),
     making kfifo_len() = 0 while tx_remaining remains N
  4. uart_flush_buffer() releases the port lock
  5. DMA IRQ fires; handle_tx_dma() acquires the port lock and calls
     uart_xmit_advance(uport, tx_remaining) on an empty kfifo

uart_xmit_advance() increments kfifo->out by tx_remaining. Since
kfifo_reset() already set both in and out to 0, out wraps past in,
causing kfifo_len() to return UART_XMIT_SIZE - tx_remaining. The next
start_tx_dma() call then submits a DMA transfer of stale buffer data.

Fix this by snapshotting kfifo_len() at the start of handle_tx_dma()
and skipping uart_xmit_advance() when fifo_len < tx_remaining, which
indicates the kfifo was reset by a preceding flush.

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: stable <stable@kernel.org>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260506-serial-dma-stale-tx-buf-v1-1-e3ccb360d719@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 5139a9d21b2b..17da115b1e78 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1031,8 +1031,20 @@ static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct tty_port *tport = &uport->state->port;
+	unsigned int fifo_len = kfifo_len(&tport->xmit_fifo);
+
+	/*
+	 * Only advance the kfifo if it still contains the bytes that were
+	 * transferred. uart_flush_buffer() may have run before this IRQ
+	 * fired: it calls kfifo_reset() under the port lock, making
+	 * fifo_len = 0 while tx_remaining remains non-zero. Calling
+	 * uart_xmit_advance() in that case would underflow kfifo->out past
+	 * kfifo->in, making kfifo_len() wrap to UART_XMIT_SIZE - tx_remaining
+	 * and triggering a spurious large DMA transfer of stale data.
+	 */
+	if (fifo_len >= port->tx_remaining)
+		uart_xmit_advance(uport, port->tx_remaining);
 
-	uart_xmit_advance(uport, port->tx_remaining);
 	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
 	port->tx_dma_addr = 0;
 	port->tx_remaining = 0;

