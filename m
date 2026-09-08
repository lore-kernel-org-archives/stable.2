Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB829E0E5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830475; cv=none; b=Z7/eJGNNNX0NSwXZCqqPCPU9v0xn+24YLggeosctV2k1tzSumnGxIS4EQavTCs1zM52Zs/htN/PCRbY/2mJQ5pPHBL2TTEGkpd/+Qyy+JZVYadx1WoHjfVe4m2EekCS04SF1iuDu4uf4kpu9wAqt7tHx0YuEACGs23tPZIZAxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830475; c=relaxed/simple;
	bh=eXqAEl+m6Iy+9yBmzpgk1iy0CXWx+yKPJ3eTGlapfew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Boc+3rvPBzTz+zcA5YdvV2jTBwfXl/GrGUnGKJVbdwOANZg0lzTyEkCRPs5LQ7j5tTtljPN5/VM7xDREXWo4ottQBX0rx1SyY3s7ZGYQMuwHb9OcukWEiDdxibUQyAIno5TUZwIIcJNcMueYDPtO4B7uI4P/b3TFpiQGJuHv6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLxJ9Zot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLxJ9Zot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7CA1F00A3A;
	Tue,  8 Sep 2026 01:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830470;
	bh=ET21oGxpO6madyONlKKIO+qwHiTEbhyAx0RZYyDOjic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WLxJ9Zotd2Rd2ThPnvmSJH0uiYimJmD9M3r7qFX8XksBYkH8ebJP1NicgILWNqN2N
	 gjMI4Lhq4R/2QluKf6axi8MM73RfoZdqUJ2BCZRTLokY8ZMWc0LWRCDY7FxGo1fAZR
	 uq5hDPW+u/DzKhTkMTSyf7Shz468YAmxHfVL46cFpaaILTjbFxVnEW/8fqHuIGX2o+
	 qSBfgLZbhopk6bQDB6osagh8a+wfpKk5f12C4mTaYnrIUNsQTEHqFoQlqvij5VFFtJ
	 bvPR5kWjAKXOKVMrUYUT94OttbntHg4DAoBy5PH5Oh5HC+CGAOKnR8bzB+k+RUmy2q
	 AOqHg4qGmKjWw==
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
Subject: [PATCH 6.12.y 1/3] efi/cper, cxl: Prefix protocol error struct and function names with cxl_
Date: Mon,  7 Sep 2026 21:21:05 -0400
Message-ID: <20260908012108.1757370-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090335-waking-roundworm-32ca@gregkh>
References: <2026090335-waking-roundworm-32ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[ Upstream commit 84973331442a57bac31b40eaef6f264496c6f3fd ]

Rename the protocol error struct from struct cper_sec_prot_err to
struct cxl_cper_sec_prot_err and cper_print_prot_err() to
cxl_cper_print_prot_err() to maintain naming consistency. No
functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20250123084421.127697-2-Smita.KoralahalliChannabasappa@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Stable-dep-of: 6625ca499c31 ("acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/cper.c     | 4 ++--
 drivers/firmware/efi/cper_cxl.c | 3 ++-
 drivers/firmware/efi/cper_cxl.h | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 3587295cd0206..e0adbd6df9b53 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -690,11 +690,11 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+		struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
 
 		printk("%ssection_type: CXL Protocol Error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*prot_err))
-			cper_print_prot_err(newpfx, prot_err);
+			cxl_cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
 	} else {
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index a55771b99a97a..cbaabcb7382d9 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -55,7 +55,8 @@ enum {
 	USP,	/* CXL Upstream Switch Port */
 };
 
-void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
+void cxl_cper_print_prot_err(const char *pfx,
+			     const struct cxl_cper_sec_prot_err *prot_err)
 {
 	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
 		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909eca..0e3ab0ba17c36 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -18,7 +18,7 @@
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
-struct cper_sec_prot_err {
+struct cxl_cper_sec_prot_err {
 	u64 valid_bits;
 	u8 agent_type;
 	u8 reserved[7];
@@ -61,6 +61,7 @@ struct cper_sec_prot_err {
 
 #pragma pack()
 
-void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+void cxl_cper_print_prot_err(const char *pfx,
+			     const struct cxl_cper_sec_prot_err *prot_err);
 
 #endif //__CPER_CXL_
-- 
2.53.0

