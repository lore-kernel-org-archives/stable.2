Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB83A838A;
	Tue, 29 Sep 2026 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669519; cv=none; b=Qq/2v6LIzXwAplmx6BmAf1VMOvR7u89wj1a2oO5kcH32+yxgXcq/hHnmXznFc+9wcrfsxaFcTXLoEf+MTQy8g7i/7/jwjWt2vgRJ3cuDwNteSnhOe+2QKTsqT+KRsMNOcs4C0ksP+MfmjSRvKOetWLauwMNSB7Y3flYOiSeKI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669519; c=relaxed/simple;
	bh=Xhn7NZ5r24r15XU2frNI1OZHbzr/gQw+S8vbdBxeAoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hw8xg7JSU2/BzanyB6BdBls2UwiycU/VMdcSgV3mVYCLDB5sQCBxDjkpZ7Dp9dMmpLfEi0R4ciXBJAxMWrjUAtHFmkZW9kodas1i87OQxiLFQqgc8y1IJENmgevnI5cUgOIVKnF9tYHSX+SBh7JeYPgkeSYL7I6+i+i75d0sEbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=QkNQaMuq; arc=none smtp.client-ip=115.124.28.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="QkNQaMuq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790669507; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X9Zfg0WTi/I1yD8RW5WhTzzEy93JyN9xbCbnC33iwss=;
	b=QkNQaMuqH1GDp6Kyvmq4YU+Q8L1O3V+NqiVCREcn9GrbJR7oHQ7jRJC8P5Puz7Qsp+A0rGcFIaon5xG+nzXqTuMIYNsNOdfS9Fa353JDligne0mhPts2e/HnJOVPSX8Li7hHCMsQmuVDep6cxfNOhELlYz3YnDJ9O925jhSxGJI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.004257-0.00224734-0.993496;FP=212301233206641883|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jRBNq1b_1790669507;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jRBNq1b_1790669507 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 16:11:47 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: pthombar@cadence.com,
	wsadowski@marvell.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] spi: cadence-xspi: reject SDMA transfers larger than the requested length
Date: Tue, 29 Sep 2026 16:11:44 +0800
Message-ID: <20260929081146.41041-2-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929081146.41041-1-liuwb@xiaopeng.com>
References: <20260929081146.41041-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Reviewer notes:

- The SDMA size is read back from the device on every transfer, so the
  fix treats SDMA_SIZE_REG as untrusted input: without the bound the
  handlers copy the reported number of bytes between the SDMA FIFO and
  the transfer buffers, whichever direction the transfer has.
- sdma_xfer_len is set right before the command is triggered in both
  paths that use slave DMA, cdns_xspi_send_stig_command() and
  cdns_xspi_transfer_one_message_b0(), and both handlers
  (cdns_xspi_sdma_handle() and marvell_xspi_sdma_handle()) enforce the
  same bound.
- On rejection the data phase aborts with -EIO and the interrupts are
  disabled again, mirroring the handling of a failed
  cdns_xspi_is_sdma_ready() wait right next to it.

Tested on x86_64: with this patch applied the driver builds, loads and
unloads cleanly; no xSPI controller is available to exercise the slave
DMA path on hardware.

 drivers/spi/spi-cadence-xspi.c | 36 +++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 39c868a5b..1f1cd4535 100644
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
 

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.50.1

