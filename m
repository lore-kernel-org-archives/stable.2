Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840578;
	b=gGBVPWEgfPdRnlmyTwMSmeYun4aTL8Y3eT8llP7C5v9kWSvQ/DHGz8lLbjgE/RwD/VG9
	 2WjV70Ru+/wMrANi3VDQxi2JNiHRW4EHe55YfewJEsRhAbskysQorXSOT1N45jactNW/m
	 7VE3F1sg/qNVjDIdT/t3hJ6L+WQE8Zx1wI77TQLhWf5ecMC5/8l6P3YpVfB3G/rLjxcaM
	 rQhkFaOWkTrTym6awTknE/vBz1Y4ZnlQzvd6YXHdsqua1OAL8akBE7ljGjSg65dPduV3s
	 Lo+fwCDLZmbLLnP6p9HtpFiaTLagJY4s+Gg+LQuFcB1MSuZ+e/wFexP6bTiYrZ72NcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840578;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=PPVyfboNLKKBGJqR+Ebq+Z794sopcs4kI6gWqtvu1M8=;
	b=jKUS0q9pEt9FBBuyoKzW/amg7O1HAH7OsVJclPtZK86i/6TJEjug0rpoS8Dv1ZfubuUX
	 u882235Vn9nKSNCdXHeGqBABBjshHjnbQueMKHABIiodY+f0SIpYHkYMj+fhxYYrK6ZqW
	 P1pts8/DpAaEEy/pZd71rGFAwWRaeowZYmc+NZARMKyOozknfe76n5Z5go42QpZRu8TDi
	 K2gJKZ0r24iyJ5Iu76JZacQHDzYQMYiXjwBXUAHMB0WT7DHtXRnIcgFE0kP2mzFpdp3tR
	 gwFbhUrCayBJ6ep5r0nyoaXOlSJtxVDtNgkBzX1rg0w9vIFUVmnwz+93/jrXJZnAGAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tPFtt6RX;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF4606A33D
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFDF4606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tPFtt6RX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 995CB1A1699;
	Mon, 16 Nov 2026 14:49:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E3ED6023F;
	Mon, 16 Nov 2026 14:49:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BBB911BC183B;
	Mon, 16 Nov 2026 15:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840575; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PPVyfboNLKKBGJqR+Ebq+Z794sopcs4kI6gWqtvu1M8=;
	b=tPFtt6RXY8Kvax+juILG4ElPn5L/9l1agGAWnwosBavIDH0J+D+4F7X305kdDwwpp3OH6W
	XzUbJkjhbi62a3UoB9Wry/uC7v7N68Xsx5X1Y2N91nAeb2Tsn8mXkZVtGbKHJDeWngDz9V
	Jiya5+D065vNgp9WvozZY3JMDb/Lu5mxWc/EUbKDvYJhj5oOrHqzFmMwAfThjIgtDC1EhC
	soBe3pEHpvt8OPbP6WLmGB37T8h+rEGg7RFNDuGqrlvGU8ql2ganEl2JwgBpPlszjMd5/G
	0GDQ3WActJI9hhqskBLDRkae3XQr61DBJ8tGUzFLMWpaKzkOZIkf6LYwZkjBwA==
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
Subject: [PATCH v4 2/7] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
Date: Mon, 16 Nov 2026 15:49:05 +0100
Message-ID: <20261116144910.44151-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116144910.44151-1-paul.cercueil@bootlin.com>
References: <20261116144910.44151-1-paul.cercueil@bootlin.com>
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

The .transfer_one_message() function uses the STIG mode, therefore the
xSPI needs to be configured to STIG mode before starting any transfer.

Without this, .transfer_one_message() simply won't work, at least on the
CN10K SoC.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: Adapt the code slightly to work on top of [1/6]

v3-v4: No change
---
 drivers/spi/spi-cadence-xspi.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 442595daf7b5..43aef7837bcb 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -367,6 +367,20 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 					  100, 1000);
 }
 
+static int cdns_xspi_set_stig_mode(struct cdns_xspi_dev *cdns_xspi)
+{
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return -EIO;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	return 0;
+}
+
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 				      u32 cmd_regs[6])
 {
@@ -536,12 +550,9 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	int ret;
 	int dummybytes = op->dummy.nbytes;
 
-	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
-	if (ret < 0)
-		return -EIO;
-
-	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
-	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+	ret = cdns_xspi_set_stig_mode(cdns_xspi);
+	if (ret)
+		return ret;
 
 	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
 	cdns_xspi->sdma_error = false;
@@ -1112,7 +1123,13 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
-	int ret = -EIO;
+	int ret;
+
+	ret = cdns_xspi_set_stig_mode(cdns_xspi);
+	if (ret)
+		goto out;
+
+	ret = -EIO;
 
 	/* Enable xfer state machine */
 	if (!cdns_xspi->xfer_in_progress) {
-- 
2.47.3

