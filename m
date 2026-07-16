Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29F3D5C0B;
	Thu, 16 Jul 2026 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201624; cv=none; b=B8JIcXVCNq0ZgFES5kFodOOBUxOzhmG0m95oV12Co6g8Jk0IoBLbBU3mhN+It8Sd7zZIeelxN6kJtEXLMKz8X5hG6uR+qsLso/Wol3U7gtZa4EMajsouQ09D03MPF6tqIAxCorzOorHXr9+3HD40IMHSMICjfCdnnU8cxva8uxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201624; c=relaxed/simple;
	bh=6fr47kLJuvDzx9THgVPea8JKczKVtXdRPptJqq93sIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrGTah/3CQ8HX4vQ99lg087HtpuegqnIDHVaIS7anquT7tJTqVRKXRfaNglbydFL+JkQ91oU4xoszU4GjdAOzsS5m3OY80jv5l+dWu/svD91gPzI2i26WD17zNkzZKphRvn0P/l1BwBNTCAmk4jv06KKxrKf0JVZp/nVqq3woyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDnYfyGwVhqvDJfAA--.24087S3;
	Thu, 16 Jul 2026 19:33:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgDXadCFwVhqsW3wAg--.63253S2;
	Thu, 16 Jul 2026 19:33:25 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: mchehab@kernel.org,
	hverkuil+cisco@kernel.org
Cc: y-abhilashchandra@ti.com,
	bparrot@ti.com,
	dale@farnsworth.org,
	dagriego@biglakesoftware.com,
	sbellary@baylibre.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] media: ti: vpe: quiesce overflow recovery before freeing streams
Date: Thu, 16 Jul 2026 11:32:30 +0000
Message-Id: <20260716113230.3131086-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <801025b7-a3b8-4655-af49-f9bb65254170@kernel.org>
References: <801025b7-a3b8-4655-af49-f9bb65254170@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDXadCFwVhqsW3wAg--.63253S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?vBJ5GAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0xPAQCwWO2pVhAwqD+sIzxQW78zoMDftY1wSw0eA+KHkhq
	coeV5GNxBiZVRkxxB8fN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW3Ary8Jw4kuF4kWF1DKFWxGrX_yoWxuFW5pF
	Z5t34FkrZ7XF40vF4UAw13tFy5CrWvv3yjyry8u343Aw45tryYvF1xKF10vF97Gryvva42
	yrs8J3y7ur45JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The VIP overflow recovery worker is armed from the hardirq handler when a
FIFO overflow is detected, and the list-complete path looks the stream up
through the VPDMA list private pointer. Both keep touching stream, port
and device state; the recovery worker also resets the parser and VPDMA,
repopulates the descriptor list, and re-enables the per-list IRQs.

vip_stop_streaming() masks and clears the per-list IRQs, but it neither
synchronizes the hardirq handler nor disables recovery_work. An overflow
IRQ that has already queued recovery_work, or a list-complete IRQ in
flight when the stream is torn down, can therefore still dereference the
stream after its resources are released: the descriptor list is freed by
vip_release_stream() on file release, and the stream itself by
free_stream() on unbind/remove.

Drain the recovery worker and the IRQ handler at both teardown points
through a shared vip_quiesce_stream() helper, before any stream-owned
resource is released. disable_work_sync() cancels pending recovery_work,
drains a running instance, and raises its disable depth, so a subsequent
schedule_work() issued by a racing IRQ handler is rejected at the
workqueue scheduler: recovery_work cannot be requeued after
disable_work_sync() takes effect. The worker may still re-enable the
per-list IRQs before disable_work_sync() returns; disable_irqs() then
masks those sources and synchronize_irq() waits for any in-flight handler
that still dereferences stream state. In vip_stop_streaming() the helper
runs before the parser is stopped, since a worker drained by
disable_work_sync() may re-enable the parser before exiting and would
otherwise undo the stop. recovery_work is created disabled and enabled in
vip_start_streaming() before IRQs, pairing the enable with the teardown
disable across the streaming lifecycle.

This issue was found by an in-house static analysis tool and confirmed
by manual code review.

Fixes: fc2873aa4a21 ("media: ti: vpe: Add the VIP driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes in v4:
- Drop the unrelated vpdma_hwlist_release() cleanup from this fix (Hans
  Verkuil).
- In free_stream(), call vip_quiesce_stream() before clearing
  cap_streams[], so the stream remains published while in-flight IRQ
  handling is drained (Hans Verkuil).

Changes in v3:
- Replace the per-stream irq_rearm_allowed flag and the repeated IRQ
  disable/synchronize_irq() in vip_quiesce_stream() with the workqueue
  disable-depth API (disable_work_sync/enable_work/disable_work), as
  suggested by Yemike Abhilash Chandra. This also closes a window the v2
  double-drain left open, where its second synchronize_irq() waited for
  the in-flight handler but did not cancel the recovery_work it had
  requeued, so that work could run after free.
- Create recovery_work disabled and enable it in vip_start_streaming()
  before IRQs.
- In vip_stop_streaming(), quiesce before stopping the parser: a worker
  drained by disable_work_sync() may re-enable the parser before exiting,
  so stopping the parser first would be undone.

Changes in v2:
- Drain the overflow recovery worker at both teardown points through a
  shared vip_quiesce_stream() helper: vip_stop_streaming() (file release
  path) and free_stream() (unbind/remove). v1 drained only in
  free_stream().
- Document how the issue was found and that the patch was prepared with
  LLM assistance (Assisted-by trailer and body note).

Link: https://lore.kernel.org/r/20260708013738.110752-1-fanwu01@zju.edu.cn/
---
 drivers/media/platform/ti/vpe/vip.c | 37 +++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/ti/vpe/vip.c b/drivers/media/platform/ti/vpe/vip.c
index cb0a5a07a3d4..673f9addfade 100644
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
+	 * Quiesce the IRQ handler and recovery worker, then drop the stream
+	 * from cap_streams[], before releasing stream-owned resources.
+	 */
+	vip_quiesce_stream(stream);
+	stream->port->cap_streams[stream->stream_id] = NULL;
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
 
-- 
2.34.1

