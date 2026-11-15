Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794731988;
	b=cCjF0QpHDAvr9pKjDLIFQ9+nCXIpkPLLAMDggfqI0arDcJ7nYe5PNY5W4eKFXXogsJ65
	 OEPe6Ju3CQi2QxSFUNWPPAL9jex5jhplm6+8jsv9ca7mGLp9lBfA2WfNV/PN3jVLrYoSY
	 L6nbUKyCiwJbc5qUBL5y7MCGLHLAKCCpj6eX5JfvI3F3bBsQx2GxAd97yd01OiNr5Gqa/
	 HMTWu+iNYv3D8+U5tom+SGjJwdN0z0rktczFqQIrhwlX6ipnKNhWMPn4PCTmRFz/mT5v/
	 7ntr0B/4wBXI6/xBcuV1A3Tn2pVUTMPrd0+KOXSGt1zDwq/gZmJrH4Ql4lVdz8Ntbgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731988;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8I6WPL1BhC6uEnI5D/7lzAS6mtAB//YTXmIP/p+4oZQ=;
	b=qkFOtuMljsDKk7zOeN4aeDsLNE+nWJhWKa1fb2s1xP6Bz3xrJa3ANT4yFt9dRMI6Rc4H
	 TRW3JFfGFm9oiSprfMOb+7HsWwPAao8ax+h0B+cD/n2AGJea3eSWdu4lBGwOIhfyWHSwH
	 RPTaSyaYZ+C9ZEfSbFLhvCsLM0+Pm6ziYsSjq5YSIN6GI5V1ebNZck8kAJwl+RY9kEHdm
	 jSFe50IksnvrEs70ZdgV/dmfp0sncXSlVsOqYIaz7iwnelosXChiUzd/0jGQ3D6cbYKqr
	 vNQoXORbxD/2ouxJJucUqTJYssb2hEykaBjs0FNwsN6lw5mDAHh3K0toepWOOERd1Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHzj+VRS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15564606A31F;
	Sun, 15 Nov 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHzj+VRS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794731987;
	b=JwNILg5pIm1ji77e1xUUaDHxOI1J+pEa42aKM7A2DYSVZ1G2+ltN9vJ5bbu8bbnYJk54
	 PChoPisUOz6zzXA7L9jRmSkKTrZe/pO8FAuHsJNbWcMjArG7utGsGLE193tdUM9Qhjg5f
	 iihAZYuf+7eA9FJpXAhzWGwq1edauQuh0COr3QqEme/VIrOUnoanSg1TCr+Br4TSxRRUv
	 COSGyOpoLENumj21Q6PvJmCaUxYod6hgi5OatpwxGOUQL1YPzWsyCeomrySkNapbNtwzr
	 NZX6bQXZ4yJFUP972/pfnX/GNj01qgl6SHtD6APPf4r3YtOC4VSdgDn7LmJ92aNApEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794731987;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8I6WPL1BhC6uEnI5D/7lzAS6mtAB//YTXmIP/p+4oZQ=;
	b=Q1VtFNpzRLN5I7qHnpJiy7XFlCuR899+OMyk7YZk5jA2kUrYPdvIX8Mk+PuQrYwv0gE9
	 hA8hDrpvJ5aTar1sijcNver/Io8lg0ST6dJAO8jLULYyDPch/Ek2jk8NbyJ9IrF0um4da
	 Klbb+3kVsXyf7fU+w64sH3ScmJGztobuGOuWk2F3xz+S32ZHquYvZ0Ba/rtgSyo2iDUQS
	 lw0axrLbRoLN2a4/AUhEz28eUolgrdpm6a8Op/16gCSDsUjzAou8zW1CLNAU5TOAy6eFu
	 Vxxn54mzMMhn+5CdJrGr2kX49ebzfFI9XLzgfsknSZd+zpV59I85uokIxEgoVk0WfqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 011731F000C5;
	Sun, 15 Nov 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794731987;
	bh=8I6WPL1BhC6uEnI5D/7lzAS6mtAB//YTXmIP/p+4oZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HHzj+VRSHu8gLobmqqoVuE8AC9c7nA8X8+mD8LrcfqW4ZGRarB4DucohMYklzJOWz
	 Z2NzJK/aA78ers2IruyB4ehp/GUBW33rbaqfxR+HlYBYTUe2Ci0BWEAHc1OKnzUJhK
	 ky82BPr5EFH0mxga5WklTyya9j5KMrA5ZRcGGEov4XamHKpekOmSOCuhXIVyQ1G71t
	 h3dVNS1QVwAy+5IMWwFObLcA+oPCXsLxUB26eBQzj6IsP7N4V8aYbNlrwQg548G5Oh
	 cjekEwXGAz0JwZA+KhnQLHDnF2uNvAxjsXxtqD6IqWEMWiHnoJBAHVn/2AxCp1iaYM
	 OTN0Z08XzuNaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6C54049FEE;
	Sun, 15 Nov 2026 08:39:46 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 08:39:46 +0000
Subject: [PATCH v2 1/4] media: verisilicon: Size the VP8 segment map for
 the largest frame
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
Message-Id: <20261115-hantro-fixes-v2-1-bfecfb07a3e7@gmail.com>
References: <20261115-hantro-fixes-v2-0-bfecfb07a3e7@gmail.com>
In-Reply-To: <20261115-hantro-fixes-v2-0-bfecfb07a3e7@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794731985; l=1178;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=HL3Blb6OWyDUqsGQviHP7B92VIrg7DTEXdqj8j/7nqU=;
 b=URFopEk5oS38P36Xwr5aN0tmKgXZZJP3hjScqQ7OJNMmx9tPMQBLbZNUh1y3wt6NuOamQ+j0N
 +ANmer4lhJKAinZXiGcHEnq5GMutHJAjFs7HSl2II1X3w3Sm2sHoQy7
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The segment map is sized at STREAMON, but the CAPTURE format can grow
while streaming and overrun it. Size it for the largest frame, as VP9
does.

Fixes: bbd267daf4fc ("media: verisilicon: vp9: Allow to change resolution while streaming")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_vp8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_vp8.c b/drivers/media/platform/verisilicon/hantro_vp8.c
index 381bc1d3bfda..98ad86269bc3 100644
--- a/drivers/media/platform/verisilicon/hantro_vp8.c
+++ b/drivers/media/platform/verisilicon/hantro_vp8.c
@@ -151,8 +151,8 @@ int hantro_vp8_dec_init(struct hantro_ctx *ctx)
 	int ret;
 
 	/* segment map table size calculation */
-	mb_width = DIV_ROUND_UP(ctx->dst_fmt.width, 16);
-	mb_height = DIV_ROUND_UP(ctx->dst_fmt.height, 16);
+	mb_width = DIV_ROUND_UP(ctx->vpu_src_fmt->frmsize.max_width, 16);
+	mb_height = DIV_ROUND_UP(ctx->vpu_src_fmt->frmsize.max_height, 16);
 	segment_map_size = round_up(DIV_ROUND_UP(mb_width * mb_height, 4), 64);
 
 	/*

-- 
2.55.0


