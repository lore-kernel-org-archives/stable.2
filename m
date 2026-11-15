Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794730889;
	b=Cfasmefez7ZazjDLGqb1PwxTkcA5UWFwpzrtizTEuMcUPCRfF2GZjqcsqTOp0BRSt/y/
	 QVzR0XCi7BXOaG5eTIoeIG0smsb4o588MwOLr/eejlA2zjbvVTZnq6vNuwBGqsJ4HD2bp
	 t284qOG8ga1NfnTnRQdl4lL2B3k/JnITsTHBltgtGvAiYypXcoMBRxoDVluQBPf6ynSrH
	 z1pLCGC5mMxyOlpTpxfYmEkv6nu0k3KeJ+mx8bqbPLrHishs1je82MvxCh/GZEuTM/XI+
	 NTfynOXVTNP+L87QtQprAXFuTcd16ki5dcGl2AzC7WCeyLb76pWmDCbhJkCoNlDI2+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730889;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ENmgzf/tl3n2tKo2JxTzXWou+7h9tZdT57vOa3F26Cc=;
	b=A39MjerJuLi7KIr4vhkZkMwEAFLz7IFtxlRCF4qmMR9hrKgZ8Zmw4VTNhuRUcuDNxokn
	 lgrx/lkEkCQhIVImLV8nlt19JLQwWUrLOyPgkmsAO1m3sBp4s4nPGNheJ+7vFCrZuvSu7
	 XL+F3YWlpVgJjOlRAD8tpci32bw59TmR4n+DBSbQNgxIFeSQYDWbXVp+R5loSlT22ozSy
	 2rPmv24mXKVIgdmTXdV6PjWjvUD8YrKZP+LakaC1pQ5BPbgA4IvvAAZvkEz4z9fMIKVL1
	 d1vikWybjRGa40kYZWPk38QetL7EFjD5mfhbmqgZBQNYOyiyTqVCsmbxSQ3j/57pHSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpyRBYU2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D2606A330;
	Sun, 15 Nov 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpyRBYU2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794730889;
	b=MzrAL84BkU0iS4w4dm81jOX1zb9NCzBQ5v0LUUhQK3a4fDcSpHwXyh3OagNS/9Z3h/qv
	 Cxkhs5CN4syrX/xbitBQVJI/Oi/5/1bEUiUM2nvdKoszbqjCQWBJRN8zPViWM5H4IqiQC
	 dj4JpGZF8uzusBQqusEf8ze8cySWxlo8aG7gblWoY1aATvlIYAEvuwQ+KGLZCXulEB8Hu
	 mNd2ZOjGlFVJKst6JfiF0HcIsyXPCGv9vNbIk94Iaee0gEChfgH/HNKZ26kSUnPmzFJp3
	 Md/CeOom7aneVRGBhaUjJ0wPk/+u91vKn0/Kj4aaI7B/niCrehDz3xqTBNnKaWaCTYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794730889;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ENmgzf/tl3n2tKo2JxTzXWou+7h9tZdT57vOa3F26Cc=;
	b=xezzN3HvdI9p1/MhKJgFkMzQHvczVPzaehsHZb0F4mRFMBo75zpnqVCHDHeacrUxkGue
	 zvXjn6Hkpf1cGkCKl4xNOKrf0HVtM/tmPd+qC2RpQ+ZU8BAG2U+xFbzsHyt1CjWFgQqHV
	 I9lwNYR2xSE99VmjXTosWXhMr1d3ZMhoFaACKXr91vxcuKazYWrBrYUALlOZ3Q5M5NMR1
	 sGuA54k4+j7xM+V7TQFFyvCOe5JXNot/Rnipo11hVcE8tkvMYNRhsdx9hjxb8jpNL/w4P
	 kOfte4nfVxyhMb3+qyt9+mt0DTZ5CrUrTSD6ZvwT42zZdQ1RJtzlCJeqvwOX+hbOrHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D75E71F000C6;
	Sun, 15 Nov 2026 08:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794730889;
	bh=ENmgzf/tl3n2tKo2JxTzXWou+7h9tZdT57vOa3F26Cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BpyRBYU2KY3sEJXEWT64YFXWDBxtN8Tss1AhHeNFf6F215TqWrLS6QmHHvQ3ChHUr
	 CDBP8SbivO0j86mlFJpDeIgS7Be81LvBdY5M0jcI3r2Hfhg28fYccbeRSpxjLgdQtS
	 d46NFsZMQEAtrrtRUmf4gMz+5GoX7G+cHMkQXZo+9Xx/pZqASlIIVr0UTb3cMs5HDn
	 7KBgzoZqaEuiz82XAG1nnSlOa9TIknPCaLZGDExOwQdGmTI4Fzabb2QFi4O6/AWR7l
	 o30Ts/r4mza7H9uc6nRmwtnmlYoAlAkovumLq0pyIjHX1ZN7LQI39a+heu681F9iRf
	 N73lxqf5PngOw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 62B4A49FE2;
	Sun, 15 Nov 2026 08:21:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 08:21:29 +0000
Subject: [PATCH 2/2] media: rkvdec: Stop the VDPU383 core on timeout
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
Message-Id: <20261115-rkvdec-wdt-stop-v1-2-59e687c6cc63@gmail.com>
References: <20261115-rkvdec-wdt-stop-v1-0-59e687c6cc63@gmail.com>
In-Reply-To: <20261115-rkvdec-wdt-stop-v1-0-59e687c6cc63@gmail.com>
To: Detlev Casanova <detlev.casanova@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alex Kazinsky <a.kazinsky@ideco.ru>, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794730887; l=2992;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=igPIRoqR10XhXtRMntnOpxbLAunwjLzr9JIJfVVGwv8=;
 b=uDK7aEpPgMbGShhyHDHLQc5AGfT0UOsY5Ar/vSvRfvtp0JO7iOAsFrAIYv26VDvlfCA84Yf7c
 BNKe0CtcK23BXvO7k1DdQN0BDVFHfHaZXly0aQybwFwW5F0cxzPhAS0
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The watchdog's RK3399 register write does not stop a VDPU383 core
either. Use the IP reset, as the Rockchip BSP does, then reprogram the
IOMMU, which the reset leaves in bypass. No reset line pulse: on RK3576
the DT lines are the BIU resets.

Compile-tested only.

Fixes: fde24907570d ("media: rkvdec: Add H264 support for the VDPU383 variant")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../platform/rockchip/rkvdec/rkvdec-vdpu383-regs.h   |  4 ++++
 drivers/media/platform/rockchip/rkvdec/rkvdec.c      | 20 +++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec-vdpu383-regs.h b/drivers/media/platform/rockchip/rkvdec/rkvdec-vdpu383-regs.h
index 04eb23297e37..b8ee9c4dd294 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec-vdpu383-regs.h
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec-vdpu383-regs.h
@@ -33,6 +33,9 @@
 #define VDPU383_LINK_DEC_ENABLE		0x40
 #define VDPU383_DEC_E_BIT		BIT(0)
 
+#define VDPU383_LINK_IP_RESET		0x044
+#define VDPU383_IP_RESET_EN		BIT(0)
+
 #define VDPU383_LINK_INT_EN		0x048
 #define VDPU383_INT_EN_IRQ		BIT(0)
 #define VDPU383_INT_EN_LINE_IRQ		BIT(1)
@@ -40,6 +43,7 @@
 #define VDPU383_LINK_STA_INT		0x04c
 #define VDPU383_STA_INT_DEC_RDY_STA	BIT(0)
 #define VDPU383_STA_INT_SOFTRESET_RDY	(BIT(10) | BIT(11))
+#define VDPU383_STA_INT_IP_RESET_RDY	BIT(11)
 #define VDPU383_STA_INT_ALL		0x3ff
 
 struct vdpu383_regs_common {
diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.c b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
index a8fdad2850fb..63482354bc2e 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
@@ -1644,6 +1644,24 @@ static void vdpu381_stop(struct rkvdec_dev *rkvdec)
 	rkvdec_iommu_restore(rkvdec);
 }
 
+static void vdpu383_stop(struct rkvdec_dev *rkvdec)
+{
+	void __iomem *link = rkvdec->link;
+	u32 status;
+
+	writel(FIELD_PREP_WM16(VDPU383_INT_EN_IRQ | VDPU383_INT_EN_LINE_IRQ, 0),
+	       link + VDPU383_LINK_INT_EN);
+	writel(VDPU383_IP_RESET_EN, link + VDPU383_LINK_IP_RESET);
+	if (readl_poll_timeout_atomic(link + VDPU383_LINK_STA_INT, status,
+				      status & VDPU383_STA_INT_IP_RESET_RDY,
+				      1, 200))
+		dev_warn(rkvdec->dev, "IP reset failed\n");
+	writel(FIELD_PREP_WM16(VDPU383_STA_INT_ALL | VDPU383_STA_INT_SOFTRESET_RDY, 0),
+	       link + VDPU383_LINK_STA_INT);
+
+	rkvdec_iommu_restore(rkvdec);
+}
+
 static void rkvdec_watchdog_func(struct work_struct *work)
 {
 	struct rkvdec_dev *rkvdec;
@@ -1779,7 +1797,7 @@ static const struct rcb_size_info vdpu383_rcb_sizes[] = {
 
 static const struct rkvdec_variant_ops vdpu383_variant_ops = {
 	.irq_handler = vdpu383_irq_handler,
-	.stop = rk3399_stop,
+	.stop = vdpu383_stop,
 	.colmv_size = vdpu383_colmv_size,
 	.flatten_matrices = vdpu383_flatten_matrices,
 };

-- 
2.55.0


