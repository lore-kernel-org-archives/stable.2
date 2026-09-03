Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08394C77A8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447925; cv=none; b=Cpj1W4vz3F2xY9afXyjkA7o//p/ODLZ1Pat3MVgAwdyXrKVZBSACotWM2zVjbrdxmVWhl3BfmyWU2muwCK9dX3vt4Oq7KEwBN92B6hoff/WwR4J7Xs063w3nMiXdBpG282d60CAQXzlomwe+72Von032HAQ5qFJVlfRwVqA0UVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447925; c=relaxed/simple;
	bh=dQp7R8o5jxqDGQ0v9TqXmmdgmF4/QK4W4eC8EJTOTio=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PYQA8q+VTz8RrND1XHrSmjm95agh4NdQTeMX3+kH9JoE/raKGJDHC6MKHjvkoEYLZrFM789QsfuG2tSVf5BA2oYLm402zo8fs9ThH3hewRKle5l+OKTbpq+EKJb/Z9X83nJln84Tg/wtehcJbELdw+KP2OSAuIK7A6xks3KsK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=12mPrfRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="12mPrfRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567051F000E9;
	Thu,  3 Sep 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447923;
	bh=16ecxQvcPzeTs+7XhKIQ8mcS3f+t+Lymr7wkoFjhUmU=;
	h=Subject:To:Cc:From:Date;
	b=12mPrfRxW7AlWBmodrY45otzjR8Q0A/lziIocXp85msU+cywGHHOYLQr713VCpMgL
	 blQpAJB3QyW4a9nUIMFo/SRtqcE5rokiNe9ZUb2UgRF9RPKyEzKxpyL2GaBoFCIEcq
	 xNxJdMlGSatL3u4EWyXcPxSgkFXhNmKEo6SLn+0E=
Subject: FAILED: patch "[PATCH] iommu/vt-d: Force requesting ACS when tboot is enabled" failed to apply to 5.10-stable tree
To: kevin.tian@intel.com,baolu.lu@linux.intel.com,joerg.roedel@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:45:51 +0200
Message-ID: <2026090351-finlike-grumbling-0d17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 607432b2618b61df81134be0ef2562b8300c1216
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090351-finlike-grumbling-0d17@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 607432b2618b61df81134be0ef2562b8300c1216 Mon Sep 17 00:00:00 2001
From: Kevin Tian <kevin.tian@intel.com>
Date: Wed, 5 Aug 2026 07:43:00 +0800
Subject: [PATCH] iommu/vt-d: Force requesting ACS when tboot is enabled

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

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 767ec092accd..e32685402f74 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -915,6 +915,18 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
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
@@ -928,8 +940,7 @@ void __init detect_intel_iommu(void)
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
index 1a1f27a51063..4d03d9a517de 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -57,7 +57,7 @@ static int rwbf_quirk;
  * (used when kernel is launched w/ TXT)
  */
 static int force_on = 0;
-static int intel_iommu_tboot_noforce;
+int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 775f1c4ae346..2cee36138d6e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1354,6 +1354,7 @@ static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
 
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
+extern int intel_iommu_tboot_noforce;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
@@ -1366,6 +1367,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
 #define intel_iommu_sm (0)
+#define intel_iommu_tboot_noforce (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,

