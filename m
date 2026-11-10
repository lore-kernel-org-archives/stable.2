Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285396;
	b=RTeWOC/MZw6pfH0WWMoPZ4mn9YpdZvHnoGpSLIhiNExUNxnDoQzRTLUjimgUmTNn5pXc
	 pZmXHhpN78qOadOcNEV7V5ptKuIfj6qiPFLWUItaLjgunkbsnp/IUgDdxBi4UPCiRMRsj
	 oiGcfroGL3Ru4VegE9ntM/0dGk3OW40JpyC59OahNEl4qxO8/gdiNiNj0Z34PP9r0g4yn
	 VVRXRS70utbPCbDjmvnxZ1ndw0p31lRiolAyH+CjitvhEu6ryDiL8YVbbxOwUzB0Z1efE
	 tj8uXdAtfDlzgfPpzJrINDDVxgfEOry6+NbFKPLtJBnzotiblGV2Y3WL0zE29IhEXZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285396;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A9nyA7lF/10eaorTCvN0dBKzramLIb3O9pk1Tkzv8jg=;
	b=p0D9Kn5Rv1NO4Hgaijx9Xq+rnlevvjRmpy3OlhZD22OOge8MkwrPwWySTF3VNzRzwCG9
	 SlqRsELDxOjMofuW92CX2B2x2Rx7qa6JZJKNw6zuTT5xzPKHF4zFKhXmZrJDoHJ3n2kUE
	 XbZjOZOhrKBh/wBRoHwnFVPRy+HbvL+NiKsKrWN7pTr66BVmJ4sL8UqiaEoL0vE67vTjB
	 xTC81135dubxB1NAlgRU+MBZ2sOQqawEEOBAq09ETFjyDgwMiuNr6rNAE/ibcRVm4YERY
	 cJybivtmHc3kWZxTaOXUTi8X2j1o/Y6cPLcfxNyRYej/jjLtHnawm6H8awbdjsbaL0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7YrYyCf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D3606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7YrYyCf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624B61F008A1;
	Tue, 10 Nov 2026 04:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285396;
	bh=A9nyA7lF/10eaorTCvN0dBKzramLIb3O9pk1Tkzv8jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f7YrYyCfRJ1QwfU3HMfGCFTSxfWre6qSXtESOEU6x2JMV/spwvAye3bbMEIbBfG81
	 ibEG7b4ROcdFniF77pHVy7g9Qu0KnstCMaJ+pIqfXzMX1WK06ZGJnbGvBILizDn6tK
	 wYEqP8wVbzGBBkEJpDIQwiome5SeCThQjNVwKu9a0CFpUwJwfYbFOQydAtYoDduKs7
	 3coWklV6UOYjnWGDyux7ODNqhbWtbudEz8AilP8ZmE8tzJAOmP1853dMd3o1ucHOME
	 GuqdN1XCArLh3ITJ0MZlyXCd1rOTdHlApEYFHctxMJ5F3HjWAcCRL3NOVSKhaILbWl
	 lqrGTABxgftsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] media: microchip-isc: fix WB offset and gain register field masking
Date: Mon,  9 Nov 2026 23:36:33 -0500
Message-ID: <20261110043626.355449-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110043626.355449-1-sashal@kernel.org>
References: <20261107052851-failed-6.6-6e9eaa3b9387@kernel.org>
 <20261110043626.355449-1-sashal@kernel.org>
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
index 8a1ebb1a74e00..1131e91546e2a 100644
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

