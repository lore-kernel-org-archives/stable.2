Received: from mf01.lie.net (mf01.lie.net [212.77.32.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B850483BCB;
	Thu,  1 Oct 2026 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.32.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790835679; cv=none; b=Zv4jTILs2pDYdmq5puKF1X7lyOYpKkzRA7XW/K2Wf0mqRNUe9R88Dk6lp60yIzpeOCY1gUK12B3A9PhfdUNq1a9k4AdQXLyK6sdK+BOkZ3gmqI1CTrQnUzCFhVJe4lBvv1rVB4KvR5ccM3ugzb76Ur50QH9ScNV6gE/+j/8yxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790835679; c=relaxed/simple;
	bh=YAlgLuw26GFR9op9Uq5uvNMngkMw6KWKsd3NTl5ZtiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ieae11/63Q7ylTzsdMuvJqTkMb5fr5PfnS9GuB0cMtjWW8JguoXTC2QYXkKeQZisSswZgYsTyMpzk5xZM0xXfXfZ1UL/NcM+3OAqUqYlTCnFQ2M70M/rI9FlmHgFXCt47LSf4K9hNIee+CvheauS6dwQw0jlw5IjxXOROt0Wd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noxsystems.com; spf=pass smtp.mailfrom=noxsystems.com; arc=none smtp.client-ip=212.77.32.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noxsystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noxsystems.com
Authentication-Results: mf01.lie.net;
	spf=pass (lie.net: domain of simon.gassner@noxsystems.com designates 212.77.58.239 as permitted sender) smtp.mailfrom=simon.gassner@noxsystems.com;
Received: from securemail.noxsystems.com (mail.noxsystems.com [212.77.58.239])
	by mf01.lie.net  with ESMTPS id 69165j41020147-69165j43020147
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 08:05:45 +0200
Received: from securemail (localhost [127.0.0.1])
	by securemail.noxsystems.com (Postfix) with SMTP id 4hwLxj4cyVz2WX5;
	Thu, 01 Oct 2026 08:05:45 +0200 (CEST)
Received: from SRV2.NOX.intern (unknown [10.10.11.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.noxsystems.com (Postfix) with ESMTPS;
	Thu, 01 Oct 2026 08:05:45 +0200 (CEST)
Received: from SRV2.NOX.intern (10.10.11.200) by SRV2.NOX.intern
 (10.10.11.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:05:45 +0200
Received: from NOXSIMON.NOX.intern (10.10.11.80) by SRV2.NOX.intern
 (10.10.11.200) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 08:05:45 +0200
From: Simon Gassner <simon.gassner@noxsystems.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<thierry.reding@kernel.org>
CC: <ldewangan@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <simon.gassner@noxsystems.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] serial: tegra: don't clear the Tx FIFO on an Rx-only reset
Date: Thu, 1 Oct 2026 08:05:39 +0200
Message-ID: <20261001060539.32659-1-simon.gassner@noxsystems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SM-outgoing: yes
X-FEAS-SPF: spf-result=pass, ip=212.77.58.239, helo=securemail.noxsystems.com, mailFrom=simon.gassner@noxsystems.com
X-FEAS-Client-IP: 212.77.58.239
X-FE-Last-Public-Client-IP: 212.77.58.239
X-FE-Policy-ID: 12:4:3:noxsystems.com

tegra_uart_fifo_reset() applies the Tegra30 workaround for
"cannot clear the Tx FIFO while FIFO mode is enabled"
unconditionally: it leaves FIFO mode, writes the requested FCR
clear bits, and re-enters FIFO mode. Leaving FIFO mode empties
both FIFOs, so an Rx-only reset discards queued Tx data as well.

The break handler in tegra_uart_decode_rx_error() calls it with
UART_FCR_CLEAR_RCVR only. On a half-duplex RS485 board whose Rx
line is pulled low while the transceiver drives the bus, every
transmission raises a spurious break, and all but the first
character of the frame is lost.

Only take the FIFO-mode path when the caller actually asked for
CLEAR_XMIT. Likewise only wait for TEMT in that case: with the Tx
FIFO deliberately left intact, that loop would otherwise spin for
a full frame time in hard IRQ context with the port lock held.

Tested on a Colibri T30 (Tegra30) with Rx DMA:

 - Break during transmission: the reset still fires from
   tegra_uart_decode_rx_error(), and the complete frame now
   reaches the peer. Before this change only the character in
   the shift register was sent.
 - Internal loopback with a generated break: the Rx FIFO is
   correctly cleared by the plain FCR write, and subsequent
   receive works with no frame, parity or overrun errors.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Cc: stable@vger.kernel.org
Signed-off-by: Simon Gassner <simon.gassner@noxsystems.com>
---
 drivers/tty/serial/serial-tegra.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 8004fc00fb9c..b0fc4ae3686f 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -306,11 +306,19 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 {
 	unsigned long fcr = tup->fcr_shadow;
 	unsigned int lsr, tmout = 10000;
+	bool clear_tx = !!(fcr_bits & UART_FCR_CLEAR_XMIT);
 
 	if (tup->rts_active)
 		set_rts(tup, false);
 
-	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
+	/*
+	 * Leaving FIFO mode below is a workaround for a Tegra30
+	 * restriction on clearing the Tx FIFO while FIFO mode is
+	 * enabled. It empties both FIFOs, so applying it to an
+	 * Rx-only reset would destroy an in-flight transmission.
+	 * Only take that path when the caller asked for CLEAR_XMIT.
+	 */
+	if (tup->cdata->allow_txfifo_reset_fifo_mode || !clear_tx) {
 		fcr |= fcr_bits & (UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 		tegra_uart_write(tup, fcr, UART_FCR);
 	} else {
@@ -335,9 +343,15 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 	 */
 	tegra_uart_wait_cycle_time(tup, 32);
 
+	/*
+	 * Only wait for the transmitter to drain when the Tx FIFO was
+	 * part of the reset. For an Rx-only reset it is left intact,
+	 * and waiting for TEMT here would spin for a full frame time.
+	 */
 	do {
 		lsr = tegra_uart_read(tup, UART_LSR);
-		if ((lsr & UART_LSR_TEMT) && !(lsr & UART_LSR_DR))
+		if ((!clear_tx || (lsr & UART_LSR_TEMT)) &&
+		    !(lsr & UART_LSR_DR))
 			break;
 		udelay(1);
 	} while (--tmout);
-- 
2.43.0

