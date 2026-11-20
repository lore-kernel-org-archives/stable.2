Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795142955;
	b=C4YNlJ8c87UB+qzinH3I5wSwFIOhwYSg+df+9Rk9WZApRyb3bLUi1O4ydyhlhDGB1Qox
	 Opc4uduw9WJzLnM498gcpP0nkcIL0ktCTZXjW6ivkp+dg3sIpZDjTdZoVBdc9/ZFIrInz
	 A/DoumWHrcU/XH8CQuLUIBqon94W5dvbhoYU1BFEQXFqJC01Ne4/Hv8xUxZw7XqmL/Q3T
	 dwNsE7BLP/hPzwQVvI5lZgOQy1NjZsu+MrSMCuBggHmtkO7Sxv1xOQyBjOVoQn2SZY93Q
	 oaNHxyyQAll1swjLo7Jf3wa23vmjF3ZEylp6DSFHhhAmWXROgXD45yBSMlZCt77uWmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142955;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	b=oWnz71Sbtc5IQSJboXI92bzaXJGkHlMUP33caAABaE6pxXlsNd5/mCNEZXUrYZHGPk3f
	 atN3JaU/3uAs6XclshysxJ4mI4y9LCYdbTL7af2d5n4dsS8Nnw7zomvMpmxTUXluIvqtv
	 KuOR9/PQRMnWx5ntPIOfb8z+vcgwIvinnXmRORxFa1nekmwEanS8JBvcj8zDOcwg5IKiX
	 f/LFTx5tqYEiAOxrVXrhFDzjrETD1KUv3SWrjgiSwu9c1rugQv1xXcd/ViLYJTJvyLAyq
	 AI4BARtKk8RPcnTe1aDevwqfwqZ2d3JBzniW3s7y5K1DaxdHWJlZLFVqGLW1Xkl1FQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yii2Vdbg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A1606A325;
	Fri, 20 Nov 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yii2Vdbg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795142954;
	b=pUbwlGbNS8XnxxQQABP2hpGBbzRr13SpGLT55t4pstmbdv6W4WcU/JcVQQHya/4mzU4n
	 DeGlo80WXy3Zw0DgWLyJnY4o8XFWKz/hFjyX9M/eQ9WieOKfxpqks7ZXU5JLXAz6BrqjN
	 ldrZR0OE2BbVKfmWY9TOrPeRyfqJbxyDhO2uEkIpt0GcfNPf7JzIEE6W05p0LBOgocH5l
	 TazL5ehk8QuozarIefhtQIGhQxe0oTrNHleDSXsKc35Le63ZeMrrjfUJB9XnO+JPaZLrR
	 1yjrNhAWLiK50iCqrn07/nsxqAiwjC7l4/240ppiOv4dBhSivaS6uihD+G8/tbH749Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795142954;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	b=ZI14rviRUqHgBXZOFEKnDzcz1soS1sZh8ZRW894V6/GYGBiwj3gpC/93aP/1ohVX+agO
	 FH1wtCtRq7sFzmYpQvaOAz4q3G1DCI0c7XWBziBlhe6If/vaTYDCOe9AM5yA7g2gHzYez
	 BTahoYt8cgaklk82YdphyRyWsMdoFOP5JFhK/f9pTxeq/mpQkEUCeJ3rm7asDdsPQfMo5
	 bGyQ+kM0SXP3ZNTNqcTmO8qXqz/5eorysnQHHz578q5aPLNcM87Scohiw3oGQkzgC0m06
	 R35Z/GoZ09GqqlMskzGhSAIRAA6CpvEBSZDvyyugxbxd/9jMKPC09Owa6rIkqD2S3Ug==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 52AFE1F000C6;
	Fri, 20 Nov 2026 02:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795142954;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Yii2VdbgHmH7xPvC66UeSorkqmdYVoFxzRXFnwtYtgc9C6RfdIclugQjaRTgi1fLY
	 DP/bhWHVJGIE6WG9+swcZbuGuBqEdvEuGBbAHlKAAstO5u4vzAcvYGD+ro63MtR3bI
	 fdqg7TdQRuGvPWuYEFV8CgTGWwSIkPDh2gyU8Ef25idA7HQ/zuAuVgLcxhASMBWFfb
	 kVhjZ4Pzvz7EnxGzUggBPpKVb+7iTmYGHYONVZz5oJfQvPAPNkUYcDkE5GtCrKjm/l
	 3lEsOWIWLL6ZTmCvd3GMenKqvDj4aKdNB3MOttadYWuhB9I++4Zr03drMLuqJb3mqg
	 yhxcu9qJrWlSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D158E4261C;
	Fri, 20 Nov 2026 02:49:13 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 02:49:14 +0000
Subject: [PATCH v2 1/2] media: verisilicon: Don't report VDPU2 decoder
 errors as success
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
Message-Id: <20261120-vdpu2-errreset-v2-1-8f4ef55e6dee@gmail.com>
References: <20261120-vdpu2-errreset-v2-0-8f4ef55e6dee@gmail.com>
In-Reply-To: <20261120-vdpu2-errreset-v2-0-8f4ef55e6dee@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795142953; l=1243;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=pmz+6zoUL7toWQYosmuS4NH+xU1lJuYNQV3oDGrhPbs=;
 b=BDh2pWVPFr77FF11sME0qilG5geg/tyt3eY9phIjzcv/4CUISB7PCsPZP4ygzi15iLdIHKJwr
 YaT9K7/UxTpDfHsfEnyR6SoWgpMbieFVUIFumPnUFRY/RPZO7DmTGVm
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


