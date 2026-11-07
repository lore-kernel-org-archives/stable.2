Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045993;
	b=A3KmdX/+LH3dYPnEw2bQ5WlQxu8pe4RcAV/ALlbmzJ1GFi7IRx7foQFbqSpQY92RpvVg
	 pASLB2mZOs1+1T4T+xpwVZIAMVr1LWhkZcfSgVoOTKwsgBWVd5OB+4jbbdVZQaO64Ktrm
	 bPgbIbI/1eHCoRAGnBNkVcSe0NN23HxeQKD4Zn8l0M8Rl7l0IytWBCf9J/rfUiI7qNA9E
	 2D5jcw0uC2ukeYwQiHp7+vZ7dqRK1eI2ajuNfL3f35nziIiYnZbPJ2JYqFN4cmZbSOLIK
	 9VcxHZo1yEbmK72dLrrQIgcmG0xIsj5uEZt5KoR/86Hd3uebJn+UjDS0xrAeJkba9jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UOXoXpUiJG/wrSNbUFJCNCa36ry0dXz+yq4Js9ZD1Ec=;
	b=ZkuUDqbYcFDgP3LLpyS76WkKfHjVUog2gJUKBk1q4KSb4Jijhe4AivjKl7NxoD8rcCcx
	 okoOBNhOpVTXqNh6ES9ZU73DxOWAOiFhBbXgc6AcBzKIszEZ9H/ZUsMatte/65odPc1za
	 TTh/GOnOY6s5NW/Gs5wSlauLFTyOG/3NQIfz3heLfSWGnkIvW40iDSNTtIJ9eO14j1dd7
	 y3SmiRuVoDa+sGaEISbetYtRN0MAAyE90EguuUpG8ieHOQ6+uSai4DL59oO/YB9sX9NL1
	 zgST7L4eHEWcujCsVussFoq9S08ZmdkcgMx3H/ESHQqOr6qE1w/6r+yIvRYNquZ6FrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEufVwMI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEufVwMI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521691F0089F;
	Sat,  7 Nov 2026 10:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045992;
	bh=UOXoXpUiJG/wrSNbUFJCNCa36ry0dXz+yq4Js9ZD1Ec=;
	h=From:To:Cc:Subject:Date;
	b=FEufVwMIlhpnqUCb/1yLvX8qXeF06hLd21TjP1Rsk8GBMhMF6XU/8+3CDwO86rD+2
	 mjaYIs3IMIKYKM4FYmRVhXl0DsFTRpe+VwGKIEXWzNAz2DF4EFJXLawwh0fw0BSb+V
	 jLHDdxgfP09QtvryieXvDd1GA3Egvtmmola2jFDinWwFk11Rxh+Vu3CQi5luRPSsKr
	 /+7GXSC3Dj8SN9+JlUHMkUBj/l6ua2crBljpxSvVtzuGPSNgabgEi0NVdxkIFVrR0c
	 VyF7+vbFZ2YnntxLvCWKyHSVkqjttBlHTrk7oMEJzNz19+7N52xOOpgqJy5NqLyc6N
	 vBvK8zaDT1idg==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix WB offset and gain register field masking" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:31 -0500
Message-ID: <20261107050631-failed-6.18-6e9eaa3b9387@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6e9eaa3b93870e4edac1bd2539fe113c24663eaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050631-failed-6.18-6e9eaa3b9387@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6e9eaa3b93870e4edac1bd2539fe113c24663eaf Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:07 +0530
Subject: [PATCH] media: microchip-isc: fix WB offset and gain register field
 masking

ISC_WB_O_* and ISC_WB_G_* each pack two 13-bit fields. A negative offset
sign-extends and corrupts the adjacent field. Add masks for the two
fields and write them with FIELD_PREP(), which masks each value into its
field, so sign extension can no longer bleed across.

Fixes: 73c1a577b839 ("media: atmel: atmel-isc: reworked white balance feature")
Cc: stable@vger.kernel.org
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
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
index 9ddbbb6dd68bf..fe145b142b826 100644
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




