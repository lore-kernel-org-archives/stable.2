Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC103CD8CC;
	Mon, 27 Jul 2026 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785133540; cv=none; b=Kqq9RrRTisVt6s+ZviZu0IkA0WyyRO7ZaZb0eq/aXuvqjlm4uTsHN4V2cWdo72Na6es7cZhaOf1qXBlhqzxgFnpizovS+mCcXYW+mYDg5VgRzgIQoNy+Vj6sftglciZkyEz+Lkavkss6ekSBTy+HmLZWUVyZtASEE4vFNVzLuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785133540; c=relaxed/simple;
	bh=EArMMq1fbqBiNSuwPamTX/acIFzDrJtNTnWp80OBT8Q=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=fV/nhZzNLmoBYte0LKO2gTTUOYqikdT0/MaCfrbP5sofbwGSxZcr0cX7RYT9CTlcdytX5cwUp4kwCwR4cPijexDpTAeqc9uZvQox5zeazXe6vZ4zhEfUwJUsakPOucLejdZqio3dAA3xVTIQFNOUAXfd/dBjC87N8t9aCx6HsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fZNIuKJv; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fZNIuKJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785133530; bh=fJjA0u45wGrYkgaxaSw5oReCej94u2Ecc74g4A88MYY=;
	h=From:Date:Subject:To:Cc;
	b=fZNIuKJvt/4xNmKx0IbCA0scRc+zRpsD3B0BdbpV1TseQo92zpoBJj1VmjuUt22oX
	 +52iqwj4dfJnkoqqwW9LwKGs7DTRw16fla0NpsPVU+mUpSzx45FMm3iGF8uwWKuvxm
	 O3VT+Thq8/HFgr7DceFS5ES2hlVXFH0HQVYmcwM8=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 65BAD025; Mon, 27 Jul 2026 14:25:27 +0800
X-QQ-mid: xmsmtpt1785133527tnijxc6we
Message-ID: <tencent_9EE2945F4C933B4D810C73C2D7485E000F06@qq.com>
X-QQ-XMAILINFO: NGbyafB8LluucorYrT5aHYQa1dA4ggDoQ6lcjr1qRkzQrWturrScaE57APMuRp
	 4+WyO6imZcvBaWDDpjWZvUpQ/xzcPL8pUW539Uq7x9GzgwT2+5e9KrhDRJBhlibPfl6Z7cQ6LC3M
	 2taoLGRfBsmzeo+Mh6AIt9oSOj1AviB7RKO9fpzfUvWXHqdPzsOhptuQPWx5b46uaNdGGsGGDThQ
	 4DG6YIhzJ/V3WdlRXpp8NRl3TfoXvb12GcPWImNN1JPH1DQ6DL3LO0R7IPiWxbjJjDPh9xPd8dfA
	 XXjX/aFdTTB+73CU3vZEbDgl6YJByIJiR545AKQ+wOIB3Q1qrAnnyi/AePPvB+/ENXCScOvqOgvM
	 lhLgPYUQvYAeQsECmomIG6OGcnRxstwOmYyN3DaY+26TSjPkmKeQVqI6JwinSdrjB5dQTfVug+gV
	 eoK1iiI1/75AzGJ5COZzHpAx30UoEtBmRa59tpBg8A5JLxv3L24FdKoO/vG81VHbU58jD1qHUOvt
	 YI2voWLyOkxwY41R5AegC3rRVhAHZWo1ybd5n7/QFLzmuVpFrVkIpkldHBP+VWX4ES//oWhjOiL3
	 oKOq/rCtxUHfuDJhV3K512R974ix7q84WkCHgZkt5jaND9Zk5EIp3Ny3ltRIFhJgoY++EcOcEw/q
	 wZwAHMeKqjKRXLY3BaAfjUSuGRNoI5K9Sr0BJvR+2jJ3KXtUgkn7eNsUN+KFU/dK2JJ3F3jrweZZ
	 TBPYHVAPt50DtFmTbleMW09/Ef13VfL6ab00zsSECq7HOT9GaMFc93mpOwd7rb7aU0TitIzzm1yr
	 pNcMSOGhoB3VjxcjlfdZ4RL8Y/e5rC8Z7A+b6DFB783Jk9NqxHWME8bebRMQFLiGYH45TMRWI0b/
	 aHk+gi3/nMf6+rs4LOfLDdX1cMlpIe+7a7tz2WHpgnjh78R34mJiX0GU8iA++5OSTywuSTqB0peq
	 o7R//e7RcNE+GhmGRXs7DBELwlCmNBvKQMVXIFTnDlQAG2d281SivsshtCQFUiopahwHSPcrsHV9
	 5sntGH4RQKZaJO5wzgP81lZA9DAK4dOXOqg50j3RCa5E3oVGTshS4J4Pq9nW2eKB/lVJdE3R4i1g
	 acs89kqOzsTJWQWzLwgWlscRCppQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Cunhao Lu <1579567540@qq.com>
Date: Mon, 27 Jul 2026 14:25:22 +0800
Subject: [PATCH] serial: 8250_dma: Clear stale RX state on shutdown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260727-master-v1-1-12003670261d@qq.com>
X-B4-Tracking: v=1; b=H4sIANL5ZmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNz3dzE4pLUIl1LS6PENDOTNKNES3MloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AWSvaHmoAAAA=
X-Change-ID: 20260727-master-992af64f2a97
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

serial8250_release_dma() terminates RX DMA and releases the channel, but
leaves rx_running set.  If the port is closed while an RX transfer is
active, the stale state remains while rxchan is NULL until the channel is
requested again on the next open.

The DesignWare BUSY workaround added by commit a7b9ce39fbe4
("serial: 8250_dw: Ensure BUSY is deasserted") calls
serial8250_rx_dma_flush() from the LCR write path during startup.  This
happens before serial8250_request_dma() obtains a new RX channel.  On
reopen, the stale rx_running state therefore makes the flush path pass a
NULL channel to dmaengine_pause(), causing a kernel Oops.

Clear rx_running after terminating RX DMA, matching the TX cleanup.  Also
make the flush helper return if the DMA object or RX channel is not
available so startup and teardown paths cannot pass a NULL channel to the
DMAengine API.

Fixes: 0fcb7901f9d6 ("tty: serial: 8250_dma: keep own book keeping about RX transfers")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/tty/serial/8250/8250_dma.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 3b6452e759d5..5a83e5269b41 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -211,11 +211,12 @@ void serial8250_rx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (dma->rx_running) {
-		dmaengine_pause(dma->rxchan);
-		__dma_rx_complete(p);
-		dmaengine_terminate_async(dma->rxchan);
-	}
+	if (!dma || !dma->rxchan || !dma->rx_running)
+		return;
+
+	dmaengine_pause(dma->rxchan);
+	__dma_rx_complete(p);
+	dmaengine_terminate_async(dma->rxchan);
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 
@@ -324,6 +325,7 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
+	dma->rx_running = 0;
 	dma_free_coherent(dma->rxchan->device->dev, dma->rx_size, dma->rx_buf,
 			  dma->rx_addr);
 	dma_release_channel(dma->rxchan);

---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260727-master-992af64f2a97

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

