Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F10EED8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726652; cv=none; b=iOKJR136DIGdMYKZ49jTUGxePrZy4qo5IvFcMqSfeTxsZaFMuJ5sTlGNL9047h6I5NWJdaYUknavJ8nxuXQa4d0yVyA0SAiJXGRiftzdzYxu3Nx5CqvaNIgC2AvAIXvQLjz9jnspITz/DnEUrHwZYnpFH+ugYJHpvPwQcP0YGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726652; c=relaxed/simple;
	bh=nOpJvGtsiJSz7fSnlPbp2b21WVpPyNjR4r3EwM3lISw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcLasQHVK6ieLmMD5MsS3K1K5I1SQqDoKSJ2fxKjLiNjKwlu+8c0GP6gArbNKGN/mFADLYpwluR0HqTeOmavholDnyF5VP8z8Agr3PWE0fQt/h87Qj7FjSBDCnznVv/zroPX7fbqRQVlDSZJlVFx2XYR6fCHDwrK9hEktSBEXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbB3LlZU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbB3LlZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA251F000FF;
	Wed, 30 Sep 2026 00:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726650;
	bh=axq78Kbaw3gpi9G+ISkjJZWB+dn4ydBX7PNXojGFf/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbB3LlZUU9QTcTRiREI5aYgT22tvwc71eSY8jkeVqPV36Cq3QmdozaTXty9qByShv
	 Gjf/9QAU6VQkQpJTdkOOHdvlvQCQY8f96H9CmZ8Q5WGuoHDn08Qn9OWrJbt0Hi1bG0
	 9gEdb1SerCYQm9gGP1Ysr2WpbT7eJjnXo0bbbAazflAj2mkvshcUC90x4IYc2X83Y/
	 dOcH41ReKs22QvTIiktfjLkSLXtyhaXp3u9jd7ndUkkLZalcX3oeGziUnPLFRwmDWZ
	 0wvOkwlSPVwQE5p29wxdqm6OECrDU4zh33VHJcDAXX8vYYMnB3bjcnSmqOtFegnVqO
	 rCb5yXBZ0AWRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] PCI: Fix Resizable BAR restore order
Date: Tue, 29 Sep 2026 20:04:07 -0400
Message-ID: <20260930000408.2862088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092923-revoke-childish-849f@gregkh>
References: <2026092923-revoke-childish-849f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 5528fd38f230c906fcebb202cc94fbb8ed8f122a ]

The commit 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback
path") changed BAR resize to layer rebar code and resource setup/restore
code cleanly. Unfortunately, it did not consider how the value of the BAR
Size field impacts the read-only bits in the Base Address Register (PCIe7
spec, sec. 7.8.6.3). That is, it very much matters in which order the BAR
Size and Base Address Register are restored.

Post-337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
during BAR resize rollback, pci_do_resource_release_and_resize() attempts
to restore the old address to the BAR that was resized, but it can fail to
setup the address correctly if the address has low bits set that collide
with the bits that are still read-only. As a result, kernel's resource and
BAR will be out-of-sync.

Fix this by restoring BAR Size before rolling back the resource changes and
restoring the BAR.

Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://lore.kernel.org/linux-pci/aW_w1oFQCzUxGYtu@intel.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260121131417.9582-3-ilpo.jarvinen@linux.intel.com

[6.12 dependency preparation for d58384c22739848efe14b34e9586e4f1242f33c0:
Keep the existing memory-decoding and supported-size checks in rebar.c.
Move BAR size programming and rollback into the resource release helper,
so the old size is restored before restoring BAR addresses.

Use the assigned parent window to select resources for release, retaining
the old flags-based selection when the resized BAR has no parent. Provide
file-local macro mappings for the follow-up's bridge reassignment and
resource assignment checks; no functions are added.

Retain the upstream pre-target pci_bus_sem placement to allow the target
to apply without conflicts. This preparatory dependency must be applied
together with d58384c22739848efe14b34e9586e4f1242f33c0, which takes the lock
before releasing resources and assigns released BARs on root buses.]

Stable-dep-of: d58384c22739 ("PCI: Fix BAR resize for devices on a root bus")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/rebar.c     | 19 +------------------
 drivers/pci/setup-bus.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 548894a3fad5c..98b49a48bcc6e 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -156,7 +156,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size,
 			int exclude_bars)
 {
 	struct pci_host_bridge *host;
-	int old, ret;
 	u32 sizes;
 	u16 cmd;
 
@@ -176,22 +175,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size,
 	if (!(sizes & BIT(size)))
 		return -EINVAL;
 
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
+	return pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 576c6112790c6..7b8c8e23a8c44 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2368,6 +2368,11 @@ static int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long t
 	return 0;
 }
 
+/* Keep the resize follow-up compatible with the 6.12 resource helpers. */
+#define pbus_reassign_bridge_resources(bus, res, saved) \
+	pci_reassign_bridge_resources((bus)->self, (res)->flags, (saved))
+#define resource_assigned(res) ((res)->parent != NULL)
+
 int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size,
 				       int exclude_bars)
 {
@@ -2375,12 +2380,20 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	unsigned long flags = res->flags;
 	struct pci_dev_resource *dev_res;
 	struct pci_bus *bus = pdev->bus;
-	struct resource *r;
+	struct resource *b_win, *r;
 	LIST_HEAD(saved);
 	unsigned int i;
-	int ret = 0;
+	int old, ret;
 
-	down_read(&pci_bus_sem);
+	b_win = res->parent;
+
+	old = pci_rebar_get_current_size(pdev, resno);
+	if (old < 0)
+		return old;
+
+	ret = pci_rebar_set_size(pdev, resno, size);
+	if (ret)
+		return ret;
 
 	pci_dev_for_each_resource(pdev, r, i) {
 		if (i >= PCI_BRIDGE_RESOURCES)
@@ -2389,7 +2402,10 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 		if (exclude_bars & BIT(i))
 			continue;
 
-		if (!pci_resource_len(pdev, i) || r->flags != flags)
+		if (!pci_resource_len(pdev, i))
+			continue;
+
+		if (b_win ? r->parent != b_win : r->flags != flags)
 			continue;
 
 		ret = add_to_list(&saved, pdev, r, 0, 0);
@@ -2403,7 +2419,8 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	if (!bus->self)
 		goto out;
 
-	ret = pci_reassign_bridge_resources(bus->self, res->flags, &saved);
+	down_read(&pci_bus_sem);
+	ret = pbus_reassign_bridge_resources(bus, res, &saved);
 	if (ret)
 		goto restore;
 
@@ -2413,14 +2430,22 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	return ret;
 
 restore:
-	/* Revert to the old configuration */
+	/*
+	 * Revert to the old configuration.
+	 *
+	 * BAR Size must be restored first because it affects the read-only
+	 * bits in BAR (the old address might not be restorable otherwise
+	 * due to low address bits).
+	 */
+	pci_rebar_set_size(pdev, resno, old);
+
 	list_for_each_entry(dev_res, &saved, list) {
 		struct resource *res = dev_res->res;
 		struct pci_dev *dev = dev_res->dev;
 
 		i = res - dev->resource;
 
-		if (res->parent) {
+		if (resource_assigned(res)) {
 			release_child_resources(res);
 			pci_release_resource(dev, i);
 		}
-- 
2.53.0

