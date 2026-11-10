Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320229;
	b=4MwuQHU8lcBO+swQTmLriTZh9YK6x75uTHxEdRiOuYbYog8fRF0mISrSdARzCruIDV3F
	 wNRhcY+TICcVG2Ag8rVCHcMBaum+4Bg8s1MCfRM2H2ro8yDEasVPeCvca9ACo8/1fpjr4
	 BWhmwwAbdCZqmZ68+mHFeRIUkXGbmUc7lDSCGNTu3rHL3t3Epqih9FapjPITEXsgk0Zoj
	 R/1L6wA+G8QlMTbKLSTZh84EeasZwF+SEjhXhQvgvff2Bn5spA/QJs87IhaePRzcKHeru
	 V1Srm/deMxMtheRJ4N7QgYlI0bBrt6PDacY3eeyjX6DQ4fYCNPxeCmTer2vsG1B25vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b+lDqGx4OeyrR0hudbjxnKFSYpDo8Y0+WklOaXbfS20=;
	b=utYa4uH6pSgaFiEbe3Z4dKee1LgO2kw94qEtbtzUcNjwq9SJmGxeWulHuoNSIAdrbgly
	 GJAFuIZUTAQMd0Zxp/LlFhiCwkCAcR8vuOc/PaGnRenncy3HGLj13pu3z+79y7ZGAi7MJ
	 QOuvixsaVjggpvXvmF32dJ/DtO1eBI1z0BjuHDhWOnYxaz2TBiwbZpL51VLwmjZR9BUnq
	 71eq2Zoo7lotSVsMgDGO9n3bQRDZZd6TqhKmTieIisun6U/7z3Y+lTL7n4RBOo3UOxScI
	 JwOnu3Tcn5CfALw20OfnXRIG06l+E2vny9ztdJSKpKFLOqFBOR68pFmHvh13iPqPlOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNTGjhND;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06235606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNTGjhND
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FD51F0089F;
	Tue, 10 Nov 2026 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320228;
	bh=b+lDqGx4OeyrR0hudbjxnKFSYpDo8Y0+WklOaXbfS20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HNTGjhNDSb1QEfyU+2tamTUTLlkAfQkvDGuAxE2V+1uMEShiXOpTKMgeIjNH39hnP
	 EYIkkKIRMmLP/AuJry0byRbCuI2QIk7eoKGNEqFP7PJ2pYIEMNsrbkwbkjlMtI9zTT
	 VLjI+1uydkOpl3iBcZ/fGPdfpGzqblJkyTbUAiJRyrhMD0G1CCloe9d3V2m6SO66Yn
	 rkXk9gTERl35Qyg4c8jZohk0RuGX5D/TYxhYThypkLm+7cic66pIxSsaYfJW2z9Rov
	 pQZ1kb1rqGEX+EGUAuHQjPU852+xqTP0vLrbhxAQmj2g4H8ttinnIt0w3OusvCQf3q
	 bf3C2pWyGvsIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Szymon Durawa <szymon.durawa@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
Date: Tue, 10 Nov 2026 09:17:04 -0500
Message-ID: <20261110141653.1791478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051011-failed-6.18-2c88c2dc1852@kernel.org>
References: <20261107051011-failed-6.18-2c88c2dc1852@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit b37b6095a94e1ccecac80c9f1a8fca8d72919c65 ]

The new common domain number allocator can replace the custom allocator
in VMD.

Beyond some code reuse benefits it does close a potential race whereby
vmd_find_free_domain() collides with new PCI buses coming online with a
conflicting domain number. Such a race has not been observed in practice,
hence not tagging this change as a fix.

As VMD uses pci_create_root_bus() rather than pci_alloc_host_bridge() +
pci_scan_root_bus_bridge() it has no chance to set ->domain_nr in the
bridge so needs to manage freeing the domain number on its own.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Link: https://patch.msgid.link/20251024224622.1470555-3-dan.j.williams@intel.com
Stable-dep-of: 2c88c2dc1852 ("PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 40 +++++++++++++++---------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index aa6d4f56f612a..88bb5536744d7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -578,22 +578,6 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
 	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
 }
 
-/*
- * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
- * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
- * 16 bits are the PCI Segment Group (domain) number.  Other bits are
- * currently reserved.
- */
-static int vmd_find_free_domain(void)
-{
-	int domain = 0xffff;
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL)
-		domain = max_t(int, domain, pci_domain_nr(bus));
-	return domain + 1;
-}
-
 static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 				resource_size_t *offset1,
 				resource_size_t *offset2)
@@ -881,13 +865,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
-	sd->vmd_dev = vmd->dev;
-	sd->domain = vmd_find_free_domain();
-	if (sd->domain < 0)
-		return sd->domain;
-
-	sd->node = pcibus_to_node(vmd->dev->bus);
-
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
@@ -913,9 +890,24 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
+	sd->vmd_dev = vmd->dev;
+
+	/*
+	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
+	 * domains.  Per ACPI r6.0, sec 6.5.6, _SEG returns an integer, of
+	 * which the lower 16 bits are the PCI Segment Group (domain) number.
+	 * Other bits are currently reserved.
+	 */
+	sd->domain = pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
+	if (sd->domain < 0)
+		return sd->domain;
+
+	sd->node = pcibus_to_node(vmd->dev->bus);
+
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
+		pci_bus_release_emul_domain_nr(sd->domain);
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
 		return -ENODEV;
@@ -1008,6 +1000,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
+	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
@@ -1073,6 +1066,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
 	ida_free(&vmd_instance_ida, vmd->instance);
+	pci_bus_release_emul_domain_nr(vmd->sysdata.domain);
 }
 
 static void vmd_shutdown(struct pci_dev *dev)
-- 
2.53.0

