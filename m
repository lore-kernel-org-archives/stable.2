Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795811194;
	b=1NqougLIu9wtjbCXCZOczjcbFQyptPF7EDiUZWvhyF3TKxqURr2U0evhbOebW56cgTBO
	 ZALX7SmWRxAQN0yujOMwCOWUVeMt5ksEuCKgX6BHYGRtlpll8KQ/yVsluDh8LPZdaJgIr
	 X0AlYCk1PU6zuxqTq6wEzfW7Bz4QZncBw7NpQqcdDuMD0zNuNfCJwLotZYkEpEp3mgu1l
	 HpSodXxa0cIDfS52oqTWiFqJT1pFd9mBItXH84khBE7jKfj1tkWZPwLLUdvFq5kISswbR
	 g4pA6NQTM+dzBB/21DJHxoV+fsPd5ZYVP7Mf+fXMj7APeYyRC+6jcjLqHfDIZMJNMOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811194;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3TPqzwt0V/lnHcficPJAMhV5XdhUA2vaUdjT2YpenhI=;
	b=fPOu+w/SpWd8sGhAlaftfWm3BMR6zq2ooUx6H6+snswRxFX1KNp0ER/A67KMml8pIvRf
	 wlcf+0nvl23adrRyYHP3ykcEHATA4gw9VH9bu+IEobYdzq68Ik7BoTB22vN+q3hatx605
	 JrQMpw6rwleQj7cgiU//QfVxdPl9Dd4V2xuexK4y2OPkyP4X/HAb2iaNB7ZtQe0NCe77P
	 RE1s9mdkYuGjE708//BTldVzMCkerYcSmBI2kgdF7TvtTvS8ICpijlcntSxR/OGvWPNx5
	 Dhe65gW8RSyfI6HFzh1BlXM7p/yVaNHI+rO737HYOvfwV8spmyNoP/YNAOiPSLaH1+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjTeyOAN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987E606A31E;
	Fri, 27 Nov 2026 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjTeyOAN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795811193;
	b=VVjFe3gr6jXX5idxWMBXpgXwHIFfUPygkFnxxthzI4hPQkBPIyMzEPKuHx5qWJMuFV7R
	 KTFTOMUJbcqupnvFae6FTBdyCpv6n0ZgC/RCopAW/L0uNdWJG7a3sP8hCkrVMs6GkjU3D
	 pTfQZk+KzfVngjvfze1VItyqOb+H35FrMP8y2qG2WeAb1fEoLG1upydfikiIdRx/zhXFd
	 H7eME6fWiqFiWkzLO2yoONUrLPGfiGWYfBLTF2LNz2qdNvRCmtUfMypK70t5CFtPwqeUi
	 n8Bjplmr09NhnjqAWkuo3CnhVU4wzg9g+lP8TyXWbVARe3e0151Pl9luGzr40pSYQjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795811193;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3TPqzwt0V/lnHcficPJAMhV5XdhUA2vaUdjT2YpenhI=;
	b=hFO6Ak3FDLuJllUCVU7SG1OF7KOzuCXgl3fcVgAh9HvkzctxmJd+m8MLgNDBivq2JHVo
	 LuPuhgX40xYcVoI9ZAAywNaJyCyhqP3+SevrpKC1ICZPjdNLyvPJOyG/3/jVA2nWxwgZR
	 BS290RIj1BozL6BSV2ZcQy1Va98O//tYYiaCavcYJMxj2yWkNklal7gEhtaKnsPRW/QDF
	 glXleNNbD0eDnp1FvzGonb8jSpvFmp0oZbnyYy50FGrLmKKX4DS/0ty8cfzINrLR8OaE4
	 bkpyKihpvL73to7mZyb/oJfWyjUMaNHrT0Jb/9fkhGaXOwPALoScmCZSmuuN6HNN9tQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ABE5B1F00893;
	Fri, 27 Nov 2026 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811193;
	bh=3TPqzwt0V/lnHcficPJAMhV5XdhUA2vaUdjT2YpenhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CjTeyOAN0dOT8l/4nLzwmhe9NNoD9Qf8UtaP7+ua98X3s8pWNakUMzL7PDNS8AY3R
	 SyFOy3uFVyGgMY91vsVoc6Zk2lfK8WCurTcmsWwZTcWtHPqFr4ngENbbTHB3knv4RL
	 w6u5phELtfCrRV/VXqpg+NZ1/RT1y81x5Jav34e7hy1prPtjcKt+Ud/tMnCmWc3nRA
	 +XWT8IZDEPLJNDypc6u7OqGjNKdQOjScIPmmjTzYFFUhLS1xR4AZg9yd1zlKHoqG/v
	 qS3mT345NSZdHHbVkFygzfFrY/tlSE3Y3bBfuwBtL4ZjlKU2tnOzSDMAdXavN0E5pq
	 1pCZDbOSGVZTQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3D1F74DD84;
	Fri, 27 Nov 2026 20:26:24 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 21:26:24 +0100
Subject: [PATCH 1/5] media: qcom: camss: vfe-17x: fix VFE-Lite reset,
 debug, and bus IRQ handling
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-camss-titan17x-fixes-v1-1-541ab39e5889@gmail.com>
References: <20261127-camss-titan17x-fixes-v1-0-541ab39e5889@gmail.com>
In-Reply-To: <20261127-camss-titan17x-fixes-v1-0-541ab39e5889@gmail.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Andrey Konovalov <andrey.konovalov@linaro.org>, 
 Atanas Filipov <atanas.filipov@oss.qualcomm.com>, 
 Milen Mitkov <quic_mmitkov@quicinc.com>, 
 Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795811183; l=4436;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=slCIoW8m+WuCtOrrO1UwNBrEMbQUo6Idymd4H2UtdxU=;
 b=mQQOZQs7cEzHmU9BAbADjuQLqPqZn/K3vrt6TffVHzZYl34A39Lc8ATvYO8p4ibECaF3bHEfJ
 Hl2sQTRHUB9CVgtIqO8+Pg2wpQbt49L8SEFJg+U2jgcf2P3BQwr9xbu
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Reply-To: robertijtsma@gmail.com
Content-Transfer-Encoding: 7bit

From: Robert Ijtsma <robertijtsma@gmail.com>

Titan 17x VFE-Lite instances differ from the full VFE in several
registers and bus master counts:

- VFE-Lite does not implement CAMIF, bus bridge, testgen, or DSP blocks;
  omit those bits from vfe_global_reset() when vfe_is_lite(vfe).
- VFE-Lite lacks VFE_BUS_WM_DEBUG_STATUS_CFG (0x226c); guard writes to
  it behind !vfe_is_lite(vfe).
- VFE-Lite only has 4 write master clients rather than 24; program the
  4-client WM_ADDR_NO_SYNC_LITE_VAL mask into
  VFE_BUS_WM_ADDR_SYNC_NO_SYNC.
- VFE_BUS_IRQ_STATUS(n) and VFE_BUS_IRQ_CLEAR(n) consist of 3 bus IRQ
  registers (0..2), not vfe->res->line_num. On 4-line VFEs, iterating to
  line_num reads/writes offset 0x2068 (VFE_BUS_IRQ_CLEAR_GLOBAL), and on
  VFEs with fewer than 2 lines vfe_bus_status[1] would be left
  uninitialized. Iterate over the 3 bus IRQ registers instead.

Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
 drivers/media/platform/qcom/camss/camss-vfe-17x.c | 30 ++++++++++++++---------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-17x.c b/drivers/media/platform/qcom/camss/camss-vfe-17x.c
index 9606236046629c2210740d829bbf5f55cbc09f1a..304dafb39ad5121ade50cf278e0ada53f5e5203e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-17x.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-17x.c
@@ -137,9 +137,12 @@
 #define VFE_BUS_WM_ADDR_SYNC_FRAME_HEADER	(0x2080)
 
 #define VFE_BUS_WM_ADDR_SYNC_NO_SYNC		(0x2084)
-#define		BUS_VER2_MAX_CLIENTS (24)
+#define		BUS_VER2_MAX_CLIENTS		(24)
+#define		BUS_VER2_LITE_MAX_CLIENTS	(4)
 #define		WM_ADDR_NO_SYNC_DEFAULT_VAL \
 				((1 << BUS_VER2_MAX_CLIENTS) - 1)
+#define		WM_ADDR_NO_SYNC_LITE_VAL \
+				((1 << BUS_VER2_LITE_MAX_CLIENTS) - 1)
 
 #define VFE_BUS_WM_CGC_OVERRIDE			(0x200c)
 #define		WM_CGC_OVERRIDE_ALL		(0xFFFFF)
@@ -184,18 +187,20 @@ static inline void vfe_reg_set(struct vfe_device *vfe, u32 reg, u32 set_bits)
 static void vfe_global_reset(struct vfe_device *vfe)
 {
 	u32 reset_bits = GLOBAL_RESET_CMD_CORE		|
-			 GLOBAL_RESET_CMD_CAMIF		|
 			 GLOBAL_RESET_CMD_BUS		|
-			 GLOBAL_RESET_CMD_BUS_BDG	|
 			 GLOBAL_RESET_CMD_REGISTER	|
-			 GLOBAL_RESET_CMD_TESTGEN	|
-			 GLOBAL_RESET_CMD_DSP		|
 			 GLOBAL_RESET_CMD_IDLE_CGC	|
 			 GLOBAL_RESET_CMD_RDI0		|
 			 GLOBAL_RESET_CMD_RDI1		|
 			 GLOBAL_RESET_CMD_RDI2		|
 			 GLOBAL_RESET_CMD_RDI3;
 
+	if (!vfe_is_lite(vfe))
+		reset_bits |= GLOBAL_RESET_CMD_CAMIF	|
+			      GLOBAL_RESET_CMD_BUS_BDG	|
+			      GLOBAL_RESET_CMD_TESTGEN	|
+			      GLOBAL_RESET_CMD_DSP;
+
 	writel_relaxed(BIT(31), vfe->base + VFE_IRQ_MASK_0);
 
 	/* Make sure IRQ mask has been written before resetting */
@@ -208,10 +213,12 @@ static void vfe_wm_start(struct vfe_device *vfe, u8 wm, struct vfe_line *line)
 {
 	u32 val;
 
-	/*Set Debug Registers*/
-	val = DEBUG_STATUS_CFG_STATUS0(1) |
-	      DEBUG_STATUS_CFG_STATUS0(7);
-	writel_relaxed(val, vfe->base + VFE_BUS_WM_DEBUG_STATUS_CFG);
+	/* Set Debug Registers (Full VFE only; VFE Lite lacks 0x226c) */
+	if (!vfe_is_lite(vfe)) {
+		val = DEBUG_STATUS_CFG_STATUS0(1) |
+		      DEBUG_STATUS_CFG_STATUS0(7);
+		writel_relaxed(val, vfe->base + VFE_BUS_WM_DEBUG_STATUS_CFG);
+	}
 
 	/* BUS_WM_INPUT_IF_ADDR_SYNC_FRAME_HEADER */
 	writel_relaxed(0, vfe->base + VFE_BUS_WM_ADDR_SYNC_FRAME_HEADER);
@@ -223,7 +230,8 @@ static void vfe_wm_start(struct vfe_device *vfe, u8 wm, struct vfe_line *line)
 	writel_relaxed(0x0, vfe->base + VFE_BUS_WM_TEST_BUS_CTRL);
 
 	/* if addr_no_sync has default value then config the addr no sync reg */
-	val = WM_ADDR_NO_SYNC_DEFAULT_VAL;
+	val = vfe_is_lite(vfe) ? WM_ADDR_NO_SYNC_LITE_VAL :
+				 WM_ADDR_NO_SYNC_DEFAULT_VAL;
 	writel_relaxed(val, vfe->base + VFE_BUS_WM_ADDR_SYNC_NO_SYNC);
 
 	writel_relaxed(0xf, vfe->base + VFE_BUS_WM_BURST_LIMIT(wm));
@@ -337,7 +345,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 	writel_relaxed(status0, vfe->base + VFE_IRQ_CLEAR_0);
 	writel_relaxed(status1, vfe->base + VFE_IRQ_CLEAR_1);
 
-	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++) {
+	for (i = 0; i < 3; i++) {
 		vfe_bus_status[i] = readl_relaxed(vfe->base + VFE_BUS_IRQ_STATUS(i));
 		writel_relaxed(vfe_bus_status[i], vfe->base + VFE_BUS_IRQ_CLEAR(i));
 	}

-- 
2.47.3


