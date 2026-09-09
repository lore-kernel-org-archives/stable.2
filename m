Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E25328C3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951663; cv=none; b=jDJGi/qOA8S4VIrtqQSsQq1/7B2I/Lmxg0OPhqmuvwrZYZxUBFidF4DWdxUvLZ38adO6pMlEqfKwwsK64HFonBp2Q83Oxb/D9++Ur2uF/ULvP+gvcGj3obLnggB6CJiY1ycSsDH3GlAy75dJdAC34dUVh+LiZPc7enqZdeqLmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951663; c=relaxed/simple;
	bh=Z69A0XFH2F7EPg7m7ajr+eP7ASLnXpyJTSWSPn9fQnw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=edTdlpHHq6/YH6RO9fXBLF3d0dvSl4WGNGtZ++IgMDfQ5jz7LEFPYGRAjaUYGObL5XbwZgfTdhNj1eG/CIbEqQK+CxQ1lp8/b+VpxfQHZ0jS4+JLQzJa31Fbch76phgSOHXQgZI9bWmnS1sj5JuyE5I/BoEY12Ah72vk+rhocpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CaBsOsVb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CaBsOsVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFEB1F00A3A;
	Wed,  9 Sep 2026 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951660;
	bh=G+9WDS2aL4mcUVQVW7khaxvQE8Ehhg18r6SUPU+Pd2Q=;
	h=Subject:To:Cc:From:Date;
	b=CaBsOsVbTNusc2OfiXH2V7JdeyrwkYsZWbvm8s2vrY4QiQmvgbg4ltlVCqRzelGC9
	 lRLJCVsbWkBHZu0QlvH5ID0vtgBMtxrU1/xR3GP6bB1SHU6cYiR88ECoC3bEa/D7Fy
	 0zsRsRjz8VWR2V1RKRhkG0kWLzTHSwayimY3it5I=
Subject: FAILED: patch "[PATCH] media: chips-media: wave5: Set inst->std during default" failed to apply to 6.12-stable tree
To: jackson.lee@chipsnmedia.com,hverkuil+cisco@kernel.org,nas.chung@chipsnmedia.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:53:34 +0200
Message-ID: <2026090934-extrovert-manatee-136f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cfcefc5a996f6a00b310c963b5f811430f28a30a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090934-extrovert-manatee-136f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cfcefc5a996f6a00b310c963b5f811430f28a30a Mon Sep 17 00:00:00 2001
From: Jackson Lee <jackson.lee@chipsnmedia.com>
Date: Fri, 26 Jun 2026 10:22:27 +0900
Subject: [PATCH] media: chips-media: wave5: Set inst->std during default
 format initialization
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the encoder is opened, wave5_set_default_format() sets up the
default capture format (e.g. H.264) but does not initialize inst->std.
As a result, inst->std remains zero, which does not match any valid
encoder codec.

If STREAMON is called before the user explicitly calls S_FMT on the
capture queue — as v4l2-compliance does in testBlockingDQBuf — the
codec/product check in wave5_vpu_enc_init_seq() fails with
"Unsupported encoder-codec & product combination" because inst->std
is neither W_HEVC_ENC nor W_AVC_ENC, returning -EOPNOTSUPP.

Fix this by setting inst->std via wave5_to_vpu_std() in
wave5_set_default_format(), so that the codec type is always consistent
with the default capture pixel format from the moment the instance is
opened.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index e6c94b6f2671..f9fcdf4c224b 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1494,7 +1494,8 @@ static const struct vb2_ops wave5_vpu_enc_vb2_ops = {
 	.stop_streaming = wave5_vpu_enc_stop_streaming,
 };
 
-static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_fmt,
+static void wave5_set_default_format(struct vpu_instance *inst,
+				     struct v4l2_pix_format_mplane *src_fmt,
 				     struct v4l2_pix_format_mplane *dst_fmt)
 {
 	src_fmt->pixelformat = enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
@@ -1506,6 +1507,7 @@ static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_fmt,
 	wave5_update_pix_fmt(dst_fmt, VPU_FMT_TYPE_CODEC,
 			     W5_DEF_ENC_PIC_WIDTH, W5_DEF_ENC_PIC_HEIGHT,
 			     &enc_frmsize[VPU_FMT_TYPE_CODEC]);
+	inst->std = wave5_to_vpu_std(dst_fmt->pixelformat, inst->type);
 }
 
 static int wave5_vpu_enc_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
@@ -1770,7 +1772,7 @@ static int wave5_vpu_open_enc(struct file *filp)
 	inst->v4l2_fh.ctrl_handler = v4l2_ctrl_hdl;
 	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
 
-	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
+	wave5_set_default_format(inst, &inst->src_fmt, &inst->dst_fmt);
 	inst->conf_win.width = inst->dst_fmt.width;
 	inst->conf_win.height = inst->dst_fmt.height;
 	inst->colorspace = V4L2_COLORSPACE_REC709;

