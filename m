Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792703435;
	b=iZQehDYBdbQ589GgLmQbzO3dcT95gslyQJq9KxjrKXZQ4prLIZqxUVJFuu5tstD3rxQd
	 DEDuJglZvoCDYh6DCFcFIgJgTSW8h+ZyYq72KEqAv25FqZ6MMDTL0mVBsMWtMigpjnr97
	 0JuHRnPJyIJ25AfWueNWYWSwiQfU0MD05l7X3f10NQdAwVa+ZFegEvsoB4IgPgP/icRbR
	 xmrjfTRvwLRza9zZ9ilrbcOCCDsPxalDt+SKQVEBDThYetxibCAyaFrN/P+OXJNKNy6ew
	 uFMNg6x+rOQyE0o+mJWHdd9HGJno7UErpf6QrgyLVPlpFhMs2r0rxc2UUnRYAXsY7GQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703435;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZaN1tc6d7nTMvvC2G9HGd0rGxtVw7AJhg3WsuDy0dRY=;
	b=0kpYUp7hgoca6Sa2uIl6E90zDx4DxQZIuPbBFgolM3FO75UCtAUoiS0wHD4PjVAncJlb
	 RBcqdziDVhtKQTH2uBXRnw7UYQe7p8RiZRzFtrT4/sCTBFumyPuVDoKBzJK6eyZUzaS+1
	 6xgN/U+mwuOxWabcfJPLRWEA9CRNlyH9vW2y1KRibEK8p9qoZQpyhwvleMxSE1ZVdZ+P1
	 j1i7Kxn6609H0Ae9EZ/HIM2eto3vRVOlF97sg1017Ev2fbLR0yyLR6AMeyPxzKxasKlR4
	 +xE/yBiXK4dw2t7+iZyWn4TiBjeNB9W9itCoMMnyfO0NK3j0VF/GK9IuL7Wmfc9TrOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY5pDrE4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BE606A31A;
	Thu, 22 Oct 2026 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY5pDrE4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792703435;
	b=pI0gkLOH2yonnCNaTD7c+3VCb7/3DG+ctsfdY+aTku9cTCP05+vg+Pxa+CyDDtF3QdzX
	 oyHo8mpGnRuUMYyZ08O4ZTH5sGpVSm6F/w2TcCTL9vKvFnaaaE+uTfrTC3+ggki7ehCJQ
	 EvdDf4DeqyY2TONBiTA6VidAOBWpwFFOLLB49LXXEwVt7rYkhWMXPEpn4/yh+dfykNqIp
	 fCyghqpRCR1QD5coQSXza9dPyFQlufyl+MHJl3rnwLYTn2puRUR6KhKsBq+HTkstHjXhh
	 MPP+kpDzAKEB4/d3uxd4k6kENXThiV0C3dBYDsJxnSPJgZvxD1Z7aMi8oZXCUNlwTTg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792703435;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZaN1tc6d7nTMvvC2G9HGd0rGxtVw7AJhg3WsuDy0dRY=;
	b=BRSK3tDLU1Jov/kYP4O6gbfOryDpPg7vItP+wk9UvKR2n6xoQFh2u7YKDhV4KrDSDiLy
	 gdhktXmnXD3WfENDlc9yarqZt1LOBJj45x2JMz0iYGhy/jPB9mfvsrnn7omNtcq99atuA
	 AqReDPW9GBbfxaPLLA4+Q4JGQjtEGbGqN7/eRI4aoFSlTF8G0KNELCG5i6B6NiDcRM89R
	 tv9g4Rmz64enAhV9KswK0q8rnExR9Ro/zdwo/H3kVkAAkKI0a+87Q16qsZQVcYq1154iP
	 Ac9hrgQEzyIC/mN7U15mSiK+ffnZFlXhTo6s59yxTw/mhpKo6ukGSR6xp01jidMQQHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BD0941F031E0;
	Thu, 22 Oct 2026 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703434;
	bh=ZaN1tc6d7nTMvvC2G9HGd0rGxtVw7AJhg3WsuDy0dRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IY5pDrE4lrOUECpAGs42zwlFDuYLv1nkxLmrk1NpcNvjofszD079s6jigt4L31gAB
	 VT0TYpfGGt42iGZMv7IUdPlNTMfIrlC0lhLcF5zfShIhPnHXQyEtNr3BW6mGHgN1Ga
	 cGWxy1I7QfAeQ5JNt3VmY41g91szi9s4WZbrefsON0dmleTV5F6+/IMxBmT04otbky
	 soHk/ZTBF522gps+I8gUONpasTf3R06vgWngwIHEpsVrFdfNyVZq9PhvCxrM0w0qZa
	 hf9zZa0qoFAJhWrneLSk8rCBsfA/wIL0cSBr59/CvM920eLwEa1YVAPttK6eyMhB7G
	 gzZevVWxN3D0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 35EE141F55;
	Thu, 22 Oct 2026 21:10:33 +0000 (UTC)
From: Austin Schlegel via B4 Relay <devnull+schlegelas.outlook.com@kernel.org>
Date: Thu, 22 Oct 2026 17:10:26 -0400
Subject: [PATCH v3 3/3] serial: tegra: ignore stale DMA completion
 callbacks
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
Message-Id: <20261022-serial-tegra-dma-uaf-v3-3-129f6d67f673@outlook.com>
References: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
In-Reply-To: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Alan Cox <alan@linux.intel.com>, 
 Stephen Warren <swarren@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Austin Schlegel <austin.schlegel@arthrex.com>, 
 Austin Schlegel <schlegelas@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792703432; l=5372;
 i=schlegelas@outlook.com; s=20261001; h=from:subject:message-id;
 bh=XIQgFR0YA9L/OYKz/mlqsFGtu4QcgWxRk6Z+7ffAujs=;
 b=wKx2KDmxE0HiCL165F6nbqu2ktPKd7UvBfshgOHxHmqBochQ3q8DFDXuQ0mPS5MV4U6AsBFtr
 RwaxyTKm4e4DSFlA+XBy6RM0rYILdQJ+BONGlPmJC9k9qvuWfT0HS2z
X-Developer-Key: i=schlegelas@outlook.com; a=ed25519;
 pk=ddgmH7VQaSWderjJFy4hDyq+P7hdHupPxQvwnGRBzCs=
X-Endpoint-Received: by B4 Relay for schlegelas@outlook.com/20261001 with
 auth_id=1098
X-Original-From: Austin Schlegel <schlegelas@outlook.com>
Reply-To: schlegelas@outlook.com
Content-Transfer-Encoding: 7bit

From: Austin Schlegel <schlegelas@outlook.com>

The TX and RX DMA completion callbacks run from the DMA engine's
tasklet. tegra_uart_stop_tx(), tegra_uart_flush_buffer() and
tegra_uart_terminate_rx_dma() can stop the same transfer under the port
lock, and dmaengine_terminate_all() does not wait for a callback that
is already running. A callback can therefore be waiting on the port
lock for a transfer that the driver has already stopped and accounted
for.

tegra_uart_tx_dma_complete() reads the DMA status and acks the
descriptor before it takes the port lock, then advances the xmit FIFO
by the whole transfer and starts the next one unconditionally. If
tegra_uart_stop_tx() got there first, the bytes it already accounted
for are advanced a second time, skipping data that was never sent.
After tegra_uart_flush_buffer() the FIFO is empty and the advance runs
past it. If a new transfer was started in between, the stale callback
reads the new transfer's cookie, acks its descriptor and clears
tx_in_progress while that transfer is still running.

tegra_uart_rx_dma_complete() has the same problem: after
tegra_uart_terminate_rx_dma() has pushed the received data and cleared
rx_dma_active, the callback pushes the whole buffer again and restarts
RX DMA, even if RX has been stopped.

Take the port lock before looking at the transfer in the TX callback,
and in both callbacks return early unless the transfer is still the
driver's current one: tx_in_progress is still TEGRA_UART_TX_DMA and the
cookie is complete for TX, rx_dma_active is still set for RX. The stop
paths clear these flags under the port lock, and a transfer started
after them is normally still in progress, so the existing
DMA_IN_PROGRESS check in the RX callback and the new DMA_COMPLETE check
in the TX callback skip it. If it has already completed, the stale
callback handles it, and its own callback then finds it is no longer
current.

Found by Sashiko automated review (see Link below). Not reproduced on
hardware. Tested together with the rest of the series on Tegra234
(Jetson AGX Orin) with a UART loopback test that also stops and flushes
TX while DMA is running: no KFENCE reports and no data mismatches in a
10-minute run with kfence.sample_interval=1.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-172211@kernel.org/
Assisted-by: LLM
Signed-off-by: Austin Schlegel <schlegelas@outlook.com>
---
v3:
 - New patch, addressing the Sashiko review of v2:
   https://sashiko.dev/#/patchset/20261014-serial-tegra-dma-uaf-v2-0-b142b31b67e3@outlook.com?part=1
---
 drivers/tty/serial/serial-tegra.c | 43 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index c179a09b8fe2..6e1a67d83e0e 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -532,16 +532,39 @@ static void tegra_uart_tx_dma_complete(void *args)
 	struct dma_tx_state state;
 	unsigned long flags;
 	unsigned int count;
+	enum dma_status status;
+
+	uart_port_lock_irqsave(&tup->uport, &flags);
+
+	/*
+	 * dmaengine_terminate_all() does not wait for a callback that is
+	 * already running. If tegra_uart_stop_tx() or
+	 * tegra_uart_flush_buffer() stopped this transfer while we were
+	 * waiting for the port lock, they have already handled it and
+	 * cleared tx_in_progress, so there is nothing left to do.
+	 */
+	if (tup->tx_in_progress != TEGRA_UART_TX_DMA)
+		goto out;
+
+	/*
+	 * A new transfer may have been started after this one was stopped.
+	 * Its cookie is normally still in progress, so leave it to its own
+	 * callback. If it has already completed, handling it here is fine:
+	 * its own callback will then find it is no longer current.
+	 */
+	status = dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
+	if (status != DMA_COMPLETE)
+		goto out;
 
-	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
 	count = tup->tx_bytes_requested - state.residue;
 	async_tx_ack(tup->tx_dma_desc);
-	uart_port_lock_irqsave(&tup->uport, &flags);
 	uart_xmit_advance(&tup->uport, count);
 	tup->tx_in_progress = 0;
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(&tup->uport);
 	tegra_uart_start_next_tx(tup);
+
+out:
 	uart_port_unlock_irqrestore(&tup->uport, flags);
 }
 
@@ -748,6 +771,22 @@ static void tegra_uart_rx_dma_complete(void *args)
 
 	uart_port_lock_irqsave(u, &flags);
 
+	/*
+	 * dmaengine_terminate_all() does not wait for a callback that is
+	 * already running. If tegra_uart_terminate_rx_dma() stopped this
+	 * transfer while we were waiting for the port lock, it has already
+	 * pushed the received data and cleared rx_dma_active, so there is
+	 * nothing left to do.
+	 */
+	if (!tup->rx_dma_active)
+		goto done;
+
+	/*
+	 * A new transfer may have been started after this one was stopped.
+	 * Its cookie is normally still in progress, so leave it to its own
+	 * callback. If it has already completed, handling it here is fine:
+	 * its own callback will then find it is no longer current.
+	 */
 	status = dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
 
 	if (status == DMA_IN_PROGRESS) {

-- 
2.53.0


