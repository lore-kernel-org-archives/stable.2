Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24F3254A9;
	Mon, 14 Sep 2026 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352908; cv=none; b=GZPOILq10NFh4I26emC3gd+AMx5vk9WSKx7IF8ZdcUUW+0I8RCvV4EUq/7lpIGQKZHVQxQ5JdY+TojpUsoW0uljXeR9HaAy3TbwXoAkw4uTyBQnc0wMOLRvzIPqnNKeGh+jxcVO0yeYaMhCmkxwSw1eTs5vFUQRPEG2kdSYgozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352908; c=relaxed/simple;
	bh=x4qiHX9gxf5WG0f9svuvHCOR1UDGcg2Dh7YBfTEDT3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzIq6h7+X8bNXZVpUbm2UkmoSMKkCTutCp6UdCgKy9qxqoayEd317bPIS78yf4aGDxApe4eDgHMszQjuliRjWdAK7eYe2fcDb56CP2YuadGnjoRCUqsIAzoUVStO4L6xnEsyao4WtFNBIbL8+6R6RHwuUKr6l5YxNctRF/fxjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com; spf=pass smtp.mailfrom=ugreen.com; dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b=N6fMr8r7; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b="N6fMr8r7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1789352878;
	bh=QS1750WvOEqPH5k6i+R3qHKrRc8HMJtl7mpzuMFix5s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=N6fMr8r7aUgQUvDetWG2Y3ANXo/XRkoeToC7j0NJoJvkD6hFALBh0lwA3X7ed11FG
	 rv5D3NY52LyjBNrVAru5IBnxEZwXHA8h8jp519NvKhftLS98ykKyzbNZmbLH3uQ6TR
	 cCpQQldPjR/sZIApzsYhxwIg4qI07vI8Op6o5IOg=
X-QQ-mid: esmtpgz16t1789352871tcc7d0c22
X-QQ-Originating-IP: Sq8fha/UJpP7+fZwVAdK+HpvJLGpF0QMBBQxXYu1wH4=
Received: from 9DFG3.ugreendc.com ( [113.90.157.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Sep 2026 10:27:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6281952500295723294
EX-QQ-RecipientCnt: 7
From: Haowen Bai <calvin.bai@ugreen.com>
To: mathias.nyman@linux.intel.com
Cc: lukas@wunner.de,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Haowen Bai <calvin.bai@ugreen.com>
Subject: [PATCH v2] usb: pci-quirks: abort xHCI handoff if MMIO is inaccessible
Date: Mon, 14 Sep 2026 10:27:43 +0800
Message-ID: <02C44DCEA968C75D+20260914022743.30852-1-calvin.bai@ugreen.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aqacxOz0jPWIfXGs@wunner.de>
References: <aqacxOz0jPWIfXGs@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NUTz4BkILuKLs48koJu8gk9ZqAxlzGjw9zHpYjmxNC+fpulNLnzZilR2
	IiSZnyEJCNsQVAX43rYnM6y2gAgP2vkZfxnQrbjV0DybX85P5kJcjKjfuMGqPXJoV51+8FV
	SdF6HCSxbLroQCBEsacp+TvB+MRHh2dQACG/pYEIavdc8fHNdWvUOi+CWR0CCIiQipfuChf
	ZQsAhwNuXt/mQn6BZnvZT4Q9FncmgXuZ5bLNYdi2KVS8Ut6OcIW5932F+SbmJoz90wthe8m
	7fKgkjoHHrlTZa238YRqoF5knEhs8DUsQ2bWEwF0E2+jOZcPn10rWclLcb4vQg5lmvtwO0P
	Xjd8HC7D2NpLie3clJnocOf2sYoLSU4OGGXTmmqPKEQmMFy26B5AKyXJOX5l0sX436qlUk5
	59HLsY6SKL6Z3J32ykbBwcZBVJRM2pnktjZ2c2b3p0qF0WMGmjodXm37JOtthFisg5Ckkx0
	iCL6DLJHv3FSIKn8twhxaSaMmanBiBKJWQANIMnUMF1U+SB+LAyhtGttPfyujO82mX4RoQA
	svQ4df+tffNLAdJ1p/i5cBjjtylbb+SdDfr22ND5Q44XAIH2YGbiWX8OMGCPFpbuyrMZrjT
	gy5S1Z+k0kbTE+oK5rm6zXrj3t9iB0MpQrQkkXWaK1SzHglwO33L1jXebmHW7Y6yUoHwvid
	a0DLU6po080Ofkh2vVzpwmNXCbq1Vn0j2gXhSrW2ahkPz6B7mtty1TfIC+cxjesPbUok35f
	7nnILq+ekMVBc1LPrXvVzq4/H7Nqix7nTAiqqRZpd2LFmIS+UAxmEIs2HOUXKMNauGFNGvE
	R/q1X5xkSwU1QRQN6hjS8/KSMUrfKrRDvJGseA1d51py4iHhez++mKrfEtQKSL9ZHC3u/vf
	O/u+94y0u18T7tKQTMJpeCUysiE6hhFxPMMo55TAifmbNV0BoUdk1BNdmt8u68/pagi4Mm1
	mPGBU6URM2Lv5Zi/A5qQiyhSJcyHWwfkaPL9Ggz8e9ER4xbdPkr8w4EgkjEIIbxxPV7G4I2
	6dhDaumMpBjFDO1tW3
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Haowen Bai <calvin.bai@ugreen.com>
---
Changes in v2:
- Use PCI_POSSIBLE_ERROR() for both all-ones checks, as suggested by
  Lukas Wunner.
- Carry Mathias Nyman's Acked-by.

 drivers/usb/host/pci-quirks.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0404489c2f6a..1167973382d9 100644
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
+					PCI_POSSIBLE_ERROR(result),
+					delay_usec, wait_usec);
+	if (PCI_POSSIBLE_ERROR(result))
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

