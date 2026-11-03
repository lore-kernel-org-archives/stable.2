Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721680;
	b=wt2zN6t73XVNJU2wyaBOqoL59/0AcDRPw8Tu4osO98F2H1pylVlSO92nGE54ErujhRd3
	 kBMHoY7YRLSMFRVAUbgv33gpJoHBKfdlBkaVhzeI6Z/gTwBltjXANCgccRz6wXx/SYggZ
	 bAuM7dFdEhKVUdtBICbNUGwWexBnzZ0Yprj8a1Sz3ZRfDobwB+TWp8+ikvt4Ow5CiTUh0
	 bL4BiUcnMg43RF+lcb13dD/vEgxKPJw1L8d1Rg/CiW/Vi5QnVvS/M05/IjfjPl59Ep/wz
	 kudHmkXTXlY5mWvyq+oN4h/jhgOOsLaLaBzMitMATh0LMUzVRYoZdMFD5G0/ClGWX4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721680;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=o2IFbUEs3XJWUVAyVa+Z8fFrJArAYqvaopmw5yj/aIw=;
	b=E5lHZrC+MZcRNT2qnr8itt6/ArmplDeflsKs5CoFII38Rn8LOmlQ6O6nsS/Ao4YebVR4
	 5RNUQcttCcD9HF/3wBfPW5F8R9CkZJyxlDXfECfRIMk9PetehSCw4aZ8wirQAjeUezLax
	 /jmXgJn8xz0/bhUIWNIlLQaCOwDKPnQQ+eyQAJNAEaaJW9BCgXH1p/9ivHG0yzpzn2eSt
	 8tf/5wCRUiMjyXmRUjkrquCDe1GOvbyA5phFgkhczgrKNCEMAgsDRugdtsgJq0TE/Whfb
	 x23PEHSLIoI6iSpF7aDJ7/6YRVcxZqQJ42f9AcvUpG/lj85Sc3CoFq8JMzO745d5pJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E14606A335;
	Tue,  3 Nov 2026 16:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E14606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=o2IFbUEs3XJWUVAyVa+Z8fFrJArAYqvaop
	mw5yj/aIw=; b=VEs7IUN9cJ7+6FSHhh2IGdTt2lfgrQeNyqWzBoJmp3GC1gnRa4
	WpZLc9Pb8gzDwpVt4336TczpDYCF6IWMaWRYMaozFenQUMYIapuMNK4Zg0KF48Qz
	NyZ03D+pkdlWWMeVvlR8d4oyodW0sdJqK1uPk/UC8b6MF1CAuFBdNrC1w=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.43])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWHgQ9BepqkKEfAQ--.30199S2;
	Wed, 04 Nov 2026 00:01:03 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v3] usb: xhci: Fix use-after-free race in xhci_stop_device()
Date: Wed,  4 Nov 2026 00:01:00 +0800
Message-Id: <20261103160100.23190-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ca5cced-f429-42d9-9bbb-f5111acd9665@linux.intel.com>
References: <3ca5cced-f429-42d9-9bbb-f5111acd9665@linux.intel.com>
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
X-CM-TRANSID:BLQMCkDWHgQ9BepqkKEfAQ--.30199S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr15XFWDZrW7WrWkKFWUCFg_yoW7Xr1xpF
	43Ja4YkrZrKr12gFn8KrW8XF1rXwsrZ398GryIk348urs8J34rKFy0yrWqkrn3WF97Ar17
	tFn8GFWrua15GF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Jr0_Gr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU8yq2tUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUGD2rop1Xv3wABsM

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

Look up xhci->devs[slot_id] only after taking xhci->lock, and bail out
if it is NULL or if the device is already being torn down.  The
tracepoint reloads virt_dev->udev, so it moves under the lock and only
runs while the device is still attached.

xhci_free_dev() clears virt_dev->udev without xhci->lock, and only
later detaches the device from xhci->devs[] in xhci_free_virt_device(),
also under the lock.  Take xhci->lock when clearing ->udev so that
xhci_stop_device() can rely on it while holding the same lock.
xhci_free_virt_device() clears xhci->devs[slot_id] and frees the device
under xhci->lock, so a device found there while holding the lock stays
alive until xhci_stop_device() drops the lock, after which virt_dev is
not used anymore.

Fixes: be88fe4f4dda93e3 ("USB: xHCI: port power management implementation")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Hi Mathias,

Thanks for the review.  Both points are addressed:

Changes since v2:
 - Moved the xhci->devs[slot_id] lookup inside xhci->lock and dropped
   the separate pointer comparison, so the unlocked read before the
   lock is gone.
 - Dropped the explanatory comment.

I kept virt_dev->udev as the marker for "teardown already started"
instead of adding a disable_slot_pending flag.  It is now written
under xhci->lock, so reading it there is enough to tell
xhci_stop_device() not to queue stop endpoint commands, and it keeps
the change small.

The xhci_disable_and_free_slot() race is left for a separate patch.

 drivers/usb/host/xhci-hub.c | 14 +++++++++-----
 drivers/usb/host/xhci.c     |  3 +++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index b0264bd8577a..9a3437248e04 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -463,17 +463,21 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 	int i;
 
 	ret = 0;
-	virt_dev = xhci->devs[slot_id];
-	if (!virt_dev)
-		return -ENODEV;
-
-	trace_xhci_stop_device(virt_dev);
 
 	cmd = xhci_alloc_command(xhci, true, GFP_NOIO);
 	if (!cmd)
 		return -ENOMEM;
 
 	spin_lock_irqsave(&xhci->lock, flags);
+	virt_dev = xhci->devs[slot_id];
+	if (!virt_dev || !virt_dev->udev) {
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

