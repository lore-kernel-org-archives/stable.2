Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218D3AFAEB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980844; cv=none; b=se+VjffxqJUc5L9ohdUf9u5oFWChvLj7ftRzIeaDnJphehEX0U8/BudN3AAwEJ+Q6aqZFTG7/0nleiAuWJYHaK1M/dhAdiuRxqgIAw/t9cMB14mzywCtmLSwWZBIBUipxNT6rhvNZeLduNWuauc9/Zy16byMB615jZsI4j0mN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980844; c=relaxed/simple;
	bh=yKa4oaAOTz+8Y6STbrkUCG/qzWupkkrH93yAu7MM/GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pV19Ww2fw1riSP/JE7YxkjyUOmEh1EURpvvIlUD6I1cyA9cIB6eiED6J8ZmrVrvzm6o3l+Q4mHN+xaz1EJDUhFN+rIDwAIVy+/pU2k+lNB9sjqQcIemkyds/OzTr1BkkfAcsq7WmYNUqvEhx+AD7xwQZEf4IXrhJXx/WV/+90AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGiWztbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGiWztbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94F01F00898;
	Wed,  9 Sep 2026 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980842;
	bh=TnD1On6shMxAGhvkD9usaj9/C1jdW05nfTr7Bge4Z2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jGiWztbVRONgNEkIFrVdZlDAl+PY1Mj/AOlGHrEsDNor04MPjtVrXtAwVCiFe5GM3
	 6ughf4uh9rs7ha4EH2GFcDZD/QYzRv5s9VpD1GR7R1C73zVHDk8cZIDR/zUfrW/qPM
	 WW1R5iYe7sQ18GxNbybag3+egcMb1vvbWRXIt1G5ZuRoYPhyoqr8rroZIz3SJdhrdy
	 vadyLHBHqW1BbX2EHogzgNQNHUUJa7I+RYxbNPnAeuiRwgshxHKUahXlMAPQWBADkk
	 GqGI8JuwfaukDR1ghSeHG6H5qniL0R0SyeZYVps5iIXbNzN8pkzx253tvVFQoYv/LN
	 OOKxaEl72KQBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] PCI/AER: Update statistics before ratelimiting
Date: Wed,  9 Sep 2026 15:07:15 -0400
Message-ID: <20260909190718.3536304-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190718.3536304-1-sashal@kernel.org>
References: <2026090327-unfair-disagree-3067@gregkh>
 <20260909190718.3536304-1-sashal@kernel.org>
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
index 94117449e300a..f5fa82575defa 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -695,7 +695,6 @@ static void __aer_print_error(struct pci_dev *dev,
 		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
-	pci_dev_aer_stats_incr(dev, info);
 }
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
@@ -704,6 +703,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int id = ((dev->bus->number << 8) | dev->devfn);
 	const char *level;
 
+	pci_dev_aer_stats_incr(dev, info);
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -783,6 +784,8 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 
+	pci_dev_aer_stats_incr(dev, &info);
+
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-- 
2.53.0

