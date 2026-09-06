Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AE366542;
	Sun,  6 Sep 2026 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712003; cv=none; b=JM1Kc5LX1K9dD5GLdtqdnqF557HYgFjmQmj+hj8HrC9TfPehOhPd513TN6FSAWys3n9f8hsXpyrh5DHQKkAYWbbc6l4LyovqNdKS+nvawiczfNeyxdMSSGoe48RBwuOBKqKjH0Ejr6ZR3ip10TWWzrbiOKdpMDzsFh6bPbz5M3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712003; c=relaxed/simple;
	bh=XJdjMUVCftFBMMiEi003iBcikmZDE5mweCyGJKfSxuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rzhi7FOgLoskkG0oeWB2ojfibnfYhV3P99gZx3mHngO8WYtYsYlScUkeFSB04CRdCMJQGnvuDM2ARc1a0X1nLUi5rBCI4mI2/AyrV6aISVXWAgtASTVbIO8CHvQxuCSl+WBcvS1MiK6xLZAA3Yrk+BItfmZUm0o9KxjxmIPgRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com; spf=pass smtp.mailfrom=ugreen.com; dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b=bBTZTZ2C; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b="bBTZTZ2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1788711981;
	bh=XLgE1BWZQcirBHc+iAqWZqWGaNQfMqPqb7W8sbLZEds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bBTZTZ2C6CNicTyDoR6l7L8enCwVpmUqL6KFndrbBuMZUAXwQJlZt2eN+2EaRPPcI
	 vrLX16OPDQGCpCbhekSPLVLfVa7MdETbO1TX+EtzknV+qUz8DUvKqcbsDHtjLaYnQk
	 NgowPqtrGkN+4qRI7jNz2m88RxULLSvOCbgw+ELE=
X-QQ-mid: zesmtpsz3t1788711979tc1ff63a2
X-QQ-Originating-IP: UhAUtab69h2sGqbP0Vin8ZKayYmnrnRDTPaw3PRVB4s=
Received: from 9DFG3.ugreendc.com ( [61.172.236.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Sep 2026 00:26:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14850577790075968854
EX-QQ-RecipientCnt: 6
From: Haowen Bai <calvin.bai@ugreen.com>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haowen Bai <calvin.bai@ugreen.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: pci-quirks: abort xHCI handoff if MMIO is inaccessible
Date: Mon,  7 Sep 2026 00:26:14 +0800
Message-ID: <A8558181A93455E3+20260906162614.26940-1-calvin.bai@ugreen.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NcfXIs+Ms1qHQLnO4odoRZd3h1LIqnq4lXo57MTDipchhGvNRJNRs2+5
	TWMALC48SCXRnbV5xMJ0p7250gmU7piDY1X7yjctJQ1PvHkV5R/fBgQ7vJzWf+5t4Khlyhw
	8/pNeKskLlKjg1hxsT244WYlYf2VazUm9LFTCa7JFmv09nl8gs8Wi5Z+WnsJzL/oS+yijq4
	5JysJPIYTWuL5BswqVJWBG+slAviPwSQCmj/6yHsuIQGzGl86WKTGBhu/WQZPGn+h8omMxP
	WoWw5OkyXpqZb4YGdSjnv9Up6Upwt2Vca/YsphRvh2kNpHIDQ+55p8TFOtodKD85CoJtsWP
	SHRIe7kHOw+WVlPERfVu3/2rx6mFpOfFiLJW+oVvEYX9XJ+wo1ccRrXIgaqPoZra5B/i2+3
	D+ywCscVzKqn2O7tzfUwNivC76/a+FTcHa0N82bCd8hR6AJMZGcKbSfCCWMF+k0okBONpzI
	7nW0OBf5GVl2zXlTmQTZMIYkhqVXHlmmiz1OkhlhqLkod8cqlclRqrGSP1pdypjn9xi26uT
	GyrN5Br344RFYymJn7htOhXFKL5aVPL4xjABx9y7FzJ2CLRmQ7rfl6PxHuieKEFseoqoVCf
	TibC5JIcRTvEugPeRF34SKJPAp2kFTJTSkJRSxKOKiAPOJOzRjc9hYllUSaLBxOHuplmQz7
	2+v2NWEnXbW74zWVtO7RGtkJJZMvqn17r2c6boGO3Ln5rRYl49WknfqerCFhgGz0RIY6m7h
	27vS0qHtqv4iL4iLmvaPX7nrLWceelXzGBdT1WNjDowXOOE014gogJST+VnJ6qkt/63HpOz
	zbv/5V11LfRJ//Lpb+40BoSplgln+DXOhA3xD0grXckoodPAaa/WCf4Na0GVop05OeUpoF6
	kSgY3A9FEmWoKiQX+sbsKJIehCD88YOZ8Wg9kTIBSbXqUt1JWWKEe9wvszi6wU8bhchd3oX
	RDQ0MKJd/I9IoOL1Y7qQcw5yETB8N2M+Ysz7MuKobYPPMVJRWid39uZOxnLp4XXNGWfxv54
	ujFwDN+AoM9fijLe4P
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The xHCI early handoff quirk polls the BIOS ownership, CNR, and HALT bits
with readl_poll_timeout_atomic(). Unlike xhci_handshake(), handshake()
does not treat an all-ones read as an inaccessible controller.

If the controller becomes inaccessible, readl() can return U32_MAX. The CNR
bit then never clears, and the atomic poll keeps retrying. The atomic poll
budget is decremented using the requested delay and loop iterations, but
not the time spent in readl(). Slow failed MMIO reads can therefore keep
the PCI hotplug thread spinning far beyond the nominal timeout and trigger
a soft lockup. The 26-second value in the first warning is the watchdog
threshold, not the handshake timeout; repeated warnings showed the thread
still stuck up to 260 seconds before a controlled reboot, leaving the
system unavailable to normal management. Comparing the watchdog timestamps
with the RBP loop counter in the dumps (about 1,372 iterations in 26 s and
15,638 in 260 s) implies roughly 16-19 ms per polling iteration, despite
configured 10 us delay; these values are inferred, not direct measurements
of an individual readl().

Return -ENODEV when the polled register reads U32_MAX and stop the handoff
before issuing further accesses. This prevents an inaccessible xHCI from
keeping the PCI hotplug thread busy and making the system unavailable. An
eGPU may still fail to enumerate, but that failure must remain controlled
rather than causing a kernel Soft Lockup and taking down SSH or desktop
management. The existing timeout behavior for non-all-ones reads is
preserved, matching xhci_handshake().

A Thunderbolt-attached AMD Radeon Pro W5700 in a Razer Core X enclosure
reproduced this on an x86_64 UGREEN DXP8800 Plus with an Intel Core
i5-1235U. The GPU's xHCI function 0000:06:00.2 (1002:7316) triggered
the soft lockup in irq/123-pciehp; the register dump contained
RAX=U32_MAX:

  watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [irq/123-pciehp:139]
  RIP: 0010:quirk_usb_early_handoff+0x552/0x7e0
  register state: RAX=00000000ffffffff

The call trace was:

  pci_do_fixups
  pci_bus_add_device
  pci_bus_add_devices
  pciehp_configure_device
  pciehp_handle_presence_or_link_change
  pciehp_ist
  irq_thread_fn

The failure reproduced on two hot-plug attempts and did not occur when the
enclosure was connected before boot.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Cc: stable@vger.kernel.org
Signed-off-by: Haowen Bai <calvin.bai@ugreen.com>
---
 drivers/usb/host/pci-quirks.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0404489c2f6a..e5ddd33c734d 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1026,15 +1026,22 @@ static void quirk_usb_disable_ehci(struct pci_dev *pdev)
  * Returns 0 when the mask bits have the value done.
  * Returns -ETIMEDOUT if this condition is not true after
  * wait_usec microseconds have passed.
+ * Returns -ENODEV if the register reads as all-ones (hardware removed).
  */
 static int handshake(void __iomem *ptr, u32 mask, u32 done,
 		int wait_usec, int delay_usec)
 {
 	u32	result;
+	int	ret;
 
-	return readl_poll_timeout_atomic(ptr, result,
-					 ((result & mask) == done),
-					 delay_usec, wait_usec);
+	ret = readl_poll_timeout_atomic(ptr, result,
+					(result & mask) == done ||
+					result == U32_MAX,
+					delay_usec, wait_usec);
+	if (result == U32_MAX)
+		return -ENODEV;
+
+	return ret;
 }
 
 /*
@@ -1203,6 +1210,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 		timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
 				0, 1000000, 10);
 
+		if (timeout == -ENODEV)
+			goto iounmap;
+
 		/* Assume a buggy BIOS and take HC ownership anyway */
 		if (timeout) {
 			dev_warn(&pdev->dev,
@@ -1231,6 +1241,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 	 */
 	timeout = handshake(op_reg_base + XHCI_STS_OFFSET, XHCI_STS_CNR, 0,
 			5000000, 10);
+	if (timeout == -ENODEV)
+		goto iounmap;
+
 	/* Assume a buggy HC and start HC initialization anyway */
 	if (timeout) {
 		val = readl(op_reg_base + XHCI_STS_OFFSET);
@@ -1247,6 +1260,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 	/* Wait for the HC to halt - poll every 125 usec (one microframe). */
 	timeout = handshake(op_reg_base + XHCI_STS_OFFSET, XHCI_STS_HALT, 1,
 			XHCI_MAX_HALT_USEC, 125);
+	if (timeout == -ENODEV)
+		goto iounmap;
+
 	if (timeout) {
 		val = readl(op_reg_base + XHCI_STS_OFFSET);
 		dev_warn(&pdev->dev,
-- 
2.47.3

