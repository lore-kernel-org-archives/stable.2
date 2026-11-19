Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069208;
	b=C3iG7+RcChREMRUGa9O9AvD91AhdFHW2X/EM3P+Y++rm9KA9yBAzdrNKHDt0xSs1N2rn
	 tByGzYH0uaBMuom9XbzHneNPMNSz4zG+A8FkBB+WiHGOxDRyp1ZquUML5xTrGg4X2I5ga
	 Woqb7+U2bj1Ff24nJeClQuMq0jZhYL0I6bxcx6OdNY4QVWZSe5hCBguDWXR6td2Etjcjx
	 2Dz6Sbm/HTm/QLaEpqQt8KEu0hwJKd7fjRVHx8Wyp61Wnm85HKeedoS3mZWNOVIGmL0zH
	 61JRITdfETWYSL1kvmwg4LIg5nfw7+BS4admPNXkFh44Z5ovZpaDs4YM7/oL3pvBZUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069208;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z59izcFqmV87WVb5c9g9cMWduIXw60LHpxtAQlDqhc4=;
	b=PHjfivIOJTuA6qlOIeP7i+uFo6vPranFADYsuAgTe21h8cNR1u7cyKloon57L+2je2T4
	 FGx3oGwryv+OxLCk3/mYmwPs3S359jcQlfRvWRsNXEWd240dLQvvTRmTo2R8/R8fokiFI
	 r55ZRs4VxkPG1s60ABiE2hRzWIsOmJxZg43rxpQpXb9nJRP6+5wr9tPIZnkO4U0jMUSPC
	 SdqDMQvwUYv+CIL/kMIXKiorJ6OiiUIt0cy/zEH8qXrYKFdODhaDlmrRh7zZ2DSmZIsja
	 7L+sejbjAdFB/RXFyeiwJniUyNfGbo2Lh2DGcPMDcNpWksnISnmhK+5YFseGRwf7s4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nqk91pTM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0960606A32C;
	Thu, 19 Nov 2026 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nqk91pTM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795069208;
	b=cWzz+UYdUY1p2lOskyegZVHVL/DSIcps9zLGsJmwkKEE8cy1M6ro/hEZn6agGwyU1duM
	 guyaHJ87dRUgI/8taY4ONUm9vcedr8r3Om8GVTIuqwTYJTPeqeB9op/rMnTeIAmZQo3b7
	 J3/VQ7GWQ3KnrXeRiAVjt58znHJgP5Qp37cXMXTUEr2+rHRc9HaG+Aecn1EE51E7PKLsp
	 iXp2g7Dvbqp4St4KMuL0hQxlgPfXLB5VudedIfNjkc1YsJVGvYJhETfnwAChbffdKsmGk
	 VsYBvCAeUXjXsXElb6uXWDig5tJNzmRqHVd6gYQCRi6xMWlSJyGxJ7RgGavlg7iCUgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795069208;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z59izcFqmV87WVb5c9g9cMWduIXw60LHpxtAQlDqhc4=;
	b=a4kvX/drJG9KyMCK5EjC1CuxdOd3y46URgUt+llnlVW4Qm9/sBAjGGnuGsB3WtKJYXW4
	 oXFLpoutYkgpsdnhOl9w3unQfGoKLzurVvWq1AN9tglIqGjv4G7jDLtvfrAAFyaTI2ASG
	 xFJQL8m79l1WXsM/ZnqGnsWgqZ/zAvhm6A6uL43gsPaOUtHC+3LYMBdrrYt0n2NxROmZx
	 0bigbvl2mgHM2EOQY6+qRsMlJri9Q9aNikmrin9j+g7zBDfS/9BcZUpb3herVOEmEb0ho
	 FYMQgB+w+gGzxDKVNcUvu+yHdtKMQ+I2FqDYeesan4cvbpS/8KqAoGD6p4ku2GBSJHA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D0A3D1F000CA;
	Thu, 19 Nov 2026 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069208;
	bh=z59izcFqmV87WVb5c9g9cMWduIXw60LHpxtAQlDqhc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nqk91pTMLB1F2yBqJVfN2nNZws3FwKm63iBewfKaqNMAHpTNnHyFjO2ubsp7qZghI
	 RhM7VwnzmtkRnGtMo5iC++PpMQcXVw3qGM0gRzfnXmm6trUrFtjPhJkFnO+RdXr5L5
	 +bHll+Z7aIUJDCHlS0953//R73aFFdQHHPGNSfJl/OVGB0fh7C0U0gPP7YUpzx9TNw
	 k851fuj2iLbUCOimHYmwnXavuSQ5YgcTkEVNJ1VB5CnqVgmEBODcJSjdP7ihsPQvYT
	 U/QWHipsLfSTRs8OnZ3KaNp8t5GDSR+fr+WS6Kt3gVMueZHkT70TWjn/0OkNSEvTEa
	 yZaYzqK2ezIsQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5EADB4B134;
	Thu, 19 Nov 2026 06:20:07 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 06:20:08 +0000
Subject: [PATCH 2/2] media: verisilicon: Reset the VDPU2 decoder after an
 error
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
Message-Id: <20261119-vdpu2-errreset-v1-2-f8fa403b6a3a@gmail.com>
References: <20261119-vdpu2-errreset-v1-0-f8fa403b6a3a@gmail.com>
In-Reply-To: <20261119-vdpu2-errreset-v1-0-f8fa403b6a3a@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795069206; l=2516;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=sjdfbb38xSnpl2qcZS+zDoOlunwHqKwXDRUV5q2wqsU=;
 b=WqxcSouqA+T7MzDgKzey3DPKmJA8dW53kZv4m7HQO81sYEsEG+IJCli/vrtWW45S9MVoiAsd6
 VTWS9aKvOQrA9Hchq40aPRHhC6X+5r+aY/2O3OnU+sNYNNkNS62RQ7Z
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

After a stream or bus error the decoder can still access the buffers of
the failed picture. On RK3588 these accesses hit buffers userspace had
already freed: IOMMU page faults, an IOMMU that can no longer stall and
corrupted output for the next job.

Soft-reset the decoder on every error interrupt, as the vendor driver
does, and wait for the reset to complete.

Fixes: 879dee56a40c ("media: rockchip/vpu: Add MPEG2 decoding support to RK3399")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../media/platform/verisilicon/rockchip_vpu_hw.c    | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 4bc1bdb41c70..01cd449f3ab2 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/iopoll.h>
 
 #include "hantro.h"
 #include "hantro_jpeg.h"
@@ -384,6 +385,21 @@ static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * After an error the decoder can still have bus accesses of the failed
+ * picture in flight; reset it before its buffers go back to userspace.
+ */
+static void rockchip_vpu2_dec_soft_reset(struct hantro_dev *vpu)
+{
+	u32 val;
+
+	vdpu_write(vpu, 0, VDPU_REG_EN_FLAGS);
+	vdpu_write(vpu, 1, VDPU_REG_SOFT_RESET);
+	if (read_poll_timeout_atomic(vdpu_read, val, !val, 0, 5, false, vpu,
+				     VDPU_REG_SOFT_RESET))
+		dev_warn_ratelimited(vpu->dev, "decoder soft reset timed out\n");
+}
+
 static irqreturn_t rockchip_vpu2_vdpu_irq(int irq, void *dev_id)
 {
 	struct hantro_dev *vpu = dev_id;
@@ -396,6 +412,8 @@ static irqreturn_t rockchip_vpu2_vdpu_irq(int irq, void *dev_id)
 
 	vdpu_write(vpu, 0, VDPU_REG_INTERRUPT);
 	vdpu_write(vpu, 0, VDPU_REG_AXI_CTRL);
+	if (state != VB2_BUF_STATE_DONE)
+		rockchip_vpu2_dec_soft_reset(vpu);
 
 	hantro_irq_done(vpu, state);
 
@@ -482,8 +500,7 @@ static void rockchip_vpu2_dec_reset(struct hantro_ctx *ctx)
 	struct hantro_dev *vpu = ctx->dev;
 
 	vdpu_write(vpu, VDPU_REG_INTERRUPT_DEC_IRQ_DIS, VDPU_REG_INTERRUPT);
-	vdpu_write(vpu, 0, VDPU_REG_EN_FLAGS);
-	vdpu_write(vpu, 1, VDPU_REG_SOFT_RESET);
+	rockchip_vpu2_dec_soft_reset(vpu);
 }
 
 static void rockchip_vpu2_enc_reset(struct hantro_ctx *ctx)

-- 
2.55.0


