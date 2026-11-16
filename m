Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847888;
	b=4z7ulGCRK56FF1XXyrgpULD0e7pvw/e0DiepXtpKF8vnFbyU9khos4IHG0IBVWKt7VJm
	 pyB/yyyMCF/AYlWm9YGG3oT1mrxOARupViDSmTOCqjKdgxZ5T++rI+G9n0lk8sM+naDGo
	 Be8KSdf2E/DeCjPI+o31Qs/o169IZuCApG2mBFx58PNJqfvs+hy2RIQ61TRZTjjkG3Vke
	 AeAckKREbOz5hNMOcGWEB3HCS61dqghn11V4vlEOor32bELW2G7KfGjNqjFnp8abEPanC
	 i+xTuaiUxsVTDjYYYTdRDEg0MReXq4RVnKrPKiJmUjWQnQPXo6DSrOsEu3rir2z+CoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847888;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=icZ0VipIZRXlm+fS9y9PWYLM7wR3UIt776786IJxl90=;
	b=1Br7uM5/HT7zl0oFDfVRuythcJigcE7kmlnL+u4GtXDqvmI58D9r4IB9aU6ppRXkywn5
	 7MIcwu7vlylH4taofjOZn5vDQ3mmCE+HGOfhVUHcXwxz0XAV97tSARdhr7ylGRD+/JR4D
	 zzke3w5c+bvsjd96HAX3B21DM4anoOgZC44WSLIQ6Xttoz9GKOmOPIXuUi3boaKko6USM
	 lmf9esvmdokWBmR1vZjHNONT6qcgCiLdG17KPwILBXiPp6RhdrlwD6KvwI4+iqS3d9QnU
	 1bcmjHK4A8/GUuwFZU9U3m08ubGusZ/DTYkH+jJURwsyjNb8blELTOVI4RTcLRLRWdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=cwXcuilB;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D2F606A882;
	Mon, 16 Nov 2026 16:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7D2F606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=cwXcuilB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794847887; x=1826383887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=icZ0VipIZRXlm+fS9y9PWYLM7wR3UIt776786IJxl90=;
  b=cwXcuilBQIIJNLUkP+0M46xJFIjtUDrZooS7JCeneuxkWSLl/xjDcEDk
   wKHuPKn/zS100WZfPt8GcJXFhqI8rUZ05qMlh5ttPfRQrwFP5ofNrgKTY
   IPfCx+PLTEUgAvewphgr8cb+ppsVM0EV0SvaYAE7cIrS4eFxGVVhrFRN5
   vwn9Rx/9t/1Eu71Xvk2Fn3+3s8NXL6lpawZyfAHc0OO/nkZwpqXYQPCw1
   5qyyJdm9y4kRH/l0dmevNDHFd4ep5FzaZHS2ep9BSJ3Cdf7J0m2xytHhp
   NiMsfRSGqLZNyIrXLT4TPq9jQOSyL4Y5GdqJLeNFNUaBtrvj2/5lcO8IE
   Q==;
X-CSE-ConnectionGUID: s3Yzt6LyR7uvwSBbFAHgkg==
X-CSE-MsgGUID: wAD/Aw9vRTiWxCXRLIw7ww==
X-IronPort-AV: E=Sophos;i="6.27,217,1787011200"; 
   d="scan'208";a="34220889"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 16:51:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:25088]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 43eb94d9-6c73-4232-898f-979989c8adb5; Mon, 16 Nov 2026 16:51:22 +0000 (UTC)
X-Farcaster-Flow-ID: 43eb94d9-6c73-4232-898f-979989c8adb5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:51:22 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:51:20 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Zeev Zilberman <zeev@amazon.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 2/3] PCI: Avoid runtime D3 on Amazon PCIe switch ports
Date: Mon, 16 Nov 2026 18:51:09 +0200
Message-ID: <20261116165110.2773301-3-avivb@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116165110.2773301-1-avivb@amazon.com>
References: <20261116165110.2773301-1-avivb@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The PCIe switch ports on AWS instances (vendor 0x1d0f) advertise PME
from D3hot but do not send it. Since commit d4c79b63d82d ("PCI: Allow
D3 for native hotplug-capable Root Ports on non-x86 platforms") these
ports runtime suspend to D3hot on non-x86 platforms, and hotplug events
such as an ENI attach are lost.

Mark them PCI_DEV_FLAGS_NO_D3, reusing quirk_no_ata_d3() renamed to
quirk_no_d3().

Fixes: d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports on non-x86 platforms")
Cc: stable@vger.kernel.org # 7.3.x
Co-developed-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Aviv Bakal <avivb@amazon.com>
---
 drivers/pci/quirks.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..338e884126fb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1458,23 +1458,31 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
 
-/* Some ATA devices break if put into D3 */
-static void quirk_no_ata_d3(struct pci_dev *pdev)
+/* Some devices break if put into D3 */
+static void quirk_no_d3(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 }
 /* Quirk the legacy ATA devices only. The AHCI ones are ok */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_ANY_ID,
-				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
-				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
 /* ALi loses some register settings that we cannot then restore */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
-				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
 /* VIA comes back fine but we need to keep it alive or ACPI GTM failures
    occur when mode detecting */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
-				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
+
+/*
+ * Amazon 1d0f PCIe switch ports (e.g. 1d0f:cec2) on AWS instances
+ * advertise PME# from D3hot but never assert it, so hotplug events on
+ * a port in D3 are lost.
+ */
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AMAZON, PCI_ANY_ID,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_d3);
 
 /*
  * This was originally an Alpha-specific thing, but it really fits here.
-- 
2.50.1

