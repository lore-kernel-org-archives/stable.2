Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418852E06E6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830476; cv=none; b=ujAF9QxiTT1LZH0SiV6mtfxZoCUDMfNaOjDPmtTgIJU8e+vjzh67acBJsBsa6165pF2NeLlRefH/kYaohznNjXfT5G68tYHd5CniXEp20qymsVc0AF920RrApimcVZjdKSWFaBxSexX4YDjyOvjhHRkmsSq3O0EzoaFbEuBZZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830476; c=relaxed/simple;
	bh=2VyPGeXF98UDjfKQTxe5UtkUGwLSsB49K/NWgsOrGuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A71ZHvhznSc1T8E5UX09w0MyC1LeRlbsgUEOA5Pm/SUGt2w9tH7U5fQH4YGZCum3nTW9gDvIaxhWKaxAvBEO0+cglxZE1b53uI1xQRomQB6vYY6m/hz2le1Tdu1cTFETzWVaPwzUoewTWAOHOfHw07heKNAtNOPgXZV0PC9QOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkKhLtX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkKhLtX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D351F00A3D;
	Tue,  8 Sep 2026 01:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830471;
	bh=2AhS99EUu26sgqqT2xhMSE5oaORffqkOS7ISuu4sfjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkKhLtX7lM5jZNvF1ODKmbDPOR/IUzv6jL3+lXEhSd+M+ol83iqEtFydQ2nojTkXC
	 VNuNIK1G2ZTOm4TdVggyd2X4qfN+/cb4TWxRgPeD8F1Ku1ROmP09xxhcqs4B0uUSWo
	 oVpgYgPPJ5XQwSkhQyMdxc14dbu5MqjldKD0LKLofZhnArsvdn3abLtYBclNGLeDAE
	 lqL0rib8omz1X8Wv2nJIM0JRDItnCeoJOpIn2n48mXMLOh8TgW1vwqZjKjuXhTnrOd
	 nDtDS7YTjjrnU2+giYiujc4wDaqUkzxHC4UefU6i0+MUwMi6nIYQy6bwa2GnoUHJtT
	 4MXmU4NIe1uyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Gregory Price <gourry@gourry.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] efi/cper, cxl: Make definitions and structures global
Date: Mon,  7 Sep 2026 21:21:06 -0400
Message-ID: <20260908012108.1757370-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908012108.1757370-1-sashal@kernel.org>
References: <2026090335-waking-roundworm-32ca@gregkh>
 <20260908012108.1757370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[ Upstream commit 958c3a6706863f9f77b21c90d2428473441cd8a1 ]

In preparation to add tracepoint support, move protocol error UUID
definition to a common location, Also, make struct CXL RAS capability,
cxl_cper_sec_prot_err and CPER validation flags global for use across
different modules.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Stable-dep-of: 6625ca499c31 ("acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/cper.c     |  1 +
 drivers/firmware/efi/cper_cxl.c | 35 +--------------
 drivers/firmware/efi/cper_cxl.h | 51 ---------------------
 include/cxl/event.h             | 80 +++++++++++++++++++++++++++++++++
 include/linux/cper.h            |  4 ++
 5 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e0adbd6df9b53..7fe10a06e68c3 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -25,6 +25,7 @@
 #include <linux/bcd.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
+#include <cxl/event.h>
 #include "cper_cxl.h"
 
 /*
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index cbaabcb7382d9..64c0dd27be6ed 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,27 +8,9 @@
  */
 
 #include <linux/cper.h>
+#include <cxl/event.h>
 #include "cper_cxl.h"
 
-#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
-#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
-#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
-#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
-#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
-#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
-#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
-
-/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
-struct cxl_ras_capability_regs {
-	u32 uncor_status;
-	u32 uncor_mask;
-	u32 uncor_severity;
-	u32 cor_status;
-	u32 cor_mask;
-	u32 cap_control;
-	u32 header_log[16];
-};
-
 static const char * const prot_err_agent_type_strs[] = {
 	"Restricted CXL Device",
 	"Restricted CXL Host Downstream Port",
@@ -40,21 +22,6 @@ static const char * const prot_err_agent_type_strs[] = {
 	"CXL Upstream Switch Port",
 };
 
-/*
- * The layout of the enumeration and the values matches CXL Agent Type
- * field in the UEFI 2.10 Section N.2.13,
- */
-enum {
-	RCD,	/* Restricted CXL Device */
-	RCH_DP,	/* Restricted CXL Host Downstream Port */
-	DEVICE,	/* CXL Device */
-	LD,	/* CXL Logical Device */
-	FMLD,	/* CXL Fabric Manager managed Logical Device */
-	RP,	/* CXL Root Port */
-	DSP,	/* CXL Downstream Switch Port */
-	USP,	/* CXL Upstream Switch Port */
-};
-
 void cxl_cper_print_prot_err(const char *pfx,
 			     const struct cxl_cper_sec_prot_err *prot_err)
 {
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 0e3ab0ba17c36..5ce1401ee17af 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -10,57 +10,6 @@
 #ifndef LINUX_CPER_CXL_H
 #define LINUX_CPER_CXL_H
 
-/* CXL Protocol Error Section */
-#define CPER_SEC_CXL_PROT_ERR						\
-	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
-		  0x4B, 0x77, 0x10, 0x48)
-
-#pragma pack(1)
-
-/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
-struct cxl_cper_sec_prot_err {
-	u64 valid_bits;
-	u8 agent_type;
-	u8 reserved[7];
-
-	/*
-	 * Except for RCH Downstream Port, all the remaining CXL Agent
-	 * types are uniquely identified by the PCIe compatible SBDF number.
-	 */
-	union {
-		u64 rcrb_base_addr;
-		struct {
-			u8 function;
-			u8 device;
-			u8 bus;
-			u16 segment;
-			u8 reserved_1[3];
-		};
-	} agent_addr;
-
-	struct {
-		u16 vendor_id;
-		u16 device_id;
-		u16 subsystem_vendor_id;
-		u16 subsystem_id;
-		u8 class_code[2];
-		u16 slot;
-		u8 reserved_1[4];
-	} device_id;
-
-	struct {
-		u32 lower_dw;
-		u32 upper_dw;
-	} dev_serial_num;
-
-	u8 capability[60];
-	u16 dvsec_len;
-	u16 err_len;
-	u8 reserved_2[4];
-};
-
-#pragma pack()
-
 void cxl_cper_print_prot_err(const char *pfx,
 			     const struct cxl_cper_sec_prot_err *prot_err);
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 0bea1afbd747c..66d85fc87701d 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -152,6 +152,86 @@ struct cxl_cper_work_data {
 	struct cxl_cper_event_rec rec;
 };
 
+#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
+#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
+#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
+#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
+#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
+#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
+#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
+
+/*
+ * The layout of the enumeration and the values matches CXL Agent Type
+ * field in the UEFI 2.10 Section N.2.13,
+ */
+enum {
+	RCD,	/* Restricted CXL Device */
+	RCH_DP,	/* Restricted CXL Host Downstream Port */
+	DEVICE,	/* CXL Device */
+	LD,	/* CXL Logical Device */
+	FMLD,	/* CXL Fabric Manager managed Logical Device */
+	RP,	/* CXL Root Port */
+	DSP,	/* CXL Downstream Switch Port */
+	USP,	/* CXL Upstream Switch Port */
+};
+
+#pragma pack(1)
+
+/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
+struct cxl_cper_sec_prot_err {
+	u64 valid_bits;
+	u8 agent_type;
+	u8 reserved[7];
+
+	/*
+	 * Except for RCH Downstream Port, all the remaining CXL Agent
+	 * types are uniquely identified by the PCIe compatible SBDF number.
+	 */
+	union {
+		u64 rcrb_base_addr;
+		struct {
+			u8 function;
+			u8 device;
+			u8 bus;
+			u16 segment;
+			u8 reserved_1[3];
+		};
+	} agent_addr;
+
+	struct {
+		u16 vendor_id;
+		u16 device_id;
+		u16 subsystem_vendor_id;
+		u16 subsystem_id;
+		u8 class_code[2];
+		u16 slot;
+		u8 reserved_1[4];
+	} device_id;
+
+	struct {
+		u32 lower_dw;
+		u32 upper_dw;
+	} dev_serial_num;
+
+	u8 capability[60];
+	u16 dvsec_len;
+	u16 err_len;
+	u8 reserved_2[4];
+};
+
+#pragma pack()
+
+/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
+struct cxl_ras_capability_regs {
+	u32 uncor_status;
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_status;
+	u32 cor_mask;
+	u32 cap_control;
+	u32 header_log[16];
+};
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 951291fa50d4f..e9c0331fe204a 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -89,6 +89,10 @@ enum {
 #define CPER_NOTIFY_DMAR						\
 	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
 		  0x72, 0x2D, 0xEB, 0x41)
+/* CXL Protocol Error Section */
+#define CPER_SEC_CXL_PROT_ERR						\
+	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
+		  0x4B, 0x77, 0x10, 0x48)
 
 /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
 /*
-- 
2.53.0

