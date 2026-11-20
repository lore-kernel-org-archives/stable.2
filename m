Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191636;
	b=zaPPX64/cqdRvR/znzBAEkvD9Nno1Bx8W5Lcw8VmaOMjKgiJMKcbbXrPz1Z/TSSlOg7U
	 xm2pcvv+hJNmHwimeVADbAugBNLWA7F9QE418qfeA8BZ6k3Qeio+qcDlJL1dYr5zbSVhW
	 F4L8RJpooyX1h7+gMLkErMT22bhNhIEpqmOSgLIoE0HDZ+KVr1bcEdUgHcABFi9ZNMosL
	 WEAB4soRBuFLFMttigIABj4kocoTxLuq9w0+jdoO2tYJvD3SpPBVAox0R90ynP5u1qCYg
	 2pPOPpGOKuU8IShBxU3vI0cbDwS0dvrne7zWclZO+cAwkcvVqV4Ht1VaLCkI9eBgleQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191636;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=vmvV8mNalTdSlPtHe2FtlIbyUlZmRF8mGQiZCHzGHp0=;
	b=40wmehSuaJY5g7AJWMN0YZ+4o3s3moZtl4Pmv/TNMR4JZhfWe58/O58oGMwTNPPhEoWG
	 u+u+BYPIvSi4L658OMBrkcU5NtcfaTdyZaVm1p96xJtZTxR1vuWZ3ABeypaSLG45v/BOQ
	 PqHCjoEkMorXG+4fZoEA6Bn1hQp2lHY9yLFS23O9O3iIz00bGKk2n4gLrYe5sOW4UmfIc
	 chkSa8epPrDOIlVLil0Eack1FSt9tEMZJBEkakWMht6NE7jpm3xiftn5iRKqslCIE9tWL
	 4ozGQQRDGeF+P0PgVAVhYWHVS5dpWZjcQOhothemSLRc4fuuXRyn+xUgiLO0U+eZ9FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0587606A320;
	Fri, 20 Nov 2026 16:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0587606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=vmvV8mNalT
	dSlPtHe2FtlIbyUlZmRF8mGQiZCHzGHp0=; b=b7y8gNHWficCkwy+ySEA8mfyLW
	uiPYna96mBgP7VWRbHXqIpbNPdV+DFNI8sc+kpoCgU48i/Fog7DB+7L4i5BzW10L
	eZ3RBIz1UkM/fgPMchjZlKVC0tkt6aOf7m01MYg2MWPsxdMx++BV2NdMokp/T5Qs
	yk+PqAsb61rb5pJqA=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGzAFGcwBrz2n0AQ--.56536S2;
	Sat, 21 Nov 2026 00:20:23 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v3 1/2] media: hdpvr: don't recycle an in-flight buffer
Date: Sat, 21 Nov 2026 00:20:21 +0800
Message-Id: <20261120162022.5867-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCGzAFGcwBrz2n0AQ--.56536S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw13Ww1fZFWrJFWUKFyDWrg_yoW5ZFykpF
	WfKFWayrWDXFWDWr47JF47XayrGa1vgFW8CFW3Jas7CF45Jr1SvFy8try7uryrAr92yrWU
	tFWI934fWr48ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F6IAv
	xc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtw
	CY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
	0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07j-nYrUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2sAYlgQcAABs4

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

hdpvr_read() gives a fully read buffer back to the device by moving it to
dev->free_buff_list and marking it available. The buffer status is checked
before dev->io_mutex is taken, but the worker can resubmit the same buffer
in the meantime, and the buffer then has an URB in flight and belongs on
dev->rec_buff_list.

If it is moved to dev->free_buff_list anyway, the worker later tries to
submit the active URB again, which triggers the "URB %p submitted while
active" warning in usb_submit_urb() and fails the submission, and
hdpvr_cancel_queue() no longer sees the URB, so hdpvr_free_buffers() can
free the URB and its DMA buffer while the HCD still owns them.

Two readers of the same video device can reach this, as
hdpvr_get_next_buffer() returns the receive buffer to every reader without
removing it from the list, and hdpvr_read() is not serialized.

Only put the buffer back on the free list if it is still waiting to be
read.

Fixes: 9aba42efe85b ("V4L/DVB (11096): V4L2 Driver for the Hauppauge HD PVR usb capture device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v3:
 - Split out of the combined patch sent as v2; no code change.
 drivers/media/usb/hdpvr/hdpvr-video.c | 29 ++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 4290b2367fa3..98480a67287a 100644
--- a/drivers/media/usb/hdpvr/hdpvr-video.c
+++ b/drivers/media/usb/hdpvr/hdpvr-video.c
@@ -246,6 +246,25 @@ static struct hdpvr_buffer *hdpvr_get_next_buffer(struct hdpvr_device *dev)
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
@@ -506,18 +525,10 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 
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

