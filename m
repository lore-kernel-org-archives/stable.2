Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14DF3AFAFA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980842; cv=none; b=XQe/4zXKc9qpmG4qWJoWjQGa0BonCPvyXdgocV/FvNxRwE7NR35ftKtqO0OnJJejSCA5oxyHTDd8LCuGhuM4leyYwoH+NnU9i5eE/ULGwwZbrl3dDHF+Jh+8juYCcyxdlLh9W03eFAd0Z8niXtSVEkM2JdyzdKLTObGEqYHgupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980842; c=relaxed/simple;
	bh=PSdgWHc3aNgfBVO7Od2dy6R3CJAHR0UCkRRXGRuwLfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7DoHT79/U7sTLR8d+SC87dWvdDR0ZBgzE/x+mEH3LAqskXIet4IC/3vYUHtcLKEEPxbnJKA2SnfeZt1FthHDQzDsMj+nhh8c8TpOdhKUq7MRNYq2TFSMBBCSDM58UCb4OH+rDZqyp2gSCZy2J4XFun1djd+CE3GRgCBJCdIfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6pATztH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6pATztH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66DB1F000FF;
	Wed,  9 Sep 2026 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980841;
	bh=8Mymiu+kudGNo4J4LdgLS6qBD8gZoQx7hw7tRRRhmcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6pATztHXHtJQa+P3x4pD7sS5WEKEeGMcKAEii5M58xZBeew01WOrPXQwnhVnwN4G
	 K+14KHWAHSDCIMGhoypHZToVxg+Pqm4WKGF+imLE1HzNKkA41SK1Do/9/t5z/T+4Px
	 l1mHS6wgP4DOq4wXDe8OTl2PvLzUMc9MW6K+QvnZMpMH+bRubg/M7U4P/1eBr8htPy
	 yB6c4y721s2avX0kprd0fKVl9Zs355R07cdaWMPnG2sHyDTyHZCPCfgAfJ6UuFeQiL
	 9cnaySjOCR+YNizJb7aeigPK0d0WbzlLa/svXH5LgwfaRsnTeWZKTQSw7XLEEMoJdU
	 8yLS26dOr2tvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] PCI/AER: Simplify pci_print_aer()
Date: Wed,  9 Sep 2026 15:07:14 -0400
Message-ID: <20260909190718.3536304-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-unfair-disagree-3067@gregkh>
References: <2026090327-unfair-disagree-3067@gregkh>
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
index 6b9a06bf8fc3f..94117449e300a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -766,7 +766,10 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
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
@@ -777,14 +780,11 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
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
@@ -798,7 +798,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 #endif
-- 
2.53.0

