Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194041;
	b=UyyOhZtPh3ju6g1JEC3QQYuirQU2XKup7x1p8dwUaZyw34Zx3lTDRWf9O0/ul4lx0kCM
	 9GPMzMZN+1LcLhPBKlvEzBrYKP0+9JYM+Ss7+HU/ggVvW25Lij1LuraNezsMfSZ2y6WDq
	 05CKxNab89HcmlAw2TKxN/lmneCw9wT6+2pb63NQ/oFoI2Q+OgtT49tlSEpfV6ajnzmcG
	 ik+lQRxE3i5gdZWgFgZMW9gM2bVQq90XVxiF8M5/3hCbhn8TNUkNNQysBC8iD3ZRJPUfN
	 Ig57c0kihZ71cW1FVBBt6ediZpjXr1KtXbD3cpQCJWVyDM8vWgD1rQSDK0hCPTREgxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194041;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=4IZDDSi2d+ugGc8+eYB34bH96I0Tc3GdlBRf2fwYrXk=;
	b=LSCFbQK2ahvVeG0iVMZRuZ1S7B7C/Z5JuygQP5d4kqoMZLHU6ZoEHSdWU7HZ8GbUdrm2
	 u7Dvu0AneHttXXkB6UXJgKCJUb3fKqcA935tOyBoeaKw1Mj0LFKV8lt4UA9sGAwTFraYL
	 svs3sRjB83hAF+r8d6PlO6mLbXRlY/jf/XUV3rCKBguflJEr6ZdElRoamgZPfv87gKKrS
	 Vtoynl5hu2rjMX+KKGiqfpdYcSOLHTG0ZJqt1ZDuB/NIpIgDiDPReKKlJzxidNoqzwWh5
	 rE2OBir+l5nEqpeeOb1ZC+l/zfKDaABsqIcFKQjamzAyMQ6c1JicCd8LDtc1M3jiXYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD426606A33B;
	Fri, 20 Nov 2026 17:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD426606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=4IZDDSi2d+
	ugGc8+eYB34bH96I0Tc3GdlBRf2fwYrXk=; b=YGpQpP8BDxyAsyDwrTyRMvCzHD
	iyhuXT2cDj7M4mYI1AxssnkYfr0m12xaDfFHPrkq/1okntESkm5Qrddcs22oiRyk
	4YQKNs8MTQkX6SFf8/84RFnflY0TtRaqYReR2uwhb+MN7pzmLRMWdT9jb3ddd0bY
	RMnGslUtNxGAcM6ok=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkA2XQOlfABr2fT0AQ--.62873S2;
	Sat, 21 Nov 2026 01:00:23 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v4] media: hdpvr: fix out-of-bounds read in hdpvr_read()
Date: Sat, 21 Nov 2026 01:00:21 +0800
Message-Id: <20261120170021.5340-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkA2XQOlfABr2fT0AQ--.62873S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF18KFy3Gry5uw1rGr17Jrb_yoWxZryrpa
	yfKayayr4DXr97CrsrGa1fJa1rCw1kWFW8GrW3GF9akr15Gr1FgFyrtryjvryrGr92vr4j
	qF4a9ryfuF4UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F6IAv
	xc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtw
	CY02Avz4vE14v_GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
	0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07b2tC7UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2sAYlgUOwACs0

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

hdpvr_read() computes the number of bytes left in the current buffer as
urb->actual_length - buf->pos and uses that as the length for
copy_to_user(). buf->pos is a plain unsigned int that is neither reset when
hdpvr_cancel_queue() recycles a buffer nor protected by dev->io_mutex.

After hdpvr_stop_streaming() has killed the URBs, the buffers are put back
on the free list with their old position, and the worker resubmits them
with urb->actual_length reset to 0. If the next transfer completes with
less data than the position a reader has already consumed, the subtraction
yields a negative value. As rem is an int and count is a size_t, the
comparison "rem > count" is then true, so cnt becomes count and
copy_to_user() copies count bytes starting at transfer_buffer + buf->pos,
which can be past the end of the 8192 byte transfer buffer. Two readers of
the same video device can corrupt each other's position in the same way,
and buf->pos is read twice, once for rem and once for the source address.

A KASAN slab-use-after-free read of 4096 bytes was observed in
hdpvr_read() with the source address 1281 bytes past the end of the
transfer buffer; the pages following the buffer had been recycled as slab
pages. A second report with a 42 byte copy was 25 bytes past the end of
the buffer.

Fix this by reading the position once, by using min_t() so that a negative
remainder cannot be turned into a full-size copy, and by accounting the
consumed bytes in hdpvr_account_buffer(), which recycles the buffer once it
has been read completely: the position, the buffer status and the buffer
lists are updated in the same critical section, and a buffer that has been
recycled and resubmitted in the meantime is left alone.

Reset buf->pos when hdpvr_cancel_queue() discards the buffers as well,
otherwise a restarted stream either skips the first bytes of the new
transfer or drops it entirely.

The buffer status is printed while dev->io_mutex is still held, as
print_buffer_status() walks both buffer lists.

Fixes: 9aba42efe85b ("V4L/DVB (11096): V4L2 Driver for the Hauppauge HD PVR usb capture device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v4:
 - Account the consumed bytes and recycle the buffer in the same critical
   section, so a buffer that another reader or a stream restart has already
   recycled and resubmitted is no longer modified after the fact.
 - Print the buffer status while the buffer lists are still locked:
   print_buffer_status() walks them and must not race with the worker.
 - Merge the two patches of the v3 series back into one patch, as the
   position, the status and the buffer lists form a single invariant.
 drivers/media/usb/hdpvr/hdpvr-video.c | 75 ++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 4290b2367fa3..387ddde776ae 100644
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
@@ -246,6 +248,43 @@ static struct hdpvr_buffer *hdpvr_get_next_buffer(struct hdpvr_device *dev)
 	return buf;
 }
 
+/*
+ * Account the bytes consumed from a buffer and hand it back to the worker
+ * once it has been read completely.
+ *
+ * The buffer may have been recycled and resubmitted, either by another
+ * reader or after a stream restart, while copy_to_user() slept. Its
+ * position and its place in the buffer lists then belong to the newer
+ * transfer and must not be touched, so only act if the buffer is still
+ * the one that was read from.
+ *
+ * Returns true if the buffer was handed back to the worker.
+ */
+static bool hdpvr_account_buffer(struct hdpvr_device *dev,
+				 struct hdpvr_buffer *buf,
+				 unsigned int pos, unsigned int new_pos)
+{
+	bool recycled = false;
+
+	mutex_lock(&dev->io_mutex);
+	if (buf->status == BUFSTAT_READY && buf->pos == pos) {
+		buf->pos = new_pos;
+		if (new_pos >= buf->urb->actual_length) {
+			buf->pos = 0;
+			buf->status = BUFSTAT_AVAILABLE;
+			list_move_tail(&buf->buff_list, &dev->free_buff_list);
+			print_buffer_status();
+			recycled = true;
+		}
+	}
+	mutex_unlock(&dev->io_mutex);
+
+	if (recycled)
+		wake_up_interruptible(&dev->wait_buffer);
+
+	return recycled;
+}
+
 static void hdpvr_transmit_buffers(struct work_struct *work)
 {
 	struct hdpvr_device *dev = container_of(work, struct hdpvr_device,
@@ -415,6 +454,7 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 	struct urb *urb;
 	int ret = 0;
 	int rem, cnt;
+	unsigned int buf_pos;
 
 	if (*pos)
 		return -ESPIPE;
@@ -488,10 +528,23 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 
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
+			 * is nothing left to copy. Give it back to the worker
+			 * if it is still the buffer we were reading from.
+			 */
+			hdpvr_account_buffer(dev, buf, buf_pos, buf_pos);
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
@@ -499,27 +552,13 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 			goto err;
 		}
 
-		buf->pos += cnt;
 		count -= cnt;
 		buffer += cnt;
 		ret += cnt;
 
 		/* finished, take next buffer */
-		if (buf->pos == urb->actual_length) {
-			mutex_lock(&dev->io_mutex);
-			buf->pos = 0;
-			buf->status = BUFSTAT_AVAILABLE;
-
-			list_move_tail(&buf->buff_list, &dev->free_buff_list);
-
-			print_buffer_status();
-
-			mutex_unlock(&dev->io_mutex);
-
-			wake_up_interruptible(&dev->wait_buffer);
-
+		if (hdpvr_account_buffer(dev, buf, buf_pos, buf_pos + cnt))
 			buf = hdpvr_get_next_buffer(dev);
-		}
 	}
 err:
 	if (!ret && !buf)
-- 
2.34.1

