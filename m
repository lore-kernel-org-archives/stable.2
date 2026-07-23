Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC64734EF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831307; cv=none; b=LOJqDbpU+RM12eTLob24itLD4q5L3WFEf9BkfjrRgyE5uPO6UU/DQQ4Hzr5J1MXmDFdKoEBaEhG5trstKskTrm6hfwrcjoYyFGp/ZTEApQN2WwCwYSO/xSEca8aOx/1uAswxc8OSZNQkDE1U2Mona1Q3yLBdYoPWXLzzZeLHMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831307; c=relaxed/simple;
	bh=TNYf4pMtlxe2UAbBquq71nDRodHJiSDuYvQLjrJylcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7kwuzC4Ap5r27Iso6OLRS6BLccemcoW9p/fpnhvvX6v99QLJXwtRgfBLA3aT8anGA+JY+KKsWyBHL7zpXfkxP4p+OeanV51ociDWVVXsD3SyQvWfte0SrWXcD4t4Ut82Oj5JeO+4x5iJjMSnLDfFxbejJDxK962Nr6/csbpJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0bLQ8WW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0bLQ8WW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199ED1F00A3A;
	Thu, 23 Jul 2026 18:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784831291;
	bh=amLlebtNF71mkzBZjJnR2a8MThJ0SxnMh4LcR8HvbbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0bLQ8WWyA3CATZiQSsG6M1mKmw3PvRmC+QfkdaUO1R6x5nFBQGg0VN6E/G7FcTXl
	 64tiwaTRgB8T92i2asuvz4QgVCDdYEPsVDS1CK6V7mt+pqR2pjhs9dKHFZLjlgmq5e
	 pqQuOPyqohFKLhdv7OMpOcnmhU4tik+EtEERNhuzo80vmlpyTKs7en5jJPyJENzLlg
	 BXeKnthUtHUlNzudqLXvkH+SAP44Oa3UKX+a2BXc1jPi+hj1Vfzh3wyqiayieNnqJk
	 AEmykvlCuTzkefQDIgtNyE+zy9plQvNjcgiHdn/0KbeR3x6Hyb+9V/o4TI8iQz6RLH
	 iwgGcBaOcC0Gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size
Date: Thu, 23 Jul 2026 14:28:06 -0400
Message-ID: <20260723182806.3493205-4-sashal@kernel.org>
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

[ Upstream commit c268f949e219f9e179558e836f457f6c5fbec416 ]

The CXL r4.0 8.2.4.17.7 RAS Capability Structure has total length 0x58
bytes (CXL_RAS_CAPABILITY_LENGTH); the Header Log occupies the trailing
64 bytes at offset 0x18.  CXL_HEADERLOG_SIZE was defined as SZ_512,
eight times the actual on-device size.

header_log_copy() reads CXL_HEADERLOG_SIZE_U32 (128) dwords from the
RAS capability iomap, overrunning the 88-byte mapping by 448 bytes.
The cxl_aer_uncorrectable_error trace event memcpy()s CXL_HEADERLOG_SIZE
(512) bytes from its source.  For the CPER caller the source is
struct cxl_ras_capability_regs::header_log[16] (64 bytes) embedded in a
stack-local cxl_cper_prot_err_work_data, so the memcpy reads 448 bytes
of kernel stack into the trace event ring buffer where userspace can
read it via tracefs.

Set CXL_HEADERLOG_SIZE to 64 and derive CXL_HEADERLOG_SIZE_U32 from it,
bringing all iomap readers into agreement on 16 dwords.  Userspace tools
such as rasdaemon have grown a dependency on the buggy 512-byte (128 u32)
header_log layout in the cxl_aer_uncorrectable_error trace event.  Add
CXL_HEADERLOG_TRACE_SIZE_U32 = 128 and use it for the trace event
__array and its memcpy to preserve that ABI.  Both callers now pass a
zero-filled u32[CXL_HEADERLOG_TRACE_SIZE_U32] staging buffer with only
the first CXL_HEADERLOG_SIZE_U32 (16) entries populated from hardware;
the remaining 112 u32s are zero-padded, keeping the 512-byte trace ring
buffer layout intact.

[ dj: Replaced 64 with SZ_64 per RichardC ]

Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Link: https://patch.msgid.link/20260605180610.2249458-1-terry.bowman@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/ras.c   | 27 ++++++++++++++++++++-------
 drivers/cxl/core/trace.h | 24 ++++++++++++++++--------
 drivers/cxl/cxl.h        | 14 ++++++++++++--
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b933030b8e1e77..7056a79bff4d14 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -8,6 +8,10 @@
 #include <cxlpci.h>
 #include "trace.h"
 
+/* Check that UCE header definition is maintained to keep ABI intact  */
+static_assert(CXL_HEADERLOG_TRACE_SIZE_U32 == 128,
+	      "rasdaemon ABI requires exactly 128 u32s");
+
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 					      struct cxl_ras_capability_regs ras_cap)
 {
@@ -19,6 +23,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 						struct cxl_ras_capability_regs ras_cap)
 {
+	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
 	u32 fe;
 
@@ -28,8 +33,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
-					       ras_cap.header_log);
+	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
+	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe, hl);
 }
 
 static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
@@ -44,6 +49,7 @@ static void
 cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 			       struct cxl_ras_capability_regs ras_cap)
 {
+	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
 	u32 fe;
 
@@ -53,8 +59,15 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
-					  ras_cap.header_log);
+	/*
+	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
+	 * dwords.  Copy them into the front of a zero-filled
+	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
+	 * event memcpy sees a full 512-byte source and the userspace ABI
+	 * (rasdaemon) is preserved.
+	 */
+	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
+	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
 }
 
 static int match_memdev_by_parent(struct device *dev, const void *uport)
@@ -181,12 +194,12 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
 	void __iomem *addr;
 	u32 *log_addr;
-	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
+	int i;
 
 	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
 	log_addr = log;
 
-	for (i = 0; i < log_u32_size; i++) {
+	for (i = 0; i < CXL_HEADERLOG_SIZE_U32; i++) {
 		*log_addr = readl(addr);
 		log_addr++;
 		addr += sizeof(u32);
@@ -199,7 +212,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  */
 bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 {
-	u32 hl[CXL_HEADERLOG_SIZE_U32];
+	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	void __iomem *addr;
 	u32 status;
 	u32 fe;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a972e4ef193686..d37876096dd7cb 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -56,7 +56,7 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
 		__string(host, dev_name(dev->parent))
 		__field(u32, status)
 		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
 	),
 	TP_fast_assign(
 		__assign_str(device);
@@ -64,10 +64,14 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
-		 * Embed the 512B headerlog data for user app retrieval and
-		 * parsing, but no need to print this in the trace buffer.
+		 * Embed headerlog data for user app retrieval and parsing,
+		 * but no need to print in the trace buffer. Only
+		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
+		 * the remaining entries preserve the 512-byte ABI layout
+		 * rasdaemon depends on and are zero-filled by the caller.
 		 */
-		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
+		memcpy(__entry->header_log, hl,
+			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
 	),
 	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
 		  __get_str(device), __get_str(host),
@@ -85,7 +89,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
@@ -94,10 +98,14 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
-		 * Embed the 512B headerlog data for user app retrieval and
-		 * parsing, but no need to print this in the trace buffer.
+		 * Embed headerlog data for user app retrieval and parsing,
+		 * but no need to print in the trace buffer. Only
+		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
+		 * the remaining entries preserve the 512-byte ABI layout
+		 * rasdaemon depends on and are zero-filled by the caller.
 		 */
-		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
+		memcpy(__entry->header_log, hl,
+			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
 	),
 	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
 		  __get_str(memdev), __get_str(host), __entry->serial,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 05c49133e9e035..a5b00c3b044477 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -148,8 +148,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
 #define CXL_RAS_HEADER_LOG_OFFSET 0x18
 #define CXL_RAS_CAPABILITY_LENGTH 0x58
-#define CXL_HEADERLOG_SIZE SZ_512
-#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
+#define CXL_HEADERLOG_SIZE SZ_64
+#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
+
+/*
+ * The RAS UCE trace event header array was originally sized at SZ_512/sizeof(u32)
+ * = 128 u32s due to a bug. Userspace tools (rasdaemon) have grown a dependency
+ * on that 512-byte layout. Keep the trace array at 128 u32s to preserve the
+ * ABI; only CXL_HEADERLOG_SIZE_U32 (16) dwords are valid hardware data, the
+ * remainder are zero-filled.
+ */
+#define CXL_HEADERLOG_TRACE_SIZE SZ_512
+#define CXL_HEADERLOG_TRACE_SIZE_U32 (CXL_HEADERLOG_TRACE_SIZE / sizeof(u32))
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
-- 
2.53.0

