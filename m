Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1F1F03DE
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394904; cv=none; b=uf1LGIuXz449fxNFP+BJbwrs6NYdFaD58cy+CExbJk9yAw2ZgZpWBjWnK+u90UiRIB9gHD/QSyWU4eYoBPeMnfjJmaL7zv8UyId56ng1Zwn8YJqBkBAQ67Quc4s18al8JE+6cH7E1o6tVwybjOGW4cNc2ujkAmfMERR3+qNMqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394904; c=relaxed/simple;
	bh=zeOIcoGHk4l6TCodEVFA6j6ZNy8JFNIz/aPXllMU+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFg+NS2+HBEw/Mhg+NobfnMffcV6JQ+JgJMrbBEaguKPPAH1fYznRjCSC2DxpyVKEumq6B32H0nx545KyHX0quHNgo0Z6yhKi83GVgRxA3Wb4v8yAYxxqyDJATuh2MQGTYws+fjU/ZnTaY6kE7hTC0bY2AvWID/uXyq/HdncUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwqddWvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwqddWvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC231F00A3A;
	Thu, 25 Jun 2026 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782394903;
	bh=bwr95TyqJ21fnGQAL1TJMJy9QANMncsjZ0ueu+25nJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CwqddWvQatk4zO7DV09ao4WVkRpcyUBh4lA1wUeTb3h2O9xyHOPvhX/g0DdJmJRPz
	 dQNBQyCow8VQp8+s6BwRDUClpbaxXiqgnR5Nngvx1HOZTPcyd4xzS4j6c6RiD9jErc
	 +BaQrBzFZRzwce7sxOoTEQv9eA8rH1ReadjLgc013yA9qNRZiFH051PXL5ueFzo/hd
	 t8bg25HRWAhCJYAJZFBSxzqRMk9kGOWOnEWfM5rPIKi71aShSwD7ldQ277STxbdxtJ
	 /yryk7aBSfJ2DZu6+fY4goNHeomdrj8tBE1gFH5EsTmHh6qX+pwyao8AbbWsO99WLm
	 WpCnESqvkS3Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is zero
Date: Thu, 25 Jun 2026 09:41:41 -0400
Message-ID: <20260625134141.2411620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062523-sulfite-banking-76d6@gregkh>
References: <2026062523-sulfite-banking-76d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

[ Upstream commit b93062b6d8a1b2d9bad235cac25558a909819026 ]

In qcom_geni_serial_handle_rx_dma(), geni_se_rx_dma_unprep() clears
port->rx_dma_addr before SE_DMA_RX_LEN_IN is read. If the register is zero,
for example when the RX stale counter fires on an idle line, the handler
returns without calling geni_se_rx_dma_prep().

The next RX DMA interrupt then hits the !port->rx_dma_addr guard and
returns immediately, so the RX DMA buffer is never rearmed and later input
is lost.

Keep the handler on the rearm path when rx_in is zero. Warn about the
unexpected zero-length DMA completion, skip received-data handling, and
always call geni_se_rx_dma_prep().

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: stable@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Link: https://patch.msgid.link/20260528-serial-rx-0-byte-fix-v2-1-b4195cfe342f@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 5083eaddd635a9..ab5b4c6c29de08 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -838,12 +838,9 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 	port->rx_dma_addr = 0;
 
 	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
-	if (!rx_in) {
-		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
-		return;
-	}
-
-	if (!drop)
+	if (!rx_in)
+		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n");
+	else if (!drop)
 		handle_rx_uart(uport, rx_in, drop);
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
-- 
2.53.0

