Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182520;
	b=KXv9RRlHKh4TlyvS37b/8VpeaopW0mO/8byEINj6Txgg2ggj+jAYpEMqzyTChMqjBkN/
	 QXCRiDIDXfcUh7KKzLIAheCPdiLiPYPtrv907+/S0G4J4Nz/UemGAw58v8xBHL+A7oCSo
	 rL7LkA7Vv4HWIS3pj4UEnIEpXWQ6pStBNgavNHa+PG7DS145LbvZH4LhfmUrtqPrfqERB
	 a0pnakjQr1KiGK1J2sgjRl88OzS1518Asomal7fP0l1+/LmX5u66eWhtkhKr4TXUtUfxy
	 Y7pLTiIde/03VQOyrtkZ7E8NtkX+uTrzVvX5ElK9Ht1WYZXLT3Gx+aERuST6LkUsW+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182520;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4fK+6ZbUQkihZSQA+ZxMODq0NgQAawMbTk6w4scTUPw=;
	b=HYumdgLNZJqrIrVL5zDUN+V1PvCW8nJYtp7CPSWLAxZ99pRghMdZURpNa8IGRliGNL4S
	 8SfvRCJTGbbCGMSqqNCCEk+kZQShkFrOwbcM6sUB/PjnZsCFfNkCl4+qKOYN+7JbyHnou
	 LxhGIZk016WVPVhkcW8EgMBRMlDJkLypMaTjrprwaBCP56YDpA1XyHnQVVoWmlmpm8S61
	 /ujAe8kOPBcn8nTCVSVJdm5C5LjL4TLdUJhSH2FJHw4Foht5/oqtZMqkwKHpVVHTxoOI3
	 RdV1v9dQSXturWeDqUe0B9pFz3/ubEEqp/e0gzWRofQ/Pz1m4aCM0QAvCVqOBFDigyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BlX4G2W0;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452A606A320;
	Fri, 20 Nov 2026 13:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D452A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BlX4G2W0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182520; x=1826718520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sAUKTnmfNnMfLdVIOL6tIwDkY+pwM6xD80I3kb9YhKQ=;
  b=BlX4G2W0rBbqeymptUDh29QOj/QVtlfPoWLB+j4ADe/ACgPWAmMWT7U3
   /UzGsYAH0Tf+SlT6OzdBJ3q/Yb3bcyeoU+XL/Xw1GCWckljQWq4Bk0QX2
   g2jir72Nx+qYPp3gyX4HP4ps8nQLqN0md+bfcdSdjLFMqLPMMncfU6N4M
   lMeavZvMOfhvKMAViNG+R2FJ9jbbYIE9J120vzViJmwonL8PMAZG9LeEr
   SAODR5s6XGfvnOMbjPvY4lEQeIXFJZhF3ZKETL+3CzDKxu1v2BQdRszRE
   5fyxieNyi0iIyE/9pqFOxGe8+6Zy9w463wRdWEbg3aHL5EUHFhTjTMTG0
   w==;
X-CSE-ConnectionGUID: MgNPlqn8QD6J30H09GfyGw==
X-CSE-MsgGUID: Z9ybsvdrQJSFQuED0fov7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4140379"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4140379"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:40 -0800
X-CSE-ConnectionGUID: EqfS72DjTliTqxSv8XK0FA==
X-CSE-MsgGUID: dQIYTqlVR8e4I7dgwH6MNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10691476"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 07/16] PCI: Serialize bridge window sizing and resource assignment
Date: Fri, 20 Nov 2026 15:47:02 +0200
Message-ID: <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>
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

Add pci_res_setup_lock and hold it across sizing and assignment in all
entrypoints. Assert the lock is held in the functions that modify
resources deeper in the call chains. In
pci_do_resource_release_and_resize(), take the lock before selecting the
bridge window and setting the BAR size as both depend on or change
resource state.

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


 drivers/pci/setup-bus.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 966e0f243032..f501fa63caab 100644
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
@@ -40,6 +41,17 @@
 unsigned int pci_flags;
 EXPORT_SYMBOL_GPL(pci_flags);
 
+/*
+ * Serializes bridge window sizing, resource fitting, and assignment.
+ * pci_rescan_remove_lock cannot be used for this because BAR resize and
+ * some drivers run these operations under device_lock() during probe.
+ *
+ * Context:
+ *  - Nests inside pci_rescan_remove_lock and device_lock().
+ *  - Nests outside pci_bus_sem.
+ */
+static DEFINE_MUTEX(pci_res_setup_lock);
+
 struct pci_dev_resource {
 	struct list_head list;
 	struct resource *res;
@@ -135,6 +147,8 @@ static void pci_dev_res_restore(struct pci_dev_resource *dev_res)
 	int idx = pci_resource_num(dev, res);
 	const char *res_name = pci_resource_name(dev, idx);
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	if (WARN_ON_ONCE(resource_assigned(res)))
 		return;
 
@@ -613,6 +627,8 @@ static void __assign_resources_sorted(struct list_head *head,
 	unsigned long fail_type;
 	resource_size_t align;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	if (!realloc_head)
 		realloc_head = &dummy_head;
 
@@ -895,6 +911,8 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 {
 	struct pci_dev *bridge = bus->self;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	pci_info(bridge, "PCI bridge to %pR\n", &bus->busn_res);
 
 	if (type & IORESOURCE_IO)
@@ -975,6 +993,8 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	struct pci_dev *bridge = bus->self;
 	struct resource *b_res;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	b_res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
 	b_res->flags |= IORESOURCE_MEM;
 
@@ -1079,6 +1099,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	if (!b_res)
 		return;
 
@@ -1288,6 +1310,8 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	resource_size_t children_add_size = 0;
 	resource_size_t add_align = 0;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	if (!b_res)
 		return;
 
@@ -1459,6 +1483,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 void pci_bus_size_bridges(struct pci_bus *bus)
 {
+	guard(mutex)(&pci_res_setup_lock);
 	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_size_bridges(bus, NULL);
 }
@@ -1488,6 +1513,8 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 {
 	struct resource *r;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	pci_dev_for_each_resource(dev, r) {
 		struct pci_bus *b;
 
@@ -1552,6 +1579,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 void pci_bus_assign_resources(const struct pci_bus *bus)
 {
+	guard(mutex)(&pci_res_setup_lock);
 	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, NULL, NULL);
 }
@@ -1665,6 +1693,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	struct pci_dev *dev = bus->self;
 	int idx, ret;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	if (!resource_assigned(b_win))
 		return;
 
@@ -1862,6 +1892,8 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 	resource_size_t add_size, size = resource_size(res);
 	struct pci_dev_resource *dev_res;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	if (resource_assigned(res))
 		return;
 
@@ -2194,6 +2226,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
+	guard(mutex)(&pci_res_setup_lock);
 	guard(rwsem_read)(&pci_bus_sem);
 
 	/* Don't realloc if asked to do so */
@@ -2272,6 +2305,7 @@ static void pci_bridge_size_and_assign_resources(struct pci_dev *bridge)
 	int tried_times = 0;
 	LIST_HEAD(fail_head);
 
+	guard(mutex)(&pci_res_setup_lock);
 	guard(rwsem_read)(&pci_bus_sem);
 
 	while (1) {
@@ -2330,6 +2364,8 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 	unsigned int i;
 	int ret = 0;
 
+	lockdep_assert_held(&pci_res_setup_lock);
+
 	while (!pci_is_root_bus(bus)) {
 		bridge = bus->self;
 		res = pbus_select_window(bus, res);
@@ -2401,6 +2437,7 @@ static int __pci_do_resource_release_and_resize(struct pci_dev *pdev,
 	unsigned int i;
 	int old, ret;
 
+	lockdep_assert_held(&pci_res_setup_lock);
 	lockdep_assert_held(&pci_bus_sem);
 
 	b_win = pbus_select_window(bus, res);
@@ -2495,6 +2532,7 @@ static int __pci_do_resource_release_and_resize(struct pci_dev *pdev,
 int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size,
 				       int exclude_bars)
 {
+	guard(mutex)(&pci_res_setup_lock);
 	guard(rwsem_read)(&pci_bus_sem);
 
 	return __pci_do_resource_release_and_resize(pdev, resno, size,
@@ -2516,6 +2554,7 @@ void pci_assign_unassigned_slot_resources(struct pci_bus *bus, u16 slot)
 	/* List of resources that want additional resources */
 	LIST_HEAD(add_list);
 
+	guard(mutex)(&pci_res_setup_lock);
 	guard(rwsem_read)(&pci_bus_sem);
 	for_each_pci_bridge(dev, bus) {
 		if (slot != PCI_SLOT_ALL_DEVICES &&
@@ -2536,6 +2575,7 @@ EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
 
 void pci_bus_size_and_assign_resources(struct pci_bus *bus)
 {
+	guard(mutex)(&pci_res_setup_lock);
 	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_size_bridges(bus, NULL);
 	__pci_bus_assign_resources(bus, NULL, NULL);
-- 
2.47.3

