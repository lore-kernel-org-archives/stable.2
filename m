Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472250;
	b=fb8Vhsg/22+DS6ZQcKPEtTil+Ls+4iwhsCAOow2jSJIa7ZR8UaafA4UhS8Fei7A23w+x
	 zFMkeUK597CbGz+qCsXDAh/WszZPJTTEboPJNhGhnGVEEneWe0wYQpurDZM9Sx2bB/CgT
	 3ym/ZGU8Mfqo0bWU1vAjGZmoVm9wiXG+FTHeSzIn0egVyx7kbg6gRL8GTeefiU4l6bNLd
	 YdpddMIToJySzMTLl6uVt7qgzxA5H+C+GDcHRipgiOgYSuTIjVrDOdSWtDJ0bNlWEjcZn
	 jCSIQrDCU5URJM9sXphHqzQvwzM6e7LPXKdPHeBFapbbJG7gJW2BUHQIwibE/od2RCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472250;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ASyAY8bq55NxrF7Uq8dDNoQgFuT+3SFZsxEh9sLLHJU=;
	b=KVOaf7jOGxu8U0qQHckUmqc1jGIR5f/q3zcWUcEMela/3VndzxwV9SvtxFQjyd/tP7r2
	 50kWfbR/jmC3ZVgcEbapZHnKAyCo928YkAG/EltcPGwwvASGgl5kEPlOV9VBuSKbtHZQE
	 eL3Lw6gZuU7zZQp+REqYK0urWs/EFVISg53NAHogru7hbsWcA4V/gfm+rtl2EsB5SSvQk
	 tzIY0G6nO0gpxH7t3c51GG9n3PXS3cRKoDIFUwDLBhsYz2Ua1aYffj8+3vYWfx7DBsdlf
	 W8DinZ70R8eeno0YRZ2x7UR1bLgVxWkyoiMX9P3OgvPM3aFRpWIFSJKLq41wB2MHiqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gw+r7B9d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C37606A334;
	Thu, 12 Nov 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gw+r7B9d
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472250;
	b=ELgYtB9NMQv2Dw6gmLeOGxT/8to5mkGwRCzM20yNcifoJn7642iavtnONY/LkUy5A+WR
	 mOAc9nlMQ2um7zNb544n4Emn3/6dTqBSaW3QwG6gcSPe+DkH9or12EnLLsb0w7zhT7WkU
	 nEOlug3ZvDG4y/KTflXs7AfaGbexTMTTXkNjgLNO9wZhjyd77BeNa9wXtHt4uWEXiWuGn
	 QOE3uGis8+TKXvw1UkEjQqm7cMq7zDJB+jct+SsRBQn2fEWieV/6Vg2h+RuRh/YZhsxGQ
	 noPHtLbNyNXeYLJEyrfDonl2Udhy8ouczrgXO8UxZ/5/6y+Jj+sa78HTDrG2CSj/U9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472250;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ASyAY8bq55NxrF7Uq8dDNoQgFuT+3SFZsxEh9sLLHJU=;
	b=o4vzJJ1iavfj1JbfDvRGNHDTxNPHvjihaoORPy9jnyL15QgL8CVLBfuNk8guW7FaWw7Z
	 +plSxY7tzt2rzwTg0hNRox3mTnMUJkiU6OchJIKO28MkGypXuoP0PWMc12syONVEmP+nV
	 A7i5cM8jT3qmCvrCRk6Ux0TktBN+2Fa1pbG/Kg/ptjMruzyp/d+z9X+qrd88eXfRAJWR9
	 E12/LpCmxJNl7VxxGQDiI50JCASMZM4pdtGlzJ0e3WkCmUXUK5iHdTMSXT0ipt0L2oAKz
	 Dtr7f4igrrqmYsD7LQeGr+A4yGhZEwz+TVx+J1EleagKC85xlVWjW+hzWuVYQuGgvNw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 97D741F00A09;
	Thu, 12 Nov 2026 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472250;
	bh=ASyAY8bq55NxrF7Uq8dDNoQgFuT+3SFZsxEh9sLLHJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gw+r7B9d+uGfx2+SWHJPBSpjGRD/RWGoAP3Pi8peqQuIaYONEgHcC5NgUWEw0G/mt
	 YR8miGCueGY6VUf/bNvBJ30rEntrQhNptY5LmSM/32VKDarnWeg8ayquHIYtfN3iDE
	 gkDEbE7MfvgKYFeMtexJeQ2G8ay8wIxSHJPU6OvbeEyKQoADLzqEP9vkJGV4JN5Sh/
	 ox63LQk6ZCX3Wtnujn1BREPMk2x3VyUSQEm3upF3Jgqzp0w2Fv8okIifZWisH8X/ti
	 dbUb1chbjz6DVwgnDx8rbNEbWyst/zuy1kFQEAkBKRvj9SclUgFdDfsvoNEZaIMqMa
	 Mj+AQWad+v8hw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2104449381;
	Thu, 12 Nov 2026 08:30:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:30:49 +0000
Subject: [PATCH v2 3/6] media: verisilicon: Enable the Rockchip encoder
 interrupt again after a reset
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
Message-Id: <20261112-hantro-robust-v2-3-18561fd48838@gmail.com>
References: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
In-Reply-To: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472247; l=2118;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=/pdV5Ao1nfGJCAVq9CfIzOPUMn8hmIXBimy2UnM/Qpk=;
 b=ft5+zd+VMM7oNCjDiVVEWeZlc3SSoAWnTT6gIEqUHrWWoRnoY+fjjX7uOstpMkkQs3JCHDa2w
 y0Ch1+HeEICDFvreFFH8syfHKBG6uUPEluWPx/0eyl9oBMCcxhBMFAn
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The reset operations of the Rockchip VEPU1 and VEPU2 encoders, which
hantro_watchdog() calls when a job times out, disable the encoder
interrupt before stopping the encoder. Nothing enables it again: the
encoder run functions don't write the interrupt register, only the
interrupt handler does, and it no longer runs. Every later job on the
encoder then times out as well.

Clear the interrupt register at the end of the reset, as the interrupt
handler does after each frame.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 02673be9878e..5d4e46bd9cd6 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -475,6 +475,12 @@ static void rockchip_vpu1_enc_reset(struct hantro_ctx *ctx)
 	vepu_write(vpu, H1_REG_INTERRUPT_DIS_BIT, H1_REG_INTERRUPT);
 	vepu_write(vpu, 0, H1_REG_ENC_CTRL);
 	vepu_write(vpu, 0, H1_REG_AXI_CTRL);
+	/*
+	 * The encoder runs don't write the interrupt register, only the
+	 * interrupt handler clears it after each frame. Clear it here too,
+	 * or the interrupt stays disabled and all later jobs time out.
+	 */
+	vepu_write(vpu, 0, H1_REG_INTERRUPT);
 }
 
 static void rockchip_vpu2_dec_reset(struct hantro_ctx *ctx)
@@ -493,6 +499,12 @@ static void rockchip_vpu2_enc_reset(struct hantro_ctx *ctx)
 	vepu_write(vpu, VEPU_REG_INTERRUPT_DIS_BIT, VEPU_REG_INTERRUPT);
 	vepu_write(vpu, 0, VEPU_REG_ENCODE_START);
 	vepu_write(vpu, 0, VEPU_REG_AXI_CTRL);
+	/*
+	 * The encoder runs don't write the interrupt register, only the
+	 * interrupt handler clears it after each frame. Clear it here too,
+	 * or the interrupt stays disabled and all later jobs time out.
+	 */
+	vepu_write(vpu, 0, VEPU_REG_INTERRUPT);
 }
 
 /*

-- 
2.55.0


