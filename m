Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2032EC0A4;
	Fri,  5 Jun 2026 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682790; cv=fail; b=tdj/dm5xBl8ZJ8L2OG4M1aJQyIIegpDs4pC/1JnhDme7m+ePY5Ws/pR7uHGxanihbfqCe4bWeWt25b9hHvi1RoImXDtrD3zAmbWxYzZM+kiHU+uUePPHYt6CyvcM3jcQ49CZunZ+vZ2MI0Zxf+XQEX+//KP/GAFtGP8BD9+3h1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682790; c=relaxed/simple;
	bh=X3VJX79DbGHnmycXugIYdNAxrPS004PeAc2rmDpyMe8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UckCmmsibWlWo3xOLbAuyU0xpGfC6tddjdaOm++Hm5gk7jzR5hkCdzttM5nn1wtB/dkshXv1Cpk6yudbFZwg5O1qNBlhyBt3tPZneRYgMn+lSzQ/h0e0RgOT6zMeJbvT4kXmt1HVFpajKNCtA6ElYfAfuYi2jfinz6lYYWLWEbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A9dmTRP2; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A9dmTRP2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2kkuvw7ASlD/k2iLGuuVliM8F5EwqkOeHIOUV0I9xsp5dTEIfUTTrhMl10cZQcEixXXLvgpRaubXgCEeVHUBhd89X9Z5m1RHWVDOZfjUa/6ykKkKTQNYyF0TUCtWdtPz1iy4VRrR0bwPhR8aWV7YJ4AhBEeXTAXja+7+Cid3Bt+1JQbTzT23hisJWXS0I3RZSPPNs01WfIit33SQP/MZIB9/SBza+FruASe17DfxPoTCUFMBdTHDEvkIGJx6fj1XWqJXwYRwjjrGgApwL4gPk1EiQtPnGZXr6caaogBCCfg0VnFQpE93it+Ysr1nj4umJRvW87Vh2nJmsiMZ/nLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UKuKg7y0mp+p8nu15Wp0l8Vrvdh/DzSwXtmbbQnlA4=;
 b=IauqkfMb8WNEGCv8hb4xNt74lNNnLayyj+ouLbJkoiQjkAGWQj1nXfA5yoGuglNAIftRSqyjTNvb9qD3hZyEwB0Ic/NkkIbIRMqKdMLov6OObbgb78WY5csIkFU/oi5hFWMFXInO+KqZCwH8EhFEeOq2y3rxV9uS+3zB+0VDAr2wvL99uBpqYLzPike0Y8FmEd2reHG31OoYIg6ZtH0Wcrk3oi+OJ/ru+noLQUW4djD2hCpBnKSfk4BzHfQbEPMQeO/oZPqRrXl3ha247g0hOQNeMcHm3EJPOm09O+HoharmUZfr9Y+UTmScpsV38BsVNZs3CNlS+sm0TgqY0wbOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UKuKg7y0mp+p8nu15Wp0l8Vrvdh/DzSwXtmbbQnlA4=;
 b=A9dmTRP257l00xo7WfuZaSh9aRSJu3cbLmNlq+l5XQwJuVFJcM5xUcqWv9C1MX7LiqJJEz48lcHb6S44Us6tnopdlAgwj8gg7DHPG2hNiLBdAhTIcJHkgQGXaFcmNaMy2kp6LQpAnOsnbP9XsnR0BVLx2gTmheIJjPcGeCljbwc=
Received: from DS1PR02CA0006.namprd02.prod.outlook.com (2603:10b6:8:452::12)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:06:19 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:452:cafe::8c) by DS1PR02CA0006.outlook.office365.com
 (2603:10b6:8:452::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 18:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 18:06:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 13:06:17 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <djb@kernel.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Li Ming <ming.li@zohomail.com>,
	Tony Luck <tony.luck@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size
Date: Fri, 5 Jun 2026 13:06:10 -0500
Message-ID: <20260605180610.2249458-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0562ef-cd41-458e-2422-08dec32d24ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|82310400026|376014|921020|6133799003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZZDv0e7vlqqulTMpopWHywUMHfAyPUX5ouZ6cvvAiJNEqUCPZQ8WpLUy4znEIfFA8y+gBe1DRdq0seOd6eG9/APKLOVYDU4574NoPZxaQVSlMlIJzXNOcmQlkvv4ugltdLt60RIG5U6IR0DDmpureMA0jlxphVRA89hYhaS7pe9m4FVvfPNF7NnOSv33xoh/9iTCqSpv6DCm/YoFgJDbKfcTSharypwO9fT6C5y1elPpvvl49T/MEilQUoQjHi4W95iSaSg2Yz/vKWDppZRqx9OYCZhq7NcDwXSwwL7pUzSoR+may0dpLUubjL7oImDC6G/eMI/zi1pl5UMYVSRVXwawL9Qxu0iOEV+kVGb81z+za3oCnuis4KSJid4ijSwaLZEJRtCXC936DzQCOxNZZrI7yFKcR04aBhT1Keo1sxVeHfZAGCqSB203VqH6VQWjrnzdCL2qin6aNG+pRul297tXzrOCTsPYuKy2Lg2LkKXsSKJBRXJayCQggbBI/Je5WLyNnnlgtlguhcLpN1k4uNFtGRvfmHWeNQsnQaqjUOfjoVX67mnYi5ZrVbyRaqK+O697FvXtqjHqssCuknn94XsEWep2fdpdiVxv6lhghNGDOA+kscFCHypiSftjyCAwVUMMaahHbz2kYtppa5R0mhBPHopZ5z4iYGxHnlry9q2ObHZJtrm+D2JLMpaTea5I9EVKHzECgJBCPpy9WLy1OlF6O/sN+aYuqUumCNhpFWCB4JfeIw/PZxqQCcqxh3BY3/v0oLKxArwgXt2erzsFww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(82310400026)(376014)(921020)(6133799003)(3023799007)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ieVxY7by9n2qlGm+wWtSSEo5kHM3Z+lWsbpplL8VG9Som2RrA+bkDYeYWRHWwY5PrFdvF25icaqlyuaahreh5ckkpm+EI8+DVwguD6SmOsV+ZRGoTx9jV0qXfKvAH1Jv6wpPmhCIoaiFM6f/1cmIFxoxCwVJKqOBxSvlUQvErKjg7f1IU9yWsai6hxs8fOKaY+cSmV3fsgihkcmVntySiLzgByCEAiA6VK7U0p0QR0+JXa/UeOPDuqPs91yk7GQPCdL8eow7hE4DLgRH7wupZMGQAPOlRe4x80PmrqswP3taU7qvHyF4SpXMAiNdCL2zSGit0bjOofyIvAd8Gi6zx61dimnTHIVIQQBBTwbVD7WIZ957Kft36vLK+n42BzVhKTDcrSrCRA/aLRjZMmarMX8M970PwEFjfVUyqJh1q1CMs8WThO98WdQz3K8Vyy/C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:06:18.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0562ef-cd41-458e-2422-08dec32d24ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482

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

Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/ras.c   | 27 ++++++++++++++++++++-------
 drivers/cxl/core/trace.h | 24 ++++++++++++++++--------
 drivers/cxl/cxl.h        | 14 ++++++++++++--
 3 files changed, 48 insertions(+), 17 deletions(-)

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
index 9b947286eb9b..906fb480dad5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -148,8 +148,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
 #define CXL_RAS_HEADER_LOG_OFFSET 0x18
 #define CXL_RAS_CAPABILITY_LENGTH 0x58
-#define CXL_HEADERLOG_SIZE SZ_512
-#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
+#define CXL_HEADERLOG_SIZE 64
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
2.34.1

