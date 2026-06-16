Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B23F0AB6
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781650009; cv=none; b=lvEsJy2Z4TaTVd9jxklk/mAb/tXkElTkEDPKOPPQNtf0U5f3fvFrYVNqkZ6r5EPw4+kwXTcvCMSiT4law5AX7hOmkwfdA9UC0H2LWEIJx3Bq2LjkU/D6qdr2EZvBjuSnEsYnFvi2/Sw2ScZjGMj2MFG26a5NIjDKWHlkD5y/ONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781650009; c=relaxed/simple;
	bh=4awVMQZUh5jKTsoTkdfKcauTuMxpzbplhZ9od+RcH7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew0NgfRQg6Ps0kTuIR5zD5cW94n/ZoBKTPGGhXmKG2kXDm6l1rGTLy9pyVrPCtjployz1OyAxcy/t4JGagfiSj8PTncBfl+izV2hXJCISzYkmhKVcjMb2yRDp42dBrHpS3LM43WmxFKYbh3EnL4p+WBHs6782Al6iEzzAUXJRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l86DkpH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l86DkpH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9D01F000E9;
	Tue, 16 Jun 2026 22:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781650008;
	bh=6jF+fHZ7coKJ1u+/2aO8l/Pbjsp0iYd7ZW1dOsi3AkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l86DkpH2W3RlM0qa085f77q/kIX8r7jBAGgZTXJ4OHc8jx806PZr8tsdzH1DcRO/R
	 +3cTDL46Wv4vs+U0aKKS8hkc0bQn7c65rS0SH4NpgRn5Uw8k6L7C8WmxgfEPkwaHMD
	 VoC5iyjHXte6SsHa95f+TzY5YPIJdsKYsnLxW2vgBKAFuYqQojxQeCPcVXHd8QH0Qv
	 qmr4jtxaQjap/XIMvLqthgDaQfsPwn2d+A9JrVwAnW2z9Drari2mJ+Zhfi8r6Ko6/C
	 uWjhPgaNIpuSNrhLvWL0YDN7AV+lMAGU0o8SYoX2VGaDaMH26vrdCjIV7KJO7cyDwF
	 SROkPlvuHCyNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Matthew Ruffell <matthew.ruffell@canonical.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on Gen2 VMs
Date: Tue, 16 Jun 2026 18:46:46 -0400
Message-ID: <20260616224646.3561132-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061519-estimate-triumph-4d39@gregkh>
References: <2026061519-estimate-triumph-4d39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 016a25e4b0df4d77e7c258edee4aaf982e4ee809 ]

If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
screen.lfb_base being zero [1], there is an MMIO conflict between the
drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
hv_allocate_config_window() calls vmbus_allocate_mmio() to get an
MMIO range, typically it gets a 32-bit MMIO range that overlaps with the
framebuffer MMIO range, and later hv_pci_enter_d0() fails with an
error message "PCI Pass-through VSP failed D0 Entry with status" since
the host thinks that PCI devices must not use MMIO space that the
host has assigned to the framebuffer.

This is especially an issue if pci-hyperv is built-in and hyperv-drm is
built as a module. Consequently, the kdump/kexec kernel fails to detect
PCI devices via pci-hyperv, and may fail to mount the root file system,
which may reside in a NVMe disk. The issue described here has existed
for SR-IOV VF NICs since day one of the pci-hyperv driver, and has been
worked around on x64 when possible. With the recent introduction of
ARM64 VMs that boot from NVMe, there is no workaround, so we need a
formal fix.

On Gen2 VMs, if the screen.lfb_base is 0 in the kdump/kexec kernel [1],
fall back to the low MMIO base, which should be equal to the framebuffer
MMIO base [2] (the statement is true according to my testing on x64
Windows Server 2016, and on x64 and ARM64 Windows Server 2025 and on
Azure. I checked with the Hyper-V team and they said the statement should
continue to be true for Gen2 VMs). In the first kernel, screen.lfb_base
is not 0; if the user specifies a very high resolution, it's not enough
to only reserve 8MB: let's always reserve half of the space below 4GB,
but cap the reservation to 128MB, which is the required framebuffer size
of the highest resolution 7680*4320 supported by Hyper-V.

While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
the > to >=. Here the 'end' is an inclusive end (typically, it's
0xFFFF_FFFF for the low MMIO range).

Note: vmbus_reserve_fb() now also reserves an MMIO range at the beginning
of the low MMIO range on CVMs, which have no framebuffers (the
'screen.lfb_base' in vmbus_reserve_fb() is 0 for CVMs), just in case the
host might treat the beginning of the low MMIO range specially [3]. BTW,
the OpenHCL kernel is not affected by the change, because that kernel
boots with DeviceTree rather than ACPI (so vmbus_reserve_fb() won't run
there), and there is no framebuffer device for that kernel.

Note: normally Gen1 VMs don't have the MMIO conflict issue because the
framebuffer MMIO range (which is hardcoded to base=4GB-128MB and
size=64MB for Gen1 VMs by the host) is always reported via the legacy PCI
graphics device's BAR, so the kdump/kexec kernel can reserve the 64MB
MMIO range; however, if the VM is configured to use a very high resolution
and the required framebuffer size exceeds 64MB (AFAIK, in practice, this
isn't a typical configuration by users), the hyperv-drm driver may need to
allocate an MMIO range above 4GB and change the framebuffer MMIO location
to the allocated MMIO range -- in this case, there can still be issues [4]
which can't be easily fixed: any possible affected Gen1 users would have
to use a resolution whose framebuffer size is <= 64MB, or switch to Gen2
VMs.

[1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
[2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
[3] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com/

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
CC: stable@vger.kernel.org
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Krister Johansen <kjlx@templeofstupid.com>
Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
[ changed `sysfb_primary_display.screen.lfb_base/lfb_size` reads to the global `screen_info.lfb_base/lfb_size` and dropped the `if (IS_ENABLED(CONFIG_SYSFB))` wrapper, de-indenting the block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/vmbus_drv.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 074168f34afd7c..8aa775c9382bf0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2027,8 +2027,8 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 		return AE_NO_MEMORY;
 
 	/* If this range overlaps the virtual TPM, truncate it. */
-	if (end > VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
-		end = VTPM_BASE_ADDRESS;
+	if (end >= VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
+		end = VTPM_BASE_ADDRESS - 1;
 
 	new_res->name = "hyperv mmio";
 	new_res->flags = IORESOURCE_MEM;
@@ -2096,12 +2096,31 @@ static int vmbus_acpi_remove(struct acpi_device *device)
 static void vmbus_reserve_fb(void)
 {
 	resource_size_t start = 0, size;
+	resource_size_t low_mmio_base;
 	struct pci_dev *pdev;
 
 	if (efi_enabled(EFI_BOOT)) {
 		/* Gen2 VM: get FB base from EFI framebuffer */
 		start = screen_info.lfb_base;
 		size = max_t(__u32, screen_info.lfb_size, 0x800000);
+
+		low_mmio_base = hyperv_mmio->start;
+		if (!low_mmio_base || upper_32_bits(low_mmio_base) ||
+		    (start && start < low_mmio_base)) {
+			pr_warn("Unexpected low mmio base %pa\n", &low_mmio_base);
+		} else {
+			/*
+			 * If the kdump/kexec or CVM kernel's lfb_base
+			 * is 0, fall back to the low mmio base.
+			 */
+			if (!start)
+				start = low_mmio_base;
+			/*
+			 * Reserve half of the space below 4GB for high
+			 * resolutions, but cap the reservation to 128MB.
+			 */
+			size = min((SZ_4G - start) / 2, SZ_128M);
+		}
 	} else {
 		/* Gen1 VM: get FB base from PCI */
 		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
@@ -2121,8 +2140,10 @@ static void vmbus_reserve_fb(void)
 		pci_dev_put(pdev);
 	}
 
-	if (!start)
+	if (!start) {
+		pr_warn("Unexpected framebuffer mmio base of zero\n");
 		return;
+	}
 
 	/*
 	 * Make a claim for the frame buffer in the resource tree under the
@@ -2132,6 +2153,8 @@ static void vmbus_reserve_fb(void)
 	 */
 	for (; !fb_mmio && (size >= 0x100000); size >>= 1)
 		fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
+
+	pr_info("hv_mmio=%pR,%pR fb=%pR\n", hyperv_mmio, hyperv_mmio->sibling, fb_mmio);
 }
 
 /**
-- 
2.53.0

