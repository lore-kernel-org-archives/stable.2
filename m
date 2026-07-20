Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925D39C636
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554901; cv=none; b=WSKoY5JXxk1NO9f1VQXq9rfjaRSz6+x4PVY+E9sXK7nOjgw5oWCz5dJxvf4QMUHZC1n1QnYHtbRKewzq+gMS1Ys00kDCMCcgRtqxREXAnL6tBGYQQa/eLLU2eQsXOEiTJKZaLEzsJ3hdmGtx+t41C/aE2wLLD18pnRh2VS31kbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554901; c=relaxed/simple;
	bh=QhoDBxgHN6RKWVYsjjKCAtBNNEIB+AO5/Unp9t/fgHc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qcZbiY5aVWANEWHuqFJLpqabAe4qw8uduDgK3R51X1YaeEtoLTJQuwgszqXy3/NLogjCcZ//vtO3yI/HvlpSyZ4peo2hyw+TOD0cspaaWxnV8Hi97P67dYZb4PEJf8fh9AS633xGqL8DAN9AZTDYZTc1+twa3e7fNFDkbcWo2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iq2kgt2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iq2kgt2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061631F00A3A;
	Mon, 20 Jul 2026 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784554897;
	bh=0zdloegciNubZEHNzvacovxt0rRbXOeUU6Sm6IDaErI=;
	h=Subject:To:Cc:From:Date;
	b=iq2kgt2Sm5nOlib/cmTyCJiY0YnYzQVhOfGuqpHf/v8GMJj6Z2+Mu3rQI4w0NJNdk
	 Ya48mJyNOVwiIjanHxqKJzzaQs9gfTPsMfyFT49VhkkJVy+2aCIbCJIh19m/Fd9NKS
	 VPT3XJE/D6sJ1mB6qN7gnUlPTtgSQzRyovPq9rhQ=
Subject: FAILED: patch "[PATCH] cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size" failed to apply to 6.18-stable tree
To: terry.bowman@amd.com,alison.schofield@intel.com,benjamin.cheatham@amd.com,dave.jiang@intel.com,icheng@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 15:41:28 +0200
Message-ID: <2026072028-shaky-author-b5df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c268f949e219f9e179558e836f457f6c5fbec416
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072028-shaky-author-b5df@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c268f949e219f9e179558e836f457f6c5fbec416 Mon Sep 17 00:00:00 2001
From: Terry Bowman <terry.bowman@amd.com>
Date: Fri, 5 Jun 2026 13:06:10 -0500
Subject: [PATCH] cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size

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

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 006c6ffc2f56..99fb00949c2f 100644
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
@@ -204,12 +217,12 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
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
@@ -222,7 +235,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  */
 bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
-	u32 hl[CXL_HEADERLOG_SIZE_U32];
+	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	void __iomem *addr;
 	u32 status;
 	u32 fe;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a972e4ef1936..d37876096dd7 100644
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
index 1297594beaec..21fc89d3aeea 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -158,8 +158,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
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

