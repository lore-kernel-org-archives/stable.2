Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EA4CA280
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646634; cv=none; b=awUdUozpQJmLQStuTwZ+lAGf3y3GTNs6lJL3SoiSeNJU0ixSWHTYgDOGq/ezB1IkhV28bj4n4TRrbQ/ewJQz3L4oI3rtY5GkMSwJviPYfde4EKRddrfq9xZtCfVIyGcGbtWvL0DSmiI2dH614pEk5+ZeU2AKecB8HfuqkJhk7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646634; c=relaxed/simple;
	bh=uWpcdTa952R0nbq5M34UzV6KCoU7rkVsFgcWKunZ/kw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H42gafyL61SXRbzJqv6NHrMs44BI/9qwBhxdLTgvE0tOM2XCl/YYUWptee8GrmXyPF9sgPBIVwZsx8MM5UKMf384j7F+rpKCgR62PVnLoXAgKvvgoSD1WLRuqVcyE7Q75StYCYuDmiR2uvVA9xNQg1Sz/GTu105AT7Wny9g49As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwrKkfgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwrKkfgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEAB1F000E9;
	Tue, 21 Jul 2026 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784646633;
	bh=g3NIhqDcwAliZIYjpiuXig0CYyHE+JopDAze4L+ju44=;
	h=Subject:To:Cc:From:Date;
	b=IwrKkfgi7CiolPwWB1CJVIp54X+PrG6c1RXjiDUP9cLfGeSR3cz/EnIMUSFCaplKS
	 UT0zO5LA1i45PbAybbSIogm+x1a0JQkxpbzwrwnYZ7NKfWsq3dL/m4Z8Q8ZgKTN+wV
	 MhRXnQsQKp2pjGLrIw6Ye6B/PaISxy/08HTj0o3w=
Subject: FAILED: patch "[PATCH] vfio/pci: Fix racy bitfields and tighten struct layout" failed to apply to 6.1-stable tree
To: alex.williamson@nvidia.com,alex@shazbot.org,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 17:10:23 +0200
Message-ID: <2026072123-daredevil-oxygen-b864@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e73638e55f861758d49f14d7bb5dba3035981cd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072123-daredevil-oxygen-b864@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e73638e55f861758d49f14d7bb5dba3035981cd7 Mon Sep 17 00:00:00 2001
From: Alex Williamson <alex.williamson@nvidia.com>
Date: Mon, 15 Jun 2026 13:12:31 -0600
Subject: [PATCH] vfio/pci: Fix racy bitfields and tighten struct layout

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

This split takes a binary approach: flags that are only modified
pre/post open/close remain bitfields, flags modified from user
action, including actions that reach across to another device (ex.
reset) use dedicated storage units.

Note that the virq_disabled and bardirty flags are relocated to fill
an existing hole in the structure.

Bitfield justifications:

  has_dyn_msix: written only in vfio_pci_core_enable()
  pci_2_3: written only in vfio_pci_core_enable()
  reset_works: written only in vfio_pci_core_enable()
  extended_caps: written only in vfio_cap_len() under vfio_config_init()
  has_vga: written only in vfio_pci_core_enable()
  nointx: written only in vfio_pci_core_enable()
  needs_pm_restore: written only in vfio_pci_probe_power_state()
  disable_idle_d3: written only at .init in vfio_pci_core_init_dev()

Dedicated storage units:

  virq_disabled: written by guest INTx command writes in
                 vfio_basic_config_write() while the device is open
  bardirty: written by guest BAR writes in vfio_basic_config_write()
            while the device is open
  pm_intx_masked: written in the runtime-PM suspend path.
  pm_runtime_engaged: written by low-power feature entry/exit paths
  needs_reset: set in vfio_pci_core_disable() and cleared for devices in
               the set by vfio_pci_dev_set_try_reset()
  sriov_active: written by vfio_pci_core_sriov_configure() via sysfs
                sriov_numvfs while bound.

Fixes: 9cd0f6d5cbb6 ("vfio/pci: Use bitfield for struct vfio_pci_core_device flags")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260615191241.688297-4-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex@shazbot.org>

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 27aab3fdbb91..985b8af5a04b 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -101,6 +101,9 @@ struct vfio_pci_core_device {
 	const struct vfio_pci_device_ops *pci_ops;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			virq_disabled;
+	bool			bardirty;
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
@@ -115,19 +118,19 @@ struct vfio_pci_core_device {
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
+	/* Flags only modified on setup/release - bitfield ok */
 	bool			has_dyn_msix:1;
 	bool			pci_2_3:1;
-	bool			virq_disabled:1;
 	bool			reset_works:1;
 	bool			extended_caps:1;
-	bool			bardirty:1;
 	bool			has_vga:1;
-	bool			needs_reset:1;
 	bool			nointx:1;
 	bool			needs_pm_restore:1;
-	bool			pm_intx_masked:1;
-	bool			pm_runtime_engaged:1;
 	bool			disable_idle_d3:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			needs_reset;
+	bool			pm_intx_masked;
+	bool			pm_runtime_engaged;
 	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;

