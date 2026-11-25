Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648197;
	b=nM/JLqYuwySzUy1NfJX+3Pq560s23n8NjO3ak617vDziaskraJUONLhD7C6W+f9OIIUT
	 10qgixzdSewJXjjUm6gjReOaetXBkdDet2ptr98S5pMmym1+JmP+Wx2kDhAhCCphjT1Zi
	 E1Mac2wu3mXSEqHE0+lTCWwUweaNAd9MATtep4rQrO6TUKQT9HeuHHlF9Cnxao0yUo+3a
	 2dtC8Jthh1Sa9djVdFhD9mcQwy/i+gBiGDsLPEDpe2jIxWpQ6Pn3MOlp2AJz0NjFFL+gj
	 9+Cvjwb1gHvXIh2IoY0b1Vn3AvYnESeCm0xQhRwc8oqwK/mmSnCwjyUlUoA0Ywl4f+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648197;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=jTT7ZQT/IeZuZXnF5eJK7WIKxpNbB7mlhkfRnq9M/Fg=;
	b=cUXJ7CkMW4/djeYTiScAG97ubAkAQlJ8PQR1zSIJ5uA/7HZo716C2jcC6/rmvWc29m04
	 G8NL1yxrBfKFuOxNhVQxx03th6R03CeordZxBY2gr8CcpBTWMFCZWQy893lv/fTae11Lv
	 +4YUQpZ0JMDHzSKMGKw8kvVOoxCo9KoaAOqUhsxdC30Zmp/aE3LCX9nJxqZfHVEzRmXQH
	 IkY4Q4Y4SE+vKKknb4QGqqjxERBWSJzewJh3vphnskT8oJZvaPwB1N2h5yqeXV4B5U8he
	 0Y9d7PP7wWymBsAvQV/mkJ/45sa9TDZaNIU/opB0nCr2y9XV0VupulytLCDRXvng+bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EAAYb45w;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9DF606A321;
	Wed, 25 Nov 2026 23:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA9DF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EAAYb45w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648197; x=1827184197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kP2SPO5/6lORcTqOAcqARY5ZCI7i60ffA/JZ/vM2yOo=;
  b=EAAYb45wUgTgy/DfEyj79WogaR+4Nw49JGFeBzxGGRw8pgODNNid5T3g
   V3NWXFsrKNjgrhDCAUuvx/laxNAfpSMZdgsuU2GJSvZt9QWaDlbP9hdN2
   tXt6RfvF5p1TV/e7Zb69Nycn5tg4aDix6nVhpyXpU3AjjmcrpMyp/hHcU
   huCiNnChKez1JA9Quv/Bsj/vS84aqlCyGNmn+J7gLbdjuF2P79ptWEFT8
   vz4IAAtXI9pUVpYRqPdmBrCzfhHOABCPbA1AsmtFWxWJIHVm924rR1JgW
   3jXTbsFrCYwNjHywldQGnS/uAWcI5sDCcHkHKkPI0OpL4YSNfqz67xedi
   w==;
X-CSE-ConnectionGUID: jsDpzAp+TG23T3uFa0AvYw==
X-CSE-MsgGUID: L2PCUKLyQhSxiKY9YfiS0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4469380"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4469380"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:09:56 -0800
X-CSE-ConnectionGUID: FSeJ2UOTQfqGpZEEwoMCHA==
X-CSE-MsgGUID: YkZ16Fu2QqmOys0Qlr7UQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11980046"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:09:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Len Brown <lenb@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 01/17] PCI: Add pci_bus_size_and_assign_resources()
Date: Thu, 26 Nov 2026 01:09:00 +0200
Message-ID: <20261125230925.2441-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bridge window sizing and resource assignment must not run concurrently
with another sizing and assignment pass or with device removal.
Preventing that requires holding locks across both phases. Many callers
outside of PCI core call pci_bus_size_bridges() immediately followed by
pci_bus_assign_resources() and cannot hold the PCI core internal locks
across the two calls.

Add pci_bus_size_and_assign_resources() into PCI core which combines
these two operations and convert the callers that call them back to
back.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm/kernel/bios32.c           | 5 ++---
 arch/m68k/coldfire/pci.c           | 3 +--
 arch/mips/pci/pci-legacy.c         | 5 ++---
 arch/sh/drivers/pci/pci.c          | 3 +--
 drivers/parisc/lba_pci.c           | 7 ++-----
 drivers/pci/hotplug/acpiphp_glue.c | 3 +--
 drivers/pci/setup-bus.c            | 7 +++++++
 drivers/pcmcia/cardbus.c           | 3 +--
 include/linux/pci.h                | 1 +
 9 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index ac0e890510da..555bfb091d30 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -510,15 +510,14 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 		/*
 		 * We insert PCI resources into the iomem_resource and
 		 * ioport_resource trees in either pci_bus_claim_resources()
-		 * or pci_bus_assign_resources().
+		 * or pci_bus_size_and_assign_resources().
 		 */
 		if (pci_has_flag(PCI_PROBE_ONLY)) {
 			pci_bus_claim_resources(bus);
 		} else {
 			struct pci_bus *child;
 
-			pci_bus_size_bridges(bus);
-			pci_bus_assign_resources(bus);
+			pci_bus_size_and_assign_resources(bus);
 
 			list_for_each_entry(child, &bus->children, node)
 				pcie_bus_configure_settings(child);
diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
index 5afb207ccc51..dd21c77c43a6 100644
--- a/arch/m68k/coldfire/pci.c
+++ b/arch/m68k/coldfire/pci.c
@@ -250,8 +250,7 @@ static int __init mcf_pci_init(void)
 	rootbus->resource[0] = &mcf_pci_io;
 	rootbus->resource[1] = &mcf_pci_mem;
 
-	pci_bus_size_bridges(rootbus);
-	pci_bus_assign_resources(rootbus);
+	pci_bus_size_and_assign_resources(rootbus);
 	pci_bus_add_devices(rootbus);
 	return 0;
 }
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index dae6dafdd6e0..ec0e42d9a895 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -129,15 +129,14 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	/*
 	 * We insert PCI resources into the iomem_resource and
 	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
+	 * or pci_bus_size_and_assign_resources().
 	 */
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
 		pci_bus_claim_resources(bus);
 	} else {
 		struct pci_bus *child;
 
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
+		pci_bus_size_and_assign_resources(bus);
 		list_for_each_entry(child, &bus->children, node)
 			pcie_bus_configure_settings(child);
 	}
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 878a27a1acfb..c91ca8f4cb1c 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -81,8 +81,7 @@ static void pcibios_scanbus(struct pci_channel *hose)
 		need_domain_info = 1;
 	}
 
-	pci_bus_size_bridges(hose->bus);
-	pci_bus_assign_resources(hose->bus);
+	pci_bus_size_and_assign_resources(hose->bus);
 	pci_bus_add_devices(hose->bus);
 }
 
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 5197a3c93c70..39ab93ba458b 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1639,11 +1639,8 @@ lba_driver_probe(struct parisc_device *dev)
 	if (is_pdc_pat()) {
 		/* assign resources to un-initialized devices */
 
-		DBG_PAT("LBA pci_bus_size_bridges()\n");
-		pci_bus_size_bridges(lba_bus);
-
-		DBG_PAT("LBA pci_bus_assign_resources()\n");
-		pci_bus_assign_resources(lba_bus);
+		DBG_PAT("LBA pci_bus_size_and_assign_resources()\n");
+		pci_bus_size_and_assign_resources(lba_bus);
 
 #ifdef DEBUG_LBA_PAT
 		DBG_PAT("\nLBA PIOP resource tree\n");
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 78e3effbb32d..632344f34cae 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -465,8 +465,7 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
 		max = pci_scan_bridge(bus, dev, max, 1);
 		if (dev->subordinate) {
 			pcibios_resource_survey_bus(dev->subordinate);
-			pci_bus_size_bridges(dev->subordinate);
-			pci_bus_assign_resources(dev->subordinate);
+			pci_bus_size_and_assign_resources(dev->subordinate);
 		}
 	}
 }
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed16ef7c26fa..29ec9ba59d92 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2492,3 +2492,10 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
+
+void pci_bus_size_and_assign_resources(struct pci_bus *bus)
+{
+	pci_bus_size_bridges(bus);
+	__pci_bus_assign_resources(bus, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_bus_size_and_assign_resources);
diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 5e5cf2c3e2c8..19df3f9228a7 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -81,8 +81,7 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 	/*
 	 * Size all resources below the CardBus controller.
 	 */
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
+	pci_bus_size_and_assign_resources(bus);
 	cardbus_config_irq_and_cls(bus, s->pci_irq);
 
 	/* socket specific tune function */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..d89aeb7c9ff7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1569,6 +1569,7 @@ resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
 void pci_bus_assign_resources(const struct pci_bus *bus);
 void pci_bus_claim_resources(struct pci_bus *bus);
 void pci_bus_size_bridges(struct pci_bus *bus);
+void pci_bus_size_and_assign_resources(struct pci_bus *bus);
 int pci_claim_resource(struct pci_dev *, int);
 int pci_claim_bridge_resource(struct pci_dev *bridge, int i);
 void pci_assign_unassigned_resources(void);
-- 
2.47.3

