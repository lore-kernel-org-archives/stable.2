Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29725476DE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971209; cv=none; b=jvZ6AtNQdTW7lxFU3kXSj28LJUSJWFCXSHAwhvbhC7nWjFVDLvOzEv7DaffDzp1cwlhFtgf7J44nxvAMVJwoiu6o8HGfGTSLhAEtSqXxiWaLLePyKle06jsO3xG7LLcM0Rqz+lCzcs/jaPIXr/Z0Dpj4wjiAoq5NDXGIeqj4eyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971209; c=relaxed/simple;
	bh=jTP/nfji0yziqab26h/kkz6sTSBChohDdCUOEZnNc4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPhF4v95diTcrl8IWLbZTV7BXbwRNX40gtJIGLDq7CNdrQwHNgWIEe94dILA71NTd9YSKRVyH5y24Dykafh+REk3i7nkXn/rqVd9C7cI9wtXBIfaBM2GsnNhL3Szx5GtUdIbPcxos5YnIrwMlnEhk27DEn1Pu9BG+4nvLoYwuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOXtGqIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOXtGqIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF701F00898;
	Wed,  9 Sep 2026 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971208;
	bh=ftqik1OViyiimdN0sUau9QuIOA7Yq+hJzwS4KP1l+n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOXtGqILDjYoacdJjoU7/DHXHtdwyOUoaQ+yRDXh+U19+EOx5pMC/Y+kxe9KTRrM7
	 hsCCF0buiR3DPndFH6Up4u9ttUwFEmmhE04EL2lYhrTjXtdiuoVM9TZG9MJu14yAKb
	 rc4YVC0v3oTQTMY8+W3nHaalE3fnr4C1ArbLxeL5mt38d5fW2diGx5V0jcGVCWTi9k
	 RiNVYm3QFhy4WMuo3IXqqYxv55Ror7EL2WMADZKqN6vjzoxe98yev1VagaFSpJPCYm
	 CwpZyQ7+7wJTxXF2U4sWjJciage7Q+i4kYNnRyyod3xs/8+BBPrzSDeKk+j3QBRzCD
	 CFKhs2Dn6DDhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] PCI/AER: Update statistics before ratelimiting
Date: Wed,  9 Sep 2026 12:26:40 -0400
Message-ID: <20260909162644.2981443-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162644.2981443-1-sashal@kernel.org>
References: <2026090327-shy-dealmaker-b70c@gregkh>
 <20260909162644.2981443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 88a7765e62b9e4c79c7ca2c7b749ae04f54a5668 ]

There are two AER logging entry points:

  - aer_print_error() is used by DPC (dpc_process_error()) and native AER
    handling (aer_process_err_devices()).

  - pci_print_aer() is used by GHES (aer_recover_work_func()) and CXL
    (cxl_handle_rdport_errors())

Both use __aer_print_error() to print the AER error bits.  Previously
__aer_print_error() also incremented the AER statistics via
pci_dev_aer_stats_incr().

Call pci_dev_aer_stats_incr() early in the entry points instead of in
__aer_print_error() so we update the statistics even if the actual printing
of error bits is rate limited by a future change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250522232339.1525671-11-helgaas@kernel.org
Stable-dep-of: a8bf2dd750de ("PCI/AER: Emit TLP Log only for unmasked errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e4be458fb9575..b9d9339bc0fdd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -692,7 +692,6 @@ static void __aer_print_error(struct pci_dev *dev,
 		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
-	pci_dev_aer_stats_incr(dev, info);
 }
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
@@ -701,6 +700,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int id = pci_dev_id(dev);
 	const char *level;
 
+	pci_dev_aer_stats_incr(dev, info);
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -780,6 +781,8 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 
+	pci_dev_aer_stats_incr(dev, &info);
+
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-- 
2.53.0

