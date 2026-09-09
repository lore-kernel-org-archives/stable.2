Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00852D2A0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951667; cv=none; b=ihwNde22DM9qSocvG2wzEOeK/tpmmjLACCwurIj7oIsfzgmQGbC5r/F7l2iPQCDwFvVUhIZa2gFhlP9sMrdIQcZyV7A3ArJ7AV4K5z6JAoYGP80SsOA8t++6RQqi7a7FVTkzzCzwZXx73Z+KBugkSqZybToNYy1iwCwlnqZ4pwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951667; c=relaxed/simple;
	bh=6s5/AGwdbndiOSVF0A8Ke1PX1KhBOjyZRh8Ng6+bPGk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IBMHhA26V1qQSOGYaMZI8NujG3pNbTV94HEzNud0rMVEZDuNc9tD2nOySvB/O86n1mKhk27Qx5HHvYu0l8DZlv0f0ZP/yY9v8hImZ8uUAjdr3Iwwz+L9dBuDDXxqAc6T6I6h9jBowFZIe08/2aBZ3K2iBJWGabB3hi3acAWpAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3C09Vvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3C09Vvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463B01F00A3A;
	Wed,  9 Sep 2026 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951665;
	bh=04oIh9NyUOVc7c46JhLqg2LxFYuicmdptcjVVwxNyds=;
	h=Subject:To:Cc:From:Date;
	b=p3C09VvkFPF2+ZJdtSSZhIlcVTg5avdemumyBa3S+7PHmTciX0VFD6jAhuaA+XtnU
	 9X12AkZJa3wexAHJVIf5WuIMVv+SyPd+V2AXmjMGCqKdYdkSZYm4m8Rs1KfqPASghR
	 T6OpRHhoD59iThxhALOWKJlJDkh0OozXydGSv75g=
Subject: FAILED: patch "[PATCH] media: chips-media: wave5: Add timeout while stop_streaming" failed to apply to 6.18-stable tree
To: jackson.lee@chipsnmedia.com,hverkuil+cisco@kernel.org,nas.chung@chipsnmedia.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:53:53 +0200
Message-ID: <2026090953-underline-result-7e3d@gregkh>
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
git cherry-pick -x 2ae7faed2e60d6d07d9efdd962d20dcb15330ced
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-underline-result-7e3d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ae7faed2e60d6d07d9efdd962d20dcb15330ced Mon Sep 17 00:00:00 2001
From: Jackson Lee <jackson.lee@chipsnmedia.com>
Date: Fri, 26 Jun 2026 10:22:29 +0900
Subject: [PATCH] media: chips-media: wave5: Add timeout while stop_streaming

When stop_streaming is called, an infinite loop may occur in some cases.
Add a bounded poll of the queue status: loop until the queues drain,
sleeping briefly between polls, and bail out once VPU_DEC_STOP_TIMEOUT
elapses.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 6c6e86b09b40..93f7b724d86c 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/delay.h>
 #include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
@@ -1537,15 +1538,15 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 {
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
-
-	bool check_cmd = TRUE;
+	unsigned long timeout;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
 	pm_runtime_resume_and_get(inst->dev->dev);
 	inst->empty_queue = true;
-	while (check_cmd) {
+
+	timeout = jiffies + msecs_to_jiffies(VPU_DEC_STOP_TIMEOUT);
+	while (true) {
 		struct queue_status_info q_status;
-		struct dec_output_info dec_output_info;
 
 		wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
 		if ((inst->state == VPU_INST_STATE_STOP ||
@@ -1554,8 +1555,10 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 			q_status.report_queue_count == 0)
 			break;
 
-		if (wave5_vpu_dec_get_output_info(inst, &dec_output_info))
-			dev_dbg(inst->dev->dev, "there is no output info\n");
+		if (time_after(jiffies, timeout))
+			break;
+
+		usleep_range(1000, 2000);
 	}
 
 	v4l2_m2m_update_stop_streaming_state(m2m_ctx, q);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
index 4ebd48d5550e..e04f2dbf3b65 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
@@ -59,7 +59,7 @@
 //  application specific configuration
 #define VPU_ENC_TIMEOUT                 60000
 #define VPU_DEC_TIMEOUT                 60000
-#define VPU_DEC_STOP_TIMEOUT            10
+#define VPU_DEC_STOP_TIMEOUT            300
 
 // for WAVE encoder
 #define USE_SRC_PRP_AXI         0

