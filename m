Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472285;
	b=qsT5LYyhE12zgfM0IYCjwlvhJadSZvpwVsWdxzx79M59WLWkSAaDRm2C+R2P/tcM+E6q
	 3G9h7xK0aY7bXDOVBV1RGnmedYsgXZlf5BbPKs8leqX2jPQ/hPqYYGVgQL6CsJl0vuAK+
	 50Wbs9aG6swmiTzsHFBwoGpuV3HZ18eMZvWHXZNuDMU6YmdXtM5acBsqpZsEQLv1RHzwk
	 8Ss0UPxk1vOpFy/+v75KQR2wfoPioLFN92MLfRMRg2CjsWtZ2wCv+xD11qAm4CXe4rLA5
	 /ffJfPT5rfds+zXfRZjKLxvWpHfwVqfbQ/rLnSNLNRlGTOxeTe6FFHXmu66jsgZXIBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472285;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=C5ou+jBw95xtnygEz2bMk2ownXTjurNRHkMpcrbJMQc=;
	b=nTgcq1R87y9R60Iocx3b2HJ+Td92KIS/amPsBbobD61y6VT5pCtpuWnKcM3k5dpVU4xo
	 vibyq2u1a6hchkbX7s1pRNfMmEkq8aDAPQq8gWuiybnx5ccJvCOfZ4bLuMsY0mq067VmQ
	 kmT2OJ1Cbnh0XelPnxKr+Hhe2zjrwMzRVl7wQkBUMSIlkW5nWeiZuQ77ockLk0+Lfr+CS
	 BTfWyn6HdXiwZY3cMI7/gu/M78Mrr8IerTD1Rea+ceqpt5FfZn7wCk34Db4X5t1z/tjng
	 3yRcNHVvMZdAfmkpzJp0ZXLB/eaoeJBiH5UmYmFdxcyoGbXPaK0Hx8memb/HHXotgZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/Oq+vgR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6A606A333;
	Thu, 12 Nov 2026 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/Oq+vgR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472285;
	b=CkbFk4u87W8ATohH9uhcrGKIhsjf8uNpEZ3RyFywxxvq5ersYXYn47jpbFRmLZMhMaYW
	 wh8c33AzeYyWx2PM9QrDWGMIwjGU0rR3gsgmXiuENc03qFuZOTxuAwJ6/aWSTJUHpmvM8
	 iey2bv82Nz1xj/+nGHL0jQBhL6AV8eVe9NOsroaFL0TN4otkR4VTVK0xj4JU9MLH0nyaz
	 UR80id5RD5qHSnXTbGblaBMXdKX2s0nLiv3+nFDuhw0Jn48OcwtiGe5CJZ1jjQ3ToRd79
	 PXJB4q5AAFROOKvVmUb06RbISIaAr4B21vh3QdyRi0srJPRqcD3/7RxlvQrzviQtw/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472285;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=C5ou+jBw95xtnygEz2bMk2ownXTjurNRHkMpcrbJMQc=;
	b=0kUb14HMJoXQmRaR3L7nbgtif+f0wd92dBAJOLqoh7zDGaWaat3aK2RDcmvA7YLNL/dd
	 7hD7DmlIrosk2S12WzdTeaB4/hVYpeADaORRlhO/ZgI9u46Mwf8Lz/p9Xf3u04k9xXYxi
	 b6c2RXadMUirNDtUYaL09HUv7aWCsj6elMscItPyUHdSJ7H8B4SWwONTuhpS9DoBkNwPF
	 CM/otItFp30gazDowNFC5LSLfVdH1DrBgn03hyVjKkdw0wie/FR03iWgu/wQr5gYEOVjo
	 z7SWLTk3Eb2EP0tL1FCFcNHNH4GuPg3Ze7KLOuCWdJOyGe8VfJspMLyhRdiagMtwjJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DD5291F00A05;
	Thu, 12 Nov 2026 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472285;
	bh=C5ou+jBw95xtnygEz2bMk2ownXTjurNRHkMpcrbJMQc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=d/Oq+vgRwzeeazgzDzR1NAL5RO1SpF6Z+AMbroKv+UCNvy5sGvWQBZP1V75aZn9xn
	 svH5mYPCr/6LyHuNf4oCBfx/1Teecg0xkcFGPdUGqHgzHd3Yc41gOaWnq6TZsZpWq/
	 H1hks/48OC8ThxW5faqCIICun6uCTU8rHQHkApXZnRPl+yFPtGMfsivQZ3zLsQKLLQ
	 Chjkm+rvnKtkTPPh5PHgAqVDYG1F2Vpqnadca1mAJvUr7SUW5DGBAJAh9UcEXFKRkN
	 con9jGY0Z4RgMD/HX8XXn+/gFPg69BW3AGqkZc5CmWvBKI7iVd2q1VH+fRlh1SSXWy
	 /CxuQe+Qwq44Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 68A3B49378;
	Thu, 12 Nov 2026 08:31:23 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v2 0/7] media: verisilicon: Fix the JPEG encoder format
 handling
Date: Thu, 12 Nov 2026 08:31:22 +0000
Message-Id: <20261112-hantro-jpeg-enc-fixes-v2-0-de03e643c75d@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBCGr0Jm7RjaIIIr72FYlDKFIUJJW4mG9
 O4WPIDL739u4MkxebhlGzha2bOdE8hTBnpQc0/IXWKQuSyFEDkmMTiL40I90qzR8Js81sZUrSl
 VUQsDqbs4OoxUfTQ/9q92JB32sT0xsA/WfY7jVey5fx+rwByNLjp9pbq6dPLeT4qfZ20naGKMX
 wd21vbMAAAA
X-Change-ID: 20261110-hantro-jpeg-enc-fixes-9ff8bf6a491f
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472282; l=6267;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=0XAAauAxm37JOSm2PiY0TiJ0Ij6tP2Ehovs7fdJDMuY=;
 b=lcPksa7BU6skLfmFXEeKA9B/GjieFEd/i3d8oNPV/uRi7BTA9CtNlr10+6v8Oyh2whkx6EjO5
 n7x0mufqHvHCJs+Vkx4xWLwbX+SrnsSEF92mdnuAqiHwrg3kHHznCTR
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

This series fixes the format handling of the Hantro JPEG encoders, found
with v4l2-ctl, v4l2-compliance and GStreamer on the RK3588 VEPU121.

The encoder accepted a CAPTURE sizeimage far too small for the selected
resolution, and setting the OUTPUT format never updated the coded size,
so the sequence mandated by the stateful encoder specification (CAPTURE
format first, then OUTPUT) left a 96x32 coded format under a 1920x1088
raw one. The JPEG encoders program the hardware from the OUTPUT size and
use the difference as the crop inside the last macroblock, so this ended
in IOMMU page faults, a frame processing timeout and a wedged encoder.
Patches 2 and 3 fix the two ioctl paths, patch 4 refuses a job whose
geometry or CAPTURE buffer the hardware can't be programmed with, as a
last line of defence, and patch 5 reports the fixed colorimetry of JPEG
instead of propagating whatever the application set, which also fixes a
v4l2-compliance failure on the encoder.

Patch 1 keeps the CAPTURE (coded) format while CAPTURE buffers exist:
the encoder sizes its CAPTURE buffers for the coded format, so changing
it under allocated buffers would leave them the wrong size. Patch 6
keeps the raw OUTPUT format while OUTPUT buffers exist, which also fixes
a CAPTURE S_FMT that v4l2-ctl --stream-mmap issues after the OUTPUT queue
is set up: it succeeded but left the raw format descriptor reset
to the default (three planes) under a negotiated two-plane format, so the
next job read a plane from IOVA 0.

Patch 7 limits the advertised frame size to 8176x8176: both Rockchip
encoder register layouts hold the size in 9-bit macroblock counts, so
8192 was programmed as 0 macroblocks.

Patch 2 changes the same branch of hantro_try_fmt() as patch 3 of
"media: verisilicon: fix VEPU1 JPEG encoder writes past the CAPTURE
buffer" v2 from Sergei Khomenkov [1], which raises a small JPEG
sizeimage to the header plus 64 bytes. The minimum set here is always
above that one, so the two don't contradict each other, but the one
that is applied second needs a rebase of that branch.

[1] https://lore.kernel.org/r/20261110-hantro-buflimit-v2-0-ff7790def9fc@gmail.com

Tested on an Orange Pi 5 (RK3588S, VEPU121): with patches 2-6, an
explicit CAPTURE 1920x1080 JPEG plus OUTPUT NM12 stream gives 8
decodable 1920x1088 frames, a requested sizeimage of 1000 is raised to
4178544 and a larger one is kept, G_FMT on CAPTURE follows the OUTPUT
format, v4l2-compliance passes 49/49 (58/58 with streaming) with sRGB /
ITU-R 601 / full range on both queues, nine GStreamer v4l2jpegenc
pipelines reach EOS, and v4l2-ctl --stream-mmap no longer faults. Patch
4's checks are not reachable from userspace once the format ioctls are
fixed; no run printed them. With patch 7, NV12, I420, YUYV and UYVY
encodes from 96x96 up to 8176x8176 (including 8176x1080, 1920x8176 and a
cropped 8168x8164) decode back at 53 dB PSNR, 8192 wide or high is
refused at S_FMT, and a probe with the reserved bit above each field set
showed the hardware does not take a 512 macroblock count.

The new CAPTURE busy check of patch 1 was tested on the board with v2:
S_FMT on the CAPTURE queue succeeds before buffers are allocated,
returns -EBUSY while one is, and succeeds again after they are freed.
On that kernel v4l2-compliance still passes 49/49 (58/58 with
streaming), and v4l2-ctl --stream-mmap encodes eight 1920x1088 frames
with no fault or timeout.

This series was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit messages, and I reviewed and tested
every change as described above.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v2:
- New patch 1: keep the CAPTURE (coded) format while CAPTURE buffers
  exist, returning -EBUSY from S_FMT, so the coded buffers
  can't be left sized for a different format (Sashiko: hantro_set_fmt_cap()
  was missing the CAPTURE busy check)
- Patches 2, 3 and 5 (the sizeimage, coded-size and colorimetry
  patches) now carry a Fixes tag (Sashiko)
- Patch 2: the commit message and the comment no longer call the
  default size the worst case; no functional change
- Patch 4: complete the controls of the request when the job is refused
  by the geometry check, so the media request doesn't hang (Sashiko: the
  early return left the request uncompleted)
- Patch 5: the commit message names the mtk-jpeg and imx-jpeg drivers,
  so the series no longer goes to the MediaTek maintainers and list
  (matched by a keyword only); no code change
- Patch 6: commit message corrected, the CAPTURE S_FMT succeeds (the
  -EBUSY from hantro_set_fmt_out() is ignored) and leaves the raw format
  descriptor out of sync, and the Fixes tags now name the commits
  that introduced the reset and the mismatch (Sashiko); no code change
- Patch 7 (the size limit) unchanged
- Cover letter: note the overlap with Sergei Khomenkov's series
- Link to v1: https://patch.msgid.link/20261110-hantro-jpeg-enc-fixes-v1-0-fc4dc7e985d2@gmail.com

---
Arun Iyengar (7):
      media: verisilicon: Keep the encoder CAPTURE format while buffers exist
      media: verisilicon: Enforce a minimum CAPTURE sizeimage for the encoder
      media: verisilicon: Keep the encoder coded size in sync with OUTPUT
      media: verisilicon: Refuse JPEG encode jobs with inconsistent geometry
      media: verisilicon: Report fixed JPEG colorimetry on the encoder
      media: verisilicon: Don't reset the encoder raw format while OUTPUT buffers exist
      media: verisilicon: rockchip: Limit the JPEG encoder to 8176x8176

 .../platform/verisilicon/hantro_h1_jpeg_enc.c      |  9 ++
 drivers/media/platform/verisilicon/hantro_jpeg.c   | 37 +++++++++
 drivers/media/platform/verisilicon/hantro_jpeg.h   |  5 ++
 drivers/media/platform/verisilicon/hantro_v4l2.c   | 97 +++++++++++++++++++---
 .../verisilicon/rockchip_vpu2_hw_jpeg_enc.c        |  9 ++
 .../media/platform/verisilicon/rockchip_vpu_hw.c   | 11 ++-
 6 files changed, 155 insertions(+), 13 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-hantro-jpeg-enc-fixes-9ff8bf6a491f

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


