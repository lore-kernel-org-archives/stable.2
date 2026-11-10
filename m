Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794295110;
	b=EuhWwo4CVHZaK7PPKG1Sfhd/4kQ8j+9FmwKNJJgba0veLPeLmXT2pEzCZN+u+0H8iaoZ
	 OL9nLZnDGBcdLjXFSLKSuCu6u6kziRZzpX+r5QIL/KU2SzjpKpcW0Qiv25VNpC1uxiIlh
	 jxruOq4ocredXOczD47azMYUYubtszZqsuRloXlW+hgGiq76vypO9NBUBg1j88cAJeZkw
	 y2zDAmi1RQ417/0qR7L2QleHlwdIo/dAHk93OqjQmFgQzYgcwFaU39693fsWFvDC1thyz
	 pTve4rvxo9vzsDSZAgRo77YmI5iAYmG2eNw52DiW3dFQQUgL7P1EuDoT+4iiBAVs63g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295110;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=cUTmsE4tDYaYdJp/zWZgFkDFBq+j1F65P5Ihi0SIm24=;
	b=4z2C+ItU9ApY9oTwdC57tuAzhJKlcks+xYvMy9NFUCWKkjpJXtVP3DXUDW4h4VqAKcwW
	 3NItr2O3kDPSmgQpMWQBgxETTqMcQFlRrSpsk3zp/l33TRtHzOPAHg3fB8uFmZi1GSMqb
	 drE0wmPX9h46dgfzC61hvsxYq238r82WvnOFMSYDzPC3bCdXgpv4VljY5unkM4Ao/uXvd
	 J2SxtU9+0ZDaUesy1Jam0FFNAeeuW932NiQPmK7oJPuoI7V3XrLJQT4/cxdoL3RbTCLOU
	 TxjaKPMd6PhhBgvghMYxspI1oL2xE9AT+OmWCsXHk6J3qzW0koqXm+yLTR/PEDVtoXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCobaIfM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4F606A33C;
	Tue, 10 Nov 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCobaIfM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794295109;
	b=rmHCYwXT10/AXK344r2y+R2eYiGbDbQmVX9WsAE67u1P1HM9tzJdMKDF1GY4DyApZQQW
	 BBG0jCqpGo+zTA74HjG95wndj3spd1iJHmnNRC59g08eAmARMtBhrmhvvaOF2LFNr3zyc
	 spVW2iTo1eApNg0LzY8sxqX9+z3I3MvUKfqJyQG1uyj/SoI0MV2D7M1RsknzsKLDoIfvi
	 WQxrrXAsz++Gi4wDJHxUrdbpGO1h+FOyNofyfnT8J9C6ncNuJl+kEHqZNoxea8aRbXl1j
	 Zs92B+HFARv5fxiHha8YFcU7kbAThW6+9O6NeH11GzGRz1MJX56WGwgkuGBGEZbkffA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794295109;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=cUTmsE4tDYaYdJp/zWZgFkDFBq+j1F65P5Ihi0SIm24=;
	b=P+I+3MpFMo4MsLV1W1oXi482YlLhSiS56PR0tdq8Evq9klkv5XSa8dPLvGP0XWjfwth/
	 yksaD8VMphzVv/FL6d0DXjd4ylYY6oFHl0k0g/H7tO8O8EflmsVP5gUo5Yf/HK3ho8LAP
	 a/c5o6+UMG6MvYUp+RlWcdoBV8zYx97w+aOwBp/srDGz4J/qU2eAucW6HUokUg3+spjuG
	 /u+/WsFaTpOEOi4JULQDLoxT4cRLgnIuUtd6Hj2fZejLt9aXiJNiEodvEhj85kQK/e/qU
	 gc6KykdsQ8Hv6T1JqIKz35IfdsosGoTBj61AphBICtLgJI4FrE5YCGoTdBeyFJZSeog==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 192701F0089F;
	Tue, 10 Nov 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295109;
	bh=cUTmsE4tDYaYdJp/zWZgFkDFBq+j1F65P5Ihi0SIm24=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hCobaIfMcEyzBivTp5zgyVkS2McwPEFl2gTg4kT7b0Q4yLVgSfLuAchQELr4h/jNj
	 j5REQYVBm0MgzqrcgvqVlITQ6QtUp+ILeyy4wZv77BWL4CBjZnwx8tX/08GOFSy+8H
	 vLyWEnQrhHPyLp7wWziLU49Q+Qegaqp3MAMCCIclH2b6Yyi/Rnkf0EHfIdKpbVqfgd
	 GPk+fyX68Q673r5Pi7zbTvbZy0sjDLYnEODH/3Dod0ZmL8B5yGmm5qiIh38B27I9d5
	 PhKrCCWgVX51ccABJVjd7Q8dkwkPI05uMqhQHBBZzd8hS3+3umL0SL7BPcRBZswlxN
	 oNMvn57eKSDLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A1DBA4896C;
	Tue, 10 Nov 2026 07:18:27 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/4] media: verisilicon: Fix MPEG-2 field pictures, 4K VP8
 and the AV1 tile buffers
Date: Tue, 10 Nov 2026 07:18:26 +0000
Message-Id: <20261110-hantro-codec-fixes-v1-0-0fd5372ce831@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDQAxFryJZG5gZVNCrlC40E9u4cMrESmHw7
 o26fO/zfgHlLKwwVAUy76KSVgNfV0DvcX0xSjSG4ELnvXdocssJKUUmnOXHim0fmzC1neupAQs
 /ma/BusfzZv1OC9N2PsFx/AHaqUFodgAAAA==
X-Change-ID: 20261110-hantro-codec-fixes-59d42b5609c4
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
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295107; l=3328;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=igKj8pTGOK6tivQwkwcLG6VEOzLgnx6XNOOP3PoXh9c=;
 b=po4a40qKFMdHWavWbHbTpxo2TTFFZidjqDgVh19ZpmM/OYO76L6v1ER9lIrbL/+bP95avKUvL
 RU60OlJGE1pDu7MzH57U2amsU/77XY3T0RKqNTisqMTknKzsQuOi1mO
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

Four fixes for the Hantro decoders on Rockchip SoCs, found while running
conformance streams and v4l2-compliance on the RK3588.

Patches 1 and 2 make field-coded MPEG-2 decode on the G1 and VPU2: the
driver refused V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF for MPEG-2, so the
second field of a frame could not land in the same CAPTURE buffer as
the first one, and once it can, the second field was identified with
top_field_first, which is always 0 in field pictures, so it predicted
from the wrong field. None of the field-picture streams of the ISO/IEC
13818-4 main-profile suite decoded before; they decode now.

Patch 3 stops advertising VP8 above 1080p on the VDPU2 and RK3399
tables, whose only CAPTURE format stops at 1920x1088, so that a 4K VP8
stream is refused instead of mis-decoded.

Patch 4 fixes the reuse check of the VPU981 AV1 tile column buffers,
which only compared the deblocking data buffer although the five
buffers scale differently with the frame height, bit depth and number
of tile columns, and clears the sizes when the buffers are freed.

Tested on an Orange Pi 5 (RK3588S). Patches 1 and 2 were verified with
the ISO/IEC 13818-4 main-profile conformance streams through GStreamer's
v4l2slmpeg2dec on the VPU121, compared with FFmpeg: the field-picture
streams (sony-ct1..4, tcela-8/9/10, hhi_burst_short/long) went from
rejected to 53-67 dB PSNR, and the 26 frame-picture streams are
unchanged. Patch 3: the VPU121 decoder lists VP8F frame sizes from
48x48 to 1920x1088, S_FMT of a 3840x2160 VP8 OUTPUT format is clamped to
1920x1088, a 1080p VP8 clip still decodes bit-exact against libvpx, and
the 4K clip is now refused instead of decoded into 1920x1088 buffers.
Patch 4: one v4l2slav1dec context decoding a 1920x1080 10-bit
4-tile-column stream and then an 8-bit 5-column one (and 2048x128 with
4 then 8 columns) is bit-exact against libdav1d, 32/32 frames each, and
a kprobe trace of the DMA allocations shows the tile buffers
reallocated when the second stream needs larger ones.

This series was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit messages, and I reviewed and tested
every change as described above.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (4):
      media: verisilicon: Support holding the CAPTURE buffer for MPEG-2
      media: verisilicon: Find the second MPEG-2 field without top_field_first
      media: verisilicon: Don't offer VP8 above 1080p on the Rockchip VDPU2
      media: verisilicon: Check every VPU981 AV1 tile column buffer before reusing them

 .../platform/verisilicon/hantro_g1_mpeg2_dec.c     |  8 ++---
 drivers/media/platform/verisilicon/hantro_hw.h     |  8 +++++
 drivers/media/platform/verisilicon/hantro_mpeg2.c  | 31 ++++++++++++++++++++
 drivers/media/platform/verisilicon/hantro_v4l2.c   |  2 +-
 .../verisilicon/rockchip_vpu2_hw_mpeg2_dec.c       |  8 ++---
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c       | 34 +++++++++++++++++-----
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |  8 ++---
 7 files changed, 79 insertions(+), 20 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-hantro-codec-fixes-59d42b5609c4

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


