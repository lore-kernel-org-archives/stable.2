Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320353;
	b=XiV/GsyaysSeEblj6iGAHmC+Xtoc4NVZe+VBTY8y3Y8z0bbVJTek5DcPToijdLhHi7q6
	 PzThTvZnHybJaQxMRCRrxWeVNyCoxZrrggRYRHJXAeZkPXrtCo7gOb2GUH9UmtWLN0t6z
	 cVlep9/Aa76ak1t8ik8Jdv2SXSd1r++Ssppstm5yMYIPqv0isRt4k5cXAy6CJJor2IDYp
	 985gYCiIlf3Ixa4XYB45Z+Sd0mDs7etd37HyBUEiDepUYUqDJXGz5JzOkAAyjcmS8FATe
	 UQM3ewMaMlkSD39tyzx68hdW8aw2IgeEBGB6ghOaHPFtm+7djfp7HUgrK54ZbDAURTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oGsE5c6XH3HHiDeuJIrz2mZoWl6z2j++YbZoOqXqDnE=;
	b=e30T1ZMjoFB8Qjfq/lPEza97fvFKscwX/7Q4Dab9gcjlxvrydFSqD/jX5+mha1cdhNDF
	 1tq59yCe+/gqFaZPFSAPBtv2SIWzXc4RBbLRi2V5cYEDkhVAvpVBGlMdKutqgJi2wCKkP
	 +0W4u6kfXNgagqx9I5jvQnLqyNRImMXQIsZVklBuCub02uz2ZERdJSyG+uQa+386Sh0Vr
	 8eoLM8SPHlntgSMud7Le/asLrKxN9flX3S+OkdKW1vOVzLV89tCB8tf3YuDrVKCaNm+E/
	 VEyoXVRdh7ojrcCo/kbux5lMjJ8WPiiPnJaTRIth+WGM2j7dU6HxcnRHA1J0bKyfpVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUBbcUYM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0708606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUBbcUYM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F34B1F008A1;
	Tue, 10 Nov 2026 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320351;
	bh=oGsE5c6XH3HHiDeuJIrz2mZoWl6z2j++YbZoOqXqDnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUBbcUYMPPgoVpvb0YVTK5K0RroA7FQwtVX7jh0sqO+f/AbR/92t87jMRT17NI4OM
	 Kb/4fFKLQ+Tfrf1styvcdry39c+z7p2R9gWR0dq56GVIbbGFnHveavA6HiKcLMd6NF
	 uq1XRKLkv71f7cFCSR4tdXuWnQAm7NqNXm+/U5C0gfoM+bv1Dpxg9KtmavLmZZatBw
	 3G15LgqwLbViOa46uQxHreyb5Y6/sUTACynw4HD5jTGQImwruOsWuOX2T4gmL0O8ut
	 1U7b/GeYHv9H2RQalZCV0P66jrQf3DFZJ0+RiozTtbs7QhzVnJbIWCFIgRvPbC6bP+
	 xzpe2Epx5lYYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Marko <robert.marko@sartura.hr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] spi: atmel-quadspi: use init callback for gclk variants
Date: Tue, 10 Nov 2026 09:19:08 -0500
Message-ID: <20261110141901.1859701-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141901.1859701-1-sashal@kernel.org>
References: <20261107050822-failed-6.18-717e45f97246@kernel.org>
 <20261110141901.1859701-1-sashal@kernel.org>
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

From: Robert Marko <robert.marko@sartura.hr>

[ Upstream commit b881f1d8d1dfbc4480776d3b16f80261a5a68cbc ]

Assign the existing SAMA7G5 initialization routine to every generic
clock variant and dispatch initialization exclusively through the
capability callback.

This keeps hardware capabilities separate from initialization selection
and lets variants override the sequence explicitly.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Link: https://patch.msgid.link/20260709112006.390742-4-robert.marko@sartura.hr
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 717e45f97246 ("spi: atmel-quadspi: balance runtime PM and pclk across system sleep")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 6c2d3c00409bb..a917530f81741 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1159,10 +1159,7 @@ static int atmel_qspi_sama7g5_setup(struct spi_device *spi)
 	/* The controller can communicate with a single peripheral device (target). */
 	aq->target_max_speed_hz = spi->max_speed_hz;
 
-	if (aq->caps->init)
-		return aq->caps->init(aq);
-
-	return atmel_qspi_sama7g5_init(aq);
+	return aq->caps->init(aq);
 }
 
 static int atmel_qspi_setup(struct spi_device *spi)
@@ -1577,11 +1574,8 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 		return ret;
 	}
 
-	if (aq->caps->init)
-		return aq->caps->init(aq);
-
 	if (aq->caps->has_gclk)
-		return atmel_qspi_sama7g5_init(aq);
+		return aq->caps->init(aq);
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
@@ -1639,6 +1633,7 @@ static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
 
 static const struct atmel_qspi_caps atmel_sam9x7_ospi_caps = {
 	.max_speed_hz = SAM9X7_QSPI_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.octal = true,
 	.has_dma = true,
@@ -1649,6 +1644,7 @@ static const struct atmel_qspi_caps atmel_sam9x7_ospi_caps = {
 
 static const struct atmel_qspi_caps atmel_sama7d65_ospi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI0_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.octal = true,
 	.has_dma = true,
@@ -1659,6 +1655,7 @@ static const struct atmel_qspi_caps atmel_sama7d65_ospi_caps = {
 
 static const struct atmel_qspi_caps atmel_sama7d65_qspi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.has_dma = true,
 	.has_2xgclk = true,
@@ -1667,6 +1664,7 @@ static const struct atmel_qspi_caps atmel_sama7d65_qspi_caps = {
 
 static const struct atmel_qspi_caps atmel_sama7g5_ospi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI0_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.octal = true,
 	.has_dma = true,
@@ -1676,6 +1674,7 @@ static const struct atmel_qspi_caps atmel_sama7g5_ospi_caps = {
 
 static const struct atmel_qspi_caps atmel_sama7g5_qspi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.has_dma = true,
 	.has_dllon = true,
-- 
2.53.0

