Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172305;
	b=t+nLZWOUeOtPncB/sZjTMgsvpDP0p2Ubauwt6uwzYbnxrZ7uzIh+dQF8OKvZDFlWa1Vj
	 6v7L8O9htPc6r0GCCeM0Dl87ehiymnV1xgjmNZ15BtlSworwTlYSG6gx+0Z0Z4mN9vXgb
	 rkB9QO5r1h+SePefQN2ktNeD/1OPB4LnCq4w+165NS6Xj+2TI6498jDeDr2qfLGWnZX+T
	 T4IOmcjwYgnmu7+AZ+9tfEcQxz+6eyfQ9kBuvnDXAu5xRCcl5MQIjnmF0d4DBJ04DzI1H
	 VWzqJBRwZBmeo8FBRHAQqgBzQ1VmzI0ROplVdnWrc3pWms7Thv6x1dsZAnHeUlCUnyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172305;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=yBagZQZhW3t4Jx4qjVtZRY71nILCOps2dDeRDw0jV54=;
	b=RvsrTDbRB/ZTTSbtp8Egv6SjOo17O2RixO5RKPUqKFCdMqQFzJ2TeoJLUAUgijgH51w+
	 /DDWVhg63nS6iPRILqcgtyuXRsbaKlHECPv7IWCjBzvM3WbmMbHb+0nYYX+1sJ4fKNOUF
	 sVi5thNkdAUO8i2FrxNyIPETI9mVLck0NGXXunLkRTINFK5u+ppbnlISmnZHQVZv7eT9N
	 N3WBKgV3m9UBh9cPs0MsefcaQp4R2Vcxw3M9xL3StugFxtk2Us8euPEfaARnPA5Y/7mJn
	 2tQtvwUcimpE5Rn+1X9mDYDeMiYi3lnKkCOg0g0TnhE8YlRaW44rJrlC0Ul7mVEd+QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D9606A320;
	Fri, 20 Nov 2026 10:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A58D9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=yBagZQZhW3
	t4Jx4qjVtZRY71nILCOps2dDeRDw0jV54=; b=fwuS51mzi17Sq6wWNXDQ5gy3lG
	mn+TQCfUYo3y//FMtazC+ofAfLmR+5H73z1qS5ApUBcxNdrJr8nLBUL4KiJnJCEZ
	mdQGnkPelYHLfgWrAZ2pRlcgLu4quCoGWgOBg27wz0y1+/KbarwO1Wk6X/eL+tBo
	hCf+uyeTPcjueJbk0=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkA2XQPAJwBrAY_wAQ--.59502S2;
	Fri, 20 Nov 2026 18:58:09 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: mceusb: fix NULL dereference on disconnect during IR transmit
Date: Fri, 20 Nov 2026 18:58:07 +0800
Message-Id: <20261120105807.8166-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkA2XQPAJwBrAY_wAQ--.59502S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1UZrW3WF1kXw1fKFWkCrg_yoW8ZFyDpF
	W8KFWSyFWDKF4DKr4DAanru3WUAws3GayxCry09wn09rs8Aa4qka4kKayDG3sxArW8A34j
	yF98A3y7ury5CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x07jnPEfUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUDD2r-E0ndsAAAsp

mceusb_dev_disconnect() clears ir->usbdev before unregistering the rc
device.  An IR transmit runs mceusb_tx_ir() under rc_dev->lock, and a
single lirc write may issue several mce_write() calls, each of which
waits up to USB_TX_TIMEOUT for the URB to complete.  If the device is
disconnected while such a write is in progress, the next mce_write()
passes the now-NULL ir->usbdev to usb_fill_int_urb(), which
dereferences it:

  general protection fault, probably for non-canonical address
  0xdffffc0000000003
  KASAN: null-ptr-deref in range [0x18-0x1f]
  RIP: usb_fill_int_urb
  RIP: mce_write
  Call Trace:
   mceusb_tx_ir
   lirc_transmit

A write that starts after ir->usbdev has been cleared but before
rc_unregister_device() marks the device as unregistered can hit the
same NULL pointer.

rc_unregister_device() sets dev->registered under rc_dev->lock and
waits for an in-flight tx_ir() to finish, so clearing ir->usbdev
after it returns closes both windows.

Fixes: d8b4b5822f51 ("[media] ir-core: make struct rc_dev the primary interface")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/rc/mceusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index 39ba7f6a2549..645ce0d0cbc6 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -1844,9 +1844,9 @@ static void mceusb_dev_disconnect(struct usb_interface *intf)
 	if (!ir)
 		return;
 
-	ir->usbdev = NULL;
 	cancel_work_sync(&ir->kevent);
 	rc_unregister_device(ir->rc);
+	ir->usbdev = NULL;
 	usb_kill_urb(ir->urb_in);
 	usb_free_urb(ir->urb_in);
 	usb_free_coherent(dev, ir->len_in, ir->buf_in, ir->dma_in);
-- 
2.34.1

