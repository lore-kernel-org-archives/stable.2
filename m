Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794230457;
	b=kHgjxWsIZ/kNsIGytQw3Ie9PzPZdFVoEoyhS5Tj6up8lhrixRPm0Lxm3PXTnV4vz58j0
	 L3hmWeZXVzcUCWVVKNlf+7TMW7QtpVCcIRzFU+rosU/f1W4Kv/7lVvrOfh43Z3mmS4kdO
	 xr+ZICcAFopeHHG4HVIe01zpCzq12DT+y7qXtZjuTHdPnnPbzlNtH6CdTR7T8iVsiiXYy
	 fVJ4YDirsqcue3am6eDZtDMDS2kyAgA2MG3fSJP/KxoASx/KOJoLTWqbjwmoH4H/6y0pD
	 b/7fvLqldMunX8TDpaTaAcIfOZx/Q1WANfC98nTjhIf0/9GBcIeAVkozsksf8D1/gXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230457;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8kk0BDRZXw+7xDFuJqSRq4HWjhAAgBkMx2607nI6V0M=;
	b=PG778YW0VGzQSiuUUWz/H5UClsE4FjxMRZ6OmCOT3ng22kKKOUzIuEWu2SouQFPLfYcn
	 /Xjf+XAIOyUUtA8umDYVGQmbcLUHaHhAnRwwE1Ph7SqHCd3+ceaIuiIg59Lsf0k0o587q
	 gB68dUmGF5wB3vyj8jud2M9tkvLp4thLws3jDKGUd7TuFeGDMVwK/Cov3Ch4gGcLCqD0M
	 1lUDA1xfc2eiO8g2a69r1GL9Tl45kTTdbPEANuH1Xw1JToGyDmJp5F5ENY26RfZKg8fiF
	 z2guzbO+uHx4UhRc6T9XnYj54LHl5vSnvbfYXjmMVwQ39+TyrNJRd8DA1PzgYYKPfhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EttyTTco;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BD606A31C;
	Mon,  9 Nov 2026 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EttyTTco
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794230456;
	b=ujDyzZNuJqxHcS5OZ0TODgapNL8q/6PwsX79nR0UAuO4wC2RFQTcpbpPEUUNUneY2Mu8
	 CYBakwQUKWO+LNNlQvpj1x8S0LQfSP0yEJ2hZGEb0CbWalU7YPMMoPgbojVunf5WbLrn6
	 GlHs8qFu9mB2orA9zs4fGFYRr2jVCEMcaoPkELneXru2k8Y+xluLpeyEqqLAy53SGgVJk
	 GqJK9U45zeQYjvKyQUd096ej33EcwGSwJyevR5Q4yRB+Thsn3DgMu38VgJ5fPKHSxWPbI
	 3cWWNvJUzaCMD3tfwj+rlMU9/L0LmSbtzUo+GHXRANxIgLIHDpGt+d6kHaDkjI6MgoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794230456;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8kk0BDRZXw+7xDFuJqSRq4HWjhAAgBkMx2607nI6V0M=;
	b=bSk9NuARkxLvoSB62ZkRubPrXQ1df5G+a6G/YjMyXKr49xTpMVkB1zuPY0IPgUGuYvSm
	 gtkuBvzwuswFM1jPG20L0qC9rvjWvO49wF9AMT3UVSI1EVNSWrHnXH1YnAGRQgReN8PaH
	 RXTBBuoP4+PweUdkQnEJLpeq5r96PHrXvWxXP7u4ZJkYQcD65nCgO9eqqNdoAo6WprxNf
	 P1wpC5UgVZ9RIoyb7FChpnU1pz2Kz0OOlD8xck8t4A6uR+v3ahThndsmBzrYbRRECwyJG
	 7CwfCzBnHxc1GQBdGoVhoj99aCs2HXzjYaHI3WOgmqQJTsikVGgbd+6AfFpRrtR+8kw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3B8831F0089F;
	Mon,  9 Nov 2026 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230456;
	bh=8kk0BDRZXw+7xDFuJqSRq4HWjhAAgBkMx2607nI6V0M=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=EttyTTcodJ8EkEvBkBr2Z05BoVQAYLNmwMEcpCRUAwLszZHcUJPlIuDJlcmy7ts4i
	 5UDBYi5o0LTExQbsQ4WKBT/+F/yifPlY4jxfFN8C7/07k1GjLm3YiLXSkBtf70vmEu
	 yuw1Ghty+cAgN2QgfdX0tRhYVpJ6d3YqpuxMOoLgaL6to9ilPPDw6W4eUrQamm19g8
	 fiq+2U7qMpD+GBbeLliaB4mO2CK3XbhOXc0f7HKsF61zgv+Gqzsg8NVc93yH8vsCNo
	 9WHJY9nheQYL7tfONxxBrl7Pp8kVKUL2hJ3UxxoSu+icmlAJ5JbLNEhguiH5/Hm6+7
	 fYUSXrwfFNl0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C14C2484AE;
	Mon,  9 Nov 2026 13:20:55 +0000 (UTC)
From: Ahmed Abdelfattah via B4 Relay <devnull+me.ahmedabdelfattah.dev@kernel.org>
Date: Mon, 09 Nov 2026 15:20:52 +0200
Subject: [PATCH] iommu/vt-d: Set up scalable mode context entries for DMA
 aliases
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-iommu-vtd-sm-bridge-alias-v1-1-76704f658dc3@ahmedabdelfattah.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB0wKhW9SnExSabtFKMloyKId
 zfV5Qfv/TsoR2GFLtsh8ioq05hg8gzch8Y3o/hkKIvyYUzRokwhLLjOHjWgjeLThAYhxZapcc4
 3NVUW0v8X+SXb1X72t3WxX3bzPwjHcQL9pKzpfQAAAA==
X-Change-ID: 20261109-iommu-vtd-sm-bridge-alias-9ea7ccd74a3b
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794230455; l=3605;
 i=me@ahmedabdelfattah.dev; s=20261106; h=from:subject:message-id;
 bh=dhz3rHJR7YOUo+roQBNF725wE94t53ubNOSPW8yLvDQ=;
 b=CCaCnLcMIkkJ833TNpgDHDuF6lqomjTQZdvFCQ9qy0RVezMbNjY5HwSKOoRlmEcmNnZBj92e/
 ozmQTn2f9TEDttmf2taiXGkoCtIP5IPgF1ywzfnbC822Hg12pULtuVB
X-Developer-Key: i=me@ahmedabdelfattah.dev; a=ed25519;
 pk=DHEHKU4PddrkJ/iYMZpwyyXsFyIQ6ySjTttKLrt9YqI=
X-Endpoint-Received: by B4 Relay for me@ahmedabdelfattah.dev/20261106 with
 auth_id=1438
X-Original-From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
Reply-To: me@ahmedabdelfattah.dev
Content-Transfer-Encoding: 7bit

From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>

In scalable mode, devices behind a PCIe-to-PCI bridge can't do DMA at
all. Their requests carry the bridge's alias requester ID, and the
context entry for that ID is never written, so every request faults:

  DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr 0xfffff000 [fault reason 0x02] Present bit in context entry is clear

pci_pasid_table_setup() and pci_pasid_table_teardown() only act when
they are called for the device itself. pci_for_each_dma_alias() reports
an alias that comes from an upstream bridge with the bridge as @pdev,
so these aliases are skipped. An identity domain doesn't help either,
as the device still needs the context entry.

Legacy mode is fine, because domain_context_mapping_cb() and
domain_context_clear_one_cb() have no such check, and the same check
was already removed from the pass-through path in commit 64f792981e35
("iommu/vt-d: Remove device comparison in context_setup_pass_through_cb").

Drop it from both callbacks, so the alias context entry points to the
device's PASID table and is cleared again when the device is released.

Fixes: 301f1a80487f ("iommu/vt-d: Setup scalable mode context entry in probe path")
Fixes: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
---
This showed up with a USB controller behind QEMU's pcie-pci-bridge in a
q35 guest using intel-iommu with scalable-mode=on: the USB tablet behind
it never enumerates.

Tested on v7.4-rc2 in that guest (x86_64_defconfig + kvm_guest.config,
INTEL_IOMMU with scalable mode on by default), with an EHCI controller
and an e1000 behind the bridge, in scalable mode with second-stage
tables, with first-stage tables (fsts=on) and with iommu=pt. Without
the patch both devices fault on 02:00.0, the tablet never shows up and
the e1000 hits Tx unit hangs. With it the tablet enumerates, the e1000
passes traffic and no DMAR faults are logged. Removing the EHCI
controller through sysfs and rescanning brings it back without faults,
which exercises the teardown side. Legacy mode behaves the same with
and without the patch.

Devices that share an alias always end up in the same IOMMU group, so
whichever device's PASID table the alias entry points to, it translates
with the group's domain. As in legacy mode, releasing one of them also
clears the alias entry the other one uses, so its DMA is blocked until it
is probed again (see the comment above domain_context_clear()).
---
 drivers/iommu/intel/pasid.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index e4f24d3f19a6..e72b6e972cfb 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -760,8 +760,7 @@ static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct device *dev = data;
 
-	if (dev == &pdev->dev)
-		device_pasid_table_teardown(dev, PCI_BUS_NUM(alias), alias & 0xff);
+	device_pasid_table_teardown(dev, PCI_BUS_NUM(alias), alias & 0xff);
 
 	return 0;
 }
@@ -897,9 +896,6 @@ static int pci_pasid_table_setup(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct device *dev = data;
 
-	if (dev != &pdev->dev)
-		return 0;
-
 	return device_pasid_table_setup(dev, PCI_BUS_NUM(alias), alias & 0xff);
 }
 

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261109-iommu-vtd-sm-bridge-alias-9ea7ccd74a3b

Best regards,
--  
Ahmed Abdelfattah <me@ahmedabdelfattah.dev>


