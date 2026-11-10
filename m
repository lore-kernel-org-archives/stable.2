Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287949;
	b=f2j8PQS43yRWGIF8xd6ZRMHFZDuxcV0VYnnQJmSZPdcBAHHm1h814W7/1MR8sEeOAaB8
	 FvrdYBT1QdtJve+lZ+f4JyPk2vQNjrgBQfK8uR5D1cO7t1kWELvMNe70uPBZGvZ7dyyfm
	 DltnWadhQO6a/slCGpFKBP5e0b4XQiE1glLOWCPmQjDfi9Y5CulnIBs3WbxwjnUeDxMTk
	 69cR9jgs/rd7He12TGsWROJ8wjJ4w4+UJah/KJzmiUHYRmI6BMWqxNR2YRQG9BYxeSCxV
	 rFm+01yGaNZl+ev5zdfUxAN+3MLi3EXUQABsQW8q678hTWyp6x4X12Mgbq1CiABlUKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287949;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8rPwYGkz1Q/YAAxHYnSFmnxUiDC1muv9pzkJ6N3A+/Q=;
	b=5r12v0TZYrGN3h1LGrdVn/MrfeWcjq4Je90Asd9E+k79RcAmYNX85zQJsicErtgGHMYz
	 +XXsuwPO5vSdRQzMtKwtpId0FR8kssE1pTERWjvuJVpQiHB+74SEr0koj02VVM2uqGGZ+
	 31Cr7A43m+D809NK+6+yzOu0waAfvmm3wsoj5L8J71YC3wGQQJgJgtaujajA/HmeRYvry
	 q5N+pICktXTpKuXkrIrSAJiDgENmSh9TzXBl/dDorXdmTUGGqCsQZWW4oFLtDXkZTZqN6
	 u8YkET5txdexJzGrvM+AoK1k1FIyCLe/8Dpaal3W7rADeyU7bgXxauIm4I6+Z4GUcYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rz6mInbP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C40606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rz6mInbP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D321F0089F;
	Tue, 10 Nov 2026 05:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287948;
	bh=8rPwYGkz1Q/YAAxHYnSFmnxUiDC1muv9pzkJ6N3A+/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rz6mInbPCHyW9oUBW4ZlIGGVfHy8ujhKlKTzM0tAoW0VdUQaX8pjpUZRshFqRMK3j
	 VlafQXUj/xMfs0tGfpyVlhJ35ezV0KafRVJNjYyCiWhejc3WkF5XMoNeN2BGj6ZrYr
	 yMuBwfaAVKR3/59SdIWznEwQxnIINhXBYVP2sUl6w5qs2pqZlvCeYnNUf8DI5BX24y
	 iODOd3rt8O5yJogYeeZ1B+k8TSRPw5+/92T8VtDoyfGqcGKcIqJGcmWs0wwGOJIAb0
	 Ddyq2DMMjkVSEy9o41MxhjPAfSc3CjRzx0IUKCnaZMnUEsG/PG698+YW/Sce2PJdKS
	 jBf82kCeRY5qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: microchip-isc: fix WB offset and gain register field masking
Date: Tue, 10 Nov 2026 00:19:07 -0500
Message-ID: <20261110051849.439481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061502-failed-5.10-6e9eaa3b9387@kernel.org>
References: <20261107061502-failed-5.10-6e9eaa3b9387@kernel.org>
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
[ sashal: Adapted to the older Atmel ISC driver naming and added the missing bitfield header include for FIELD_PREP(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 17 +++++++++--------
 drivers/media/platform/atmel/atmel-isc-regs.h |  6 ++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index fe3ec8d0eaee3..a05716e0e6c2c 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -9,6 +9,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
@@ -248,17 +249,17 @@ static inline void isc_update_awb_ctrls(struct isc_device *isc)
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
index f1e160ed43512..f9d3dea3fd50f 100644
--- a/drivers/media/platform/atmel/atmel-isc-regs.h
+++ b/drivers/media/platform/atmel/atmel-isc-regs.h
@@ -108,6 +108,12 @@
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

