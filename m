Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190874;
	b=FvYuGcTWaumiik/GLGrEeGVrvsuSHV0QiLRN/l3GWxEW7Mh7e4Gnbxl7zxTFcz9rv9Vj
	 rukHMMu3ksfV3vebLF2oP3pwUBwUl/KSrxXae7db/JsFflukJqFvvstK/6haCc7gGbUpM
	 PrXKMIQXPIb0c7IXO0R30VTUmJU0UC2J9ZrK2pPKXt/GzzCNP7st+/0kQ6omrQcptK3d7
	 KT4mHqYpXDKdxNgFaRtSxa7pefyoV7/0H+7QxzbT0+vyhlrYqSUl6XJRISf2uHW64FB3E
	 Cs9KX+k4BUWuzQvtmLJ3VEZ14hX0XxRYPhPBOamokds+OjsGjf5/3Vg21DhU2bZBvFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190874;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rC7FaYKY7pZ1J3YcEW6zYnBk/lwp6Pg28YLAJDL8+F0=;
	b=Sk9Xl+YxiVgaPWFA9zzz96OOJvaA+aQzmrpN7y49YAlIV6vNS58yxyNhvWJolVEEP8uM
	 GwqtpFxKf8MrnG1BaI4fjKXfCyrxC6Vs98CBOAqkh9p6Pa5Hk4tHfnovjs/wGNS1AyyW+
	 m4XaU7YSnfO9oWLNO2nc7ksOjf4umFx5e+kZ7SFNmwhs11g0tFOTvTsPCYaaC956Zxs+D
	 wx6XyUX7RIWnyBDv5RbyF32sN7Z9NCAyas30+H7+4JYnJPjIDLW8dxWWxzyHi9/KIL0LW
	 gFmUDx3JSozsvz0PaBeHnbAo0fZY6GeKEGjqmkDQWhVvSHQgUqpmH1E8ZaRdCdUvs7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59080606A334;
	Fri, 20 Nov 2026 16:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59080606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=rC7FaYKY7p
	Z1J3YcEW6zYnBk/lwp6Pg28YLAJDL8+F0=; b=PB4Wmv5beIa1kxrqhEbYQa3cgD
	BJC7KpE1TBSL2rCkIkFgjaw46rKxuJNHRVfEk8yeQAFBlqUjtPgt6Z+Cfnt2zh0B
	9V0pWna9emTZ2PTSTJEjhg9g3/xgoKV3yUlL9fWYp2+nc8kTpjlQAEd6FvpgW6vq
	K3x3smMO2gRh/nJuY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCGjP9JcABrpL7zAQ--.62584S2;
	Sat, 21 Nov 2026 00:07:39 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] media: hdpvr: fix out-of-bounds read in hdpvr_read()
Date: Sat, 21 Nov 2026 00:07:36 +0800
Message-Id: <20261120160736.8512-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkCGjP9JcABrpL7zAQ--.62584S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF18KFy3Gry5uFWfXFykuFg_yoW7tFy8pF
	WfKayayr4DXr97CrsrJF4xXa1rC3WkuF47GrWfGasakr45Gr1SgryrtryjvrWrGr92vr4U
	tFWa9ryfua1UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Jr0_Gr1lnxkEFVAIw20F6cxK64vIFxWlnxkEFVCFx7IYxxCEVcI2
	5VAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgZXoDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2sAYlgQcAAAs5

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

hdpvr_read() computes the number of bytes left in the current buffer as
urb->actual_length - buf->pos and uses that as the length for
copy_to_user(). buf->pos is a plain unsigned int that is not reset when
hdpvr_cancel_queue() recycles a buffer, and it is not protected against
concurrent readers of the same device.

After hdpvr_stop_streaming() has killed the URBs, the buffers are put
back on the free list with their old position, and the worker resubmits
them with urb->actual_length reset to 0. If the next transfer completes
with less data than the position a reader has already consumed, the
subtraction yields a negative value. As rem is an int and count is a
size_t, the comparison "rem > count" is then true, so cnt becomes count
and copy_to_user() copies count bytes starting at
transfer_buffer + buf->pos, which can be past the end of the 8192 byte
transfer buffer. Two readers of the same video device can corrupt each
other's position in the same way, and buf->pos is read twice, once for
rem and once for the source address.

A KASAN slab-use-after-free read of 4096 bytes was observed in
hdpvr_read() with the source address 1281 bytes past the end of the
transfer buffer; the pages following the buffer had been recycled as
slab pages. A second report with a 42 byte copy was 25 bytes past the
end of the buffer.

Fix this by reading the position once, by handing a buffer whose
position reached actual_length back to the worker, and by using min_t()
so that a negative remainder can no longer be turned into a full-size
copy.

Reset buf->pos when hdpvr_cancel_queue() recycles the buffers as well,
otherwise a restarted stream either skips the first bytes of the new
transfer or drops it entirely.

Only put a buffer back on the free list while it is still waiting to be
read: the worker can resubmit it between the status check and the lock,
and the position and the lists of a buffer with an URB in flight must
not be touched.

Fixes: 9aba42efe85b ("V4L/DVB (11096): V4L2 Driver for the Hauppauge HD PVR usb capture device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2:
 - Reset buf->pos when hdpvr_cancel_queue() recycles the buffers, so that a
   restarted stream no longer skips or drops the beginning of the new
   transfer.
 - Only put a buffer back on the free list while it is still waiting to be
   read: the worker can resubmit it between the status check and the lock,
   and a buffer whose URB is in flight must stay on the receive list.
 drivers/media/usb/hdpvr/hdpvr-video.c | 50 ++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 4290b2367fa3..32a54a5ebf0f 100644
--- a/drivers/media/usb/hdpvr/hdpvr-video.c
+++ b/drivers/media/usb/hdpvr/hdpvr-video.c
@@ -92,6 +92,8 @@ int hdpvr_cancel_queue(struct hdpvr_device *dev)
 	list_for_each_entry(buf, &dev->rec_buff_list, buff_list) {
 		usb_kill_urb(buf->urb);
 		buf->status = BUFSTAT_AVAILABLE;
+		/* the data is discarded, the next transfer starts at 0 */
+		buf->pos = 0;
 	}
 
 	list_splice_init(&dev->rec_buff_list, dev->free_buff_list.prev);
@@ -246,6 +248,25 @@ static struct hdpvr_buffer *hdpvr_get_next_buffer(struct hdpvr_device *dev)
 	return buf;
 }
 
+/*
+ * Put a consumed buffer back on the free list, unless the worker has
+ * resubmitted it in the meantime: the position and the buffer list of a
+ * buffer with an URB in flight must not be touched.
+ */
+static void hdpvr_recycle_buffer(struct hdpvr_device *dev,
+				 struct hdpvr_buffer *buf)
+{
+	mutex_lock(&dev->io_mutex);
+	if (buf->status == BUFSTAT_READY) {
+		buf->pos = 0;
+		buf->status = BUFSTAT_AVAILABLE;
+		list_move_tail(&buf->buff_list, &dev->free_buff_list);
+	}
+	mutex_unlock(&dev->io_mutex);
+
+	wake_up_interruptible(&dev->wait_buffer);
+}
+
 static void hdpvr_transmit_buffers(struct work_struct *work)
 {
 	struct hdpvr_device *dev = container_of(work, struct hdpvr_device,
@@ -415,6 +436,7 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 	struct urb *urb;
 	int ret = 0;
 	int rem, cnt;
+	unsigned int buf_pos;
 
 	if (*pos)
 		return -ESPIPE;
@@ -488,10 +510,22 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 
 		/* set remaining bytes to copy */
 		urb = buf->urb;
-		rem = urb->actual_length - buf->pos;
-		cnt = rem > count ? count : rem;
+		buf_pos = buf->pos;
+		rem = urb->actual_length - buf_pos;
+		if (rem <= 0) {
+			/*
+			 * The buffer was recycled and refilled with less data
+			 * than this reader already consumed from it, so there
+			 * is nothing left to copy. Give it back to the worker.
+			 */
+			hdpvr_recycle_buffer(dev, buf);
+
+			buf = hdpvr_get_next_buffer(dev);
+			continue;
+		}
+		cnt = min_t(int, rem, count);
 
-		if (copy_to_user(buffer, urb->transfer_buffer + buf->pos,
+		if (copy_to_user(buffer, urb->transfer_buffer + buf_pos,
 				 cnt)) {
 			v4l2_err(&dev->v4l2_dev, "read: copy_to_user failed\n");
 			if (!ret)
@@ -506,18 +540,10 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 
 		/* finished, take next buffer */
 		if (buf->pos == urb->actual_length) {
-			mutex_lock(&dev->io_mutex);
-			buf->pos = 0;
-			buf->status = BUFSTAT_AVAILABLE;
-
-			list_move_tail(&buf->buff_list, &dev->free_buff_list);
+			hdpvr_recycle_buffer(dev, buf);
 
 			print_buffer_status();
 
-			mutex_unlock(&dev->io_mutex);
-
-			wake_up_interruptible(&dev->wait_buffer);
-
 			buf = hdpvr_get_next_buffer(dev);
 		}
 	}
-- 
2.34.1

