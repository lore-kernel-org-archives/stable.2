Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AA569F28
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711260; cv=none; b=Xn83QXgE2SD1x49o6Hv7oNVl9qK/VbFYUadPJND9SJnmuC0qW6UT0+YwLqj56caMog1c5I01tjSNHSKivA/XOERN5AlDXRaRP5KmNxSGZ4bq+SwomNaG3YQCaMW7z74rmQG7d9mGbH/zRw8QqWIJMUy2mRIlw19OS9W/I1qZAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711260; c=relaxed/simple;
	bh=VxiIoUNkGwPwtSZaXsOujUHIjgPAV+YjhEQ26/qgLn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLoPyu6xz3T0lsQr6+Pu5rQNmjyVBqO2/CllDjt+YbrN1LbU2+KwJj3GijwR8bduuYxr5TJdQBrlITLvW9QQ7t6xfOxnIsshn0MBwYdws6146ysaBB7h2z2skPoKryub/bISpDn+w8/ZnhEPB/UeF3t8dodgf+XmgCRxVIRCMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDp45F5U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDp45F5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659111F000FF;
	Tue, 29 Sep 2026 19:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711259;
	bh=nR9Y4biN7p/IKRN5BfsOXIh2aFfSGLVmVZiaKB0epa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDp45F5URy4GBOvoXXZ651oiVsRAqIMYVijVDiqdpkMv8agxVUfCsK+gpMGXBvbSJ
	 bMcYCcpwX69oT9WBDQ+XvrE+y49bZtAtD+Ob26+gcT5nnr2EUMJMKAM198bLWq1r+g
	 P97V2aNXrn6TCKmASowRmlC5uKJXA34I6U+84s5SvPzXDrxspNySQQE/gxBH1SN9p2
	 X2y39xBlnXp5ATcg6vjAPkq7k8SDyRl6V3neoW2F+hx6xfa73QbFd1yri/z2kK22Jw
	 u/08yQOHBhK4488k4rl9QXWyNjnQm2tdbHRui6BGhFUT6Sq5lJo53iFsTkcl14LdPT
	 ynmBE/IEckGmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liz Fong-Jones <lizf@honeycomb.io>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] PCI: Fix BAR resize for devices on a root bus
Date: Tue, 29 Sep 2026 15:47:37 -0400
Message-ID: <20260929194737.835545-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092907-providing-residual-6198@gregkh>
References: <2026092907-providing-residual-6198@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Liz Fong-Jones <lizf@honeycomb.io>

[ Upstream commit d58384c22739848efe14b34e9586e4f1242f33c0 ]

pci_do_resource_release_and_resize() releases device BARs that share a
bridge window with the BAR being resized, but when the device sits directly
on a root bus (pdev->bus->self == NULL) it then skips resource assignment
entirely and returns success, leaving the BARs it just released unassigned
(IORESOURCE_UNSET).

Skipping pbus_reassign_bridge_resources() is correct in that case -- there
is no bridge window to adjust -- but the device BARs still have to be
reassigned. Before the BAR release was consolidated into the PCI core, this
case worked for amdgpu because the driver released the BARs itself and then
called pci_assign_unassigned_bus_resources() unconditionally after the
resize, which assigns unassigned device BARs also on a root bus. Commit
db92e3fef53e ("drm/amdgpu: Remove driver side BAR release before resize")
removed that call, so nothing assigns the released BARs anymore.

This breaks amdgpu completely on the SolidRun HoneyComb LX2K (NXP LX2160A,
arm64, ACPI), where ACPI doesn't expose the Root Port so the GPU endpoint
appears directly on a "root bus" of its segment:

  amdgpu 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: releasing
  amdgpu 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: releasing
  amdgpu 0004:01:00.0: sw_init of IP block <gmc_v8_0> failed -19
  amdgpu 0004:01:00.0: amdgpu_device_ip_init failed
  amdgpu 0004:01:00.0: Fatal error during GPU init

No error is logged because the resize path reports success; amdgpu then
finds BAR 0 IORESOURCE_UNSET and bails out with -ENODEV.

When there is no upstream bridge, call pci_bus_assign_resources() on the
root bus to place the BARs released above, using the same alignment-sorted
algorithm as normal enumeration instead of a manual per-BAR loop. This also
walks the rest of the hierarchy under the root bus, as
pci_assign_unassigned_bus_resources() used to for amdgpu before commit
db92e3fef53e ("drm/amdgpu: Remove driver side BAR release before resize")
removed that call -- the core-side fix that commit asked for ("such a
problem should be fixed inside pci_resize_resource() instead").

pci_bus_assign_resources() returns void, so failure is detected by checking
whether the released BARs are still assigned afterward; if not, roll back
as in the bridged case. This is stricter than the bridged path -- it fails
on any unplaced resource, not just required ones -- since a root bus
typically has one shared window, and failing loudly seemed better than
leaving something silently unassigned.

The root bus path also had a locking bug that any fix here necessarily
touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
matching down_read() (as does the "goto restore" taken when
pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
before the BAR release loop so every path through the function holds it
exactly once.

Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: Claude:claude-fable-5 checkpatch
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260918035633.566823-1-lizf@honeycomb.io
[ Replaced unavailable resource_assigned(dev_res->res) with the equivalent dev_res->res->parent check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7ec2ee3fe9093..19fbc7c5625fd 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2449,6 +2449,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	struct resource *res = pci_resource_n(pdev, resno);
 	struct pci_dev_resource *dev_res;
 	struct pci_bus *bus = pdev->bus;
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
 	struct resource *b_win, *r;
 	LIST_HEAD(saved);
 	unsigned int i;
@@ -2466,6 +2467,8 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	if (ret)
 		return ret;
 
+	down_read(&pci_bus_sem);
+
 	pci_dev_for_each_resource(pdev, r, i) {
 		if (i >= PCI_BRIDGE_RESOURCES)
 			break;
@@ -2484,13 +2487,21 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 
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
+			if (!dev_res->res->parent) {
+				ret = -ENOSPC;
+				goto restore;
+			}
+		}
+	}
 
 out:
 	up_read(&pci_bus_sem);
-- 
2.53.0

