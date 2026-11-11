Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415215;
	b=rSBXvzLDIO4zNYylyu7bYUbJURkju+gzbSuCRt2ftML6hOeI/+AC+HaHdahAwFn9eChz
	 bdz20na8+vuc+k8PxfLeFwv+HPOoKBj4rDqBOfJyRmL7cYZK/XNxzGUvukvA2KkUjlNlv
	 nnEqQB6OGNBayB3Id9avL78KAh153aizUjCGlAo2Q5JeJVNIkgDKCtFYsSMvNrihj+hBs
	 V6T/thvbipzvjAoZZNlvjRqk5ZXwyn0jzxKMcpDyH83d/sZsghQulWcLXkg33bPFfa67R
	 PdqVhOteNm+ZVwG6g0Kmjul6Hv0M14n+NcaOC+6YXN3hoMR/SVkmGQq/y7y72/xsW+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GGRYmAKybQeI6LB5/LVYdBbUdNt8wBRZXAwIekgmBs8=;
	b=idWFteG9QkZksVvHH/KBLl6s4PM0CvmnjevN48SqGDyo3cmTyPmPnFLuF+opKu84zt79
	 Gxzfk9E1stDdPm9mbs2w28lpc7Meg+KcMwDzCtw3THgkrOCMxHqyMYsHQYSJNF3VnCYhi
	 +Nt/l4r6SUdsuHlt9RHYsS9pU780zIIbMO4SCSV4AUrr6Ji4Fw4SN9jNHjTv6n+IY7n0s
	 uhrYnK6v3WRDS9TYgbOMhQpehChHRIvhPr5htEnOy2lvqkdi0hqTRaE0iH1LoOye8rzXa
	 KNNdtFH89ac5nRlMdb+7bDeeL4HpfZYAgTQVDAYY6m8r+bWgOL0aBtAISjW+zR7v2GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjKIFffP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A3606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjKIFffP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102561F00A06;
	Wed, 11 Nov 2026 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415215;
	bh=GGRYmAKybQeI6LB5/LVYdBbUdNt8wBRZXAwIekgmBs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjKIFffP2Az/BBEmmXXga402PpIAi50898LnG4M3lt2CLpMNu1PkHaBYCkeBCIicC
	 fuE9+gw9N+ZB0ax4Bq9lsMh2myxb+EAWpeEsQBgqUrvQCjkPKE5Uc9mKJKckn0s+D+
	 FWXVWVkWk1vME2KcmXdai0oAljkqnYjwy9f7oh0ioQVJbIeq69Iao+BDdJFAYZhJsV
	 JfCk65Dvz8CEP2QLGH38tnVbHA0L9ZO2LEOYInQb4GGCzDi+ZOHS/o26LUZD2LLDI0
	 BXQENu0Yl5ShB+NCgjZXQ8wOekTGLZLkHqBgxugcEg0GU2hQF/no5iLRlDoiGzaofg
	 PAPhxi9h6e3AA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] spi: cadence-xspi: reject SDMA transfers larger than the requested length
Date: Wed, 11 Nov 2026 11:40:11 -0500
Message-ID: <20261111163924.3264424-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111163924.3264424-1-sashal@kernel.org>
References: <20261107051125-failed-6.18-ea9854a169e9@kernel.org>
 <20261111163924.3264424-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weibin Liu <liuwb@xiaopeng.com>

[ Upstream commit ea9854a169e9c1437df8829bea21c2f2e80b137c ]

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
[ sashal: Adjusted context to retain ioread8_rep() and iowrite8_rep() because the wider-I/O helpers are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 36 +++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index c12930ce67472..ca6af39e977a4 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -332,6 +332,7 @@ struct cdns_xspi_dev {
 	int irq;
 	int cur_cs;
 	unsigned int sdmasize;
+	unsigned int sdma_xfer_len;
 
 	struct completion cmd_complete;
 	struct completion auto_cmd_complete;
@@ -344,7 +345,7 @@ struct cdns_xspi_dev {
 	u8 hw_num_banks;
 
 	const struct cdns_xspi_driver_data *driver_data;
-	void (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
+	int (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
 	void (*set_interrupts_handler)(struct cdns_xspi_dev *cdns_xspi, bool enabled);
 
 	bool xfer_in_progress;
@@ -445,7 +446,7 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 	return 0;
 }
 
-static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
 	u8 sdma_dir;
@@ -454,6 +455,13 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
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
 		ioread8_rep(cdns_xspi->sdmabase,
@@ -465,6 +473,8 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 			     cdns_xspi->out_buffer, sdma_size);
 		break;
 	}
+
+	return 0;
 }
 
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
@@ -510,6 +520,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
 		cdns_xspi->in_buffer = op->data.buf.in;
 		cdns_xspi->out_buffer = op->data.buf.out;
+		cdns_xspi->sdma_xfer_len = op->data.nbytes;
 
 		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
@@ -518,7 +529,11 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
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
@@ -900,7 +915,7 @@ static void m_iowriteq(void __iomem *addr, const void *buf, int len)
 	}
 }
 
-static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+static int marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
 	u8 sdma_dir;
@@ -909,6 +924,13 @@ static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
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
@@ -920,6 +942,8 @@ static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 			     cdns_xspi->out_buffer, sdma_size);
 		break;
 	}
+
+	return 0;
 }
 
 static const struct spi_controller_mem_ops marvell_xspi_mem_ops = {
@@ -1084,9 +1108,11 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
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

