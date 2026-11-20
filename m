Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182492;
	b=ga8ImmP6dVOTuLDYi9A11rGZPjayclMJW+N+sKIm1bANsjFxUruWLMYe/KpzwHRNoib6
	 hv2xedxYx/4172KMUGPlviKzg0br5LLoFcCJPx+jeJeBWmgLKdGm1xJckQOh2OjinIgHL
	 vFNxWm6kFNJx5KPrrT1sMlVIjWOl/md4wTk0gv89OJ9uo0GbmQ1tZabUKQlGrpwAKlXKd
	 5AccDQogh7t4aHpQAkKH9uvI2lKOkC+Zpo8GkEl+NTB3zgtiSwp4XXWWHqIYSZOwXEJck
	 8ZyzJQzGzXtRgvp/szDCGmlq/yteqQy5ipZ9XZZcuV2jW7fYcfC3ncZX+OR2gp42lIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182492;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TbkfL66m9ECDiQK36aAmap5xmwD9r6tD/pr0s1W5frk=;
	b=ekmS9dycJgK5OW4+/yUKFY0VSu4FnjG8QWrwe1aaD0XlRUsfpOxekZ0K0/4fiI9zimFx
	 CzokrcvTLzx5BHGHFiwUmJFUpfRdqzW33aWL5k/kicgPo4zCWbIl9qyvNAzmsSfgIpSJX
	 Ok49wbvjuW3/g4//Dd5XhJcCDfrqRIIei48YKzxcHQCQ4K/9bmtnKLXbKWwPIr0Y1mCyT
	 fOs8YeFVlpGYXfBjsMEOnOFeiCpRl5X6wzR9lxGZ68vpJBAhFaOmZOqnXr8lodXZmXb+P
	 I4VtOuSHbYBG3PFLdscsRptB8+0pqAg2UkqypljEWHfJsxTewevc7RHYXqqJshVbMjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ZFVJ8/W2";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA4606A320;
	Fri, 20 Nov 2026 13:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCA4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZFVJ8/W2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182493; x=1826718493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7geqW9zhuBY3AfdSKl5WstwumJN3yFgf/R+Sx8dEEX8=;
  b=ZFVJ8/W20uulw7H8ajmZqIld7QSdnIAa7IBrw4b6ShmTzTdWI/Ci4wbY
   nCo32IvACI2yCnluBUmq/xgJwhMopUrHPgA0riXPT75uSLJ+bVWW0gqOc
   T6m99AR/7MUheI2CYTkmYzIpGRsGh7DvZTcH5qYArSnwsAJAq5oxIku8f
   ESnVij7Tzbyu/yxsBnXQxhBQMJykYb0IIfeP5z6oRW2dOjiQK5R4C0YMJ
   PemoUpps3NWaQ6u8F2PyrhwBMhU5Pg7kmHUPnvbQ7+gJpHs8xvW4Hzq0Q
   FugINW1mDq4Y9/sQIiiLWfXu9OY3oZynjkznkrGt5cQazQbpL9hc5f4wI
   w==;
X-CSE-ConnectionGUID: w+29hkMkTZmX3bPOLZICVQ==
X-CSE-MsgGUID: eE7AiM63TmuoYZuprzPy+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3955114"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3955114"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:12 -0800
X-CSE-ConnectionGUID: IFTuiv81ToO1OlzGznR03A==
X-CSE-MsgGUID: gMTNQYk5RNGsOj/b2rQcGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10971348"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:09 -0800
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
Subject: [PATCH v2 04/16] PCI: Add pci_assign_unassigned_slot_resources()
Date: Fri, 20 Nov 2026 15:46:59 +0200
Message-ID: <20261120134716.3027-5-ilpo.jarvinen@linux.intel.com>
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

