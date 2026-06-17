Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03743C3C0E;
	Wed, 17 Jun 2026 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691046; cv=none; b=kWs+w9Xx092yzy01ojz7OFSdq4bzE2zK/lnHClNWMARRTdbKHmPQ4lMmh4UzTRs7ixRoX2EJdaRNSloI0j1oZvCIoGlK1pvLffkHZN+NFk9LRAon+sXvX4FV9rVIceTFWvzIoexGIWYZAfuJaUgjc4EIAbYRMxr5hpXvayGQz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691046; c=relaxed/simple;
	bh=34QBRVhfuaS2DMfKCySh/mkmfr2LC/mf23+rkkAdqDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VsK4s+AHfoi0A94jMpRILVYjJtZdBi5DPmjy0nC2Ws9pAUWhG6ANYEWXbHzi2L+A7ElOPZQTcXGtW3IDBY7Me4VfsNf+P6NYVMn9nxE3R75TQgVXlaOk2bPztJORWvjkeiBGczCoACTCZNZkaUvfP2XG/R5qzM+Pw9UrEEvtzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jjjrHG5Y; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jjjrHG5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781691016;
	bh=t0k4KETS3DYbrhuiTcpPSSNVJN8XG33QT9JP6dIByTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jjjrHG5YD5geU+YCMCIsWyHS+RaPtG94xrNFnGVRKCPVhSt3nNdc4bTQABDJRSPvh
	 FYqlbCG8ulrhw1/BvEIpgaDRysBtGhPlcYOsX/ieW2qIqjEZDlhEQNpdrae4TBQrOY
	 fIK5w3Ch4YKHIEccLqzZ+KmwpJMIUFBPAMkeuDD8=
X-QQ-mid: zesmtpgz6t1781691000t43d5fb33
X-QQ-Originating-IP: meuJZ+mkGZcHUGa1IWwktNozjbt5o5TDqGotR1bukL0=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jun 2026 18:09:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7307632202497933010
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v2] xhci: pci: Disable soft retry for Renesas uPD720201
Date: Wed, 17 Jun 2026 18:09:57 +0800
Message-ID: <D9BA02889D046D23+20260617100957.2888108-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NQN/cmJBY1rC10lbOi6TuNqgKRROH5AUjkbVIfKhWdrSTuWzYrMjoNST
	BePrmAwGCGQDkEj1rjdVY3AlcrSsqUPNjVaoNdrzbitg4ePoLPDiQf1t61kIeZyDNFQRn1A
	F7WelYFDuLTyrKWRcRfzD9b5CbJKd1RI0pukU57mVW7Deawi8C37F8eXOOBpCJG60T8/v4C
	9VhW6Lf5W6v/Hfu05Fy7ByTBqBkhCjLmmQIAfnjKIrWoMPXxJn+6jO7MgQY/xnqizQLdoNM
	xPPxqu1JYEzWf4fM3zxrQZdMONGf0GpY3PhWkVTzWsRh1RIx/ChAChijPdGV9tsvF3v5Yp5
	CM3eMWEALsPQgw54o5ntqd52ALUslyARw/KQq7K84ix+Oipx3gXzS/PoPt3xHuTWwxo9fSv
	4DIEasty0hS8nJeRCGsEVhjxNhEiTrnCn/illruGe8oYdkEmWvPVjygNbtRa+cZHqQSdot0
	Zp80WwbEnpoci9Yhw+zIjvqeHKfXHMg5FEhh6mqzxp0AT2VAoUj7L8G7nqLHU2WTOMY8By1
	kmqUDqr4gvE4mr7wk8Lnrh6EJeFgx8DodLcGtGkawEryQjn17sslMp/mBW3Jv1qcqT+QOzS
	T9TW9HucyosnxNDPIQ6Y7HTAlEa8rFbpuRU39L1igCJqlVluYlm44vskwGP0LGnahk6e0P4
	wnf+Ny4vD+LW835KlMlds+6TJO1WcuKLK6jUh+blVC5K8oP+leepyC6R38vaFXnH401fwBg
	lh1nWxKpNLdZBTH8kkdXTtak2/fjQ+v8LysgWMHfN+dVaSz2DVQWgGW5LnnqZK2lmAw0O+s
	MeMB+vVgUK+OsfIarp4N2vSA6x3fWkfnTDpoX0++POfJqNdByM+IKOZ1lUoJlmIdXHhCN55
	CUyEujO6E7dtAyL0i6APsNTip1wZxJ6D1fCVhIFbOQX9O+d5pp2K5hl4MLx7bcT1gXSG/QB
	oX38m4IMNmxvtJqmY+enGc8i3Bk1zQj0Gh0PgNacfnFh1JxWQJ/NWBTp9P/o029uTEZfA+y
	C9RD2PsjXDIbNlSIRLOxPkGDkSyt87S2rsXcd1+YvhQo8NCHW5Z+A6B3Ig3kXKet5k5VCsu
	5EVoYgE7CV6ogesvITfb5edq+xePjJCUGJxY5UI9N8UG6hNw6OpKco=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The Renesas uPD720201 xHCI controller can fail to complete
a Stop Endpoint command after a transaction error on an interrupt
endpoint when soft retry is used.

This was reproduced with this setup:

  xHCI: Renesas uPD720201, PCI ID 1912:0014 rev 03
  dev:  USB Ethernet device with an integrated Genesys Logic
        USB3.1 hub, USB ID 05e3:0626, and a Realtek RTL8153
        Ethernet function, USB ID 0bda:8153

Reproducer:

  1. Plug the integrated USB hub and Ethernet device into the
     1912:0014 xHCI controller.
  2. Let r8152 bind to the 0bda:8153 RTL8153 Ethernet function
     behind the integrated hub.
  3. Bring the Ethernet device up.
  4. Hot-unplug the device.

The host reports a transaction error on the RTL8153 interrupt
endpoint, queues a soft reset, and later times out the Stop
Endpoint command while disconnecting the device:

  Transfer error for slot 8 ep 6 on endpoint
  Soft-reset ep 6, slot 8
  Ignoring reset ep completion code of 1
  xHCI host not responding to stop endpoint command
  xHCI host controller not responding, assume dead
  HC died; cleaning up

The Renesas 1912:0014 controller cannot safely use the xHCI soft
retry path. Set XHCI_NO_SOFT_RETRY for this controller so
transaction errors use the pre-soft-retry recovery path. With
this quirk the same hot-unplug test no longer times out the Stop
Endpoint command and the RTL8153 remains usable and stable.

Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org.

 drivers/usb/host/xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 585b2f3117b0..d70c6a6a64bb 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -427,6 +427,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_ZERO_64B_REGS;
+		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0015) {
--
2.50.1
