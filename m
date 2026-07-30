Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6439B4BF
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413750; cv=none; b=pGT3ZPOk1uJLICk9x8xCcnssrfFjZ/8vCPgPVf4dkY1v6cWrckdHm7ggZVw1G9JeiOJJEb5WdJr8tWdMXa4DlNUxvfDFj9Vjoydmhy1Q9HuU+UaU4OA3wSssnpxFtNdayGaO3XcZ3/ewtkGVgr0LNKpx+gx6IsZfyzrg5LXT+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413750; c=relaxed/simple;
	bh=BFkLSm03FQ2qNdFxCm4nOnMoCtq7E2rydc8iLSH5VfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3/5WNv4mdhfEWeHIyeqq3OBdCSoobiO6kbcKUDyXInvjCjvYiiPQueI+JDq1RmYiVRB1iUOT6dNTAlyWu6swRtabohg/IU5bP/IRlU1g4Eeo588zTMYNfZ+mw53jzg9E+R75qg093Wp4Ws6BsYe88+jTS027WM+NYKyGQQP+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9wbjoSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9wbjoSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A83E1F000E9;
	Thu, 30 Jul 2026 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413732;
	bh=UcnqNWeg6pyQkrbHPbwMmf38mF88+Wnw8TMUXeDOj08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9wbjoSwgmJWfEfwzoDHA3tb1vV49IwR7/l+1JdSGRyF62DihbAHNQkOV03NkMNaS
	 j351Zmv8Jrd6s8pjMh0ljUfDV1a72uAfu8IRR44v1FvEJpFs025P6pD4lAnB7Ep4YR
	 y/ZSs3ERmFe4cEHmfmt1AA2w7M0BPO00m6Q8QOU/pmku9XbT8us5Zy7zgyFyHlHvCg
	 5Dkr8dgM1Ds5xwNsTkQVYz0cetKY4GsJYOKRmFTpHvdWtl3QI8VAvd8eQDhOpuxJnx
	 8JJB4sHu9dL7f8o+RGs8ocbE0QsMIFZjAdyWAj+JmMMaiXvRT6ty8evrg2KsTX7kbt
	 zWIPSBj51Ateg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] vfio/pci: Fix racy bitfields and tighten struct layout
Date: Thu, 30 Jul 2026 08:15:30 -0400
Message-ID: <20260730121530.2207687-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072123-daredevil-oxygen-b864@gregkh>
References: <2026072123-daredevil-oxygen-b864@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex.williamson@nvidia.com>

[ Upstream commit e73638e55f861758d49f14d7bb5dba3035981cd7 ]

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
[ dropped the `has_dyn_msix:1` bitfield line (absent in this tree) while keeping the rest of the struct layout change ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/vfio_pci_core.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9197cac4faadb2..b08422f03b24c4 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -54,6 +54,9 @@ struct vfio_pci_core_device {
 	struct pci_dev		*pdev;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			virq_disabled;
+	bool			bardirty;
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
@@ -69,18 +72,18 @@ struct vfio_pci_core_device {
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
+	/* Flags only modified on setup/release - bitfield ok */
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
-- 
2.53.0

