Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61438390231;
	Wed, 29 Jul 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346910; cv=none; b=b/N6T6HbK0opCUoeNJ9diTHR01t+ajRACuYyJIvW/SAQ5FjefLThKPEVXe24G6eqK62kW0i1B0ruX7DqpNVQfj3dejGR0ZlRNwLqJlB8A3u2ktG5TESRRRgYFD0/KClNDRhlAkv0L72nZ3oa1whfzkuR0QDAZeiv+Facnd1ojkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346910; c=relaxed/simple;
	bh=qo5h3VNWAzGEFdvQ0xNBFa4ZF+t7QzbwK3DsnihikGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCehDHZBW6cCPMY68MB0Dd5+WHcxOILOefgLUFVVcG4ilWZQXPsuBmBnImip7kQoHzSUtcwqMjRG0CZvQ2Ez6xOYbDxWGPOunKklaSf6pJi81R/cu6JskhJLUFrt4VZ0PfJ0w57g4G9At7CdCPcpLPgVKiM0VdhX7l2cYF3KHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=MtJEZ2Hs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNXeZOr/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="MtJEZ2Hs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNXeZOr/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 47714EC0522;
	Wed, 29 Jul 2026 13:41:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 29 Jul 2026 13:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785346892;
	 x=1785433292; bh=O0dGnjvFzVmFkVemNxwSqq8PLt+SyQJiIe7cP5VoALg=; b=
	MtJEZ2HsAOa/x9Pki7qBmHiaPyPS12482Tdabv/KBrCEfdXS8Lv2Sd9vx7YMZxIJ
	mhxRY/PwmSUSkRYK9N1ddRkZqMv5cIMkw561n77NzG4gw5IDCLeNSvcajEBKPONC
	riWOs8PQwBFnAxop5e+cDizKD351XY99Hy/X51rnDzsU31VVxf0u2mXlyeJgD+gf
	FRE8IZanAQCDkzrz1QAANXSwRJl4ENnKpsrbvnAcY8kup424qUL0CF7gY/B+EeJ0
	lyvFof8wKmRSlsCXZ9MGtyYp3wRElrWVJ4gkpjNDXoCP+VEYyGmlBGHzfFmT7qD/
	qanmAAIpy2kQQPRWoeBInQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785346892; x=
	1785433292; bh=O0dGnjvFzVmFkVemNxwSqq8PLt+SyQJiIe7cP5VoALg=; b=D
	NXeZOr/60e0fb5sHbBNwLfMKNdfGI6iesrq8ySgAOZPCGjJXKaIHkPEPW1jiAetU
	J/P7Szacv+9IrYWBxWrE3yeourCJiZqlM1nX3OUAW8s1k4dfehJsV0b49Zy1end0
	LUtWBTYZdr2I8S0yTDfdwJGk/g/Q5lNshznYL7l2cJ+qPOTCYc80Vfr7Nd614/zi
	VKcgr7go4AdXnrMCEfydCD0KzNfF2NBjJmNvvu9+ED0zwXRR9bKYT3z19STNNF/O
	LEAvS00iV6pcMrvm+hMJEVWPA6MAT0pdI8O55TnO10mLuW/CXtGojzM7GDHJMAkk
	TcOP18CYYdoPYc4oLbwrA==
X-ME-Sender: <xms:TDtqamCXl84g9haHqL6kv0TUrKVOfjMZ7OmTK87y1x2PHyLrh4X6tg>
    <xme:TDtqaoqFCiBRV7TOVMp_yPRPSBd4EPvD4Hk7uyVdNG6WMOqyI7ZqgHWJ_Ls0gMACm
    8yIKx2gmwORaCpLz1unjEQd15OXrfX8b3wIhhiuZJChFvvqfgTTrg>
X-ME-Received: <xmr:TDtqapHlRakOGsZoGs9XH5mrlK41E4Dce6IaDLZTjmEngs1-MICGuGMRBlh1sUquIcDwGgczOu-A4oY8>
X-ME-Proxy-Cause: dmFkZTFd5BfrM21xr15PPLyl6QtlAoAmZUqUjNtYelXjhTkjwkdSqVbbyQghuIT0yxuuFM
    dtKeO806aLs5t9ZXAoT/57TqWQ6T7bTpANjrc+yXHahXevhrJFh5o4L95gCN6vGCPYcMXn
    dp242DjRTDo8I/PqN/77JYx9bHkFRQuAEoP2PdXgdSODNRUDzKJ3nye04KaUK66oeqY4Qd
    2uVrwFC7yjIoqOu8tcRZwjHGHE+oVYL7Zj+JSGLMCov/SmEAa9k9JQv/O8rmYCgdBVbTaw
    Rz4Lfd6ASveFmVeqeGedG/Z7VCx6vPFDDkYMDpW/3W+5GDQeSx61xpB8agJOtEnhfKQMaQ
    wfRBR8l8wOpUZfE24Q/RXeoOwaBIY1sjYzTGlAknp1OM41Sz42kagUB0Nxix6KIGcdJ0uU
    HwShTlFxf5bAmlQXZ9KmkuPh/Xjy9gTDmk8+d3KhqTevmTOPIeLzon66IQ+r5vBm6qvIxm
    QazFqTA+LaDLDrN5wMutQaZCgGY6j7WDDkBrto1qiIYHWuu99Ca6dENypUQ/UO68Kuau9k
    JqG3V5lPoxP2G1xQ2IzqQplLngh+PYkSYPXIPqtk3Ope49Fgi2/LXk7y+d6KsgOOXnC9Qn
    iH7CbQ0ZFcubR+SSDsSaySHjccOtV5rjxJ/shHM0lW392rogAJ7yOmMga6Qw
X-ME-Proxy: <xmx:TDtqakuDGZE_htofql8eP8TuSR2Twv4vvRv12aVIr5aTGwm4v9PDOw>
    <xmx:TDtqanZq5kOrtDdPJ4ZO3Pz6C_ekt5RE34yKDj9da5P8xa-z6gcYAw>
    <xmx:TDtqas739sqx3KLSQi3BwzsoIiWXvB2gxOplCeeeabCozfXA4cgb-w>
    <xmx:TDtqan-hnPxWHSy0cPopMZlfX8gl4eBcv9BExPaimy7EWEpOoORgQA>
    <xmx:TDtqahJvhtG8CTE9_ASzz3Pf8nKQatXR06VhN8Wv4sUnAGINkKc28vnY>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:41:30 -0400 (EDT)
From: jaseg <git@jaseg.de>
To: 'Greg Kroah-Hartman ' <gregkh@linuxfoundation.org>,
	'Jiri Slaby ' <jirislaby@kernel.org>,
	'Bartosz Golaszewski ' <bartosz.golaszewski@oss.qualcomm.com>
Cc: 'Praveen Talari ' <praveen.talari@oss.qualcomm.com>,
	'Viken Dadhaniya ' <viken.dadhaniya@oss.qualcomm.com>,
	'Zong Jiang ' <quic_zongjian@quicinc.com>,
	'Krzysztof Kozlowski ' <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	=?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] serial: qcom-geni: fix TX DMA buffer flush
Date: Wed, 29 Jul 2026 19:41:05 +0200
Message-ID: <20260729174105.21838-2-git@jaseg.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729174105.21838-1-git@jaseg.de>
References: <20260729174105.21838-1-git@jaseg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jan Sebastian Götte <linux@jaseg.de>

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
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/qcom_geni_serial.c | 43 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 21 deletions(-)

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
-- 
2.53.0

