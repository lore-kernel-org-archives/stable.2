Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018202;
	b=n6ZsoLA3lHaju8b9mEcwVlDUwa8BRgUh6L39xwi3qd6jTuU5XzdJc4cTUsNB4IGrTqEt
	 6Js2C53EZ0eIxvrgy9CymG6KW0Y8vKst/MZndV/KYsDIao5lfeLGYGepTLFfA7p4POeni
	 mHtiw1/kou8+6W4qneKEp6OZ/XUfpSZsSK6jD+FZIxNbFEla6nxyq4OTxdB1h4d/MymYg
	 tR56qGQ/RzTFp7B5wqUXhlH9B4pHSQCtk3tcV84RHyedQB3ZMQKKefRxxm9YkJvr/AJhl
	 mLlbV8SD9q4I+5RpN0mxAs7rieTMywEly/pJdlrwEmLcrR+2BD7H3sxrmthb5E7IhIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018202;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=kv1D4zw72J04tOcMux0t9A016KuhZdOeedx6n6a7yeU=;
	b=1YzA95nsoJaGQ34l37/GlaFPQuWbHLZ8VuHVtPZWK52pQw5lEhSNqjKe4Ua6CSnWZR5a
	 Ebr5zUqOqsrf3lGVWiokG2pUNqHmJiPXHUulVDu8zWlgbH+hGfToap3o7kF5CPjw841lN
	 ivNXiUDpr/Fv5Ur1QAZEbn6nCxnnZmKPPwsrPF/myp08nBlWeA2GecbOxw/Yq0NByC1Gz
	 2p7RPMPrX5AesykZXpupdSb9W/byvuNSTCZyLBK6ld2Og9WFbO+iLF63YKKeNEXch1HYV
	 svKjEEXCvJMZg7SDteS9piW7p3eVgqjtSIWnfmaI2clPeHTXCYAlxfOw9VZFOYWPWaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813C606A31A;
	Mon, 26 Oct 2026 12:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E813C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=kv1D4zw72J
	04tOcMux0t9A016KuhZdOeedx6n6a7yeU=; b=oje4rCIoa3xrZIA9YSNk+Z1Faz
	RUwwOaOgu7KgYp8CMs0pOb53iKZ4Kh8fsH4i6QKLT4O3DhUKEeEeoKkPSM0UL6Kb
	Ku4k2l+tpDLxdOyKIfxsR1YHF/4nme/xsnllAKWkczKvCAFwbO+QstRepTWZ/lqg
	Z+1v/ezivSPRqeuGs=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.126])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCmygBNSd9q9dDpAA--.50221S2;
	Mon, 26 Oct 2026 20:36:30 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] usb: xhci: Fix use-after-free race in xhci_stop_device()
Date: Mon, 26 Oct 2026 20:36:28 +0800
Message-Id: <20261026123628.7493-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkCmygBNSd9q9dDpAA--.50221S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr15XFWDZrW7WrWkKFWUCFg_yoW7Xry7pF
	45Xa4YkrZrKr12qFn8KrW8XF1rXws7X3yDGFyxu348urZ8J34rtFy0yrWqkrn7uFZ7Zr1I
	qFn8GFZ5uF45GF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxU4l1vUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUSD2reHcC3dwAAsz

A KASAN slab-use-after-free read was observed in xhci_stop_device():

  BUG: KASAN: slab-use-after-free in xhci_stop_device.constprop.0.isra.0+0x395/0x430
  drivers/usb/host/xhci-hub.c:479
  Read of size 8 at addr ffff88804e85d2f0

  Freed by task 585700:
   kfree+0xf8/0x390 mm/slub.c:6566
   xhci_free_virt_device+0x3f/0x50 drivers/usb/host/xhci-mem.c:881
   xhci_free_dev+0x286/0x350 drivers/usb/host/xhci.c:4131
   usb_disconnect+0x6b6/0x910 drivers/usb/core/hub.c:2391
   ...
   usbdev_ioctl+0x6f05/0x86d0 drivers/usb/core/devio.c:2826

  Allocated by task 572283:
   xhci_alloc_virt_device+0x171/0xb70 drivers/usb/host/xhci-mem.c:986
   xhci_alloc_dev+0x475/0x840 drivers/usb/host/xhci.c:4271
   usb_alloc_dev+0xe8/0xdc0 drivers/usb/core/usb.c:661
   hub_event+0x1c82/0x4050 drivers/usb/core/hub.c:5953

xhci_stop_device() reads xhci->devs[slot_id] without xhci->lock and
keeps using the pointer across xhci_alloc_command(GFP_NOIO), which may
sleep.  All callers (the port suspend and bus suspend paths in
xhci_hub_control() and xhci_bus_suspend()) drop xhci->lock before
calling it, so a concurrent usb_disconnect() -> xhci_free_dev() can
clear xhci->devs[slot_id] and free virt_dev under xhci->lock in that
window.  The endpoint loop then dereferences the freed virt_dev.

commit 88716a93766b ("usb: xhci: Fix panic if disconnect") added a
NULL check for this case, but that only helps when the device was
already freed before the check; it does not close the window.

Re-check xhci->devs[slot_id] against the pointer fetched earlier after
taking xhci->lock and bail out if it no longer matches, or if the
device is already being torn down.  The tracepoint reloads
virt_dev->udev, so it moves under the lock and only runs while the
device is still attached.

xhci_free_dev() clears virt_dev->udev without xhci->lock, and only
later detaches the device from xhci->devs[] in xhci_free_virt_device(),
also under the lock.  Take xhci->lock when clearing ->udev so that
xhci_stop_device() can rely on it while holding the same lock.
xhci_free_virt_device() frees the device under xhci->lock, so a
matching pointer while holding the lock keeps virt_dev alive until
xhci_stop_device() drops the lock, after which virt_dev is not used
anymore.

Fixes: be88fe4f4dda93e3 ("USB: xHCI: port power management implementation")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes since v1:
 - xhci_free_dev(): clear virt_dev->udev under xhci->lock, so that
   checking it under the same lock actually synchronizes with the
   store.
 - xhci_stop_device(): bail out with -ENODEV once ->udev has been
   cleared, instead of queueing stop-endpoint commands for a slot
   that is already being disabled.

 drivers/usb/host/xhci-hub.c | 19 +++++++++++++++++--
 drivers/usb/host/xhci.c     |  3 +++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index b0264bd8577a..f4401f2fcea0 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -467,13 +467,28 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 	if (!virt_dev)
 		return -ENODEV;
 
-	trace_xhci_stop_device(virt_dev);
-
 	cmd = xhci_alloc_command(xhci, true, GFP_NOIO);
 	if (!cmd)
 		return -ENOMEM;
 
 	spin_lock_irqsave(&xhci->lock, flags);
+
+	/*
+	 * Callers drop xhci->lock before calling us and allocating cmd
+	 * above can sleep, so xhci_free_dev() may have detached and freed
+	 * the device in the meantime.  It removes the device from
+	 * xhci->devs[slot_id] and clears ->udev under xhci->lock, so while
+	 * the lock is held a matching, still-attached device stays alive
+	 * and keeps its udev.
+	 */
+	if (xhci->devs[slot_id] != virt_dev || !virt_dev->udev) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		xhci_free_command(xhci, cmd);
+		return -ENODEV;
+	}
+
+	trace_xhci_stop_device(virt_dev);
+
 	for (i = LAST_EP_INDEX; i > 0; i--) {
 		if (virt_dev->eps[i].ring && virt_dev->eps[i].ring->dequeue) {
 			struct xhci_ep_ctx *ep_ctx;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5c759ad28199..9e375eb48f38 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4128,9 +4128,12 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	trace_xhci_free_dev(slot_ctx);
 
 	/* Stop any wayward timer functions (which may grab the lock) */
+	spin_lock_irqsave(&xhci->lock, flags);
 	for (i = 0; i < 31; i++)
 		virt_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
 	virt_dev->udev = NULL;
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
 	xhci_disable_slot(xhci, udev->slot_id);
 
 	spin_lock_irqsave(&xhci->lock, flags);
-- 
2.34.1

