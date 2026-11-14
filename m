Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615256;
	b=wEtrnENVUZrju39JnRIvLRHgQHrhA6pBNAlhFEPiTs9UNm0d6KQqHM8AK3ZhMx/YqQPN
	 b1XLTpckUuKd+QO15Nami5vb7t/EohVusktVsSp69eiaPD+nZCWDHzsXaMayOjqhul9y8
	 +qyNR78ix/J/usz8a5khdxsK6/L/3R2Q6cx5VDE3QTPsf0E8u51DDLOcE91BLaxkm/2Vd
	 O5JRjdOGhRcjYhuKdbGswNsVgeYb3vQqKZL4angrzLse1Rd8G4fk+KGfKBE14OvnesTuT
	 a2yg/fWEWtxnfXzu0vMArVKFkQPCBMMU9GwrM+X2LT8hnKYgbXqiRJPvzcGQCyroAHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615256;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YXWqWTsUvzu6GfTNAs76N9VFY+Z2orZHnwJxeJ8LOlE=;
	b=NopQB1UEnRaovouUaT81FjXwrgh04YGdC84fo3Wnj2CgIwmUP4SES5IG9PeaxuaY3M5O
	 Lqu9r3xVorrnhM3JvtDQfBNTcfXuZiJIv4v6HCbyun18qztgtwABYH29j2VR1VyOsx//O
	 yNqVJ3AVpkuruyGsLJrmMA8aPn/W2DEgUxbWjoW1A3u7Ljg5fS0ld11R/xusbVhZNyyLD
	 fTgR/7OTr7wcSctUsdEB6V2nLzmv40oEn8E/hvVbJerOKmSqV+W69bIOd0v5Ucx4QCeoJ
	 0PjwtTMtFFfFQ0QX8T+B3FtwYNLkkEUgn6L9tijnITuDf2WjCzIzgSJB12kKpYjdW1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkrayVJU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE67606A89A;
	Sat, 14 Nov 2026 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkrayVJU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615255;
	b=N8/GDuWvezJuoFG1dTFBQ9d/BuoT5Rxkke86oucdqjBieXf0wlaMvmY4Bx6IeoOEvqgj
	 /aG70sGChyhVMnVphWkjglCn0UpHptbII5uel36bvX8g0RqcAZX0MJml7Fm58xYjyOiyp
	 3JwRNP+N4275rDwxIQYuGpih5h0+HyE8hzhBE+PlKOdxBlrBvQeQb3XWq+kRizif6gUQe
	 OJqGaSMzfUrovmt6Ic8mlie/oQxzV7gPxVnv0uodxhMHYy/u2So6ou0m5QmOBzkNUZkvZ
	 v6ZRdjYNuQ2qxlcIZJGBZ82DwYc4A+zJl5WNJ8MZfGMrA9Avx+ud0k0HTfte7Hgl04w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615255;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YXWqWTsUvzu6GfTNAs76N9VFY+Z2orZHnwJxeJ8LOlE=;
	b=UJli94+zetiwthuvgbm/D2KZdDd4AKMji4Z4Cbe8uJntJTmNaZeWHR/WYshm18jtU0Ze
	 4djCjWWYgdsPmwuunXFMebHdIfXYr/GZbUzw0kb2k1bryeF3Svv+C41Xisf3t5tbdvpPa
	 oXfiSQuZ5UAuV+ETud54tiYARlsGY6TDRg0dDg+HcrFXB5n5A/AhSzNFYpGjonzBC5urm
	 RAaeTANX3S6XkivgDPhIWrDQWwqb3ugCHX3ZN5NmeEivdzaJxdNDWTkpce4L/JRVbaEZ9
	 +yOYe+ON7CTHOAqk+XUtmUQFmzh0Ci8R21KABYA6e0HmYO0XGiR5yNMupm2h7SKmbSA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 04DCA1F000C9;
	Sat, 14 Nov 2026 00:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615255;
	bh=YXWqWTsUvzu6GfTNAs76N9VFY+Z2orZHnwJxeJ8LOlE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AkrayVJUUEioWGqXReZaaN9DSSs9XCb2sIBGMD36JUI3kAXLqoFz8UBdZ6XW7qaYD
	 XqBLsQD8J4NjwSfgk/h6XLa6QbGFFmQ+WQr4dgTlfxGNK8MkNRWrbuzWiLjT7CeL2A
	 alodGjdvV8CrqBkRB7nkgLxHOK5Q5tJQnH+7xEQyalZUQO7p+nNclMPIhvlWom7rjc
	 20P8VQqZ+VTulS2VZdAyRpmKnM3yBAP/CeRRZ3vURAQb1qnPHUh4q2+xbBPq5rnrCD
	 29yPE1AcoWMWvtq559cKUmsINFLJ/wRhrLxscuGBetF8Pj0QxiNRRNFQOv5k/DXoaW
	 vJXNS6fU/JI6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8A85549BBF;
	Sat, 14 Nov 2026 00:14:12 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 00:14:13 +0000
Subject: [PATCH 2/4] media: verisilicon: Set need_postproc before resetting
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
Message-Id: <20261114-hantro-fixes-v1-2-abb78264801e@gmail.com>
References: <20261114-hantro-fixes-v1-0-abb78264801e@gmail.com>
In-Reply-To: <20261114-hantro-fixes-v1-0-abb78264801e@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615252; l=2134;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=K/OBfhFLZqelp4gN8EoRryPycBadFZf1ehuMruueJ3I=;
 b=K1Tm3Mg18Zf0xKACgdOObktcPQmZDw2LPUWDZZU4RmQjvmOo0nhAqHCKKwf2Cmh9SwV1NuYuw
 WHOKYE30lRXCA2c0N2BNt/yRi8N/w0JFlNf3RaOA43xllqFKr6SuasZ
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

hantro_reset_raw_fmt() stores need_postproc only after
hantro_set_fmt_cap(), so hantro_try_fmt() sizes the new format with the
old value. When an AV1 stream drops film grain, the post-processor goes
away but the CAPTURE format still lacks the motion vector area the
decoder then writes after the picture.

Set the bit depth and need_postproc first and restore them on error.
The next patch needs the bit depth set there too.

Found by Sashiko in its review of hantro-dec-size-check v1.

Fixes: 80c7373a456e ("media: verisilicon: Conditionally ignore native formats")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 83af9fa1ce94..2baab4cf3bbf 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -449,6 +449,8 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_postproc)
 {
 	const struct hantro_fmt *raw_vpu_fmt;
 	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
+	bool old_need_postproc = ctx->need_postproc;
+	int old_bit_depth = ctx->bit_depth;
 	int ret;
 
 	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth, need_postproc);
@@ -465,14 +467,18 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_postproc)
 	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
 	raw_fmt.width = encoded_fmt->width;
 	raw_fmt.height = encoded_fmt->height;
+
+	/* hantro_try_fmt() uses these. */
+	ctx->bit_depth = bit_depth;
+	ctx->need_postproc = need_postproc;
 	if (ctx->is_encoder)
 		ret = hantro_set_fmt_out(ctx, &raw_fmt, need_postproc);
 	else
 		ret = hantro_set_fmt_cap(ctx, &raw_fmt);
 
-	if (!ret) {
-		ctx->bit_depth = bit_depth;
-		ctx->need_postproc = need_postproc;
+	if (ret) {
+		ctx->bit_depth = old_bit_depth;
+		ctx->need_postproc = old_need_postproc;
 	}
 
 	return ret;

-- 
2.55.0


