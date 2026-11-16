Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840583;
	b=uOXQ738O49rVi43qqD5lESKpmya7s/GX07B3LCipqu5F19dwYaWpHS4jsVbjyC0YAOo5
	 L1YOYuDmfMU5TxhYNGBaoE5WsxodUevO/b47qwtdUPvg8dCczHFi6Dwdd0vy442S4mWZR
	 8kSkOUlwdfu0RBnR3MLI8H9BGKFgNEEgGmLGQiCngTccF3rfa9OjcH1dK24x26c+MI5IS
	 3SB8eogEjCzS1wzZhxu9RBv83eG6xR8sbv/qI2qzWhA/gaFf9kjBxQY4QH1f7a2tGiKW5
	 twFGBOZcApzoh0UYDhNZ99uB4HjpWblCdr5uXWQcXl+7V9L/JsLaSQPKwMZGtzq+uLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840583;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=etV+RFlcprPmoGZ+0AEdnBPJAYs8L7Hm7FCHjf7YO8U=;
	b=mEdw30HMToOL57MTulI1FwajIyR0WcS7wPDzghtqyVr5AWVLPqmpLds/G7vPaYxzrvdf
	 529DOp/I/+mXvswgQKrrCJtL1mOmCQ1mZgbRHa/mL9kL0CqF2QiY4FFJ41+oRz6UuhtEZ
	 bQpbou6QP6xu5AZCpmd8ZsEzxjGv/Nlhi3zy2/+ZP276ByqUAmcGCUPlVn+T/aoI1QJMf
	 rLOxCHKqeQXlKJdnXhsP97Mn0P1kXht7i+RE/UQdPSB+YfiWjFR41zBmIVNYl+JJjdmC9
	 FPmR46mwdaOxgGMfEnnyT0uVbmPYSJFvgDGLtIUp5i+QkNEsYejzNzXqh4Iehu5u3MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DKPYvOpB;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167A606A33B;
	Mon, 16 Nov 2026 14:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9167A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DKPYvOpB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 76A981A1699;
	Mon, 16 Nov 2026 14:49:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D8E86023F;
	Mon, 16 Nov 2026 14:49:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3361E11BC1097;
	Mon, 16 Nov 2026 15:49:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840580; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=etV+RFlcprPmoGZ+0AEdnBPJAYs8L7Hm7FCHjf7YO8U=;
	b=DKPYvOpBXOQtfktgRYlO3K7T+JkStULarCLWff5BlsTG0CDX8JX5yWSzto3wNt4KlvscVr
	OGSEFKSLXalsh0tZLnLc1myREz5jCPFE8mADKRwRfJJF1NqtxwLljGkvm4/3ya6QsyXMsl
	riSn9haGOI/3fubpBMWCImJ1e899JE418geE77yew5hEDc29O3kr24ggoZrBmQCm9TNggK
	mZiz62ZWXlFbhp7aLp90dKOA+4U3yISOXscywRnE9i9PJpLD6b7Yrb4zXAGAOiC7tpFf/N
	IgDztHrMGJrab5ewW/lurkjS1elMVtBvaZuGGs36NZv/BdFPi20qzTSg5QS7JA==
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
Subject: [PATCH v4 4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
Date: Mon, 16 Nov 2026 15:49:07 +0100
Message-ID: <20261116144910.44151-5-paul.cercueil@bootlin.com>
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

When polling for the "SDMA ready" event, once the corresponding bit is
set in the CDNS_XSPI_SDMA_TRIGGER we should reset it to zero. Otherwise,
any subsequent call to cdns_xspi_is_sdma_ready() will just return early.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

Note that Sashiko complains about it racing vs. the IRQ handler but
that's bogus. This function is never called in a code path where IRQs
are enabled at the device level.

v4: New patch.
---
 drivers/spi/spi-cadence-xspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 6c88116f8f0b..4db734b8990d 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1104,12 +1104,20 @@ static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
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

