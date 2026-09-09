Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95C57C72A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963043; cv=none; b=bxmK0y9CoWMW6OoU/mefQvq5O42x2/xKmi3TOvIVfA1ESEtW+d6lOv/WDTN2uTitI8wqrcML2uWzikoGWy0t2Q0ERclH6zkehmp8GrwwexXc8XNjPjFLBAx2xlEMZzRUn4dwZNpZaeYmR7gZlym91elH8skFfCqL/qL11aaIqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963043; c=relaxed/simple;
	bh=6RUNm85Q1EFgpwmx4DoEgDCy7H8a9aB+qtH1DIBgcgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAOlU9Hd/KpC8UnOWc4vQ9YZJHp0F6BpQtSFMbIs3FqmT5z2aW4dsA3hZAVWEdelGIyqI6tuhSq3zvzuDjsR7+y3t8FoneUgXi4Kr/6mxDCaSS3FWsrT5k1JKlH+q8oYcZB3w/4eqofyzudcmQ7P86IBuuWMb6RMuQqQIManxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1QWRuJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1QWRuJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC7B1F00A3F;
	Wed,  9 Sep 2026 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963041;
	bh=JMDLPRdVuB8z4kUbOQAQpmcmbAoNYAvGHoHQzU6DV7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1QWRuJSBmmVQWUYEuMZfGNY0EQ7orrphS/ZH/i1DE7pXomFEmUgszmCsfjN1kfXn
	 OM0V45uDN2XxnVC5gWDrVEFvXhZe40uPM78jdi4uHssqOCrwhd4XRxt/00DzTiZY7i
	 tcl1D6hE6y+t1L9URq6YNDWE0pjLXZ+o7yahlBDpoOmfjS6FGh5mUZbfIqjhMbEx9o
	 ohdRIE4FSnghLnHlWUG2gbkof+9UB2WXQhDkeX4PczOD2Tzecs3neKYFmwFPZWrNdr
	 gUxwKvJUJwCLF97+IPuV7Q6CqecQSJ7SA/YILuoRid8pPS6ZOKLOhnoON18ELbDMPy
	 X3SIq+6tn9PrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] iommu/vt-d: Force requesting ACS when tboot is enabled
Date: Wed,  9 Sep 2026 10:10:33 -0400
Message-ID: <20260909141035.2381120-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141035.2381120-1-sashal@kernel.org>
References: <2026090351-clapper-monorail-cc3a@gregkh>
 <20260909141035.2381120-1-sashal@kernel.org>
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
index 37fc660634081..7a580155389ce 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -913,6 +913,18 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
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
@@ -926,8 +938,7 @@ void __init detect_intel_iommu(void)
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
index 86e23fe27c896..3ce3ed37b152e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -162,7 +162,7 @@ static int rwbf_quirk;
  * (used when kernel is launched w/ TXT)
  */
 static int force_on = 0;
-static int intel_iommu_tboot_noforce;
+int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3c8bfc2cfccb8..861babac03689 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -817,6 +817,7 @@ extern int intel_iommu_sm;
 
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
+extern int intel_iommu_tboot_noforce;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
@@ -829,6 +830,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
 #define intel_iommu_sm (0)
+#define intel_iommu_tboot_noforce (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
-- 
2.53.0

