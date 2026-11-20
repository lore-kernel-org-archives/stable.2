Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191636;
	b=x0JMnkozl36J9H3OTk4/8uZ8Y58sWSYSlAJHBRjVE2iChdIaxX32R4zQlIvhzX8tN9ac
	 3ePwGDhpYKk191jev50QqFYawBQs96RV9y45NJ6MQJ+mt1Z/dBm667NrEUnw9RMUa36PB
	 mFN5RFtptlsrJMg66va9SoPARLO+LQ4WAuJdqsjF4smfhzXOr50LvSNeKkvkx1gYDHlMb
	 crSQdyfHEIy9zYU0fvwOtl2dm2zJWA3GXO4p5FKFEPzXikx64FJ5dQlNYo0dem9lr6Q8K
	 EPVZtsKGMj++SuX6F8jcdjfP70g6vvYfkHl6b0INIWRlqBTWcLXFwtP4oFdY9H8V4sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191636;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=+D05lpCV9sFp0O/vrHa47EoULttgReSKLF94kPLxRF0=;
	b=SlwxYQ8tipUoSvzAvxLU1I+ly3FW0eccSEY/bmJPe0MJPHVx/1Wto/ZEdlXCuE3aDqK1
	 noAFbcACVeKYfJOvu/r3Ps8QTPezmqeE2qPEgZPs66gvwcfGzhIM02CFhuoD4p+ONRa3n
	 vuOYJxJLdHcfKE1qKPXKkU0KszE2vo2dgcl9zd8ElF9b0r7IJzn5FYWUF25sLH9a8W8Nu
	 GK5T3XR5zxyQfSbccbnOkaFHV3bxRsrt8c78VugR5zV98BHNXcIgcL34N41jatO1XlxGc
	 MZdh5W38bOOP+Z77QWro+5vjfTDqNOB/EYkmTq+zCGuAAM8J4P9Ieh6upwgTBeuXqcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C2D606A330;
	Fri, 20 Nov 2026 16:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14C2D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=+D05lpCV9sFp0O/vrHa47EoULttgReSKLF
	94kPLxRF0=; b=Z6hlyNtJgNdKsGmNHHYF5p2Nd2SqblPc7hkoghjDqaIHYk5PXN
	n+edXnqD/8MN4aE52im2ttfEishyu4BNKh+aHel8eKGci2bBTVXrDIlg/WQ4ADd5
	ZTXoUZ7Fi0e5/rGhJtzqw+KZ8NxzObtcm5QrUXzUsOAUFv1HW2hsoNEJU=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGzAFGcwBrz2n0AQ--.56536S3;
	Sat, 21 Nov 2026 00:20:28 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v3 2/2] media: hdpvr: fix out-of-bounds read in hdpvr_read()
Date: Sat, 21 Nov 2026 00:20:22 +0800
Message-Id: <20261120162022.5867-2-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120162022.5867-1-25031212351@stu.xidian.edu.cn>
References: <20261120162022.5867-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCGzAFGcwBrz2n0AQ--.56536S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18ur4kWFy5Gw1Utw18Krg_yoWrWr17pF
	W3KrW2yrWDXr9FkrnrXa1Iqa1rA3WkCF4UGrW5Gasayr45Gr1F9ryrt34jvFWrGr92vryj
	qFWa9ryfua1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY
	1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWlnxkEFVCFx7IYxxCEVcI25VAKI4
	IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMxkIecxE
	wVAFwVWUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0KNt5
	UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2sAYlgQcAACs7

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

Fixes: 9aba42efe85b ("V4L/DVB (11096): V4L2 Driver for the Hauppauge HD PVR usb capture device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v3:
 - Move the buffer recycling fix into a separate patch; no code change.
 drivers/media/usb/hdpvr/hdpvr-video.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 98480a67287a..32a54a5ebf0f 100644
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
@@ -434,6 +436,7 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 	struct urb *urb;
 	int ret = 0;
 	int rem, cnt;
+	unsigned int buf_pos;
 
 	if (*pos)
 		return -ESPIPE;
@@ -507,10 +510,22 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 
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
-- 
2.34.1

