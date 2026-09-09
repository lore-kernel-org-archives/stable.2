Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719EF52BE36
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954468; cv=none; b=ELuIykXzEQ2ahbwGTMHygs6DRAeQSoHKR4tR450dYKwKx1EG2VgtWIdMRYdQhGobpgWTrJo06/XRrA9/6ngQHdIIcPLSJKG6k5gVzpCcdSvyythewke4U2IuB+S04mzX+wAOXxBkd9x2NDE3CTm9YlvxMDGZYmmsX88c5zudvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954468; c=relaxed/simple;
	bh=p6fBFpgp7Ui6dwWWjnhpkauHz9MdRNBdn0rHlmde1tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAEvZbrmWt6LOGLzwqBNc2pXhVzGVUSUSbwUY2Up0TjHPRZyrAa/oJJ3mWMqVzUlMGjFt//vkfbk7axF564kCer1wi6MfDQIb68pXHih0hROxvvlu9k12Hi/LfpSx15BBOGrB2zig2KmeZ78sNmLJXCdSfrDnt8EWi2jOxdI03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMx9+ExY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMx9+ExY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1F51F00A3E;
	Wed,  9 Sep 2026 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954467;
	bh=4FMJhvapdKKb6WzklF//rh87WqjKfpkS9BGEshCeZEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cMx9+ExYccTVx8E1lRhBkZh1KPuspwWazNE8Bco00DiwmrFiINRLoyeiYjKX5aYxm
	 0FwWD7ediBHBMxrtmsBbMvnjlzv42CfDmibiwuD0t0p4fP+VsogteUlRmXaTMFFg2o
	 lPFH6LyNzn8rGQ1czHNX8Beq0gN4gqd/FdxmVmMzq1s+5C2xMk3Cdj/Br7JCrPDGNc
	 D9g2atKCleW8WJEVPj/tDuB0PNGAYHJ+DMYS7A0SyoYfhRwqq3K5R1uPLrs4FCVg/1
	 aZcQO/+TMDOAYN+bgzvpGfvILf4Ncxd9JbashLnfBZlI3omdPmRh/fZyw0NlzrFLDo
	 kfxB6sdQ6+how==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
Date: Wed,  9 Sep 2026 07:47:43 -0400
Message-ID: <20260909114744.2013430-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-paralyses-labored-e273@gregkh>
References: <2026090354-paralyses-labored-e273@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Farhan Ali <alifm@linux.ibm.com>

[ Upstream commit c243e6c470c4695965cc8287767925bc1d9a7867 ]

Introduce a constant for placeholder value and update the kerneldoc for
pci_create_slot() to reference PCI_SLOT_PLACEHOLDER instead of -1
throughout. No functional change.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://patch.msgid.link/20260805165518.794-2-alifm@linux.ibm.com
Stable-dep-of: dcc5bec09e23 ("PCI: Allow per function PCI slots to fix slot reset on s390")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pnv_php.c     |  2 +-
 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/slot.c                | 21 +++++++++++----------
 include/linux/pci.h               |  3 +++
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index ff92a5c301b81..37299d59f906f 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -808,7 +808,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
-		php_slot->slot_no = -1;   /* Placeholder slot */
+		php_slot->slot_no = PCI_SLOT_PLACEHOLDER;   /* Placeholder slot */
 
 	kref_init(&php_slot->kref);
 	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 67362e5b99719..92eabf5f61b9c 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -84,7 +84,7 @@ int rpaphp_register_slot(struct slot *slot)
 	struct hotplug_slot *php_slot = &slot->hotplug_slot;
 	u32 my_index;
 	int retval;
-	int slotno = -1;
+	int slotno = PCI_SLOT_PLACEHOLDER;
 
 	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
 		__func__, slot->dn, slot->index, slot->name,
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 6d5cd37bfb1e7..42ff66461f74a 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == PCI_SLOT_PLACEHOLDER)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
@@ -210,7 +210,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn), -1 for placeholder, or
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), PCI_SLOT_PLACEHOLDER for placeholder, or
  *	PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
@@ -236,15 +236,16 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
  * In most cases, @pci_bus, @slot_nr will be sufficient to uniquely identify
  * a slot. There is one notable exception - pSeries (rpaphp), where the
  * @slot_nr cannot be determined until a device is actually inserted into
- * the slot. In this scenario, the caller may pass -1 for @slot_nr.
+ * the slot. In this scenario, the caller may pass PCI_SLOT_PLACEHOLDER for @slot_nr.
  *
  * The following semantics are imposed when the caller passes @slot_nr ==
- * -1. First, we no longer check for an existing %struct pci_slot, as there
- * may be many slots with @slot_nr of -1.  The other change in semantics is
- * user-visible, which is the 'address' parameter presented in sysfs will
- * consist solely of a dddd:bb tuple, where dddd is the PCI domain of the
- * %struct pci_bus and bb is the bus number. In other words, the devfn of
- * the 'placeholder' slot will not be displayed.
+ * PCI_SLOT_PLACEHOLDER. First, we no longer check for an existing %struct
+ * pci_slot, as there may be many slots with @slot_nr of
+ * PCI_SLOT_PLACEHOLDER. The other change in semantics is user-visible,
+ * which is the 'address' parameter presented in sysfs will consist solely
+ * of a dddd:bb tuple, where dddd is the PCI domain of the %struct pci_bus
+ * and bb is the bus number. In other words, the devfn of the 'placeholder'
+ * slot will not be displayed.
  *
  * Bus-wide slots:
  * For PCIe hotplug, the physical slot encompasses the entire secondary
@@ -267,7 +268,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c1..b628787e9485c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -81,6 +81,9 @@
  */
 #define PCI_SLOT_ALL_DEVICES	0xfe
 
+/* Used to identify a slot as a placeholder */
+#define PCI_SLOT_PLACEHOLDER	0xff
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
-- 
2.53.0

