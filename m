Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5B55C339;
	Wed, 14 Oct 2026 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992671; cv=none; b=tfOwTqvfNIwwcMdD/iHpgadQTaETcCR1ictwcgnFicZlJNw2J7y23q/Gz07vd+qXP4XdNFsIDqkrac2k2BJwdXCUQNsz+mMMyyi6I7J35waRqzR2YOztWbBtFEfB89ItxphTMneXaQ2ieTmIX1rJAim3SE8GayHkxXfJjgeTsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992671; c=relaxed/simple;
	bh=XBqmpRnePSKi6pL7Pxm4mvK8Q86lgvyAFwGvk8EQJMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOpaaqdqwDaqVSgn+OoOoBHJ1T4OHi29TcHufJ1YlTGtRkXx+zQZRqBg907DQtVhCOgBDMhHKwX4uRpFY+elOAckh3wiwpghrVqXME39hK7B1P4buXTr5jf8JAQQN7j81wjyBgZG2CH9xAp7VlW1JxL11VIaTG6oFPzUi8OZhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M2b5N9s8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M2b5N9s8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 48D494E411FA;
	Wed, 14 Oct 2026 15:44:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1D95060368;
	Wed, 14 Oct 2026 15:44:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C326410328540;
	Wed, 14 Oct 2026 17:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791992658; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=zgfztfOJ6l8wxkOS8Fa5/mop0OdmxA0oYDEDAChq13Q=;
	b=M2b5N9s8Qvfcv7PqrIOgEFUvM+FfX7QmRjwehcxPoYt/yhtlxRLvHkawbjQIJTg4zFf10m
	qXurF++mQXdpTgNWwEEVC7wWwxhvnbztbls49jMC+BvJV0knJLmZzHMndiaJ0TlO0gdqAb
	JMHJMrFn3fFNztSkN8JQWp27JyxTvMO7oXIgavraMPrH1KRmG4+bvwJSb3ZkTR5ScFkCJq
	1etSsz+YFs21hP2/pQ3c+ztiu2yfsjY4zKpeJSRAt3eAiHrWq9E9+gsN0Yg4y81qtDpn01
	ISdGItkbRtqmaysjWEK/dxm/VcihGRgfDNf5EUC620VBKCWD0Qt2licGnJVQ7Q==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
Date: Wed, 14 Oct 2026 17:42:58 +0200
Message-ID: <20261014154301.157755-5-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014154301.157755-1-paul.cercueil@bootlin.com>
References: <20261014154301.157755-1-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

When polling for the "SDMA ready" event, once the corresponding bit is
set in the CDNS_XSPI_SDMA_TRIGGER we should reset it to zero. Otherwise,
any subsequent call to cdns_xspi_is_sdma_ready() will just return early.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---

Notes:
    v2: New patch
    
    v3: No change

 drivers/spi/spi-cadence-xspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 39c868a5b171..095bf640b379 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1068,12 +1068,20 @@ static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
 {
 	u32 ctrl_stat;
 
-	return !readl_relaxed_poll_timeout
-		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
-		ctrl_stat,
-		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
-		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
-		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+	if (readl_relaxed_poll_timeout
+	    (cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+	     ctrl_stat,
+	     (ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
+	     sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
+	     sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0)) {
+		return false;
+	}
+
+	/* Clear the flag */
+	writel(CDNS_XSPI_SDMA_TRIGGER,
+	       cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
+	return true;
 }
 
 static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
-- 
2.47.3

