Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182510;
	b=acW8EulYuL5F+pkOlTeQTXGi2goHO4721UyRmjc6wNq6IEOLTU9BXxLh77M04B9TRGCT
	 7w9ls96ceDpf8hkhoj9T1wBPDbODKzKHHpoL1WShVSOzPvf+5Pr11azQwtLHkpm95sIt3
	 3UGKA5gMUnruqbuNHREFAYHmq8wysP2bbnmHtatsElUxOCbI1reI4SiMoks15mBrmc1PP
	 95GRSlQ9/C2TzYAIBHgmCYiezBEe9XsqFaXC9Dkf/5GRwvwn/YhgaLMJkrP2hZ69jeMmo
	 vCrInE42NuCNOJ2BjAdX3KA8tqTY4jNicfcmVKzNtFXhuQJFlS1i6dHhtRcAap5IwTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182510;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=oTH0T+j9mxYF9pgNoL09Y/KCz0muKuE0+CC2lvJMHlc=;
	b=wJ8+opfpmXy45e+LaacL6dMnFJ04KG+SJPrddZ232FRANmntBUqwS4gMz9MU22P7f0KD
	 hwSf9E7RwPaxg0yI6pCRiKfeI4XzFvdRaZ2XkYDmgLEmMgMScR/yDxWhr+A/rHMWJFqDt
	 TU+DS5EyyN6OpEL7RGob5SMDaQkKO0QwYyA0wOqdr4mOAKCPC+2qR4qjvafthTLJYvkIW
	 F6MdeaS6BuWDHOv1jyYgQ39bJJTexqb3xpE2P+BCD/95TEUQeJT1/jM7N8+cZb+ik+IYF
	 axIDKMbuIbQXgcuFhgJj0la2xh1b5IMm3X/SUqfWjROh1qNOqcIeBM2Usq3rQp1fC+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DH1Ck3bX;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C6606A325;
	Fri, 20 Nov 2026 13:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C5C6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DH1Ck3bX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182511; x=1826718511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eAZIIz6Vqb0Uazy7AggTrqHt708HzfClkhEbTdowxR0=;
  b=DH1Ck3bXBfuyAHOTE/nmgPV4Qlu602IE64zDa3dmzIx8pkO7rvHv6r6z
   5pdJXEX1GVHpr/TTHZbVajPT+A8ozItUXDzTGBMJThEOasG32KxcHviZD
   UGgs9CyrBuiQPw6T9qzkmfY5EzS7zbiGdf/5IurwRD/soB9I5QOCD+Xt+
   5GYfJ6mMYg3+GVx04l865HD/dFAnvv8F/F/oLV6jt+bP1Kf15c9KKaMs1
   cBTvjGs8wrBGwy/+9F1kamsQdEuR6Q66xp6TR5BRU9i0+m7Eqqm3qv2/O
   KNJVouQkxP1oAOqzLHYg/Et0zC/fFxzzM08MVx6rw1eJ2/oh5NXha6tqA
   g==;
X-CSE-ConnectionGUID: hKjcECl1SxS9mjhmRLPLJw==
X-CSE-MsgGUID: 0YAq57qbSs28eQo7e5pLzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4140364"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4140364"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:30 -0800
X-CSE-ConnectionGUID: wivF4fq+SR6As43fLC0Fvg==
X-CSE-MsgGUID: 7mr9tiPdTxy0/qvOPq+GWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10691454"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 06/16] PCI: Hold pci_bus_sem across sizing and assignment entrypoints
Date: Fri, 20 Nov 2026 15:47:01 +0200
Message-ID: <20261120134716.3027-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
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

The bridge window sizing and resource assignment algorithm walks
bus->devices and inserts resources of the found devices into the
resource tree in many places. In addition, its internal datastructures
hold references to devices and resources it encountered while walking.

Most entrypoints to the algorithm do not hold pci_bus_sem, and
pci_assign_unassigned_bus_resources() drops it before the assignment
phase.

pci_rescan_remove_lock is not held by all callers and cannot be taken
by callers running under device_lock().

Protect the walks by holding pci_bus_sem for read across the entire
sizing and assignment operation right at the entrypoints.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/setup-bus.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7d135ddd93b2..966e0f243032 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1459,6 +1459,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 void pci_bus_size_bridges(struct pci_bus *bus)
 {
+	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_size_bridges(bus, NULL);
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
@@ -1551,6 +1552,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 void pci_bus_assign_resources(const struct pci_bus *bus)
 {
+	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, NULL, NULL);
 }
 EXPORT_SYMBOL(pci_bus_assign_resources);
@@ -1839,7 +1841,7 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 	if (host->preserve_config)
 		return auto_disabled;
 
-	pci_walk_bus(bus, iov_resources_unassigned, &unassigned);
+	pci_walk_bus_locked(bus, iov_resources_unassigned, &unassigned);
 	if (unassigned)
 		return auto_enabled;
 
@@ -2192,6 +2194,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
+	guard(rwsem_read)(&pci_bus_sem);
+
 	/* Don't realloc if asked to do so */
 	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
 	if (pci_realloc_enabled(enable_local)) {
@@ -2260,14 +2264,15 @@ void pci_assign_unassigned_resources(void)
 	}
 }
 
-void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
+static void pci_bridge_size_and_assign_resources(struct pci_dev *bridge)
 {
 	struct pci_bus *parent = bridge->subordinate;
 	/* List of resources that want additional resources */
 	LIST_HEAD(add_list);
 	int tried_times = 0;
 	LIST_HEAD(fail_head);
-	int ret;
+
+	guard(rwsem_read)(&pci_bus_sem);
 
 	while (1) {
 		__pci_bus_size_bridges(parent, &add_list);
@@ -2294,6 +2299,13 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 		pci_prepare_next_assign_round(&fail_head, tried_times,
 					      whole_subtree);
 	}
+}
+
+void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
+{
+	int ret;
+
+	pci_bridge_size_and_assign_resources(bridge);
 
 	ret = pci_reenable_device(bridge);
 	if (ret)
@@ -2427,7 +2439,7 @@ static int __pci_do_resource_release_and_resize(struct pci_dev *pdev,
 			goto restore;
 	} else {
 		/* No bridge window to adjust; let the core reassign the bus. */
-		pci_bus_assign_resources(bus);
+		__pci_bus_assign_resources(bus, NULL, NULL);
 
 		list_for_each_entry(dev_res, &saved, list) {
 			if (!resource_assigned(dev_res->res)) {
@@ -2504,7 +2516,7 @@ void pci_assign_unassigned_slot_resources(struct pci_bus *bus, u16 slot)
 	/* List of resources that want additional resources */
 	LIST_HEAD(add_list);
 
-	down_read(&pci_bus_sem);
+	guard(rwsem_read)(&pci_bus_sem);
 	for_each_pci_bridge(dev, bus) {
 		if (slot != PCI_SLOT_ALL_DEVICES &&
 		    PCI_SLOT(dev->devfn) != slot)
@@ -2513,7 +2525,6 @@ void pci_assign_unassigned_slot_resources(struct pci_bus *bus, u16 slot)
 		if (pci_has_subordinate(dev))
 			__pci_bus_size_bridges(dev->subordinate, &add_list);
 	}
-	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 }
 
@@ -2525,7 +2536,8 @@ EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
 
 void pci_bus_size_and_assign_resources(struct pci_bus *bus)
 {
-	pci_bus_size_bridges(bus);
+	guard(rwsem_read)(&pci_bus_sem);
+	__pci_bus_size_bridges(bus, NULL);
 	__pci_bus_assign_resources(bus, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_bus_size_and_assign_resources);
-- 
2.47.3

