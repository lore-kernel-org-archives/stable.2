Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786861;
	b=aoS3a+P3OftkhlyUelWqK6XW8FluS2dNxjIBAJUyB1acAzHpIsfpCaZXyHS72JuGKVAX
	 ilU0T0Zy2a3rvKv63BvNNimleZFKQnH3J4/cSzgO8fbE88kVqV0zuSw7aiU+TTOxxOIu9
	 1arsDK2MRZyVsPqPHhFKRsvpGeM/C9DvPhMOf8SWQhDVOKAVCQ77ZUWNYKU1S3+65zvMY
	 jtmqA0c01R8Q6tiQlitPZ9e8mcG0QVeFMs4nOOvh64nG6om4NCHFBnrzohWbAbVWfdfyA
	 IdDyOs7lxtVyqOwJXT6sZ4u8ColsNZC6Jqqd+hFe6gpsFMUyxX6PfasQif1zbajsv5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786861;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=yAjUsrKQSPbtUssggE1dmZm8YyojJWtbN0tnuzAowiE=;
	b=qfYncc65kZ2g5kLb7WidbCvHLze+0Z5uCjHYzdaq4vnsBGxBfm73SIJoVhFrhNMqPMPj
	 EYMUgkmpcfXdWKhPXT7s8qhKpG9tmIWjMQTdOXskIudz/kF/s6+y1D6wp+KwV8p8iD/Vt
	 OqT0vfzSXmb1TdpZ5noQQpYdzmXwg6jzc3722IJoD28+6FwP36G2SsJlah3IWKGqXEBZF
	 8TWtdbViK/rkIIUku9qTfLeakcJ6RDCEZZK0+B+9QuyZcE87AT0g+GmJUsB8+A1e3dswn
	 HYwdbVpxofmIOipo7vikllV/yqL30UgUaBtv7Vv4QaWaHFN5A62TZMO/PiPbljqH4kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=T4sZHwlc;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B5606A331
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 10:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 733B5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=T4sZHwlc
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D7192C8F46F;
	Wed,  4 Nov 2026 10:08:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAA8F60770;
	Wed,  4 Nov 2026 10:07:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2FAA103291D2;
	Wed,  4 Nov 2026 11:07:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793786858; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yAjUsrKQSPbtUssggE1dmZm8YyojJWtbN0tnuzAowiE=;
	b=T4sZHwlczc/xVofZKumDRT2BJIducPd/gWhdufcUpdrmM38DxV9JJUzbBBT0en5HBRwpng
	4sWKdGyTYtXh7nMRPBMHcodInEPQ2mxVFddFhg6Peq9ivKrO3dg+5i6gdSUuJb5sP4iHjH
	wpVp7atzwirZrLDyD5L0nMvcjtIoFuZoZWoMfLVyvykJqyeppnb8fRKlgBI0p2fqt/jBPc
	vHsTfWWryRQMOzAhojGKVPf9/XqbesHiu8XGcFjkD2h5Q9IUIj4JYCBdFdt0XVoEy9wqqf
	oil0DTODz0nvEE+sASGA00JJyYv51ztR6hw5jXhUKth/MJ/A+sYgONhDpzOfpg==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 1/5] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
Date: Wed,  4 Nov 2026 11:06:39 +0100
Message-ID: <20261104100643.162694-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104100643.162694-1-paul.cercueil@bootlin.com>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
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
 drivers/spi/spi-cadence-xspi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3687853e4ce4..e3e265f51e56 100644
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
@@ -1112,6 +1123,11 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
+	int ret;
+
+	ret = cdns_xspi_set_stig_mode(cdns_xspi);
+	if (ret)
+		return ret;
 
 	/* Enable xfer state machine */
 	if (!cdns_xspi->xfer_in_progress) {
-- 
2.47.3

