Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939984915AA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895422; cv=none; b=NDGLSgZY+fKqKG3I/FE13KiuwJfum7nOamqyr6NI2ji4SR9T9jmo4OOgZkUtL9+gwWVZkfv8p20T3QvWEXN4ubZ1dsYasnmffUfJNBFq8OJySgmZ5XU8S19rMLuPpW81N34kJ8my+7qpqd6uj6gc1ZVi2P/rmJoiWoX7nb8JY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895422; c=relaxed/simple;
	bh=2YT3G/W3RYmHP8SAFjoVPUfGng9QTDp2Kvk+0FfEI0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cXesy6VSx5IDhniEjNLIZp9o0/FWYyoFxHLJLEc8b2PBZmMzy59wtdeqv0t4HQRZYgp5DwqfzS6SLTJjNXcAc7OCl1u6qIsaUr8EodFAIaJWMWHI7HkaFKunwo7VLo9yvdD6xAsgg+ZCBvLmhsPYyhtkBHi1+Ho3aA+b+jHEF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=Ml2AWGo1; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="Ml2AWGo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:date:subject:mime-version:content-type:content-transfer-encoding:
	to:cc:cc:content-type:date:from:subject:to;
	s=s1; t=1788895418;
	bh=XKSZye67d8JWpvqcZAS4vVfrMeJDR4xzGGcJsQcvPTA=;
	b=Ml2AWGo1YQh8VWcnIh+RUDPtRM4MglnGEM4Rq8U31GM5fImmcvl/2LuF+CpZcVxC/WRt
	ekKmCdbXE/ySi3T+4LtGW7pqU1IlwlMy6zc3ZeERGD0xluRn1g9SN4Tp8oil7mAbQDW2zw
	P+t1hS6bKCtpToXdZ6yK+DHwBS0gcAGt2S1N27y+lwQtQU4Lvv9VEkV34J2fQbCshQ+sqY
	hWfU3CvBrw3i2cYW7fN+YGe/czSKR5zlRahjpEFQggJKsKEvFP3mDEtCj5gYgMXOK4pZGH
	i0PVvulpu6N9kWC/q7/fWvDtowlN1ZvmnchAcl+JTYi+sZlfiJ0Tl4FkVkCwh34A==
Received: by recvd-79d65b999-bztzm with SMTP id recvd-79d65b999-bztzm-1-6AA060B9-A6
	2026-09-08 19:23:37.791143227 +0000 UTC m=+3630567.265530310
Received: from [127.0.1.1] (unknown)
	by geopod-ismtpd-14 (SG) with ESMTP
	id p46aKrcOTaWJTa7t3sRjLg
	Tue, 08 Sep 2026 19:23:37.711 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Date: Tue, 08 Sep 2026 19:23:38 +0000 (UTC)
Subject: [PATCH v4] PCI: Fix BAR resize for devices on a root bus
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-pci-rebar-root-bus-v4-1-2780e9c22e08@honeycomb.io>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQrCMBCF4atI1kYyk9a0rryHuGiSiY1gU5Jal
 NK7myqCSJcPZr5/Yomip8QOm4lFGn3yocuj2G6YaZvuQtzbvBkK3AslCt4bzyPpJvIYwsD1PXE
 nAaUjEM4olh/7SM4/3ujp/Nnprq9khkVaLlqfhhCf7+oIy903UK4FRuDAy9I6JYy2tqqObejoa
 cJN73xgS2PEHwVwVcGsNKBrEKqp0JoVRf4oElYVmZW9kkgopTN1/afM8/wC6ozoXVUBAAA=
X-Change-ID: 20260704-pci-rebar-root-bus-f3123fe10fc7
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8370; i=lizf@honeycomb.io;
 s=gpg; h=from:subject:message-id;
 bh=2YT3G/W3RYmHP8SAFjoVPUfGng9QTDp2Kvk+0FfEI0Y=;
 b=owEBbQGS/pANAwAKAaXO1OOXra/CAcsmYgBqoGC4VasNlY6NyxFzaSCRMjnV0gPbvSpeUNQhQ
 K3n88XneZaJATMEAAEKAB0WIQSfW1LPQ0gyJmoTHwelztTjl62vwgUCaqBguAAKCRClztTjl62v
 woGGCACt+9ZAvpzd3kTrFZ0ncZy1ZllG/oGlBmdKWrmA1QNZr+FIw62XF7hWEFBwXtXhcBqeCD+
 sQQ13urM0Lb1iOSeXhvDP2XkzjF0hxhv0fnBEUNr/AwofHY47Ush8r+vJV1xBQn8OFO4P78xJcu
 x1kf+w/IG1wPGXyNKaktC+XssKjHU/as6kMjFHhNp4ogOozMQx7HmCq+2SU+I5Eq3mEI5oWqRsR
 maWmAGR5pVQe1QPwm8DDIy5uqVvJdRhD12DzCoK+zLWOaoxNtPVcDisW/kA3BYcLwJoYa/wZRL/
 We7cH+DHvypaUWyi/APfv6S+joZrPa7g8auWqTHmWep1HEpA
X-Developer-Key: i=lizf@honeycomb.io; a=openpgp;
 fpr=1F7714D7EC3441D2CECC24606A3F8B00FBDDD2A4
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmecTnVcYYuGdz?=
 =?us-ascii?Q?y6JdwkXztV5yobw=2FIKIy8r6+xEz8iHtMNZI2HuZ?=
 =?us-ascii?Q?8x4kiMRWVljWXl0Akj5B8lI0rLIIWt7fr4tMcFt?=
 =?us-ascii?Q?13ILdZcuaeYbVMOEnBexpqyI8Tiv0d3ivTqso7C?=
 =?us-ascii?Q?LWvidplVlO4dWrrYg6rrFfOPfVcmgWMJOTdIGXk?= =?us-ascii?Q?JOlz?=
To: Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?iso-8859-1?q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, Jon Nettleton
	<jon@solid-run.com>, Jon Nettleton <jon.nettleton@gmail.com>, Jacob Martin
	<jacob.martin@canonical.com>, Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org, Krzysztof =?iso-8859-2?q?Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Liz Fong-Jones <lizf@honeycomb.io>
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==

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
Changes in v4:
- No functional changes. Resending per Thorsten Leemhuis (regressions
  tracking) -- this looked to have fallen through the cracks after
  v3. Confirmed still broken today on v7.3-rc2 (mainline) and v7.2.4
  (stable): pci_do_resource_release_and_resize() still has the
  original "if (!bus->self) goto out;" with no reassignment on that
  path.
- Rebase onto current mainline.
- Link to v3: https://patch.msgid.link/20260731-pci-rebar-root-bus-v3-1-6732e233fc99@honeycomb.io

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
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
---
 drivers/pci/setup-bus.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e8c94aa1d3c1..9907dc5521aa 100644
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
base-commit: 5acbae5f7eb3d5275120abfe698c394b7325dcec
change-id: 20260704-pci-rebar-root-bus-f3123fe10fc7

Best regards,
--  
Liz Fong-Jones <lizf@honeycomb.io>

