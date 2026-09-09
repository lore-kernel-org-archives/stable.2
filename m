Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6360576EC4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963278; cv=none; b=sXgKuJZXvEfRwIeLxbK4Sh8bliCR8UaQ7VbGSLnqZ++Ox19NMHtSYRuioJCxn6UOGnE4LfaoW1d9sTboOh3JvrLZajdyPY4hENYBaPMdLwde9u0LZ7l5Bpw20yAmVAuT+J9qsjn15WglSo9rvd7HQKtXzXP19QCFqkK6NQfk9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963278; c=relaxed/simple;
	bh=kfHl5Z4dXz/1+A1J/YEBl5r1tZRqmrFg5VCtvPQato4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bl7CRtv6uUp+tEJQqMA9KlasJb9MT4S0TIJXQ0XHFWlZzFJ318dK7jC1FBziqhIysS1xJfxnC2ZepOCfSOStvFKI6TsEdaNgSHNE+i8uBAgUrtn/8xqBduNovZuyjgt2vUoVf4DlLrcxTjxI0pmAvyzU/AgH63m6eoaZzxAdVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKEHAUoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKEHAUoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD891F00A3D;
	Wed,  9 Sep 2026 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963276;
	bh=5Z7PrhmmaiTRBNEEJ15S8uC/y1eYLX24pgiOcPWEXDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKEHAUoOmSMjyEHHrtLAymOugK6q5iMnmLGaF8iYHjRiH3EC+nw/wIvaC0sHj+WBX
	 PYKF/1CAGuea8PsTC1UnO5TYpzRNaulHNnxkcftPRqYs6hkxN6BmRmrxCKj+dWiRRH
	 jtc2XGUfm0wx8H771kbP40ci4rPR6eTVO+fNeYNJsRxxbss5sNm9yt73rZY1/I+INk
	 75xmiycmijVHTQWKatCkvD2v/vqIJfe13BT5mxvNMCb7oUktM8NJFVt0DHATQjlbIX
	 UxRyJaXEHMEtIe2aQc03u2AN7I9W+EweMfoNEcqznHveKYnjuEVIc0Iju1UXXlgF5V
	 zwybrfwyTuEJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
Date: Wed,  9 Sep 2026 10:14:33 -0400
Message-ID: <20260909141434.2391408-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-granular-yam-34d7@gregkh>
References: <2026090354-granular-yam-34d7@gregkh>
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

Stable backport: this tree predates 102c8b26b54e ("PCI: Allow all bus
devices to use the same slot"). Include its PCI_SLOT_ALL_DEVICES definition,
slot-number documentation, and core matching/address handling so that
subsequent commit dcc5bec09e23 ("PCI: Allow per function PCI slots to fix
slot reset on s390") applies without conflicts. Keep the PCIe hotplug
callers unchanged; enabling bus-wide slots there is outside this dependency.

Retain the stable tree's kzalloc() and ATTRIBUTE_GROUPS() implementations.
The placeholder conversion covers both PowerPC hotplug callers and the
PCI core. All code changes stay within existing functions.

Stable-dep-of: dcc5bec09e23 ("PCI: Allow per function PCI slots to fix slot reset on s390")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pnv_php.c     |  2 +-
 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/slot.c                | 50 +++++++++++++++++++++++--------
 include/linux/pci.h               | 13 +++++++-
 4 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index c5345bff9a553..e9c8f7fb22134 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -813,7 +813,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
-		php_slot->slot_no = -1;   /* Placeholder slot */
+		php_slot->slot_no = PCI_SLOT_PLACEHOLDER;   /* Placeholder slot */
 
 	kref_init(&php_slot->kref);
 	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 779eab12e9810..ac8c512190df4 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -85,7 +85,7 @@ int rpaphp_register_slot(struct slot *slot)
 	struct device_node *child;
 	u32 my_index;
 	int retval;
-	int slotno = -1;
+	int slotno = PCI_SLOT_PLACEHOLDER;
 
 	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
 		__func__, slot->dn, slot->index, slot->name,
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 50fb3eb595fe6..b5fbf2709fbd3 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,11 +37,20 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == PCI_SLOT_PLACEHOLDER)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
 
+	/*
+	 * Preserve legacy ABI expectations that hotplug drivers that manage
+	 * multiple devices per slot emit 0 for the device number.
+	 */
+	if (slot->number == PCI_SLOT_ALL_DEVICES)
+		return sysfs_emit(buf, "%04x:%02x:00\n",
+				  pci_domain_nr(slot->bus),
+				  slot->bus->number);
+
 	return sysfs_emit(buf, "%04x:%02x:%02x\n",
 			  pci_domain_nr(slot->bus),
 			  slot->bus->number,
@@ -73,7 +82,8 @@ static void pci_slot_release(struct kobject *kobj)
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -166,7 +176,8 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -188,7 +199,8 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), PCI_SLOT_PLACEHOLDER for placeholder, or
+ *	PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
  *
@@ -213,15 +225,26 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
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
+ *
+ * Bus-wide slots:
+ * For PCIe hotplug, the physical slot encompasses the entire secondary
+ * bus, not just a single device number. If the device supports ARI and ARI
+ * Forwarding is enabled in the upstream bridge, a multi-function device
+ * may include functions that appear to have several different device
+ * numbers, i.e., PCI_SLOT() values.  Pass @slot_nr == PCI_SLOT_ALL_DEVICES
+ * to create a slot that matches all devices on the bus. Unlike placeholder
+ * slots, bus-wide slots go through normal slot lookup and reuse existing
+ * slots if present.
  */
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
@@ -234,7 +257,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
@@ -285,7 +308,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot_nr)
+		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot_nr)
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 505bf6e009b18..5e80ab9dff2fb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -72,12 +72,23 @@
 /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
 
+/*
+ * PCI_SLOT_ALL_DEVICES indicates a slot that covers all devices on the bus.
+ * Used for PCIe hotplug where the physical slot is the entire secondary bus,
+ * and, if ARI Forwarding is enabled, functions may appear to be on multiple
+ * devices.
+ */
+#define PCI_SLOT_ALL_DEVICES	0xfe
+
+/* Used to identify a slot as a placeholder */
+#define PCI_SLOT_PLACEHOLDER	0xff
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
-	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
+	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
 	struct kobject		kobj;
 };
 
-- 
2.53.0

