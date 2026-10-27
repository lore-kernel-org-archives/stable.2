Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065327;
	b=oTHEnqZ6qUXW/Hk3DW/LnqsYVAOV+ydh3szDDMDlZEgygCY4DORfceER1RfmZiUrzZaS
	 FVWX3deGlUFWxD5neFeOo2FOKjJTEJumKVc6cgifhwO0nAvawlljTaz6wb+Zw5IGWZ7CY
	 0E6o0pkZOsMQ7pLssURJXvHWSlbFR1IeAiKdaquKOW/LE3PiGDaS/Qq6GVgf2tvW9DzsX
	 4jp3J9bwY3m1dd0a8a+kxugehlEQ2n3v/VRD8cjzI3GUEKpc9RO7qGQRcwB86y+WGLfP9
	 WK7RT23ypo7I0/cRbQ5QwzhYQFaUCSB9G2xQ6Ivg5FxuSQn/+jOg2Z9KozyGtw6RTfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065327;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=QPrihA68+s7bx9jPC5nNtA5h81Z0wGgJQ69n7dzB+zg=;
	b=vCpkcZIf84BR2caN87fC2sbgKXLBSz0sP/cncGqQAqnZWY8mtTGwPyPVJqCdMwPO5Vwn
	 T9aBl6ucCmTSdE82tiDmOIkSjHbChrcpdpT/ecQzzNI31MkXior6VcbViPHXgcPu293m9
	 Ta1uvO7Fj30tIaTG59EYSxueSiBh7l93BHYDAHnD0FuMTXG4r4ESWTa8rlFLBL/adOxjc
	 74VHMV/3XhoNa3YTwjc7G43uUMkubQKK6mDvRqgvroLg/pF9dS1Fd8K0SJkAeI/Ky26Iw
	 K3zNofp+75P5hLj90z2B50t1pSwmJhBa+DYbkXAFUWLtkS86cFRvctBkd2dVT3Uk+KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D13606A31A;
	Tue, 27 Oct 2026 01:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D13606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=QPrihA68+s
	7bx9jPC5nNtA5h81Z0wGgJQ69n7dzB+zg=; b=aJWRJ5Pr668VyEYwztZVjQl2v7
	ezuQcdj6N58AZdu+Z0QLK0xhJb4u4UM7+MnAlflrQUoVLs1n8ZQU74CH42Et9oPZ
	6c3eL01nv6mAGlz3QPMQm7Q/EW1+GuCwONUWGxGBDM53S5zXAU8aPByjwjBLKcPN
	PZYPPhoYUqJnLxjh8=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCGrwVYAeBqGKLsAA--.50649S2;
	Tue, 27 Oct 2026 09:41:45 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: =?UTF-8?q?David=20H=E4rdeman?= <david@hardeman.nu>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] media: rc: fix use-after-free of rc_map.name on register error path
Date: Tue, 27 Oct 2026 09:41:44 +0800
Message-Id: <20261027014144.9144-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkCGrwVYAeBqGKLsAA--.50649S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr15AryftF4xGryDArW5ZFb_yoWrXF43pa
	n5Wa4rtryjgrsrWr47Xw42qa4rua1Iy398Zry8Kw1q9FZ3Ary3tFZ5JFyUCa4UJry0yFW3
	tFW5J3y8uayUuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUcID7UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2rfb0FCrgAAss

If rc_register_device() fails after device_add() - for example when
ir_raw_event_register() cannot create its kthread - the unwind path
frees the keymap via rc_free_rx_device() while the device is still
visible in sysfs, and never clears dev->registered.

A userspace reader of the uevent attribute then enters
rc_dev_uevent(), passes the registered check under dev->lock and
dereferences the already freed dev->rc_map.name:

  BUG: KASAN: slab-use-after-free in string+0x483/0x4c0
  lib/vsprintf.c:737
  Read of size 1 at addr ffff888007ca9d80
   rc_dev_uevent+0xd7/0x1d0 drivers/media/rc/rc-main.c:1628
   dev_uevent+0x28d/0x570 drivers/base/core.c:2709
   uevent_show+0x1af/0x380 drivers/base/core.c:2756

Fix it the same way rc_unregister_device() does: take dev->lock,
close the input device if it is still open and clear
dev->registered before releasing any resources. rc_dev_uevent()
then observes the cleared flag and returns -ENODEV instead of
reading rc_map.name. The same sequence is also needed when
rc_setup_rx_device() fails: lirc has been registered by then, so
an open /dev/lircX file descriptor would otherwise keep calling
driver callbacks that access the torn down device.

Fixes: f56928abaa6d ("[media] rc-core: cleanup rc_register_device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

---
v2:
 - Clear dev->registered on the rc_setup_rx_device() error path too;
   lirc is already registered there and open file descriptors can
   still reach driver callbacks.
 - Factor the lock/close/clear sequence into rc_unregister_device_state()
   and share it with rc_unregister_device().
---
 drivers/media/rc/rc-main.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index dda3479ea3ad..3ac5d532c6dc 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1888,6 +1888,24 @@ static void rc_free_rx_device(struct rc_dev *dev)
 	ir_free_table(&dev->rc_map);
 }
 
+/*
+ * Prevent userspace from accessing a device that is being taken down.
+ *
+ * The uevent attribute, the lirc character device and the input device
+ * all check dev->registered under dev->lock before using driver data.
+ * Clear it while still holding that lock, and call dev->close() for an
+ * input device that is still open, exactly as rc_unregister_device()
+ * does, before the resources they use are freed.
+ */
+static void rc_unregister_device_state(struct rc_dev *dev)
+{
+	mutex_lock(&dev->lock);
+	if (dev->users && dev->close)
+		dev->close(dev);
+	dev->registered = false;
+	mutex_unlock(&dev->lock);
+}
+
 int rc_register_device(struct rc_dev *dev)
 {
 	const char *path;
@@ -1954,8 +1972,10 @@ int rc_register_device(struct rc_dev *dev)
 
 	if (dev->driver_type != RC_DRIVER_IR_RAW_TX) {
 		rc = rc_setup_rx_device(dev);
-		if (rc)
+		if (rc) {
+			rc_unregister_device_state(dev);
 			goto out_lirc;
+		}
 	}
 
 	if (dev->driver_type == RC_DRIVER_IR_RAW) {
@@ -1970,6 +1990,7 @@ int rc_register_device(struct rc_dev *dev)
 	return 0;
 
 out_rx:
+	rc_unregister_device_state(dev);
 	rc_free_rx_device(dev);
 out_lirc:
 	if (dev->allowed_protocols != RC_PROTO_BIT_CEC)
@@ -2024,11 +2045,7 @@ void rc_unregister_device(struct rc_dev *dev)
 	timer_delete_sync(&dev->timer_keyup);
 	timer_delete_sync(&dev->timer_repeat);
 
-	mutex_lock(&dev->lock);
-	if (dev->users && dev->close)
-		dev->close(dev);
-	dev->registered = false;
-	mutex_unlock(&dev->lock);
+	rc_unregister_device_state(dev);
 
 	rc_free_rx_device(dev);
 
-- 
2.34.1

