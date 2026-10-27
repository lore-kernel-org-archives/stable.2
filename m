Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099503;
	b=sOM0Nm7imFpjWkodwaLNCOv+Wj/jrir3tUMOOoGQA+0/T4of2qCoSjgXLrq6XI2zbH1S
	 efG+vPyMzdhbC1CifiFcDTnzOzn9gqhvrXhO1+53zePQNFvJ+q6Cc9uwdmi5uuef39flq
	 H6qwtvSvnC+YfSm6e2vy6rdftTc1zG6d4C4HtrQXuM3I8l+7p49Y/jgn7rH9RMbzCOVNg
	 ziYOmVtf9kjrQB/aGzq7igY86T9IaV1VUcc65HjqP0NgItScBu94S4vAgR0IEypqzpGo8
	 e9dV4Wfpv2IxR6wZC1EKH1zBXCF43YV4/tnm1OT6P5U+dYhl5eiogrWtiop5eGadJ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099503;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uRm+F7qYtT36OPuPfH5nm2HUlkYwRf4AN90k+1SZEEo=;
	b=VF3q1EoX1JpV4aRULMqr6J7KelD9Dklnkj7BUqtCDV9mwRb1EN1AljE1UuK17uDbgEjo
	 xuTdEy5G8tyZeEVd1tq6bxg92WdrdYt+125rQXCnFcILHt8WEUY5C47WE2ddnAaCW3Xxx
	 Y+QL2cevfWPW4OXFe+eyyjeF2gy0OEXgqZx/5HzCwmm2g+NMkNjSB/Ow6Um6HTRMVrKjN
	 d0Jh2Jum2sEZiHoqcZT0uEeHoBkCpUZOHO4Y83CEppxOWjAx2M84DVGjBeQJSR80Njl6L
	 Z3MajlJ3zhvD6ilaU2vQmnmCnggtUf0R+/RT3h0fP6YTZAtDfOEyo4CD7bxvNhshQAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=runtimeverification.com;
	spf=pass smtp.mailfrom=runtimeverification.com;
	dkim=pass header.d=runtimeverification.com header.i=@runtimeverification.com header.a=rsa-sha256 header.s=protonmail header.b=OYa4Eb8M;
	arc=none smtp.remote-ip=109.224.244.107
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC211606A329
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC211606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runtimeverification.com header.i=@runtimeverification.com header.a=rsa-sha256 header.s=protonmail header.b=OYa4Eb8M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1793099500; x=1793358700;
	bh=uRm+F7qYtT36OPuPfH5nm2HUlkYwRf4AN90k+1SZEEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OYa4Eb8MMmjnnSbftKj6t6tsGHic4RQNA/6WBHSkWGWjXLZungxm37Dy6thwFzn6w
	 ttNvjB19xqdAw2tZXvk+IRLLy+7DvqX7CqjWr9mON5mK5iZqM4Cifo4RhUTrUrie2L
	 2Q/nGfE/ij0XGHoLHKW3RMc6qQGa2sKn0DO+zYJb4gS/cGQsyOfdk+rR67+j8yuGu8
	 vsCaqlMlxKd1jzbg0SmloMaa7lRgYdDuO91dPyNfXe8e+rguZVwplPZD9VwTA/9XH5
	 diPoPp8j84cgmvipLqtt++w3RD5oJWbtHPzzHFea8NgwLdTTt8YefAjzSq2q18kDnN
	 Ln3r4THmsAypg==
X-Pm-Submission-Id: 4jDSVb5T0kz2Scj6
From: Natasha Klaus <natalie.klaus@runtimeverification.com>
To: laurent.pinchart@ideasonboard.com,
	hansg@kernel.org,
	mchehab@kernel.org
Cc: ribalda@chromium.org,
	noambs2999@gmail.com,
	david.laight.linux@gmail.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Natasha Klaus <natalie.klaus@runtimeverification.com>
Subject: [PATCH v4 2/3] media: uvcvideo: Fix integer overflow in frame buffer size calculation
Date: Tue, 27 Oct 2026 14:11:15 +0300
Message-Id: <20261027111116.119182-3-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027111116.119182-1-natalie.klaus@runtimeverification.com>
References: <20261027111116.119182-1-natalie.klaus@runtimeverification.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Noam Ben Shimon <noambs2999@gmail.com>

In the function uvc_parse_frame(), it recomputes
dwMaxVideoFrameBufferSize for uncompressed formats. This helps working
around devices that report it wrong:

	frame->dwMaxVideoFrameBufferSize = format->bpp * frame->wWidth
					 * frame->wHeight / 8;

These three arguments originate from the device's own descriptors, and
therefore can be decided by it. bpp is a u8 and wWidth and wHeight are
u16. The expression is evaluated in int, and the maximum value is
255 * 65535 * 65535 (which is roughly 510 times INT_MAX).
A device that declares large dimensions therefore overflows a signed
int here.
The kernel is built using -fno-strict-overflow, so this wraps rather
than being miscompiled, but the wrapped value (which is often negative)
is then divided by 8 and stored in a u32 used as a size.

Two examples for this (using legal field values):

  - 32 bpp, 16384x4096: the product is exactly 2^31 and wraps to
    INT_MIN. After division and conversion to u32 the field has the
    value 4026531840 rather than 268435456.

  - 16 bpp, 16384x16384: the product is exactly 2^32 and wraps to 0.
    The field holds 0, rather than the correct 536870912.

I don't think memory corruption is a consequence of this. The value
reaches uvc_queue_setup() as the vb2 buffer size, and every copy on the
decode path is bounded by buf->length, which uvc_buffer_prepare() gets
from vb2_plane_size() rather than this field. What a wrapped value does
instead is make the driver describe the stream inconsistently.
For an uncompressed format uvc_fixup_video_ctrl() copies it into
ctrl->dwMaxVideoFrameSize unconditionally, and that becomes the
sizeimage reported by VIDIOC_G_FMT. This is while width, height and
bytesperline continue to describe the full frame.
This also makes uvc_video_validate_buffer() mark error on all frames,
because it is comparing bytesused against the same number.

Compute the size in 64-bit, and if the result does not fit in the u32
field then skip the frame descriptor. An uncompressed frame this large
is probably not a real device, and skipping it leaves the rest of the
format and the streaming interface usable.

The overflow was found with the help of Claude. The fix itself
was written by hand.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Cc: stable@vger.kernel.org
Signed-off-by: Noam Ben Shimon <noambs2999@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Tested-by: Noam Ben Shimon <noambs2999@gmail.com>
Signed-off-by: Natasha Klaus <natalie.klaus@runtimeverification.com>
---
Changes in v4:
- >> 3 instead of DIV_ROUND_UP_ULL, see cover letter. This is the
  form Ricardo reviewed on Noam's v2; Noam's test inputs give the
  same result, so Reviewed-by and Tested-by are kept.
- Changelog says how the overflow was found.
- Rebased onto d135ab453a74.

Changes from Noam's v2: rebased on 1/3; dev_warn() instead of
uvc_dbg(); operand values in the message (David Laight); last
paragraph describes skipping instead of rejecting.

 drivers/media/usb/uvc/uvc_driver.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 14ab4cc28c40..4d1380c38ec6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -295,9 +295,21 @@ static int uvc_parse_frame(struct uvc_device *dev,
 	 * information. For uncompressed formats this can be fixed by computing
 	 * the value from the frame size.
 	 */
-	if (!(format->flags & UVC_FMT_FLAG_COMPRESSED))
-		frame->dwMaxVideoFrameBufferSize = format->bpp * frame->wWidth
-						 * frame->wHeight / 8;
+	if (!(format->flags & UVC_FMT_FLAG_COMPRESSED)) {
+		u64 bufsize;
+
+		bufsize = ((u64)format->bpp * frame->wWidth *
+			   frame->wHeight) >> 3;
+		if (bufsize > U32_MAX) {
+			dev_warn(&streaming->intf->dev,
+				 "UVC non compliance: FRAME %u computed buffer size overflows (%ux%u, %u bpp), skipping it.\n",
+				 frame->bFrameIndex, frame->wWidth,
+				 frame->wHeight, format->bpp);
+			return -EINVAL;
+		}
+
+		frame->dwMaxVideoFrameBufferSize = bufsize;
+	}
 
 	/*
 	 * Clamp the default frame interval to the boundaries. A zero
-- 
2.34.1

