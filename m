Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903558E2AC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963527; cv=none; b=Z/zjINtD8XYtnO6taE4sjLnaSc9y/7dfq7Lqad9lT5mdIfHTOBkckh426x5kZ4KcnI+vrKX2S35e/naAIrgH+cwkCK8NfLP7dUOF4E7ltv1tFNas2brIUCsCHoKRmPrWs0sxbV2ijJYBX5incQKD0wmiOrS5SRLFE9Mq8KvWyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963527; c=relaxed/simple;
	bh=DT7djPtWLJtZWFHLfUr2iNMwugRvIYpfSf6hf8kx0IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivhR7oTEm7rFJvCaBXw0dku/90jKy1T9mg55XpEiwS5pUSJF5W9wYXrPNbTzAMq+H1ncX2VKnL7VrFfjcxOQL+bGcRsIAmZiM/BPhF5w/OMe7OIU4VXJ0Sf5pMdp+lWm+gp+O8W7GLgZUxcqlkxZ9gLpEWNvuMaxCHGWWzneSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEsDTjG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEsDTjG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D5F1F00A3F;
	Wed,  9 Sep 2026 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963525;
	bh=HbSpiF8EALlESm9PvKZ5hZ0HGOaeoOR5Z4DTrKLoelk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hEsDTjG9WsP/1IZn/e1dC0Ln25NHgu+4xmo9gZx9aR78z5jSd6jQSxXPJwoh8zlSr
	 dSJSD9v+AB+BTmSJSLE0fNdsIfDFjcJbwxxgXVYVwlWy/EK9V2zjQ+G/7oXNqUT1wd
	 Gbb9HNUeAf23gt3VLWZSKOqVVHTM/+3NJaiAqZY2sw4Zd8A/3swnGKI5ZuMu485wkc
	 267crMPclsAeWf+DHQC8MX2c/eg7a3Njqq+HfhcIYjoCz0CRfItEPSCuTsvz1+4Gss
	 ijhPxsQYHk32xRPQuEDQjqextCJHqj6Cgu3JjDK9zgxovf8JMDiL8DnL6DNpEWW2mn
	 /9WoQyLAPXu+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] PCI: Allow per function PCI slots to fix slot reset on s390
Date: Wed,  9 Sep 2026 10:18:42 -0400
Message-ID: <20260909141842.2422116-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141842.2422116-1-sashal@kernel.org>
References: <2026090355-script-eleven-4176@gregkh>
 <20260909141842.2422116-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Farhan Ali <alifm@linux.ibm.com>

[ Upstream commit dcc5bec09e23bbc4f9de055a11fce9937244f2c8 ]

On s390 systems, which use a machine level hypervisor, PCI devices are
always accessed through a form of PCI pass-through which fundamentally
operates on a per PCI function granularity. This is also reflected in the
s390 PCI hotplug driver which creates hotplug slots for individual PCI
functions. Its reset_slot() function, which is a wrapper for
zpci_hot_reset_device(), thus also resets individual functions.

Currently, the pci_create_slot() assigns the same pci_slot object to
multifunction devices. This approach worked fine on s390 systems that only
exposed virtual functions as individual PCI domains to the operating
system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
s390 supports exposing the topology of multifunction PCI devices by
grouping them in a shared PCI domain. This creates a problem when resetting
a function through the hotplug driver's slot_reset() interface.

When attempting to reset a function through the hotplug driver, the shared
slot assignment causes the wrong function to be reset instead of the
intended one. It also leaks memory as we do create a pci_slot object for
the function, but don't correctly free it in pci_slot_release().

Add a flag for struct pci_slot to allow per function PCI slots for
functions managed through a hypervisor, which exposes individual PCI
functions while retaining the topology. Since we can use all 8 bits for
slot 'number' (for ARI devices), change slot 'number' u16 to account for
special values PCI_SLOT_PLACEHOLDER and PCI_SLOT_ALL_DEVICES.

Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260805165518.794-3-alifm@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c   |  5 +++--
 drivers/pci/slot.c  | 29 +++++++++++++++++++++++------
 include/linux/pci.h |  7 ++++---
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 451ee220f9541..dfb2509ffdaf9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4899,8 +4899,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 
 static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 {
-	if (dev->multifunction || dev->subordinate || !dev->slot ||
-	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
+	if (dev->subordinate || !dev->slot ||
+	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
+	    (dev->multifunction && !dev->slot->per_func_slot))
 		return -ENOTTY;
 
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 4cdef17152779..bd536f30c5280 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -73,6 +73,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
 	return bus_speed_read(slot->bus->cur_bus_speed, buf);
 }
 
+static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *slot)
+{
+	if (slot->per_func_slot)
+		return dev->devfn == slot->number;
+
+	return slot->number == PCI_SLOT_ALL_DEVICES ||
+		PCI_SLOT(dev->devfn) == slot->number;
+}
+
+static bool pci_slot_enabled_per_func(void)
+{
+	if (IS_ENABLED(CONFIG_S390))
+		return true;
+
+	return false;
+}
+
 static void pci_slot_release(struct kobject *kobj)
 {
 	struct pci_dev *dev;
@@ -83,8 +100,7 @@ static void pci_slot_release(struct kobject *kobj)
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (slot->number == PCI_SLOT_ALL_DEVICES ||
-		    PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -177,8 +193,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (slot->number == PCI_SLOT_ALL_DEVICES ||
-		    PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -288,6 +303,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot->bus = pci_bus_get(parent);
 	slot->number = slot_nr;
 
+	if (pci_slot_enabled_per_func())
+		slot->per_func_slot = 1;
+
 	slot->kobj.kset = pci_slots_kset;
 
 	slot_name = make_slot_name(name);
@@ -310,8 +328,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
-		    PCI_SLOT(dev->devfn) == slot_nr)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f4ec39d5add44..32357dd88005d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -78,17 +78,18 @@
  * and, if ARI Forwarding is enabled, functions may appear to be on multiple
  * devices.
  */
-#define PCI_SLOT_ALL_DEVICES	0xfe
+#define PCI_SLOT_ALL_DEVICES	0xfeff
 
 /* Used to identify a slot as a placeholder */
-#define PCI_SLOT_PLACEHOLDER	0xff
+#define PCI_SLOT_PLACEHOLDER	0xffff
 
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
-	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
+	u16			number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
+	unsigned int		per_func_slot:1; /* Allow per function slot */
 	struct kobject		kobj;
 };
 
-- 
2.53.0

