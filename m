Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490141;
	b=bIAEWfAdAJDuS2IFasouNdBWkMvVSL8oU8y94iSaRUbV5FES+Mz+ZUu4A5f4WWgnFi3t
	 6CjvwzyY1rjvfFPGvBKlA3t6v/JA0cmQBZNlvtJUQF+WzpOl9pBOh+FyFPZLeRU11kUEv
	 m4R/XDZDBLoI/T1tpx0yE86lmMR9k+vzwnY/sz9H0g0JAzLirMqGttq6OwvTev74cZbaO
	 gButexwYp94V05ZYH2tKhpsECcfIiIf4E88RNyHFdmCWFlJoksm+7RYpmyQ3zObpYWtfw
	 SknJ3HJozRVeJ4LyEDq8zBMRqcPFpQOHUN6g0JKrxYHSGUJW+hMjrHp84AXZXke+Hfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490141;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=P8l2QId3mH+IrSBq1qchRf6jsGorpmHmgtaz/Zi2jsQ=;
	b=yzDrrC2IVqa7ERUmxvPOu/VEWtzLN5wfJdHd7eyqoaAWnmbmtW0B0TdCskF8okOVkwKe
	 3SZuL7pg5i0ClEC2bHe9o8VgmjF3xRq5YhXYKTwoKat3bw20ljhHy1PKqh7TsDUW8Kfbc
	 TjPZlSFLJlwig3q+ofh1nxu1xpzDP5UQtnhmPxsDd4dEfdqaNWH5ozS6hQySaXrjAj8u+
	 fm6kc7nasbyUoep2a3QX/mt2OveTEpe/b7b5jbT5nQx+adenAd0TBR9wsu9CMe2OEv2U1
	 DbxI68FCYhdzHiBzRpMGCPELNJyVSpURppfbeCTWaLABRUu0SFfu/cLVOuIINAj9Cbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03F8606A327;
	Thu, 12 Nov 2026 13:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A03F8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=P8l2QId3mH+IrSBq1qchRf6jsGorpmHmgt
	az/Zi2jsQ=; b=7H7JAh8/XybRbzLXpwjrwjv6ksnklmOVLKjgN84CA4wDYvkuMf
	7LKPnFzZ/vImS/Xqy+fNlSVkR8mxQCwirQOkHfkM+zAhg1TBahfZhO+1/TzLMQUY
	0K/yl3s3URABnh4UvVCiiqSgrFNAHNGLDT9d/YJHsc5Rs1QqjAGf5J/eM=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBGbgQHv_Vq2duGAQ--.20236S2;
	Thu, 12 Nov 2026 21:28:41 +0800 (CST)
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
Subject: [PATCH v5] media: gspca: don't set streaming before the transfers are set up
Date: Thu, 12 Nov 2026 21:28:39 +0800
Message-Id: <20261112132839.39998-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8ee51709-5c3a-4708-b10d-86d172c4397b@kernel.org>
References: <8ee51709-5c3a-4708-b10d-86d172c4397b@kernel.org>
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
X-CM-TRANSID:BrQMCkBGbgQHv_Vq2duGAQ--.20236S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4fKw4kCr1xGw4rXr43Jrb_yoWrJr1DpF
	Z3WayYy398JF4DuF47Wwn0kFyrCa93JrW7GrWfKws5Ars8CF90yFyFq340gr17ArZ7uayr
	tF1DtryUGa9IyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUPD2r0hNbUBAACsa

gspca_init_transfer() sets gspca_dev->streaming before it submits the
URBs, so an URB that completes while the remaining ones are still being
submitted is processed: gspca_frame_add() hands its buffer to videobuf2.

If one of the submissions then fails, gspca_start_streaming() returns the
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
userspace while a read() was starting the stream: the endpoint is
removed, so usb_submit_urb() fails with -ENOENT, and the driver is
unbound.

Set gspca_dev->streaming only once the transfers are set up.  Until then
isoc_irq() and bulk_irq() discard the completions, so no frame can be
completed before start_streaming() returns and the done list is empty
when it fails.  The subdrivers that start the transfers themselves
(bulk_nurbs == 0) get the flag right after their start callback, as
before.

Fixes: 1f5965c4dfd7 ("media: gspca: convert to vb2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
The flag is just set too early: isoc_irq() and bulk_irq() already discard
the completions while streaming is clear, so moving the assignment after
the URB submission is enough.  The subdrivers that start the transfers
themselves (bulk_nurbs == 0) get the flag right after their start
callback, as before.

Changes in v5:
- Don't park the frames that complete early; set gspca_dev->streaming once
  the transfers are set up instead.
- Drop the pending list, the extra flag and the retry state reset that v4
  added.

 drivers/media/usb/gspca/gspca.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 594d73e50b9f..69361ad4d8f9 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -840,11 +840,12 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 			goto out;
 		}
 		v4l2_ctrl_handler_setup(gspca_dev->vdev.ctrl_handler);
-		gspca_dev->streaming = true;
 
 		/* some bulk transfers are started by the subdriver */
-		if (gspca_dev->cam.bulk && gspca_dev->cam.bulk_nurbs == 0)
+		if (gspca_dev->cam.bulk && gspca_dev->cam.bulk_nurbs == 0) {
+			gspca_dev->streaming = true;
 			break;
+		}
 
 		/* submit the URBs */
 		for (n = 0; n < MAX_NURBS; n++) {
@@ -855,8 +856,10 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 			if (ret < 0)
 				break;
 		}
-		if (ret >= 0)
+		if (ret >= 0) {
+			gspca_dev->streaming = true;
 			break;			/* transfer is started */
+		}
 
 		/* something when wrong
 		 * stop the webcam and free the transfer resources */
-- 
2.34.1

