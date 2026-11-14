Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615255;
	b=n0g6ATOYQ7+LSMf81LCISBmsDmMcmqNAqt3E7Bf/8oDSmXv9uqZMyzexgzACuiJq4mwF
	 FvGhcbKjOD2YtXpgmcUrGGkUBF7RNzJ8wcE884T6Iz4NzWVEYoxhimKZ94BfHYO3fdPfD
	 FQDy9IE+oHmaklyt3kwvaGQ05ajnAlVJ7GHGWwiHq40KpqIT7BYCzL8ue8JiVFfpkJUHM
	 lrcd00cUZJtttPnxfTzw/Ry58lzbY19ifhiwlqlXLlvfbLg1U6p4CalSVwmnDbtrLs0zB
	 katW1ObVk5DTeEBvcBpxlv+vsRvfnfxIU6+Gno3NAtYsczCwwHoEn3GaYRmp6ymdYJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615255;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FQ1LfSq7RW9yRUYVXOUx5MG/HJXut2PEx0C5V9vOAm0=;
	b=wsScx8ZpGHVOk2ZQJ9pxgZu+jp29sxo3sS5xqc1C/VjYfph4jYOsiSCYYA7XHVoP5/8h
	 1+XEnk4DFod8YRPI0Y91xDuIzphNSQTOtNloTzumIPqAj5M+VEQ/k63u+nTDKyD+nnhAu
	 TUM2Tkj1nWQ4cVm6JOZ+X8UbhG6P3QqWoNuDuRi+6cH21tFGEwNIZ3ksU3Dz/ShN4yoQD
	 /lQ9MZYYlg77B+mDvs6OB/mCqrdyKsLx5LVMJCn02Z8HQcj9BIMqkLOsPXqv0iQyppcs7
	 lY5n1Mik8QczbiAub21qoE4UoB1RGbMeBTrd1rHvTtgkoiMbP3IL7m+fQqZKdaY0Czw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ctee2aTQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843C606A885;
	Sat, 14 Nov 2026 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ctee2aTQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615255;
	b=T+csyDrd6KrnenhMwWg6MIgdXtrctUnpK9xYhUmTjsyWqwb4Gdr8SE64gqG6nSH9LLJE
	 VZhd7K6xUrZ+P+pQMYfG5UVIYwPHlSezGewxi4vgZSyJNIlodHXS5eC6sm/Iw8LW9nB4b
	 MHkr5H3yqHtcQS8EiHohhZuSX1+qauiTOV+LZbtt48I+46dTcI/xRNBbbqeIvhwfaV0B3
	 VArYvdMPI0yXUkj5MNTzD4F+mgvz391ns3Laf07S/iB26BHkF1uFUMI8DS1Zezu+L0AJX
	 YUwroMBlowUvu+yVbYOCLZcVG/5BhZmmd7SbgY8BHLLjsYapg9jtTeLf18ZDbTKvcLg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615255;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FQ1LfSq7RW9yRUYVXOUx5MG/HJXut2PEx0C5V9vOAm0=;
	b=Jajq6VshPxqD2FWquq4tN+B5cdhGhxgrXoP1bYSOjYWgvFdcnpvSTiXbYdL/ml6QGj4e
	 SSPnR6eFoqR09uEcdu1kGRqPt8fVDc0eQ4o58TazeMu0jwWcmRaxv5PWKBomlnKkLWaPw
	 DHuRL5rkXrPa4ddFzDyG5K/gO1tOkimSN+y4CMlMeJ2w0ksUkn8n/CV1DB++P8ecjyZKO
	 HXMsF5GCVtAOvCP7u2l+lmAtkmha7S8rQCGOUwK3i2fj52su6FAtUcfG6+eL15v++Eldc
	 knkBaANuvTYp1G1ZYFLFHXsrf+9JjLKNSsPDbLSyqCR7+XT8cddcABYhpW/523gBKmg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 195861F000CA;
	Sat, 14 Nov 2026 00:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615255;
	bh=FQ1LfSq7RW9yRUYVXOUx5MG/HJXut2PEx0C5V9vOAm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ctee2aTQF98y0nsjDWArljxUS0XqHTeilzxVfbuv1eGK6ckI+T0ToQjq0LHRhK85W
	 BIcfTqAxfdY2gJ6aEZE2ST/S7fbmI3wMA5FRouO4FV46hjvNBcNa+C8aZHkLD8YzuQ
	 aPvy3VzE/9I6WUPdi3U+cveUUBDgIbSQ50ZBGpMpe4kIa98yLU0CgSSJlw9FcjeDdy
	 L0x7d0PS86TX1imcwsm6XdDZG5blsRfl+UqZZNxz9DOtlXk4DMQQ4ybDVuwEXTCzM7
	 7JedrLdtIEVsP4jytqKxX5bbQBd9O1AT3C/3gf9xcHPQOhd4lB8cAfPz7xDMhKalXj
	 31gChYpOKyvaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9F39D49BC7;
	Sat, 14 Nov 2026 00:14:12 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 00:14:14 +0000
Subject: [PATCH 3/4] media: verisilicon: Keep the CAPTURE format at the
 stream's bit depth
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
Message-Id: <20261114-hantro-fixes-v1-3-abb78264801e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615252; l=1438;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=mXsqYy0PJIO8RW/ep6ozTJeepcxK3PGTSINO9ycmhwE=;
 b=tLpy5tv59U2Ro7kaItdF8i3ov9qaV21o4xMBS8B4whtF/nSccwrZClo6yLBRnU7Z8mpsg6ps7
 q0YdIYvsTOXC+AOk/OR0fTbBlil3Pm2m1kffIT2kx0hEsZbTxmuxnj8
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

ENUM_FMT on the CAPTURE queue of a decoder lists only the formats that
match the bit depth of the stream, but S_FMT and TRY_FMT accept any of
them, so userspace can select an 8-bit format for a 10-bit stream and
the decoder writes 10-bit pictures into buffers sized for 8 bits.

Replace a format of the wrong depth with the default one for the depth,
as for an unknown format.

Found by Sashiko in its review of hantro-dec-size-check v1.

Fixes: 8d03c2ab881b ("media: hantro: Support format filtering by depth")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 2baab4cf3bbf..362fbc747eea 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -342,6 +342,14 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 		pix_mp->pixelformat = fmt->fourcc;
 	}
 
+	if (!coded && !ctx->is_encoder &&
+	    !hantro_check_depth_match(fmt, ctx->bit_depth)) {
+		fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth, ctx->need_postproc);
+		if (!fmt)
+			return -EINVAL;
+		pix_mp->pixelformat = fmt->fourcc;
+	}
+
 	if (coded) {
 		pix_mp->num_planes = 1;
 		vpu_fmt = fmt;

-- 
2.55.0


