Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7CA3FFD
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101303; cv=none; b=BZQlh0UEOgMwv4g9i6GYg+F9DMKwz7bUph5eIIpBC9i4a62fUdwRtQqId4zij0dujH1UV48Ty2Lpvvr7cifGMgpJWZ4tngGxlUYWKLEDMOVq+t1UDcgODDq6WmRaK4p2NCqAJaKwsg9ZBoiGNpAbTLumM2OH42St8YTJuYJcgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101303; c=relaxed/simple;
	bh=iu7GKZndJUkhJJTW0ONyJCAkd6iEpp+LDenp/lpjpAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPNcSz5wJCXBhU02QOpA2L1i+KH14/rLuT/1CvcEWC8rpLqqV09CoHFqoq7G81QJAVcNH1IZbLVMU8xune869trhaMnL+//krO+6sehdeurmrQZNhOc0efvMutvxukNxgP84iA8GKQ/zVEWXa93LSVl+/E+AaGT3kqcxBZ3Yaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHs13dRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHs13dRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7601F000E9;
	Sun, 26 Jul 2026 21:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101301;
	bh=ez4M9q/cQ45Ih9Tody7laqa3Afje2eobw3QMx+MuCMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHs13dRCLfTWD/7EbIu/Rn9Jaq2icrZAC3fofz6dCwdgdveWWj69c6w3utCDkTI3+
	 Vn/aT0dUMUFfq/HMu1dQFU58OcWUe1MtHWUkhOQR0MIODiXLEny7V1N3nH/SUlhHEF
	 C88zQIDEklQaA64ohrWfLLnXVik+8UkSXsKBerlKfDoTffoLS+BMD4rA8ZzSMhp+Xy
	 WlpQdYavRpIGsO2MiS8Moke74k0xrEAcvMJgxtFSdZ0it1j86KRbk+fXAFaNTF34xB
	 +oo6fmWMWw/3TwEK9fGe7ZP39cZkwKoDj0pJlme0RVcYxEyYb+ZAVDrAl+on5cX8et
	 x7XJOcegrIenw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] PCI: Add pci_find_vsec_capability() to find a specific VSEC
Date: Sun, 26 Jul 2026 17:28:16 -0400
Message-ID: <20260726212819.4022652-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072058-sadly-hatchery-b25e@gregkh>
References: <2026072058-sadly-hatchery-b25e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>

[ Upstream commit c124fd9a969acaa83f6dfa5e160a99a500af9e4b ]

Add pci_find_vsec_capability() to locate a Vendor-Specific Extended
Capability with the specified VSEC ID.

The Vendor-Specific Extended Capability (VSEC) allows one or more
proprietary capabilities defined by the vendor which aren't standard
or shared between vendors.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/d89506834fb11c6fa0bd5d515c0dd55b13ac6958.1613674948.git.gustavo.pimentel@synopsys.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 8ffba0171c6b ("dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8ed2c9fb263ab6..6658bba9717d7c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -690,6 +690,36 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
+/**
+ * pci_find_vsec_capability - Find a vendor-specific extended capability
+ * @dev: PCI device to query
+ * @vendor: Vendor ID for which capability is defined
+ * @cap: Vendor-specific capability ID
+ *
+ * If @dev has Vendor ID @vendor, search for a VSEC capability with
+ * VSEC ID @cap. If found, return the capability offset in
+ * config space; otherwise return 0.
+ */
+u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	if (vendor != dev->vendor)
+		return 0;
+
+	while ((vsec = pci_find_next_ext_capability(dev, vsec,
+						     PCI_EXT_CAP_ID_VNDR))) {
+		if (pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER,
+					  &header) == PCIBIOS_SUCCESSFUL &&
+		    PCI_VNDR_HEADER_ID(header) == cap)
+			return vsec;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
+
 /**
  * pci_find_parent_resource - return resource region of parent bus of given
  *			      region
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6018d7eace6b67..47c53bbf3f9d8d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1101,6 +1101,7 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
+u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
 
 u64 pci_get_dsn(struct pci_dev *dev);
 
-- 
2.53.0

