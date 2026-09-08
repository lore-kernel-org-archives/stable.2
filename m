Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478F344D95
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883292; cv=none; b=VzqVAZ+DAviV4SAILV/42E4mLinFqlmjsrXhYO42jWpkm0+Wu0PPV+1qIRKYkK7KO2PnVkFGmEg6DbqvkFlzlpU1XDGxi/3gCG3Xm+jaZfRIUwXZOJOSXJI2d6ll0hw73wlEPT+eEFaYDFw715Ua0HFVzxq+lJnZyRmG3nVS6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883292; c=relaxed/simple;
	bh=iadbJ2iJ52Q9ksd73NQ5oPFUmfraZBylhjy8hUmyq6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUnuprkgxVSaVh731f0Pf+PEPouLpZa1Js+s057xmVvFwtgDYHCE9IwQgMDsIybhPj+fKJ1IqATfm1CtBWyTTgtdokFVAm/6wTnh8nVbrb4eY6mErg1SYEUU06lKcLBPyOIo8Hz6HBexepbW7xAS86Z1gYHyT8/wIaQnkzA/nIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMuWzlol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMuWzlol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7891F00A3D;
	Tue,  8 Sep 2026 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883290;
	bh=afiyqU0LRhmFdS0h7UarsW3pGdXcRJ4oI9MzFf/+d+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jMuWzlolnnywGZEdcLt8QHfzESZV4MAgY1FyOT6Nkxq81h/mNhp6NOzdztYG+yJQz
	 z4IadtR+3j3+R4W5Od+P57I6yU6sxvyPThdFheQR186f6y8Kxb6e6P2BcSgPLMphWJ
	 ljRg8McxwcHILDCT+RLGKyyDDUeFDqgoI2a2MQzuYtv+LCUmKQwQWHXbu9xWV9bFeI
	 OxcO4ERC5179nHsgyHh39pNMOXe0NMJyN6bHam91HMu2sRw0XSux58hpTkycka4VxN
	 jkDbXFyverw0nmfMoSCw+oYwtT0RJvtOwtX7BgtrpNR3t+d+mirWePVagt4uhAfFOy
	 KQJtE8lVFEd4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] cxl/pci: Remove unnecessary CXL RCH handling helper functions
Date: Tue,  8 Sep 2026 12:01:25 -0400
Message-ID: <20260908160127.2548313-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160127.2548313-1-sashal@kernel.org>
References: <2026090317-roundish-company-df16@gregkh>
 <20260908160127.2548313-1-sashal@kernel.org>
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
Stable-dep-of: 9d399526128b ("cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register")
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

