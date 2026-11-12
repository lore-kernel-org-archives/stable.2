Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482274;
	b=eQJl06GaQJuR0dzEPazw2h2eveqDhBy6xGkLXnWzgL8/WyV2DDODHQZzhl4GDLB01FuE
	 eZYsZ6o2SQYhKprLlBduYPad4P8Raio2wiLnkA+Yb0YuMj8AZ7giYN+FNo1wldjO7Li3N
	 jL+D7IC1l/5qjymIh2c2SIxt/wDOTnn5XZ3njhdY+zlTwJVrC8ZRw0tR9SyRqIll4vGjz
	 qzP3QrtMxxMnYur9ZDWxsNzQvk2RmWPoVc3NcHUCdnuDemQOYo5FeuOZnG9OQ4/YplELw
	 YHIM/goXsE1NaW5ifehPwd/RQu/2kA6NNXsu7B2K1ImKBe/Pix/dslmZUYNAULTKIlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482274;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GOIXyvEBp5Mk6/fa7dmjq+ngz+K78W9i84ablp4EwKk=;
	b=aHAjyOmc/pjEAF4EyrDQUxWqT/FIv8lDlrqU9aiGSNPgQQIpPG35Yr9op68fIIi/IfEL
	 wxFiWb+BkwLx0/J6owrDM0Ct5frfXnV521rmEus2LOlACMgdLjp1YWO9CuOKB290P6CbF
	 FY+Bb8Wxwx2eXCvpnxqJKBoUcsAfn0b8lPEq9YH9exwZVQIeUaQrLDu5gdsIC2sllQ5V6
	 0JuQpX0P5Fc4IOA0XN2q92vmIcfQCA3VTwJWuPL1DCUhUF2sFGoKDdY7m1I3l+YnFm0TQ
	 mPFXm0HCaPV7PI8DTrkBvSUzcAEd11QG0WXN/9r69thLo7nyRxQQ0brcWYJokIt7QsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSHRJM4C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1195E606A89C;
	Thu, 12 Nov 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSHRJM4C
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794482273;
	b=u2oHFIsJSmrbAftJPtV+RvjLHKwnU47Rq7KvCSWkBJobg8s4ECJhLZpDJ9y6AkBYjbao
	 I1gZBn4J8kdkDsYuO8//aTrFKuH2fFcYgnaCf8SZEk2x+TOI1AhiOXiPp0B5/1iR9kGRE
	 JdMqb31qvBaWxlayW4F1Pko6dshFeshtAkdNiFTZf+pCw/JP57UaW84bSeQXWOumZVWtq
	 nhzG6envEXmN4b35a0wS6KZ6ftnXso7VjwjqZJKJwLHZ38anRpqeFEheYb2Gn/WNBEZ9D
	 Y8URaPEXw3XKzngI1QrbtAYDu+17iea8mMWWzTkaDeChxvbut+73U0LwNfdZ+zaBNHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794482273;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GOIXyvEBp5Mk6/fa7dmjq+ngz+K78W9i84ablp4EwKk=;
	b=JXuCl3ZkAlOpYk/mNO5EVQ7SI/C6wPiVkrT3+UaHqbdIDX7DKnJSWDTgdOXY1jSVymkn
	 Nn2tGuoGFiRpMg1+bJeE7pWYFGjEu5n+WQapF7lBFsdo0jkbGpg5tDAFR8+RIJMltAEpC
	 Q17VqJEzIbPDpSaxv1EkBte4zxMR+aoBARmi22GvRv8oDqw542KVWA1oadjnF8OHkPRCW
	 XqMDrqhxwu2aB27QXLv8ot0NanOkoiwgP/1t38Cqpfd+VquyjLopRuA4+0/XWoT+JFxfc
	 tyDvHQg42+EfGwhkjsQAozE2NUsxOFPY3heWjTzsxNM8uzbrOazF5aCCKtlWHAXytbw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1B0701F00A0C;
	Thu, 12 Nov 2026 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482273;
	bh=GOIXyvEBp5Mk6/fa7dmjq+ngz+K78W9i84ablp4EwKk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=aSHRJM4CLuVXiC0+XWISuke//QNNIc1JA+cpcjmst4U9H37OwUtFqXZ7SY00pQOfk
	 V5g1MGaRj49vZ/eVVQw2vtLB+3Ccup/MEGGo1jUzwLdDJQzlvOMAiLtoK2C05RhT2P
	 bjjU+vbfPc1HhMo7NUQl+2Cg9XxFLFHeW4qpOYPZfwvcVpQBB2OJxYf4y3Q8hdd/Bh
	 SYus29IyPVzNLSC8Z506wTEizeOMzMW1W/X3btCZhif4NQaTmU9Kliv4r0lZ5Movzn
	 cVLJaBv8GucYk8Py9HvfWd9MEUowmlJjP1FQ3pnRtdMWmdDY+jfpzAf05QLnNpAQ/j
	 hX/uRVyfmJ+nQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 70CFD49494;
	Thu, 12 Nov 2026 11:17:52 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 11:17:52 +0000
Subject: [PATCH] media: verisilicon: Only accept formats of the queue's
 kind in TRY_FMT
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
Message-Id: <20261112-hantro-fmt-role-v1-1-e596d6f4828f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MjXaBgSVG+blpuiW5Rfk6qrrmJcUqiUZKlRXJykhJQV0FRalpmBdj
 E6FgIv7g0KSs1uQRkjFJtLQAkwJ6acwAAAA==
X-Change-ID: 20261112-hantro-fmt-role-743da2b98ccb
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794482272; l=4438;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=s3CPAFpQ1/qB9nw0SP8YBgc/jIrhI3ySnN7uPXYFxW4=;
 b=Y8ORNp5aA3bzodvaJDfM+grVFHRPKgG4txfK1ZC+0Y2b16sv5q50TTacSXLRObUFtAewOP/zd
 UZWgNf9SZr+ApgVTplkVfT1vH4lqo2pjGW2lxnGtJ3aqdpNY9aWFDL2
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The format tables of the Hantro variants hold both the coded formats and
the raw ones (codec_mode HANTRO_MODE_NONE). vidioc_enum_fmt() and
hantro_get_default_fmt() filter them by kind, but hantro_try_fmt() looks
the requested pixelformat up in the whole table. It therefore accepts a
raw format on the coded queue and a coded format on the raw queue, and
hantro_set_fmt_out() and hantro_set_fmt_cap() store it as
ctx->vpu_src_fmt or ctx->vpu_dst_fmt.

On an RK3588 running a 7.3 based kernel, a user who is only a member of
the video group can set a raw format on the coded queue of the VEPU121
JPEG encoder and of the VPU981 AV1 decoder with VIDIOC_S_FMT. When the
application leaves sizeimage at zero, the driver computes it from the
header size and the depth of the format. A raw format has neither, so
the sizeimage of the coded queue stays zero, and the next VIDIOC_REQBUFS
on that queue fails with -EINVAL after

  WARNING: drivers/media/common/videobuf2/videobuf2-core.c:951 at vb2_core_reqbufs+0x1ac/0x530 [videobuf2_common]

which is the WARN_ON(!plane_sizes[i]) check. With panic_on_warn set,
this is enough for such a user to panic the machine.

From reading the code, the wrong format can do more harm than that:
hantro_start_streaming() takes the codec mode from the format of the
coded queue and uses it as the index into the codec_ops array of the
variant, and HANTRO_MODE_NONE is -1. This was not observed. In the test
above, which left sizeimage at zero, no buffer could be allocated on the
coded queue and VIDIOC_STREAMON failed with -EINVAL too, so the index
was never used. It has not been established whether another sequence
gets that far.

Treat a format of the wrong kind like an unknown one and fall back to
the default format of the queue. With this change VIDIOC_S_FMT returns
the default coded format on the nodes above.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261110-hantro-jpeg-enc-fixes-v1-0-fc4dc7e985d2@gmail.com?part=1
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Sashiko listed this as a pre-existing problem in the findings of its
review of "[PATCH 1/6] media: verisilicon: Enforce a minimum CAPTURE
sizeimage for the encoder" (in the review data on sashiko.dev, not in
the review mail it sent to the list); it is not caused by that series
and this patch does not depend on it.

Tested on an Orange Pi 5 (RK3588S) with a 7.3 based kernel that carries
out-of-tree patches, with a small test program run as an unprivileged
user in the video group. Without the change the raw format is accepted
on the coded queue of the VEPU121 JPEG encoder, of the VPU981 AV1
decoder and of an H.264 encoder node that is not in mainline, and each
of them logs the warning quoted in the commit message. With the change
all three return their default coded format and the kernel log stays
clean. The coded format on the raw queue case is fixed by the same
check but was not exercised. On media-committers next the patch is
build-tested only (arm64, W=1). The test program is available on
request.

This patch was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit message, and I reviewed and tested it
as described above.
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 83af9fa1ce94..64e32aef8b04 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -337,6 +337,9 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 	vpu_debug(4, "trying format %p4cc\n", &pix_mp->pixelformat);
 
 	fmt = hantro_find_format(ctx, pix_mp->pixelformat);
+	/* The format list mixes coded and raw formats, only take the right kind */
+	if (fmt && coded != (fmt->codec_mode != HANTRO_MODE_NONE))
+		fmt = NULL;
 	if (!fmt) {
 		fmt = hantro_get_default_fmt(ctx, coded, HANTRO_DEFAULT_BIT_DEPTH, HANTRO_AUTO_POSTPROC);
 		pix_mp->pixelformat = fmt->fourcc;

---
base-commit: 55271157078b9a6fd3519ee21b567a684f7277ca
change-id: 20261112-hantro-fmt-role-743da2b98ccb

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


