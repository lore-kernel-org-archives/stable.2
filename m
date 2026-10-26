Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019488;
	b=RrQ04w9klaRPxztGKE5sZloUaYAkvzahyZH6G4X4YzbP5ToJGUVf59VDlslWpLN0jY4p
	 oNUAmxdD2IeDAjM3fH8YEiypFWAto3KK2BDByLO3IKYMZscVBvs0CHCdn36gkhVNp09bM
	 5D/1l7G+t1ZKjzme9HjBjmSfgYNhMvU25f2MptLlB8M+7w0ZhGTX49PINbgr8JHyQHGg3
	 +fdpjER1BMbRkWqG6JZ0CNhnfh9N1ITVfBKoRW8bmIXHy/8DnJiAxP5O2BxvhXrYjiYPd
	 +PKgAqOw+AMx3r5QNmr7fgDC7CLQTTmnJqan/F+3JwaHLNz6UHgbYYTKO9qR7GfFRcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019488;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=lZl2kSIwMNJIkCLglscnuCt3O0TybLkz70TCo4UfuW8=;
	b=VQYJtZPwIKc0GZ4DOurzqF42SDPy4uCiogBy15GoA1Hbm+9EbFgcPcC/4MIZShEm4ffQ
	 l2DhzwxWmQHDpIqAws5eE8IXG9yzZ9dhdhQ9sG4TYp9vM9AmpxAFXaPgIKF0EZjMnVAI8
	 m0iQZ6Ew9XA1WPTUKQkG02QlNHTjAHOg/XJW+vvrZ1oHBIkTrUjkzE0Fi179KT894+Jlf
	 CHmpkkarHpruO/gZFRmJ4Hizb4EMoEDEgW2HmVXhQB46BtMQM69VmIggrJbnK+jNT6Hrz
	 +bMZK/u805B69IcWdMyEa+nJftDTzsA7moThgXE25CPK9nJa0jdgMPk6cps0aG7qlIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C1606A320;
	Mon, 26 Oct 2026 12:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E74C1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=lZl2kSIwMNJIkCLglscnuCt3O0TybLkz70
	TCo4UfuW8=; b=QnuhWUjtE04W8Eoe0tqGvEFE7Xfm/3dcmvnasdLILAqeUb7rpt
	7coohlYSPBm6VCWKOcEyssZ22tW8TunkOBzSdMwM79TPZoZE94kcsf7L3vMBBgbZ
	2OAShrz/F2w6yKmaBeOp/V08WICmWrzdEizTepwh/d9VAm8tYZGezE9J4=
Received: from localhost.localdomain (unknown [113.200.174.126])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWGwFJTt9qbqzpAA--.7289S3;
	Mon, 26 Oct 2026 20:57:51 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Anssi Hannula <anssi.hannula@iki.fi>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] media: rc: ati_remote: fix NULL input_dev on rc device open
Date: Mon, 26 Oct 2026 20:57:30 +0800
Message-ID: <20261026125731.1952-2-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261026125731.1952-1-25031212351@stu.xidian.edu.cn>
References: <20261026125731.1952-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkDWGwFJTt9qbqzpAA--.7289S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw48KF13Gr43ZF48AF1rXrb_yoWrKF1fpF
	W3CayFgFZ5Kr1jga13Kw1UZa45Wr4xZay5ur1fX34a9rs5Zr9YyFyDtFy7JayUAFy09Fy5
	tw15J3y8uFyUAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62
	kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2
	z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
	0En4kS14v26r126r1DMxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07j4dgXUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUSD2reG1O7tQACsp

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

Free the input device only after the rc device has been unregistered and
the URBs have been killed, so that a completion still in flight cannot
report through an input device that is going away.

Fixes: c34516e599d9 ("[media] ati_remote: migrate to the rc subsystem")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/rc/ati_remote.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/media/rc/ati_remote.c b/drivers/media/rc/ati_remote.c
index 51d85de24fae..8543612d5a60 100644
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
@@ -893,37 +893,47 @@ static int ati_remote_probe(struct usb_interface *interface,
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
+		goto exit_kill_urbs;
+
+	/* Register the mouse input device */
+	if (mouse) {
+		err = input_register_device(input_dev);
 		if (err)
-			goto exit_free_input_device;
+			goto exit_unregister_device;
 	}
 
 	usb_set_intfdata(interface, ati_remote);
 	return 0;
 
- exit_free_input_device:
-	input_free_device(input_dev);
  exit_unregister_device:
 	rc_unregister_device(rc_dev);
  exit_kill_urbs:
 	usb_kill_urb(ati_remote->irq_urb);
 	usb_kill_urb(ati_remote->out_urb);
+	input_free_device(input_dev);
  exit_free_buffers:
 	ati_remote_free_buffers(ati_remote);
  exit_free_dev_rdev:
-- 
2.34.1

