Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049098;
	b=1LSYeOVZnFOQBqxSBUJnSKW8U4y8HEkNBekJUVX07DdtXplSV1FqsKOfimAFFw3jvs1s
	 73x+353RCvgaihfylhIs+QjByTD5u32m9P3/6wYRotXBloFx+/YLMStMUia1aEG0+8SVY
	 /gbkznrnVVdkqlQ1WQHvLMwFHc5Uftx9JkojLjJ28cFnlq+lLraChaIBGeCrXXvhsWTyq
	 JTs5ZFsAZDKJqU0Je9ncLa+wiU4PVngPbXxtCR1WZi3D2n3EqczsilnE6DP4umwqWYuz2
	 IWtTfeIKEm335IBMIp34KLhzH2QTbr/qsqpYG+2tb/5gqvhmBJ3uS/bAXJQKwKl6gCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZzefYa533xHrIRbvoJ0Zap2cCEuyQ4mMXJr7NI9JdRw=;
	b=ptU/DteSiH8QoG2T8WGn4MSTka4unzLeoZegY9Ws1j/UZJQcAhA6l1Tw8Uf7zpMncMwW
	 cbUA415LP0SvohLALQGhYkSp2hq8KB7u41HsXXzdwmELv+6fE4sfVurGdC63yIvd5uP1K
	 Fv9IsH9qN2HKb5qoNbQhyDKWV10E3gztXvhKd4wWBtQRcxdph57KoM4dPe8daJdEQ0+UT
	 I+TWWmP21mE9bg0m0L2F/Zim+u2lYzLlbyOpAqwKhSAS2ES6P7e5NiendvtheGY2ofwws
	 r+7UXwTUTMTnNZJuiBDlRJNwQdRNT7qOUjOjS3x1nFY6YFIuHQ4RR5fzv0tHMRxlo9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nU1Ea9i7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9EE606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nU1Ea9i7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164061F0089F;
	Sat,  7 Nov 2026 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049096;
	bh=ZzefYa533xHrIRbvoJ0Zap2cCEuyQ4mMXJr7NI9JdRw=;
	h=From:To:Cc:Subject:Date;
	b=nU1Ea9i7xsxgQcKdh3dGBg0uk1yPG8a3tjG2ohjI2gZr10i96I6tOfvSQQONUNL6F
	 XEXI4EYw6Gn9FVrAnpixnJ8qNln1BQuf0jgFmT7W356tPXTjvYlEsjPy1OGYPdusK/
	 +B5b6ZwS300DKqnL+Wspb5yDwDAFpZeGmbpIqt6gsrZUPrgzbbZj03t4sdv90wndn6
	 b+Xwn/yCS0bv5C84Fhh2f0uoBBFuBKp1bE7zzvff0PQfHMeWhd7rHn18PMcREr2Klc
	 W/5EI3e9ULLqK5APTD2buZ/qTg6GIGWNvHX0PIs5bqDhPdOVSmMPSVu6+XRgfxg0SH
	 L7cmowuYm5rkw==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix WB offset and gain register field masking" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:14 -0500
Message-ID: <20261107055814-failed-5.15-6e9eaa3b9387@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6e9eaa3b93870e4edac1bd2539fe113c24663eaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055814-failed-5.15-6e9eaa3b9387@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




