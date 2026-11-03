Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722553;
	b=hMYXVNIIk85Z8mpBRKrYlS7/Gt6Z8wpbuPGVX/bnWu1CTJsYK9QWhMZQ9JW5p9Q4Fw0z
	 m8QzQjz63EmXQhZqP13x6s7EO8o8O+Imec2o46tGnKIfLwGFUC4RMsJfOn7K3l2tRzEHa
	 Hx18Ltu8nqpkce7luYmVxl5JhQSqwUtAICTnDZjS+JHwTW2dh3y4ZdxM/OIhP6iULYfWz
	 L4lB2wxS+afWvtAHVqPzFCQpuVj+/MFCTgXTLqH0WLY+0jnk9aVd0KcRcIoZ+AnTrLiFu
	 leyRyBIwN9irgFrPDGBoToJQ9/EDRIH4YmQdcVQ0tloVrf6Lu3XDqYVuCRu2Z0kl5/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722553;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=fBOjexThyqX9vtjFuxgIxqfaXQ1kHhMRsue68ZUwUxM=;
	b=2XGPso0cjJPkC3Bslm0Hm7r5THYwOUe6Kw5pMWRBbAsjGEwTJTBNKmd2VQrfkOEDeCDg
	 38pTY4X5yqv3sJdH6xrVHP1b6oq9ApzzgcGY2PUZFGLeH/CMWnWSfLGRBd/4ga/n3kDkb
	 SJXri3H90/6zTgG1aR0KqNk8v/wafbiLHsz85guMh+4xCef4zNlXu+gvCqbeJkS4HHzm3
	 9kPiHoZF0/3NNNkWhEXDKDKdaZ8IKU1UJ1nXSA6pg0BCWFe8f8F695FMucbW7TiTSqkkv
	 NVoweIijRd2IJQxfBu9WENJ5wzmdS7jRcByRV7k3PVtLeRV+MjqHgqZXeVPWaQJQFtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23C606A337;
	Tue,  3 Nov 2026 16:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C23C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=fBOjexThyq
	X9vtjFuxgIxqfaXQ1kHhMRsue68ZUwUxM=; b=Mk0X8iK7Q/bzmKdIlSyyDSaCww
	Fg6vO8MBm5MCKVjJD6la264JbwDjaYsrulWX+zLSWvQ/D0kLb/bMMZ5Riv+nreLM
	zJr7KvrdmHzzg79oGPd5sMbbzc3f5Eu2WgR/Zsaku/xsvluSYmDMrZFg3ESIKHEl
	9MDUTVd63SEoDZkmU=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.43])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkC2_gOtCOpqMa8fAQ--.34019S2;
	Wed, 04 Nov 2026 00:15:42 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v4] media: gspca: don't complete buffers before streaming has started
Date: Wed,  4 Nov 2026 00:15:40 +0800
Message-Id: <20261103161540.23947-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkC2_gOtCOpqMa8fAQ--.34019S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJrWxAF1xtryrAr18uFW3ZFb_yoWDAF4UpF
	Z3Kay5tayDJr1kCr4UXw1DGF1fua1kJ3y7CrWSkwn3Ar4UXF98ZFyFqry8Gr47ArZFvw4r
	Jw1UGrWUCws7XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUzT5dUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUGD2rp+0MMQQAAs4

gspca enables the data transfers before it knows whether start_streaming()
will succeed: gspca_init_transfer() sets gspca_dev->streaming before the
URBs are submitted, so an URB that has already been submitted can complete
and gspca_frame_add() can hand its buffer to videobuf2 while the remaining
URBs are still being submitted.

When one of those submissions fails, gspca_start_streaming() returns the
buffers that are still queued to vb2 in QUEUED state, but the buffer that
has already been completed is no longer on the driver's queue, and
vb2_buffer_done() cannot take it back (it only accepts active buffers).
vb2_start_streaming() then warns because the driver left a buffer on the
done list although it failed to start:

 ------------[ cut here ]------------
 WARNING: drivers/media/common/videobuf2/videobuf2-core.c:1821 at vb2_start_streaming+0x312/0x680
 ...
 Call Trace:
  <TASK>
  vb2_core_streamon+0x285/0x470
  __vb2_init_fileio+0xdc1/0x1120
  __vb2_perform_fileio+0xa7a/0x15e0
  vb2_fop_read+0x219/0x3e0
  v4l2_read+0x1fc/0x320
  vfs_read+0x1d9/0x980
  ksys_read+0x111/0x210
 ...
 gspca_main: set alt 0 err -19
 gspca_main: usb_submit_urb alt 1 err -2

This was observed on a camera whose USB configuration was changed from
userspace while a read() was starting the stream: the endpoint is removed,
so usb_submit_urb() fails with -ENOENT, and the driver is unbound.

Do not hand a buffer to videobuf2 before the transfers are set up.  A frame
that completes earlier is moved from the queue of free buffers to a pending
list, and is given to videobuf2 only once gspca_init_transfer() reports
success.  A failing start_streaming() therefore always leaves the done list
empty, while the frame is not lost either: the subdrivers that restart
their transfer from the frame completion callback (sq930x, se401) keep
working when the very first frame completes inside that window.  When the
start fails, the pending frames are put back on the driver's queue and
gspca_start_streaming() returns them in QUEUED state with the others.

The frame has to be taken out of the queue of free buffers: it is that
queue's first entry, so the next frame would take the same buffer and
overwrite the completed one, which would then never reach videobuf2.

The state of the frame being received is now also reset when a lower
alternate setting is retried, so that the packets of the retried transfer
cannot be appended to a frame left over from the previous one.

A driver side flag is needed because videobuf2 sets q->streaming before
calling start_streaming() when VIDIOC_STREAMON comes in with fewer buffers
queued than min_queued_buffers, and start_streaming() is then called later
from vb2_core_qbuf(), with the first URBs possibly already completed.  The
flag is cleared when gspca_init_transfer() starts rather than when the
stream is stopped: gspca_suspend() does not go through gspca_stream_off(),
and gspca_resume() calls gspca_init_transfer() directly.

Fixes: 1f5965c4dfd7 ("media: gspca: convert to vb2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v4:
- Move the frames that complete before the transfers are set up to a separate
  pending list.  Leaving them in the queue of free buffers, as v3 did, did
  not protect them: the completed frame was still that queue's first entry,
  so the next FIRST_PACKET took the same buffer and overwrote the frame,
  which was then never handed to videobuf2.  The subdrivers that send
  FIRST_PACKET right after LAST_PACKET (etoms, ov519, konica, nw80x) hit
  that on every start.
- Put the pending frames back on the queue in gspca_return_all_buffers(), so
  a failed start still returns every buffer to videobuf2.
 drivers/media/usb/gspca/gspca.c | 58 ++++++++++++++++++++++++++++++---
 drivers/media/usb/gspca/gspca.h |  2 ++
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 594d73e50b9f..1232f5d10bae 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -392,7 +392,7 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
 	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
 
 	if (packet_type == FIRST_PACKET) {
-		/* if there is no queued buffer, discard the whole frame */
+		/* If there is no queued buffer, discard the whole frame */
 		if (!buf) {
 			gspca_dev->last_packet_type = DISCARD_PACKET;
 			gspca_dev->sequence++;
@@ -439,11 +439,10 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
 	 * next first packet, wake up the application and advance
 	 * in the queue */
 	if (packet_type == LAST_PACKET) {
+		bool ready;
+
 		if (gspca_dev->image_len > gspca_dev->pixfmt.sizeimage)
 			gspca_dev->image_len = gspca_dev->pixfmt.sizeimage;
-		spin_lock_irqsave(&gspca_dev->qlock, flags);
-		list_del(&buf->list);
-		spin_unlock_irqrestore(&gspca_dev->qlock, flags);
 		buf->vb.vb2_buf.timestamp = ktime_get_ns();
 		vb2_set_plane_payload(&buf->vb.vb2_buf, 0,
 				      gspca_dev->image_len);
@@ -451,7 +450,25 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
 		buf->vb.field = V4L2_FIELD_NONE;
 		gspca_dbg(gspca_dev, D_FRAM, "frame complete len:%d\n",
 			  gspca_dev->image_len);
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+		/*
+		 * The frame can complete before gspca_init_transfer() has set
+		 * up all the transfers: the first URB can complete while the
+		 * others are still being submitted, and a submission can then
+		 * fail.  Videobuf2 requires that start_streaming() leaves its
+		 * done list empty in that case, and a completed buffer cannot
+		 * be taken back, so the frame is only released to videobuf2
+		 * once the transfers are known to be set up.  Until then it is
+		 * parked on the pending list, out of reach of the next frame.
+		 */
+		spin_lock_irqsave(&gspca_dev->qlock, flags);
+		ready = gspca_dev->streaming_ready;
+		if (ready)
+			list_del(&buf->list);
+		else
+			list_move_tail(&buf->list, &gspca_dev->pending);
+		spin_unlock_irqrestore(&gspca_dev->qlock, flags);
+		if (ready)
+			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 		gspca_dev->image = NULL;
 		gspca_dev->image_len = 0;
 	}
@@ -732,6 +749,7 @@ static int create_urbs(struct gspca_dev *gspca_dev,
 static void gspca_stream_off(struct gspca_dev *gspca_dev)
 {
 	gspca_dev->streaming = false;
+	gspca_dev->streaming_ready = false;
 	gspca_dev->usb_err = 0;
 	if (gspca_dev->sd_desc->stopN)
 		gspca_dev->sd_desc->stopN(gspca_dev);
@@ -745,6 +763,26 @@ static void gspca_stream_off(struct gspca_dev *gspca_dev)
 	gspca_dbg(gspca_dev, D_STREAM, "stream off OK\n");
 }
 
+/*
+ * The transfers are set up: from now on the frames are handed to videobuf2
+ * as soon as they are complete.  Release the ones that completed while the
+ * URBs were being submitted, they could not be completed earlier because
+ * start_streaming() could still have failed.
+ */
+static void gspca_flush_pending_frames(struct gspca_dev *gspca_dev)
+{
+	struct gspca_buffer *buf, *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gspca_dev->qlock, flags);
+	gspca_dev->streaming_ready = true;
+	list_for_each_entry_safe(buf, node, &gspca_dev->pending, list) {
+		list_del(&buf->list);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	}
+	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
+}
+
 /*
  * start the USB transfer
  */
@@ -760,6 +798,7 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 	gspca_dev->image = NULL;
 	gspca_dev->image_len = 0;
 	gspca_dev->last_packet_type = DISCARD_PACKET;
+	gspca_dev->streaming_ready = false;
 
 	gspca_dev->usb_err = 0;
 
@@ -870,6 +909,10 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 		/* the bandwidth is not wide enough
 		 * negotiate or try a lower alternate setting */
 retry:
+		/* the frame of the previous transfer is lost */
+		gspca_dev->image = NULL;
+		gspca_dev->image_len = 0;
+		gspca_dev->last_packet_type = DISCARD_PACKET;
 		gspca_err(gspca_dev, "alt %d - bandwidth not wide enough, trying again\n",
 			  alt);
 		msleep(20);	/* wait for kill complete */
@@ -887,6 +930,8 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 		}
 	}
 out:
+	if (ret >= 0)
+		gspca_flush_pending_frames(gspca_dev);
 	gspca_input_create_urb(gspca_dev);
 	return ret;
 }
@@ -1338,6 +1383,8 @@ static void gspca_return_all_buffers(struct gspca_dev *gspca_dev,
 	unsigned long flags;
 
 	spin_lock_irqsave(&gspca_dev->qlock, flags);
+	/* the frames that never reached videobuf2 are still queued */
+	list_splice_init(&gspca_dev->pending, &gspca_dev->buf_list);
 	list_for_each_entry_safe(buf, node, &gspca_dev->buf_list, list) {
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
 		list_del(&buf->list);
@@ -1518,6 +1565,7 @@ int gspca_dev_probe2(struct usb_interface *intf,
 	gspca_dev->vdev.queue = q;
 
 	INIT_LIST_HEAD(&gspca_dev->buf_list);
+	INIT_LIST_HEAD(&gspca_dev->pending);
 	spin_lock_init(&gspca_dev->qlock);
 
 	/* configure the subdriver and initialize the USB device */
diff --git a/drivers/media/usb/gspca/gspca.h b/drivers/media/usb/gspca/gspca.h
index a6554d5e9e1a..93f304787cd4 100644
--- a/drivers/media/usb/gspca/gspca.h
+++ b/drivers/media/usb/gspca/gspca.h
@@ -187,6 +187,7 @@ struct gspca_dev {
 	__u8 last_packet_type;
 	__s8 empty_packet;		/* if (-1) don't check empty packets */
 	bool streaming;
+	bool streaming_ready;		/* buffers can be completed */
 
 	__u8 curr_mode;			/* current camera mode */
 	struct v4l2_pix_format pixfmt;	/* current mode parameters */
@@ -196,6 +197,7 @@ struct gspca_dev {
 
 	spinlock_t qlock;
 	struct list_head buf_list;
+	struct list_head pending;	/* completed, not given to videobuf2 yet */
 
 	wait_queue_head_t wq;		/* wait queue */
 	struct mutex usb_lock;		/* usb exchange protection */
-- 
2.34.1

