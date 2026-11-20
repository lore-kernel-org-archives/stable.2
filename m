Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175995;
	b=aSqot1Mn9LkrMqTwa0UlF4HkhBFLjjUGtiXV34YyPvGUr4s/jWVfqoryKGmYN7wnSIBE
	 2qHg7tzqS3EpdSUWkZ2mylSh6M8QV40noLG4USSYvSLI3kruSql3Pki+FMw+4qkBibrHE
	 QaFmI4jld09WcOD2xelqSDb/IU06yM7fJC7S6E7KiNz1sNtEk3Keh8/TrtCAfG9czupA0
	 2hspI3WsoG65MAFQqAns6+bUdTzIkh5btL3PAlP0cwD9D3g4ADmGzQhhGqtqB4M1BIR6B
	 /pv5eVzwl6zJCB8yGUW87yMvfa2UVvKlgxnL4CTKofIhwDYfypQePzHzYp2m/8ZDlvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175995;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=HSt22FZMFS/lBvERD6y8JC4unmUiIxcaCvcofVi2k90=;
	b=T9FZ3uN4Dsryh43xtBJnVYYTB94baoIBC1Cqcx6m3/3PLBSJB3QiN8bsdJy+C1/r0MAc
	 cnbzsUAzvHD6ZnZeT47fKdDiTMW4vXSz9/tSOV3feMzoCE/asMHFZ7F89NQTU3auD+dAH
	 PTW1pVrxjDIHer2uHNIUTOWCXwY4xCVzcM1ARpRRdd4IJanI34caq+tMlcf0hGJ7EYKgC
	 OrqySRveizAp4trm+CVBFbDnxP1Uy3+KZPXtF1V/8f7k2M8k8bOSnkPb+fSUfTe9Gfws+
	 Emzthkl1B0s0eNy4vLieEj7zeQ7FwxiLjaaUDK3XuzcHyciBNoHrR3+oumdrB5YtFkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="yV/tpB8I";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFD606A32A;
	Fri, 20 Nov 2026 11:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98FFD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yV/tpB8I
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3E9D74E41681;
	Fri, 20 Nov 2026 11:59:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C0536017D;
	Fri, 20 Nov 2026 11:59:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 364BC11BC004C;
	Fri, 20 Nov 2026 12:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795175987; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HSt22FZMFS/lBvERD6y8JC4unmUiIxcaCvcofVi2k90=;
	b=yV/tpB8I9DV+OQLh+a1ioEb8GAW0dCP7vdt+Y05Dwaur6IDjIZFUthkjmtM9fO96RGdY5l
	Rd+CiF/1jUAhGvz65O6p66dwda7LjG6O3yy3Xi1e1WuwdZjLyQlzOU19fGDgMr0xOpEHwI
	MtwH9RJUrlI+opRDqj4mtmfe8kq5RsYGj9/mKWfWIASU1Kcj0EIwQOqZ3OF2HQVo1Szn8e
	ryixgvsZtjROVEM2CKgiVSqvxWthIJ0twGBgZ9Oz5ER3hJ6J0NpITPbtDvbqiRgpYoyri7
	hVylu3r0EDON8gQ21OSE/IPhmrlXLMQVbASUYsd/FjGHmjGMVh/QSiyHjcayAA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v5 1/7] spi: cadence-xspi: Properly handle errors in .transfer_one_message
Date: Fri, 20 Nov 2026 12:59:19 +0100
Message-ID: <20261120115925.173568-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120115925.173568-1-paul.cercueil@bootlin.com>
References: <20261120115925.173568-1-paul.cercueil@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The cdns_xspi_transfer_one_message_b0() function was not setting
m->status on error, causing it to be stuck at -EINPROGRESS, confusing
the SPI core.

Additionally, reset cdns_xspi->xfer_in_progress on error.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: New patch

v3: No change

v4: Also reset cdns_xspi->xfer_in_progress on error.

v5: Reset hardware FIFO on error
---
 drivers/spi/spi-cadence-xspi.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 72852849ba27..e2d5d464bd30 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1243,6 +1243,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
+	int ret = -EIO;
 
 	/* Enable xfer state machine */
 	if (!cdns_xspi->xfer_in_progress) {
@@ -1283,7 +1284,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 							  false, cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 			} else {
 				cdns_xspi_prepare_generic(cs, txd, 1, true, cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
@@ -1292,11 +1293,11 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 				cdns_xspi->sdma_xfer_len = current_transfer_len - 1;
 				if (!cdns_xspi_is_sdma_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 				if (cdns_xspi->sdma_handler(cdns_xspi))
-					return -EIO;
+					goto out;
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 
 				if (rxd)
 					cdns_xspi->in_buffer += current_transfer_len;
@@ -1324,7 +1325,10 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 		spi_transfer_delay_exec(t);
 	}
 
-	if (!cs_change) {
+	ret = 0;
+
+out:
+	if (ret != 0 || !cs_change) {
 		u32 xfer_control = readl(cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
 
 		xfer_control &= ~(MRVL_XFER_RECEIVE_ENABLE |
@@ -1333,10 +1337,12 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 		cdns_xspi->xfer_in_progress = false;
 	}
 
-	m->status = 0;
+	if (m->status == -EINPROGRESS)
+		m->status = ret;
+
 	spi_finalize_current_message(controller);
 
-	return 0;
+	return ret;
 }
 #endif
 
-- 
2.47.3

