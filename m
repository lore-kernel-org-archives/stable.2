Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648225;
	b=UcPeb9rOHQMT57lVzkyDjr4obou7zaVI8+29sMg+PgBc8fuJdOXKJPuCLzxKghJvhDqG
	 zWZf1dwHhQFwXG0fUoEEzfDCGkD8NCjpN8xWtD7ZWh6nonzvD5uVrByPo87XzAm3dOlhp
	 W5+wxkGuKdFsGc5FYq2c6pOdmHL9b+Kr3cI8DZEDbEQM6Dy/jXx7Zc9YT/8J7zhFVquBD
	 k3yzWdFN4dp3CCbP17mOZw9dqxGpVOAnQkTbIqF9vEanYheDHmATMs7J109dMosmbU1kc
	 +4p9ebEzj+8POQ2JBb3f12V2UX+mcMA9RcGk2DcJMuwu2Mb7n1Tqhm7xNjAFTlG65bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648225;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TbkfL66m9ECDiQK36aAmap5xmwD9r6tD/pr0s1W5frk=;
	b=VrTz88z3l306hmAygbehIzQNn3j5bbCWIjv4N7CdWdNUX55aRf8mrdqop5zNeLM82Xpc
	 yWzCCiLzLaWTQVl9k74+1q4x3IY/qejK3OJdxmVErl1KeuIBEWFQEt41WCI8B7kZNVqwJ
	 FggQPGdzr3sxxBoccJZr+s5uhJM1W4baEFQrMGRW76x0oo8j9zyAX/OLkmEpfkPMdNL2M
	 uEYb4DAgqXNOcB2atRkCX2zwW34Y/2CJU7bwIYPS2uYzm4cGxSRZKES2+Xu34z6IuooHO
	 1od7q8pnk37eZIrlQrtl6rZeAf8AQWknWKeMAW/+GvszSiQO6ImflrjnSqTRF4lUPvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NjtOBh6T;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D8606A326;
	Wed, 25 Nov 2026 23:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 845D8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NjtOBh6T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648225; x=1827184225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7geqW9zhuBY3AfdSKl5WstwumJN3yFgf/R+Sx8dEEX8=;
  b=NjtOBh6TEHL9mcFVD2LzOHvZ9ZQyHmnuHnOWRcCPzhXH+dJkbuX+ej7n
   ObNsgaAP2v/dGOUI4TwTBdeV7maF5zN0Ti3Q+9LoLgEbnBPACd5LuIcmJ
   uoz9e+za81h+IvLw1C+m+wfhBAqsIcecpqUmkpeI23hiuZoeK6VelcEmX
   x/a4L6bXQz72N5rn6rH3qgnERkelcAqU1MBWamBVXTUV4hfZ/PPrYHwp3
   KLqzjGLC44UoCsxeDQLxib3lISmUk0BECoQDqp7LdFffkSz5sdWUg4/2L
   q+oeujFB/HwmItcdjZoRxr8rtrgNsEjWYJLxBA9VcifmQOvwibzvgKiTQ
   g==;
X-CSE-ConnectionGUID: wnJ4pCOwRf+Kaur8InlPpw==
X-CSE-MsgGUID: 31BIHow4RCOXgZFhuxliuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4537960"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4537960"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:24 -0800
X-CSE-ConnectionGUID: X8g9jJXWRLyTWiymmh82iA==
X-CSE-MsgGUID: AEymLCsxStOFyXPB7UXK3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11866226"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 04/17] PCI: Add pci_assign_unassigned_slot_resources()
Date: Thu, 26 Nov 2026 01:09:03 +0200
Message-ID: <20261125230925.2441-5-ilpo.jarvinen@linux.intel.com>
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

Bridge window sizing and resource assignment need locks that are held
across both phases. acpiphp open-codes
pci_assign_unassigned_bus_resources() with a slot filter by calling the
internal sizing and assignment functions directly, so it would have to
duplicate that locking.

Add pci_assign_unassigned_slot_resources() which sizes only the bridges
in the given slot, and implement pci_assign_unassigned_bus_resources()
with it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/pci.h       |  1 +
 drivers/pci/setup-bus.c | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..ce29d9ca0194 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -542,6 +542,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus,
 void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *add_list,
 				struct list_head *fail_head);
+void pci_assign_unassigned_slot_resources(struct pci_bus *bus, u16 slot);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 void pci_walk_bus_locked(struct pci_bus *top,
 			 int (*cb)(struct pci_dev *, void *),
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 10b9d3eb2864..7d135ddd93b2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2489,19 +2489,38 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 						    exclude_bars);
 }
 
-void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
+/**
+ * pci_assign_unassigned_slot_resources - Size and assign resources of a slot
+ * @bus: PCI bus
+ * @slot: Slot whose bridges to size, or %PCI_SLOT_ALL_DEVICES for all
+ *	  bridges on @bus
+ *
+ * Size the bridge windows of the bridges in @slot and assign unassigned
+ * resources on @bus.
+ */
+void pci_assign_unassigned_slot_resources(struct pci_bus *bus, u16 slot)
 {
 	struct pci_dev *dev;
 	/* List of resources that want additional resources */
 	LIST_HEAD(add_list);
 
 	down_read(&pci_bus_sem);
-	for_each_pci_bridge(dev, bus)
+	for_each_pci_bridge(dev, bus) {
+		if (slot != PCI_SLOT_ALL_DEVICES &&
+		    PCI_SLOT(dev->devfn) != slot)
+			continue;
+
 		if (pci_has_subordinate(dev))
 			__pci_bus_size_bridges(dev->subordinate, &add_list);
+	}
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 }
+
+void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
+{
+	pci_assign_unassigned_slot_resources(bus, PCI_SLOT_ALL_DEVICES);
+}
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
 
 void pci_bus_size_and_assign_resources(struct pci_bus *bus)
-- 
2.47.3

