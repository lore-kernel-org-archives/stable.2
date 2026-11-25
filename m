Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612585;
	b=iFW6H2qGh7Dxjeg5aHpMHGOTZNCcCgFeQ1dgWJ0o+8VT+hf9vDiVAEhg/WL+WBZH2gwD
	 k1AMCBRDbhFIyEX6o6/f4sdDSuXxsRsrtC3Wx1kfBfA9cTTz2VbUiNtwOJG77EA0Zm8X2
	 C4Cpn7EAcCTE3zHilRW2TW9q7dKUSCqFX1w5xNuGPFRtoV6sm8/JPU8GbaBubcLk1CLVB
	 PlYg/ItOA4FVCa94+CMwTaGW9182nJMd36xGrATVJD14bAEGZYJjGH/IFepLoP1deCxSz
	 i84NkPiRfebBkVqoweiN5MVdqRAIwnN+k+DQc1QV31hpkhLWnYwJkj2U3gDg2VXq46A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612585;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=t9B5wGN6/95WVS2HwxutgATaxtkHQINqqJVM959cVdI=;
	b=zYuxtTpRkElKK9NqQyZRngZvn2PKLkl7Q7v8HXI8oBcGmQmTxyQ3avgYeok6f2m3Qayx
	 m7620124+gg/PVekss6XTauMS1cMriuBwb6y2r8KlAajX2qLnyYJBMsfgtYn4i5Gv2kMz
	 4EQyAZQxbmGtdcX+xiCy1O5YA3jroh0vTeZWlNovQr8NBxHUV9as8AueNuQTrZcY+u+Dx
	 WwrSHtkdA4W8eSEwYykugIWQ8uzbRW9qn5BV56Wls8WrgTI4pTJSXB3D4xC0Njg+eujdP
	 90eekLRg7GnJqccnm29ICJ13NRnfrW2yXJl6BJvkRlZWj0T/Tl2S9JvSacIxBWkT5Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1A606A321;
	Wed, 25 Nov 2026 13:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A1A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=t9B5wGN6/9
	5WVS2HwxutgATaxtkHQINqqJVM959cVdI=; b=HTLG1utSKDs1rrfuWgEnsnJbeQ
	Ue1Lc492LZ9JfEKNLNaEQ3luwlg7cTXrcZj7NdkL54gl0EA9/gRhh4sge7+/81OH
	WeaJs9boeQLZNvwvZBWFIEcBiCU4rFSRrZ1yHbY/oapl3MswD9TWMIA4OIkHU3i9
	vUt++sO4Ijf5IpyEU=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.49])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkA2XQOT3wZrak42Ag--.43051S2;
	Wed, 25 Nov 2026 21:16:04 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v6] media: hdpvr: reject a second reader in hdpvr_read()
Date: Wed, 25 Nov 2026 21:16:03 +0800
Message-Id: <20261125131603.2806-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkA2XQOT3wZrak42Ag--.43051S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFykZw47Zr43urW3Ary5Arb_yoWrCw1Upa
	95KFWayFyDXr929r47Ga1xt3W5C3WvkFyUGFW8Gas3Arn8Gr1FgryFkayjgFyrJ3s2vrWj
	qF42v34fuw4UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F
	6IAvxc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAV
	WUtwCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjxUyEdyUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUID2sFqsrrpgAAsD

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

hdpvr_read() does not check dev->owner, although the rest of the driver
assumes a single active reader: vidioc_encoder_cmd() returns -EBUSY when
another file handle owns the stream, and hdpvr_release() only stops
streaming when the owner closes the file.

Two readers therefore consume the same buffers and update buf->pos
concurrently. When hdpvr_stop_streaming() has killed the URBs, the
buffers are put back on the free list with their old position, and the
worker resubmits them with urb->actual_length reset to 0. If the next
transfer completes with less data than the position a reader has already
consumed, urb->actual_length - buf->pos is negative. As rem is an int and
count is a size_t, "rem > count" is then true, so cnt becomes count and
copy_to_user() copies count bytes starting at transfer_buffer + buf->pos,
which can be past the end of the 8192 byte transfer buffer.

A KASAN slab-use-after-free read of 4096 bytes was observed in
hdpvr_read() with the source address 1281 bytes past the end of the
transfer buffer; the pages following the buffer had been recycled as slab
pages. A second report with a 42 byte copy was 25 bytes past the end of
the buffer.

Return -EBUSY when another file handle owns the stream, like
vidioc_encoder_cmd() does, and reset buf->pos when hdpvr_cancel_queue()
discards a buffer or when a new transfer is started, so that the position
always belongs to the current transfer. A stream restart can still race
with a read of the owning file handle, so start over at the beginning of
the buffer instead of letting the negative remainder become a full-size
copy.

Suggested-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Fixes: 9aba42efe85b ("V4L/DVB (11096): V4L2 Driver for the Hauppauge HD PVR usb capture device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v6:
 - Reject a second reader with -EBUSY in hdpvr_read(), as
   vidioc_encoder_cmd() already does; this is the root cause of the
   concurrent buf->pos updates.
 - Drop the generation counter and the buffer accounting helper. Only
   reset buf->pos when a buffer is discarded or a new transfer is started,
   and start over at the beginning of the buffer if the position no
   longer matches the current transfer.
 drivers/media/usb/hdpvr/hdpvr-video.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 4290b2367fa3..620923acb4f1 100644
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
@@ -210,6 +212,7 @@ static int hdpvr_submit_buffers(struct hdpvr_device *dev)
 		urb = buf->urb;
 		urb->status = 0;
 		urb->actual_length = 0;
+		buf->pos = 0;
 		ret = usb_submit_urb(urb, GFP_KERNEL);
 		if (ret) {
 			v4l2_err(&dev->v4l2_dev,
@@ -420,6 +423,10 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 		return -ESPIPE;
 
 	mutex_lock(&dev->io_mutex);
+	if (dev->owner && file_to_v4l2_fh(file) != dev->owner) {
+		mutex_unlock(&dev->io_mutex);
+		return -EBUSY;
+	}
 	if (dev->status == STATUS_IDLE) {
 		if (hdpvr_start_streaming(dev)) {
 			v4l2_dbg(MSG_INFO, hdpvr_debug, &dev->v4l2_dev,
@@ -489,6 +496,14 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 		/* set remaining bytes to copy */
 		urb = buf->urb;
 		rem = urb->actual_length - buf->pos;
+		if (rem < 0) {
+			/*
+			 * A stream restart discarded the data this position
+			 * belongs to: start over at the beginning.
+			 */
+			buf->pos = 0;
+			continue;
+		}
 		cnt = rem > count ? count : rem;
 
 		if (copy_to_user(buffer, urb->transfer_buffer + buf->pos,
-- 
2.34.1

