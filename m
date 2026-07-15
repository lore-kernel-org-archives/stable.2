Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854F385D96
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133151; cv=none; b=GagS2ILMH0W6MwgznuVPgH6OCSDw6VepmtxYkS9Nv9d8u3TEgsxmYTDWuqAUaMszhHCBEq+pasHNmxrZgTpgn3TxcBHStGhhY2iri/JxHJaqfvZrjH1bcmx8s7u/WAzjdEG+83lSg8x9+9C5/gp7jga0Yl6F3rvf44NxM7vYGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133151; c=relaxed/simple;
	bh=N314a3fPmrFjgCQz/4EYQOzCtC9ASNP552+p6k7FBbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1A9zUwvSfqXA3NNvEwwnjIO/WeN2qjJbWhI5zZsXHPUpXjlXNXB2hCpzX3KowtmlYXe9+Ohyf0CE16FuLKk0D2AYpHzCWHy4wxeXfZbgrB28SJvZWBsWJ5Oz1pYYv2ojGVGRykw8/lPHpKMXlgPtuVEMsBypu/w6DfCEloNQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMUWH2hS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMUWH2hS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6CD1F00A3D;
	Wed, 15 Jul 2026 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133149;
	bh=FAhJBrd9/pK7W2pwCME/zWdv9AoohQd8RkV3ra1pnps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMUWH2hSD9dNUwEf+ic6LVz4hMtPAlhPu9HDZWsC+i9fMAwKNtAO0q3Yccjb/EdLr
	 EZOMXxn8G0RVhnm0mYBgXT0pibrrbEvvX/4kJe+DpAQtfvdh8lUAaCEp12f47uNWmm
	 yR8L+8UMZ/0IX5I705X8h9zXRyCgWCm472ERjMHqzbVgJSu/5bMehuO8FbNp6uZFp3
	 v87hPp3PDXkKFwLSAGZT9nQ9agtmKwIF2ggVgFGsa8isK0/kg3/28emeazWSmVx8ih
	 l1pHDfjUnsh6HlAWCUCFj/JSlPBdBMcyoijNktymOVszNR0XIhveJGCmxUo7is+4xf
	 J9NE49e4G+xeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/6] PCI: Move Resizable BAR code to rebar.c
Date: Wed, 15 Jul 2026 12:32:22 -0400
Message-ID: <20260715163223.952417-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715163223.952417-1-sashal@kernel.org>
References: <2026071318-kettle-cringe-5d1a@gregkh>
 <20260715163223.952417-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 9f71938cd77f32a448f40a288e409eca60e55486 ]

For lack of a better place to put it, Resizable BAR code has been placed
inside pci.c and setup-res.c that do not use it for anything.  Upcoming
changes are going to add more Resizable BAR related functions, increasing
the code size.

As pci.c is huge as is, move the Resizable BAR related code and the BAR
resize code from setup-res.c to rebar.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patch.msgid.link/20251113180053.27944-2-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/driver-api/pci/pci.rst |   3 +
 drivers/pci/Makefile                 |   2 +-
 drivers/pci/pci.c                    | 135 -----------------
 drivers/pci/pci.h                    |   1 +
 drivers/pci/rebar.c                  | 211 +++++++++++++++++++++++++++
 drivers/pci/setup-res.c              |  64 --------
 6 files changed, 216 insertions(+), 200 deletions(-)
 create mode 100644 drivers/pci/rebar.c

diff --git a/Documentation/driver-api/pci/pci.rst b/Documentation/driver-api/pci/pci.rst
index ca85e5e78b2c43..32b040a6663322 100644
--- a/Documentation/driver-api/pci/pci.rst
+++ b/Documentation/driver-api/pci/pci.rst
@@ -31,6 +31,9 @@ PCI Support Library
 .. kernel-doc:: drivers/pci/slot.c
    :export:
 
+.. kernel-doc:: drivers/pci/rebar.c
+   :export:
+
 .. kernel-doc:: drivers/pci/rom.c
    :export:
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 522d2b974e91bd..c8a20fe2373779 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
-				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
+				   pci-sysfs.o rebar.o rom.o setup-res.o irq.o vpd.o \
 				   setup-bus.o vc.o mmap.o setup-irq.o
 
 obj-$(CONFIG_PCI)		+= pcie/
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ecac0f8d7ff510..8ed2c9fb263ab6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1626,33 +1626,6 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 	}
 }
 
-static void pci_restore_rebar_state(struct pci_dev *pdev)
-{
-	unsigned int pos, nbars, i;
-	u32 ctrl;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
-	if (!pos)
-		return;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
-		    PCI_REBAR_CTRL_NBAR_SHIFT;
-
-	for (i = 0; i < nbars; i++, pos += 8) {
-		struct resource *res;
-		int bar_idx, size;
-
-		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
-		res = pdev->resource + bar_idx;
-		size = ilog2(resource_size(res)) - 20;
-		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
-		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
-	}
-}
-
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: PCI device that we're dealing with
@@ -3557,114 +3530,6 @@ void pci_acs_init(struct pci_dev *dev)
 	pci_enable_acs(dev);
 }
 
-/**
- * pci_rebar_find_pos - find position of resize ctrl reg for BAR
- * @pdev: PCI device
- * @bar: BAR to find
- *
- * Helper to find the position of the ctrl register for a BAR.
- * Returns -ENOTSUPP if resizable BARs are not supported at all.
- * Returns -ENOENT if no ctrl register for the BAR could be found.
- */
-static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
-{
-	unsigned int pos, nbars, i;
-	u32 ctrl;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
-	if (!pos)
-		return -ENOTSUPP;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
-		    PCI_REBAR_CTRL_NBAR_SHIFT;
-
-	for (i = 0; i < nbars; i++, pos += 8) {
-		int bar_idx;
-
-		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
-		if (bar_idx == bar)
-			return pos;
-	}
-
-	return -ENOENT;
-}
-
-/**
- * pci_rebar_get_possible_sizes - get possible sizes for BAR
- * @pdev: PCI device
- * @bar: BAR to query
- *
- * Get the possible sizes of a resizable BAR as bitmask defined in the spec
- * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
- */
-u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
-{
-	int pos;
-	u32 cap;
-
-	pos = pci_rebar_find_pos(pdev, bar);
-	if (pos < 0)
-		return 0;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
-	cap &= PCI_REBAR_CAP_SIZES;
-
-	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
-	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
-	    bar == 0 && cap == 0x7000)
-		cap = 0x3f000;
-
-	return cap >> 4;
-}
-
-/**
- * pci_rebar_get_current_size - get the current size of a BAR
- * @pdev: PCI device
- * @bar: BAR to set size to
- *
- * Read the size of a BAR from the resizable BAR config.
- * Returns size if found or negative error code.
- */
-int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
-{
-	int pos;
-	u32 ctrl;
-
-	pos = pci_rebar_find_pos(pdev, bar);
-	if (pos < 0)
-		return pos;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
-}
-
-/**
- * pci_rebar_set_size - set a new size for a BAR
- * @pdev: PCI device
- * @bar: BAR to set size to
- * @size: new size as defined in the spec (0=1MB, 19=512GB)
- *
- * Set the new size of a BAR as defined in the spec.
- * Returns zero if resizing was successful, error code otherwise.
- */
-int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
-{
-	int pos;
-	u32 ctrl;
-
-	pos = pci_rebar_find_pos(pdev, bar);
-	if (pos < 0)
-		return pos;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-	ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
-	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
-	return 0;
-}
-
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77f5b7d54826b6..8802bf0f48b461 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -629,6 +629,7 @@ static inline int acpi_get_rc_resources(struct device *dev, const char *hid,
 #endif
 
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
+void pci_restore_rebar_state(struct pci_dev *pdev);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
 static inline u64 pci_rebar_size_to_bytes(int size)
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
new file mode 100644
index 00000000000000..ec449374291020
--- /dev/null
+++ b/drivers/pci/rebar.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Resizable BAR Extended Capability handling.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "pci.h"
+
+/**
+ * pci_rebar_find_pos - find position of resize ctrl reg for BAR
+ * @pdev: PCI device
+ * @bar: BAR to find
+ *
+ * Helper to find the position of the ctrl register for a BAR.
+ * Returns -ENOTSUPP if resizable BARs are not supported at all.
+ * Returns -ENOENT if no ctrl register for the BAR could be found.
+ */
+static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
+{
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos)
+		return -ENOTSUPP;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
+		    PCI_REBAR_CTRL_NBAR_SHIFT;
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		int bar_idx;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		if (bar_idx == bar)
+			return pos;
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * pci_rebar_get_possible_sizes - get possible sizes for BAR
+ * @pdev: PCI device
+ * @bar: BAR to query
+ *
+ * Get the possible sizes of a resizable BAR as bitmask defined in the spec
+ * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
+ */
+u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
+{
+	int pos;
+	u32 cap;
+
+	pos = pci_rebar_find_pos(pdev, bar);
+	if (pos < 0)
+		return 0;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
+	cap &= PCI_REBAR_CAP_SIZES;
+
+	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
+	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
+	    bar == 0 && cap == 0x7000)
+		cap = 0x3f000;
+
+	return cap >> 4;
+}
+
+/**
+ * pci_rebar_get_current_size - get the current size of a BAR
+ * @pdev: PCI device
+ * @bar: BAR to set size to
+ *
+ * Read the size of a BAR from the resizable BAR config.
+ * Returns size if found or negative error code.
+ */
+int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
+{
+	int pos;
+	u32 ctrl;
+
+	pos = pci_rebar_find_pos(pdev, bar);
+	if (pos < 0)
+		return pos;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
+}
+
+/**
+ * pci_rebar_set_size - set a new size for a BAR
+ * @pdev: PCI device
+ * @bar: BAR to set size to
+ * @size: new size as defined in the spec (0=1MB, 19=512GB)
+ *
+ * Set the new size of a BAR as defined in the spec.
+ * Returns zero if resizing was successful, error code otherwise.
+ */
+int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
+{
+	int pos;
+	u32 ctrl;
+
+	pos = pci_rebar_find_pos(pdev, bar);
+	if (pos < 0)
+		return pos;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+	ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
+	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+	return 0;
+}
+
+void pci_restore_rebar_state(struct pci_dev *pdev)
+{
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		struct resource *res;
+		int bar_idx, size;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		res = pdev->resource + bar_idx;
+		size = ilog2(resource_size(res)) - 20;
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
+		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+	}
+}
+
+/**
+ * pci_resize_resource - reconfigure a Resizable BAR and resources
+ * @dev: the PCI device
+ * @resno: index of the BAR to be resized
+ * @size: new size as defined in the spec (0=1MB, 31=128TB)
+ * @exclude_bars: a mask of BARs that should not be released
+ *
+ * Reconfigure @resno to @size and re-run resource assignment algorithm
+ * with the new size.
+ *
+ * Prior to resize, release @dev resources that share a bridge window with
+ * @resno.  This unpins the bridge window resource to allow changing it.
+ *
+ * The caller may prevent releasing a particular BAR by providing
+ * @exclude_bars mask, but this may result in the resize operation failing
+ * due to insufficient space.
+ *
+ * Return: 0 on success, or negative on error. In case of an error, the
+ *         resources are restored to their original places.
+ */
+int pci_resize_resource(struct pci_dev *dev, int resno, int size,
+			int exclude_bars)
+{
+	struct pci_host_bridge *host;
+	int old, ret;
+	u32 sizes;
+	u16 cmd;
+
+	/* Check if we must preserve the firmware's resource assignment */
+	host = pci_find_host_bridge(dev->bus);
+	if (host->preserve_config)
+		return -ENOTSUPP;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (cmd & PCI_COMMAND_MEMORY)
+		return -EBUSY;
+
+	sizes = pci_rebar_get_possible_sizes(dev, resno);
+	if (!sizes)
+		return -ENOTSUPP;
+
+	if (!(sizes & BIT(size)))
+		return -EINVAL;
+
+	old = pci_rebar_get_current_size(dev, resno);
+	if (old < 0)
+		return old;
+
+	ret = pci_rebar_set_size(dev, resno, size);
+	if (ret)
+		return ret;
+
+	ret = pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
+	if (ret)
+		goto error_resize;
+
+	return 0;
+
+error_resize:
+	pci_rebar_set_size(dev, resno, old);
+	return ret;
+}
+EXPORT_SYMBOL(pci_resize_resource);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index aa66e85a3a4715..2ec1c719f31935 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -422,70 +422,6 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
-/**
- * pci_resize_resource - reconfigure a Resizable BAR and resources
- * @dev: the PCI device
- * @resno: index of the BAR to be resized
- * @size: new size as defined in the spec (0=1MB, 31=128TB)
- * @exclude_bars: a mask of BARs that should not be released
- *
- * Reconfigure @resno to @size and re-run resource assignment algorithm
- * with the new size.
- *
- * Prior to resize, release @dev resources that share a bridge window with
- * @resno.  This unpins the bridge window resource to allow changing it.
- *
- * The caller may prevent releasing a particular BAR by providing
- * @exclude_bars mask, but this may result in the resize operation failing
- * due to insufficient space.
- *
- * Return: 0 on success, or negative on error. In case of an error, the
- *         resources are restored to their original places.
- */
-int pci_resize_resource(struct pci_dev *dev, int resno, int size,
-			int exclude_bars)
-{
-	struct pci_host_bridge *host;
-	int old, ret;
-	u32 sizes;
-	u16 cmd;
-
-	/* Check if we must preserve the firmware's resource assignment */
-	host = pci_find_host_bridge(dev->bus);
-	if (host->preserve_config)
-		return -ENOTSUPP;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (cmd & PCI_COMMAND_MEMORY)
-		return -EBUSY;
-
-	sizes = pci_rebar_get_possible_sizes(dev, resno);
-	if (!sizes)
-		return -ENOTSUPP;
-
-	if (!(sizes & BIT(size)))
-		return -EINVAL;
-
-	old = pci_rebar_get_current_size(dev, resno);
-	if (old < 0)
-		return old;
-
-	ret = pci_rebar_set_size(dev, resno, size);
-	if (ret)
-		return ret;
-
-	ret = pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
-	if (ret)
-		goto error_resize;
-
-	return 0;
-
-error_resize:
-	pci_rebar_set_size(dev, resno, old);
-	return ret;
-}
-EXPORT_SYMBOL(pci_resize_resource);
-
 int pci_enable_resources(struct pci_dev *dev, int mask)
 {
 	u16 cmd, old_cmd;
-- 
2.53.0

