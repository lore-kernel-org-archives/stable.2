Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697001;
	b=PMmkPfTxU7Ei5GW59aRoDfbzuhx5uWlUDi3AwdkBIB+x05Z7ly4H8Afe5amq2qH7IiIw
	 7gL42OG77LLUTw1cF89igdZE+HOUcTBN4WJmzTXP1tYMFhOQ6yGMrdlCFUhcecB3PwYwv
	 QFsySZxK4dWgwK3qve455bzwVkCVLlNGVR0reCvexO9F1zTg2EIOmucO/BfTteGONEmJF
	 IMN3e3NMZNJc3p2G802v1Jnh2pe+cE2e4JKpELJsmOk4cobCpCX71uk3E3BtKO5Fz6luN
	 sUchoigCyF4jhYaQoqjzRujorf4G5SxbVFlB5UmxWfJKfI+bJ8eOju4Q9aYE5CASo0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697001;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=lcdSq6LeLo/FqotJnfp1rxr60x8LqCt3EpIwwOz6Ni4=;
	b=tDOMzS+NMgcWPigdB1plyQrZz/3KwmcLLyRPN0ooxz1+DDZtDW1NuIm9yu6nC6jBJC1g
	 O+HgVpoM6UAEuD3Gy2mI9aUmjyWIIMfV3itHbJTTgxo8R8vhPJtBEG13KLuMP9b2CjIzu
	 7/gpW+Ju/NGxOA4/O0gmkEfCZEv7F0CUUPSeFFE0gmsa48xrSvfjxVSzg0zrDzfMW41bV
	 xOwG+wP1tduJ09ZOaErYvND2da+YnJ3U4I4BFU9xkXm55FSX7Ho+Wqntn+C4siO6IHWcz
	 7SP/2ylbiyOqCgCcnzliAbMlGjWkQPs/au1uNyyzjl4ZHWWH9639J9EORS72u65chcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32230606A324;
	Tue,  3 Nov 2026 09:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32230606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=lcdSq6LeLo
	/FqotJnfp1rxr60x8LqCt3EpIwwOz6Ni4=; b=xwBVNDUOYQO+80JKVBaPwgIISi
	EnpDjG2emrflO44h3ybc/kXOMjKnrIx4JtM4eN3E1JciNQgnAPCTrPe+TAJ+Nmxl
	FyLrxWCM3YIfFohLHcgnM+yueoJDVH9vnNTI53wn9vkwjVIALZx3OdC2W4GepzX2
	huEdiYGN4oHzINaXY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDW2_7SpOlqD4odAQ--.50070S2;
	Tue, 03 Nov 2026 17:09:40 +0800 (CST)
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
Subject: [PATCH v3] media: gspca: don't complete buffers before streaming has started
Date: Tue,  3 Nov 2026 17:09:38 +0800
Message-Id: <20261103090938.22464-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkDW2_7SpOlqD4odAQ--.50070S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF17CF43XF4kur15Kr45Jrb_yoWDGryrpF
	Z3Gay5tayDJr1kCr4UXwn8GF13CaykJ3y7GrWSkwn3Ar4DXF90vFyFqry8Gr47GrZFvF4r
	Jr1UJrWUuwsFqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JU6c_3UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUGD2rop1WnCgADsT

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
that completes earlier stays in the driver's queue, marked as complete, and
is given to videobuf2 only once gspca_init_transfer() reports success.  A
failing start_streaming() therefore always leaves the done list empty,
while the frame is not lost either: the subdrivers that restart their
transfer from the frame completion callback (sq930x, se401) keep working
when the very first frame completes inside that window.  When the start
fails, the marked buffers are still on the driver's queue and
gspca_start_streaming() returns them in QUEUED state with the others.

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
Changes in v3:
- Do not drop the frames that complete before the transfers are set up:
  keep them on the driver's queue and hand them to videobuf2 once
  gspca_init_transfer() succeeds.  Dropping them would stall the subdrivers
  that restart their transfer from the frame completion callback (sq930x,
  se401) when the first frame completes inside that window.
- Clear the streaming_ready flag when gspca_init_transfer() starts instead
  of when the stream is stopped: gspca_suspend() does not call
  gspca_stream_off(), and gspca_resume() re-enters gspca_init_transfer()
  with the flag still set.
- Reset the state of the frame being received when a lower alternate
  setting is retried.
 drivers/media/usb/gspca/gspca.c | 59 ++++++++++++++++++++++++++++++---
 drivers/media/usb/gspca/gspca.h |  2 ++
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 594d73e50b9f..ad8a0d686da8 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -389,10 +389,12 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
 	spin_lock_irqsave(&gspca_dev->qlock, flags);
 	buf = list_first_entry_or_null(&gspca_dev->buf_list,
 				       typeof(*buf), list);
+	if (buf && packet_type == FIRST_PACKET)
+		buf->frame_complete = false;
 	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
 
 	if (packet_type == FIRST_PACKET) {
-		/* if there is no queued buffer, discard the whole frame */
+		/* If there is no queued buffer, discard the whole frame */
 		if (!buf) {
 			gspca_dev->last_packet_type = DISCARD_PACKET;
 			gspca_dev->sequence++;
@@ -439,11 +441,10 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
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
@@ -451,7 +452,24 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
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
+		 * once the transfers are known to be set up.
+		 */
+		spin_lock_irqsave(&gspca_dev->qlock, flags);
+		ready = gspca_dev->streaming_ready;
+		if (ready)
+			list_del(&buf->list);
+		else
+			buf->frame_complete = true;
+		spin_unlock_irqrestore(&gspca_dev->qlock, flags);
+		if (ready)
+			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 		gspca_dev->image = NULL;
 		gspca_dev->image_len = 0;
 	}
@@ -732,6 +750,7 @@ static int create_urbs(struct gspca_dev *gspca_dev,
 static void gspca_stream_off(struct gspca_dev *gspca_dev)
 {
 	gspca_dev->streaming = false;
+	gspca_dev->streaming_ready = false;
 	gspca_dev->usb_err = 0;
 	if (gspca_dev->sd_desc->stopN)
 		gspca_dev->sd_desc->stopN(gspca_dev);
@@ -745,6 +764,28 @@ static void gspca_stream_off(struct gspca_dev *gspca_dev)
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
+	list_for_each_entry_safe(buf, node, &gspca_dev->buf_list, list) {
+		if (!buf->frame_complete)
+			continue;
+		list_del(&buf->list);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	}
+	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
+}
+
 /*
  * start the USB transfer
  */
@@ -760,6 +801,7 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 	gspca_dev->image = NULL;
 	gspca_dev->image_len = 0;
 	gspca_dev->last_packet_type = DISCARD_PACKET;
+	gspca_dev->streaming_ready = false;
 
 	gspca_dev->usb_err = 0;
 
@@ -870,6 +912,10 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
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
@@ -887,6 +933,8 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 		}
 	}
 out:
+	if (ret >= 0)
+		gspca_flush_pending_frames(gspca_dev);
 	gspca_input_create_urb(gspca_dev);
 	return ret;
 }
@@ -1327,6 +1375,7 @@ static void gspca_buffer_queue(struct vb2_buffer *vb)
 	unsigned long flags;
 
 	spin_lock_irqsave(&gspca_dev->qlock, flags);
+	buf->frame_complete = false;
 	list_add_tail(&buf->list, &gspca_dev->buf_list);
 	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
 }
diff --git a/drivers/media/usb/gspca/gspca.h b/drivers/media/usb/gspca/gspca.h
index a6554d5e9e1a..d0475db62da5 100644
--- a/drivers/media/usb/gspca/gspca.h
+++ b/drivers/media/usb/gspca/gspca.h
@@ -144,6 +144,7 @@ enum gspca_packet_type {
 struct gspca_buffer {
 	struct vb2_v4l2_buffer vb;
 	struct list_head list;
+	bool frame_complete;	/* frame filled in, not given to videobuf2 yet */
 };
 
 static inline struct gspca_buffer *to_gspca_buffer(struct vb2_buffer *vb2)
@@ -187,6 +188,7 @@ struct gspca_dev {
 	__u8 last_packet_type;
 	__s8 empty_packet;		/* if (-1) don't check empty packets */
 	bool streaming;
+	bool streaming_ready;		/* buffers can be completed */
 
 	__u8 curr_mode;			/* current camera mode */
 	struct v4l2_pix_format pixfmt;	/* current mode parameters */
-- 
2.34.1

