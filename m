Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D634D926
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898169; cv=none; b=cqVlqHIEIwQ7HhG8t37z+PEBwwtSLZqcFH1DALW2+pYSwS9+7Kx0Z+Am2ulr8xQQY/m+mrcJN9LwgDXBRdSibAHd3yeg66Tt9qkuyypprsbAizi6E3sb40mwF6O1DUJPk6qb++fQd/4YjnRTys5kgslz6PPkZEocn6TLI00Ebyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898169; c=relaxed/simple;
	bh=t1+ckeH/aMwGOuvxZL76S9c0gPW+XJSDmjQqF8ih33A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVliWWtC+l2unaMCwDvBh+PVws1I3MG4rMjU1iOE3I7RSSgeGJmvltBAnw1+td2FBlvwSkqZ4MKiZv/VleORkhue8AmTB/IN5gVQXbLrrzaYyyDfDa9gxxq0yqjxvsc1D2jkgzrqLDlfsnJPVh483zZvGgGStuv77OIJG8TFwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fV5wV0c9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fV5wV0c9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898168; x=1817434168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t1+ckeH/aMwGOuvxZL76S9c0gPW+XJSDmjQqF8ih33A=;
  b=fV5wV0c9cNqXoA/+xHp01DgTvwEdcEavxGpxjY//2Rr0pqr/B3OrP/fR
   tkKSlDz8RKyPVcISj/XeWj1WjxQsgdLYhSE0onhKP/DfHDNJhfOzOnxdA
   5HHDLQRLBf90GrqWjBCH5mWkGxoTBUzWed3oYa/rKGD5U1zibzx2A5jsV
   i29ROMEHIkzmuMgZfO+vavyEETkAcezztLfBok1/AuB86uvHgaucYJ8Tu
   5XXQWg18Kn3Rv15txCfw4uznrX8+oM5vIQLWzxhvefbdlkqIFAE6w8M8s
   yHCGdM/iYt/tkutAGjmigKU5NpFRXBRqyRfrtuZ2Br00dTpHE0EwwZomi
   g==;
X-CSE-ConnectionGUID: PlXPrCqFS5K/dxcPy9af8g==
X-CSE-MsgGUID: EDx1L1y1SJa95WeYbAcCrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826132"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826132"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
X-CSE-ConnectionGUID: oBC4b2SiQXyAR1g0Wyi/9g==
X-CSE-MsgGUID: 9tDUYZxxTqWkNP/b4DXLfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911794"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 06/12] drm/xe/rtp: Keep track of non-OA nonpriv slots
Date: Tue,  4 Aug 2026 19:49:09 -0700
Message-ID: <20260805024915.3407033-7-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
References: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 60d49ea28bb190a640bd8dc3f4c946e0811a948c ]

In order to dynamically whitelist/dewhitelist OA registers on OA stream
open/close, we need to keep track of nonpriv slots occupied by non-OA
register whitelists.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-4-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index d82b14f8d0716..12d12d8f0e99c 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -94,7 +94,7 @@ static const struct xe_rtp_entry_sr oa_whitelist[] = {
 	{}
 };
 
-static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
+static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 {
 	struct xe_reg_sr *sr = &hwe->reg_whitelist;
 	struct xe_reg_sr_entry *entry;
@@ -126,6 +126,8 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 
 		slot++;
 	}
+
+	return slot;
 }
 
 /**
@@ -139,9 +141,10 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
+	int first_oa_slot;
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, &hwe->reg_whitelist);
-	whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, &hwe->oa_whitelist);
 }
-- 
2.54.0

