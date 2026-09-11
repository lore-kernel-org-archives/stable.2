Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309C32B13F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140518; cv=none; b=O3VU8CuM4qMx77ppXSnzHFcih44Drd29sPnaeUkQw5uaAzrEiZR6J24lFrP+/jm59CIZ0BOtBlo/0lR6xjGwQLXtnLVcqoAkbkCR0Fz5uhvK2W5fzfiU7YyKTcNk+tV16GHZRFurKBBNaTgFt07FT41rC/H6PJUEDScnpMAmDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140518; c=relaxed/simple;
	bh=yQe4BrVDXJmQratnpuUOlJzyVSmF1SQQd63x86DcjQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QT9ZWiTM+ZL3IG+fGlOppGhtgVtI1rY2HfvkH/eauS4bpO/5n0cQFizKrV89cPeCsYmJzFlMV7hC6uJ6t1FMlOYgYzS/AawUt0ihDpG5UEnt59dj4ktWXti4vrUSW2thQXqfOSFb8tyGNPzWKhZESmQcVsiNE9vrX4QV/Fh5uaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGTV1L0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGTV1L0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E041F000FF;
	Fri, 11 Sep 2026 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140516;
	bh=pio93g+XAdjM2c6wPTNK8TpenLk/lpPKj4TXS9pJyJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oGTV1L0xPZYtbJ1HY7l3EiZsqrHcEBAY+dTl675nFKtIdUajovlzmQVu6VpWpkPAX
	 8/Mh4mhaif+sIOvDN7940WxHI+1FypQxkFMjumiomKuDyS3B93AzSmHGXvDBW18n7Y
	 AW0tDRefCAVkFqjAvfc3T0WkXnh05NkBiei3+6Oj6Esqb7kCxshT/rGBhP2euIifIa
	 yAuHQPhqBFfL+CCFjraWQrfUhhHCxVPQaQQaedb7qn14uJA2eA2PHDLWM06HLKJns5
	 k++AxppzsUidH4urto631u2FCZdy5uWbyUmkaAdRLqN7wkgut6eZtje8ZY1Tf6PSOc
	 4uIrcBPc9Wcug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jackson Lee <jackson.lee@chipsnmedia.com>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: chips-media: wave5: Add timeout while stop_streaming
Date: Fri, 11 Sep 2026 11:28:34 -0400
Message-ID: <20260911152834.1078203-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-salvaging-dowry-0b1d@gregkh>
References: <2026090953-salvaging-dowry-0b1d@gregkh>
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
[ adapted the stop loop to use 6.12’s existing report_queue_count condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/chips-media/wave5/wave5-vpu-dec.c | 12 ++++++------
 .../platform/chips-media/wave5/wave5-vpuconfig.h     |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 2685ef393eaa2..1db555bc7b7db 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/delay.h>
 #include "wave5-helper.h"
 
 #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
@@ -1556,24 +1557,23 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 {
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
-	bool check_cmd = TRUE;
+	unsigned long timeout;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
 
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
index e4bc2e467cb52..b63cc6bdcd88a 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
@@ -40,6 +40,7 @@
 //  application specific configuration
 #define VPU_ENC_TIMEOUT                 60000
 #define VPU_DEC_TIMEOUT                 60000
+#define VPU_DEC_STOP_TIMEOUT            300
 
 // for WAVE encoder
 #define USE_SRC_PRP_AXI         0
-- 
2.53.0

