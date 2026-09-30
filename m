Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620231E5B9A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736558; cv=none; b=eBlbkhxKO9eUFDAdIqBqh8ADyl4Kx5xZiAhEUnMelySCHWgdU0XG9kcdh/N/bpKBs3QLvo9r1YAuebl1SQo7vYIDHBsVyiE8PCTngU8M3PrInUraAhlXAzy7nGFyANJG6wIlH53n7jEOWjzQL/O7tP5db4TdIO5iV5HX8RF8mDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736558; c=relaxed/simple;
	bh=KR0/nM7LaLz/NqsHot+0o4kSpKKt0bQVhOnDcP6AcIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMzCU4SRnAx+Du8LcUCRTN3XW6pJhfK+2yHZyxER5sg+F9bXG21DSoxATYdw1bkMc+UhPg8z8Q25SuvOc+SqhqcQR2DmOA4BaJL381ytZNglgy2/vQkRLQtbbne6Uxqj96ys4lpJyRqTivrkAOxfQh77ueReQbNDoGifLF50ckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 81ab3a06bc7911f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b864b9b7-a386-4237-919c-7e95585a0aea,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:0809f01a5624e200255e4baed2ae2412,BulkI
	D:nil,BulkQuantity:0,SF:102|123|136|850|865|898,TC:nil,Content:0|15|50|99,
	EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81ab3a06bc7911f19a56ed5b684f684d-20260930
X-User: fengchenguang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fengchenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1113844359; Wed, 30 Sep 2026 10:49:07 +0800
From: fengchenguang@kylinos.cn
To: oushixiong@kylinos.cn
Cc: Chenguang Feng <fengchenguang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: venus: vdec: Clear streamon flags on streaming errors
Date: Wed, 30 Sep 2026 10:49:00 +0800
Message-Id: <20260930024900.170970-1-fengchenguang@kylinos.cn>
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

