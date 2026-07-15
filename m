Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863D1A267
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083565; cv=none; b=S6GsCgZk5iKPI3uUToiaRxVW/jDyLBxggtDyZpOE9Y4+yO7Wb7RvaMW0ybth+iX+cNkcxsYz/A6tWYAfc2c8vky/FEjQOXTEGZ/7TR9HA8cEXAvVb87I5krVIYFpbGjLGpdSPWp+pR7jmeZ8VuEKxkylwddG/muBwuAiL2YmiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083565; c=relaxed/simple;
	bh=n3KMBAre60kb2y3NWQZjlNX2IMJljfDSi8tyXUiIXMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8rkGP1AXnwC0R/pw+8F0JDqBEdXfVszpOgzhBQmAC5G6mH5jNBhN78Hbf9eoJ/EQAKFNRaRr8MdmlTBBNTXEpX6/XHi3iRJfDD1DJq3lB62SbKWD4b5qr1erspETdGAM9Wkw92AcmKTZOSVBcjgPGiTNNAEN5fWs9IWKqVH2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk4XFDEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk4XFDEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AA61F00A3A;
	Wed, 15 Jul 2026 02:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083563;
	bh=tyAH3UiIKcHbPRkCVbbwQ/NWcti8OIRHHyVunw/V6DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yk4XFDEhmx0tqJmiQIRytMXL+6fxj5zkQ8EoeV14M3HlQcqp7w04v2+cggIaDMq3B
	 mVD1QkFYqWlrPsQHzzYJCEuuC0B4tXwTN8qHDAQSJ7B1MnftK46RoqXGLXG5TKm6dL
	 ayJXLAkIESMmXbn/5yut3Im433RviK3EKEeN5RhE089sn6e96jnuqdgLFDabQUIW3R
	 aZgm//Q9CJLmyqHjMg4KVeKkmLjCwWXDgoAYvNImZVAnYumix9lhLci0YsNguDTduZ
	 zHpuPSLFpgi6jtANzcEfyLdPZ4xiLeHWW5NJZnI4kfE/Fz5yQeJn9doKGbFCUgUixd
	 1f/Zvo1eVsKrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/6] PCI: Fix restoring BARs on BAR resize rollback path
Date: Tue, 14 Jul 2026 22:45:56 -0400
Message-ID: <20260715024559.106836-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024559.106836-1-sashal@kernel.org>
References: <2026071309-opal-shaking-a4ea@gregkh>
 <20260715024559.106836-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 337b1b566db087347194e4543ddfdfa5645275cc ]

BAR resize operation is implemented in the pci_resize_resource() and
pbus_reassign_bridge_resources() functions. pci_resize_resource() can be
called either from __resource_resize_store() from sysfs or directly by the
driver for the Endpoint Device.

The pci_resize_resource() requires that caller has released the device
resources that share the bridge window with the BAR to be resized as
otherwise the bridge window is pinned in place and cannot be changed.

pbus_reassign_bridge_resources() rolls back resources if the resize
operation fails, but rollback is performed only for the bridge windows.
Because releasing the device resources are done by the caller of the BAR
resize interface, these functions performing the BAR resize do not have
access to the device resources as they were before the resize.

pbus_reassign_bridge_resources() could try __pci_bridge_assign_resources()
after rolling back the bridge windows as they were, however, it will not
guarantee the resource are assigned due to differences in how FW and the
kernel assign the resources (alignment of the start address and tail).

To perform rollback robustly, the BAR resize interface has to be altered to
also release the device resources that share the bridge window with the BAR
to be resized.

Also, remove restoring from the entries failed list as saved list should
now contain both the bridge windows and device resources so the extra
restore is duplicated work.

Some drivers (currently only amdgpu) want to prevent releasing some
resources. Add exclude_bars param to pci_resize_resource() and make amdgpu
pass its register BAR (BAR 2 or 5), which should never be released during
resize operation. Normally 64-bit prefetchable resources do not share a
bridge window with the 32-bit only register BAR, but there are various
fallbacks in the resource assignment logic which may make the resources
share the bridge window in rare cases.

This change (together with the driver side changes) is to counter the
resource releases that had to be done to prevent resource tree corruption
in the ("PCI: Release assigned resource before restoring them") change. As
such, it likely restores functionality in cases where device resources were
released to avoid resource tree conflicts which appeared to be "working"
when such conflicts were not correctly detected by the kernel.

Reported-by: Simon Richter <Simon.Richter@hogyros.de>
Link: https://lore.kernel.org/linux-pci/f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de/
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/linux-pci/874irqop6b.fsf@draig.linaro.org/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[bhelgaas: squash amdgpu BAR selection from
https: //lore.kernel.org/r/20251114103053.13778-1-ilpo.jarvinen@linux.intel.com]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patch.msgid.link/20251113162628.5946-7-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.c |   2 +-
 drivers/pci/pci-sysfs.c                     |  14 +--
 drivers/pci/pci.h                           |   3 +
 drivers/pci/setup-bus.c                     | 101 ++++++++++++++------
 drivers/pci/setup-res.c                     |  19 +---
 include/linux/pci.h                         |   4 +-
 7 files changed, 87 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9d82edb89aab70..220a407d39adc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1272,7 +1272,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_release_resource(adev->pdev, 0);
 
-	r = pci_resize_resource(adev->pdev, 0, rbar_size);
+	r = pci_resize_resource(adev->pdev, 0, rbar_size,
+				(adev->asic_type >= CHIP_BONAIRE) ? 1 << 5
+								  : 1 << 2);
 	if (r == -ENOSPC)
 		DRM_INFO("Not enough PCI address space for a large BAR.");
 	else if (r && r != -ENOTSUPP)
diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
index f3ad93db0b21fa..83fbe150a335a6 100644
--- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
@@ -37,7 +37,7 @@ _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
 
 	_release_bars(pdev);
 
-	ret = pci_resize_resource(pdev, resno, bar_size);
+	ret = pci_resize_resource(pdev, resno, bar_size, 0);
 	if (ret) {
 		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
 			 resno, 1 << bar_size, ERR_PTR(ret));
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7670e3e2ecc5e5..7a55a1853c353c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1455,8 +1455,8 @@ static ssize_t resource##n##_resize_store(struct device *dev,		\
 					  const char *buf, size_t count)\
 {									\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	unsigned long size, flags;					\
-	int ret, i;							\
+	unsigned long size;						\
+	int ret;							\
 	u16 cmd;							\
 									\
 	if (kstrtoul(buf, 0, &size) < 0)				\
@@ -1481,17 +1481,9 @@ static ssize_t resource##n##_resize_store(struct device *dev,		\
 	pci_write_config_word(pdev, PCI_COMMAND,			\
 			      cmd & ~PCI_COMMAND_MEMORY);		\
 									\
-	flags = pci_resource_flags(pdev, n);				\
-									\
 	pci_remove_resource_files(pdev);				\
 									\
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {			\
-		if (pci_resource_len(pdev, i) &&			\
-		    pci_resource_flags(pdev, i) == flags)		\
-			pci_release_resource(pdev, i);			\
-	}								\
-									\
-	ret = pci_resize_resource(pdev, n, size);			\
+	ret = pci_resize_resource(pdev, n, size, 0);			\
 									\
 	pci_assign_unassigned_bus_resources(pdev->bus);			\
 									\
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8b177931cf21ef..97b24e913fa5d2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -242,6 +242,9 @@ enum pci_bar_type {
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
+int pci_do_resource_release_and_resize(struct pci_dev *dev, int resno, int size,
+				       int exclude_bars);
+
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9e8d37720ef67f..df345ebbb991fd 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2223,18 +2223,16 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
-int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
+static int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type,
+					 struct list_head *saved)
 {
 	struct pci_dev_resource *dev_res;
 	struct pci_dev *next;
-	LIST_HEAD(saved);
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
 	unsigned int i;
 	int ret;
 
-	down_read(&pci_bus_sem);
-
 	/* Walk to the root hub, releasing bridge BARs when possible */
 	next = bridge;
 	do {
@@ -2251,9 +2249,9 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 			if (res->child)
 				continue;
 
-			ret = add_to_list(&saved, bridge, res, 0, 0);
+			ret = add_to_list(saved, bridge, res, 0, 0);
 			if (ret)
-				goto cleanup;
+				return ret;
 
 			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
 
@@ -2269,67 +2267,108 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		next = bridge->bus ? bridge->bus->self : NULL;
 	} while (next);
 
-	if (list_empty(&saved)) {
-		up_read(&pci_bus_sem);
+	if (list_empty(saved))
 		return -ENOENT;
-	}
 
 	__pci_bus_size_bridges(bridge->subordinate, &added);
 	__pci_bridge_assign_resources(bridge, &added, &failed);
 	BUG_ON(!list_empty(&added));
 
 	if (!list_empty(&failed)) {
-		ret = -ENOSPC;
-		goto cleanup;
+		free_list(&failed);
+		return -ENOSPC;
 	}
 
-	list_for_each_entry(dev_res, &saved, list) {
+	list_for_each_entry(dev_res, saved, list) {
 		/* Skip the bridge we just assigned resources for */
 		if (bridge == dev_res->dev)
 			continue;
 
+		if (!dev_res->dev->subordinate)
+			continue;
+
 		bridge = dev_res->dev;
 		pci_setup_bridge(bridge->subordinate);
 	}
 
-	free_list(&saved);
-	up_read(&pci_bus_sem);
 	return 0;
+}
 
-cleanup:
-	/* Restore size and flags */
-	list_for_each_entry(dev_res, &failed, list) {
-		struct resource *res = dev_res->res;
+int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size,
+				       int exclude_bars)
+{
+	struct resource *res = pdev->resource + resno;
+	unsigned long flags = res->flags;
+	struct pci_dev_resource *dev_res;
+	struct pci_bus *bus = pdev->bus;
+	struct resource *r;
+	LIST_HEAD(saved);
+	unsigned int i;
+	int ret = 0;
 
-		res->start = dev_res->start;
-		res->end = dev_res->end;
-		res->flags = dev_res->flags;
+	down_read(&pci_bus_sem);
+
+	pci_dev_for_each_resource(pdev, r, i) {
+		if (i >= PCI_BRIDGE_RESOURCES)
+			break;
+
+		if (exclude_bars & BIT(i))
+			continue;
+
+		if (!pci_resource_len(pdev, i) || r->flags != flags)
+			continue;
+
+		ret = add_to_list(&saved, pdev, r, 0, 0);
+		if (ret)
+			goto restore;
+		pci_release_resource(pdev, i);
 	}
-	free_list(&failed);
 
+	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
+
+	if (!bus->self)
+		goto out;
+
+	ret = pci_reassign_bridge_resources(bus->self, res->flags, &saved);
+	if (ret)
+		goto restore;
+
+out:
+	up_read(&pci_bus_sem);
+	free_list(&saved);
+	return ret;
+
+restore:
 	/* Revert to the old configuration */
 	list_for_each_entry(dev_res, &saved, list) {
 		struct resource *res = dev_res->res;
+		struct pci_dev *dev = dev_res->dev;
 
-		bridge = dev_res->dev;
-		i = res - bridge->resource;
+		i = res - dev->resource;
 
 		if (res->parent) {
 			release_child_resources(res);
-			pci_release_resource(bridge, i);
+			pci_release_resource(dev, i);
 		}
 
 		res->start = dev_res->start;
 		res->end = dev_res->end;
 		res->flags = dev_res->flags;
 
-		pci_claim_resource(bridge, i);
-		pci_setup_bridge(bridge->subordinate);
-	}
-	up_read(&pci_bus_sem);
-	free_list(&saved);
+		if (pci_claim_resource(dev, i))
+			continue;
 
-	return ret;
+		if (i < PCI_BRIDGE_RESOURCES) {
+			const char *res_name = pci_resource_name(dev, i);
+
+			pci_update_resource(dev, i);
+			pci_info(dev, "%s %pR: old value restored\n",
+				 res_name, res);
+		}
+		if (dev->subordinate)
+			pci_setup_bridge(dev->subordinate);
+	}
+	goto out;
 }
 
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c6d933ddfd4649..98d909fa83d4ac 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -427,9 +427,9 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
-int pci_resize_resource(struct pci_dev *dev, int resno, int size)
+int pci_resize_resource(struct pci_dev *dev, int resno, int size,
+			int exclude_bars)
 {
-	struct resource *res = dev->resource + resno;
 	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
@@ -440,10 +440,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (host->preserve_config)
 		return -ENOTSUPP;
 
-	/* Make sure the resource isn't assigned before resizing it. */
-	if (!(res->flags & IORESOURCE_UNSET))
-		return -EBUSY;
-
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	if (cmd & PCI_COMMAND_MEMORY)
 		return -EBUSY;
@@ -463,19 +459,14 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (ret)
 		return ret;
 
-	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
+	ret = pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
+	if (ret)
+		goto error_resize;
 
-	/* Check if the new config works by trying to assign everything. */
-	if (dev->bus->self) {
-		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
-		if (ret)
-			goto error_resize;
-	}
 	return 0;
 
 error_resize:
 	pci_rebar_set_size(dev, resno, old);
-	res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
 	return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8b13be1633db17..282e86b9a35fe9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1380,7 +1380,8 @@ static inline int pci_rebar_bytes_to_size(u64 bytes)
 }
 
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
-int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
+int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
+				     int exclude_bars);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
@@ -1450,7 +1451,6 @@ void pci_assign_unassigned_resources(void);
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
-int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_assign_irq(struct pci_dev *dev);
-- 
2.53.0

