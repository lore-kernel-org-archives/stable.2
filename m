Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046603;
	b=MlMpCCuXmS3haHUNLXyzvk1mimpvQ3hQ1cmnvSIXHeq219dOnfRBwPP0jDI1vvU5j4OU
	 DN4hAxLSKjfmthEqdk9Hm6RmlBLewjfoNhBqYjj3XuP6+M40f4+yD59V5V49zsR0fsVPt
	 kqqBBqXO2drj6Wn1ZLMigSSo6qvgo2yIRQaZEgNb7QyhSo4JBWyi6Jg41aAsE8RZTSNfQ
	 3L/F3dxQ+m9O2RK5uv+9t2IVzR5pf96A9TZWwwjRPfPlg3hKxy4Nmagp6i7B+l4WUs4ch
	 CMmYLMV2y3vCdKJSm+fJsSwd/3Zysxun3q2cj+qvwyzQW5KOYqT/sDBZzRORbRhiJOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZUFILCuYS9JDLUsR4Z6jMQlPrEGSne42+Rz0GNYjQEs=;
	b=XPuXZjy5bQWpuPYDbO1kOKnDMHxbSoXdDKT3J+Vf3GAUEw6+gDJqnXGfbCIDwOoYl+66
	 eXZxKWPNOt4mMBBi7IAeCcRn+dneF1uioliAGBFSUoD59F8mggS/o21425JROo8FSqiRC
	 8Mhjhqb0MO7V07T7Za2VCCnBnZMBKleZldfWHU+N1hh7E3ykpYxuEM/P7VEFLBqZ4qKqc
	 +giZeEudtlzKxnTSZVQ0I9x5DjphCj+E5LF32R/Eo8kCQO7mqKO6o4lO9nyuoDmwMYeFx
	 AktrI15x0iKj+AyiZTeTz4ancROTV49DAZmTnN2zOJ1vz6YuHc1TpgbAfLVt+LGkJWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ya6XaM3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116B606EEB7
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ya6XaM3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0304D1F008A3;
	Sat,  7 Nov 2026 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046603;
	bh=ZUFILCuYS9JDLUsR4Z6jMQlPrEGSne42+Rz0GNYjQEs=;
	h=From:To:Cc:Subject:Date;
	b=Ya6XaM3MSjQiRZi4CnjXNWldtTFqpd5Ms79y2cQMD+fGm6mHtgXVqdvm1drpPEJaV
	 7l2e5AmgbnrVTZIqwLBy3LfY5gecIPAZJ/0r9Vl+zNbeIKOTAst8fDUSoDeY0P/Gl0
	 D5Nukk68I+C8rvfJtDwgSbepav26piCiDRmWB7iOtnJWsEwDBoE9GIPwbTssOdN4zm
	 vn9ALKBXXEoNQ/X2mnj/u3gia3Di0qnkjp1lhX096Zc5D2AdZoYqM2JpjU8+NMM63p
	 alzH0JJsyAe90+soAxSp7zc6042Q2cp7SXsstfpJddWYDyPJDQi3PVaOkuMOhYnWao
	 tmCQRnF5rsySw==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix WB offset and gain register field masking" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:41 -0500
Message-ID: <20261107051641-failed-6.12-6e9eaa3b9387@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6e9eaa3b93870e4edac1bd2539fe113c24663eaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051641-failed-6.12-6e9eaa3b9387@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




