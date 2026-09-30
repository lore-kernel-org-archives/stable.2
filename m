Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E43655CE;
	Wed, 30 Sep 2026 04:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742274; cv=none; b=EUHVUt6IXsFA3WCG8DLGQvVe25Itrw0SPer1RjMVrXVAIsOJRdsNeMIYjK6+JtmyAbpEychrqo0ZnFp8dfRrAzjwAomBuXKi90tlAPGUv6AsTMsiRVRtvTiFGXzLaE9F9LK1wYe5ETCgpWMzt0pC77sc7UZrRBgNW8TEZB+Nswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742274; c=relaxed/simple;
	bh=KR0/nM7LaLz/NqsHot+0o4kSpKKt0bQVhOnDcP6AcIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H4VNa7FI+Ghr+Q2frLiHjTyseQKDldAqudTmWeQ5/JiVBXjdkLlRQ5pL57OntGQwQZtlOdnzydEaEPP/01UNtjUQptZdlCuQsWLrRkFfMGsmGgQ2R//DjdmJPf4QEmRZG23Jm37H82LnzbiOHqLvQ9DdKdVBmer3c2esFbH0iYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d06aa3eabc8611f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:68fac968-8661-42c1-bda2-4a029c0e5f17,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:ec27ba03910cf2d188a2a8dced6161bb,BulkI
	D:nil,BulkQuantity:0,SF:102|123|136|850|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d06aa3eabc8611f19a56ed5b684f684d-20260930
X-User: fengchenguang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fengchenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 387389142; Wed, 30 Sep 2026 12:24:23 +0800
From: fengchenguang@kylinos.cn
To: vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com,
	bod@kernel.org,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenguang Feng <fengchenguang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: venus: vdec: Clear streamon flags on streaming errors
Date: Wed, 30 Sep 2026 12:24:17 +0800
Message-Id: <20260930042417.191675-1-fengchenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Feng <fengchenguang@kylinos.cn>

The decoder only clears inst->streamon_out and inst->streamon_cap on
the success path.  When vdec_start_output() runs with the decoder in
the INIT or CAPTURE_SETUP state, it still sets streamon_out at its
done: label even if venus_helper_process_initial_out_bufs() failed,
and the error path of vdec_start_streaming() does not reset the
flags.  vdec_stop_streaming() skips the clearing as well whenever
the hfi flush fails.

In both cases the driver and vb2 disagree about the streaming state:
vdec_decoder_cmd() and delayed_process_buf_func() keep going as if
the queue were still streaming, and a later capture streamon assumes
the output queue is streaming too.

The encoder clears both flags unconditionally in the same
situations, so make the decoder do the same and print an error when
the flush fails.

Fixes: beac82904a87 ("media: venus: make decoder compliant with stateful codec API")
Cc: stable@vger.kernel.org
Signed-off-by: Chenguang Feng <fengchenguang@kylinos.cn>
---
 drivers/media/platform/qcom/venus/vdec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 6a43ea191da1..b25d9299f4d2 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1217,6 +1217,10 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	vdec_pm_put(inst, false);
 error:
 	venus_helper_buffers_done(inst, q->type, VB2_BUF_STATE_QUEUED);
+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		inst->streamon_out = 0;
+	else
+		inst->streamon_cap = 0;
 	mutex_unlock(&inst->lock);
 	return ret;
 }
@@ -1297,15 +1301,14 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 
 	inst->session_error = 0;
 
-	if (ret)
-		goto unlock;
-
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		inst->streamon_out = 0;
 	else
 		inst->streamon_cap = 0;
 
-unlock:
+	if (ret)
+		dev_err(inst->core->dev_dec, "dec: failed to stop streaming: %d\n", ret);
+
 	mutex_unlock(&inst->lock);
 }
 
-- 
2.25.1

