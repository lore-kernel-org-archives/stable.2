Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608852E043
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951653; cv=none; b=mc22k4vo+Fcdpz8oMbj35swB4OW4bkGNRxWjrxcvTP9THscBXR7RrFxG7ZjAfAQKqEezr9QxIp4CtdYDR0Kf66o8WdabtocoN2Skrn2DF3A0dPmIhdnqXxZCCKz50Jf8O636mGQoiUbWebwTstxWUjqr1hJWmXC5TOda/v6un2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951653; c=relaxed/simple;
	bh=MWTVjt7jhYyePQbYLT7ac6Ecfqadhgpz+Ka5+pm/iMk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qQQ4VlrGQOaW+kZuBUKgSdFYR3Y6ZzKh98kZ9czpJNDNwexOOWDOW10fstEAeihv87SJnHi7ge0WbEZINnzCQcIz2j9uhvfLKatYghQVw5dMb42IHqsaMqID7naca8P890K5MiCO/LWOlX/aFk+zzSVmKcvFchjbmr78FE/Lug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P8TTipfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P8TTipfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E54A1F00A3D;
	Wed,  9 Sep 2026 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951651;
	bh=sw1U37gV/NIZrZVgzCFlT3TGRffQzyfFDUz2sq3WA2s=;
	h=Subject:To:Cc:From:Date;
	b=P8TTipfxOLZTIQgGuo6YsYUW0NIhNahhdYbl65150yW7kVsmxST2/C2aLgk+LXziM
	 4cpJwVRi7PVjuQfr16KHzR7YUV2qBfbJC5m4PdK5nEOSCe+znMF3n/3aoGZWtbljoC
	 0TQYjLl7AbpvSX22eBcKFbmZOVGdGAkXvQa0f4xQ=
Subject: FAILED: patch "[PATCH] media: qcom: iris: fix missing hfi_id in gen1 GOP_SIZE cap" failed to apply to 6.18-stable tree
To: wangao.wang@oss.qualcomm.com,bod@kernel.org,busanna.reddy@oss.qualcomm.com,vikash.garodia@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:52:57 +0200
Message-ID: <2026090957-mandarin-lurk-07db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5eebacbc9a38e1019854ea5f86e367a4d5116387
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090957-mandarin-lurk-07db@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5eebacbc9a38e1019854ea5f86e367a4d5116387 Mon Sep 17 00:00:00 2001
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:55:54 +0800
Subject: [PATCH] media: qcom: iris: fix missing hfi_id in gen1 GOP_SIZE cap

Add hfi_id to gen1 encoder GOP_SIZE cap and replace the set function,
remove the redundant INTRA_PERIOD cap.

Fixes: d22037f3fd33 ("media: iris: Set platform capabilities to firmware for encoder video device")

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 10e33b8a73f6..391e1fc5f6e2 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -1293,7 +1293,7 @@ int iris_set_use_and_mark_ltr(struct iris_inst *inst, enum platform_inst_fw_cap_
 int iris_set_intra_period(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id)
 {
 	const struct iris_hfi_session_ops *hfi_ops = inst->hfi_session_ops;
-	u32 gop_size = inst->fw_caps[GOP_SIZE].value;
+	u32 gop_size = inst->fw_caps[cap_id].value;
 	u32 b_frame = inst->fw_caps[B_FRAME].value;
 	u32 hfi_id = inst->fw_caps[cap_id].hfi_id;
 	struct hfi_intra_period intra_period;
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1.c
index ca1545d28b53..eff9216bb501 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen1.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1.c
@@ -171,7 +171,9 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
 		.max = (1 << 16) - 1,
 		.step_or_mask = 1,
 		.value = 30,
-		.set = iris_set_u32
+		.hfi_id = HFI_PROPERTY_CONFIG_VENC_INTRA_PERIOD,
+		.flags = CAP_FLAG_OUTPUT_PORT,
+		.set = iris_set_intra_period,
 	},
 	{
 		.cap_id = ENTROPY_MODE,
@@ -240,7 +242,7 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
 		.step_or_mask = 1,
 		.value = 0,
 		.hfi_id = HFI_PROPERTY_PARAM_VENC_INTRA_REFRESH,
-		.flags = CAP_FLAG_OUTPUT_PORT,
+		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_DYNAMIC_ALLOWED,
 		.set = iris_set_ir_period_gen1,
 	},
 	{
@@ -281,16 +283,6 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
 		.value = 0,
 		.flags = CAP_FLAG_OUTPUT_PORT,
 	},
-	{
-		.cap_id = INTRA_PERIOD,
-		.min = 0,
-		.max = 1,
-		.step_or_mask = 1,
-		.value = 0,
-		.hfi_id = HFI_PROPERTY_CONFIG_VENC_INTRA_PERIOD,
-		.flags = CAP_FLAG_OUTPUT_PORT,
-		.set = iris_set_intra_period,
-	},
 	{
 		.cap_id = LAYER_ENABLE,
 		.min = 0,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index c9256f2323dc..ff48333ad089 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -165,7 +165,6 @@ enum platform_inst_fw_cap_type {
 	USE_LTR,
 	MARK_LTR,
 	B_FRAME,
-	INTRA_PERIOD,
 	LAYER_ENABLE,
 	LAYER_TYPE_H264,
 	LAYER_TYPE_HEVC,

