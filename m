Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2463AFB11;
	Fri, 31 Jul 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519300; cv=none; b=iUNhv6FAlSo7bhyQ2gsf3vaoIjgtJePKX1vXmh6lMPHmuaFdgOpdK4FZZ47SI2FuhvqFIL+HBnXj2wHlS003l8OpHfh546TvIH0hcnvrOLCf53wIsMl0S9ow5h5VY+PKSlHv06+o2cgQK67Xjq8MzTZfuC/mstmixCyRGm6+mNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519300; c=relaxed/simple;
	bh=BKS53CPa4ZWJrD1kCC8MyHrwZ7pCF0u4ee7NVEiRwo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cq9cOqO+798f1JRgfJkNv67Y9OrcRyGjKW9LOW2EO/zkXfvBSfhGgRYcHwvA44WmSBP0Qjcj+E/MOjItdknWZLXKgWgzWumjal6aChDlq918cgSR3g7rJWq39+gFzwldsaSdRbYjXKDmXZXEZK6ewn9yUnpkSH8ilZdnm07ZpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAlVSGaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAlVSGaG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D60EEC2BCB9;
	Fri, 31 Jul 2026 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785519299;
	bh=BKS53CPa4ZWJrD1kCC8MyHrwZ7pCF0u4ee7NVEiRwo8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=vAlVSGaGh3oyeIogGnyNKlhkiDCvf28sXs0lKe3KhOnnN4kaabv1iv7WRVf4uVU3t
	 QJqIbTG1S8DPG9FHAfP2ngkUdbCcjIzE8OqC6hbabSaDtO7FV5UU63bmjgGrCz7iRP
	 T+cTkb9aiJmTloVvDNmBSdd8ICkFSciyFlAvLWAGlUyGajrUAINc+WiQ2nQ/SIoaUu
	 3fzJDWxUr+MH7RBeb4rcPTcs6YPq/UGgM5ozoqaKItHTIc3x8KTCoUXDBSrfavwlKQ
	 EctMoG51LnDLX4WJbl+VGlQBfh3WQ19eRH/iNvJp2LUO39y7ONJ3TrejR/YpEEuck/
	 2DupO+P5Xobcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3043C5516D;
	Fri, 31 Jul 2026 17:34:59 +0000 (UTC)
From: Liz Fong-Jones via B4 Relay <devnull+lizf.honeycomb.io@kernel.org>
Date: Fri, 31 Jul 2026 10:34:59 -0700
Subject: [PATCH v3] PCI: Fix BAR resize for devices on a root bus
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-pci-rebar-root-bus-v3-1-6732e233fc99@honeycomb.io>
X-B4-Tracking: v=1; b=H4sIAMLcbGoC/22NywrCMBQFf6VkbSRJra2u/A9xkceNvYJNSdpgK
 f13k4og0uXAOTMzCeARAjkXM/EQMaDrEpS7guhWdnegaBITwcSR1exAe43Ug5KeeucGqsZAbcl
 FaYEzq2uSjr0Hi69Ver19OIzqAXrIprxoMQzOT2s18rz7BqqtQOSU06oytmZaGdM0l9Z1MGn3V
 Ht0JDei+LFwsWkRySK5OnFWy0YY/WdZluUNzJa3zQ8BAAA=
X-Change-ID: 20260704-pci-rebar-root-bus-f3123fe10fc7
To: Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
 Jon Nettleton <jon@solid-run.com>, Jon Nettleton <jon.nettleton@gmail.com>, 
 Jacob Martin <jacob.martin@canonical.com>, stable@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Liz Fong-Jones <lizf@honeycomb.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7820; i=lizf@honeycomb.io;
 s=gpg; h=from:subject:message-id;
 bh=tiZwX1JmLLUsHZJG3LbO1qum0siFMUGL+nup0ZLj+Xw=;
 b=owEBbQGS/pANAwAKAaXO1OOXra/CAcsmYgBqbNzDr8ep/jGlcuUqZtPyGYoV8lNXGhJJ6o6p5
 bJDuK58YKCJATMEAAEKAB0WIQSfW1LPQ0gyJmoTHwelztTjl62vwgUCamzcwwAKCRClztTjl62v
 wm2fCACzplb0URlP9O9SZoCrIJkNf+9dSN1UVWBNLkWHJhJiPfy+RhKryzBpkUnrnk+eGGVy/6v
 SJpSGdPtUUaZkf8OlGv6Upb5GItiyRwctbn6mPjyd/kmB+YaxXMAxBGttiELGn7g2BkJM7cTSYv
 QXvKemb1VVqrkV+wm8ZAshy8lM8URpPLTw77PlJKmU7H0woyQsW8TpzJOcl4Fu0kiZAnHrs8JDW
 evEFcyFrPbyMF7UhgcueWYhecqwm1c6WKxHtPorw5MfJDo2xM98cdF5RmdcoCuzk/i7DOo6Xw4R
 oVKeg0a7T+kxTBFRa8b3vTEk6b+xBa0W/D4pI2C9E2/Kn/9m
X-Developer-Key: i=lizf@honeycomb.io; a=openpgp;
 fpr=1F7714D7EC3441D2CECC24606A3F8B00FBDDD2A4
X-Endpoint-Received: by B4 Relay for lizf@honeycomb.io/gpg with auth_id=854
X-Original-From: Liz Fong-Jones <lizf@honeycomb.io>
Reply-To: lizf@honeycomb.io

From: Liz Fong-Jones <lizf@honeycomb.io>

pci_do_resource_release_and_resize() releases the device BARs that
share a bridge window with the BAR being resized, but when the device
sits directly on a root bus (pdev->bus->self == NULL) it then skips
resource assignment entirely and returns success, leaving the BARs it
just released unassigned (IORESOURCE_UNSET).

Skipping pbus_reassign_bridge_resources() is correct in that case --
there is no bridge window to adjust -- but the device BARs still have
to be reassigned. Before the BAR release was consolidated into the PCI
core, this case worked for amdgpu because the driver released the BARs
itself and then called pci_assign_unassigned_bus_resources()
unconditionally after the resize, which assigns unassigned device BARs
also on a root bus. Commit db92e3fef53e ("drm/amdgpu: Remove driver
side BAR release before resize") removed that call, so nothing assigns
the released BARs anymore.

This breaks amdgpu completely on the SolidRun HoneyComb LX2K (NXP
LX2160A, arm64, ACPI), where the GPU endpoint is enumerated directly
on the root bus of its segment (there is no root port device, so
pdev->bus->self is NULL):

  amdgpu 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: releasing
  amdgpu 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: releasing
  amdgpu 0004:01:00.0: sw_init of IP block <gmc_v8_0> failed -19
  amdgpu 0004:01:00.0: amdgpu_device_ip_init failed
  amdgpu 0004:01:00.0: Fatal error during GPU init

No error is logged because the resize path reports success; amdgpu
then finds BAR0 IORESOURCE_UNSET and bails out with -ENODEV.

Assign the released BARs directly from the root bus windows when there
is no upstream bridge. On failure, roll back through the existing
restore path exactly as in the bridged case.

The root bus path also had a locking bug that any fix here necessarily
touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
matching down_read() (as does the "goto restore" taken when
pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
before the BAR release loop so every path through the function holds
it exactly once.

Use pci_upstream_bridge() rather than testing pdev->bus->self
directly to decide whether the device has an upstream bridge. The two
are usually equivalent, but pci_is_root_bus() -- which
pci_upstream_bridge() uses internally -- documents that "virtual"
buses added for SR-IOV via virtfn_add_bus() also have bus->self ==
NULL without being root buses. pci_do_resource_release_and_resize()
is reachable for VF BAR resizes (see the pci_resource_is_iov() checks
elsewhere in this file and in rebar.c), so testing bus->self directly
could misroute a VF resize into the root-bus assignment path added
above. Nothing about the bug being fixed here involves a VF; this is
purely for correctness on that path.

Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
Cc: stable@vger.kernel.org
Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
Assisted-by: Claude:claude-fable-5 checkpatch
Assisted-by: Claude:claude-sonnet-5
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>
---
#regzbot introduced: 337b1b566db0

Observed at runtime on Ubuntu's linux-hwe-7.0 (7.0.0-14, broken) vs
linux-hwe-6.17 (working), but nothing here is distro-specific: Ubuntu
carries this code unmodified, and the affected function is identical
to current mainline. By source inspection the regression window is
v6.18 (old code paths) to v6.19 (consolidation). Workaround for
affected users: amdgpu.rebar=0.

On the topology question raised in review: this is physical hardware,
not a virtualized guest, running the UEFI/ACPI firmware variant of
this board (SolidRun also ships a U-Boot/devicetree variant of the
same hardware). Deferring to Jon Nettleton (CC'd, SolidRun) on the
exact root complex wiring; see the hardware manual's block diagram:
https://dev.solid-run.com/nxp/lx2160a/com-som/lx2160a-com-hardware-user-manual#block-diagram
---
Changes in v3:
- Add Reviewed-by from Krzysztof Wilczyński, received on v2.
- Use pci_upstream_bridge() instead of testing pdev->bus->self
  directly, per Bjorn Helgaas's review: bus->self == NULL doesn't
  necessarily mean a root bus (SR-IOV virtfn_add_bus() buses are the
  same), and this function is reachable for VF BAR resizes elsewhere
  in this file. Doesn't affect the bug being fixed here (not a VF)
  but is more correct in general. Reviewed-by kept from v2 -- this is
  a narrow, mechanical change to a path this device doesn't exercise,
  not a substantive rework of what was reviewed.
- Rebase onto current mainline.
- Add Jacob Martin to Cc: he independently triaged and accepted the
  corresponding Ubuntu report (LP: #2159596) on the Canonical kernel
  team, so he has direct interest in this landing.
- Move Ilpo Järvinen to To: for final review, per Bjorn.
- Link to v2: https://patch.msgid.link/20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io

Changes in v2:
- Add Assisted-by tags (missing from v1; required per
  Documentation/process/coding-assistants.rst)
- Add Link: to the corresponding Ubuntu bug report
- Drop the "# v6.19+" annotation on Cc: stable; unnecessary noise
  given the Fixes: tag already lets the stable team derive applicable
  versions (per stable-kernel-rules.rst)
- Link to v1: https://patch.msgid.link/20260705-pci-rebar-root-bus-v1-1-55df70cbdd88@honeycomb.io

To: Bjorn Helgaas <bhelgaas@google.com>
To: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org
Cc: Jon Nettleton <jon@solid-run.com>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
Cc: Jacob Martin <jacob.martin@canonical.com>
---
 drivers/pci/setup-bus.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c0a949f2c9956..d50f3d57a7791 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2380,6 +2380,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	struct resource *res = pci_resource_n(pdev, resno);
 	struct pci_dev_resource *dev_res;
 	struct pci_bus *bus = pdev->bus;
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
 	struct resource *b_win, *r;
 	LIST_HEAD(saved);
 	unsigned int i;
@@ -2397,6 +2398,8 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	if (ret)
 		return ret;
 
+	down_read(&pci_bus_sem);
+
 	pci_dev_for_each_resource(pdev, r, i) {
 		if (i >= PCI_BRIDGE_RESOURCES)
 			break;
@@ -2415,13 +2418,24 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 
 	pci_resize_resource_set_size(pdev, resno, size);
 
-	if (!bus->self)
-		goto out;
+	if (bridge) {
+		ret = pbus_reassign_bridge_resources(bus, res, &saved);
+		if (ret)
+			goto restore;
+	} else {
+		/*
+		 * A device on a root bus has no bridge windows to adjust.
+		 * Assign the BARs released above directly from the root bus
+		 * windows.
+		 */
+		list_for_each_entry(dev_res, &saved, list) {
+			i = pci_resource_num(pdev, dev_res->res);
 
-	down_read(&pci_bus_sem);
-	ret = pbus_reassign_bridge_resources(bus, res, &saved);
-	if (ret)
-		goto restore;
+			ret = pci_assign_resource(pdev, i);
+			if (ret)
+				goto restore;
+		}
+	}
 
 out:
 	up_read(&pci_bus_sem);

---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260704-pci-rebar-root-bus-f3123fe10fc7

Best regards,
--  
Liz Fong-Jones <lizf@honeycomb.io>


