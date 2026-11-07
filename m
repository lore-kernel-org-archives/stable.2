Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050104;
	b=hIAXs/ZczUbUMaB852rT8uTj8shbN+8jnjB//EUKa3Q0YBwg/5p7CLPdR9zr+LhkFVzC
	 YH2mzFZh7Bfjm0q75VfiVvGhKx0Gz3OMt24Y4V9xmDBIy58PzDVUzJzZxgV2dYjPNjOGy
	 p9yYM5gqrxeSrj27+gsRjBmhslO18ZtxcMeC8DLGLg8jUo9lm6iU0XoITH2+NzsuxeP8e
	 APDmAkszGOgrd3QTz27IO2vVTLEWy8FAT63uNajGPCIIz/+42yViBolvlXYmZO847toGj
	 v+HMLoPwETWSufH7FU20ANCifxb7EfquqS8QhlVlGg40NwISlp+hnr6Kn/bLWpaqF+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050104;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ip7XOAhztsHAKsvuYsBGf6iI3LqmxGOLB27R94bP2qc=;
	b=JrUkaUSqJvEe+3LRlZCvG3Fyh5t/XvANNVZP9hnYEIXZmG3SUIn8kiD6iXFtGmAfNuo9
	 SqGmhW+2v36HDZ9VWXPFrHVaP9qeG2zIaSQarXUy0eQd+T34pmVZ9/B8pqFNIzX0O9IFE
	 qtfsrg8wTwrvMGabt5kDI65xy7dz78SgBKIIsIDvoIr8v2OMFxx9OLLV8W5jELZtwDKSf
	 C470HcRoZWAeszuXXnM4braSg0XndTuyxD11G/0fM2n8PF6+SAnvhYl9t8HAq6oFwc2aP
	 kGhM9vFQNXXPspBeN5zk8A4noA7L37XTshmEMLoaYQKCXN4EySOZTGpJza7ENCEovKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knQK5+Vd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knQK5+Vd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7761F0089F;
	Sat,  7 Nov 2026 11:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050104;
	bh=Ip7XOAhztsHAKsvuYsBGf6iI3LqmxGOLB27R94bP2qc=;
	h=From:To:Cc:Subject:Date;
	b=knQK5+VdjBj5VX94lgM9O9hCLIlhN2UP6aU/mZ4bwjCbU3y9nng2oyZg/UHa6cO1K
	 5QDZq5py1FHDmw6wqnWPOfanF3UE4yIWqO1h1VVSvrZkpDU3OkHeoBJ0K7tXjv8IMu
	 2RMfhRfxUYwfHXjS3A0wP2/UQOENPGajtMaVImhTpRNjhFrrjptMfPg6slY6HM8jbb
	 X8W/VEUuaNix5luBT/PJHrP2ZgN35viBu0AFbBGoB578AYVZ0v69/La/0nGRHIc6WV
	 L+b8SeNt/etO1iKINQz0EPDEUO/Wkwp2NgPE43FpRCHJWeyHqslm4rsgEY1U4d4XGz
	 y7ogNq4pLxP1g==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix WB offset and gain register field masking" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:02 -0500
Message-ID: <20261107061502-failed-5.10-6e9eaa3b9387@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6e9eaa3b93870e4edac1bd2539fe113c24663eaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061502-failed-5.10-6e9eaa3b9387@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




