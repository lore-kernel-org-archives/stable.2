Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16952B1D2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971209; cv=none; b=TA31vIsgoreK6TaBi0y19IYMSIhmRjfC8z3ZzfU6XbgEV6iYMl5I2YW7oBWrPjcL6ygDZY+8W+HkElIgFzJJhWeVJ51egg0IH3KBkRREi8ckRkWYInIH75itEyWLlaq5dfPDyuM+AQedcQ4WFMXhKhExeUZIWPGniWNt7QN4R1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971209; c=relaxed/simple;
	bh=WBj1SpGSiKokT2TwZisfvHkSww7wPAZzhSBuDR8AGVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSrWbcOHkNU6pm7xNTzUHqVYxErQz+HLSvZ7aLshdNFfRI/TjANZqLzXZyskXBszl3BuU6jg2Kout0cAcigogF4a0YeQv6i47uINMRXSHLUuYZLFMUURs8e/exnVqpq+PHD5t37KZpiiUDxQ3FPk00Ohs+Y54haqyuWjN7HIx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVcwrCee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVcwrCee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5491F000FF;
	Wed,  9 Sep 2026 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971207;
	bh=rVZdhZHZbwX/nlTafcCfonfYFMs0mlrRBGndjLXHOeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVcwrCeejciEMYe4Pb0hfi+YNwnEb2OfxghcOqovMAIpADxGCHoG0wvJaSDrVcYEW
	 rVxCeSO17GPTr8tsNYk9uFD95+NPOwmt0SpECjRRDRNG/rZITJqn3s27eKx8wtuRtt
	 V0YU9Q56R9Zhq8ANX4K8B/6bpvKU+uCEJFwe/5YDzgsuNMGsolE13FIkVCsObyKFIp
	 IGZF3Q/S0gEPvruNDtTqS9TGAHmwwlW+ZoQDQPI9IXuuiYStC3d/E83ajG9I0l2ha4
	 Ga7hNWTVcu76xOS32hsvJ9CATfHa0/VnG297+qIf7vASEZ5jJ+xbO0jQ9i523N3qMx
	 WdL6XBzTJFyvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] PCI/AER: Simplify pci_print_aer()
Date: Wed,  9 Sep 2026 12:26:39 -0400
Message-ID: <20260909162644.2981443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-shy-dealmaker-b70c@gregkh>
References: <2026090327-shy-dealmaker-b70c@gregkh>
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
index 608908552daf3..e4be458fb9575 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -763,7 +763,10 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
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
@@ -774,14 +777,11 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
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
@@ -795,7 +795,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 #endif
-- 
2.53.0

