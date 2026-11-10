Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286454;
	b=NJ+udI9kXtDhX+WBOeFdOLPWis0d946nTpwDEd008BEQgMxz+btabe82/ilStGoVegjm
	 Tt8ly7e57G5RFvF4oDEb43aGYKTuB1Xs1ykPn4/c8C6TCfmtz7C/kYlaPZYA7zuCcSgB6
	 lweRjw2Y9hNHhUr9pu4L8SpPgKYdolMkFYErXr2oc7ujhMAYe9+BBxWaqsyGqWOcgn0Rx
	 8JtfEp7FvmsR8hI+wH+CxynpW3RQM0ZB+4DNKoRF/P9dwRRyqtg5xpEgzUlCcJR8vShoi
	 JPZVyn4ZnWVGe2ia5ANX5B0wEA+aq5AO8qUtfhOclgJfuvGQYQw9iFZzWrkozbW/QUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hFNnZIFlFtvFCvZ2cIiwAPtJ7HrZdmvFZJPDUPM3j3g=;
	b=dQRfNk4tFb08LzGCGDs48oOura3wU/owg6obPcZ5MoS5JsuuLxKzTzcsR6UItsa3BOvy
	 FqmRagLpvU9BRb92aj2xcKXuBOmAvdYT1HmdtyPU8aRX/+LoSTmhQXbhexE7FnySPIfwN
	 Th7db1O8UalVYsjU8hsa7J+Oi9+8TNIALjk6Nu3wWJ/u1QgGdHUtAqosVKxTWn30li6AU
	 DgPBSYqsihv4/RWf+mphHUOXaQTKMWXUPL8KVe+5wobXdnwo9VcN+u2vjsrEBAivu0VzE
	 qL+cH0kyi5r/ceaDB92eXM88RVDzZ5BEmkFZX3T03XyTqEaFx3ztVkz0pPsKNXhP6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyamz4Nf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyamz4Nf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12231F0089F;
	Tue, 10 Nov 2026 04:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286454;
	bh=hFNnZIFlFtvFCvZ2cIiwAPtJ7HrZdmvFZJPDUPM3j3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iyamz4NfJZQ2ZlIArqGmQODwjNCIYmbqNOgNUD48JDitvOrIYOYpuj2lSsCAtxvoT
	 3UM6To8UsRMXQXf3oFkiOyoKSVVdGLA19VRWB5D9fItq2FNn8QYsgHU7z92lc86Faq
	 x6s6Vey3hL6BS8Y6QC4/h9PpWirzTxKQ3eaSb5Y2LdoDVRiFFLMNWpKu3Bjluqy+wH
	 FkPPlN+KYz1ufmPZpolqso3wu0Yg6ZVOloiaqgO9lvRqgM4d7yXeT9oNgJE9LsLNrC
	 KecT4ktJJ0TOUHpSun2GjYHm+K7VSzGJ00SQorQrEi1NO/pxnTq5S+Obf8Zxyqn6uj
	 GbS7BZbInqf9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: microchip-isc: fix WB offset and gain register field masking
Date: Mon,  9 Nov 2026 23:54:12 -0500
Message-ID: <20261110045354.388226-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054131-failed-6.1-6e9eaa3b9387@kernel.org>
References: <20261107054131-failed-6.1-6e9eaa3b9387@kernel.org>
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
[ sashal: Adapted hunks to the older driver filenames and added the missing header include for FIELD_PREP(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 17 +++++++++--------
 drivers/media/platform/atmel/atmel-isc-regs.h |  6 ++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 9e91e4d948a24..a73279adbd175 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -8,6 +8,7 @@
  * Author: Eugen Hristev <eugen.hristev@microchip.com>
  *
  */
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/math64.h>
@@ -71,17 +72,17 @@ static inline void isc_update_awb_ctrls(struct isc_device *isc)
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

