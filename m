Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415995;
	b=E54j3g2S2DCAGudF+Ghku07/LGnMskT/9BThcd9KhnjZURq4qZ14NOW5nWF/Cin0tRlh
	 P2TbE5gs2QI4TtUDejgmAj6VAZ2YEBfs4lEvmi/tmnPkmM0jOGaGh7IMrWmVuQT9lQfNV
	 V8GhQK3wgE0LmmtIWA/HRoQxJTc+SeXP0S0WdhXLkUCdkyh0x7ICGo85NTjx3FIJ3ML4/
	 gBTMw8ULY5h7frjqp6QTawmM0rZjFnDx6aMfrfA+ZDsu/JEqmz5gRXDjh4rI3aubbDk5r
	 Sqv9QPNFGO41EGWLVccNywQU6Zppof4CTGUinUmMckV1Z4EqBKVb4CoogsTaiXfF8rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vtbS7qfH2H6GFDJLJybgz/6ClcPtmBwqlrSILdX6ZG0=;
	b=UlKHnIlef9wINVq1087vtPAVqzmLB/vBVxc3YqWCyPnQRgSRCVHKh2RB3Q4pD/OxeLiq
	 0qkQ4IoSTOF+aXcnavU7dg81+CCRRyMcOTW3P9WJrJ78CpsFZ0NHpNKnX1qYN2Kz42OfK
	 ukhJhcNBjmPFaksuno/+xvycVNB9beTIKcMAxSzMHNjJ5N1lc05o/hu79IO1Y5aLTtab3
	 pGaoelQfM3tNVnuN5xGFNlB3WIK6TPBc96w43XIkv1qLTJjIeAUVaOE1qPNqTK4PMgVvN
	 jiniHf7eVPy0xRt5ETUo+n2dTRt9Qt5+e3isbRuJS6DbDOtgP8DPNLVUTzKaFRSuTbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vt+LLt3l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFF606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vt+LLt3l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282021F00A06;
	Wed, 11 Nov 2026 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415994;
	bh=vtbS7qfH2H6GFDJLJybgz/6ClcPtmBwqlrSILdX6ZG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vt+LLt3lDAWMDONsVqCnoTvunzLeozCCXdM/Dav236NAdXYydwfBk8SU4uL4gM23/
	 VJk0p1z9HZEzrY2sgNieHsm6Np5dZMeiZxeiO0U1aAnErNyRA6gjNUWAeFKEFPLKLJ
	 Eq8PsUeOoxehCHA69EYtvVqVdvx2LVMIoT+1MwvxQucs/ErGsjdwmsNcwAKGOs6t2F
	 czDv54WJfHpGpm3jFarogIDguzb/6PGXpjSS16EwWwQjzQtlusv2e63VyzWPP/xWU4
	 0egzmsvF7/+Vqwp1e1F4yHbPFSjt+rxh+QaoqE+arA148d/2xIieIg0B+r3fXkCSyS
	 t+6eQvw28JVqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] spi: cadence-xspi: reject SDMA transfers larger than the requested length
Date: Wed, 11 Nov 2026 11:53:13 -0500
Message-ID: <20261111165245.3330719-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053509-failed-6.6-ea9854a169e9@kernel.org>
References: <20261107053509-failed-6.6-ea9854a169e9@kernel.org>
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
[ sashal: Replaced callback-based SDMA and interrupt dispatch with existing direct function calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index ee342501b759f..407731d20c24d 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -220,6 +220,7 @@ struct cdns_xspi_dev {
 	int irq;
 	int cur_cs;
 	unsigned int sdmasize;
+	unsigned int sdma_xfer_len;
 
 	struct completion cmd_complete;
 	struct completion auto_cmd_complete;
@@ -326,7 +327,7 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 	return 0;
 }
 
-static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
 	u8 sdma_dir;
@@ -335,6 +336,13 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
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
@@ -346,6 +354,8 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 			     cdns_xspi->out_buffer, sdma_size);
 		break;
 	}
+
+	return 0;
 }
 
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
@@ -391,6 +401,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
 		cdns_xspi->in_buffer = op->data.buf.in;
 		cdns_xspi->out_buffer = op->data.buf.out;
+		cdns_xspi->sdma_xfer_len = op->data.nbytes;
 
 		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
@@ -399,7 +410,11 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 			cdns_xspi_set_interrupts(cdns_xspi, false);
 			return -EIO;
 		}
-		cdns_xspi_sdma_handle(cdns_xspi);
+		ret = cdns_xspi_sdma_handle(cdns_xspi);
+		if (ret) {
+			cdns_xspi_set_interrupts(cdns_xspi, false);
+			return ret;
+		}
 	}
 
 	wait_for_completion(&cdns_xspi->cmd_complete);
-- 
2.53.0

