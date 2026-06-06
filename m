Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC823A7F6E
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750188; cv=none; b=CJEh3haiU9HFX272wKmmY2S15m4tqubazbSWVqvdF8xfz+IU/yAlBxdtPWIQIlUSHpiXCM+np9v3pUFkwfmo/teEKw8BWnhlW9aOBkkTNrUbYZNVqld8BgPaiv1B5rDdyp3TLNVeo6rv5W8D+Ql+mnHF+y4tI0UfPgmSdJWrGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750188; c=relaxed/simple;
	bh=WSLV6T0vfkTOT5AuaOpgd4wlhccag4QhNwYOk2qVc7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tevyvAw8EOndRRlaAIPHvoKHJZpxOmTLxqnNHICNJvDrLdTmdLvmemAJokMAy4Xj/g1ykfOX1Ixl8ZZTEBtSEzLyca3z4tH4jZFtwnu8TUzvh5b0IzOZoZ13IZ0VU0EHnBxgbGmiHiY6UcRrUdohJ2XdHSLSACt+AxQrPAKGRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXsClxvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXsClxvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B191F00893;
	Sat,  6 Jun 2026 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780750186;
	bh=8BFFK7HAcwK01ndEzF455iIQwsugwfH4L4WoumA+C9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXsClxvzIxqfE3QeHpOtyj9a9yrVk4XMYJVCMJyLNCJbvOh+74y1s+1+SSyfQepWH
	 /6ifC2uUZA57wgjTPNFiZn/4vWi8MiLrKZo6AOlq5MDu2+4gpxA0JTc2hLXLw1ESwA
	 WAIZV8l2V9RON585K+phBe8twNnmwVEohsrZE7hqodrmUoiULFLIxxSdgL/rNi9Mdo
	 u+/RLkuKdv/uTIyT9vzdLdhZjmqhRyqzINPcL4kX5qITl0LHjOMKZ24coUgZyqwSAC
	 X1Hne8BYbSYlBaRPozY7II+AlPg3ifFYaPYozFxyl8dJAOh7k1SWmhNVfaIX+GmN27
	 oxIaGlClwdvhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] serial: qcom_geni: fix kfifo underflow when flush precedes DMA completion IRQ
Date: Sat,  6 Jun 2026 08:49:44 -0400
Message-ID: <20260606124944.2878832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060404-computing-retiree-825a@gregkh>
References: <2026060404-computing-retiree-825a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

[ Upstream commit 452d6fa37ae9b021f4f6d397dbae077f7296f6f4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f820a09cb5c39b..b97faf0c804bfd 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -962,8 +962,21 @@ static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
+	unsigned int chars_pending = uart_circ_chars_pending(xmit);
+
+	/*
+	 * Only advance the buffer if it still contains the bytes that were
+	 * transferred. uart_flush_buffer() may have run before this IRQ
+	 * fired: it clears the circular buffer under the port lock, making
+	 * chars_pending = 0 while tx_remaining remains non-zero. Calling
+	 * uart_xmit_advance() in that case would advance xmit->tail past
+	 * xmit->head, making uart_circ_chars_pending() wrap to
+	 * UART_XMIT_SIZE - tx_remaining and triggering a spurious large DMA
+	 * transfer of stale data.
+	 */
+	if (chars_pending >= port->tx_remaining)
+		uart_xmit_advance(uport, port->tx_remaining);
 
-	uart_xmit_advance(uport, port->tx_remaining);
 	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
 	port->tx_dma_addr = 0;
 	port->tx_remaining = 0;
-- 
2.53.0

