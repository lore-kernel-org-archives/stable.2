Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256763;
	b=iwXzA8D47zKIjG1yOpxanLGv9J/nd3Ifw6Dv2M81cYWur8vEQDJ1ecnloM9z7QylqblS
	 AjxHhoQtL2lrhQLhqt3v0/UFWOwCE90EpB1M9YMOhS3nPswVbe17z23EbSxORRiiFpPi5
	 dat2SvAYwo3omALxKSC14gz+Atl8sNn3lQkVyTm2eNoV3xbxc2sscVARN/1EpSmYD++Ac
	 uQTKmTPOE/W69F3ECv3O8e3SeoH6XM5RKunJ9/SVNqaZklIyIrEj/tv9vY7blKGU37HKj
	 klGdBjzjdOaRSa4p1afaImJ8p0zhwfLi7qNkcvPDIaYMAzpv4URReVWRleIrKd1/bsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256763;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=qa9oD3zTchOdAVP4qDsTgWeaLYAWjGscH74jTPHvN0o=;
	b=4rmTgrzZkYcPnZd7LXLQ2K24VTKSPGh6+sDD0gAiJIryPrpix1KLzFS4JCrwOZ5C9OqY
	 872RZXr1/DMyaxqCDULLdLj6nhBZcUyfslQVX9pMNJ+NJ4xpps7zmLkEdSSu4q2z0Mai/
	 onIiDMzgvhCZGBsoE5sSzwf85BzTU62w8e2MLvdt00tvN/coeQjbFM5pRk5aB1keDsjha
	 hieplMw06swV9fg9Hy5eIqC2Mv6jl/0Vpewmci75la0D5iGF+3FvL5AOkLI3MWGuV8UKk
	 bnZP52kLO9MNNS/DXX8XHF9iDq6A+KrNA7pnrmeY3Vs41jqGHfLPVTS50/goI5wjrIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148B9606A332;
	Sat, 21 Nov 2026 10:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 148B9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=qa9oD3zTch
	OdAVP4qDsTgWeaLYAWjGscH74jTPHvN0o=; b=YnPVaTNZs3VOMWBD6U7Pmk41fi
	CKbVNyO2JMv3nKiMe8P0wyiQXXK+LnghXbQzl15z395O7A4zK8CZRV44uxqD3ksU
	6UN+7lvhjELh3Fu1ELAQlnhFsu/u6OL2Tm2ZYPV/XXoS3Vnt7moqgEDHTnt2WCe7
	J98DDdXXN9aMZ7oLQ=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBWdPqvcQFrwtIAAg--.46559S2;
	Sat, 21 Nov 2026 18:25:52 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v5] media: hdpvr: fix out-of-bounds read in hdpvr_read()
Date: Sat, 21 Nov 2026 18:25:51 +0800
Message-Id: <20261121102551.11263-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkBWdPqvcQFrwtIAAg--.46559S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF18KFy3Gry5uw15Kw1Dtrb_yoW3uF4kpF
	WfK3yayrWDXryxursrJF48Ja4rAwn29FW8GrWxGasYyr15Gr1FgFyFqryjkryrGr92vr4j
	qF4a9ryfuF4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F
	6IAvxc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAV
	WUtwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjxUguWLUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUED2sAZMnEuAADs1

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

hdpvr_read() computes the number of bytes left in the current buffer as
urb->actual_length - buf->pos and uses that as the length for
copy_to_user(). buf->pos is a plain unsigned int that is neither reset
when hdpvr_cancel_queue() recycles a buffer nor protected by
dev->io_mutex.

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

Fix this by reading the position once, by using min_t() so that a
negative remainder cannot be turned into a full-size copy, and by
accounting the consumed bytes in hdpvr_account_buffer(), which recycles
the buffer once it has been read completely: the position, the status
and the buffer lists are updated in the same critical section.

The helper only acts when the buffer still holds the transfer that was
read from. A reader can sleep in copy_to_user() while another reader or
a stream restart recycles and resubmits the buffer, and the new transfer
may start at offset 0 as well, so every buffer carries a generation that
is bumped on submission and is checked along with the position. For the
same reason the head of the receive list is re-read after each copy
instead of keeping a buffer that may meanwhile have been queued behind
the reader's back.

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
v5:
 - Bump a generation on every submission and check it when accounting the
   consumed bytes: a reader that slept through a recycle and resubmission
   could mistake the new transfer for the one it was reading, as both start
   at offset 0.
 - Re-read the head of the receive list after each copy instead of keeping
   the buffer, so a reader never waits on a buffer that has been recycled
   and resubmitted behind its back.
 drivers/media/usb/hdpvr/hdpvr-video.c | 86 +++++++++++++++++++++------
 drivers/media/usb/hdpvr/hdpvr.h       |  3 +
 2 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 4290b2367fa3..c7b55962d986 100644
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
@@ -210,6 +212,8 @@ static int hdpvr_submit_buffers(struct hdpvr_device *dev)
 		urb = buf->urb;
 		urb->status = 0;
 		urb->actual_length = 0;
+		buf->pos = 0;
+		buf->generation++;
 		ret = usb_submit_urb(urb, GFP_KERNEL);
 		if (ret) {
 			v4l2_err(&dev->v4l2_dev,
@@ -246,6 +250,42 @@ static struct hdpvr_buffer *hdpvr_get_next_buffer(struct hdpvr_device *dev)
 	return buf;
 }
 
+/*
+ * Account the bytes consumed from a buffer and hand it back to the worker
+ * once it has been read completely.
+ *
+ * The buffer may have been recycled and resubmitted, either by another
+ * reader or after a stream restart, while copy_to_user() slept. Its
+ * position and its place in the buffer lists then belong to the newer
+ * transfer and must not be touched, so only act if the buffer still holds
+ * the transfer that was read from. The generation tells the transfers
+ * apart even when both of them started at offset 0.
+ */
+static void hdpvr_account_buffer(struct hdpvr_device *dev,
+				 struct hdpvr_buffer *buf,
+				 unsigned int generation, unsigned int pos,
+				 unsigned int new_pos)
+{
+	bool recycled = false;
+
+	mutex_lock(&dev->io_mutex);
+	if (buf->generation == generation && buf->status == BUFSTAT_READY &&
+	    buf->pos == pos) {
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
+}
+
 static void hdpvr_transmit_buffers(struct work_struct *work)
 {
 	struct hdpvr_device *dev = container_of(work, struct hdpvr_device,
@@ -415,6 +455,7 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 	struct urb *urb;
 	int ret = 0;
 	int rem, cnt;
+	unsigned int generation, buf_pos;
 
 	if (*pos)
 		return -ESPIPE;
@@ -488,10 +529,25 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 
 		/* set remaining bytes to copy */
 		urb = buf->urb;
-		rem = urb->actual_length - buf->pos;
-		cnt = rem > count ? count : rem;
+		generation = buf->generation;
+		buf_pos = buf->pos;
+		rem = urb->actual_length - buf_pos;
+		if (rem <= 0) {
+			/*
+			 * The buffer was recycled and refilled with less data
+			 * than this reader already consumed from it, so there
+			 * is nothing left to copy. Give it back to the worker
+			 * if it is still the buffer we were reading from.
+			 */
+			hdpvr_account_buffer(dev, buf, generation, buf_pos,
+					     buf_pos);
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
@@ -499,27 +555,19 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 			goto err;
 		}
 
-		buf->pos += cnt;
 		count -= cnt;
 		buffer += cnt;
 		ret += cnt;
 
-		/* finished, take next buffer */
-		if (buf->pos == urb->actual_length) {
-			mutex_lock(&dev->io_mutex);
-			buf->pos = 0;
-			buf->status = BUFSTAT_AVAILABLE;
-
-			list_move_tail(&buf->buff_list, &dev->free_buff_list);
-
-			print_buffer_status();
+		hdpvr_account_buffer(dev, buf, generation, buf_pos,
+				     buf_pos + cnt);
 
-			mutex_unlock(&dev->io_mutex);
-
-			wake_up_interruptible(&dev->wait_buffer);
-
-			buf = hdpvr_get_next_buffer(dev);
-		}
+		/*
+		 * The buffer may have been recycled and resubmitted to the
+		 * tail of the list while we copied, so re-read the head
+		 * instead of keeping it.
+		 */
+		buf = hdpvr_get_next_buffer(dev);
 	}
 err:
 	if (!ret && !buf)
diff --git a/drivers/media/usb/hdpvr/hdpvr.h b/drivers/media/usb/hdpvr/hdpvr.h
index 84519c962cb4..4504fb58855a 100644
--- a/drivers/media/usb/hdpvr/hdpvr.h
+++ b/drivers/media/usb/hdpvr/hdpvr.h
@@ -139,6 +139,9 @@ struct hdpvr_buffer {
 
 	uint			pos;
 
+	/* bumped every time a new transfer is started on the buffer */
+	unsigned int		generation;
+
 	__u8			status;
 };
 
-- 
2.34.1

