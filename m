Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847888;
	b=CpISH9pEDjfiyFCyDmSTiI2rMGK7KOvwpUDC0Hf0sabpeU1kQfR+/QGdH6xcB+6K4paN
	 +ma9+1N4feUvjA6RZA1L5wc8vQ/O9xf37iK/PuiJQ3ALkOClI8Db/gaZFFlpE/95NeQiz
	 PxqN9ualP9wTVp6BDercYaahtO6uV9/WvShCPk5EA2mRlxtKfGx3hEXaI6zG7ARIqzF/E
	 S8WI3PRgECFimpsSb/nX5OKfXaKLzegJJWEXW8ODu/osq96yo1Hi7JQPIHStHBQ0DpRNz
	 4gUH5vFG8F5Gray5xbUldOokF4gOYjfvraiINnCcA/7CXzb9+ZEzT0JsGbb0QtoUJXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847888;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=1pwY32vzU52ZQS2Abk01B/OTrskSTo9RY0mYXqsrgE4=;
	b=0QgOx11vMUMXPvIFcTGOxcSd2uZPxZNrZepzamQ8hZp5VFM0UPmvinCsg9PqHJW3KEAt
	 LFTuDdgdL/EO/8muHLgQaFbf2OHw9bVIXSQJpKwMLenTvpvrG5pXbj0MWP7z4G40LMt39
	 oqS83EdP0nBhh2k14huz8ps7Iz+K16qKrSEBFUu/9bsVD7KcnZZ5KBXiIa+v4+0uaSh3o
	 nNju4TdvBJ7b9QZWkKid6Yl9Xp1otDi+/4zZKP7SJkmhx9ttTXOKn765P50wJ/BDMszxD
	 t6aybhLn1DVUYdwJOwD7yPrtpOCprJEThG34myKvSlT8neZPXUaepd9MGosXOHssYtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=JDkqvHLe;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C17606A886;
	Mon, 16 Nov 2026 16:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C17606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=JDkqvHLe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794847888; x=1826383888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1pwY32vzU52ZQS2Abk01B/OTrskSTo9RY0mYXqsrgE4=;
  b=JDkqvHLeP70GjQowh0w5tNgXTaod4blnBfY0M/n6hcWaveVZlUkHyBee
   NuWY4mE3aVQu5+9Q4ZaxwcE6p2W+rOYZlf31gGcUbXDpbkV0BXTht2Izv
   xOwZivErwppG33NfIv2CyK87obi9P2h0za3uC5Z8klJR8R1I1SQ/19Jim
   Guwnvz1sNBr06nDtNek8qqfoqLCJdH8lHo2bEYlFeSjmHCUj543/tj13y
   CFj1wTgUFuprfoBdV4PVtWlMyTFUUOrhEouFifQUWgO/8xhzUqtPno6YM
   bvYD7h2AO2941GQOHLewLXbMw1A4SlGIleYqBXyuEMTAYqshjwQyWRV5g
   g==;
X-CSE-ConnectionGUID: U5NgDz/cRWm8tRQiTjeWzA==
X-CSE-MsgGUID: vEe/iOEuRzWh3fiIbWjqOg==
X-IronPort-AV: E=Sophos;i="6.27,217,1787011200"; 
   d="scan'208";a="34220885"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 16:51:21 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:15678]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id de546fa7-f6dc-4602-a240-529b60e41581; Mon, 16 Nov 2026 16:51:20 +0000 (UTC)
X-Farcaster-Flow-ID: de546fa7-f6dc-4602-a240-529b60e41581
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:51:20 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:51:19 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Zeev Zilberman <zeev@amazon.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 1/3] PCI/PM: Honor PCI_DEV_FLAGS_NO_D3 in pci_bridge_d3_possible()
Date: Mon, 16 Nov 2026 18:51:08 +0200
Message-ID: <20261116165110.2773301-2-avivb@amazon.com>
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

pci_set_power_state() does not put a device with PCI_DEV_FLAGS_NO_D3
into D3, but pci_bridge_d3_possible() ignores the flag.
pcie_portdrv_probe() therefore enables runtime PM on such a port, and
on runtime suspend pciehp masks the hotplug interrupt while the port
stays in D0.

Return false from pci_bridge_d3_possible() when the flag is set.
pci_bridge_d3_possible() must return the same value for the lifetime
of the device, and FINAL fixups may set the flag after portdrv has
probed, so record the flag in pci_pm_init() and check that copy.

Fixes: d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports on non-x86 platforms")
Cc: stable@vger.kernel.org # 7.3.x
Co-developed-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Aviv Bakal <avivb@amazon.com>
---
 drivers/pci/pci.c   | 10 ++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..eb7f2f03d9ae 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3055,6 +3055,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_disable)
 			return false;
 
+		/* The port is known not to work correctly in D3 */
+		if (bridge->no_d3)
+			return false;
+
 		/*
 		 * Hotplug ports handled by platform firmware may not be put
 		 * into D3 by the OS, e.g. ACPI slots ...
@@ -3227,6 +3231,12 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = 0;
 	dev->pme_support = 0;
 
+	/*
+	 * pci_bridge_d3_possible() must not change after this point, so
+	 * ignore NO_D3 set by later fixups.
+	 */
+	dev->no_d3 = !!(dev->dev_flags & PCI_DEV_FLAGS_NO_D3);
+
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 	if (!pm)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..1238667d643c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -420,6 +420,7 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	no_d3:1;	/* NO_D3 set before PM init */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
-- 
2.50.1

