Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B09384238
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980493; cv=none; b=fTy++sRRDupfjQYMjFJ841UR1NHUb+2hqkigJM9UZma4AligPsYdxUL8wx/YmBasgw61F5RE9vnrs+PBwkqgpYetld03PR1MUwN22/YcnxPIdhG5oD3cZ1hweHHtSBI3PXJDTUyG4o1o+kpOaHwMtnl++Co7tLZIsUYD+aKStjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980493; c=relaxed/simple;
	bh=jwSns5ye9tMONgPE/Nl3TPg4rUCvMhLWzAsm3GGcD9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2dQg89ddTupIH0cM5mGfTPPjCo4If9AJ1Awriv3Z3cJWd57KSb1+BIyUOGTJguWiaewmZ7X2tokgSxfogGWPiDzHF8wASlyBlj+CthweLlKayONoPjp8/R2GRWf95k2WwXK6jIRte7gZIftT9G6cG2MLEzX2HsV0j29BRl+6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz6370md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz6370md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDEA1F000FF;
	Wed,  9 Sep 2026 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980492;
	bh=RgDjPhWLbQaNdpUerzZItFBpS+2frRaItPQSbiOGRog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zz6370mdXz6J+JTEmwcWoYMVq8cej182pZVVrtIwYcVL/ahn5xYSzXCyJ4gWUCOka
	 9pd5Wyt4zvu4PNmOW1HW/SKJTDe5Yyz31qjlvpR/lng6L9UszzwRuvSPcU0W7hpz0L
	 SjIgpBMhEfkidCCN28V6kvPjOOwewhvk3f67gCSiXsF+3lu7dOfVMqQCFxdVIOMO00
	 sl/B2VkbW42Bin32uXOsFFUosm0t7nWXN8ZQ4jSCoTTyRM8orLljJ1GhwrhS/Um6Kb
	 ldT6pzAh+tjoJKy3UR4NirfoA/mf5Dxz044Bzq98tDVi0tqEQgoTRNsIiwujEcQhRN
	 ZSJtM/DZLucmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] PCI/AER: Simplify pci_print_aer()
Date: Wed,  9 Sep 2026 15:01:25 -0400
Message-ID: <20260909190129.3511451-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-figurine-worst-aeee@gregkh>
References: <2026090327-figurine-worst-aeee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit ad9839137cf9fb0f0c2d531bd04bc4382e6f2de9 ]

Simplify pci_print_aer() by initializing the struct aer_err_info "info"
with a designated initializer list (it was previously initialized with
memset()) and using pci_name().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://patch.msgid.link/20250522232339.1525671-10-helgaas@kernel.org
Stable-dep-of: a8bf2dd750de ("PCI/AER: Emit TLP Log only for unmasked errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 37832d4168cfb..3ab7d97fc8966 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -771,7 +771,10 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
-	struct aer_err_info info;
+	struct aer_err_info info = {
+		.severity = aer_severity,
+		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
+	};
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
@@ -782,14 +785,11 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
 	}
 
-	layer = AER_GET_LAYER_ERROR(aer_severity, status);
-	agent = AER_GET_AGENT(aer_severity, status);
-
-	memset(&info, 0, sizeof(info));
-	info.severity = aer_severity;
 	info.status = status;
 	info.mask = mask;
-	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+
+	layer = AER_GET_LAYER_ERROR(aer_severity, status);
+	agent = AER_GET_AGENT(aer_severity, status);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
@@ -803,7 +803,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 #endif
-- 
2.53.0

