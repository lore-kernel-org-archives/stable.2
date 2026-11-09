Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794231840;
	b=yTQp2YkSpmUbGK8yr81nlV2UrDuFC3PTAVY8UlCC5KcvH+0AEMziQDJTg3FgTkVkidP+
	 TFR6SFic8KRyi2IDAaxmXrkZUC/zBTHlSTUSpkvqA/1D1eVbOaEf8YVbWeHsuYHamgPGY
	 NUkDjoJBMGmy9JeE7nFF5A2sopUnyPU40adZ5kNqAX2nRwdKKrROc5g7WjfXS196PmFdB
	 iBeQZTffSTwv4ZdiOIJhBNQ4GtiWI5/LcP/vUkJRVj0xFzfp6X6KWfilSerFl72ycYTTS
	 gJ48kLp5NDq3O8RKLWfisdORMpgMaFXGiuhNn8NDS5i15gIi6O68gFdxjL2VZ8mHiAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231840;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uQPEtNnmLlScHzIoED0cbGAI+vw3fcSsbnPTSfV6adM=;
	b=YzLO/F8t3ECGAqfBToNVaLHNS/GUpgLy47PzG4oqnsvTgpK4RJoiZDoJdD5U+Ac8CFJV
	 EGa90TXcZcl6PQ/74KqNszvxm4je5IdmcQZjsGYaEexH5Rca0i/hPbFS46qadZmT75G0r
	 WIdW1aCZsSAqyiSe5n9ahAHIsPStHonjbBU57HqoL7akHq87S4bMAvKJVbYYknWu8dfxK
	 birbXi5G6sauwGO/SrYApsDbEYyo12tzh4n7bfaQEqpGHD7+DCMWNu4HejDbZ2mPAzOwK
	 wppT9i6qecW5C6jnKdQuG2T1X08RFjjXzKgpJ5SBDkQmX3ABWGXPPIOwc7T6HLPu2nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFv5ScoH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3402606A32A;
	Mon,  9 Nov 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFv5ScoH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794231839;
	b=lG96xWLSy5XFfp2TMOIYrBVkKaQ+VBADwRz4p/M2sUwZ5/zRbjGhLs8jHA/fTInXt5JH
	 NHFM+sYE7acMZlympfex1cMEKiMDe6+On9ddowo53UTKLm9ALHa4dqFzVSuxLEULxy0Ki
	 ZZ1qybt4b8//Izwevapqm3OmDfnYgWGyNW/v93AKFdCnNA2aupdg58NUpxkfIvx0mb8j3
	 wZ9uh3gx0PfODpVk2rfNhbohELad4LNpwnBKzt+WwrGSRLMtoGicZIS0FhEDLnL4aQDlH
	 KmlHqT6o+pWrzGWeaMG2sff4tfFiX/kYU6CYBkGZ+3sds15gvl9sDQ9MCdDPgt0Ixkw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794231839;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uQPEtNnmLlScHzIoED0cbGAI+vw3fcSsbnPTSfV6adM=;
	b=cqm9nPwAZPY2fjZiArfLYyw3VQ9gCurGoqhE4NwI3DMMQe5mz3jfA3IXNnVA7tFMjGmt
	 ZbIK05gmypGp1djMFkrTtp+DJ1GHpwRVY3mLsGPmMDWTENX0Cib9vGuXhEzLjyVYvi4+O
	 Hs93N0N5q5Qoj15r94F2/CS4uhh4Rz3L+WiXpqza8o5Ub+5+lHOD3yoLPfYIf83KuqIM5
	 ugtHYRhmDUm8oJEzLQy7hFrTzJ4FadHkkXk5hvpRqJJ3HO/99wHzed43ITBilyEjPTu6v
	 Kt7V3iXVH1x7w2IVBCOWO98hZhBz0E0UYhhfIYijp9QjGFeYQcWWxgMERGbQAdJHPsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A2901F008A3;
	Mon,  9 Nov 2026 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231839;
	bh=uQPEtNnmLlScHzIoED0cbGAI+vw3fcSsbnPTSfV6adM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OFv5ScoHr6NEX0ohHKaYpAnOpZrheTiWrjXo99Rlw0ygg1U/Dn2oZPucD7D+8evGk
	 3ZdZ6nLr/wwUQMeiwrO0+o3V4FNVo6AKlCD15SjOWuyiwb6dBPGZnlLzTGRsZQvJAq
	 rcRTKisoxYnKf1AqpS5adK5I7K/uq0hrDQb95ZRoLAVRLBuq2paQZqIW2tjyQ+s8ol
	 a5IWZTRu+qt+El3jWoPmmaqwBKUVVvrALlDIhQjxzRRg2Df/NeAtmCw2ybQ5w2EVdm
	 HY2WvmPMfTprGz22zP/oPpqBZb14pNIwXoecP2b5HKsQnWLFs5UleEunL1Acfd0lXo
	 u+z+Buf8ObpoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DFA6F484C5;
	Mon,  9 Nov 2026 13:43:57 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 16:43:53 +0300
Subject: [PATCH 3/3] media: verisilicon: leave room for the JPEG header and
 one stream burst
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
Message-Id: <20261109-hantro-buflimit-v1-3-f0b86ce61e66@gmail.com>
References: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
In-Reply-To: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794231837; l=2875;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=WFzfE2RiWdT+i+qq0glggXPv17AxZu0PiVwPxE5rxXQ=;
 b=pPK6FLWKeibNzXyvohaaL0PsnBvzKTougQAG6KwXp2yfxpo4tasR1lz+/mNE91PalLZ0uU93p
 0Pp3dUaw9zCAA3hw1AA6gCnAy32OCAfz/TuRbgsnNesnOQZWA78mcPb
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com
Content-Transfer-Encoding: 7bit

From: Sergei Khomenkov <shomenkow@gmail.com>

hantro_try_fmt() keeps any non-zero sizeimage on the JPEG encoder's
CAPTURE queue, however small, and hantro_buf_prepare() then accepts a
plane of that size. hantro_jpeg_header_assemble() writes the 624-byte
header into the plane with the CPU before the hardware starts, and a
plane smaller than the header also makes the WARN_ON() in
hantro_h1_jpeg_enc_set_buffers() and
rockchip_vpu2_jpeg_enc_set_buffers() fire on every job, which userspace
can trigger at will. After the header the encoder writes its stream in
bursts, one of them even when the stream limit is 0; on the RK3026
VEPU1 a burst is 64 bytes. A plane smaller than the header plus 64 bytes
is therefore written past its end.

Raise a smaller request to header_size + 64, so that every plane the
driver accepts holds the header and at least one such burst.

Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board (VEPU1); the assistant also drafted the code and
this message. Tested on that board: a 640x480 CAPTURE format set with
sizeimage 1, 600, 656 and 689 reads back 688, 688, 688 and 689, a
656-byte DMABUF plane is then refused with EINVAL, and frames that do
not fit a 688-byte plane stop exactly at its end and come back with the
ERROR flag. A request of 600, now raised to 688, encodes with no
warning; before this change it was kept, and the encode hit the
WARN_ON() at hantro_h1_jpeg_enc.c:50 (hantro_h1_jpeg_enc_set_buffers(),
reported in hantro_h1_jpeg_enc_run()). Also before it, with 32 and 8
bytes after the header (a stream limit of 0), the encoder wrote one
burst, 32 and 56 bytes past the plane. The burst size is measured there
only; not tested on other SoCs.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 83af9fa1ce94..cc35beac8338 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -394,6 +394,16 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 		 */
 		pix_mp->plane_fmt[0].sizeimage = fmt->header_size +
 			pix_mp->width * pix_mp->height * fmt->max_depth;
+	} else if (fmt->codec_mode == HANTRO_MODE_JPEG_ENC) {
+		/*
+		 * The JPEG encoder writes the header with the CPU, then the
+		 * stream in bursts, one of them even when the stream limit
+		 * is 0. Leave room for both; a burst is 64 bytes on the
+		 * RK3026 VEPU1.
+		 */
+		pix_mp->plane_fmt[0].sizeimage =
+			max_t(u32, pix_mp->plane_fmt[0].sizeimage,
+			      fmt->header_size + 64);
 	}
 
 	return 0;

-- 
2.53.0


