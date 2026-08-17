Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3A21D3F5
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969489; cv=none; b=Fzx4xb1q0q0nWdHpR+LlUR1PY3iB9eWiHm160YRQ2LcuQPjsEQIg8eAWyzq8RIMBp4iEk8LIxeekOXYWI/IC7MHn5XOedqQcGbNpBlQGJGD5qsUI8attBrBGuNB+zDPcKYI6gmxz73wbfukvrKWmPKBheEBuODI6eYpX5MvGgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969489; c=relaxed/simple;
	bh=edumdP7c/zivR7D9RhkRyla8qJg+FbP+gLk0iSEhIZA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ibf4mEWJj3yNl+LkMd/Nt2qsNSUbvEQIvFRAPVTEsM8QwqezNXAhDLESBO94uh84kL40uvYogzpuz7yRsntSoZ2RhPxh9TZrWX1kTJqn/IA2UNZ4ippy+DdPPIy+s56T9RClL5W+r9zDCs8FyZTiYxhi1z33PukfVE0hHLeCIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hc9+xFyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hc9+xFyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7001F000E9;
	Mon, 17 Aug 2026 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969487;
	bh=b7k2X3Td8DJapdXzcsXnPFDfOuuN00gDvfGgn9vYPkY=;
	h=Subject:To:Cc:From:Date;
	b=hc9+xFylq6oaSvobV836QBuU88+CInLAUxlkBH8g1HZO52oZPQOiOrZMKpI0MA4zH
	 hrOfj8A96uE6/vO6JE+ggbDtesKcbqYkfU7HM6NPOCqplH8DD+MKH1YUHnvy862Sdc
	 TBs9wAvlq2MqzXLFR+omVTfZwFNWCwQgCbWtq2R0=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix TX DMA buffer flush" failed to apply to 6.6-stable tree
To: linux@jaseg.de,gregkh@linuxfoundation.org,praveen.talari@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:24:43 +0200
Message-ID: <2026081743-aghast-resisting-a8ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x e3c04834ae1ab5e9cfbe8ac54ec734aa4774249d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081743-aghast-resisting-a8ca@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e3c04834ae1ab5e9cfbe8ac54ec734aa4774249d Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
Date: Wed, 29 Jul 2026 19:41:05 +0200
Subject: [PATCH] serial: qcom-geni: fix TX DMA buffer flush
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When transmit flushing a qcom-geni UART during an ongoing TX DMA, the
UART gets stuck infinitely repeating corrupted TX DMA frames.

The DMA-mode uart_ops does not provide a flush_buffer callback, so an
in-flight transfer can complete after serial core has reset the transmit
kfifo, underflowing its length and resubmitting page-sized transfers
indefinitely. Add one that stops the transfer and clears tx_remaining
and tx_queued.

The stop path was also broken: it unmapped the buffer while the serial
engine could still read it, and never reset the TX DMA state machine.
Cancel the main sequencer command first, then reset the state machine
and wait for it before unmapping. Drop the early return so a pending
mapping is also cleaned up when the main command is inactive.

The bug can be triggered from userspace with a large write immediately
followed by TCOFLUSH. A following tcdrain will hang forever. The bug was
reproduced and this fix was validated on Arduino Uno Q (QRB2210)
using /dev/ttyHS1.

Assisted-by: Claude:claude-5-opus Codex:gpt-5
Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: stable <stable@kernel.org>
Reviewed-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
Link: https://patch.msgid.link/20260729174105.21838-2-git@jaseg.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..1e39122ec09f 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -158,6 +158,7 @@ static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
 
+static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport);
 static void __qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
 static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
 static int qcom_geni_serial_port_setup(struct uart_port *uport);
@@ -636,35 +637,34 @@ static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
 	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
 }
 
+static void qcom_geni_serial_flush_buffer_dma(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	qcom_geni_serial_stop_tx_dma(uport);
+	port->tx_remaining = 0;
+	port->tx_queued = 0;
+}
+
 static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	bool done;
 
-	if (!qcom_geni_serial_main_active(uport))
-		return;
+	if (qcom_geni_serial_main_active(uport))
+		__qcom_geni_serial_cancel_tx_cmd(uport);
 
 	if (port->tx_dma_addr) {
+		writel(1, uport->membase + SE_DMA_TX_FSM_RST);
+		if (!qcom_geni_serial_poll_bit(uport, SE_DMA_TX_IRQ_STAT,
+					       TX_RESET_DONE, true))
+			dev_err_ratelimited(uport->dev, "TX DMA reset failed");
+		writel(TX_RESET_DONE | TX_DMA_DONE,
+		       uport->membase + SE_DMA_TX_IRQ_CLR);
+
 		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
 				      port->tx_remaining);
 		port->tx_dma_addr = 0;
-		port->tx_remaining = 0;
 	}
-
-	geni_se_cancel_m_cmd(&port->se);
-
-	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-					 M_CMD_CANCEL_EN, true);
-	if (!done) {
-		geni_se_abort_m_cmd(&port->se);
-		done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-						 M_CMD_ABORT_EN, true);
-		if (!done)
-			dev_err_ratelimited(uport->dev, "M_CMD_ABORT_EN not set");
-		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
-	}
-
-	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
 static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
@@ -1180,7 +1180,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 	uart_port_unlock_irq(uport);
 }
 
-static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
+static void qcom_geni_serial_flush_buffer_fifo(struct uart_port *uport)
 {
 	qcom_geni_serial_cancel_tx_cmd(uport);
 }
@@ -1769,7 +1769,7 @@ static const struct uart_ops qcom_geni_console_pops = {
 	.request_port = qcom_geni_serial_request_port,
 	.config_port = qcom_geni_serial_config_port,
 	.shutdown = qcom_geni_serial_shutdown,
-	.flush_buffer = qcom_geni_serial_flush_buffer,
+	.flush_buffer = qcom_geni_serial_flush_buffer_fifo,
 	.type = qcom_geni_serial_get_type,
 	.set_mctrl = qcom_geni_serial_set_mctrl,
 	.get_mctrl = qcom_geni_serial_get_mctrl,
@@ -1792,6 +1792,7 @@ static const struct uart_ops qcom_geni_uart_pops = {
 	.request_port = qcom_geni_serial_request_port,
 	.config_port = qcom_geni_serial_config_port,
 	.shutdown = qcom_geni_serial_shutdown,
+	.flush_buffer = qcom_geni_serial_flush_buffer_dma,
 	.type = qcom_geni_serial_get_type,
 	.set_mctrl = qcom_geni_serial_set_mctrl,
 	.get_mctrl = qcom_geni_serial_get_mctrl,

