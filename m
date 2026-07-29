Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F3486641
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330155; cv=none; b=a2iDjXSG1QbxKnGjNpJDUoojNv5pDZKVyC8X2cNfwnRyHBr9Mb/bdP3czOUqtSFGRVliku0PoI1hAmC7VTQxJmrr8Q6+O7TkCFVzMeTRrpPFmGW5E0vBA9nyaE4NaKbQVvLYgGxSlojKl4bUO83aBW4zhSFnNNaHgEuX5PHDqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330155; c=relaxed/simple;
	bh=1fxDhMGawQColmmUj9wFvTkunSllQk08Sejo/6JJi9w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q7g7jVRQHlmY9DHGc+t5pCdaDk00/AjoVsI9Himx04jrjqoFvyuJXKuI08OgCgSmlqeGXuVd7ebt1gzemCGLJWQU+WsRx1Jq82SUXjpmYmn+QAMCK9QhgrvgTuLYHRFX/bXBFr7z5UL22eLORtHFpbu/+qcahE5xOZZJnE0Vnus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2VjocFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2VjocFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE1B1F000E9;
	Wed, 29 Jul 2026 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330151;
	bh=eWCruu7HlA8ecM99L9ynh3Z0fjY9Sc7coBcbR4nW2dY=;
	h=Subject:To:Cc:From:Date;
	b=L2VjocFndoyvb8e8Exj6Hhc4K3F9DUP52V3RUgeBAhiQjbG6U/msHKbXx9PeA5ex7
	 u0bLECtPpqCo0tqX41XNzvkTi0KprkUUcDXPdi8Rb8BQp6VFn38BJ9Mq8BQw6ic2V4
	 5sYwGj5MGHlFb2DXK/SS7iCYNdSsYu9kiBI43jP8=
Subject: FAILED: patch "[PATCH] media: v4l2-ctrls: validate HEVC active reference counts" failed to apply to 5.15-stable tree
To: pengpeng@iscas.ac.cn,hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:02:15 +0200
Message-ID: <2026072915-skies-omnivore-06eb@gregkh>
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
git cherry-pick -x afbe4bc252d90a6f8fad869b06d5430f615f22f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072915-skies-omnivore-06eb@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From afbe4bc252d90a6f8fad869b06d5430f615f22f9 Mon Sep 17 00:00:00 2001
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 24 Mar 2026 11:13:26 +0800
Subject: [PATCH] media: v4l2-ctrls: validate HEVC active reference counts

HEVC slice parameters are shared stateless V4L2 controls, but the common
validation path does not verify the active L0/L1 reference counts before
driver-specific code consumes them.

The original report came from Cedrus, but the active count bounds are
not Cedrus-specific. Validate them in the common HEVC slice control path
so stateless HEVC drivers get the same basic guarantees as soon as the
control is queued.

Do not reject ref_idx_l0/ref_idx_l1 entries here. Existing userspace may
use out-of-range sentinel values such as 0xff for missing references, and
some hardware can use that information for concealment. Keep this common
check limited to the active reference counts.

Fixes: d395a78db9eab ("media: hevc: Add decode params control")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 6b375720e395..ba047d7d8601 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -971,6 +971,7 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 	struct v4l2_ctrl_hevc_ext_sps_st_rps *p_hevc_st_rps;
 	struct v4l2_ctrl_hevc_sps *p_hevc_sps;
 	struct v4l2_ctrl_hevc_pps *p_hevc_pps;
+	struct v4l2_ctrl_hevc_slice_params *p_hevc_slice_params;
 	struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
 	struct v4l2_ctrl_hevc_decode_params *p_hevc_decode_params;
 	struct v4l2_area *area;
@@ -1260,6 +1261,18 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 		break;
 
 	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
+		p_hevc_slice_params = p;
+
+		if (p_hevc_slice_params->num_ref_idx_l0_active_minus1 >=
+		    V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
+			return -EINVAL;
+
+		if (p_hevc_slice_params->slice_type != V4L2_HEVC_SLICE_TYPE_B)
+			break;
+
+		if (p_hevc_slice_params->num_ref_idx_l1_active_minus1 >=
+		    V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
+			return -EINVAL;
 		break;
 
 	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS:

