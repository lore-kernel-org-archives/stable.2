Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEF2DC79B;
	Thu, 16 Jul 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209804; cv=none; b=CHM9RR+cVwWFMAtCoUMvR771PVRxFh3pZ8u31X3JIA6jGfq4WEPEhdUCkFfzIPZZ01OezTAicBnfwH+EXpW8bfeb/TLZBY3UgSaplnwydkbTMIeGzOKT/5rm+yT7v3T3vX1XSQ1MlDBxQ2BcfRPGoAI50noFKHA47es8osG3lJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209804; c=relaxed/simple;
	bh=edHyrD6g3YKFiajOhYcLs5D0M0Wq54QPpEaPDMPgvbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnUWy9lnrFnuXuoAymQPa+Cq7lFJRNb4nIsQnLrOJmcVyYHOA+KTo4lNhsUdV/cE2aX+Ef/qLL/pZC0xesGnrncBoZItQPvRtOFyWbkmm/BkJrXPMawCzvoLlAGUwpcfdlqxPnkOYRpS7TLxKVck3EeNWg172SXOLfe159aSo9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3IV934VhqkgZgAA--.10752S3;
	Thu, 16 Jul 2026 21:49:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgB358x14VhqjDbxAg--.35535S2;
	Thu, 16 Jul 2026 21:49:41 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: mchehab@kernel.org
Cc: hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] media: cx231xx-audio: drain wq_trigger before audio fini
Date: Thu, 16 Jul 2026 13:48:46 +0000
Message-Id: <20260716134846.3132097-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708141622.3936490-1-fanwu01@zju.edu.cn>
References: <20260708141622.3936490-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgB358x14VhqjDbxAg--.35535S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?pJe2awXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI3IWMtfu/GU2xOferQPnfgLLxCi5s1C7HjcijontArQBLD5
	D7askrhb8LEjBgo6zO7N5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW3GrW7CrWrur1UWFW5Gr17urX_yoW7Wr1rpF
	Z5t34FyrZ7JF40qF47Jw1akFyYkr4vyayjk347uw1Ykr43Gr1YvF1xJa48ZF93AFyxZay2
	yr45t3y8ur45XFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==

audio_trigger() is deferred work (dev->wq_trigger) armed from
snd_cx231xx_capture_trigger() on every PCM START/STOP; it dereferences
dev->adev state and may free the URBs via cx231xx_isoc_audio_deinit().
cx231xx_audio_fini() tore down that state without draining wq_trigger,
so work armed before or racing fini ran against freed state.

Use disable_work_sync() in fini to drain the work and prevent further
queueing.  Initialize the work, lock and stream_started counter at the
top of cx231xx_audio_init(), before any fallible allocation, and clear
the partially-built audio state on its error path, so fini is safe even
if a later step fails.

This issue was found by an in-house static analysis tool.

Fixes: 61b04cb24a12 ("[media] cx231xx-audio: fix some locking issues")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.6: use cancel_work_sync()
Link: https://lore.kernel.org/r/8c7e1294-b906-4636-890c-b64d03b0e1d0@kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes in v2: use disable_work_sync() instead of a teardown flag +
cancel_work_sync(), as suggested by Hans Verkuil.  The init-ordering
fix and error-path cleanup from v1 are retained.
---
 drivers/media/platform/ti/vpe/vip.c   | 37 ++++++++++++++++++++++++---
 drivers/media/platform/ti/vpe/vpdma.c |  3 ++-
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/ti/vpe/vip.c b/drivers/media/platform/ti/vpe/vip.c
index cb0a5a07a3d4..30e9a85d4cf5 100644
--- a/drivers/media/platform/ti/vpe/vip.c
+++ b/drivers/media/platform/ti/vpe/vip.c
@@ -814,6 +814,22 @@ static void clear_irqs(struct vip_dev *dev, int irq_num, int list_num)
 	vpdma_clear_list_stat(dev->shared->vpdma, irq_num, dev->slice_id);
 }
 
+/*
+ * Quiesce recovery work and per-list IRQs before releasing stream resources.
+ * disable_work_sync() prevents the overflow handler from requeueing recovery
+ * work. Mask and synchronize IRQs afterwards because a running worker may
+ * have re-enabled them before exiting.
+ */
+static void vip_quiesce_stream(struct vip_stream *stream)
+{
+	struct vip_dev *dev = stream->port->dev;
+
+	disable_work_sync(&stream->recovery_work);
+	disable_irqs(dev, dev->slice_id, stream->list_num);
+	clear_irqs(dev, dev->slice_id, stream->list_num);
+	synchronize_irq(dev->irq);
+}
+
 static void populate_desc_list(struct vip_stream *stream)
 {
 	struct vip_port *port = stream->port;
@@ -2428,6 +2444,7 @@ static int vip_start_streaming(struct vb2_queue *vq, unsigned int count)
 		goto err;
 
 	stream->num_recovery = 0;
+	enable_work(&stream->recovery_work);
 
 	clear_irqs(dev, dev->slice_id, stream->list_num);
 	enable_irqs(dev, dev->slice_id, stream->list_num);
@@ -2452,13 +2469,17 @@ static void vip_stop_streaming(struct vb2_queue *vq)
 	struct vip_dev *dev = port->dev;
 	int ret;
 
+	/*
+	 * A running recovery worker may re-enable the parser, so quiesce it
+	 * and its IRQ handler before stopping the parser or releasing the
+	 * descriptor list.
+	 */
+	vip_quiesce_stream(stream);
+
 	vip_parser_stop_imm(port, true);
 	vip_enable_parser(port, false);
 	unset_fmt_params(stream);
 
-	disable_irqs(dev, dev->slice_id, stream->list_num);
-	clear_irqs(dev, dev->slice_id, stream->list_num);
-
 	if (port->subdev) {
 		ret = v4l2_subdev_call(port->subdev, video, s_stream, 0);
 		if (ret)
@@ -3074,6 +3095,8 @@ static int alloc_stream(struct vip_port *port, int stream_id, int vfl_type)
 		goto do_free_hwlist;
 
 	INIT_WORK(&stream->recovery_work, vip_overflow_recovery_work);
+	/* Start disabled; vip_start_streaming() enables it before IRQs. */
+	disable_work(&stream->recovery_work);
 
 	INIT_LIST_HEAD(&stream->vidq);
 
@@ -3139,6 +3162,13 @@ static void free_stream(struct vip_stream *stream)
 		return;
 
 	dev = stream->port->dev;
+	/*
+	 * Unpublish the stream and quiesce its IRQ handler and recovery worker
+	 * before releasing stream-owned resources.
+	 */
+	stream->port->cap_streams[stream->stream_id] = NULL;
+	vip_quiesce_stream(stream);
+
 	/* Free up the Drop queue */
 	list_for_each_safe(pos, q, &stream->dropq) {
 		buf = list_entry(pos,
@@ -3150,7 +3180,6 @@ static void free_stream(struct vip_stream *stream)
 
 	video_unregister_device(stream->vfd);
 	vpdma_hwlist_release(dev->shared->vpdma, stream->list_num);
-	stream->port->cap_streams[stream->stream_id] = NULL;
 	kfree(stream);
 }
 
diff --git a/drivers/media/platform/ti/vpe/vpdma.c b/drivers/media/platform/ti/vpe/vpdma.c
index 573aa83f62eb..f9f5b2f1ee1a 100644
--- a/drivers/media/platform/ti/vpe/vpdma.c
+++ b/drivers/media/platform/ti/vpe/vpdma.c
@@ -988,7 +988,8 @@ void *vpdma_hwlist_release(struct vpdma_data *vpdma, int list_num)
 
 	spin_lock_irqsave(&vpdma->lock, flags);
 	vpdma->hwlist_used[list_num] = false;
-	priv = vpdma->hwlist_priv;
+	priv = vpdma->hwlist_priv[list_num];
+	vpdma->hwlist_priv[list_num] = NULL;
 	spin_unlock_irqrestore(&vpdma->lock, flags);
 
 	return priv;
-- 
2.34.1

