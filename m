Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733BA3D47B3;
	Thu, 20 Aug 2026 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219828; cv=none; b=MxgRAZ65k30yHnOMSEbnICnGWt7JirRH2Td1Psfz+CR54FVZERJrRDlWcyZb/K1tEmGg2SjQH34mjWFxpjJ395bx74WaX7bdSYovpJ1h8bl72PMYVU4+9L0pyMdccK0n62XyAlSLmc46Rv1sXpv67nAXkNLK8at19FS8zda/dWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219828; c=relaxed/simple;
	bh=EOzJwL2VF71Oj1nlIn9PyZ6GOzLBYhQNyYVB3d7V0Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/mwBYO1uFbuPV3MIlHarcs0R3HNMQNOilY/+53SK/wTlAX98nWqdcOLjiD6d7y5oiCON4KqGJMoHk6XLW8UAMwUG4zotvFUgzZQx93urzm9skscyICywmP9nGQyroFeBJgAnkL8rH9Nz/9K9DEg9HpfZfp8kD3efsOFhnyJvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=runtimeverification.com; spf=pass smtp.mailfrom=runtimeverification.com; dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b=ExVC14f6; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b="ExVC14f6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1787219822; x=1787479022;
	bh=2/bn8C1GiljxycCunjsCAnUpBrSonw1V8BnzctlDV7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ExVC14f6wxk/mhISDM9Qbxc6s249l2GLoQI58Ur07iC8qKkYde6Yyk1wZ69bs6318
	 gLoYMDvZcMTyB9ZaZCE3VX2HqFgN36AjABgrr4ogBEMaw7inUdo99xlrxJQqe8mgrV
	 WDQYltTOT/utIxgQy0+Rks+0DhUF3qwDhvratQiW95+VYqaJY4/21Et0ja6166MzLC
	 kFw4hc4HDBHjLO6iTV9uBo6WhDpsqDFHRPNgsKp6RmVGWXxLMQPisGb76dPNR5ccCs
	 zv4P9A05XsjToz/A3MbbFnFxl5k+jgBtjlCoiawmck1smVhwBIH+kBczffEAcGhbCt
	 621d74B5vikVQ==
X-Pm-Submission-Id: 4hQf3t1Pn8z2ScmM
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
Subject: [PATCH 2/3] media: uvcvideo: Fix integer overflow in frame buffer size calculation
Date: Thu, 20 Aug 2026 12:56:25 +0300
Message-Id: <20260820095626.111196-3-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820095626.111196-1-natalie.klaus@runtimeverification.com>
References: <20260820095626.111196-1-natalie.klaus@runtimeverification.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

The rounding also changes from truncation to round-up. Truncation is
pre-existing rather than introduced here: the original expression used
integer division, so it has rounded a partial trailing byte away since
the driver was merged. Rounding up is the right direction for a buffer
size, and DIV_ROUND_UP() against BITS_PER_BYTE is what the rest of the
media tree uses for this computation, including uvc_parse_format()
itself for the FORCE_BPP quirk.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Cc: stable@vger.kernel.org
Signed-off-by: Noam Ben Shimon <noambs2999@gmail.com>
Signed-off-by: Natasha Klaus <natalie.klaus@runtimeverification.com>
---
Changes from Noam's v2:
- Rebased onto patch 1/3; this patch no longer applies standalone.
- Diagnostic changed from uvc_dbg(dev, DESCR, ...) to dev_warn() on
  &streaming->intf->dev, reworded to begin "UVC non compliance: " and to
  say the frame is skipped. The explicit device and interface numbers are
  dropped from the message text because dev_warn() already identifies the
  interface. (The original could not be kept as-is in any case: patch 1/3
  removes the local alts variable it referenced.)
- bpp, wWidth and wHeight added to the message text (David Laight), matching
  the wording of the diagnostic in 3/3.
- The >> 3 replaced with DIV_ROUND_UP() against BITS_PER_BYTE (David Laight),
  so a partial trailing byte is no longer dropped. The overflow check is
  applied to the rounded-up value.
- The return value is still -EINVAL; what changed is its meaning, which
  patch 1/3 redefines as "skip this frame descriptor" rather than "fail the
  whole streaming interface".
- Last paragraph of the commit message reworded from "reject the frame
  descriptor ... rejection is consistent with the other checks over
  malformed-descriptors in this function" to describe skipping instead, and
  a paragraph added on the rounding change.
- Ricardo Ribalda's Reviewed-by dropped, as it was given on the unmodified
  v2.
- Submitter's Signed-off-by added.
- Fixes: and Cc: stable lines unchanged.

Rounding up also moves the U32_MAX boundary: two inputs within the field
limits (bpp=79 at 10077x43161 and bpp=237 at 3359x43161) landed exactly on
U32_MAX with the old truncation and are now rejected, since the rounded-up
size is not representable.

Build tested on x86_64 only. gcc-multilib was not available in my
environment, so the 32-bit code generation for the DIV_ROUND_UP() on a u64
was not verified; the divisor is the power-of-two constant BITS_PER_BYTE, so
I expect a shift rather than a libgcc 64-bit division helper, but I have not
confirmed it. No hardware and no UVC gadget were used.

 drivers/media/usb/uvc/uvc_driver.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 0cc0e351d139..eb7177ea291d 100644
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
+		bufsize = DIV_ROUND_UP((u64)format->bpp * frame->wWidth *
+				       frame->wHeight, BITS_PER_BYTE);
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

