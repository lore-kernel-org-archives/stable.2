Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463FF258CD7
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534750; cv=none; b=OvJOK7Slktt83FkAOv04gLs15o5wsdShux1DC8/08XVFB+abyVuWZ0UwPZUztiHp3hM4MwgweWQzjEvCbJ2s/pBAwGD/DJNszq/wQmtRYfApvukXH+Q1FlmFwGcVNsJ4YTdwBeSTCjGFIVSAhy3SH/Tcozd1lnoKh8NkiaElD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534750; c=relaxed/simple;
	bh=lxbU/lE/Vp0Xy3o9arztlrSsBcyce44QDXcT4q9XaZo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XOYaQD8STdEBXQbY+FH3ViX38VunXHzX2isoAkoUWYtSsJR745/5hdX8xFVV26NGKOuSNAnFWeIOJjSgC/880ZwU7WcNWNBag8zNNezT9M3ZsF0a1Je4JY7ey64BfeBh6ng/13a1EPNaKXgBRvJEoyreyhka8/DPRVwwuT1kDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AqbMY/RE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AqbMY/RE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A9C1F000E9;
	Mon, 15 Jun 2026 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534748;
	bh=UFmviTaajMBq3HVtFOmEIgzpG2j1zjXsMpCLYobHH+o=;
	h=Subject:To:Cc:From:Date;
	b=AqbMY/REhWcBBwIzwaiVk5x2tdsNFBBZNI5tGhbOZ4GPfxITsg7+wmS7kYIcV84NN
	 p/L8e0Y1PkWqQv1ZG/nIR1MtDqGsQ4+GVJv2QueDHUowKsyo+0FE64Y3wYD94YEZFT
	 9UVmZdhwKtSpPx+Fj/lGGhFYcGfYlKsdeEEnEWoc=
Subject: FAILED: patch "[PATCH] Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on" failed to apply to 6.1-stable tree
To: decui@microsoft.com,kjlx@templeofstupid.com,matthew.ruffell@canonical.com,mhklinux@outlook.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:32:19 +0200
Message-ID: <2026061519-estimate-triumph-4d39@gregkh>
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
git cherry-pick -x 016a25e4b0df4d77e7c258edee4aaf982e4ee809
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061519-estimate-triumph-4d39@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 016a25e4b0df4d77e7c258edee4aaf982e4ee809 Mon Sep 17 00:00:00 2001
From: Dexuan Cui <decui@microsoft.com>
Date: Thu, 7 May 2026 14:28:38 -0700
Subject: [PATCH] Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on
 Gen2 VMs

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

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c9eeb2ec365d..b80a35c778ab 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2327,8 +2327,8 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 		return AE_NO_MEMORY;
 
 	/* If this range overlaps the virtual TPM, truncate it. */
-	if (end > VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
-		end = VTPM_BASE_ADDRESS;
+	if (end >= VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
+		end = VTPM_BASE_ADDRESS - 1;
 
 	new_res->name = "hyperv mmio";
 	new_res->flags = IORESOURCE_MEM;
@@ -2395,6 +2395,7 @@ static void vmbus_mmio_remove(void)
 static void __maybe_unused vmbus_reserve_fb(void)
 {
 	resource_size_t start = 0, size;
+	resource_size_t low_mmio_base;
 	struct pci_dev *pdev;
 
 	if (efi_enabled(EFI_BOOT)) {
@@ -2402,6 +2403,24 @@ static void __maybe_unused vmbus_reserve_fb(void)
 		if (IS_ENABLED(CONFIG_SYSFB)) {
 			start = sysfb_primary_display.screen.lfb_base;
 			size = max_t(__u32, sysfb_primary_display.screen.lfb_size, 0x800000);
+
+			low_mmio_base = hyperv_mmio->start;
+			if (!low_mmio_base || upper_32_bits(low_mmio_base) ||
+			    (start && start < low_mmio_base)) {
+				pr_warn("Unexpected low mmio base %pa\n", &low_mmio_base);
+			} else {
+				/*
+				 * If the kdump/kexec or CVM kernel's lfb_base
+				 * is 0, fall back to the low mmio base.
+				 */
+				if (!start)
+					start = low_mmio_base;
+				/*
+				 * Reserve half of the space below 4GB for high
+				 * resolutions, but cap the reservation to 128MB.
+				 */
+				size = min((SZ_4G - start) / 2, SZ_128M);
+			}
 		}
 	} else {
 		/* Gen1 VM: get FB base from PCI */
@@ -2422,8 +2441,10 @@ static void __maybe_unused vmbus_reserve_fb(void)
 		pci_dev_put(pdev);
 	}
 
-	if (!start)
+	if (!start) {
+		pr_warn("Unexpected framebuffer mmio base of zero\n");
 		return;
+	}
 
 	/*
 	 * Make a claim for the frame buffer in the resource tree under the
@@ -2433,6 +2454,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
 	 */
 	for (; !fb_mmio && (size >= 0x100000); size >>= 1)
 		fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
+
+	pr_info("hv_mmio=%pR,%pR fb=%pR\n", hyperv_mmio, hyperv_mmio->sibling, fb_mmio);
 }
 
 /**

