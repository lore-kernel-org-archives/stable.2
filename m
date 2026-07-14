Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839E346AC0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999992; cv=none; b=kWzVFuXqe4h/zc7kEs/zJjlpCJcIxltz1xEsJNZPpGb0+FGeWDHHMUsS/ETVgOWgr5fkivTzbhFpvhDvf6cIZaTur1sSSClmj9LyabdF42XPZuKmBtTlHt3/O6NAT3ltCKgQn+psvs5W5nW01f8P3DldpW2ZSk5XY4eWyndyvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999992; c=relaxed/simple;
	bh=KT129RmMdEJRGquz2YSZZMG6I9PSAnJ0bAyas/x7TS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcLRqbmjdc2GzklwrwRxPYeKm3PvtqPYCEez1rBLoeocLM69I34FPNpFwD1CFfRMlSsbVCCXdowG1XycjEupIIpvCiqOs4AVCvsg3xKXd91b/Zt7/8JgSmeR0KLjH69l4j0rV1IpJoPDhtAGFgiBoiJAbvJynDg6i4CeUYJoKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKWTyB79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKWTyB79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAAE1F00A3E;
	Tue, 14 Jul 2026 03:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783999990;
	bh=Bh41rrTxZjbzBI2Nu3aE6/bm0WIN5OVVlmlpkoN9Qlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKWTyB79eC0U9xycBJUwWxOBjJVnQzjcXtlkoMjZL/YwGC/F3SU9T5Z+rxdV7g7Pl
	 QKtXPk0ix77unwd81UvegOKY8qCZs48P0kAuxNp2EorBsV1stFhpazP6fkIH52vf/9
	 j6CveFFP7dnqtpPkHda0VYTAnk5fW9+f9KoXh5F+WRT7VoOLwLuStN4RqxjMp89iKs
	 tp8LXWTfCw9tiQPEhdtnYZuEbgbDdnknNEw1VazPNB2KwCqxCaGE1GqjlFYNUc1e+P
	 zn33wkRVDK3Jk9+yqmiDTWwf5zyFmlTH4tfo8Yv/UvFvP8zdGyWrNVHhIIyJcKSvRJ
	 eBAqLLEUL5Myg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] vfio/pci: Latch disable_idle_d3 per device
Date: Mon, 13 Jul 2026 23:33:07 -0400
Message-ID: <20260714033307.2397254-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714033307.2397254-1-sashal@kernel.org>
References: <2026071301-corned-default-6f79@gregkh>
 <20260714033307.2397254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex.williamson@nvidia.com>

[ Upstream commit 4575e9aac5336d1365138c0284773bf8da4b1fa3 ]

When disable_idle_d3 was introduced in vfio-pci, it directly manipulated
the device power state with pci_set_power_state().  There were no
refcounts to maintain or balanced operations, we could unconditionally
bring the device to D0 and conditionally move it to D3hot.  Therefore
the module parameter was made writable.

Later, in commit c61302aa48f7 ("vfio/pci: Move module parameters to
vfio_pci.c"), as part of the vfio-pci-core split, the writable aspect
of the module parameter was nullified.  The parameter value could still
be changed through sysfs, but the vfio-pci driver latched the values
into vfio-pci-core globals at module init.  Loading the vfio-pci module,
or unloading and reloading, with non-default or different values could
change the globals relative to existing devices bound to vfio-pci
variant drivers.

Runtime PM was introduced in commit 7ab5e10eda02 ("vfio/pci: Move the
unused device into low power state with runtime PM"), which marks the
point where power states became refcounted.  PM get and put operations
need to be balanced, but the same module operations noted above can
change the global variables relative to those devices already bound to
vfio-pci variant drivers.  This introduces a window where PM operations
can now become unbalanced.

To resolve this with a narrow footprint for stable backports, the
disable_idle_d3 flag is latched into the vfio_pci_core_device at the
time of initialization, such that the device always operates with a
consistent value.

NB. vfio_pci_dev_set_try_reset() now unconditionally raises the
runtime PM usage count around bus reset to account for disable_idle_d3
becoming a per-device rather than global flag.  When this flag is set,
the additional get/put pair is harmless and allows continued use of the
shared vfio_pci_dev_set_pm_runtime_get() helper.

Fixes: 7ab5e10eda02 ("vfio/pci: Move the unused device into low power state with runtime PM")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260615191241.688297-2-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_core.c | 19 ++++++++++---------
 include/linux/vfio_pci_core.h    |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a8823cc77b998a..519907bddeffb9 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -472,7 +472,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
-	if (!disable_idle_d3) {
+	if (!vdev->disable_idle_d3) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
 			return ret;
@@ -547,7 +547,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 out_disable_device:
 	pci_disable_device(pdev);
 out_power:
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
 	return ret;
 }
@@ -674,7 +674,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
 
 	/* Put the pm-runtime usage counter acquired during enable */
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
@@ -2091,6 +2091,8 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
 	init_rwsem(&vdev->memory_lock);
 
+	vdev->disable_idle_d3 = disable_idle_d3;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2183,7 +2185,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 
 	dev->driver->pm = &vfio_pci_core_pm_ops;
 	pm_runtime_allow(dev);
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(dev);
 
 	ret = vfio_register_group_dev(&vdev->vdev);
@@ -2192,7 +2194,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	return 0;
 
 out_power:
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
@@ -2211,7 +2213,7 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 	vfio_pci_vf_uninit(vdev);
 	vfio_pci_vga_uninit(vdev);
 
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_get_noresume(&vdev->pdev->dev);
 
 	pm_runtime_forbid(&vdev->pdev->dev);
@@ -2526,7 +2528,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	 * state. Increment the usage count for all the devices in the dev_set
 	 * before reset and decrement the same after reset.
 	 */
-	if (!disable_idle_d3 && vfio_pci_dev_set_pm_runtime_get(dev_set))
+	if (vfio_pci_dev_set_pm_runtime_get(dev_set))
 		return;
 
 	if (!pci_reset_bus(pdev))
@@ -2536,8 +2538,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 		if (reset_done)
 			cur->needs_reset = false;
 
-		if (!disable_idle_d3)
-			pm_runtime_put(&cur->pdev->dev);
+		pm_runtime_put(&cur->pdev->dev);
 	}
 }
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index cda27d476d8597..9197cac4faadb2 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -80,6 +80,7 @@ struct vfio_pci_core_device {
 	bool			needs_pm_restore:1;
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
+	bool			disable_idle_d3:1;
 	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
-- 
2.53.0

