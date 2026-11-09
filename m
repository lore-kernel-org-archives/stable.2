Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794231839;
	b=2L2rgjbJp8fUrzXzQJB//9hLNPkeOyy0oBaIwEc1PAFoZb1hck8ZCep08raaWSCPXXqc
	 j7MFQbsguvoQ1xxjcFX2laN1J/VNuoDsbuSiq08yNlwyGr9VpbYqThpMTpUT6oHFhJUg/
	 BxrzlSWBwwk0KnX9iWKiQunZxiQMUWVyDaA5bxtj4eYHy1t63eeWaW0EWTxljo4qRq51q
	 qU+Drpam+PxGMpazzwRO7DO0s8+rUKDqveBenaAmUDpaw/bWW244QkIlegMQhRLtSbr+4
	 SBEAaV6XUuHHQ/yR0w7QLyjh0Fe7qXk6B+5o7I3mHYS/mQCk2Vgm26r7h0qzyyeC0JA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231839;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=KqI+Qz+GFttCTfVI/Kt/WWeDzMVSRyn+Mk3zpEGvFOc=;
	b=YwzgdjN+LALYGNKqHpXh/uVokXZqUT2VtzOct/Nr/gDEVmI7bF3r9wC79nq2d/ZSYzR2
	 Z+XPwCS2N66bPZvS+V//jdvdESr2FwoUsxBFtIWiOkoefOcnUQv7n9wkOr1fh+RI3rKmt
	 VP3Xe5vbtEhU2feX+1ZaF+KtCMIGj/ebODItfz69c0m+JMKkwsGup3XhhFG+CqbnBIaAE
	 TFb9imGabegE4LnxfM3dYCLTP+DAoJvchzTnrPsZD+U6Zsj+5G60t0lzRDJUmiF8QvnOL
	 ERd6IPLH+Xujh4wGcTbu2W0w8jz1yw6h9vG5ptcoDniN8JTrjSFyAT+ewdIz1PNoX3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJTyT2C8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56E606A31C;
	Mon,  9 Nov 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJTyT2C8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794231838;
	b=WMrLIb5/84cSbNq17bceaxs3giUQ8Q9F/FC9Jz/86UvDMLCd86OlQAyQoX98RzQMXOMC
	 Ll+1UJsC5e0j2CX67fPSsYz8oaHq/O2QDae9NM3mTWWNvkTW4aR93rUwDakecqb0plrlA
	 h0okC5rY3qxlzz12QmwrAYTy+5RC/MzfyqwDRhWrEOV1H6DuwP2ZPxLV37wolhHeGmQU2
	 kqizBadskrR6dA6aewPEusz/JLfEd3YyLjdmmh/kJojTrwN4V1zvRIfdvoxOIsZRJjtnL
	 DA4hXGiy9QGJpjswR1rlI492w+AQkn5qpx2B4+OJ8GPWNCI+tAjk8wxg8R+tZLXT+Dg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794231838;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=KqI+Qz+GFttCTfVI/Kt/WWeDzMVSRyn+Mk3zpEGvFOc=;
	b=bJA93VoW8AUZ07o+d43jg6e4qzfhhoKoLvk51n0ENXs261cIxSkQ3Fj7sc3N0EFgJOIu
	 DvN1Yi4xmNMKlsg3cak2rwtDhzyjLvao0M92sevT5Rd54isgjoGdH0//Sgls4JvzFn+q4
	 Q/wpURvE8/oKbgshOFk97JrvS3Jx3oF8MlvX1cCFXYoAzWiaCIUN9p19bEbIsW33/IdnP
	 xBU720dwuhc8wed+9M36KqTjf+6N94jv+lgDCmxC8GogGJgNkCMbuxT9gdEmk4JKnlzC9
	 2bq7aBh2uJbCRczLGQX3i2qj38Ei71XWForH6bWG8fWUNcmJblnEKiIYLUhF3eXeILQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E4291F0089F;
	Mon,  9 Nov 2026 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231838;
	bh=KqI+Qz+GFttCTfVI/Kt/WWeDzMVSRyn+Mk3zpEGvFOc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZJTyT2C8NUfrZtvakG0CARNC8BpC3p4lhy4WayPqKEddz/u0NvYw+Y2N/8eANgrjp
	 HT4oJmUDu7Z8AIURXNT7QBUcugnFoSLs6774bSvqh3DxuJZfwCmXGiPsmkW5ikgrSn
	 O+XyMjvbZFjGo1CAMCftH9kkU3HAbBdbvs1nLXmwGPJ8obgN5qdkZMwsMPBr0LjI56
	 DPVY410dhV/WZMZ76pEAivZLFDV4cfk3uFZNVdlOvSMqcOQ8nDKn0hNgO8lO7b1W7u
	 v5DIM7xoorU6j6wyZaHRPlu4RsOHbOV4MHyk43C5H3Zrb94olfDtWi7kLFIVCXp40Z
	 P8MHI3+7QRhSA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A4FEB484BD;
	Mon,  9 Nov 2026 13:43:57 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Subject: [PATCH 0/3] media: verisilicon: fix VEPU1 JPEG encoder writes past
 the CAPTURE buffer
Date: Mon, 09 Nov 2026 16:43:50 +0300
Message-Id: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAv1JyNtBWFPUr4sElasCNVEWQ/t3gc
 QZmXggkTAEq84LQzYH3TcElBvq53SZCHpTBW587Z3NUecqO3TUuvPKJNsuosL7syKeg1SE08vM
 f6ybGD+G1YdFhAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794231837; l=3241;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=en/jn4YMqVb7Nenx7Rb8ix4nBUnrgggys7Qhs7eVdYc=;
 b=Vzu8+WR8qtMz9STuQ8vNsgANjERJiMoL0jn3Kz0IB5o5qa5qjmePpUxxb375dpQGxFTRimMKP
 T/vCqhTRomuBg/iauDBMz10oDcnBKdVSRsyoTRBpSaar41IE7Ta6eJ/
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
userspace can also set a smaller one, so any client of the encoder node
can get there. On an RK3026, which has no IOMMU in front of the VPU, the
encoder wrote 230 KB past a default-sized 640x480 buffer and 1.6 MB
past a 1920x1088 one.

Patch 2 writes the limit in the right unit, rounded down to the 64-byte
write bursts measured on the RK3026. With it, a frame that does not fit
ends with a buffer-full interrupt, which the driver turns into an ERROR
buffer but which leaves the encoder paused, so the following jobs time
out. Patch 1, which goes first, stops the VEPU1 encoder after such an
interrupt. The encoder still writes one burst with a limit of 0, and the
driver writes the 624-byte header itself, so patch 3 makes the smallest
CAPTURE sizeimage the header plus one burst.

All three were tested on the RK3026 (VEPU1) only; the test paragraph of
each patch has the numbers. v4l2-compliance 1.30.1 on the encoder node
shows no new failures with the series; its one failure (the raw OUTPUT
format's colorspace is not SRGB, v4l2-test-formats.cpp:892) fails
without it as well. The VEPU2 JPEG encoder (rockchip_vpu2_hw_jpeg_enc.c,
rockchip_vpu2_vepu_irq()) has the same code and the same limit in bytes,
and the STM32MP25 VENC runs the H1 code that patch 2 changes but has its
own interrupt handler without the stop of patch 1. I cannot test either,
so this series leaves the VEPU2 and the STM32MP25 handler alone; a check
there with a quality 100 noise frame and a default-sized CAPTURE buffer
would be welcome, and the same change can follow.

Not changed here: after a watchdog timeout, rockchip_vpu1_enc_reset()
sets H1_REG_INTERRUPT_DIS_BIT and the JPEG encoder path never clears
it, so every later job times out until the module is reloaded. That
can be a follow-up.

Before v5.18 (dc8bfe1e482d, "media: hantro: output encoded JPEG
content directly to capture buffers") the stream went to a bounce
buffer; patches 2 and 3 do not apply there and those trees would need a
separate backport.

The bugs were found and the patches drafted with an LLM coding
assistant while porting mainline Linux to an RK3026 board; every claim
in the messages was checked against the code or measured on the board.

---
Sergei Khomenkov (3):
      media: verisilicon: stop the VEPU1 JPEG encoder after an unfinished frame
      media: verisilicon: program the H1 JPEG stream limit in 64-bit words
      media: verisilicon: leave room for the JPEG header and one stream burst

 drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c | 10 +++++++++-
 drivers/media/platform/verisilicon/hantro_v4l2.c        | 10 ++++++++++
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c    |  9 +++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261106-hantro-buflimit-055e8029be23

Best regards,
-- 
Sergei Khomenkov <shomenkow@gmail.com>


