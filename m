Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176006;
	b=izeRa0JdIrkymJRdTSAxDbpzAfaHWiOsbiVBUUrAuZ5EtYzCAizEQm4TUjYo3jKwsRpz
	 KhPG6C0TzADoel0DAM7NF30gJe0s+6d1K+p0FcntVTTaspuq0GVgLIdEJ8vyyHM0kbdYx
	 /ZQns9MR9FfPqALeRw/iCP4FzVgviH3aODs9oCWup0TS0iFvdn2mhzecfeEfZeG/0CLuO
	 2gN4IlAmGARsSnbD0eEN/6wrNcFcwiQ2E1zSMei9XBiLURFINcctOUjPE/fwRQ98juKjW
	 irok+hV7Gy4qcGObB8Zx5CEDywXXODeZgw7goSQg0j8aArFnVkCTr89Pv7HZlM4Q+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176006;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=TPR3502mWRHPpf/VdS/bn9dfjjeFIqqUIwLMoaTjDp4=;
	b=TjlAui5sQAoudVmOrZJMREpmtW6SHKnOwjR3EDn1gaZwLsskvZi/D0SQrgez32399pT7
	 aXw4s5/imHCDDthScq6VEGYRE1140UsQXDP9dqXSVMYkHSVUV/sSNHZ0NGE/3MSFyAT5X
	 kIsxCRGijv9voSzC6ojgj5sVFo/EkRi8l5rbN78N0qK4PjEJL0ZDLoMJcArBId68qJGmG
	 1AiHJ6Vy9BGLerhcodZoB54m8+2S47VjUOQOS7dTILMrHu/7dL2VB5FmY4iObSyuBXhEm
	 mWDBnUTSs4OMZEnhqlh42Q8pzlmYr6Wdlh9JKvLzMqNpGvoBAEBjaKdHNl57r8JfHaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sGptb0rB;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094960A261A;
	Fri, 20 Nov 2026 12:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7094960A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sGptb0rB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C9331C6221B;
	Fri, 20 Nov 2026 12:00:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 267BC6017D;
	Fri, 20 Nov 2026 12:00:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BAAE611BC003B;
	Fri, 20 Nov 2026 13:00:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795176002; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TPR3502mWRHPpf/VdS/bn9dfjjeFIqqUIwLMoaTjDp4=;
	b=sGptb0rB0179NeSzvhahBp0pmw4ar1czGBs3MicRJhoPc6rCLijJKKCkUZAf33CeRoPhFF
	VoJkg8G6y2wNHTUfst9GvnaZjfxW9gn/K++ueo3Gbsk/pgVHJ5NI4IrBge3TplkDwdvkNH
	wBiIoqYPi7TDHP5B9gkTTsRm2zZIegUA+e3IKiZPoTNBqbNpg01U1Sb9yG7Yczqw21sXcK
	uAkJL1rSl/sQ/Rc0HFWe8AVRmeRMKdQrB508ESqpuMxkMzq0i1CPwXt/8suV/ZadbcF1jv
	NBNxjuLFVvaV+4u+Oez06Zhnm0xiK+fDlW3qQo0M1Rqfz8KTwZaxVeNN26bH1w==
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
Subject: [PATCH v5 4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
Date: Fri, 20 Nov 2026 12:59:22 +0100
Message-ID: <20261120115925.173568-5-paul.cercueil@bootlin.com>
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

v5: No change.
---
 drivers/spi/spi-cadence-xspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 29a54ffa1664..7c7a604f4c62 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1235,12 +1235,20 @@ static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
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

