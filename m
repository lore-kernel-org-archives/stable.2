Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493877;
	b=f6f0aQYSKsHl6OvfHrDdWnbXgvFibgYFy7olcYFrq8DXY5J7dEtA9BzLYRAK6UIe7DFo
	 CMCRAUv3X5mMR0S8nsb51lzhiNNF/rcS9d7CrqZcWiCHkF0906YMVEfufsYcry8CmniIO
	 11Yv3tLoFqdCT0a+vLR5ZCP7arIvMCOZIYlSfNNyhFlJIyAPyh2AjeVzDM+ApFb5li1uG
	 Ht5yBGOnWLtCVj7lKWJnhFF4r3Om4z1uaEkJd7IWHvquZKY9OngQKqjvwb5lkqkJqlNtH
	 6/Yc5xZ2K6iA8g9fhXcMOHkQcN9s+VCUWnpG6DEx92igLXUUWINfG5bdumzC4HoxR9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493877;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=D9gX7IQoFmiZn66NpC9/3hlVzyg/M0Vsll6oQ3O0knw=;
	b=Murnvo+g9hkq0AE/tqmQTIqbL4SMR22PudoaXHVKssEoccXRP9DWjaOpJwSqveiqgNs7
	 Ps409D0fp33gQDdm1F5xOqrGAfSP3oVzDvjVXseyBbJS7IEiUBrOD3e1dXTc0JAM64LMu
	 KXcR42khZVN7i0ngM5/2IyP/xHQaWRZ6+iv4oHRmUv4WldRw0YtXd5+YcesQzngBEzp0/
	 rH8Zzf5U2WjlJ8oiqGKkNJtdSPr+1RTZsr1kZa2jhl2NFyFNWiEL3qzULuN5uNAiBk7dR
	 5eeFwgp7vfHayJgMF9JJBhxcFUeFrfPlEi4XltST638zkBLA8l6wLj7S70+KdDZk5Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ibW11s8d;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6C606A88F;
	Thu, 12 Nov 2026 14:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B6C606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ibW11s8d
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 024991A162A;
	Thu, 12 Nov 2026 14:31:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD7D75FF85;
	Thu, 12 Nov 2026 14:31:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13B5411BC1078;
	Thu, 12 Nov 2026 15:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794493875; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=D9gX7IQoFmiZn66NpC9/3hlVzyg/M0Vsll6oQ3O0knw=;
	b=ibW11s8dlQJ90A845P0uya5S7PTvyFTUa4Qhwg0t2OBKWHChE9xM9n66FLuysfxNdOda0j
	qD9mJZ1cqD2uEmtFmTdls3lqKilgKwE0OlSuNJMe5MEgdC7dDQsk6ThTuWuKFaaP+8z7bZ
	k5H+X1wlJrWyA6pejiYybfIhftk8OH3NICRcXnJepBBishjJnMIlaPDZ4ivdez59j8XqvX
	bGeFdc0BA+IfugKKs4JqUq//a++CFCXCZKY5FtgYfZMGnVp/N/KrkQMuYEwaDz3aq1h/B5
	KxorHkn/qdKGBIMsXQ1xGuA7sF6a6Q8jUfNx3QQiY6iGESsHxGOiaBmzjW/ICA==
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
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 2/6] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
Date: Thu, 12 Nov 2026 15:30:46 +0100
Message-ID: <20261112143050.53347-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112143050.53347-1-paul.cercueil@bootlin.com>
References: <20261112143050.53347-1-paul.cercueil@bootlin.com>
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

v3: No change
---
 drivers/spi/spi-cadence-xspi.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index a584a3c395d0..87b986a318f3 100644
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

