Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736A3E315F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965193; cv=none; b=cFVhudWhzJk7QmzYE9uzflxtJ/APGFb2iaRtBThU8dtXcp1+gqo++sLYu7bgj85Qz0KXsYsXMeN6J2TtWt06JvncEQ5v8njklfIA6W+KXmKN+nGHdOH9NgC1H5nY+tm3MDQbsw1+Bx3KFRrr7fTmWAkSmO6uCQKJmgM/RIOdDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965193; c=relaxed/simple;
	bh=hzzwyfl1yUEB1ilUqWoeF4bo3c+suoZMfPBMndec+SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBg1zqR+uv5oKo7kcvIpbcrAUHFZt6UqVRc9CDb83kOTUVdVtxf8FN033LKyL7/WgF2wW82rKxuQhdEAOTEJVhwpQUn1k9JuGF6NYBaPmuce1MkwusdJFd6no/DtaN3iCXk1SYCANP7+eRqbgkdF57z+9wcTmXugpejG4alaep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GurlPpXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GurlPpXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335F71F00A3D;
	Wed,  9 Sep 2026 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965191;
	bh=UDGVFj/2B7seiyy8IkwvpIKr2u32AhNe+lh0nyG72vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GurlPpXXcj4hknGd7DM2HcP8g+vSM6lhxRkySyaE0DUJgLAEr7Vxu6MuBHsu4/TzF
	 owgVS80+FaSWlhKzm3iaGKYuSfR5heYlAr5VPTwpqOlqRmTQGBHn/7atRCej2b2fy4
	 ywQmBDptHa6jemfef+BDTjmhqOMXvJjpGX/SHj074d5sv4UOpXjM9CkAsBynLLLcVb
	 A+Gfjvl89zNTRIh0Jr8igQhn18bJRuy6zBzWlq9052XlvroZrjCs2ddbhpvDu1I/jZ
	 eX/hB2VzKBwrnuLO6x9vWf0Tzcn/4AMh+C0T2rL8ybo4HgyiPzOczx9kn9CZRORmgh
	 BTyMeYvE7dQeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] iommu/vt-d: Force requesting ACS when tboot is enabled
Date: Wed,  9 Sep 2026 10:46:27 -0400
Message-ID: <20260909144628.2652039-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909144628.2652039-1-sashal@kernel.org>
References: <2026090351-finlike-grumbling-0d17@gregkh>
 <20260909144628.2652039-1-sashal@kernel.org>
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
index 8e9b5a0b6202e..ab7c03ce5166d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -907,6 +907,18 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
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
@@ -920,8 +932,7 @@ void __init detect_intel_iommu(void)
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
index b9a01ef44e0a3..045b47cd7a972 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -179,7 +179,7 @@ static int rwbf_quirk;
  * (used when kernel is launched w/ TXT)
  */
 static int force_on = 0;
-static int intel_iommu_tboot_noforce;
+int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a5efdb0c6657c..6db0b8b1e33c2 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -803,6 +803,7 @@ extern int intel_iommu_gfx_mapped;
 
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
+extern int intel_iommu_tboot_noforce;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
@@ -815,6 +816,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
 #define intel_iommu_sm (0)
+#define intel_iommu_tboot_noforce (0)
 #endif
 
 #endif
-- 
2.53.0

