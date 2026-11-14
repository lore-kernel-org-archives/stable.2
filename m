Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615255;
	b=Jv4glO5gRs7ojUW7tR/spFA4vVKpXnTpazKp1g1NSfLogY6s/J/nZEqTIXRJjg6p47Ga
	 VIlZlKVstPgNm5dD/tyDNdoRV+BHF7JF/9Uk7wl5xrYn0SoJDzPAizXlb6gC1mk66eG+s
	 7EQ9pj5oKeSDstk5gpGtkCIBfNxJVv4DzF6lsR9aJRxrP4OOkqZiVG9rifiZJXQwNF9Cz
	 veodoKS5KdKmD8L/cMMGF0d3c2P/E+BCRIAPO1rdSa6ndiurksLu79Sg2z1ngyN0cdCPR
	 Fa8s17bQ3u0Tck4cdgJ3vdlDalrPyWul+WTwvMe+Wnsl8FJnpSMlq5M1BY4iADWu9ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615255;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5xWOQv1bwNw06uJHNenWoZXrA9tw+q3EVxeGliOI4C8=;
	b=H4nJCHsm0B6netGDxPj61O/SOnP2XIFdrU1tJNrrb6kW/HtOUjB25NEF4lPgPFVH60dV
	 MPv3oCmiJx540LW/2A3ioxNOUm2Lh5/ggUhyWKtBf4x0p4NNJzWoFJxgGonx8d1K6qVZ1
	 RjOvbTkMfH+6NeED+QLKsqPv/0UwW+pygs5XdYJBvhLzqN23rTn4i3Vxp4UnWbRXPUz+a
	 Q0AfRcmYbFor9lNM6wo1g7KisNOunDR2pSDoYsuIcJS4q990TV5Oc46Hdaov8r7gorfnF
	 bRMoNlGwyIZxCFPc94757mVKzA6cHmJ4HzHPU6ob1JS/hdoDsCt/Rdt4agVovgw7xOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDAUs23i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E7606A332;
	Sat, 14 Nov 2026 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDAUs23i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615255;
	b=iPzRVjcdLPAr2YYV1xgZrot0MIcAo0sUoznK0/w4mxIH11ffx7tDao6G+AsYIEH9maHI
	 W6WHmnCMagWbD+wFoOsfUdQUi0fbVEEd/6KVPpKB4KL350tfbaAgnjhnkrh69T/acwwXs
	 SzUAO8YDLu6IefSvPkmjYgcxdZe4BzP7Wzg5gaT6PUbEembpU3Ja0RsO/ezPvHYG8vaib
	 OVfKLJfNeovkU7RcXs0aL2omqRIlzQTOKRDsN3wkom4aI59a1xUPy07kEjXbKru1LWfiw
	 AjaLy7WeK/C91o0KG/KcLyWnqDBl6mhOvwJQZhOGChflsoFWc9gMSpO8lkIu2oxyFNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615255;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5xWOQv1bwNw06uJHNenWoZXrA9tw+q3EVxeGliOI4C8=;
	b=G0H6NUlxjMYCIZB/wVmBQ39dXLSFRmhkp9M1nvLoFZxE2Tlmsr5kobZYiHt1cCEt9nNu
	 gPIDcUEdzsBshjbZdxHWE2TFw5XeH7USdUEAtyKHBizlgPARProfDI1sixQs34wop7Nk8
	 gEPYpIGeXSs3IaUb+E+jrFeQkdRvhlw1nswKMrFzWZg3UzWCnDLJsipOURUbannOs5+PR
	 RSSSiUQ1AUFPbudhsJjkBajEG6VsGSJ6doOhcoG59vWiLhWPzyMpvA+p0UZj3rfjhDX1s
	 WFeXFGoZVnejreBpOEazb5N2hoGcKCjq0c/eg+PVKxsKX7+KM+z3XVr+9kXTxwaXC/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E571B1F000C8;
	Sat, 14 Nov 2026 00:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615255;
	bh=5xWOQv1bwNw06uJHNenWoZXrA9tw+q3EVxeGliOI4C8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HDAUs23iB2vudblDpO6T8RIRuFJuyD5FjgfTU7rT+GX3gfgdc1LqD1w9ql8827Qz5
	 oU1ARSzJG7q0Vc3/9G1FSUPupTCt77745R3k3IwlqAEh9XN5RijSWvqASyirqq3oCo
	 PoXATNalIslDWGH3i7N8ktyOZ9rYVxqJKMt7X6Sy2Jdq7IYiumo8Tdyc7cpOdJfHjL
	 JFTa7isuuCCfk9FaoEzJYfov2+l1zspI/Hiv+pFYkb7rWUYU/yAXMnDK8rJT0F7BtN
	 LpSNmiwf+gkhjeGg66kwk0/0iJyNsgLTLimGMpoYt6KDoAa+6RRWaxTdSVK8EQnPO2
	 09m90Mc36gF9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7553149BC3;
	Sat, 14 Nov 2026 00:14:12 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 00:14:12 +0000
Subject: [PATCH 1/4] media: verisilicon: Size the VP8 segment map for the
 largest frame
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
Message-Id: <20261114-hantro-fixes-v1-1-abb78264801e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615252; l=1568;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=uf0y3QXiqPaWDkwu0IT1uHWdZkMxGVfJurXyC9ak0Fo=;
 b=36HLcA/Lv1TOaerShkK/mv3DJsPckfFXASIgVkUHIXZygIv9/3DMuaI2P0/PHsSvjuRVyEd9J
 uK+fK0M6wkDCRnXRq1PYfmzz0EeZnilnqU2FSExRAyHTnw4/SlQSNhs
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The segment map is allocated at STREAMON for the CAPTURE format of that
time, but the format can grow while streaming, and the decoder writes
2 bits per macroblock of the new size. The map of a small format is one
page, which a frame of more than 16384 macroblocks (3840x2160, for
example) overruns.

Size it for the largest frame the variant decodes, as VP9 does.

Found by Sashiko in its review of hantro-dec-size-check v1.

Fixes: bbd267daf4fc ("media: verisilicon: vp9: Allow to change resolution while streaming")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_vp8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_vp8.c b/drivers/media/platform/verisilicon/hantro_vp8.c
index 381bc1d3bfda..12907f000a92 100644
--- a/drivers/media/platform/verisilicon/hantro_vp8.c
+++ b/drivers/media/platform/verisilicon/hantro_vp8.c
@@ -150,9 +150,9 @@ int hantro_vp8_dec_init(struct hantro_ctx *ctx)
 	size_t segment_map_size;
 	int ret;
 
-	/* segment map table size calculation */
-	mb_width = DIV_ROUND_UP(ctx->dst_fmt.width, 16);
-	mb_height = DIV_ROUND_UP(ctx->dst_fmt.height, 16);
+	/* The format can grow while streaming: size for the largest frame. */
+	mb_width = DIV_ROUND_UP(ctx->vpu_src_fmt->frmsize.max_width, 16);
+	mb_height = DIV_ROUND_UP(ctx->vpu_src_fmt->frmsize.max_height, 16);
 	segment_map_size = round_up(DIV_ROUND_UP(mb_width * mb_height, 4), 64);
 
 	/*

-- 
2.55.0


