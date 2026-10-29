Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269276;
	b=lOlCGR5RgYZp84tNlsG2qOHnhZ0gjwkzs2aY5etdwzRgWQbjsCCMGS4fc274HW2S9FM+
	 AMnAMYsEOUjwlRWU87XxavOUSKHDS6gAsrPRCVm9+Y2mZLQ/z9mTd3n0OzVryPg6U+jBb
	 wprWRc0uEwbtmxJvu+05p6V+k9Imr/Lq6R10eT5Nqn33FAt87+A7wnh4b0vP4kITtP+aJ
	 0zsCx1GaMzDm8PJQfep+anyXA6Bb2LPUNcy/vmHWiWs3vh6cH9BX/Zb2sQ+tYj98CFbZj
	 iy+KGvWzWmssJ59lgmOsnrKYPrNwyHBA52/yKWZBvlBPeecDo9xXsXDxC14cL24GYfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269276;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=+3nAUYBGz2stcktDmPryBjKJjci4h4852ZCrooNiT6c=;
	b=2wftCPdC/F7bB5ExiZKz40UzWMJVUVkaUYu5SkWnMTsHRlcPAbIYOw8jNiyDSUUpmqqB
	 gpLe4dV9F86IvyvRL0cP8QnOeSI8KodOVRREyNOQwR9dshn7zbjD20147prK6jYk6GKNv
	 b3XQjgtqYFFWXxHHUjBI8U/Y8crjRMt4lWRncD9ahFyM8ViFt6ZnAaeqHZrYvbG1YNGtZ
	 s0YgAiiuBP76LX16V7H/2NnDfu0W80JuYMmHEJlLvwm2WsOvaB/vvbEIurO6xmHNcGB9L
	 urNfL+33zgrtBnN4QvVsmLeeAro30IbgyvJGh2MekWnl8HcadQ4WACjjbUfJSLi4ENQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57B8606A31C;
	Thu, 29 Oct 2026 10:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=+3nAUYBGz2
	stcktDmPryBjKJjci4h4852ZCrooNiT6c=; b=Al66+AjQDZIjJXHujnO6XuEfMu
	l/PstyfhSArKh5Ow8iDerX0pJQmaZq1q9dKu4YOXPE00PmxqY4/I+yf0hZzClkOg
	XYyczVRKbJxujDv2vIO9lpaJ2FkdHWOkwIE7z2aQ3I0pRpa613sv69oG6uOBt2eq
	UEENhncf1wXZ7lKhI=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBGjgMIHuNq+uD9AA--.65420S2;
	Thu, 29 Oct 2026 18:20:57 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Huang <huanglei@kylinos.cn>,
	Dean Anderson <dean@sensoray.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: s2255: cancel the in-flight firmware URB before reloading
Date: Thu, 29 Oct 2026 18:20:55 +0800
Message-Id: <20261029102055.30569-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBGjgMIHuNq+uD9AA--.65420S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryrZw48AF45WFyrAw17GFg_yoW5Wr1DpF
	W0ga4YkFWDGw1rCF1rCrW7u3Wruan5JFW7GFy7J34qvrn8J34DAFyFq342qFyDJrySka47
	tryqgFy5CFWUtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2fMaUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUBD2riD9OnswAAsK

The driver uses a single URB to upload the firmware. s2255_timer() submits
it one second after s2255_fwload_start() filled in the first chunk, and
s2255_fwchunk_complete() resubmits it for each following chunk.

When the transfer does not complete within S2255_LOAD_TIMEOUT, s2255_open()
stops waiting, sets the firmware state to S2255_FW_FAILED and returns
-EAGAIN. The next open() calls s2255_fwload_start() again, which refills
the URB and arms the timer while the previous transfer may still be owned
by the USB core.

One second later s2255_timer() submits that URB again:

  URB 00000000b9ed398a submitted while active
  WARNING: drivers/usb/core/urb.c:379 at usb_submit_urb

usb_submit_urb() returns -EBUSY, the firmware state is set to
S2255_FW_FAILED and the device stays unusable. Rewriting the fields of a
URB that is still in flight is unsafe as well.

Cancel the outstanding transfer and the pending timer before reusing the
URB. A killed transfer completes with -ENOENT, so do not report it as a
transfer error.

Fixes: 38f993ad8b1f ("V4L/DVB (8125): This driver adds support for the Sensoray 2255 devices.")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/s2255/s2255drv.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index 15012d73975c..4d5de6930542 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -490,7 +490,9 @@ static void s2255_fwchunk_complete(struct urb *urb)
 	int len;
 
 	if (urb->status) {
-		dev_err(&udev->dev, "URB failed with status %d\n", urb->status);
+		if (urb->status != -ENOENT)
+			dev_err(&udev->dev, "URB failed with status %d\n",
+				urb->status);
 		atomic_set(&data->fw_state, S2255_FW_FAILED);
 		/* wake up anything waiting for the firmware */
 		wake_up(&data->wait_fw);
@@ -2187,6 +2189,14 @@ static void s2255_stop_readpipe(struct s2255_dev *dev)
 
 static void s2255_fwload_start(struct s2255_dev *dev)
 {
+	/*
+	 * A previous load attempt may still have a transfer in flight, e.g.
+	 * when s2255_open() timed out and the next open() restarts the load.
+	 * Cancel it before rewriting the shared URB.
+	 */
+	timer_delete_sync(&dev->timer);
+	usb_kill_urb(dev->fw_data->fw_urb);
+
 	s2255_reset_dsppower(dev);
 	dev->fw_data->fw_size = dev->fw_data->fw->size;
 	atomic_set(&dev->fw_data->fw_state, S2255_FW_NOTLOADED);
-- 
2.34.1

