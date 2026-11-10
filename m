Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287336;
	b=KrtVb4Wt5DmcO0gB6s7R5gqYT+qFgqf7MU5WknaUzbXHSn9hQc9I9zVTkNau0z4QUiJ7
	 XJ2ckS516Dr3vhuIyKkkC5HYPIRKQrcftj2pbNtE/R98MkveltO5MCBRxonpYZnq71uci
	 m2SYqBzmAoE9nKvzFUNB28BpR7jnTW70BKoqtd3FYfpxLQKvmbWR0lc1kYtoURQcW+F9J
	 7oB6zzsE5kppLxsLFmaCqPO1XJqPH8MKflOUl9AxHcLjYD/G8FAIGcHNBJEL30LAH8ct8
	 RWeK02nVmkjiJiiMt4+DYBMRutxBPGzOTfRosge5AdyX4py1lCEJy70/3iDMnu/1NpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287336;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hxHTN/Y48hFwlN5rSnvNwuIZVT4P5JOuc9I9IS9s0VQ=;
	b=qD5a7hVxUofBWPFdEGjwqiGsBKc27N5XeCO0CF1vZALLPX7UxjNpF8c2Q9T1SfkqMlQL
	 DxFARXwW2Zu96AIg3qrem0Oqq/NdZlO2QzvAkb3Uii3ahyMTOafEnbr2AWWvTYo7Pbtlf
	 B1QrMKFSvlfJdL3TMuBnvggMOpO+XL6yuhh896osLvcKL2Uhj8IxDAH1TtYgB4xtUVKya
	 GUUOGLMJ2NUnUEq7p2uitZpW28N9L4EwHL1HLHGilyXU6+Y7HH20MlG9OlhkTiT67MlDo
	 hR6Jqi9pL2tyf4NfH9S9rTgGK4AGxINVHg+d77ybdQ20pffJLid+X32hECEj63XMbBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfG7PizN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8216606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfG7PizN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2E1F008A2;
	Tue, 10 Nov 2026 05:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287335;
	bh=hxHTN/Y48hFwlN5rSnvNwuIZVT4P5JOuc9I9IS9s0VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PfG7PizNkgValtf2l2yoBGU8lfNfUREG+gfC0/3vbj42IpB5QQHdvAsKmeBHrHS05
	 OkbW47yN74YF5lUh0xOJKbKazfKxgt4NrzitEYwytWPl4UbIyf1PGWon1FY78GmTtj
	 4MqizLfLDtrhjP4cvYQw0RkdYr2cJm3eu95YwfM4IEnOFVs+CXre+NsUEUOd4Lb2Bm
	 4rfgcF/wwB43/ZJGkPZ1Md/XBuvKnq3n3d97I6CWglFmLZ54pty/Esc9x8vQFfMuYf
	 BFDiZBvYol0LIsVR6bxxOu+JLFu4UQeROuPPMUGG7KNOSBD1jnn/ca7wEkVO7xPNQH
	 1f4IbMWjPvyxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: microchip-isc: fix WB offset and gain register field masking
Date: Tue, 10 Nov 2026 00:08:53 -0500
Message-ID: <20261110050828.416310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055814-failed-5.15-6e9eaa3b9387@kernel.org>
References: <20261107055814-failed-5.15-6e9eaa3b9387@kernel.org>
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

From: Balakrishnan Sambath <balakrishnan.s@microchip.com>

[ Upstream commit 6e9eaa3b93870e4edac1bd2539fe113c24663eaf ]

ISC_WB_O_* and ISC_WB_G_* each pack two 13-bit fields. A negative offset
sign-extends and corrupts the adjacent field. Add masks for the two
fields and write them with FIELD_PREP(), which masks each value into its
field, so sign extension can no longer bleed across.

Fixes: 73c1a577b839 ("media: atmel: atmel-isc: reworked white balance feature")
Cc: stable@vger.kernel.org
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adapted to older driver filenames with an explicit bitfield header include for FIELD_PREP(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 17 +++++++++--------
 drivers/media/platform/atmel/atmel-isc-regs.h |  6 ++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index eeaf91d80acd7..c856891adf99e 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -9,6 +9,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
@@ -75,17 +76,17 @@ static inline void isc_update_awb_ctrls(struct isc_device *isc)
 	/* In here we set our actual hw pipeline config */
 
 	regmap_write(isc->regmap, ISC_WB_O_RGR,
-		     ((ctrls->offset[ISC_HIS_CFG_MODE_R])) |
-		     ((ctrls->offset[ISC_HIS_CFG_MODE_GR]) << 16));
+		     FIELD_PREP(ISC_WB_O_LO, ctrls->offset[ISC_HIS_CFG_MODE_R]) |
+		     FIELD_PREP(ISC_WB_O_HI, ctrls->offset[ISC_HIS_CFG_MODE_GR]));
 	regmap_write(isc->regmap, ISC_WB_O_BGB,
-		     ((ctrls->offset[ISC_HIS_CFG_MODE_B])) |
-		     ((ctrls->offset[ISC_HIS_CFG_MODE_GB]) << 16));
+		     FIELD_PREP(ISC_WB_O_LO, ctrls->offset[ISC_HIS_CFG_MODE_B]) |
+		     FIELD_PREP(ISC_WB_O_HI, ctrls->offset[ISC_HIS_CFG_MODE_GB]));
 	regmap_write(isc->regmap, ISC_WB_G_RGR,
-		     ctrls->gain[ISC_HIS_CFG_MODE_R] |
-		     (ctrls->gain[ISC_HIS_CFG_MODE_GR] << 16));
+		     FIELD_PREP(ISC_WB_G_LO, ctrls->gain[ISC_HIS_CFG_MODE_R]) |
+		     FIELD_PREP(ISC_WB_G_HI, ctrls->gain[ISC_HIS_CFG_MODE_GR]));
 	regmap_write(isc->regmap, ISC_WB_G_BGB,
-		     ctrls->gain[ISC_HIS_CFG_MODE_B] |
-		     (ctrls->gain[ISC_HIS_CFG_MODE_GB] << 16));
+		     FIELD_PREP(ISC_WB_G_LO, ctrls->gain[ISC_HIS_CFG_MODE_B]) |
+		     FIELD_PREP(ISC_WB_G_HI, ctrls->gain[ISC_HIS_CFG_MODE_GB]));
 }
 
 static inline void isc_reset_awb_ctrls(struct isc_device *isc)
diff --git a/drivers/media/platform/atmel/atmel-isc-regs.h b/drivers/media/platform/atmel/atmel-isc-regs.h
index d06b72228d4fa..bac10cd653982 100644
--- a/drivers/media/platform/atmel/atmel-isc-regs.h
+++ b/drivers/media/platform/atmel/atmel-isc-regs.h
@@ -149,6 +149,12 @@
 /* ISC White Balance Gain for B, GB Register */
 #define ISC_WB_G_BGB	0x0000006c
 
+/* Each WB offset/gain register packs two 13-bit fields, low and high */
+#define ISC_WB_O_LO	GENMASK(12, 0)	/* R or B  offset [12:0]  */
+#define ISC_WB_O_HI	GENMASK(28, 16)	/* GR or GB offset [28:16] */
+#define ISC_WB_G_LO	GENMASK(12, 0)	/* R or B  gain [12:0]  */
+#define ISC_WB_G_HI	GENMASK(28, 16)	/* GR or GB gain [28:16] */
+
 /* ISC Color Filter Array Control Register */
 #define ISC_CFA_CTRL    0x00000070
 
-- 
2.53.0

