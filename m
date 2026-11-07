Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047710;
	b=dF3JX1mBC5r8lIqMElm1AoDHQi+YtDApOLWhdne0DvpTUlY2XSCWmxlU8lbAe4Lyxy9M
	 lPBM54KYD/eAmv+S7TGLhu+wgdvIdhEGkQuP6ATLREbXVR60dtnPuGwldlt7ebGs54vfF
	 ycsS4D3MpchIIxmc0xu0TUB56exvrGtBntU3X7z+OD4y8AaXWeMKUTdcYey9CFG577baQ
	 1y1N1iVeZxw90O70eMoPjzI7gdbbAhqOR80Frd7Kbgl3h8LSy78ITWy6qrro9RZn6LF3B
	 lhz4rq1hme3Zs8AFfe0AzI1DLgOJEHB77V4qHf0PurUGPcZ5TsInefKtO2cen89BXcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lLOMeeU9Qi0Jsq6h6WKtCqKujrVmcMoGiys2QhrV2CU=;
	b=srRQFt6ai7qMpXHWr5TzrN8KCRQigxSEt55m7ZaNC/zo0ywWeUO+iHVpXM7KWmuo8vbq
	 9SOrmzkZfqWFh/Oj3PU2ui7RnapthWaRqPwWwlq2AC2WuIFBviMqUsQ8BTW36jBUKs+kX
	 C/mYYZOrv38xxPveHnIimt2wzzC9+mi7708H0Cz2Up/oThUAyoHXPR3pY2UOXudS3dXBo
	 4TSs3aUeQN3wU3HB/Y1zuq/OC8xnQh82CtG8uKWgP6IDqQmRGp5caZDUY9iwaUUxvhbDT
	 GFcsBoNKwstSRYzBo+0sQiwLR23L0T1pRg/AXRTXwffbaXMuhLweWcdHoFyc38guaMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wj6J1cpS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wj6J1cpS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060F91F0089F;
	Sat,  7 Nov 2026 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047710;
	bh=lLOMeeU9Qi0Jsq6h6WKtCqKujrVmcMoGiys2QhrV2CU=;
	h=From:To:Cc:Subject:Date;
	b=Wj6J1cpSNgMNBzXUb0Rh9Cyt6b+VU2nLm+1mYQpkoWdc4zapDkx+zMMF3xAs3ZGGg
	 V9XnLfVLtEacVnIk7In0pwtUxrjH4dxPpFiRF4U3tR0KiUSBSNc0qCcVq5YdpRORsY
	 h5jFamKqm/ZaGbFHupi1WXsYRq/K/mLh70IW2wbpRvd/61oDFg4LEgWCr9r1nPr3GZ
	 DEUmxmsVYKRRE6M6B8V9KuTsButjj0B1fXMA/agZBcYWgqGZhzAcJa3AmiItuLGf97
	 DgDnRCrCcTdFaPBdk87gpv+MTQn69VsWWoM5xhOmdCJu+iEBSKlMirVYWrCQXx0vHg
	 4Gd6LWCVXlG/Q==
From: Sasha Levin <sashal@kernel.org>
To: liuwb@xiaopeng.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: cadence-xspi: reject SDMA transfers larger than the requested length" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:09 -0500
Message-ID: <20261107053509-failed-6.6-ea9854a169e9@kernel.org>
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
git cherry-pick -x ea9854a169e9c1437df8829bea21c2f2e80b137c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053509-failed-6.6-ea9854a169e9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ea9854a169e9c1437df8829bea21c2f2e80b137c Mon Sep 17 00:00:00 2001
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Tue, 29 Sep 2026 16:11:44 +0800
Subject: [PATCH] spi: cadence-xspi: reject SDMA transfers larger than the
 requested length

The XSPI controller reports the size of the slave-DMA transaction
through SDMA_SIZE_REG. Both SDMA handlers take this register at face
value and copy the reported number of bytes between the SDMA FIFO and
the transfer buffers, without checking it against the length of the
transfer that was actually requested.

While cdns_xspi_adjust_mem_op_size() clamps the size of the operations
issued by the SPI core, the device can still report a bigger SDMA size
than what was programmed, which makes the handlers read from or write
to memory beyond the end of the transfer buffers.

Track the number of bytes requested for the current data phase in a new
sdma_xfer_len field, set by cdns_xspi_send_stig_command() and by the
Marvell b0 transfer path, and reject any SDMA size that exceeds it.

Fixes: a16cc8077627 ("spi: cadence: add support for Cadence XSPI controller")
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Link: https://patch.msgid.link/20260929081146.41041-2-liuwb@xiaopeng.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 36 +++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 39c868a5b171c..1f1cd45359d34 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -332,6 +332,7 @@ struct cdns_xspi_dev {
 	int irq;
 	int cur_cs;
 	unsigned int sdmasize;
+	unsigned int sdma_xfer_len;
 
 	struct completion cmd_complete;
 	struct completion auto_cmd_complete;
@@ -346,7 +347,7 @@ struct cdns_xspi_dev {
 	u8 hw_num_banks;
 
 	const struct cdns_xspi_driver_data *driver_data;
-	void (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
+	int (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
 	void (*set_interrupts_handler)(struct cdns_xspi_dev *cdns_xspi, bool enabled);
 
 	bool xfer_in_progress;
@@ -496,7 +497,7 @@ static inline void cdns_xspi_sdma_write(struct cdns_xspi_dev *cdns_xspi, size_t
 	iowrite8_rep(dst, (const u8 *)buf + offset, len);
 }
 
-static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
 	u8 sdma_dir;
@@ -505,6 +506,13 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
 	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
 
+	if (sdma_size > cdns_xspi->sdma_xfer_len) {
+		dev_err(cdns_xspi->dev,
+			"SDMA size %u exceeds the requested length %u\n",
+			sdma_size, cdns_xspi->sdma_xfer_len);
+		return -EINVAL;
+	}
+
 	switch (sdma_dir) {
 	case CDNS_XSPI_SDMA_DIR_READ:
 		cdns_xspi_sdma_read(cdns_xspi, sdma_size);
@@ -514,6 +522,8 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 		cdns_xspi_sdma_write(cdns_xspi, sdma_size);
 		break;
 	}
+
+	return 0;
 }
 
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
@@ -559,6 +569,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
 		cdns_xspi->in_buffer = op->data.buf.in;
 		cdns_xspi->out_buffer = op->data.buf.out;
+		cdns_xspi->sdma_xfer_len = op->data.nbytes;
 
 		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
@@ -567,7 +578,11 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 			return -EIO;
 		}
-		cdns_xspi->sdma_handler(cdns_xspi);
+		ret = cdns_xspi->sdma_handler(cdns_xspi);
+		if (ret) {
+			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+			return ret;
+		}
 	}
 
 	wait_for_completion(&cdns_xspi->cmd_complete);
@@ -950,7 +965,7 @@ static void m_iowriteq(void __iomem *addr, const void *buf, int len)
 	}
 }
 
-static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+static int marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
 	u8 sdma_dir;
@@ -959,6 +974,13 @@ static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
 	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
 
+	if (sdma_size > cdns_xspi->sdma_xfer_len) {
+		dev_err(cdns_xspi->dev,
+			"SDMA size %u exceeds the requested length %u\n",
+			sdma_size, cdns_xspi->sdma_xfer_len);
+		return -EINVAL;
+	}
+
 	switch (sdma_dir) {
 	case CDNS_XSPI_SDMA_DIR_READ:
 		m_ioreadq(cdns_xspi->sdmabase,
@@ -970,6 +992,8 @@ static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 			     cdns_xspi->out_buffer, sdma_size);
 		break;
 	}
+
+	return 0;
 }
 
 static const struct spi_controller_mem_ops marvell_xspi_mem_ops = {
@@ -1131,9 +1155,11 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 				cdns_xspi_prepare_transfer(cs, 1, current_transfer_len - 1,
 							   cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				cdns_xspi->sdma_xfer_len = current_transfer_len - 1;
 				if (!cdns_xspi_is_sdma_ready(cdns_xspi, true))
 					return -EIO;
-				cdns_xspi->sdma_handler(cdns_xspi);
+				if (cdns_xspi->sdma_handler(cdns_xspi))
+					return -EIO;
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
 					return -EIO;
 
-- 
2.53.0




