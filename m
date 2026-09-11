Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301D339389
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135885; cv=none; b=Tjr4q1UIAPnBAgLF8N8WRzhCuDbiISQld8CmlAouq9CIKrJJsADlcq1mMXOQw7tTGTK3B1xSLTvZSc++U8MK2kq/IfBYvoooqibytYAC93UBojVoFEk4v0ihVigzPoRkHlfxppnmpFfAuAWg6SiN7N8GtoSMn+4ai6qm+lOtunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135885; c=relaxed/simple;
	bh=vd38BHuAyWVWOS6zo3mBWIi3WGzSfK5WGYn9GHMvp08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsd4+EaR9+O6QuX7jXDH3Njv25bezTPNMmrbApglxh4kH9udLtJiCjnXI46tla7dPQArtTbg826M8vWsQjYwo/Dk5LZRyn+aLvsgQGvMmZAf3QjhzgG4tdi3jX1LlkEFQCt/kYoU1fI0hCc4OFq6g254GXkubBSiWNTAxJwN6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua/qmgqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua/qmgqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5E61F00898;
	Fri, 11 Sep 2026 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135884;
	bh=aLR0qIf4a28Wt0SrOsRQyXLzLEqwT/REOiB/6EeYqM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ua/qmgqrVYdbzmBBIflCacI4KrxT60jtXlK4u8YyzkaRlQt5OxGG7ZZJPkfa+1PER
	 7F0W/+w0qAReJtq11U9rhft//NBDuQ+P//X9XNx/0tryYI7h44FdccGvMEp/Twp51k
	 2RM2uMa/GIRnsnJYQhzXoPwM5ecexU/gmo3JyMNdUlI8g13qg78/k4nBs6MzcKuBRH
	 gFBDMMd4h+tWqq8jM19O3YD3dl2MHegvmuUNB2PiZtgT/ua06DbBrZgLImVyd0Zvh1
	 W1AkJNl9n5TaJpFlhsr0IhRreV6zbZpFu6IQXoa/ibvWFv7SDkmyh9+UxILL4gPqSv
	 7638mKCSLtQMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jackson Lee <jackson.lee@chipsnmedia.com>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: chips-media: wave5: Add timeout while stop_streaming
Date: Fri, 11 Sep 2026 10:11:22 -0400
Message-ID: <20260911141122.758706-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-underline-result-7e3d@gregkh>
References: <2026090953-underline-result-7e3d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jackson Lee <jackson.lee@chipsnmedia.com>

[ Upstream commit 2ae7faed2e60d6d07d9efdd962d20dcb15330ced ]

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
[ adapted timeout polling to the older decoder’s report_queue_count condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/chips-media/wave5/wave5-vpu-dec.c | 12 ++++++------
 .../platform/chips-media/wave5/wave5-vpuconfig.h     |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 13f09bb42cb2d..5aa052da53463 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/delay.h>
 #include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
@@ -1480,25 +1481,24 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 {
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
-	bool check_cmd = TRUE;
+	unsigned long timeout;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
 	pm_runtime_resume_and_get(inst->dev->dev);
 
-	while (check_cmd) {
+	timeout = jiffies + msecs_to_jiffies(VPU_DEC_STOP_TIMEOUT);
+	while (true) {
 		struct queue_status_info q_status;
-		struct dec_output_info dec_output_info;
 
 		wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
 
 		if (q_status.report_queue_count == 0)
 			break;
 
-		if (wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT) < 0)
+		if (time_after(jiffies, timeout))
 			break;
 
-		if (wave5_vpu_dec_get_output_info(inst, &dec_output_info))
-			dev_dbg(inst->dev->dev, "there is no output info\n");
+		usleep_range(1000, 2000);
 	}
 
 	v4l2_m2m_update_stop_streaming_state(m2m_ctx, q);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
index 1ea9f5f314995..e04f2dbf3b655 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
@@ -59,6 +59,7 @@
 //  application specific configuration
 #define VPU_ENC_TIMEOUT                 60000
 #define VPU_DEC_TIMEOUT                 60000
+#define VPU_DEC_STOP_TIMEOUT            300
 
 // for WAVE encoder
 #define USE_SRC_PRP_AXI         0
-- 
2.53.0

