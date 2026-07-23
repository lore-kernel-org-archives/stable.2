Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616C476078
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831304; cv=none; b=tam1xHT+i9QEL7ckih/fjHJ2jd+kW2foWRsNqxasv9lZ0o7dLRGxFnj1iaYN9y0SgjRxTOS9FCYt/E+bMcvbU4krLYTRjI+raNsqoRSDgkvmixVpSFcHd8uNv/3s8Q9vbKJcuv2NJUrOjvecIwzZzTzi/kbQ4nMHoAkT+/pTyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831304; c=relaxed/simple;
	bh=HqdwGbXU+HeYdA4Q5p3Ws5nk0VB+gySDoBnHKESVONM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM/kOd2kKHGTSHxNf3YHrCbnLjCQfs91HAsLQrQi2aC52x/KBEpxpPF3IwCmb2GZAI7Av4YCIwfkSBRpwa9DoE0UZHolBsK6A6i9RAqYOJvpsSczFZvo6MNjO8I7VKJwd5qlUSi7sOJCr/hPb4aS2rOYn/tjyWxO2BHZmMmutts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myuO3Ue7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myuO3Ue7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EF91F00A3D;
	Thu, 23 Jul 2026 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784831289;
	bh=be3afmclR8VWZRuVeJ4nJN3zBU2NrHh5+J1EyfHAt2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=myuO3Ue78bB7byvueCH7xJbpSsjwLjWJ/aWirwIs7sK1vBbbLcRijMJfkUChUuU0n
	 qUFI7Fom9uBdzfRa68aAhU8WyPERwyNpqS1m/+z9euvgj+AmOuP+STjLe/1s8BhCNP
	 tHCBQ+O7j8Pg72OWcWnM3as94nPpxa1OuUKCE8J7B0VxbaPuyHX+s3dFKu9lCPr4QB
	 SXOj7i8CgzqSu0OWW5GWnF0N3IWOvsfEhgPOTq8G4yDufeDYdDLMyUQ4noPhlnMs/H
	 AfbASZ2vGQvx8X8NV2qGUXuFWEqVz7JFQdof83DLQZAxWydC2rjiq7+7B4e7ThKtUA
	 socWklgKKOkRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] cxl/pci: Remove unnecessary CXL RCH handling helper functions
Date: Thu, 23 Jul 2026 14:28:04 -0400
Message-ID: <20260723182806.3493205-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723182806.3493205-1-sashal@kernel.org>
References: <2026072028-shaky-author-b5df@gregkh>
 <20260723182806.3493205-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Terry Bowman <terry.bowman@amd.com>

[ Upstream commit eb78ef4d6f0e51243c1ee117f801dbc503e886ab ]

cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
to Restricted CXL Host (RCH) handling. Improve readability and
maintainability by replacing these and instead using the common
cxl_handle_cor_ras() and cxl_handle_ras() functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20260114182055.46029-6-terry.bowman@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Stable-dep-of: c268f949e219 ("cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/pci.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 078e9e5651e1bc..3fb9462954da20 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -858,18 +858,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
-					  struct cxl_dport *dport)
-{
-	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
-}
-
-static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
-				       struct cxl_dport *dport)
-{
-	return cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
@@ -939,9 +927,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	pci_print_aer(pdev, severity, &aer_regs);
 
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_rdport_cor_ras(cxlds, dport);
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
 	else
-		cxl_handle_rdport_ras(cxlds, dport);
+		cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 #else
-- 
2.53.0

