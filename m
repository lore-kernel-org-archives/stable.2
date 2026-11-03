Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693440;
	b=hHGXLAGsy4TowHUtpdVlDaADggrngPej6Bc+JsmmIeDymkRRNO+zumUstNue+T9uk+nK
	 Joxj2JyXrmcu4INfOuGvL9ShJdFXtstAO1JueBSjR/C+WGaiZ/ZQBAp/qv6H1Ch7Jmf0q
	 TRTQaCqghlwUrS8o43yOwLCGSdeDbWy0BYLEgYdvf1ZST8uGheaCbKvwwUotqnfxmQLE3
	 Zs80jbdXF9ZFsoQtIlxsU/zBHhWZgwSm7ivjup4g8jdVtXOnpaCmrmtYkIB0thbcwVXb+
	 G6KlFmOeDKwx6W+sojderA7zfsQVjUXWwyJd0svc2ChAPUwnw8HG4juUm3ZpqV+ECYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693440;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=KhCQsbEtDHVWIosXzD12/AzO9JwD6rO3/xpeBtsKprU=;
	b=H9rpf2B44WUyjSUgNjfe44mD/NYCL/fHr/u0FtaP+7qhBkq9LN49ZRlm/ydGz//e5IIQ
	 eOaL7d461uOEXGl19s22RVmsh1v6FQmM236jZ7sN2GDoaCFf2b7U0w2jyHu5tzrEgxdqa
	 8qYbFAY3R+JejzRfsRKiPz9z4OYyiFS5B3KIJT9nPKC5RjwWAuLTu6wMnCfARoYLXtZpu
	 XZLWm8vcuruKP3Z4DzS/fnyUvk9K2WTwd9xz4m8djO80xS5HnYY5a6szO/WRiMf/mEzPL
	 ZeJUSIRFjskIf6H28htmMojHI9fMM6UKK52YEoOIA+4klOddlZE74TnqzaGXWf/XGFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF5606A324;
	Tue,  3 Nov 2026 08:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4FF5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=KhCQsbEtDH
	VWIosXzD12/AzO9JwD6rO3/xpeBtsKprU=; b=AoXN4BrFWrDvFXF5wQpB7ULUCF
	+E9dKXtLfx/kdMuTaUWOj24QMAxE9a6WRJFcLB60jAO04S6lRe770DkHIh6JPgqz
	Ujb+eSbb3jrQgOkBuOZdRfs4DS2y/tPmWfu8+oYsjlqEdxeG+bhrfLkX7ptHjBUq
	krtBTgIZqgGd02RNc=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkD2OP7vlulqoKgdAQ--.33754S2;
	Tue, 03 Nov 2026 16:10:24 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] media: gspca: don't complete buffers before streaming has started
Date: Tue,  3 Nov 2026 16:10:22 +0800
Message-Id: <20261103081022.27105-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkD2OP7vlulqoKgdAQ--.33754S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF17CF43XF47Gw4ktF47Jwb_yoW7CF1xpF
	Z3KayFy398Jr4kCrsrXwnxGa4fGayxJ3y7KrWSgwn5Ars8AF90vFyrtr48KFy7CrZFvFW0
	qFn8G3yDCw4IqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAac4AC6xC2jxv24VCSYI8q64vIFxWle2I262IY
	c4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI
	0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY
	0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14
	v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4GQgUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUGD2roqcKe4gAAsb

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

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

Do not complete buffers before the transfers are fully set up.  A new
streaming_ready flag is set at the end of gspca_init_transfer() only when
it succeeded, so a failing start_streaming() always leaves the done list
empty.  Frames that arrive before that are dropped, just like frames that
arrive when no buffer is queued; the window lasts only as long as the
remaining URBs are still being submitted.

vb2_is_streaming() cannot be used for this check: videobuf2 sets
q->streaming before calling start_streaming() when VIDIOC_STREAMON comes in
with fewer buffers queued than min_queued_buffers, and start_streaming() is
then called later from vb2_core_qbuf().

Fixes: 1f5965c4dfd7 ("media: gspca: convert to vb2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v2:
 - Do not gate the completion on vb2_is_streaming(): videobuf2 sets
   q->streaming before calling start_streaming() when VIDIOC_STREAMON is
   issued with fewer buffers queued than min_queued_buffers, so that call
   site was still reachable and the warning could still be triggered.
   Track in the driver whether gspca_init_transfer() has finished setting
   up the transfers instead.

 drivers/media/usb/gspca/gspca.c | 23 +++++++++++++++++++++--
 drivers/media/usb/gspca/gspca.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 594d73e50b9f..3f5ece57d66a 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -392,8 +392,23 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
 	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
 
 	if (packet_type == FIRST_PACKET) {
-		/* if there is no queued buffer, discard the whole frame */
-		if (!buf) {
+		/*
+		 * If there is no queued buffer, discard the whole frame.
+		 *
+		 * Frames are also discarded until gspca_init_transfer() has
+		 * set up the transfers: the first URB can complete while the
+		 * others are still being submitted, and if a submission then
+		 * fails, start_streaming() must leave vb2's done list empty.
+		 * A completed buffer cannot be taken back, so frames that
+		 * run into that window are dropped.
+		 *
+		 * vb2_is_streaming() cannot be used for this: videobuf2 sets
+		 * q->streaming before calling start_streaming() when
+		 * VIDIOC_STREAMON comes in with fewer buffers queued than
+		 * min_queued_buffers, and start_streaming() is only called
+		 * later from vb2_core_qbuf().
+		 */
+		if (!buf || !gspca_dev->streaming_ready) {
 			gspca_dev->last_packet_type = DISCARD_PACKET;
 			gspca_dev->sequence++;
 			return;
@@ -732,6 +747,7 @@ static int create_urbs(struct gspca_dev *gspca_dev,
 static void gspca_stream_off(struct gspca_dev *gspca_dev)
 {
 	gspca_dev->streaming = false;
+	gspca_dev->streaming_ready = false;
 	gspca_dev->usb_err = 0;
 	if (gspca_dev->sd_desc->stopN)
 		gspca_dev->sd_desc->stopN(gspca_dev);
@@ -887,6 +903,9 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 		}
 	}
 out:
+	/* the transfers are set up now, buffers may be completed */
+	if (!ret)
+		gspca_dev->streaming_ready = true;
 	gspca_input_create_urb(gspca_dev);
 	return ret;
 }
diff --git a/drivers/media/usb/gspca/gspca.h b/drivers/media/usb/gspca/gspca.h
index a6554d5e9e1a..3e0b9e27f4b1 100644
--- a/drivers/media/usb/gspca/gspca.h
+++ b/drivers/media/usb/gspca/gspca.h
@@ -187,6 +187,7 @@ struct gspca_dev {
 	__u8 last_packet_type;
 	__s8 empty_packet;		/* if (-1) don't check empty packets */
 	bool streaming;
+	bool streaming_ready;		/* buffers can be completed */
 
 	__u8 curr_mode;			/* current camera mode */
 	struct v4l2_pix_format pixfmt;	/* current mode parameters */
-- 
2.34.1

