Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA393A5E7D;
	Sat, 17 Oct 2026 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235376; cv=none; b=alRTWETGAJQZdsOzNWPmjmcbwi+qLaMOvf1fFFrifEcMfbwnkgRAazsF9l0ElXjIPF+76Q2AqCZfAk1i5ltU1G9/JQuyNqVjM4YhlCJOLSC8TMwEESCmDWbKFaMpWwzXtwyS3gq6W1Uut4x7NKuEQFlGcdn26iF1Qh2jV8o1wuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235376; c=relaxed/simple;
	bh=vq3XskGd5/NEL9F2R+co2lZrTdDplK8LSUgUejA9+Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsCDrxpxLcE+nhSQNmJu8924DvvLBTYuxWDYnDwvb5THegN04spxV1/McsqV/QKM6IP73kdS7IUXFZg3ABk0rZ9tv9DVEI90uNmbOkkpYluxHwoJd9UKQ/D3dXgKqnbDaG0KSAIBGyOXABNK6Cu+jo+QtiYDza85KSopPbIchOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=ZTWig6an reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="ZTWig6an"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=euKsPWoPPN
	1GGIGw7L6gA2kcWywSeniW95HwwIIekuQ=; b=ZTWig6annewuswySUuwjY4/VBP
	OaAAYM1896a4vJOnvbm1EAU0n9+mBsdSoPWvWI+xfgs0urIxFYMfuPWbmIlle1dp
	2Zpfw+ltZGEdcVqR/7iAIJ8SVrt1htLMe6p4U7DQEAQSrvEu8Qx6XLjdKelzX4Xu
	sPEdTYL54hAGEo1qM=
Received: from localhost.localdomain (unknown [113.200.174.50])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCW2wBZV9Nq7bevAA--.18105S2;
	Sat, 17 Oct 2026 19:09:15 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Anssi Hannula <anssi.hannula@iki.fi>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: rc: ati_remote: fix NULL input_dev on rc device open
Date: Sat, 17 Oct 2026 19:08:59 +0800
Message-ID: <20261017110859.1429-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCW2wBZV9Nq7bevAA--.18105S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw48KF13Gr43ZF48AF1rXrb_yoWrZF1kpF
	WfCayFgFWkJryjgw43Kw1UZa45Wa1xZayrur1fXw1a9rs5Zr9YyFyDtFy7JayUAFy09ry5
	tw15J3y8uFyUAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ZiSPUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUJD2rSQD2CnwAAsZ

ati_remote_probe() registers the rc device before it allocates and
assigns the mouse input device:

	rc_register_device(ati_remote->rdev);
	...
	ati_remote->idev = input_dev;

The rc device can be opened as soon as it is registered, either through
its evdev node or through /dev/lirc0; both call ati_remote_open(), which
submits the interrupt URB.  The completion handler ati_remote_irq_in()
reports the events it receives through ati_remote->idev, so a report
that arrives before the assignment above is passed to input_report_rel()
and input_event() as a NULL device:

	BUG: kernel NULL pointer dereference, address: 0000000000000028
	#PF: supervisor read access in kernel mode
	...
	RIP: 0010:input_event+0x41/0xa0 drivers/input/input.c:394
	...
	Call Trace:
	 <IRQ>
	 input_report_rel include/linux/input.h:450 [inline]
	 ati_remote_input_report drivers/media/rc/ati_remote.c:634 [inline]
	 ati_remote_irq_in+0xf45/0x1420 drivers/media/rc/ati_remote.c:657
	 __usb_hcd_giveback_urb+0x238/0x550 drivers/usb/core/hcd.c:1657

input_event() dereferences the device it is given and the faulting
address 0x28 is the offset of evbit in struct input_dev.  ati_remote is
zeroed when it is allocated and ati_remote->idev is never written back,
so the pointer is NULL because it has not been assigned yet, not
because an input device was freed.

Allocate and initialize the mouse input device before the rc device is
registered, so that ati_remote->idev is valid before any path that
submits the interrupt URB exists.  input_register_device() keeps its
place: input_event() is documented to be safe before registration, the
events are then simply not delivered to any input handler.

Fixes: c34516e599d9 ("[media] ati_remote: migrate to the rc subsystem")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/rc/ati_remote.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/media/rc/ati_remote.c b/drivers/media/rc/ati_remote.c
index 51d85de24fae..393717fbecc7 100644
--- a/drivers/media/rc/ati_remote.c
+++ b/drivers/media/rc/ati_remote.c
@@ -813,7 +813,7 @@ static int ati_remote_probe(struct usb_interface *interface,
 	struct usb_endpoint_descriptor *endpoint_in, *endpoint_out;
 	struct ati_receiver_type *type = (struct ati_receiver_type *)id->driver_info;
 	struct ati_remote *ati_remote;
-	struct input_dev *input_dev;
+	struct input_dev *input_dev = NULL;
 	struct device *device = &interface->dev;
 	struct rc_dev *rc_dev;
 	int err = -ENOMEM;
@@ -893,23 +893,34 @@ static int ati_remote_probe(struct usb_interface *interface,
 	if (err)
 		goto exit_kill_urbs;
 
-	/* Set up and register rc device */
-	err = rc_register_device(ati_remote->rdev);
-	if (err)
-		goto exit_kill_urbs;
-
-	/* Set up and register mouse input device */
+	/*
+	 * Set up the mouse input device before registering the rc device:
+	 * opening the rc device submits the interrupt URB, and its
+	 * completion handler reports mouse events through
+	 * ati_remote->idev, so that pointer has to be valid before the rc
+	 * device can be opened.  input_event() may be called before
+	 * input_register_device(); such events are then simply not
+	 * delivered to any input handler.
+	 */
 	if (mouse) {
 		input_dev = input_allocate_device();
 		if (!input_dev) {
 			err = -ENOMEM;
-			goto exit_unregister_device;
+			goto exit_kill_urbs;
 		}
 
 		ati_remote->idev = input_dev;
 		ati_remote_input_init(ati_remote);
-		err = input_register_device(input_dev);
+	}
 
+	/* Set up and register rc device */
+	err = rc_register_device(ati_remote->rdev);
+	if (err)
+		goto exit_free_input_device;
+
+	/* Register the mouse input device */
+	if (mouse) {
+		err = input_register_device(input_dev);
 		if (err)
 			goto exit_free_input_device;
 	}
@@ -919,7 +930,6 @@ static int ati_remote_probe(struct usb_interface *interface,
 
  exit_free_input_device:
 	input_free_device(input_dev);
- exit_unregister_device:
 	rc_unregister_device(rc_dev);
  exit_kill_urbs:
 	usb_kill_urb(ati_remote->irq_urb);
-- 
2.34.1

