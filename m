Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069209;
	b=rO4GwWhJHkSVOCFH5upDW0S7ilHsglOMKl6pcvfyr5RhBu4W/IpTr0z1KkoFHa29rBE2
	 6yFef7UIue7MG3sbULyfhvS7Je5OOV43w+SKxdWBiElNyEk2N2fuUm4I+8w023Cpu6Maa
	 LntO2YgTiUv0RHokBiNYz6/SW9I3G7uEaooirUzZz2UWHRUQ2EHG0BbHF9HYq5XvQN9+t
	 xkHD97bPkiHhqgC79dnosiGHD3rh2yMBgcqPuaCkGg9nNcqHzf++jwZ/TR7rEpyPfxn2X
	 D7AzSd4pmoDaftdcooXd3S1ZheAlmzs2BwAGYcpXpsmexjxfF9KDSV2Y5sSmH2/yY/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069209;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	b=mQD5xEF0ZVcUajez0N7FWp5ETCibXpFCz396ClpICzjGcoNalCB8djdEhGQHcybuHTs1
	 z7xtDeofuagTjOEkcE1nWOWQU6+gmXBx+fAJG3RXCFAApzqzqUgSpLWXAb2Wst9udwToO
	 WpyeioYdnk+Qkcc9jmoE+V9Q/3NV944DT/UeodD4y5VTStGpyIlHQqAde0yZMU1Fkf9z9
	 +QkX1xmyr6yeIlrbhS2qtGZXG+6EYpvqgsVv80FpODrBGJ59M7TTHAZYSdeM9qrLY9vdf
	 CPG1jbeUnfJkDNY65YZlPto+UFcQHn3TLMKzA9B4UWyJWT7Xq7tgGSnJElAqmOTmITQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csBUG3p9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E0606A331;
	Thu, 19 Nov 2026 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csBUG3p9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795069208;
	b=oFqEn7AlMG+KBaJ+233otNj/CA0hrtMAcI7LYe2JkucCfcB8qOppAephxs8/9TgcZll8
	 9ihTt2HByDjMA+u9ILc8vqT1dmQNsSqoSFDTMxz/BjuYWnJk0JHW01qp/dGaMu0adocrV
	 d4FyS7yduMdADwnmojQ3qw2OgVGpth8yTf5pPhYrZlBMtss7RvRC2G3vJNMS77yBot37W
	 MTVvNQaBbLjMN/A47hbDBheGLo63wTRRjEQXD16YcivApbYf7CUROErhvgRaJZkkgFYDf
	 1dWdMX3RyHCcjRZMQlP+VRjI02/DHSBnRYt+lAUCGB2whF3gk1HEuXkSnvVylkECERQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795069208;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	b=x4LeZeq9Sz+H/+Y1BuYbbmDSh41KOef11shrsU+l9haG+bx/lHYPOifxUTWTXkbcJz/c
	 ayqtU5y2XUXMKs68MnhUBhmQi0NBq5HRayibK+uXzjoBghcudQ8UnrkhoEPLpCgVtyq35
	 lePqQ7nQ23wXOqpbZJLaoCTLGyJmA0UCt6YtmbLkYLogVMjdDuD7WCFH/JfiUypSPXwmo
	 pa/Q42inNHMi7kcXKyxBMcatBalLnKBs6ryP5UhiC9rC4yArUAqiTmgqbW7di/iS7fr1B
	 uMbixti18Tvig14G635fa1Fqm8QBVhhje5hcktbvKMZO+7C0GGTLd+xm07NbF1H5iaw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC72A1F000C8;
	Thu, 19 Nov 2026 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069208;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=csBUG3p9BqnQKK0c4HQBMUQYG2t90ruQVgsAFqfcR/jLUV8kQ+uN3uzhIqE4w6fiX
	 aGQa5DiJDTBCow0MupIQjsRGPASZ0E0b/HJw1gUAPolltFLZYhlhwwIIay6azuQLqc
	 2J11Il/ZN+/ux8Sw1WLQXvJQJkJdDoG89pZUesj2/afriTdB1Q23+7ubTEfcohPU8H
	 yligTp+mtk1Gyh4rJsvFOV3gcU3wEQ/pjOZhOYBD0wE0+1AFXt6k2/flwjjN49CdJy
	 22mtHuhroamnCyom82ef+5CLclpFcKbgUxzlNVs1ZfhFdEX54CXYLXScpoW/VeRkaU
	 1yoCZ2D/tH/jA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 467F04B122;
	Thu, 19 Nov 2026 06:20:07 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 06:20:07 +0000
Subject: [PATCH 1/2] media: verisilicon: Don't report VDPU2 decoder errors
 as success
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
Message-Id: <20261119-vdpu2-errreset-v1-1-f8fa403b6a3a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795069206; l=1243;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=pmz+6zoUL7toWQYosmuS4NH+xU1lJuYNQV3oDGrhPbs=;
 b=OYCFLJRuRrbnhDbhNtGXvR4hOd51xcqVX9fSAJzoa1o2Xi3QrAm9+9J1oqKqSvdXVmD1CED6q
 ibtyPRYQXKnAedQ/0X/pd0hfWzk1Gc4ER24OAidPj173RuSexecTNsw
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The VDPU2 interrupt handler completes the job as done whenever the
decoder raised an interrupt. DEC_IRQ is set for every interrupt,
including timeouts, bus errors and stream errors, so failed decodes
are returned to userspace as valid frames.

Check the picture ready bit instead, as the G1 handler does.

Fixes: 879dee56a40c ("media: rockchip/vpu: Add MPEG2 decoding support to RK3399")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 02673be9878e..4bc1bdb41c70 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -391,7 +391,7 @@ static irqreturn_t rockchip_vpu2_vdpu_irq(int irq, void *dev_id)
 	u32 status;
 
 	status = vdpu_read(vpu, VDPU_REG_INTERRUPT);
-	state = (status & VDPU_REG_INTERRUPT_DEC_IRQ) ?
+	state = (status & VDPU_REG_INTERRUPT_DEC_RDY_INT) ?
 		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
 
 	vdpu_write(vpu, 0, VDPU_REG_INTERRUPT);

-- 
2.55.0


