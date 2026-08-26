Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611132B131;
	Wed, 26 Aug 2026 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715708; cv=none; b=WINV+6IsYCzMc7CfSbepfKseJ2F42Pz0jX6JDGtWBPXtDdtxuFEKl++mv7QDylffVQ0RylJnVpD4GuQQs5KuuHW+1og6I+b4rYNbz17zkot4RAnvCczzdc+Z/VkjuCksfyTrlkiBsOxitsHz1/DI3OeUvpY4IifGj+wvTexLubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715708; c=relaxed/simple;
	bh=Z5i/moaRA/CjRMqFlkCCPoQH9HwGrGBJ9UnSq1KhBz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cqLhLoduS97GFmwzN7/J+D22kpFW8fUfCqV9CPQdHtA0q4FwN0hAYxZtjgd3JUN1uV2Zqei2LHfn+KNxVoFS6pbL+9rp3fIGb7UaxVn860bxbfyz+l9xinqpDED8fxW4pix0smjf5toNWUAZjxBxnhKYWERvY7tkJLZFLBThVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0cf150d6a10011f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:54f73c20-2849-4baa-83b1-3682bcfa5d84,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:959e9b4b55bb29c944e19680da8f0ae8,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0cf150d6a10011f19a56ed5b684f684d-20260826
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 142324271; Wed, 26 Aug 2026 11:41:41 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+4a6e6173b1fc7916e950@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] input: sur40: fix use-after-free in disconnect
Date: Wed, 26 Aug 2026 11:41:38 +0800
Message-Id: <51e68e6de6d9e7a864a5729bac1b33bd083802f6.1787715605.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the USB device is disconnected while userspace still holds
an open file descriptor to the V4L2 video device, sur40_disconnect()
calls kfree(sur40) immediately after video_unregister_device(). However,
video_unregister_device() only removes the device from the V4L2
framework and does not drop the kref. Userspace still holds a valid
reference to the embedded video_device, causing a use-after-free when
subsequently performing ioctls that access vdev->flags via
video_is_registered().

Fix this by setting vdev->release to a new callback sur40_video_release()
that frees the containing sur40_state via container_of(). Replace the
direct kfree(sur40) in sur40_disconnect() with a reliance on the kref
mechanism: video_unregister_device() triggers device_unregister() which
drops the kref on vdev->dev; when the last reference is released
(all userspace file descriptors closed), the V4L2 core automatically
calls vdev->release(), safely freeing sur40_state.

Also fix the error path err_unreg_video to properly free the
independently-allocated input device and return early, preventing
fall-through to cleanup labels that would access the already-freed
sur40_state.

Fixes: e831cd251fb9 ("[media] add raw video stream support for Samsung SUR40")
Reported-by: syzbot+4a6e6173b1fc7916e950@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a8e44ca.dbb3a75c.7844.002f.GAE@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/input/touchscreen/sur40.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 09d8c5f8d09f..2d93234cc86a 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -237,6 +237,7 @@ static const struct video_device sur40_video_device;
 static const struct vb2_queue sur40_queue;
 static void sur40_process_video(struct sur40_state *sur40);
 static int sur40_s_ctrl(struct v4l2_ctrl *ctrl);
+static void sur40_video_release(struct video_device *vdev);
 
 static const struct v4l2_ctrl_ops sur40_ctrl_ops = {
 	.s_ctrl = sur40_s_ctrl,
@@ -750,6 +751,7 @@ static int sur40_probe(struct usb_interface *interface,
 	sur40->vdev.v4l2_dev = &sur40->v4l2;
 	sur40->vdev.lock = &sur40->lock;
 	sur40->vdev.queue = &sur40->queue;
+	sur40->vdev.release = sur40_video_release;
 	video_set_drvdata(&sur40->vdev, sur40);
 
 	/* initialize the control handler for 4 controls */
@@ -806,6 +808,8 @@ static int sur40_probe(struct usb_interface *interface,
 
 err_unreg_video:
 	video_unregister_device(&sur40->vdev);
+	input_free_device(input);
+	return error;
 err_free_ctrl:
 	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
@@ -820,19 +824,23 @@ static int sur40_probe(struct usb_interface *interface,
 	return error;
 }
 
-/* Unregister device & clean up. */
+static void sur40_video_release(struct video_device *vdev)
+{
+	struct sur40_state *sur40 = container_of(vdev, struct sur40_state, vdev);
+
+	v4l2_ctrl_handler_free(&sur40->hdl);
+	v4l2_device_unregister(&sur40->v4l2);
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
+}
+
 static void sur40_disconnect(struct usb_interface *interface)
 {
 	struct sur40_state *sur40 = usb_get_intfdata(interface);
 
 	input_unregister_device(sur40->input);
 
-	v4l2_ctrl_handler_free(&sur40->hdl);
 	video_unregister_device(&sur40->vdev);
-	v4l2_device_unregister(&sur40->v4l2);
-
-	kfree(sur40->bulk_in_buffer);
-	kfree(sur40);
 
 	usb_set_intfdata(interface, NULL);
 	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
-- 
2.25.1

