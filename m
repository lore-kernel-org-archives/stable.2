Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648262;
	b=L5cEqOmKeXNc0GLCEMiC5TK1e/VmUAezjI0saSICffwOVj9QO9gfS9YCuLPA5gtKQ/P5
	 m+Er84K8oyu7mlkm6AOk324yLM6U17b4TsGRvqcdJrpWXunhbkVHteH+j1XTRfQWTEMAK
	 O7x+OaGXvboIAW0REL8OWdabzmeDMdPoo6vbuI1/aQci4I7FUacUvUFXbd0OllckED9ut
	 ZPV7LbzeScK9MjSdZyMEY20CLSwCJL/Cxyzys0EZQulB3SIFJhFZE3EQqruiMFE/8Vf4Y
	 cDDfgzSG62ruzKsDAdmDL7s5l1QNb6aid9BzFPpRHjeGD/Xlw6rT/HCBh5uC9YbMBNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648262;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZlWvbo0G3EWhyflb2b3wFiXMngCswG9W19sJIN+8kkc=;
	b=TNHWiL1UhR1y6co2Yre/wBdmXT+UTIe3P/IqApJqZ+1XfVbuti4kLtGd20fPnai20Dl8
	 Cnppp7JN5+lwa8JLFpfC0tcZkVmAZ9zsComQQ9oRQeX+LkeRF5aG98hPledXokMvjbWvi
	 RrvTwjoglStItOdRAUAAwfgUdXT5gxBwdZSgq9ndhmE48qjNQi8Ky3pxJ8Pl2ILgu67ex
	 sPGPc1/Q2GpVsBYXK8z71XB7DY7bUmwx6KWNBpYyeCmqUwbAlt3XD33Y5iCOfn7BfTtCp
	 QFAYat0necOrw/oq/omsNb5vbX6G+HzrFN7ySVxQWyAD6g0a4oxkMOJDg+ctBWUH2dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=InqQ1CaC;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345B606A31E;
	Wed, 25 Nov 2026 23:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F345B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=InqQ1CaC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648263; x=1827184263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zab2d+3Rn/CIHTpQf6PW4y1o/CuAQ8nnPCEbFYfcg3E=;
  b=InqQ1CaC/qviblht5YmUID2idoWDryecOZLDslQwri4Ovz2x1eGnQ2wX
   7PWB7J6n5or8lUQX62Tydw2cXXb2ySYOr9eds9AisRZgTbStA0ytEwMKO
   E953CRd57Q527Si+LXZGSBrfcjxEb18slQfznb5viA4ivYkHb2SHZtG8y
   KsjShbAbd6lRBf0s8HXqt0LMhtcOcmG5AevJRj8m/tvo98laCp0U30o7i
   wrpX/PcgsjHXON3rUMyy1JU8wHDw3xhuWGV19lh51XBKu7hjl46vMtnUq
   qUUH0rAvwn1GN5W6aC/cR4gNOTj2qWVQDOz8/LPCzztIa5ulBObs1SNjK
   Q==;
X-CSE-ConnectionGUID: WJa5jZdUR9+vOKPyldtLsA==
X-CSE-MsgGUID: IEMpphAfRviVtd2klvMzSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4469429"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4469429"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:02 -0800
X-CSE-ConnectionGUID: Joa6xaeaSVeh7hC1Jgaknw==
X-CSE-MsgGUID: kmzqa+iaRC+HtMmbJFOtQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11980289"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 08/17] PCI: Serialize bridge window sizing and resource assignment
Date: Thu, 26 Nov 2026 01:09:07 +0200
Message-ID: <20261125230925.2441-9-ilpo.jarvinen@linux.intel.com>
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

Bridge window sizing and resource assignment are started from multiple
entrypoints: rescan and hotplug under pci_rescan_remove_lock, and BAR
resize from sysfs or driver probe under device_lock() only. The
entrypoints hold pci_bus_sem only for read, so nothing prevents two
sizing and assignment passes from running concurrently on the same
bridge windows and BARs. E.g., a rescan may assign a BAR that a
concurrent BAR resize has released, or restore a resource the resize has
already assigned.

Looping BAR resize through sysfs against a rescan of the parent bus on a
system with a BMG GPU triggers the add_list sanity check. The rescan
sizes the Downstream Port's prefetchable window while the resize assigns
it, and the sizing values overwrite the assigned window. The resize then
programs these values into the Downstream Port, outside the root bus
resources and overlapping System RAM [mem 0x100000000-0x4075ffffff]. The
rescan skips assigning the window as it looks assigned, which leaves its
add_list entry unused:

  pci_bus 0000:b7: root bus resource [mem 0xd6000000-0xddfbffff window]
  pci_bus 0000:b7: root bus resource [mem 0x2e0000000000-0x2effffffffff window]
  pcieport 0000:b9:01.0: bridge window [mem 0x800000000-0x1000ffffff 64bit pref] to [bus ba] add_size 4000000 add_align 800000000
  pcieport 0000:b9:01.0: PCI bridge to [bus ba]
  pcieport 0000:b9:01.0:   bridge window [mem 0xdda00000-0xddbfffff]
  pcieport 0000:b9:01.0:   bridge window [mem 0x800000000-0x1000ffffff 64bit pref]
  add_list && !list_empty(add_list)
  WARNING: drivers/pci/setup-bus.c:1546 at pci_assign_unassigned_bus_resources+0x9e/0x130, CPU#58: srf8-resize-rac/2861
  CPU: 58 UID: 0 PID: 2861 Comm: srf8-resize-rac Tainted: G S                  7.4.0-rc1-g6628e7d4c6b2 #59 PREEMPT(full)
  RIP: 0010:pci_assign_unassigned_bus_resources+0x9e/0x130
  Call Trace:
   pci_rescan_bus+0x20/0x40
   dev_rescan_store+0x6e/0x90

Other trigger vectors are possible as well. Hotplug takes the same locks
as the sysfs rescan. BAR resize walks the bridge windows up to the Root
Port to make room for the resized BAR, and then sizes and assigns the
whole hierarchy below the Root Port. Thus, hotplug anywhere below the
same Root Port can race with the resize, e.g., when connecting a
Thunderbolt device. Instead of the sysfs resize, a driver can resize a
BAR during probe, e.g., after unbind and bind.

pci_rescan_remove_lock cannot be taken under device_lock() because the
device removal path takes them in the opposite order.

Add res_setup_lock into struct pci_host_bridge and hold it across sizing
and assignment in all entrypoints. Sizing and assignment only operate
within the hierarchy of a single host bridge, so serializing them per
host bridge is enough. Assert the lock is held in the internal functions
the entrypoints call. In pci_do_resource_release_and_resize(), take the
lock before selecting the bridge window and setting the BAR size as both
depend on or change resource state.

The race was also reproduced in QEMU, which found more symptoms.
Looping BAR resize through sysfs against a rescan of the parent bus on
a guest with 512M of RAM, using a synthetic host bridge with a Root Port
and an Endpoint with a Resizable BAR, triggers the following failures:

1) Both the rescan and the resize release the Root Port's prefetchable
   window. Both find it assigned, but the rescan releases it first, and
   the resize then dereferences the NULL parent in __release_resource():

     pcieport 10000:00:00.0: bridge window [mem 0x940000000-0x97fffffff 64bit pref]: releasing
     pcieport 10000:00:00.0: bridge window [mem size 0x40000000 64bit pref]: releasing
     BUG: kernel NULL pointer dereference, address: 0000000000000038
     Oops: Oops: 0000 [#1] SMP
     CPU: 0 UID: 0 PID: 49 Comm: init Not tainted 7.4.0-rc1-00001-g4aa3acaaeb08 #1 PREEMPTLAZY
     RIP: 0010:__release_resource+0x8/0x70
     Call Trace:
      release_resource+0x22/0x40
      pci_release_resource+0x54/0x90
      pci_do_resource_release_and_resize+0x1f3/0x3d0
      __resource_resize_store+0xf0/0x180

2) The rescan restores a resource that has already been assigned:

     WARNING: drivers/pci/setup-bus.c:136 at pci_dev_res_restore+0x32/0x90, CPU#0: init/1
     CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.4.0-rc1-dirty #6 PREEMPTLAZY
     RIP: 0010:pci_dev_res_restore+0x32/0x90
     Call Trace:
      __assign_resources_sorted+0x2db/0x570
      __pci_bus_assign_resources_one+0x57/0x190
      __pci_bus_assign_resources_one+0x12d/0x190
      __pci_bus_assign_resources+0xd/0x30
      pci_assign_unassigned_bus_resources+0x6f/0x80
      pci_rescan_bus+0x1a/0x30
      dev_rescan_store+0x46/0x60

3) The rescan assigns the BAR while the resize is assigning it, failing
   the resize:

     pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x90fffffff 64bit pref]: releasing
     pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x90fffffff 64bit pref]: releasing
     pci 10000:01:00.0: BAR 0 [mem size 0x40000000 64bit pref]: can't assign; no space
     pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x93fffffff 64bit pref]: assigned
     pci 10000:01:00.0: BAR 0 [mem size 0x40000000 64bit pref]: failed to assign
     pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x93fffffff 64bit pref]: releasing
     pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x93fffffff 64bit pref]: assigned
     pci 10000:01:00.0: BAR 0 [mem size 0x40000000 64bit pref]: resource restored
     pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x90fffffff 64bit pref]: old value restored
     pci 10000:01:00.0: Failed to resize BAR 0: -28

4) While one pass is sorting a released bridge window for assignment,
   the other pass assigns it, which clears IORESOURCE_STARTALIGN. The
   window then has zero alignment:

     pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x93fffffff 64bit pref]: releasing
     pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x93fffffff 64bit pref]: releasing
     pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x90fffffff 64bit pref]: assigned
     pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x90fffffff 64bit pref]: alignment must not be zero
     pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x90fffffff 64bit pref]: assigned

5) BAR 0 loses its flags and the Root Port's prefetchable window gets
   programmed over RAM, after which every BAR resize fails with -EINVAL:

     pci 10000:01:00.0: BAR 0 [mem size 0x10000000 64bit pref]: can't assign; no space
     resource: remaining [mem 0x000000001ffdf000-0x000000001fffffff] available
     resource: avoiding allocation from e820 entry [mem 0x1ffdf000-0x1fffffff]
     pci 10000:01:00.0: BAR 0 [mem size 0x10000000 64bit pref]: failed to assign
     pci 10000:01:00.0: BAR 0 [mem size 0x10000000 64bit pref]: can't assign; no space
     pci 10000:01:00.0: BAR 0 [mem size 0x10000000 64bit pref]: resetting resource
     pci 10000:01:00.0: BAR 0 [??? 0x00000000 flags 0x0]: failed to assign
     pci 10000:01:00.0: BAR 0 [??? 0x00000000 flags 0x0]: resetting resource
     pcieport 10000:00:00.0: PCI bridge to [bus 01]
     pcieport 10000:00:00.0:   bridge window [mem 0x20000000-0x200fffff]
     pcieport 10000:00:00.0:   bridge window [mem 0x10000000-0x1fffffff 64bit pref]
     pci 10000:01:00.0: Failed to resize BAR 0: -22

Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
Suggested-by: David Matlack <dmatlack@google.com> # put the new lock to pci_host_bridge
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Cc: stable@vger.kernel.org
---

Bjorn,

It's up to you if you want to keep all those qemu reproduced cases in the
changelog. You usually seem to prefer the log messages for easier googling
in case somebody happens to hit the issue so I added them all.

I couldn't get the rest to trigger on a real host but that could be due to
serial output that was too slow to keep up with the test loops which might
have affected timing.


 drivers/pci/probe.c     |  2 ++
 drivers/pci/setup-bus.c | 20 ++++++++++++++++++++
 include/linux/pci.h     | 12 ++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..4aff60ef66d5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -641,6 +641,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
 		pci_bus_release_emul_domain_nr(bridge->domain_nr);
 
+	mutex_destroy(&bridge->res_setup_lock);
 	kfree(bridge);
 }
 
@@ -663,6 +664,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
 	INIT_LIST_HEAD(&bridge->ports);
+	mutex_init(&bridge->res_setup_lock);
 
 	/*
 	 * We assume we can manage these PCIe features.  Some systems may
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 966e0f243032..b2173e1d9db0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -27,6 +27,7 @@
 #include <linux/cache.h>
 #include <linux/limits.h>
 #include <linux/lockdep.h>
+#include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -40,6 +41,11 @@
 unsigned int pci_flags;
 EXPORT_SYMBOL_GPL(pci_flags);
 
+static struct mutex *pci_res_setup_lock(const struct pci_bus *bus)
+{
+	return &pci_find_host_bridge(bus)->res_setup_lock;
+}
+
 struct pci_dev_resource {
 	struct list_head list;
 	struct resource *res;
@@ -1396,6 +1402,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	struct pci_host_bridge *host;
 	int hdr_type;
 
+	lockdep_assert_held(pci_res_setup_lock(bus));
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
 		if (!b)
@@ -1459,6 +1467,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 void pci_bus_size_bridges(struct pci_bus *bus)
 {
+	guard(mutex)(pci_res_setup_lock(bus));
 	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_size_bridges(bus, NULL);
 }
@@ -1544,6 +1553,8 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *add_list,
 				struct list_head *fail_head)
 {
+	lockdep_assert_held(pci_res_setup_lock(bus));
+
 	__pci_bus_assign_resources_one(bus, add_list, fail_head);
 
 	if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
@@ -1552,6 +1563,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 void pci_bus_assign_resources(const struct pci_bus *bus)
 {
+	guard(mutex)(pci_res_setup_lock(bus));
 	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, NULL, NULL);
 }
@@ -2194,6 +2206,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
+	guard(mutex)(pci_res_setup_lock(bus));
 	guard(rwsem_read)(&pci_bus_sem);
 
 	/* Don't realloc if asked to do so */
@@ -2272,6 +2285,7 @@ static void pci_bridge_size_and_assign_resources(struct pci_dev *bridge)
 	int tried_times = 0;
 	LIST_HEAD(fail_head);
 
+	guard(mutex)(pci_res_setup_lock(bridge->bus));
 	guard(rwsem_read)(&pci_bus_sem);
 
 	while (1) {
@@ -2330,6 +2344,8 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 	unsigned int i;
 	int ret = 0;
 
+	lockdep_assert_held(pci_res_setup_lock(bus));
+
 	while (!pci_is_root_bus(bus)) {
 		bridge = bus->self;
 		res = pbus_select_window(bus, res);
@@ -2401,6 +2417,7 @@ static int __pci_do_resource_release_and_resize(struct pci_dev *pdev,
 	unsigned int i;
 	int old, ret;
 
+	lockdep_assert_held(pci_res_setup_lock(bus));
 	lockdep_assert_held(&pci_bus_sem);
 
 	b_win = pbus_select_window(bus, res);
@@ -2495,6 +2512,7 @@ static int __pci_do_resource_release_and_resize(struct pci_dev *pdev,
 int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size,
 				       int exclude_bars)
 {
+	guard(mutex)(pci_res_setup_lock(pdev->bus));
 	guard(rwsem_read)(&pci_bus_sem);
 
 	return __pci_do_resource_release_and_resize(pdev, resno, size,
@@ -2516,6 +2534,7 @@ void pci_assign_unassigned_slot_resources(struct pci_bus *bus, u16 slot)
 	/* List of resources that want additional resources */
 	LIST_HEAD(add_list);
 
+	guard(mutex)(pci_res_setup_lock(bus));
 	guard(rwsem_read)(&pci_bus_sem);
 	for_each_pci_bridge(dev, bus) {
 		if (slot != PCI_SLOT_ALL_DEVICES &&
@@ -2536,6 +2555,7 @@ EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
 
 void pci_bus_size_and_assign_resources(struct pci_bus *bus)
 {
+	guard(mutex)(pci_res_setup_lock(bus));
 	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_size_bridges(bus, NULL);
 	__pci_bus_assign_resources(bus, NULL, NULL);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d03a2e277013..f535ab12b04e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/kobject.h>
@@ -646,6 +647,17 @@ struct pci_host_bridge {
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
 	struct list_head ports;		/* Root Port list (pci_host_port) */
+	/*
+	 * Serializes bridge window sizing, resource fitting, and assignment
+	 * below the host bridge. pci_rescan_remove_lock cannot be used for
+	 * this because these operations also run under device_lock(), e.g.,
+	 * BAR resize from sysfs or probe, and VMD probe.
+	 *
+	 * Context:
+	 *  - Nests inside pci_rescan_remove_lock and device_lock().
+	 *  - Nests outside pci_bus_sem.
+	 */
+	struct mutex	res_setup_lock;
 #ifdef CONFIG_PCI_IDE
 	u16 nr_ide_streams; /* Max streams possibly active in @ide_stream_ida */
 	struct ida ide_stream_ida;
-- 
2.47.3

