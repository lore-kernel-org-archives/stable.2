Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794314509;
	b=SYRJYjrRQWElwDArzo16uArRlRk8Vusx3G78a2u5AZ/terLDoe28n+vU4MuNdfh35yYY
	 EQKwXqat9aVSXjZ/pCY5oDXlQMyCFz/Z9/OneV/vgMlKFlBgD4ErWjLmWGqyoZ1qyo7fa
	 nMlsmfR8S/MeyVkW+Jw6K0LPBPhSMwgBKol5aQIqZSrzleshOZIZo78z7000p3rgJ7Mh7
	 g88oTaVCmrfZ/mvQnCn1SEs+Ak6yzpKpVOkT/N8bkM6VH/E5u6mEChDKhrRvqO3IGNy2w
	 5xM8B87ri/sF84OU/K5kHReTqKQtDgO9/TeMxVhwwwWh0s5Rr+y0WahzqEnds0pPA9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314509;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hxSefBfUDE5H76wsNqoXn2Ry4DBGDXioabY9jbecasY=;
	b=QZSv7+EfIML++LcB0TUo5mGs81vwm1YFtQeLBdYYbMlpGLfIj0VoRCkkCgJDmY4HNrKs
	 ipPufVd8ZJX1UGG+nbAtUzb2kEQB1XVpfl/nvPPakpM98PQzh6lyM0Mv5bUvlF3h3gOBY
	 HXczQX0Iod86R9mt61tIU1fDstYdldHQUVHcSnxcTF2Pni3wbCP/d1QG7kLAvCpl4arSQ
	 tH59wXGCvOR1R3ClRgeuFqfRvuEMx0QdqnNT/uIOcN09Se2V4J2lRAYCEDleaikRgCCmM
	 2utQ02F83ptcOKYjFL69qbpSv5K/FzyGHv7oPENG+iBiBzW7jbJNwnsNKTcBgv2GEKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qz06QtqX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E5606A321;
	Tue, 10 Nov 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qz06QtqX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794314508;
	b=HGHjY9g5zpN0yX3XgvI7+YDR0EQO+tWJ3qCjZIov4Jc7x8QVFOI/wRqyOQxYRk/90YyU
	 vbn0zWMbEcHuqX7h0A6Yt0ZDuWfKpgpctUwqG66J/QOTfXe+yApfuHuhIPBXymFD4AE8E
	 GlervCz9qHJvISsd070DmpZsfqgYe/Xz/+p4L2C3SPFFYaeDELsfa/eFbHVaMM4oaq/r4
	 ga/YOzUg2AWTdj1Rm6pCd5mGFWAR504A3Xf3U2ALhhCjXNmrwqEicKzeW5MQTNNfWz1hH
	 1DySaZxfesRPCSuKmdVzkONtDgR8H1v1HDWWfWPPJ+LLr4pdyXMciIpOidd3+CNRSqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794314508;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=hxSefBfUDE5H76wsNqoXn2Ry4DBGDXioabY9jbecasY=;
	b=QxB8lbIIwBRjCRTmO/Kw6szNidYxm/QOjB7mbS8ptdzkgsVKzrLK04WP9fiJSApqL8dY
	 hURI2W0axKAguFWMvvttSD2K4jQYm5Y9obltv0uE7UjEC8bmvvwG0MRoIPKsp2snUTMSD
	 AaUav03eRgytLdsrQeF/hzBggP0dMRym3SYH5oPDRpbJqr5kMzgghvCQrCdr6h1WaD0+5
	 CfBrBtGI9mOE7BgbeiVHLDXqi8CPYiE8c/yfsUW0tRWtrLB9Sj0Mcm6JFHk4LsZi2Ta5O
	 37K0OMdi7zV2WyDQ1O8AzLe7r4i8ZtCQDKdPiw2GeMPj9/Zr2gWJfIHBJwaYo3P21Ig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D21E81F008A1;
	Tue, 10 Nov 2026 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314508;
	bh=hxSefBfUDE5H76wsNqoXn2Ry4DBGDXioabY9jbecasY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Qz06QtqXA6HRgkNs9nl/u4i3CiuZiy5mIDBtEquw3tvIo4Lb5Iopdwt8q+l1QUPtw
	 9VfZP4RWwyncDz3qI942nOaJ4mU8RXiEifCy/770Gfj520qP9xNHb79NO8JI285pGD
	 y76OiuGgIpEoGJPKxDOSaYfgCgWWvJi68sm0Zry0M2kb4bQeFM0rmSxJWsGs6Rvx5d
	 URLFkchnaNKxRlWAP3fcCCDEjy/08Sbv1TYAznqKfiq50YTLw3zLcxA3/8C8U5PK0M
	 lR8aVj7dkeJ1jP2/GjLKhlLeEeAIkIMJADJY+G4SF1sUUffid/ChHl4mL11RKkqmmN
	 uumGbv4Aqw/dA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3565048B4E;
	Tue, 10 Nov 2026 12:41:47 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] media: verisilicon: fix VEPU1 JPEG encoder writes
 past the CAPTURE buffer
Date: Tue, 10 Nov 2026 15:41:43 +0300
Message-Id: <20261110-hantro-buflimit-v2-0-ff7790def9fc@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQrDIBAFfyXsuRa1RJKe+h8hh2jXZCHGolZag
 v9eG+ipxxl483aIGAgjXJsdAmaK5LcK8tSAWaZtRkb3yiC5VEJwxapMwTP9tCs5Soy3LXZc9hr
 lBerqEdDS6ygOY+WFYvLhfRxk8bW/Vv/XyoJxZrnulEElUKnb7CZaz8Y7GEspHxsD73quAAAA
X-Change-ID: 20261106-hantro-buflimit-055e8029be23
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794314506; l=2924;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=Au9m2ZyJsM3rdkYmqexDG3q3feqvM6j21m3H6c6K1c0=;
 b=vmeArtTiWleE0liax4kfCT491w/QAjEfFTub6oVHTQqfEiqvH9AVODBQI7koxcvGyZdbFrIdp
 inI0naDjH4tA5WgSDPPtmKjthKVj4CqHjnIVuwKy3olsRRsJJQOp54U
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com

The H1 JPEG encoder is given its stream buffer limit in bytes, but the
register counts 64-bit words, so a stream that does not fit the CAPTURE
buffer is written past its end, up to eight times the buffer size. A
quality 100 frame of noise does not fit the default sizeimage, and
userspace can also set a smaller one.

Patch 1 stops the VEPU1 encoder after a buffer-full interrupt, which
leaves it paused. Patch 2 programs the limit in 64-bit words, rounded
down to whole 64-byte bursts. Patch 3 makes the smallest CAPTURE
sizeimage the 624-byte header plus one burst.

Testing, on an RK3026 (VEPU1) only: without the series the encoder
wrote 230 KB past a default-sized 640x480 buffer and 1.6 MB past a
1920x1088 one. With it, 17 overflowing frames, four of them queued back
to back, stopped at the programmed limit without writing past the plane
and came back with the ERROR flag, one interrupt each and no timeout;
the jobs after them completed, and frames that fit are byte for byte the
same as before. A sizeimage of 1 or 600 now reads back 688.
v4l2-compliance 1.30.1 on the encoder node shows no new failures.

The VEPU2 JPEG encoder writes its limit in bytes the same way, but I
cannot test it, so its limit and interrupt handler are unchanged; the
common patch 3 applies to it as well. The STM32MP25 VENC runs the H1
code of patch 2 and gets patch 3, but not the stop of patch 1. Neither
is tested.

The bugs were found and the patches drafted with an LLM coding
assistant while porting mainline Linux to an RK3026 board.

---
Changes in v2:
- Trim the commit messages and code comments (Nicolas).
- 1/3: clear only the enable bit of H1_REG_ENC_CTRL instead of writing
  0 to the register, and add a rate-limited warning per fault bit, as
  hantro_g2_irq() does; add the H1_REG_INTERRUPT_* fault bits (Nicolas).
- 3/3: keep max(): it is a floor of header + one burst, the 64-byte
  rounding is on the stream limit in 2/3 (Nicolas).
- Move the test numbers from the commit messages to this cover letter.
- Link to v1: https://lore.kernel.org/r/20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com

---
Sergei Khomenkov (3):
      media: verisilicon: stop the VEPU1 JPEG encoder after an unfinished frame
      media: verisilicon: program the H1 JPEG stream limit in 64-bit words
      media: verisilicon: leave room for the JPEG header and one stream burst

 .../media/platform/verisilicon/hantro_h1_jpeg_enc.c    |  7 ++++++-
 drivers/media/platform/verisilicon/hantro_h1_regs.h    |  4 ++++
 drivers/media/platform/verisilicon/hantro_v4l2.c       |  9 +++++++++
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c   | 18 ++++++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261106-hantro-buflimit-055e8029be23

Best regards,
-- 
Sergei Khomenkov <shomenkow@gmail.com>


