Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795063209;
	b=YlbU/MzuCXvYH+J8hb2j4XfAH4LCOG3yQLtDySuXF4RSvLxlDV/q6cUtvUb9te12ckjK
	 pbgkhNA5TNq5dUbLqeCJLsWjOOmnj93bITc8cdkjB9MqYdu9cCJLftZu58LsWLxfcr0+D
	 IoCI9iXxA7MbsftLjlz0mUZ6VuE2NKLSOPN/uJfcvo6YhxH/8z8jU8FVq5jmZJ+0hmX8/
	 9/gsWJzuS+iGWXsGptAv7piq3X/cdG559xeGFYXCAYkH27bxzqhJp8ypaS/8MGIicRncI
	 w+CjaGmED/2d6OW82YM/iYqwpUY1IDASJotMbFNh/cWKVWBoKOE/PRm6jGZmmu4nlsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795063209;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xYL1KZ42xOkHUH44B4GkVUfmlTrnkWZLD2iTvQvO8g8=;
	b=wJn1ITnmO8oSgrPAKzTh/ObkMjJvPr9VFMzMC+KeH2/lLWRamvRxdCYVQ7q9ow0f0/0u
	 RXmJl8b1virUUoSYal184y0IXmvTjhWjHC09Rm7UoTBHh9+KDlGR25EDiMJKHPxDoQBCQ
	 hhwj1y+WIyRTHHrLYm1lugxa7Ze3DVyTvzfjjXmGiFYz+SWW6V6NHoLkGHiuFRZMynjsh
	 bGBmZ+TpR5bgZ6Pd2EAYXG96OLXIWZN+GcGnyDqQE3r+Q6KHkarWSLeRHVgJzk3rETxx7
	 QV8e2mcb4g0zlRrt5FxPLrSh+kEANGTqei+h50XpUHajnY3lJK5fvhMr1LGWdlGFgyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yt8Lo/Km";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18819606A320;
	Thu, 19 Nov 2026 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yt8Lo/Km
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795063208;
	b=hM0P1CoCmOxndJLu8P6OaciNg9sEWdwaxdFGfF+luBekgd/qrgEsDSgchO+H5m+kpzWY
	 1gjGNfA5LwICnyaY/aGXMt/ve+IWTJNPtoysQ0eIJYMyUqsdl7iu0AZOWJl2349pQ9tgt
	 wq6dm3vzaJJV8ig9aAiTulFoZ4zuw0gVshNvDAyzHIyMJ52vftd/dORqeHat3Krny64x+
	 CwYYqbPdwlxNuIfunla5N9OcS0jMMiqo+qXaqTHRVDGEXKOOMhAjCTzDD3YR/cqaAn37Y
	 dTSOvwo/MIenMPsDkbUcm7JZ3GitGQ8Ky3dqiDdBC+eFhSbMvg8o2xDd7vpjbYf3CcQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795063208;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xYL1KZ42xOkHUH44B4GkVUfmlTrnkWZLD2iTvQvO8g8=;
	b=p1U8C8HESm+VigG84nqeaU6e06rva6XRFIAafsZCO5alXkTIR7BC5yTSICr9t7f3dNGw
	 DMqHU70nWLWq2p1jl12bBkIBah2x+IVCOpWEKR9NTYdKlDbk0LE1l32j2X+mQNDDRCNxS
	 GtJpJpXEDLlFQgHyTXbPqh6ZlPpjkTckt6g1mY506zNdCeb3y9DDMi/CJoUS49WJJ1Xa8
	 TwcD6GWpMvpNk0Ry7rw5+erTfaZjamRneIITNTRHiUD6/vdKR9EzvJsjhHTMrFxFfkmVo
	 MW5Q+eUacA03k/OXtXifNv75cpDC6s7mGAXBIySRgoX07+F/b22w0yWZF8Gl89qd+kw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D26101F000C6;
	Thu, 19 Nov 2026 04:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795063208;
	bh=xYL1KZ42xOkHUH44B4GkVUfmlTrnkWZLD2iTvQvO8g8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Yt8Lo/KmCtphyGE/mxcwuFjEnJgwcR7e55xMH1aY9XQq6S+Ma9omhzqr8/2ur0iZV
	 xa3AVwAOhqYBp0Gp6K9P5uMAp8XF3qYaLfdABNXxWMl71PMYqUkFla4TX0TNSEm85p
	 t38lQaMBd0Zq8WZrKJvAbIlYgSvPBi0/iJq6ptLPjJe5bhqly5xWz2e4Z2hdqdWr+j
	 laKXauRC6MJ9FB+NLISApcu43HXdJ01/VzKwrTJgUY740shutR+7OPUlXYx56y5G0b
	 fpadIfH1niZK7c3lJZwI+kU5g/W/eG/h40ZWrOv2ZYmhF3u0ty/nyZFtAzRngjN3Zd
	 E8Ry07WIpLLWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5F1E04B0E8;
	Thu, 19 Nov 2026 04:40:07 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 04:40:08 +0000
Subject: [PATCH v2 2/2] media: verisilicon: av1: Read the segmentation map
 at the reference's offset
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
Message-Id: <20261119-b4-vpu981-av1-refs-v2-2-7c270158b20e@gmail.com>
References: <20261119-b4-vpu981-av1-refs-v2-0-7c270158b20e@gmail.com>
In-Reply-To: <20261119-b4-vpu981-av1-refs-v2-0-7c270158b20e@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795063206; l=2044;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=M5VkkkdflunTVyGr1Nz/gUu/uiqdpj4/jtKjFiX6La8=;
 b=PfK2nx60qvDot3pPQb8sNiCu7mL5/ewrHcGUlIufCanfGvZ8XhvDNrx0yefrmEzuRKSNZUrUH
 Ixd6+x30474A9F/JgkuxopzmZSIhV5QmLK6it7TPuRYw7xa3sJjGH/q
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The segmentation map of the primary reference is read at the motion
vector offset of the current CAPTURE format. After a switch to a larger
format, that is past the end of a reference held in a smaller buffer.

Use the reference's own offset, and skip the map of a reference of
another size (the spec then uses segment 0, load_previous_segment_ids()
in section 6.8.2).

Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index b331ff234878..21a97a57328a 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -910,13 +910,15 @@ static void rockchip_vpu981_av1_dec_set_segmentation(struct hantro_ctx *ctx)
 	    frame->primary_ref_frame < V4L2_AV1_REFS_PER_FRAME) {
 		int idx = rockchip_vpu981_get_frame_index(ctx, frame->primary_ref_frame);
 		struct hantro_decoded_buffer *ref = rockchip_vpu981_av1_dec_ref_buf(ctx, idx);
+		int mi_cols = DIV_ROUND_UP(frame->frame_width_minus_1 + 1, 8);
+		int mi_rows = DIV_ROUND_UP(frame->frame_height_minus_1 + 1, 8);
 
-		if (ref) {
+		if (ref && av1_dec->frame_refs[idx].mi_cols == mi_cols &&
+		    av1_dec->frame_refs[idx].mi_rows == mi_rows) {
 			dma_addr_t luma_addr, mv_addr = 0;
-			size_t mv_offset = rockchip_vpu981_av1_dec_chroma_size(ctx);
 
 			luma_addr = hantro_get_dec_buf_addr(ctx, &ref->base.vb.vb2_buf);
-			mv_addr = luma_addr + mv_offset;
+			mv_addr = luma_addr + ref->av1.mv_offset;
 
 			hantro_write_addr(vpu, AV1_SEGMENTATION, mv_addr);
 			hantro_reg_write(vpu, &av1_use_temporal3_mvs, 1);

-- 
2.55.0


