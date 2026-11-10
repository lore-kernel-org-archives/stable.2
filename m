Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794314509;
	b=DVeF4PggqNth1JsnH8JABzwWSqSQQQJFnEtVnmLS3UYIp4V84aMNJiPCH9t2Qc61Cifp
	 OW2BQdWgsZErvglt6xR607TWxeuoyUgr34btl7EAGTp7F4Ja3VRl2S0fOjz1liFg5M0Ya
	 vSh5G5NIKv6EtnS8QV7/6nb9VSjhZVCPavzMipSE7+O13jpRR5rxqdwtQlK4waBPTQeEr
	 PFxF9nrRAEIs8YgY+HOdPlZWaLemGB4UKnU3xOFfzZ4c0xpmkHRsgX3HTNfQVBz4uTM6I
	 6nFmUespr6o6OsDPVxTa6xMP4hQd24zzwMWd0/Iv4/uGieag72sUl7l1omOl91DvKxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314509;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QxlVyvsqNV97AlBOC2FE8kEyEB+oWLu2PyocIQGDZuE=;
	b=4/vTuc6N/Vg2h7ypbaYH0eznIN+s1byGEYF5MtccoV+Z2UFB7POkaWbVQlqruHmACaXu
	 4Drty07N9skrs0hhnlNuyDZ/09k1H2Jyhdb6VEyvXGfJOWJskZ0eB3F40NvRPjlLjIcyr
	 JxXpEUPtpUaT7os7AJOEd/nbdQuW9Dl06mEoAqJh0tCTGKvmbHRHDZNT5GOar0R3MbvBZ
	 L3+sxuDJSm0ozKP2aZzbkR2I4Wp3nAFYUlV6YF4htJi0aH82b3YHN3lJhDHcQMdwo7gVv
	 yxKtoKbpEyClhh5PQuwem71Y5e+knDxBjHh5Fcak0FAC7IDfx28LYvMEOrekhYzqb3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKz9Rjp9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CAB606A31C;
	Tue, 10 Nov 2026 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKz9Rjp9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794314508;
	b=gRbRGdrrE8vnnJ1nLMAncGOsaJ6kFDZPRPduaEzcgiOHuD0Fl+sk36DuicQLCjv4pD4R
	 DssGkDiatRo6UvVvnvWrRxGfXzBda8LvFyeJT5juNqAZ2GpFT7J0IEkmAidEnqpdcIJMC
	 pi6ANdRpaChopJyU5JR7SHhI0fFGClLV+wbs6w3vb4ZGNJLcA6khC85SlienXXopInWII
	 eUPTHodmpXvxBaoqSUWC5XadTh1uLRI5I1Zj3VPH2Wl7l6ykRCVM99RwDl1nqSbZHBhZ9
	 vEr1+NBPR1McP2nHjgFjKJ4Zj9agnmYSKsHfG/NrePOW1ClWkgKh/W+fhHaUJ2i/cnw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794314508;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QxlVyvsqNV97AlBOC2FE8kEyEB+oWLu2PyocIQGDZuE=;
	b=AChZb6oW1DyxV/RbLnE/FxYiKROd4Hjud/bz/FqypYJ99rm5NCFGTHAU3UxtnegY6Idm
	 YhZYrxoNGG+yriFMWVidJiaajJmnOd7zEBBKk/VlySl97QXWM3PAFHauIwMGnGpUY7M5K
	 kplurima2qjQWuYN0XGeugtsgQc1k2ggU5jppCx6u0cVI+v2gWWubjOCK46Yg1nwTYpNV
	 0f5eOYlRxlLP6180TYX7GFf8ExRyO+X2UilQT7Fw7bctHJA/Rz6b8Y6koG9V5rqBv7VXs
	 x31n4/g7w6POJGxLWlsQLNj5u4E32oKSkD7YWpSbJkOKWhmdoEXAUcDbhBsEl+RDYvA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D21A91F0089F;
	Tue, 10 Nov 2026 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314508;
	bh=QxlVyvsqNV97AlBOC2FE8kEyEB+oWLu2PyocIQGDZuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QKz9Rjp9nwlNPY9eIAxUhIZeLlPsQyQ7csZsRc3kJs8sRYxbvwR7AkbRBB+oRn8LC
	 ZjsGcwa4TosHzZSiEtxRAB7fsVM1iG0ht4bXe078OS8TjljRkdvdfASKE3UcSlYjOJ
	 7G88mdYlQthmAIu1M4lHt095SruBRDMk19JhSLC19YHipMR4RBJsU9tRleqYR7dd13
	 VsZX6kYnh7rEgx8aC6CQSz97BprNOnGFZn7FCKZfykJ/PxnekI9k7gQXJAj1+7ctlL
	 H+64ozPS0oOu4onvtBybjHaTm7px/+ydM65rOi/3T1MFFcvzUy1R0eYuMCq04FVrJj
	 ubXfoEnCSe8Ag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4B2EB48B42;
	Tue, 10 Nov 2026 12:41:47 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 15:41:44 +0300
Subject: [PATCH v2 1/3] media: verisilicon: stop the VEPU1 JPEG encoder
 after an unfinished frame
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
Message-Id: <20261110-hantro-buflimit-v2-1-ff7790def9fc@gmail.com>
References: <20261110-hantro-buflimit-v2-0-ff7790def9fc@gmail.com>
In-Reply-To: <20261110-hantro-buflimit-v2-0-ff7790def9fc@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794314506; l=3084;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=YHxh7pOb2K0qV8FuiClIzJFZEkYN6AmWKtxTo6KANAk=;
 b=uZxJGwVHOcWH3jWGfP8L1xLnMi7Sr/GSOL1WEVuW+C2Pi3WQsnfDvXgw2aoDxwWAs2rHNKOSz
 9v92gCbP2MfBnlUnTVUb6/Ye4SVCdcNY0Jwxh/vRozR2gp33+BJcSbd
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com
Content-Transfer-Encoding: 7bit

From: Sergei Khomenkov <shomenkow@gmail.com>

When the JPEG stream reaches the stream buffer limit, the H1 raises a
buffer-full interrupt and pauses with the enable bit of H1_REG_ENC_CTRL
still set. rockchip_vpu1_vepu_irq() does not stop it, so the next job is
programmed into the paused encoder and times out.

Clear only the enable bit when an interrupt does not report a finished
frame, and warn (rate limited) about each fault bit that is set, as
hantro_g2_irq() does.

Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board; the assistant also drafted this change. Tested
on that board, with the next patch applied: a frame that does not fit
now ends with the ERROR flag and one interrupt, and the following jobs
complete. Not tested on other SoCs.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_h1_regs.h  |  4 ++++
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_h1_regs.h b/drivers/media/platform/verisilicon/hantro_h1_regs.h
index 8650cc489392..a7f18683dac1 100644
--- a/drivers/media/platform/verisilicon/hantro_h1_regs.h
+++ b/drivers/media/platform/verisilicon/hantro_h1_regs.h
@@ -11,6 +11,10 @@
 
 /* Encoder registers. */
 #define H1_REG_INTERRUPT				0x004
+#define     H1_REG_INTERRUPT_TIMEOUT			BIT(6)
+#define     H1_REG_INTERRUPT_BUFFER_FULL		BIT(5)
+#define     H1_REG_INTERRUPT_RESET			BIT(4)
+#define     H1_REG_INTERRUPT_BUS_ERROR			BIT(3)
 #define     H1_REG_INTERRUPT_FRAME_RDY			BIT(2)
 #define     H1_REG_INTERRUPT_DIS_BIT			BIT(1)
 #define     H1_REG_INTERRUPT_BIT			BIT(0)
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 02673be9878e..d201b058e5e8 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -376,6 +376,24 @@ static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
 	state = (status & H1_REG_INTERRUPT_FRAME_RDY) ?
 		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
 
+	if (status & H1_REG_INTERRUPT_BUFFER_FULL)
+		dev_warn_ratelimited(vpu->dev, "stream buffer full\n");
+	if (status & H1_REG_INTERRUPT_BUS_ERROR)
+		dev_warn_ratelimited(vpu->dev, "bus error detected\n");
+	if (status & H1_REG_INTERRUPT_TIMEOUT)
+		dev_warn_ratelimited(vpu->dev, "frame encode timed out\n");
+	if (status & H1_REG_INTERRUPT_RESET)
+		dev_warn_ratelimited(vpu->dev, "encoder reset\n");
+
+	/* After a buffer full the encoder pauses, still enabled: stop it. */
+	if (!(status & H1_REG_INTERRUPT_FRAME_RDY)) {
+		u32 ctrl = vepu_read(vpu, H1_REG_ENC_CTRL);
+
+		if (ctrl & H1_REG_ENC_CTRL_EN_BIT)
+			vepu_write(vpu, ctrl & ~H1_REG_ENC_CTRL_EN_BIT,
+				   H1_REG_ENC_CTRL);
+	}
+
 	vepu_write(vpu, 0, H1_REG_INTERRUPT);
 	vepu_write(vpu, 0, H1_REG_AXI_CTRL);
 

-- 
2.53.0


