Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284673;
	b=LS6K8+7/+438FoYwxr0Sdmw1tgd9WRzzGH7EPTPxA3szxCuRLtiCHgWX0uHgWIQb/FVu
	 DAxjytx++KZSe02V6wgNdGnS6WNJMK/b4exVi3MGMM8mTKlfZBg82NaCrPhb9Tdq5UrDE
	 BVZ5WWC5dSe+P8IYZQz6+cyqVl2uB4C8/Hf9CCXIPwdgez6eAawPD/o1m4wdWw/07O5TZ
	 sXFIUYOIQ3HbDIXcdcq3yCTcXGu2t0YU2X6f3AAVNQ5mvCHSNW/Efv07bYEMRpmP7Bzed
	 Uq2lwUGsVcl8nEvz0hcvUjP8iC2jLlWaPRQJNAANZ82hsXXyG5GnkEuKXjmbffBYc/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uYVcxGLJ5DV5Y2urrYGrKCmTWn1H1nrCzZqLOrlNpag=;
	b=HAWlEKdhgLdZBM9Y92eDfY4PSG0GIjsTILNCGo628zIrAI7HeDD7k3pxU0YKiVTgTFGn
	 57NOPyUmJ5ZoxIB59OinDdzAdmsBTCi/nJ/9yadDh8V2Scbm0E8rTFIqmbSpNeDRauobL
	 raHzzBDtPnsQspLz2M/yUzepoDZIIB4PSqCVx/wKE46DqVdmB/fFf+vEf19lzIZSxLU/7
	 bItWMWbAg7byPtDaR7L6T0oYWsI+Xeie5hUbgFUvrCCtX1B6jFpRz8h/bTMXdlJpIhdWu
	 zl8BY0f2UWTEZk6dS2LGSUVwUiIW1l8Sj+ITUsLyoGms2IsZvbP3MwNAJA/iT7RvzqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N31k9Ac3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FDE606DE68
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N31k9Ac3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB85D1F0089F;
	Tue, 10 Nov 2026 04:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284672;
	bh=uYVcxGLJ5DV5Y2urrYGrKCmTWn1H1nrCzZqLOrlNpag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N31k9Ac3ObW5LUqTio5uB0Ocaw/DSLxJ/U4aSWwKKxHr/QnP91Jm8Cuxn2VErYy06
	 kjPoen8qvjSQ0fMthxVMGYEK1FCVId5HK8Y3CBp/FxADz/8J4Mqo/GUtHsu+mJlY/I
	 wkef3+rvwHjYJM9dT1kGLjekogjEsf2zFA819gtZnZnrOK8cvxCX3BE8f1nW7nKVTa
	 fCKVamh/zwczrRTS0EqbmlZAEaAxqSh7UomW3ADdFAd5AGNeQDcfOF5L/fgZy0MRDj
	 I48dk8NMLeO2lYso3aXFFZ0RfMqMsfv4airA3JGsZKQrtHYNQWOMD1Kvxyxt64leBz
	 xwRttnwUes5ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] media: microchip-isc: store the unshifted PFE_CFG0 BPS value
Date: Mon,  9 Nov 2026 23:24:29 -0500
Message-ID: <20261110042424.316772-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050303-failed-7.3-6e9eaa3b9387@kernel.org>
References: <20261107050303-failed-7.3-6e9eaa3b9387@kernel.org>
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

[ Upstream commit 14cbe597504a04c5c49342d0566438e2b438a948 ]

pfe_cfg0_bps held a pre-shifted BPS value (ISC_PFE_CFG0_BPS_EIGHT was
0x4 << 28) ORed straight into the register. The other format selectors
like cfa_baycfg store the bare field value and position it at the write,
so this one was inconsistent.

Store the bare BPS value and apply it with FIELD_PREP() at the PFE_CFG0
write, and fix the pfe_cfg0_bps comment to match. No functional change.

Suggested-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: 6e9eaa3b9387 ("media: microchip-isc: fix WB offset and gain register field masking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-base.c |  4 +++-
 drivers/media/platform/microchip/microchip-isc-regs.h | 10 +++++-----
 drivers/media/platform/microchip/microchip-isc.h      |  4 +++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 21d108eb93c7b..e5ecf6ffd24a8 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -8,6 +8,7 @@
  * Author: Eugen Hristev <eugen.hristev@microchip.com>
  *
  */
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/math64.h>
@@ -291,7 +292,8 @@ static int isc_configure(struct isc_device *isc)
 	struct isc_subdev_entity *subdev = isc->current_subdev;
 	int ret;
 
-	pfe_cfg0 = isc->config.sd_format->pfe_cfg0_bps;
+	pfe_cfg0 = FIELD_PREP(ISC_PFE_CFG0_BPS_MASK,
+			      isc->config.sd_format->pfe_cfg0_bps);
 	pipeline = isc->config.bits_pipeline;
 
 	dcfg = isc->config.dcfg_imode | isc->dcfg;
diff --git a/drivers/media/platform/microchip/microchip-isc-regs.h b/drivers/media/platform/microchip/microchip-isc-regs.h
index e77e1d9a1db87..185ef0eab7ad3 100644
--- a/drivers/media/platform/microchip/microchip-isc-regs.h
+++ b/drivers/media/platform/microchip/microchip-isc-regs.h
@@ -31,11 +31,11 @@
 #define ISC_PFE_CFG0_MODE_PROGRESSIVE   (0x0 << 4)
 #define ISC_PFE_CFG0_MODE_MASK          GENMASK(6, 4)
 
-#define ISC_PFE_CFG0_BPS_EIGHT  (0x4 << 28)
-#define ISC_PFG_CFG0_BPS_NINE   (0x3 << 28)
-#define ISC_PFG_CFG0_BPS_TEN    (0x2 << 28)
-#define ISC_PFG_CFG0_BPS_ELEVEN (0x1 << 28)
-#define ISC_PFG_CFG0_BPS_TWELVE (0x0 << 28)
+#define ISC_PFE_CFG0_BPS_EIGHT  0x4
+#define ISC_PFG_CFG0_BPS_NINE   0x3
+#define ISC_PFG_CFG0_BPS_TEN    0x2
+#define ISC_PFG_CFG0_BPS_ELEVEN 0x1
+#define ISC_PFG_CFG0_BPS_TWELVE 0x0
 #define ISC_PFE_CFG0_BPS_MASK   GENMASK(30, 28)
 
 #define ISC_PFE_CFG0_COLEN	BIT(12)
diff --git a/drivers/media/platform/microchip/microchip-isc.h b/drivers/media/platform/microchip/microchip-isc.h
index f5e322c2e36bc..d7bcd74efff92 100644
--- a/drivers/media/platform/microchip/microchip-isc.h
+++ b/drivers/media/platform/microchip/microchip-isc.h
@@ -62,7 +62,9 @@ struct isc_subdev_entity {
  * @mbus_code:		V4L2 media bus format code.
  * @cfa_baycfg:		If this format is RAW BAYER, indicate the type of bayer.
 			this is either BGBG, RGRG, etc.
- * @pfe_cfg0_bps:	Number of hardware data lines connected to the ISC
+ * @pfe_cfg0_bps:	ISC_PFE_CFG0 BPS field value (e.g. ISC_PFE_CFG0_BPS_EIGHT),
+			written into PFE_CFG0 with FIELD_PREP(ISC_PFE_CFG0_BPS_MASK)
+			at configure time.
  * @raw:		If the format is raw bayer.
  */
 
-- 
2.53.0

