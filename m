Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A194F4747
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535698; cv=none; b=nAWvkOlA8BuXF/FM527gDHg12GjspkoZIcRVe5U5A43YT18DrxClZ4zumriXB7r5CBCBH38rcpZCFAuLhBMe6sF0HNh+a05HcYUGuSN3hBJAO4uO9eUFfOhY61EVCFukuX1XeUvpqNtc/sFOLegTfAAj7v4d/dKWNCKfLwSp7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535698; c=relaxed/simple;
	bh=8GI02/jYjaJVRugYXIHXVfPdSgKjv/LNcTqs6+p1Jw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URfDgapdK44nUABTHdqDQ68gRNtW5GzMIvRckHRNirMrreDrzZ7HJx+FtNs4qbKnN7m3rSvTTkvkf1JqE2Mtwe635/nn66y4wOe3k/H5Y54cw63FvmDk9ZKGWI1NC/YuaeNHI9DL6ECM70j5ZLrJ+enKA3/CcaJj1Ct0Jn/WgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfI50PHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfI50PHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACB41F00A3F;
	Fri,  4 Sep 2026 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535696;
	bh=J8b7ZlMw5/ovMffY7swUZFckyD3nKDksYxRmj1bPF0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfI50PHOd2JbcvgR3cypB8Yc9cJnqYpj3vs++Fgp42m8oeV0hAxYEzNPA9qs03UYo
	 kAE0879aojjdQByXgp6PN7GKSJOE+Vbiu/TMasgxwAwM0pf6ZmCll48GIpY4B02amG
	 blVL9NWITmsMynP+oQW6aUYStrvaoPR396Jy0Q1hVa7VUIAwxmlkSFrJuMRzCQKhie
	 q9T4BobQiwvU+4T4Yuz6lnas+iagj5eTseKkM+JAI6jWFGKaSCkl957hkmysQOSzeT
	 lM+VdFj0Ymh2ELWkyjotMJIEZu8eOhU900+MyGp0a2LNlAZjgvhUvmzLZ+WIH9iRdk
	 LhapiO62Tw6Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] cxl/pci: Remove unnecessary CXL RCH handling helper functions
Date: Fri,  4 Sep 2026 11:28:11 -0400
Message-ID: <20260904152813.899321-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904152813.899321-1-sashal@kernel.org>
References: <2026090316-sincere-breeding-8254@gregkh>
 <20260904152813.899321-1-sashal@kernel.org>
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
Stable-dep-of: 29458e62d082 ("cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/pci.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c70b75a6f6fe5..42fc18878b0d6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -797,18 +797,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
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
@@ -878,9 +866,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
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

