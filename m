Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627145;
	b=ulzHJMYOBy4I9fv5f4SJjQckf5WsApR9oK7P21X9kqCS49QWZTzzQjSuWaX9cr/bql+T
	 kHQNYiEspYItgn/T3BIqaQYHd++Up3pXbTMFTzzjbgw1bhGOXUrmWSA4QlH0wf7GGd9Il
	 k+G2r87aFKxSaZrYSG6gmPWqrpMRDHyWyh9Dg07zgvX7Hh3n/vbD3jqyJSfo1b/BDV8B4
	 CkLNtfsPQDRyDkkqOQ83htUXVEcGLD0SlsdemPkmBuEXNBlrjFyiYcnhWZXF/ezSqZMNm
	 vOTCHl6afzxIeJib2QyIHEEw4pgpS/rc+ispljRW+HE1Dr03h7bebqmvscc1wV0hvsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627145;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=wAjHvNUqvta+sdWtgkRMRvCccI4IjDkWJMkgjZPZg3I=;
	b=XBPWSKT+jaPwdzA3YlIhhOTExgH7Z21SfjEwUlO0Txv9nbNU0fc/a852HDz8+5SifjTV
	 J5TIfOfFcPo4zX+ivatGhleSJwDDREi2EFpfJo9zmGnKNlb0mixL8vxCnPf5RvOd6Zsa8
	 94wnR5gpnLNWTI+9Ri9EG+FHzQIru+el/XhwGE1+MrU3O2tcSNwbHhhQezbzXI7VZyeBD
	 heG+7sM3+ouIsgez7bJAlrO8/GLgzTCy8sI/WZI18UBvmEEcDsu6QGa2cZdzib9DBNlFF
	 aJrE+UJRAxywXqki14yvugdg0AJjnAQPmSufxX+rp5OYGj7Q+onObNZrMZNYlUmBkLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC33606A327;
	Mon,  2 Nov 2026 13:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC33606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=wAjHvNUqvt
	a+sdWtgkRMRvCccI4IjDkWJMkgjZPZg3I=; b=4rM3iPsDSb9boXQ6brm7+db4tg
	PHVq8i1cborxOF9RPrTxKkFecZcykXFwPEd3HIx+Ua9wzmvx2LwJmgBBXqh35fRk
	nPEJAA4Rf+Vz2tAKF4WDLnb9R0NKw2s14GysDlvBkK3oCkkRnqvqMmYIVhLcO59m
	+WshH5hKes0PLF45c=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBWnAH3k+hqs8kZAQ--.13514S2;
	Mon, 02 Nov 2026 21:45:29 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: au0828: hold the vb2 queue lock when releasing the queue on close
Date: Mon,  2 Nov 2026 21:45:27 +0800
Message-Id: <20261102134527.14486-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBWnAH3k+hqs8kZAQ--.13514S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kCrWrCFW3AFyfAw43KFg_yoW8ur1Dpa
	95KrWjk395Xr4UWwsrXa1293Wru3Z8uFW0kry7ta1Svr1rZFyIvr1Fyw4jvrWUZ3s7Aw4j
	qayDtrWakrWUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxU4zBTUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rnVdS+DAAAsw

au0828_v4l2_close() releases the vb2 queue with _vb2_fop_release(filp,
NULL) while holding dev->lock. The video and VBI queues have their own
locks (vb_queue_lock and vb_vbi_queue_lock), and v4l2_ioctl_get_lock()
serializes the queue ioctls with those instead of dev->lock. The queue
can therefore be released on close while another file handle is in the
middle of VIDIOC_REQBUFS or read().

__vb2_queue_alloc() adds each buffer to the queue before allocating its
planes, so the release can find an MMAP buffer whose mem_priv is still
NULL and hand it to vb2_vmalloc_put():

  BUG: KASAN: null-ptr-deref in vb2_vmalloc_put
  Write of size 4 at addr 0000000000000020
  Call Trace:
   vb2_vmalloc_put
   __vb2_buf_mem_free
   __vb2_queue_free
   vb2_core_queue_release
   _vb2_fop_release
   au0828_v4l2_close

Pass the queue lock to _vb2_fop_release(). Taking it while holding
dev->lock matches the lock order the driver already uses in its
unregister path, where vb2_video_unregister_device() takes the same
queue lock.

Fixes: 05439b1a3693 ("[media] media: au0828 - convert to use videobuf2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/au0828/au0828-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
index 3c53105f3d2b..e3f894d67d7c 100644
--- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -1094,7 +1094,7 @@ static int au0828_v4l2_close(struct file *filp)
 			pr_info("Au0828 can't set alternate to 0!\n");
 	}
 end:
-	_vb2_fop_release(filp, NULL);
+	_vb2_fop_release(filp, vdev->queue->lock);
 	dev->users--;
 	mutex_unlock(&dev->lock);
 	return 0;
-- 
2.34.1

