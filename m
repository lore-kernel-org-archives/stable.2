Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664233;
	b=OUaJRhS02lFrQLYsV34hcTEMZj8sNl9eQd9PEFNqh9be05JUT25mqQhjveeA2JGJp5Su
	 RGx3l1j6VrZOSg/qjxL4ik5s2XeBKcgvLdcKnp1+C6gWMX0nnLzjd7NdNw4NqMdveXQAI
	 LkLBct8CPbHULaUigoVBT65ZsR2GSKiNqfOsyP8WYl7jK5lqdymRKb20s9ZZJixqCfDeZ
	 qfPpAQ3wtaI3cO1itYk3KzCg52BRUX8Njp4SUx95TZ6veVb4MYRYkqXvPbLY0PPXASqF1
	 o648E1B+qnD8cCU9KbNc6FedFA/3DZtFZc+CYEaao0Fx7qbPn/0PIKnTcjyessRBShA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664233;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MpQDFTjOnZQ2jUpmmDnU5MLaPPCLMzpos0JrnSoekyU=;
	b=bz8WnKjbwErG5WDV9qTi31QqKfLW4Hr+PYpk07rSvefkRGius0icrk6MYjDNyfSeH2xs
	 gC3cNZlGIXX+ZG4YI4+vhW1fssO65YmiMMPNe4vX2YdzcLTp4o9TzQATzIAXTuHIz298P
	 7fIuikbCME8CqDqjWo5Gf4uLfOJgAxTtyeTVRPOruR9O9as9BbtZeub07R4E9KZRne2+h
	 40pa+T1CRpDvjVZW0yWdLXMTEiT2ri2KmsA8g1G6G/fu1SjdeBDnGgfp+omz+wTnoqg3g
	 HyNEdYi6K2qW+t4kbxp6fKU37Rhyw0v2dmWnpstc0r76GK1NWA9UvzTNFJfohXl8gOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aW4TJIVW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4003606A31E;
	Thu, 22 Oct 2026 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aW4TJIVW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792664231;
	b=bAu60N97WvNESTm7zar7jRFDSrsKWSoBmqPwkOiv+11BrtW5ph0hx53IKK6Z3OLZvmKD
	 hUfpczH/T/Zd7hhT7m8dUcD4WF8JDv+W83UIZwAayFkSfFFPiKBeQ38vuzBFjuC4EcCMo
	 owWfGtXGyqpljIKd1vjIfhJxh/idzvN8zU2KFqDrK1DDps8W60h/cBN1lKg5JW2a9RPff
	 GHLxV8xxG+7xukaFx29oRg8+oYfi1uz49yL5eFFwHWxgG9U95gvIAQAV7Vu0GQbMRh06K
	 RsMEaI5kzjSCZS/gF6tfcYdW55I353Kd9Qye/3NhWyGG1Dhq/QczC+ALFaXPDCCR1FQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792664231;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MpQDFTjOnZQ2jUpmmDnU5MLaPPCLMzpos0JrnSoekyU=;
	b=pHPkIsZiu5b5gfqnYsdFGBiBYPaWbnkPJF3wsUB/oRsLWT+Iqmy1t1w1EhA/LKBPmSK/
	 boSM6EtXF50WCRc763q4uk2klDvKakxMozRlq9YDWXVGPmR75hzNYa9Nga/TsRptkqr/4
	 OLlg+clCCPcSjnzRL5RGXS4wdeQei3TUbro8YDDy4iI+7h0AYyRGIkvmlCjmPf7OxNs6e
	 gN1h9xQ1p1LlIRHx9g4ZaP+1iEr5fT3op5Sy70ukYykaitUgQ9MAXOuQZq+0zO6OfvQli
	 5q4jZMqClAObuUDCWX8p2MaIRXl0uDJWO5vO3Ppg0/bZVRjSz+5vFp51H95yl/iXzsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3DF991F000C4;
	Thu, 22 Oct 2026 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664231;
	bh=MpQDFTjOnZQ2jUpmmDnU5MLaPPCLMzpos0JrnSoekyU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=aW4TJIVWnXB4vi/G7LXEGrMMtm2Hwki/pB5cGxCbjxx49Wbc++fxxjIZRRW4YBn8l
	 W+/vxkll1rZHtRcEjlVbNAobN1lbEX/tJf90ztuMW7iuGjniT+LVmlrjgdKvzMDT0h
	 o9/A+aXC0q4sneiqjc+mSn/hFrIAuUAuqSzIBGb15U3lX003D7BTMayDQUj+XAGycv
	 LU3B4P8r9lke/zaNegmqwRAsxEpH14J0GYCdJN5zRNE7syZcGz0T5zsXAOqI7sr2WB
	 m3zu1NzZShU7iqf5rgQhnJI6rbqT33lpHY4gDtb2cj4sJ3NR3b6YDkhlacbPSsiUtT
	 MwvYulrrVFvFw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E1AB43556;
	Thu, 22 Oct 2026 10:17:10 +0000 (UTC)
From: Johannes Schrimpf via B4 Relay <devnull+johannes.schrimpf.blueye.no@kernel.org>
Date: Thu, 22 Oct 2026 12:16:52 +0200
Subject: [PATCH v2] media: uvcvideo: Release streaming interfaces at
 disconnect, not last close
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
Message-Id: <20261022-uvc-release-intfs-v2-1-901bc1c47cfb@blueye.no>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/32Nyw6CMBBFf4XM2hqKUtGV/2FY9DGVGlJMhzYSw
 r/b4t7M6uTee2YFwuCQ4FatEDA5cpPP0Bwq0IP0T2TOZIambgSv+ZnFpFnAESXlyM+WmLXXFk8
 XIRRvIe/eAa377M5H/2OK6oV6LqLSGBzNU1j2p4mX3j9/4ixfZwR2xkppursaIy549BP027Z9A
 XPd/+fEAAAA
X-Change-ID: 20261014-uvc-release-intfs-ff95e3766b15
To: laurent.pinchart@ideasonboard.com, hansg@kernel.org
Cc: ribalda@chromium.org, hverkuil@kernel.org, linux-kernel@vger.kernel.org, 
 mchehab@kernel.org, linux-media@vger.kernel.org, stable@vger.kernel.org, 
 Johannes Schrimpf <johannes.schrimpf@blueye.no>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792664229; l=7840;
 i=johannes.schrimpf@blueye.no; s=20261014; h=from:subject:message-id;
 bh=jITjUBkqSOrja9OK7j/wiP5VysOC8DbpzIk24IUo4ns=;
 b=PCRLhcqexTTYWT5A2+bjtxRNBlp44aWrcGYfceBjjiWYGAmJlROJ8vu54EeiA1t9sISWgXKH8
 khjZYShjQuUDa4Daum8GIFwL3duaVHmaLkve+IbVHmoTdqhAwatZbPI
X-Developer-Key: i=johannes.schrimpf@blueye.no; a=ed25519;
 pk=900KgDI7vLhnD9R982XOT47UCm3e4vWxQWBC4jDCUPo=
X-Endpoint-Received: by B4 Relay for johannes.schrimpf@blueye.no/20261014
 with auth_id=1178
X-Original-From: Johannes Schrimpf <johannes.schrimpf@blueye.no>
Reply-To: johannes.schrimpf@blueye.no
Content-Transfer-Encoding: 7bit

From: Johannes Schrimpf <johannes.schrimpf@blueye.no>

If a UVC camera goes through a USB reset while an application holds it
open, the camera is unusable after the reset.

The old uvc_device releases its streaming interfaces only when its last
open file handle is closed, which unbinds them from the new uvc_device
that has claimed them in the meantime.

Release them on disconnect and on the probe error path instead, as the
last step of uvc_unregister_video(), which is renamed to
uvc_unregister_device().

This also ensures that usb_driver_release_interface() is only called
with the USB device lock held.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.14: &uvc_driver.driver
Assisted-by: LLM
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Johannes Schrimpf <johannes.schrimpf@blueye.no>
---
Changes in v2:
- Shorten the commit message; the details are now below (Ricardo).
- Move the release into uvc_unregister_video() as its last step and
  rename that function to uvc_unregister_device() (Ricardo). The
  release still runs after the video nodes are unregistered and before
  kref_put(), in uvc_disconnect() and on the probe error path.
- Add Ricardo's Reviewed-by.
- Link to v1: https://patch.msgid.link/20261014-uvc-release-intfs-v1-1-18d6e8dfaad8@blueye.no
---
Details from the v1 commit message:

Mechanism: uvcvideo has no pre_reset() and post_reset() handlers, so
usb_reset_device() unbinds it and probes it again on the same struct
usb_interface objects. A file handle from before the reset keeps the
old uvc_device alive. usb_driver_release_interface() only checks that
the interface is bound to uvcvideo, not to which uvc_device, so the
old uvc_delete() unbinds the interfaces from the new device. The URBs
of a running stream then complete with -ESHUTDOWN,
uvc_video_complete() sets UVC_QUEUE_DISCONNECTED, and every following
VIDIOC_QBUF fails with -ENODEV. Nothing is logged, and the stream stays
dead until the next reset or replug.

Reproduction, with a Sonix camera (0c45:6366) on an i.MX6Q board,
Linux 6.18.24 (linux-fslc-imx):

  1. open() a video node of the camera and keep the file handle
  2. reset the camera with USBDEVFS_RESET
  3. stream from a video node of the re-probed device
  4. close() the file handle from step 1

The stream fails within a few milliseconds of the close() in 4 of 4
runs, with one KOBJ_UNBIND uevent per VideoStreaming interface; the
VideoControl interface stays bound. A handle on either streaming
interface has the same effect. Without step 1 the stream survives.

usb-serial splits it the same way: usb_serial_disconnect() releases the
sibling interface, and its kref release, destroy_serial(), releases
none. With no file handle open, uvc_disconnect() drops the last
reference itself, so on that path the interfaces are still released
from within uvc_disconnect(), as before.

Tested with v1 on the same board and kernel: the reproduction with the
handle on either streaming interface or closed before the stream
starts, a USB reset without a held handle, sysfs unbind/bind of the
VideoControl interface with and without a held handle, and a second
UVC camera (MJPEG and H.264 at 1080p). The stream survives all four
streaming runs, none of the five stale-handle closes unbinds an
interface, and the close() takes 0.13-0.23 ms instead of 38-42 ms.
USB-reset recovery and the second camera work, and sysfs unbind/bind
releases and reclaims the streaming interfaces.

Tested with v2 on the same board, built into the kernel image: the
reproduction with the handle on either streaming interface, closed
before the stream starts, and with no handle held. The stream survives
all four runs and no interface is unbound; in the two runs that close
the stale handle while streaming, 149 frames arrive in the 5 s after
the close.

Ricardo's "media: uvcvideo: Remove refcounted cleanup" (Nov 2024) would
have moved all device cleanup into uvc_disconnect(), and was NACKed
because it fixed no concrete bug. This patch keeps the refcounted
cleanup and moves only the release of the streaming interfaces.

Tool use: this was developed with an LLM coding assistant, Claude Code
running Claude Opus 5.5; v1 was also reviewed by GPT-6 Astra. Starting
from stream failures in our bench logs, the assistant traced the code
path, wrote the reproduction scripts, ran them and the tests above on
the device, surveyed the upstream history and other drivers, built and
checked the patch on media-committers next, and drafted the patch, the
changelog and these notes.

Test kernel: linux-fslc-imx 6.18.24 with three local uvcvideo patches
(keep MJPEG frames recovered by MJPEG_NO_EOF, nodrop=0 by default, and a
coherent_urbs parameter). None of them touches probe, uvc_disconnect(),
uvc_delete(), the interface claim/release or uvc_video_complete().

Not tested:
- an unmodified uvcvideo, or any kernel other than linux-fslc-imx
  6.18.24; on media-committers next, the patch is build-tested only
  (v1: gcc and clang, arm, arm64 and x86_64, W=1, sparse, smatch; v2:
  gcc, arm, W=1)
- a debug kernel: the test kernel is the board's production config
  (SMP, PREEMPT; no lockdep, DEBUG_ATOMIC_SLEEP, DEBUG_MUTEXES,
  SLUB_DEBUG, DEBUG_PAGEALLOC or KASAN)
- unplug and replug, sysfs unbind of a VideoStreaming interface, and
  the probe error path
- frame delivery after a sysfs rebind: the Sonix camera delivers no
  frames after any re-probe that does not follow a USB reset, with and
  without this patch, so those runs check only the binding; the
  second camera was not rebound
- v4l2-compliance
- any camera other than the two on this board
---
 drivers/media/usb/uvc/uvc_driver.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index cbc1456..bb8f0e3 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1976,7 +1976,6 @@ static void uvc_delete(struct kref *kref)
 		struct uvc_streaming *streaming;
 
 		streaming = list_entry(p, struct uvc_streaming, list);
-		usb_driver_release_interface(&uvc_driver, streaming->intf);
 		uvc_stream_delete(streaming);
 	}
 
@@ -1992,9 +1991,9 @@ static void uvc_release(struct video_device *vdev)
 }
 
 /*
- * Unregister the video devices.
+ * Unregister the device and release the streaming interfaces.
  */
-static void uvc_unregister_video(struct uvc_device *dev)
+static void uvc_unregister_device(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
@@ -2024,6 +2023,14 @@ static void uvc_unregister_video(struct uvc_device *dev)
 	if (media_devnode_is_registered(dev->mdev.devnode))
 		media_device_unregister(&dev->mdev);
 #endif
+
+	/*
+	 * Release the streaming interfaces here, not in uvc_delete(): after a
+	 * USB reset, a new uvc_device may already have claimed the same
+	 * interfaces.
+	 */
+	list_for_each_entry(stream, &dev->streams, list)
+		usb_driver_release_interface(&uvc_driver, stream->intf);
 }
 
 int uvc_register_video_device(struct uvc_device *dev,
@@ -2355,7 +2362,7 @@ static int uvc_probe(struct usb_interface *intf,
 	return 0;
 
 error:
-	uvc_unregister_video(dev);
+	uvc_unregister_device(dev);
 	kref_put(&dev->ref, uvc_delete);
 	return ret;
 }
@@ -2374,7 +2381,7 @@ static void uvc_disconnect(struct usb_interface *intf)
 	    UVC_SC_VIDEOSTREAMING)
 		return;
 
-	uvc_unregister_video(dev);
+	uvc_unregister_device(dev);
 	kref_put(&dev->ref, uvc_delete);
 }
 

---
base-commit: d7e7bca7169873b46e857c025c10f3336c1258d8
change-id: 20261014-uvc-release-intfs-ff95e3766b15

Best regards,
--  
Johannes Schrimpf <johannes.schrimpf@blueye.no>


