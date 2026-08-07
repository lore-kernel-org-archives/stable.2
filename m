Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF631F985
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130662; cv=none; b=W+ulD3z+DD8LRAB4leOzbl7jhXHn9iVsC8wC1qtG69B1fh7aYGcYIcHrst0/OxMmMCr0nxvgHLxbk7F5AQPuU3lWG3/DDny5+9y1I9jyDMQBtm0r9VnofNNPtOoecb2K7trDdrFw+pcm2KmHlGkjHe8A/tch4LHqt2P2qIb/ft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130662; c=relaxed/simple;
	bh=jrCHeYZIdyZ3MVZUKmyFjr7FFMpHV+BS5nXHVsp+8qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWaikWFFPK0xSel3htRS4fJGtNne5Gy5hEjJxHNF7j8UhBa6uT9ro0D8p3nqyYM8YD+Re8pAJ8j4WNK/PdTe/AWQ7NHMFCpLS/ZvB9xcXU0ipaLl+CGPTHtsDDHEKwaNMH8cYfdJXdRf+dbUmZqN66VD05RsCItcizZeqiA+usM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzJYWQvw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzJYWQvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786130660; x=1817666660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jrCHeYZIdyZ3MVZUKmyFjr7FFMpHV+BS5nXHVsp+8qo=;
  b=OzJYWQvwFQOvS8FswfcigM9gmTCrkJFZjL7PCg1oUYE2v4ObEqs3RZor
   vetNdAm9uv/BN9cKmRvsHFWpTwEud/fS9pXPzTB7ObSAXc35508jPTBed
   RSklC1bUkDdzs99shqvj49Z92BlELdXyXSqd537qZlQImGuGulNu08aGm
   xTlCKX0z9prLK65rTKm7NWiRq3gQLvq/rwWyHGR39n0BqHe+w8NRzImyM
   Sd4xp17+wQUWGnb+so+WuKJTKNovXkSjuixRZMnagnjiHAYWGHH0qYmv4
   kZBdRoZgnJ7StBugqgmWN0WClW6gSjcUpLnAHdnwf1Rq8ZlISyN0gVdkw
   w==;
X-CSE-ConnectionGUID: 3C7cS9CtQnye68QoBHKOfQ==
X-CSE-MsgGUID: 9uZiR0RoRwyks9zoplQmlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="112293850"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="112293850"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 12:24:19 -0700
X-CSE-ConnectionGUID: MhCL2lxSRo2qfteaU+P5Yw==
X-CSE-MsgGUID: SpM4WRCsQV6JcKCFsev0Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="258170139"
Received: from jesusnar-desk.jf.intel.com ([10.88.27.172])
  by fmviesa006.fm.intel.com with ESMTP; 07 Aug 2026 12:24:15 -0700
From: Jesus Narvaez <jesus.narvaez@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jesus Narvaez <jesus.narvaez@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Alan Previn <alan.previn.teres.alexis@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915/huc: Validate the CPD entry offset before manifest read
Date: Fri,  7 Aug 2026 12:23:02 -0700
Message-ID: <20260807192301.3009387-3-jesus.narvaez@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPD manifest offset was dereferenced without checking whether the
offset was out of bounds or not. Validate the offset is within the FW
blob before continuing with the read.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 93a575ab1533 ("drm/i915/huc: Parse the GSC-enabled HuC binary")
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Jesus Narvaez <jesus.narvaez@intel.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
index b648238cc675..b9cbcf973236 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
@@ -216,9 +216,19 @@ int intel_huc_fw_get_binary_info(struct intel_uc_fw *huc_fw, const void *data, s
 	entry = data + header->header_length;
 
 	for (i = 0; i < header->num_of_entries; i++, entry++) {
-		if (strcmp(entry->name, "HUCP.man") == 0)
+		if (strcmp(entry->name, "HUCP.man") == 0) {
+			u32 offset = entry_offset(entry);
+
+			if (offset >= size ||
+			    size - offset < sizeof(struct intel_gsc_manifest_header)) {
+				huc_err(huc, "CPD manifest offset 0x%x out of bounds (size %zu)\n",
+					offset, size);
+				return -ENODATA;
+			}
+
 			intel_uc_fw_version_from_gsc_manifest(&huc_fw->file_selected.ver,
-							      data + entry_offset(entry));
+							      data + offset);
+		}
 
 		if (strcmp(entry->name, "huc_fw") == 0) {
 			u32 offset = entry_offset(entry);
-- 
2.43.0

