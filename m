Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284673;
	b=yOvFR5txPDt18uDWh0+F/oI79Rex6HIkQaqryGRvcKs6B4KX+tzhUaYEsHD/b4ix+uMq
	 jxpNvWzQy0fPtysCnD++VLb+9z4DobTM7Ykm7tGefmqfsQUbktAZtzpcwsWaAONzvMeto
	 idPzFKZztDwL5mQHapcRjmLlzmwlHLAopbl4PGC1qf0QhabtwBIwbZn9/+ZQx3l80CUV3
	 PpPQY7fF0Arvb00x+LyG7DMw8A8hmfDpOHIetySXgHhkF/OsyHzvgPGwoMdNdWj0M59Id
	 e2cMSvrlctc1cDBfZpavIclFsPWihXE2QAw0SZxi4SYsIevRQKL3ugn1lIvXjJ98fMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tgbsKrhhrDnE0Ue4r4dP2phZ5YuEY9qBYQwgPdsXf4w=;
	b=dnom9exXtbu6f/qT9qEYDkA8RM4RJZL391DN6TVwwoWfSUOOuNQB7v4TIfhgTgHZ6dNm
	 KheCNaoenLUlE5zEsx6+C8ASGWYnytxvvQf2ycZ7zX3LZdaq93F5lPPywV6ljS+NR7Uog
	 VIqLYtlmrJXY9LPZUT5gpE94qSlCb02jUNDf55unHrO/YDBuxKV+SKzdjKT07qIj/dud2
	 lUYwG12jsXG5pvV5yqEfstcd8QOU1fsOzHyllvkUy8FqWV0wZZslTMhf62qQvxppIZEmd
	 50bVmHquh5avH3SprF+xyPlCalbVFztDr8pwXN5KF70hDnSSKD5H/WqyaKPZHchb+IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XOx9bH/o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8C606DE68
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOx9bH/o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F43C1F008A2;
	Tue, 10 Nov 2026 04:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284673;
	bh=tgbsKrhhrDnE0Ue4r4dP2phZ5YuEY9qBYQwgPdsXf4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XOx9bH/oky1jwNWwV72AVTxlLBdRdzHYVwQK50ZbaK1Kw+krZIpLhDpcF3fZu+a+e
	 lfIaSQai3IKSZ+MTJXMyYxPyXfLYBSxJaXXj/fyX1V+EVIK1iosj4Qp3r6UDu4zHFn
	 1QH1PZ3Ssx0N0HFNoMVVsFEbyHCI+taErqeEoSp3CC/IXzp0FI3WAjaXh8ZBouCHj6
	 zkpgk39KXQyroG/uMYS5d7L3HjUEbUyGMMdWXA763oOVGazLtLUQFzCc0F/HXx5RzA
	 vXNQC8CE6QFEwxbC6O4vdhg2tb0MNBTMqY57QdHA3xfMRGQlgpQZAMXQfdHsMoFuvm
	 KCMsMZB/qSwig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] media: microchip-isc: fix WB offset and gain register field masking
Date: Mon,  9 Nov 2026 23:24:30 -0500
Message-ID: <20261110042424.316772-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110042424.316772-1-sashal@kernel.org>
References: <20261107050303-failed-7.3-6e9eaa3b9387@kernel.org>
 <20261110042424.316772-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/microchip/microchip-isc-base.c      | 16 ++++++++--------
 .../platform/microchip/microchip-isc-regs.h      |  6 ++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index e5ecf6ffd24a8..963d5fd53b589 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -63,17 +63,17 @@ static inline void isc_update_awb_ctrls(struct isc_device *isc)
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
diff --git a/drivers/media/platform/microchip/microchip-isc-regs.h b/drivers/media/platform/microchip/microchip-isc-regs.h
index 185ef0eab7ad3..cabecf128b37a 100644
--- a/drivers/media/platform/microchip/microchip-isc-regs.h
+++ b/drivers/media/platform/microchip/microchip-isc-regs.h
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

