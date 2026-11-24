Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527633;
	b=rkXpQTbb/0h9FkAx0T7SlSFBi6E0ayIRixdnfRtYKXtUNSvKYzcf9+ye2dp88SvEMpUS
	 l5dYaExIL1lK5QNMvIZzgiwwo/asd8F4K6PU31TnzjXzU/LMSgMnfHicAT9OuPzenB+/I
	 AaET2VHafbvTHECOYRmdcG1E8PBYDsuiVsiysDTo6UKG1h6rV2cZIuNxyUYk1jFPV/z3a
	 ZbWyzCPP/hMjqAKl4/cuxYTeiJ96oT6VIcAu2xL3ebmMLvOxlLdPtCk+4DiiChDv9obHK
	 +GBjLR1K7QIXl1zWiZHH3x9/MCzyQm3YOr6EbcfLvCeEI4tNo9dfbC8s6so9N2++3Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527633;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AFQUerxMoXa3m0Ev5SjHXNJUPKI3EK/dEbiXEl5C7iY=;
	b=zfUdKN2ZxoaQyIFseiq5cmDSecugnW9pK7OmidB7ndu9ZYhm+2H77nwlSUr/9cDIwas/
	 bVefxUzXBH0+GQvxkSr8DJ9GvjLgG19vmZIIVy8o47Em6WrBqhKMtq4SdG+iicIchlvPO
	 hzpd5v5b8Fo8z3aGTmU7jvWmZuZqG3BX2XAZHZ7K2sTOoMz3PzJXrf22RT8yyauZBnpft
	 K+GsshO0YOFHKkFNeD6q8a7Phdw3Zi/f8vYiHQmI0mI/KCocbGqiQZQESOln6h5Y8h+IB
	 ddzv8/C0BxXDTJ+mSyytM10kG7ttFcWvSpdei6aUOVFsnJAH1laLEtpdKwDTWrqFuFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kbbr6xbT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F45606A327;
	Tue, 24 Nov 2026 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kbbr6xbT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795527633;
	b=PNOPpiQgehXUUX/cRf8fuBPGz8qym7ylZuHXT75p/Tyjgef3X/U78HV7A025y33XIlNp
	 MrxgsbYYYNZ0UOz9BVDZWnCd9U8ZuC/9r6iaZs+GtUan9dWzCTF/sdasujzoToN+Zma48
	 c+Q9Y9bIwZz90mhHJ70P3Zo/KJkiZATQGq4XI6YYvTgQFKOTb9ai8MUbDQ3IfUVHS2m7z
	 64a16OMrPu1Cf9CsR4KjhBKlnbdZRuP7XmMuQ4u0LeicqNkIqzxs3Ydm7RJVCaf6TyJEe
	 KlPMStE4ITDQqDotBdimh0UVgXpJ8nvWBsl+nmaTpxkWmUjTxgMcMwcWA55JY5Vvitg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795527633;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AFQUerxMoXa3m0Ev5SjHXNJUPKI3EK/dEbiXEl5C7iY=;
	b=kwImLeRk01VPxTUo2TCBnOaa1CItpApRh8P+Y8rkzK7kOPw+XPz2Rd3AjHY4icViwAqQ
	 7E0sAp9poh59WIZuPVLwqfF0pKv4/uYnLmkfziL6Qm11p3CG24UxemDXMZ7MAm/DZebNr
	 Aunzf7fwA9YTAm/PnKMEIrhxP3cJzR5m2/LuAWoN6zMPXkxNlXE+f50DSzGFiposUz7U+
	 eAPiIuLTFcZS5QUMqaJFirquu+HRSxQNQud7AddaDeEwfCI8L4US5S7QGzZhIk07cfIH8
	 xSHq5zVdKjt0YcyoZGFBuQdWH+V6LQBzvMYLh4WnZbCjr/TTeaguYMF0AAZ5GGLSVAQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C832D1F000C6;
	Tue, 24 Nov 2026 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527633;
	bh=AFQUerxMoXa3m0Ev5SjHXNJUPKI3EK/dEbiXEl5C7iY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Kbbr6xbTbCIARPzRq9g7tdXU82V1bfd7v0xRG5zGVrUhpfHIhQ/EkOAw/3RMe4IUF
	 vZiBNWoCSnfVIM5ODCkH/T0pt+NhepzzFvxT+HDtt5d8Bj9+vGqSiuyGRV4vVpEtz/
	 C4gafFKjxf2cgTxOd74ZSvbYfpBXmpdNLhAqGze6eD/qpNhhURwlf34ZRAJL2/Qw9L
	 n8rv8CXROiTwAlKDy2ajqo0T0Kl8+aOhk/g2nJuECQX9TDrjrlRA0g6y/Or3qOvTdy
	 tCkopPDVPtgUe/lb/lNlxtptLiNDy3gU5pnRJWkodsoAnJg1fQV4kTTH8eFyMYTH+7
	 UERQoO87kT/Rw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5A6B24CA3F;
	Tue, 24 Nov 2026 13:40:21 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 16:40:17 +0300
Subject: [PATCH v3 1/3] media: verisilicon: stop the VEPU1 JPEG encoder
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
Message-Id: <20261124-hantro-buflimit-v3-1-780903970ca0@gmail.com>
References: <20261124-hantro-buflimit-v3-0-780903970ca0@gmail.com>
In-Reply-To: <20261124-hantro-buflimit-v3-0-780903970ca0@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795527620; l=3188;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=72wEzEpWvcZUPVzgCWpUbYv9ZbU47P8Ry3jsfvrX0JM=;
 b=923nxQwhaJv7x9wuorJha3YiDSdvwEjHRzr4yYbRoLPca94/xekCNsPlns5m4UMmyxuBWi5yg
 IMTJa230fFjAysnDMcDd/O4SEIwyDwVFJ1XqaG+tG2pJKgueKRZiqYe
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

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board; the assistant also drafted this change. Tested
on that board, with the next patch applied: a frame that does not fit
now ends with the ERROR flag and one interrupt, and the following jobs
complete. Not tested on other SoCs.
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


