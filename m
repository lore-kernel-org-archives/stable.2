Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473699;
	b=UqFsJbLd9XTryPOFQf0RFZw6iuUnUyVlbQcD01C+1fUx9y039jHqQcGlZHntKFSQmCEE
	 bhnNhlTMGqIw7h5T5mDb3mMO55QsmEKWWqlDM1Kj7Dd0kS4QVrFMsLdV7bNWjGYE+FCb1
	 eQmqYqyao3nxcNozXIu9PW2/0feJNshBHTQ4DKEW+CjR/1zt2aJi9d6Z69ERAM3PJudw3
	 kNksDb2WaU0MbND9dItjo791guKr3wNbKcVmUcaHeUbTe7NUpqB8ekwXYcemkbRtJKV6E
	 sAEpV7yHyjiXpZvRiQAzCTIpl2iVfyYiqaCgcJZejjuAO084HxxHPrza0r0++eTKggQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473699;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WECNd7JSglyenV0IG4TXcEc5kXGA7Avlj46c3tWdFVk=;
	b=wKIj78LNf7hMnQH08ga1zAnBnvw1znMMg4y73F/swX6w3E/TvoknQeg1SL/WxeR3uBdL
	 9aTYpbm5pc9LKnSFgVtPzaeTvaAIrJsoXmsuTiHZj3P/CuAgQcMQ4luPM8gE7//oBDgGW
	 rw+tI0wFYA77est3nVnFvhlPmwOO9xcFFpyb7oxZ98+S5n5bl3VGR1xKeM7zGHW0YlOCe
	 L4+eMlc2TEs9BjpTuNl4g3018vC2mtB370yRyifcyHQYhyBunbK+qFTCPuXuw2XR2Cvuu
	 rQh/qV7WlzW50x6BIfoF5l03r0gPhegPrp/D700BH45oAU8GW2lQPhzajBKoGpypj5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbnrx6CT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268C60A2602;
	Thu, 12 Nov 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbnrx6CT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794473699;
	b=xb/7LUbDP5s0StwdpBo5eMEng1SidoGDh5qQHD4OVNSlMn31dHyLIG53eZRem/S3lYaO
	 E+mqSIV+GVYzJJ5YXoO5sx2KFtuAqHtXyxbNPYkQ1Riisz7kQ7CVsGBimLEZmlZamW8KK
	 Gffsk1FZpRnYXCAOWw7GeARzrmWFI7GPONFEes1iICm1uktW9zS5pBxlhru+tUFZxuoTQ
	 NnpTS4F6910/Q/4vrjzZ4lx5q9oUNiwq5Sdl4wz95Zs6JvHQVMU4S8Id4loRQtQbbJbuY
	 UdpDTDPReEk6R+pqbLrjvWxWmpAf5mu8VlINVDOL8VJ3hjYMHbGQdj2C7Kz60L1TmSg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794473699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WECNd7JSglyenV0IG4TXcEc5kXGA7Avlj46c3tWdFVk=;
	b=Z4c1zxpyRneG8dmkLKsX6IcxbeyvZdySnXOe9i6sOCQwlnh65Dq5o4a7uZj+jeesnUs/
	 mDsy+0q8S6Msr7KDph9BG09sArKT430wjeE/UC/y3jJ3y89xVG+/s4g6XIcVYUN15gZMi
	 kJGd4elr1Gpf8J35ys+0h4tutMLfuapHyP2jqXYlWKUd9cC7YmGe3AMuCs18AqOxjZyhV
	 DphmcQucKb+bSp6/+fhSLJFGvOZHcjuob8+2pCbFX+xnnDWR796FiiVNO8Q9ixL2g6cfR
	 52K2xgoOsP1H6H8ZWqAqnpjO8dePUBFusrj8pR4Z59VduncDVZZj7T9HRX45ANShK2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9128C1F00A13;
	Thu, 12 Nov 2026 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473699;
	bh=WECNd7JSglyenV0IG4TXcEc5kXGA7Avlj46c3tWdFVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nbnrx6CTIrWvDKeKz1jpAw/wnu0Bw/J5lLM1J0CNGx1MWjlWt17nLc9BLDXKf+Vnu
	 NyC2SghZP0yTb0sXIbRhqF7B/rDdTzcMjViIuSi7FMYsyUEyrPKERtbqYG/XyeIwHT
	 ZYTwGAdA/enyGMU+S8dfwzlcAiBVt345gneAfg34YuNRrjAWqC037YcTKhqcR1n+lm
	 lO3m7BnTb0IM2jEE+VmHYCE3Jslc+SxfyRvakeMK9g6BNypj+nqFbCcLzy4yVQePvS
	 OdJCuJtGqfla40PppjyGHRcUgGCoEcJbK6gDsDDxe6mdsJHZXb8p8czA30Z589jwmT
	 FOKiYtSxd1UAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4F1904941B;
	Thu, 12 Nov 2026 08:54:56 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:55:00 +0000
Subject: [PATCH v2 6/6] media: verisilicon: Reject AV1 frames larger than
 the CAPTURE format
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
Message-Id: <20261112-hantro-codec-fixes-v2-6-f44424df585b@gmail.com>
References: <20261112-hantro-codec-fixes-v2-0-f44424df585b@gmail.com>
In-Reply-To: <20261112-hantro-codec-fixes-v2-0-f44424df585b@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Fricke <sebastian.fricke@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Tomasz Figa <tfiga@chromium.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473695; l=2755;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=F0sBvLxC1b6DWpic9ac/w+3lxIegpPEHIfh/PZ7x1mA=;
 b=fZk80umJ9nhQFUKVcYAIaAf4QJ5vg4VBbgr3VYDUCzayQiz8NtBQ48aAKvoBnkUWy5eGamjKK
 /fGPWQavH7vBh6ZyfY8TNUDzW8N+a6EJaOMlTxeuQpjzcV+W+aCA9YH
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

frame_width_minus_1, frame_height_minus_1 and upscaled_width of the AV1
frame control are not validated against anything, and the decoder is
programmed with them.

The decoder writes the luma, the chroma and the motion vectors of a
frame into one buffer. The size of that buffer and the offsets of the
chroma and of the motion vectors in it are computed from the width and
height of the CAPTURE format, so a frame that is larger than the format
does not fit in the buffer the decoder is given.

rockchip_vpu981_av1_dec_tiles_reallocate() also sizes the tile column
buffers from the frame height in 32-bit arithmetic, which wraps around
for large heights, while the hardware is given the height as a 13-bit
number of 8-pixel blocks. The buffers can then be smaller than the
programmed height needs. For instance, frame_height_minus_1 = 0xffffffc0
rounds up to a height of 0, so the buffers of the previous frame are
found big enough and kept, and the decoder is started with a picture
height of 8185 blocks, 65480 lines.

Reject frames that are wider or taller than the CAPTURE format. The
format is never larger than the decoder supports, 4096x2304, so this
covers the heights that wrap as well. Frames that are smaller than the
format, as streams with spatial layers have, are still accepted.

Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index 8154b405ca63..016f11f04a80 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -533,6 +533,18 @@ static int rockchip_vpu981_av1_dec_prepare_run(struct hantro_ctx *ctx)
 	if (!num_tiles)
 		return -EINVAL;
 
+	/*
+	 * The frame size comes from userspace. The decoder writes a frame of
+	 * that size, upscaled to upscaled_width, into buffers that are made
+	 * for the CAPTURE format, so the frame has to fit in that format. As
+	 * the format is within the limits of the decoder, this also keeps the
+	 * frame height in the range the tile column buffers can be sized for.
+	 */
+	if (ctrls->frame->frame_width_minus_1 >= ctx->dst_fmt.width ||
+	    ctrls->frame->frame_height_minus_1 >= ctx->dst_fmt.height ||
+	    ctrls->frame->upscaled_width > ctx->dst_fmt.width)
+		return -EINVAL;
+
 	ctrls->film_grain =
 	    hantro_get_ctrl(ctx, V4L2_CID_STATELESS_AV1_FILM_GRAIN);
 

-- 
2.55.0


