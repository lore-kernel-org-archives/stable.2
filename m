Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958FF4AE122
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579625; cv=none; b=RN+QzGTUbqPtehWlWbwWPoQx0kYWq0vEC2p9z4mt/OzY7x2y4TEBX7vPsAIxhSNDgFecIXrDr+jU7sRD7JeSxU79Mxame1bsXN3PMHzvFS1D/Y2bH62v/w2QQaYRiVF7zFttcCknyQ1iR5Gf1auk6UYeCrrGCqIlgop/hx4QOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579625; c=relaxed/simple;
	bh=tYXK1eNoSwAdFPyV5XYwjd8ydlRKBTGDqRsDjO1OLCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML8xPKgT5k8CyYrue7PN2W+jBOcO87muIzSCIqCCxb1QArgDGVlG7QvJ8aVSrzyEb0ahxfmOb+hYO2IXlAnkH3stni1ah1HmzGROMgDKeXiG6S91b6Wd5Gxgl2FRMBXbdxnX1n0IfKsEOXDpCue4gMfu8wQrC+sJB7ju54OU724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkFp0pIR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkFp0pIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789579623; x=1821115623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tYXK1eNoSwAdFPyV5XYwjd8ydlRKBTGDqRsDjO1OLCc=;
  b=HkFp0pIRqyuxQyFDgeCfCmLHi18UMqGhOipEHGA62cl/AQb5qGZpDay6
   AznpDJs5Qfof8xmF1O4IBs7OTyAANul/lE2hkBHmoYlq1mvmAAtlPc5fZ
   Gx7fj2D3dmM+7RjO1BudZriw+Gx5jenHTHNxS87AAF//BQrDs8jea+/9i
   MY/Jpiki2zp/RZ5gT/yzORc/rE61440LJYPVNiGlxRrT4wm0htaEq43+2
   U4URWznY9H6n+k+Onw96ZC+09qaN1V/5Iu2KYcmVpGdhay8o/wOUNQITJ
   0jSNshl7Dav/350nvtqlgcWY8Gm1blaWD3AhOg6kRzZQE7IKMUrXUCvWW
   Q==;
X-CSE-ConnectionGUID: pMAlCFDoShSGZ9ZAk2IDow==
X-CSE-MsgGUID: m3yAGlWjTnyHLS567r8G5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115499484"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115499484"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 10:27:02 -0700
X-CSE-ConnectionGUID: +tl5PTnuSzaCMeECH97nHQ==
X-CSE-MsgGUID: y11mBr+uTImsnW15vX15Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1630839"
Received: from jesusnar-desk.jf.intel.com ([10.88.27.172])
  by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 10:27:01 -0700
From: Jesus Narvaez <jesus.narvaez@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jesus Narvaez <jesus.narvaez@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Alan Previn <alan.previn.teres.alexis@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/i915/gsc: Validate the CPD entry offset before manifest read
Date: Wed, 16 Sep 2026 10:26:17 -0700
Message-ID: <20260916172615.681135-4-jesus.narvaez@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916172615.681135-3-jesus.narvaez@intel.com>
References: <20260916172615.681135-3-jesus.narvaez@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPD manifest offset was dereferenced without checking the bounds
first. Therefore, ensure the offset and manifest header fit within
the CPD region before reading the GSC manifest.

Also, validate CPD header length before using it to size the CPD
entry table, and cast the boot1 partition's offset and size to size_t
to avoid an integer overflow.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

v2:
  - Removed unneeded manifest offset check against CPD header (Daniele)
  - Saved sub_partition_offset to cpd_offset variable (Daniele)
  - Added parenthesis to manifest bounds check (Daniele)

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 56fafa569764 ("drm/i915/mtl/gsc: extract release and security versions from the gsc binary")
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
Cc: <stable@vger.kernel.org> # v6.6+
Signed-off-by: Jesus Narvaez <jesus.narvaez@intel.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c | 27 ++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
index d550eb6edfb8..ab6c19d4125f 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
@@ -82,6 +82,7 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
 	const struct intel_gsc_manifest_header *manifest;
 	struct intel_uc_fw_ver min_ver = { 0 };
 	size_t min_size = sizeof(*layout);
+	u32 cpd_offset = 0;
 	int i;
 
 	if (size < min_size) {
@@ -139,7 +140,7 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
 	 * --------------------------------------------------
 	 */
 
-	min_size = layout->boot1.offset + layout->boot1.size;
+	min_size = (size_t)layout->boot1.offset + layout->boot1.size;
 	if (size < min_size) {
 		gt_err(gt, "GSC FW too small for boot section! %zu < %zu\n",
 		       size, min_size);
@@ -173,8 +174,9 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
 		    INTEL_GSC_BPDT_ENTRY_TYPE_GSC_RBE)
 			continue;
 
-		cpd_header = (void *)bpdt_header + bpdt_entry->sub_partition_offset;
-		min_size = bpdt_entry->sub_partition_offset + sizeof(*cpd_header);
+		cpd_offset = bpdt_entry->sub_partition_offset;
+		cpd_header = (void *)bpdt_header + cpd_offset;
+		min_size = cpd_offset + sizeof(*cpd_header);
 		break;
 	}
 
@@ -195,7 +197,14 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
 		return -EINVAL;
 	}
 
-	min_size += sizeof(*cpd_entry) * cpd_header->num_of_entries;
+	if (cpd_header->header_length < sizeof(struct intel_gsc_cpd_header_v2)) {
+		gt_err(gt, "invalid CPD header length in GSC bin: %u < %zu!\n",
+		       cpd_header->header_length, sizeof(*cpd_header));
+		return -EINVAL;
+	}
+
+	min_size = cpd_offset + cpd_header->header_length +
+		   sizeof(*cpd_entry) * cpd_header->num_of_entries;
 	if (layout->boot1.size < min_size) {
 		gt_err(gt, "GSC FW boot section too small for CPD entries: %u < %zu\n",
 		       layout->boot1.size, min_size);
@@ -205,7 +214,15 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
 	cpd_entry = (void *)cpd_header + cpd_header->header_length;
 	for (i = 0; i < cpd_header->num_of_entries; i++, cpd_entry++) {
 		if (strcmp(cpd_entry->name, "RBEP.man") == 0) {
-			manifest = (void *)cpd_header + cpd_entry_offset(cpd_entry);
+			u32 man_off = cpd_entry_offset(cpd_entry);
+
+			if ((man_off + sizeof(struct intel_gsc_manifest_header)) >
+			    (layout->boot1.size - cpd_offset)) {
+				gt_err(gt, "GSC FW boot section too small for manifest: %u < %zu\n",
+				       layout->boot1.size, man_off + sizeof(*manifest));
+				return -ENODATA;
+			}
+			manifest = (void *)cpd_header + man_off;
 			intel_uc_fw_version_from_gsc_manifest(&gsc->release,
 							      manifest);
 			gsc->security_version = manifest->security_version;
-- 
2.43.0

