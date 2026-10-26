Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011951;
	b=INMQmauV9v1YdUhtDPYbFsXIUd+rvKpOrQBFydd2ohIdaiEp/k3LkUEwVxBpsRA76t+d
	 VdLbfl29mjj0iDrn3nxJer/9YwU2giOcZFpiPQJuSh3UN7ZZfkKizhAtVuBCfCWG6ZHIN
	 OKyE6Mw+Bq81XIKF4bNHEPvSFutTlDOWvgWPGQBzwTMP/0DNPZlnxRGozygJlxRwzYw6U
	 fLJv9EwhOj/z9aFZiH1Zhdpo4o1PHbyFvL16YwD6JEgrBf9sfyO7PuyCo6qvMoAem48jA
	 Y982owLCoLR3RI9a2Kdb0XCB1TOrKCmgdHVmBzmct/VI4gr/Nv/YVbvf/Ffytlyd6MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011951;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=AQy2Dahtoc1vS64zM/q2064E7p7snqqcln1PMUtXXJo=;
	b=HYbWrKQyrCiHEqm04dVEz/d8gCamWixh+PQRk9mSA97KqJjxLMV4QwWl+tCkZisa7Q+J
	 47KxNGUTcI8mk/wf2Z415eUZjE+jR1AF32hxNWENANvmpmC6vlCXI9Q/pvg8j4aDGMYb+
	 LLfcd5E2jsG3GULc3V0KFIe88GLNni4lyeRFTkufzMUzfmb4vVFRcRxr0FqSJnosGlS6s
	 lcAY4aGs+tJDSEX6YfMCswN8EyCa69ab+Gce3iiOIEfwXXDohyn0uWIxl4xBNylhnXhZR
	 flvnNJjWxduTvQRvA3yFC90O6SQDtV7cX/0elRe7pee/AD/g726HzEO47EtWHYQMxIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D2606A327;
	Mon, 26 Oct 2026 10:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C16D2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=AQy2Dahtoc
	1vS64zM/q2064E7p7snqqcln1PMUtXXJo=; b=AvoL+hhVnJEQTZGOIuDMCxm3pV
	UKqpBEt4XPu8LYxSfYzrCoxRcqBu8fKKIhV0yU3X1QjHT6YMaIpSsvn7ea01J910
	em9EGc32CiJV31oEzKiRCnYBXtNUiwgWeaNIzbSHS/7pEAG1glsgJaWNkpl/l3ff
	uasfRcBcz2LezBHHU=
Received: from localhost.localdomain (unknown [113.200.174.126])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBmpfrhMN9qL0jpAA--.46778S2;
	Mon, 26 Oct 2026 18:52:18 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] usb: xhci: Fix use-after-free race in xhci_stop_device()
Date: Mon, 26 Oct 2026 18:52:03 +0800
Message-ID: <20261026105203.1250-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
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
X-CM-TRANSID:BLQMCkBmpfrhMN9qL0jpAA--.46778S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArWfKr1Dtw18Zry7Zw43Wrg_yoWrGFykpF
	43Ja45CryUKr1agFs8Kry8XF1rAws7Z3yDWryxW34UursxJryrKFySyrZ09wn7ur97Ar17
	tFn8GFWruay5GF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjxUcID7UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUSD2reHcClDgAAsY

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
taking xhci->lock and bail out if it no longer matches, and trace the
device only while udev is still attached.  xhci_free_virt_device()
frees the device under xhci->lock, so a matching pointer while holding
the lock keeps virt_dev alive until xhci_stop_device() drops the lock,
after which virt_dev is not used anymore.

Fixes: be88fe4f4dda93e3 ("USB: xHCI: port power management implementation")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/usb/host/xhci-hub.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index b0264bd8577a..f058cb4d3534 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -467,13 +467,31 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
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
+	 * above can sleep, so xhci_free_dev() may have freed the device in
+	 * the meantime.  The device is detached from xhci->devs[slot_id]
+	 * under xhci->lock before it is freed, so re-check under the lock
+	 * that this slot still points to it.  The device cannot be freed
+	 * while xhci->lock is held, and virt_dev is not used after the
+	 * lock is dropped below.
+	 */
+	if (xhci->devs[slot_id] != virt_dev) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		xhci_free_command(xhci, cmd);
+		return -ENODEV;
+	}
+
+	/* xhci_free_dev() may already have cleared udev without the lock */
+	if (virt_dev->udev)
+		trace_xhci_stop_device(virt_dev);
+
 	for (i = LAST_EP_INDEX; i > 0; i--) {
 		if (virt_dev->eps[i].ring && virt_dev->eps[i].ring->dequeue) {
 			struct xhci_ep_ctx *ep_ctx;
-- 
2.34.1

