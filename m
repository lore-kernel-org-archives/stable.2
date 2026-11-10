Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313999;
	b=N9JN4wtvcbT9HzOZWotHo+wswzfdzYdipUPRTA+iiyiyj7E6yZoAfevqr/UXteQEbA8P
	 SnpAcWfAICaDFsTirM+8DZxBQLdTm4NYXJy3BoKSa9mfthaotFxO68emMl8fA52BH7VNC
	 QY5uK4RX+dW8p3Jh6sjEWfSwpz1KexsinfW99pv1s7svobHcBsYxOadeGE0nrr9lP2Tit
	 L+8OF/YcTDumEWTyHpyy33CCtr2FuJT4oVLMOg3E+m+vDprsNUUGCxN/HuLflvwIybWAZ
	 3GJ9DsydDsrg+QZFDCEJ9rRl/xek0+OpV7SNplNjyGsBWzIjWM0zRR6iL5htVxOp5Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313999;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7inwf3FxL5Kj4TLVs/bPWMcJn+NH3q72yh4J0x+dSrw=;
	b=MzNp0uJar7tCbKPWcNx5uLy8gTuuQS3lqHlB3hEcVARBxBADS56NsR3ce8tKSh71099g
	 cqe7A3tdGs8zcZuCGx+I//zMnGHYVWt1uW7zaW+PiNYzRhFcTMWbOir9C/zraOaxPn7mo
	 VZDMEDQWy1ZNWg4iFcUeHsSid2GWxopaRLZl/2DDRy0rTPNlgqeK0Hspn6GC8E7vpSve2
	 TjkRUvTKiyKg6IApLOcyQhFiRut/P646sz0JY216AhF/AFCpmcctsVOp2SEwOnOaxxg4K
	 BpX60eb59TCllqVp7c6sjeCc55AAJGFXXKwTapHoTi4FucvFKTFRdeJ+BdFclnw3APA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VU4WSERA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C65606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VU4WSERA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B43F1F0089F;
	Tue, 10 Nov 2026 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313998;
	bh=7inwf3FxL5Kj4TLVs/bPWMcJn+NH3q72yh4J0x+dSrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VU4WSERATtya+8utzmH3ezQJL5sRuQ2OQOAa+rDXRzhyJ84dLU4Ops3fuzLvbkBn7
	 vjuSvF8SGNyZgOEuMDhgkjx3aTiJodkDDQf8IpnMCQ+ldzEoJB5QFatnGo+RRLX9gc
	 OqvFi+TGddiL4NEQXmg1d1JKRnJ8vNHxuIkY4pYq7KARa16XpCtxruVWP5O2Lf+7eL
	 8BbJGzrESkF3WxnQh8hDHqdz5oGyCEi8dNI7jVvFlh8crIZj91CpaQEYp8ywvwyzcG
	 QlpFCQQQ/SvG6gKh75QzcWWQmk/GIHq4UIcrYA9O2oUNzZDndT8JW0FFwxToMd57Fu
	 I3KOZaufEBHAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: v4l2-common: Fix P010 format info
Date: Tue, 10 Nov 2026 07:33:17 -0500
Message-ID: <20261110123257.1097462-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054354-failed-6.1-8761a87aff82@kernel.org>
References: <20261107054354-failed-6.1-8761a87aff82@kernel.org>
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

From: Nas Chung <nas.chung@chipsnmedia.com>

[ Upstream commit 8761a87aff8259eab0add8a9428cee2c280fb6eb ]

V4L2_PIX_FMT_P010 is a 10-bit 4:2:0 semi-planar format, but its
v4l2_format_info() entry described a 4:2:2 layout with a half-width
chroma plane. Correct bpp and vdiv to match P010's real layout,
consistent with the other semi-planar formats.

Cc: stable@vger.kernel.org
Fixes: 5374d8fb75f3 ("media: Add P010 video format")
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: Omitted the bpp_div initializer because the target format-info structure lacks that field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 1c8d36684809d..4dd75dae2484f 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -266,7 +266,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
-		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
 		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
-- 
2.53.0

