Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13253488774
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330227; cv=none; b=Ts/we1a73rJ0mkOEpuwlFqMbQCBjFTtCCBREYLHavBoqqOXv0TE8zYpsg269moHGtKjj7gEVW2E+M/VL1dVMai7tauuhzDzUcDZlYqqPjA0QFOk/vNK5MGgBg8daxSLkMg9YEznYhq7yY2CWvF7o2RxWmSbxwpUQcfzwaROcrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330227; c=relaxed/simple;
	bh=9hM79qCMExY0oBawnMunlJxGKoo3wF6SD35dkzQ13bg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JRmvPpRaRmZ0tPORBgCNe3NfMHeUaRCHjyt708Dz3KhidLBctUZj2qgrdUOwDIi3PmOHSXI8ARhDoeIfnqBqYYgMv6N1ybDzhV1USvjVVUKsiQ/iNeAIBw8w20/MSRg1lfYnN1rUNPfVZTVrrUmh6AYTHpVgU+n/1pgHaGUYGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R0jfLhh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R0jfLhh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A461F000E9;
	Wed, 29 Jul 2026 13:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330225;
	bh=76TfGeN8Z4708CboWwGDMwBmIQ1tEjeXRwiRJf8t+xs=;
	h=Subject:To:Cc:From:Date;
	b=R0jfLhh2cKdN7fiSMVmmN/KIt/FijZFfULrsamZZC9QMpMoubIwov46xg564jDWKA
	 DfzJ0cqC07Rf+SlYkgw+SeB8JTD4LRW7QcCGY0Mxhk3864/e3U2evyY7m/WfATWeuS
	 8dpBbzHy/tv3IcBZ44BGj0O7d2LHi0LgU9MZOiZ4=
Subject: FAILED: patch "[PATCH] media: vivid: add vivid_update_reduced_fps()" failed to apply to 5.15-stable tree
To: hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:03:32 +0200
Message-ID: <2026072932-scuttle-monorail-eabe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1d793a29efb4260f90913f5287939bf95573b073
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072932-scuttle-monorail-eabe@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d793a29efb4260f90913f5287939bf95573b073 Mon Sep 17 00:00:00 2001
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Date: Wed, 20 May 2026 09:30:44 +0200
Subject: [PATCH] media: vivid: add vivid_update_reduced_fps()

Don't call vivid_update_format_cap() when switching to/from reduced fps
for HDMI inputs: that will also reset the format, which is overkill for
this.

Make a new vivid_update_reduced_fps() function that just updates the
dev->timeperframe_vid_cap.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Fixes: c79aa6aeadb0 ("[media] vivid-capture: add control for reduced frame rate")
Cc: stable@vger.kernel.org
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/test-drivers/vivid/vivid-ctrls.c b/drivers/media/test-drivers/vivid/vivid-ctrls.c
index f94c15ff84f7..1077445f5772 100644
--- a/drivers/media/test-drivers/vivid/vivid-ctrls.c
+++ b/drivers/media/test-drivers/vivid/vivid-ctrls.c
@@ -609,7 +609,8 @@ static int vivid_vid_cap_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case VIVID_CID_REDUCED_FPS:
 		dev->reduced_fps = ctrl->val;
-		vivid_update_format_cap(dev, true);
+		if (dev->input_type[dev->input] == HDMI)
+			vivid_update_reduced_fps(dev);
 		break;
 	case VIVID_CID_HAS_CROP_CAP:
 		dev->has_crop_cap = ctrl->val;
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index b95f06a9b5ae..76e0b161c049 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -364,6 +364,24 @@ static enum tpg_pixel_aspect vivid_get_pixel_aspect(const struct vivid_dev *dev)
 	return TPG_PIXEL_ASPECT_SQUARE;
 }
 
+void vivid_update_reduced_fps(struct vivid_dev *dev)
+{
+	struct v4l2_bt_timings *bt = &dev->dv_timings_cap[dev->input].bt;
+	unsigned int size = V4L2_DV_BT_FRAME_WIDTH(bt) * V4L2_DV_BT_FRAME_HEIGHT(bt);
+	u64 pixelclock;
+
+	if (dev->reduced_fps && can_reduce_fps(bt)) {
+		pixelclock = div_u64(bt->pixelclock * 1000, 1001);
+		bt->flags |= V4L2_DV_FL_REDUCED_FPS;
+	} else {
+		pixelclock = bt->pixelclock;
+		bt->flags &= ~V4L2_DV_FL_REDUCED_FPS;
+	}
+	dev->timeperframe_vid_cap = (struct v4l2_fract) {
+		size / 100, (u32)pixelclock / 100
+	};
+}
+
 /*
  * Called whenever the format has to be reset which can occur when
  * changing inputs, standard, timings, etc.
@@ -372,8 +390,6 @@ void vivid_update_format_cap(struct vivid_dev *dev, bool keep_controls)
 {
 	struct v4l2_bt_timings *bt = &dev->dv_timings_cap[dev->input].bt;
 	u32 dims[V4L2_CTRL_MAX_DIMS] = {};
-	unsigned size;
-	u64 pixelclock;
 
 	switch (dev->input_type[dev->input]) {
 	case WEBCAM:
@@ -402,17 +418,7 @@ void vivid_update_format_cap(struct vivid_dev *dev, bool keep_controls)
 	case HDMI:
 		dev->src_rect.width = bt->width;
 		dev->src_rect.height = bt->height;
-		size = V4L2_DV_BT_FRAME_WIDTH(bt) * V4L2_DV_BT_FRAME_HEIGHT(bt);
-		if (dev->reduced_fps && can_reduce_fps(bt)) {
-			pixelclock = div_u64(bt->pixelclock * 1000, 1001);
-			bt->flags |= V4L2_DV_FL_REDUCED_FPS;
-		} else {
-			pixelclock = bt->pixelclock;
-			bt->flags &= ~V4L2_DV_FL_REDUCED_FPS;
-		}
-		dev->timeperframe_vid_cap = (struct v4l2_fract) {
-			size / 100, (u32)pixelclock / 100
-		};
+		vivid_update_reduced_fps(dev);
 		if (bt->interlaced)
 			dev->field_cap = V4L2_FIELD_ALTERNATE;
 		else
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.h b/drivers/media/test-drivers/vivid/vivid-vid-cap.h
index 38a99f7e038e..d08a85927510 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.h
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.h
@@ -9,6 +9,7 @@
 #define _VIVID_VID_CAP_H_
 
 void vivid_update_quality(struct vivid_dev *dev);
+void vivid_update_reduced_fps(struct vivid_dev *dev);
 void vivid_update_format_cap(struct vivid_dev *dev, bool keep_controls);
 void vivid_update_outputs(struct vivid_dev *dev);
 void vivid_update_connected_outputs(struct vivid_dev *dev);

