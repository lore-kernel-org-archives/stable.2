Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEE3E3D98
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391929; cv=none; b=tdA6WwFaO9PA6XAI1R82xxlz4Ge2H23tJ4CMt26I7Ulc/+d4FMLQbuc30fjBUZESXwBR9ngjz8F6FisPKZHo4EvkViSoUaRY76Ldr/8LIDjB4BHEWBk2VQrYxCda6m9MMLqJD4ZujjNfmXl0tU7u6IpNrLUcYAot2jlL6ifnHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391929; c=relaxed/simple;
	bh=hdPX9sU0ppmNFLDsSnbrWlN73uQ/YB1jvYe5lO32hSI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VL7TVyARNBywA7fwgl9kpjQe7LPi+Eg06jBEKLzL64Qze+ojUqUoTVIIBijJmWio5sB1UOZSOoevdMgnd39uWFxS6gHCilDJPjtpUxuC1fr4NqmA6e8T/j0FOhre92oSm91zy7uWNX9thvMzzjYWplVJ69PQETXOhTwOuaDRQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HvHBtah4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HvHBtah4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30E61F000E9;
	Thu, 25 Jun 2026 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782391928;
	bh=3La/XFBxb4xyYmyJ4Xdp0O0lRSob30WDyJkXZZDm6gs=;
	h=Subject:To:Cc:From:Date;
	b=HvHBtah4zg08Ww3G/Y/3V+35hU1VGDPCxf47VL5cBIUbJ5KXJP6nChTuyek+FjbzR
	 rgPxF9WAkOR1QtZMIlIj5/Z142ik+uKXjfxNTFiU9Ye9JlaOgO+BIWXaucnc7Lce7M
	 dAnKgZ6KUcwVMurqrdtsg5AOThVrJBy6Wxhlz5+g=
Subject: FAILED: patch "[PATCH] serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is" failed to apply to 6.6-stable tree
To: viken.dadhaniya@oss.qualcomm.com,bartosz.golaszewski@oss.qualcomm.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jun 2026 13:46:23 +0100
Message-ID: <2026062523-sulfite-banking-76d6@gregkh>
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
git cherry-pick -x b93062b6d8a1b2d9bad235cac25558a909819026
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026062523-sulfite-banking-76d6@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b93062b6d8a1b2d9bad235cac25558a909819026 Mon Sep 17 00:00:00 2001
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Thu, 28 May 2026 22:48:07 +0530
Subject: [PATCH] serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is
 zero

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

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d81b539cff7f..7ead87b4eb65 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -905,12 +905,9 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
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
 		handle_rx_uart(uport, rx_in);
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,

