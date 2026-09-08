Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CC478E5F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908586; cv=none; b=dmS0DO8PtNmZmyAZcq6Zmti/UVwrqgbJi8boefvq0zHOJv7JPKxSBXiN1iPNKjRz9ssul+2hVenNzIKQzwDnfOC4mH2UVhb48ewcfzHCSmqxUwK4ypZcrdxvjgr/eT0WDmqEtr8ajPhY5IFssROuHC5sBU5Dj7VG5kSct9ddJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908586; c=relaxed/simple;
	bh=D2YuvcUAHUFJza8GC6Kjwm7Grr/7KVf6tU/jjasoRfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MgmNE/+STGB+VZxUc1k2B7SOCEefuJJaEsotKErLTx/fLOFZ/aYi/lHx4Us28QQlv1RPoYLnyyiiMkO10nZhs/Xms9HfNRAmMuqNZ4UEj921whc6zfeL9AlU/apcxu6fj7IcmH0h/frxFT1OgBYpn+9f727xiA++kQmW2GAVPjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=XmUfG0D1; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="XmUfG0D1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:date:subject:mime-version:content-type:content-transfer-encoding:
	to:cc:cc:content-type:date:from:subject:to;
	s=s1; t=1788908583;
	bh=hzMs9bWmTBKn/dyZ3v41ire/mT+Fl+HYyGkzUgv04nk=;
	b=XmUfG0D1X6lSbycQsv+9AG4MZ0XLSfjt20qJdPz/kTDgMsG71Sd0IYImmu7PovV6Rz2n
	fnUai95JFV2AcXPgI3pfIwzPx8RoDobq0uZeDzSAoJbUAL29DG8qN5oiUl9uD9ZLXgAh7O
	ZR5TTjKHmJlmu0n+vFAzefOpBpgcpm1L2P1crZCAgDFGSk7qVOFn5OcJQz2kUjmixVe6P+
	S6/RrXpvacWDQ5wjQ71wtQRbTZx3BmfXVMHDmSFuddd7OlcOLjh1sjcwnnmos8VMRMQz8i
	53EP1mspRQLwSMRzEkSqaVE5MAAEUPfEXJ72wNZXX+sWm6vpmEgwMlVqbd2B9mxw==
Received: by recvd-668757f9cc-jnt6k with SMTP id recvd-668757f9cc-jnt6k-1-6AA09426-141
	2026-09-08 23:03:02.859202496 +0000 UTC m=+3643851.653686036
Received: from [127.0.1.1] (unknown)
	by geopod-ismtpd-8 (SG) with ESMTP
	id oYFXptEuSG6pF6ftZE61Ag
	Tue, 08 Sep 2026 23:03:02.804 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Date: Tue, 08 Sep 2026 23:03:03 +0000 (UTC)
Subject: [PATCH v5] PCI: Fix BAR resize for devices on a root bus
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23PQW7DIBAF0KtErEs0DHaArHKPqAsDQ02lmggcq
 1HkuxenihpVLL/0533NnRXKkQo77u4s0xJLTFMN/duOuXGYPohHXzNDwAMo6PjFRZ7JDpnnlGZ
 ur4UHKVAGEhCcYvXwkinE7wd6fv/N5Wo/yc2btDXGWOaUb4/VRWy950DfGlgEF7zvfVDgrPdan
 8Y00c2lL7uPiW0bC74oApsKVmUQ1ghQg0bvGop8UaRoKrIqByWRUMrgjGko3Z9iQDeVriqoNJB
 xiAT/P1rX9QcRazMsmwEAAA==
X-Change-ID: 20260704-pci-rebar-root-bus-f3123fe10fc7
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9707; i=lizf@honeycomb.io;
 s=gpg; h=from:subject:message-id;
 bh=D2YuvcUAHUFJza8GC6Kjwm7Grr/7KVf6tU/jjasoRfQ=;
 b=owEBbQGS/pANAwAKAaXO1OOXra/CAcsmYgBqoJQmvh3lUFWQGVYTBoKHHX13qVQYZ3v7VoOhm
 MAY4oF2oJ+JATMEAAEKAB0WIQSfW1LPQ0gyJmoTHwelztTjl62vwgUCaqCUJgAKCRClztTjl62v
 woNNCAC7e2YMkWiEwxf06fN7i9NVJXM5svGmCdIM1YrGjKHfi3h8cQ4AQh7YmjOsvl76vFkXtKZ
 HlLiw2+wg0gjqPBcI5iuFAabcMFZ1ZeuVuR1GMSCPvyK/s1AOWTMqKEOEEKDtgsPnJdL52B709o
 939hyQ0C39fEM5KE2ltuP8gSLYg/TypRp/gXLtQ1PxrvlMqatt83dl1bWLYhPUNCDXzYrYNNmM/
 NodQxzZJseiO0XSSpXdZZk09/f22Y1QiHIcgQaeQ6mufPz0AIc2KNhujJzqVEXxjRQXa+ymjKza
 5naF6Do8hSMPQ0X2SuRWw07KWzMYiL2NT8WQDGaxgin9o5sf
X-Developer-Key: i=lizf@honeycomb.io; a=openpgp;
 fpr=1F7714D7EC3441D2CECC24606A3F8B00FBDDD2A4
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmef43UvCFff4x?=
 =?us-ascii?Q?hVKLca=2FKLaJQz5Z7IxcROrl0PkkesuNkUt9DEJC?=
 =?us-ascii?Q?jF7OMyVM7olLWpf+j2dZZewHV8XYQ005O1Y+gK5?=
 =?us-ascii?Q?rFjnG8jUu7h8YOQfKA8meNKWbrcoZx6LzR31=2FNe?=
 =?us-ascii?Q?tkmlUEdqhAiUoMtKCW8Yg=2FJ0rOeVJKDnhwasIUa?= =?us-ascii?Q?haPQ?=
To: Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?iso-8859-1?q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, Jon Nettleton
	<jon@solid-run.com>, Jon Nettleton <jon.nettleton@gmail.com>, Jacob Martin
	<jacob.martin@canonical.com>, Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org, Liz Fong-Jones <lizf@honeycomb.io>
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

When there is no upstream bridge, call pci_bus_assign_resources() on
the root bus to place the BARs released above, using the same
alignment-sorted algorithm as normal enumeration instead of a manual
per-BAR loop. This also walks the rest of the hierarchy under the
root bus, as pci_assign_unassigned_bus_resources() used to for amdgpu
before commit db92e3fef53e ("drm/amdgpu: Remove driver side BAR
release before resize") removed that call -- the core-side fix that
commit asked for ("such a problem should be fixed inside
pci_resize_resource() instead").

pci_bus_assign_resources() returns void, so failure is detected by
checking whether the released BARs are still assigned afterward; if
not, roll back as in the bridged case. This is stricter than the
bridged path -- it fails on any unplaced resource, not just required
ones -- since a root bus typically has one shared window, and failing
loudly seemed better than leaving something silently unassigned.

The root bus path also had a locking bug that any fix here necessarily
touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
matching down_read() (as does the "goto restore" taken when
pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
before the BAR release loop so every path through the function holds
it exactly once.

Use pci_upstream_bridge() rather than testing pdev->bus->self
directly. The two are usually equivalent, but pci_upstream_bridge()
is the canonical test -- pci_is_root_bus(), which it's built on,
warns that bus->self == NULL doesn't necessarily mean a root bus
(SR-IOV virtual buses from virtfn_add_bus() are the same).

Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
Cc: stable@vger.kernel.org
Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: Claude:claude-fable-5 checkpatch
Assisted-by: Claude:claude-sonnet-5
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
Changes in v5:
- Per Ilpo Järvinen's review of v4: use pci_bus_assign_resources()
  instead of a manual per-BAR pci_assign_resource() loop in the
  root-bus branch. Same outcome for the bug being fixed, but reuses
  the core's alignment-sorted placement algorithm and matches the
  design intent stated in db92e3fef53e's commit message, rather than
  reimplementing assignment ad hoc.
- Drop Reviewed-by from Krzysztof Wilczyński: this revision changes
  what the root-bus branch actually does (not just a predicate, as
  in v3's pci_upstream_bridge() change), so his v2 review doesn't
  carry over. Add Suggested-by for Ilpo instead.
- Add Suggested-by for Bjorn Helgaas too: overdue credit for the
  pci_upstream_bridge() suggestion from v3 review, which only ever
  made it into the cover letter's changelog, not the actual commit
  trailers.
- Link to v4: https://patch.msgid.link/20260908-pci-rebar-root-bus-v4-1-2780e9c22e08@honeycomb.io

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
 drivers/pci/setup-bus.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e8c94aa1d3c12..ed16ef7c26fa7 100644
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
@@ -2415,13 +2418,21 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 
 	pci_resize_resource_set_size(pdev, resno, size);
 
-	if (!bus->self)
-		goto out;
+	if (bridge) {
+		ret = pbus_reassign_bridge_resources(bus, res, &saved);
+		if (ret)
+			goto restore;
+	} else {
+		/* No bridge window to adjust; let the core reassign the bus. */
+		pci_bus_assign_resources(bus);
 
-	down_read(&pci_bus_sem);
-	ret = pbus_reassign_bridge_resources(bus, res, &saved);
-	if (ret)
-		goto restore;
+		list_for_each_entry(dev_res, &saved, list) {
+			if (!resource_assigned(dev_res->res)) {
+				ret = -ENOSPC;
+				goto restore;
+			}
+		}
+	}
 
 out:
 	up_read(&pci_bus_sem);

---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260704-pci-rebar-root-bus-f3123fe10fc7

Best regards,
--  
Liz Fong-Jones <lizf@honeycomb.io>

