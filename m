Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992154EEC6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955095; cv=none; b=AS/5NQzqlRnE50Jk8ngFn7wT2w4yLfbOcOi9RktA9GpdvoFWVFC1Bf/EE5t2uZrKHfBT2Pq+Hc7ETFW7kH8y2PH0FTKA9DSWQuAxjpTD7RYFZh3osaa8CY9GjFrlz/HuDSwBhvHsGyHej433Qg+ZwtSQrIk45aXtx6b+0oEt6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955095; c=relaxed/simple;
	bh=zJT5LVg6L7cEx5IFDHrfE3sbLUzJCzHGJU4uTniRGk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVreQFVL+wPfoI4CJq+Ald0/x4oD/ToB56Lvt2/JcWqymN2wv2TSGKK56AqrBXL4cN74BC4lBOVJNEOsaBN50Cn8b8GsDBrXi5y8DtK5/Qa71nIxTAaU9WQ5gXoAI52jTU4S7XMru6RQjuifF62zUaLbB8QWtFB5EBDMUy467A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=havHFC+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="havHFC+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D501F00A3E;
	Wed,  9 Sep 2026 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955094;
	bh=vZKn8QyLpRZwQ+WSEdad/lx5R++b7Ij1fwz8G7tPc28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=havHFC+pwmOi9pgqEI5+BNZ6rXB7v2d62xTTRfny5MUgxZtiAemLLdsVrkRIT+wXS
	 kOAmI4hpFbxeBE+wzdsrzu/u4B60/+szdO1LEnEYcCSDvkgJQjGLdFh9WtfnXzdEtj
	 8xIvruMdRtDl4eqUrSK3/P0P/fZCDERFPHtCYoHrlsGXQJ5GVfya+A5cvJv7YlMf58
	 Q1mHGD56K2TdY+/Kz7xwYP2dr7MJNKAQ1yC/EvXjLwQROm8TAB4igIpUc46M2ffmY/
	 Lrzn4HTAYczsW3Na7vvk2KJvkpz4xL2jcFCRELOWgsdzlVFZlVn02wsplSqU8NkMFN
	 t8wu5PnESPZag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iommu/vt-d: Force requesting ACS when tboot is enabled
Date: Wed,  9 Sep 2026 07:58:10 -0400
Message-ID: <20260909115810.2181247-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909115810.2181247-1-sashal@kernel.org>
References: <2026090350-unpleased-sandbag-2584@gregkh>
 <20260909115810.2181247-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Tian <kevin.tian@intel.com>

[ Upstream commit 607432b2618b61df81134be0ef2562b8300c1216 ]

Currently the conditions of requesting ACS in detect_intel_iommu()
don't include tboot, leading to a possible misconfiguration with ACS
disabled (e.g. due to user opts) while iommu is later forced on by
tboot_force_iommu().

Fix it by checking tboot in detect_intel_iommu().

Fixes: 5d990b627537 ("PCI: add pci_request_acs")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/dmar.c  | 15 +++++++++++++--
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 75eb4bd5ebb74..1d330852fb0bb 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -912,6 +912,18 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 	return 0;
 }
 
+static bool dmar_required(void)
+{
+	/* tboot supersedes any user/platform opt */
+	if (!intel_iommu_tboot_noforce && tboot_enabled())
+		return true;
+
+	if (!no_iommu && (!dmar_disabled || dmar_platform_optin()))
+		return true;
+
+	return false;
+}
+
 void __init detect_intel_iommu(void)
 {
 	int ret;
@@ -925,8 +937,7 @@ void __init detect_intel_iommu(void)
 	if (!ret)
 		ret = dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
 					   &validate_drhd_cb);
-	if (!ret && !no_iommu && !iommu_detected &&
-	    (!dmar_disabled || dmar_platform_optin())) {
+	if (!ret && !iommu_detected && dmar_required()) {
 		iommu_detected = 1;
 		/* Make sure ACS will be enabled */
 		pci_request_acs();
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 01afca6e0c95b..c7f5df9efba13 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -138,7 +138,7 @@ static int rwbf_quirk;
  * (used when kernel is launched w/ TXT)
  */
 static int force_on = 0;
-static int intel_iommu_tboot_noforce;
+int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5116105671727..080cbaafec434 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -802,6 +802,7 @@ extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
+extern int intel_iommu_tboot_noforce;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
@@ -814,6 +815,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
 #define intel_iommu_sm (0)
+#define intel_iommu_tboot_noforce (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
-- 
2.53.0

