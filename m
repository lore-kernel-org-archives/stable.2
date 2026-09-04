Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173594F648C
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535697; cv=none; b=mvRmhnivDpF1mjGYOfwPCdsjwKsCLZRUVX8jlBllW1YCmLMbLXrqmDwjSO78ABjIDly0CQ0fiAC/kqiHGz4p9v4ykSzZSlqA9v3xABknqeUmzlpSb6BVRqQ87PZKqo8+Pr1mf1PfmNOMv9fFFaRP9CcTupS+8cQcpqwRl+zO0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535697; c=relaxed/simple;
	bh=2t7b0xREGoc8WCvoDjAW7QWbbExp2uun5Ft5EKRTezU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIsHuyKC+D8nBIX1l1TKYQhyex7i1WBbFqG8sq/mYcW1O22/GOLVLyI2zWpHAc6SfFKQLNhxYsFBZa8lX8t+x6w4zCP1kvX90waGgPK57QxSAxm0+SG6FbT9O0kiCn5FiqYI2zVJsASfUQbq3GF9V+HuOFOuwRgrgoJAaU9bDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GArTUnsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GArTUnsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFBC1F00A3D;
	Fri,  4 Sep 2026 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535695;
	bh=GNo8IHHzvd2Hnm/zRvw9kX57UIQU3+OsRV//7rKLxi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GArTUnsdqheaf8GbS8+9SbiXTGsrLXQ43pPIdoQP+qhSq1DDqeew4RGxJ+73foc7R
	 6orVQ99kKcjkopc2iUleyZ4JZLqGQK6ffMuJWbPpvkUULB4zo4iTkr92WpU2CMkcus
	 F8w5GG4k7UgMpraVxdw7Rj/U15tVd6U4Ic5hPLYiXrTk7GNs6hr2WB4udgjn19xJJI
	 gygAw8ZMMUvpSkDMf3GqOqwndojUpC7WNlhPVoad4cJLediqUO2UAAB4KyOEt8joiI
	 hnUrWc3578quBqY49zi9GkgteTr9mXvE0t36lHLadVgd+CjizqbEUhjxl3xTBlf3jO
	 iSucc8wE40PlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Fri,  4 Sep 2026 11:28:10 -0400
Message-ID: <20260904152813.899321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090316-sincere-breeding-8254@gregkh>
References: <2026090316-sincere-breeding-8254@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Terry Bowman <terry.bowman@amd.com>

[ Upstream commit ca3d1a53e62093d17436abd447463da9c0f4e56b ]

The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
are unnecessary helper functions used only for Endpoints. Remove these
functions as they are not common for all CXL devices and do not provide
value for EP handling.

Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
to cxl_handle_cor_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20260114182055.46029-5-terry.bowman@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Stable-dep-of: 29458e62d082 ("cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/pci.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa95..c70b75a6f6fe5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,8 +650,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-				 void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+			       void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -667,11 +667,6 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	}
 }
 
-static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
-}
-
 /* CXL spec rev3.0 8.2.4.16.1 */
 static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
@@ -693,8 +688,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
+			   void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -727,11 +722,6 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
-}
-
 #ifdef CONFIG_PCIEAER_CXL
 
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -810,13 +800,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 /*
@@ -913,7 +903,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
@@ -942,7 +932,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
 	}
 
 
-- 
2.53.0

