Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960C4D37B2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579608; cv=none; b=VE1zbTHd9APhY67wg+/LsJ1a9BNMhEPBScl1s260zJ8Bx1IRbhlhzOy0QSW3bQiykHwiPJ5PLU3imYBD4nGDpKe9y3SNeqe3FVp96MTRjBjDIDGkBWqdLyaEk6IqjwR/P8SeM5eoAxxkidX5n9aX5VO5qykkhiiS2P+Ulnes7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579608; c=relaxed/simple;
	bh=WBPC+qP5/J+46m2cj9buYBvg4f0hgvW8kMQtB122HKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7Lex2keuY4DZxSHlk/qMLqEeAXTuOzYHV7tHpgKqtn30DKxGQjzG+koc36B1UygHlfKtHcG88o4g0MsbazU/cvqwrbctds4F0LnkQPf9OEBKo80NieMnRiOPfqtV/6NZRqXE6q9n24TS+4rzzzq6XeLhClRHorAQZWIpsu0rQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ck1OGOhe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ck1OGOhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789579606; x=1821115606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WBPC+qP5/J+46m2cj9buYBvg4f0hgvW8kMQtB122HKc=;
  b=ck1OGOheO4e6jTR3gJZdQUxgg4RupWK9ARLSN4e/kfmWkoSrE1ZoemlB
   rR9cMVWHhgQh7qXrOLCTE7mDPPcd6cnvVpM3DkEOP+gSLhLJ7NtmooRtD
   Yw0r7ra0XPgd9VOV8ig3MBqOkKN12oAv8j3fQ3O2N4HUsf/pcbMbwCYP0
   KveA/kQ5heXvyKnCkylZEgBS5eq29UQyqpd8mdlP8yM3ocV53p9prGS8v
   Lm5mFlmZZ2Fxw7HO6B04+gqdDwsBFiNbucoRIrGtSBVFkZ51y7di20k+9
   evoj9YCbkBprOMD22Y3hwixlyMgXhDlwtO1RgLvBTgN8EDX9TOnoUREt1
   g==;
X-CSE-ConnectionGUID: gcieuaM/Q9iFAS4kmk5idg==
X-CSE-MsgGUID: 2tFr3xmERa2bLGfuNnsbaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115499459"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115499459"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 10:26:45 -0700
X-CSE-ConnectionGUID: 0oxytLzxS5qSWKo/I6lgUw==
X-CSE-MsgGUID: TUQXpHquRLG5KeN1Z8dO/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1630763"
Received: from jesusnar-desk.jf.intel.com ([10.88.27.172])
  by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 10:26:45 -0700
From: Jesus Narvaez <jesus.narvaez@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jesus Narvaez <jesus.narvaez@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Alan Previn <alan.previn.teres.alexis@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/i915/huc: Validate the CPD entry offset before manifest read
Date: Wed, 16 Sep 2026 10:26:16 -0700
Message-ID: <20260916172615.681135-3-jesus.narvaez@intel.com>
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

v2:
  - Add parenthesis to clarify offset check (Daniele)

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 93a575ab1533 ("drm/i915/huc: Parse the GSC-enabled HuC binary")
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Jesus Narvaez <jesus.narvaez@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
index b648238cc675..3560961d606f 100644
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
+			    ((size - offset) < sizeof(struct intel_gsc_manifest_header))) {
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

