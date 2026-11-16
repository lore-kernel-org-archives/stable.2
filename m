Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851688;
	b=SjJ8LI+PidFNC19IGfOUkeY+NvtB3+YbQVbUGJIeUReEiyLHCYxnXnzGqlhPaEnaPNiG
	 sH9Zqi03detbiq7T+2xZg+iGV1SdFj4BK3iLppuXmNashI/L+Chy7J4nrcuqBBWoBU9wv
	 me7Aori//sraVuWc/G/NziMFQ4tC0q1kDv0c4447Xw0FgkW0vlFTounmfSMQqUsJr+xLW
	 RhZwX64viTwi7/h5v9dW+72Ko7Jq68dhQPkxC8FLr8awWxmm9U/Q+EpCBTuVLLWUTaeuQ
	 jIgQiTQ1Tk8+A1I1+aD92xfTtVMRcty5QxFoqyBz1w/S6dzjOw07dDNwbQD8Pwykb+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851688;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=BexiXxDoqI0E/gCNS3LAqWJ7uuhxAY02QSzzdUZk1WQ=;
	b=xi3KRo7eqSLUL381d+8AMjyWyXJtXLCQA9cmew46X5agIqevNH+BlUsL6RJH+hbQ0EUk
	 IYMKo0qU52VRrri+vIpORONJ252ClKXzoiCIFp1WpcWOg4ZghJ9zGiT8ZTnsskGwFFRaY
	 GOqX46eEw6j/y5BT6KtbGQENFBCZGvHTPH19XZwBF1ueOpjJqNktvoYhdFGjO9kVDbJB5
	 gbYk/5ujUlxUVmeKN4SSR5cMH/aaMSk9aLOpkTPXdmxgjCjEtRNSCs+k7Hn051LMGfPnn
	 NP5haW24EOJmpMlOXMLElwgEyXN0m+dfQMa5ntTLnP58jLdiXsoC7jcOlZuNmbYi3tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D3606A334;
	Mon, 16 Nov 2026 17:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C19D3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=BexiXxDoqI
	0E/gCNS3LAqWJ7uuhxAY02QSzzdUZk1WQ=; b=a1HOpdCzlzIRK8XvtHzHMeW/b5
	jHiKge8ooTBEcQ39iyCQV58sOWADJOBoaSMdvP+c+eNrRDNiw5NUl/5Om04axCBf
	m3WDgbl9RhH/nkh2T8ONcgeb0EU9RauyAMjAabePsrYtOt7QTBRq/+BikFkJY5ZS
	MXElTwifkrvMnACpY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkB2nwVUQ_tqLZG7AQ--.61802S2;
	Tue, 17 Nov 2026 01:54:30 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: hdpvr: fix out-of-bounds read in hdpvr_read()
Date: Tue, 17 Nov 2026 01:54:28 +0800
Message-Id: <20261116175428.14540-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkB2nwVUQ_tqLZG7AQ--.61802S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18ur4kWFy5Gw1Utw18Krg_yoW5KFWDpF
	W3KayayryDXr9F9wsrGa1xXa1rCw1kCFW8GrW7Gasakr45XF1S9ryrtayjvFyrGr92vry0
	qFZI9r95ua1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F6IAv
	xc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07boT5LUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2r7HFch0wAAsw

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

Fixes: 9aba42efe85b ("V4L/DVB (11096): V4L2 Driver for the Hauppauge HD PVR usb capture device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/hdpvr/hdpvr-video.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 4290b2367fa3..364a55dbdde8 100644
--- a/drivers/media/usb/hdpvr/hdpvr-video.c
+++ b/drivers/media/usb/hdpvr/hdpvr-video.c
@@ -415,6 +415,7 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 	struct urb *urb;
 	int ret = 0;
 	int rem, cnt;
+	unsigned int buf_pos;
 
 	if (*pos)
 		return -ESPIPE;
@@ -488,10 +489,28 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 
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
+			mutex_lock(&dev->io_mutex);
+			buf->pos = 0;
+			buf->status = BUFSTAT_AVAILABLE;
+			list_move_tail(&buf->buff_list, &dev->free_buff_list);
+			mutex_unlock(&dev->io_mutex);
+
+			wake_up_interruptible(&dev->wait_buffer);
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

