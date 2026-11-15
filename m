Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763123;
	b=oAf4E+qYEkRBwjyp8ygy1op1KO7pBEeWAl5mZ3YrL4BneeZ3IcxqoHixcPpeMZhjMcD2
	 FX8H+PJzGgO6cuJHNUukmfgHqsUs3kIvhE+X7m3w/cSgmHXop/y8WkXL2Yg/cXtZFZRMO
	 fvTtamytAVfQRJvT7tj09oaE+gbAQpmcoPMkVTlYmxinqNaDbgqSBlbvkvdZsNjKePGYF
	 OLhoSwd6Mj4/bhvuDRyUonFANszXNsUSUdlHMHjCTEtXvdPid2O6dPmAgUq88wJGoVIz9
	 vg4MKs7/uHdUW3wQKHaAbOJKwOOFyvRszcoO8+uhHwc1/4OCWOk5jiVUSIGIevPAENQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763123;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=6SPQoq63tz1usrlqWtzQsVBhtZ6Dan0Y+sElILVXxNU=;
	b=iRDdGhcpicTG7IWa1+kiM+PzAEdrTNSTjhnoeEk0Xk5xAlxgq96mWcY5nusdYO+L4AIR
	 nDMgqMqOIkcZYoHL/meaiQhEg0+mRoR41jI59GiNBfUSVlUzWmw2HyiYyvcxwgs7vFhGv
	 iolqXOnO6dOMjbE2KCfePsH2ePgWPk1ADHIudc5kNXE2BCcOmQ0pfjTm6hBpdcX/9TzeI
	 qL8GxNbPGt+s1yg/aGTayRhDGqUBJC6mR8KwE+0GSjAfjy5a5WuznIVEHPRhDmWwOyMUI
	 DC3wujbCNWp+nt2MUWg9npFqNgEt4sRMFa4Tb4wCXsNxkKNy+uCMnyDSbdYexz8pN0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=B0keetNt;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469FA606A32C;
	Sun, 15 Nov 2026 17:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 469FA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=B0keetNt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794763123; x=1826299123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SPQoq63tz1usrlqWtzQsVBhtZ6Dan0Y+sElILVXxNU=;
  b=B0keetNtUU23rtId5sBsV43DovuI0nNMHZgQWGleU6z0XN2zBgtdysy6
   X9nOcCXt4SaAQVUL82thV4eO5BRWHUOvkSOiev+1R53sbHLyF70hAJNhq
   spm4I6pfuNAr2tyQriyyDxnoY1lbvq1TavB4shf6zeoms50o3MTONI42q
   xQQ4kcjm2AHTvHkIgtrsCsKnQG/5C/xVxpvL6g6/Iv4rC/f9ufQhiIThi
   /QIPSAsvQkA5+g62rs3+06ImR8/rkgl6AxJsZMyRD4NhF1sQtnhdTEsFN
   aKYRp06WQbo0YaOxwuYx7KwwnyaZ1Jly6myXPNAsyfd9rEcS0ip35kEDD
   Q==;
X-CSE-ConnectionGUID: TBQbZXeDR8+az+kBVpncgQ==
X-CSE-MsgGUID: 3XsX8a3oSKS9xc61eAx6AQ==
X-IronPort-AV: E=Sophos;i="6.27,215,1787011200"; 
   d="scan'208";a="33568805"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 17:18:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:31330]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id c6c90dd7-06c0-43c5-9b34-b42e3de9f4fc; Sun, 15 Nov 2026 17:18:40 +0000 (UTC)
X-Farcaster-Flow-ID: c6c90dd7-06c0-43c5-9b34-b42e3de9f4fc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 15 Nov 2026 17:18:40 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 15 Nov 2026 17:18:39 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Zeev Zilberman
	<zeev@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] PCI/PM: Honor PCI_DEV_FLAGS_NO_D3 in pci_bridge_d3_possible()
Date: Sun, 15 Nov 2026 19:18:29 +0200
Message-ID: <20261115171831.1498006-2-avivb@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261115171831.1498006-1-avivb@amazon.com>
References: <20261115171831.1498006-1-avivb@amazon.com>
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

pci_set_power_state() does not put a device with PCI_DEV_FLAGS_NO_D3
into D3, but pci_bridge_d3_possible() ignores the flag.
pcie_portdrv_probe() therefore enables runtime PM on such a port, and
on runtime suspend pciehp masks the hotplug interrupt while the port
stays in D0.

Return false from pci_bridge_d3_possible() when the flag is set.

Fixes: d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports on non-x86 platforms")
Cc: stable@vger.kernel.org # 7.3.x
Co-developed-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Aviv Bakal <avivb@amazon.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..1a23be4b6a07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3055,6 +3055,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_disable)
 			return false;
 
+		/* The port is known not to work correctly in D3 */
+		if (bridge->dev_flags & PCI_DEV_FLAGS_NO_D3)
+			return false;
+
 		/*
 		 * Hotplug ports handled by platform firmware may not be put
 		 * into D3 by the OS, e.g. ACPI slots ...
-- 
2.50.1

