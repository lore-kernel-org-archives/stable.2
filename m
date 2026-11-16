Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840576;
	b=Xi5cug8zcMmKyvVmGLjjdqk6eUkUG+1Wuc7UrTOXRTbQsEkvTHQRRFhijeGIotUrJ8lP
	 a88VWprij0kRmVSjbySAvkocGODEAxZS07/Alg529pRTlIvDFZks4iTvifJZ2m1vNCMF2
	 yice9VBcbLMNG56p2A3N300p9l+9kVW4BHhyCvaPIWPVIcYZfaZNpAC/420SNytpBnNV/
	 Hf0skl5ixYgaSSsRdLhqI5CR5czzDB84Fu9oAbh4Wiy7ZorR63SxgFyXbaLpfU7H6y6Wu
	 94tw/gmBNa0iOJxhvy1GeFQ2pUbv1qDVbijA6XFz025fuuM/kmregnk+S87z1SlCCfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840576;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=npfZK7W8Bp9paacaxLF0kqkWMJTXuX5iG3UN6ApFE/8=;
	b=iYz6e/gp3jM16KyEDJrG5LLmkltkod1dCh/UT05dKiFEnAg4i8c2XxBIa4Vo4bPGbKEN
	 kP4SmrBw8B5/PPUgyswSZNv9zLpI+ReDtiwErvcHYceY4sYx+SOczoEO//NZ0ERfBfIyn
	 QAIL1dYBFwRn6V2XFcy3PsgZizM2Fuq9Eugy0c9oe6WeSxh47KkWmFI3vDbOzmx5BKjQ3
	 J6lwrtuHHh8fcOEKvfg7Ok941YidOwwjGOGKsp3os3SxSx3mFI6zgTQ2noBgocOV3uhLv
	 P/mzKMnUyvsZiMiT+kbz1TetHCR7Q3mLAhnmOskI81vGca+Z7BrMfjbKnkAyKHD+V7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TCkMsXsw;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E5606A335
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 780E5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TCkMsXsw
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 19A351A1699;
	Mon, 16 Nov 2026 14:49:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2E026023F;
	Mon, 16 Nov 2026 14:49:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0531A11BC05D6;
	Mon, 16 Nov 2026 15:49:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840572; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=npfZK7W8Bp9paacaxLF0kqkWMJTXuX5iG3UN6ApFE/8=;
	b=TCkMsXsw0vPqbYSF117iBfd1nPrPAXb7HjQFdYTu02WXw6zIu6rxu0WAW23tXJCXC+TiJw
	xjWbT3OrHFcuqVRhDhP0Q+7Q5ZRELMRrF+UNazUTCI8QsbZGwIQtnMiEst6GLOyVDY50CK
	A0HbnyoyY2HIVlRFvrCqlAsU0kWbCdJIUFRK6/Sg8wvCE3vtfeAclYvascIJniL5Owb9bj
	HN64+Ylw2/m+iKPPuwjmi+LC2Bfw6ZA63e77un5UUMv8N/whiZ5vwVBeF8zkIKx+tuD94D
	Strqu1TR/vOQNwiu7ZCATjvW62JOIrK29//4YPAm2fYIK9SE0hje9YLRhC0w4g==
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
Subject: [PATCH v4 1/7] spi: cadence-xspi: Properly handle errors in .transfer_one_message
Date: Mon, 16 Nov 2026 15:49:04 +0100
Message-ID: <20261116144910.44151-2-paul.cercueil@bootlin.com>
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
---
 drivers/spi/spi-cadence-xspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3687853e4ce4..442595daf7b5 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1112,6 +1112,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
+	int ret = -EIO;
 
 	/* Enable xfer state machine */
 	if (!cdns_xspi->xfer_in_progress) {
@@ -1152,7 +1153,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 							  false, cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 			} else {
 				cdns_xspi_prepare_generic(cs, txd, 1, true, cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
@@ -1161,11 +1162,11 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
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
@@ -1202,10 +1203,17 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 		cdns_xspi->xfer_in_progress = false;
 	}
 
-	m->status = 0;
+	ret = 0;
+
+out:
+	if (m->status == -EINPROGRESS)
+		m->status = ret;
+	if (ret)
+		cdns_xspi->xfer_in_progress = false;
+
 	spi_finalize_current_message(controller);
 
-	return 0;
+	return ret;
 }
 #endif
 
-- 
2.47.3

