Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D14EA373
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048432; cv=none; b=NtzscsL8XXDIGOQETIZZ74K7PCfjbeQ5cIm9OejPMBgA/lhK9A0Jx/WEyfCMWHEuTsNSMhXhK+eKEKXonuo17Qz89pAgY/26HYPbatv0wqM7xIRfbwo/P5HbM6TG/UcKPCNdLFE0VC+4WQFNuHikdd3GRjOJAnmK9f02/NogwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048432; c=relaxed/simple;
	bh=CtzHXLm4rqQfESPrSLFYzqXudFQYcZGZv7gLN/aBxbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I/qiMIqMcjvDaADNtsuIJRivVToVnnJtET+PdP1Z0VPNIgANdncewuLP5fupGdPVQXspawErGhzYE5jVGtXiuj2hyBiE7lsME8tM5s73DBZQ9QDUb55wYjIvwG+5bGTi5+xZqtSCq3+V+2FATKgJ1TOPAcUmIQtKpU7evoYfHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7ML6q+b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7ML6q+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784048432; x=1815584432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CtzHXLm4rqQfESPrSLFYzqXudFQYcZGZv7gLN/aBxbc=;
  b=J7ML6q+bJK+FhNXP8hh6aI1Q/9LnSGtz0t5UqOxTk7xOHcmYGOkgSkne
   IUULzPbcLGwJoWZLf4zqKoBNAmlDGoPQZlFYVNdxGIPB04OMiseCHs+f6
   X2yihKRF3hXkS6D/q8OcIi/ZanombNHEk9yzJcZUvTlRhzTIAM/EnabU/
   2sspZKfsjK1/xg3Dq0rkeL6Z/6t4G8wwPXGvj6slYZD9n5lyR2b7/RT6d
   jJ9WSYK7WljTqWGCiPnUSDD29q7yKRJC07k1TfT4wXeinvX9q/VN5yHJd
   Dc1/d8rYxp4DnkpqcGALZTGV6EA8UXpKn74swUjG/JImajbV4dpwXjnqb
   w==;
X-CSE-ConnectionGUID: LfWTdj7WT46Ghiu8/51qKQ==
X-CSE-MsgGUID: bqQYhzCcRfqwAso1vKYvow==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95031410"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95031410"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:00:31 -0700
X-CSE-ConnectionGUID: Oe7vmsbuTyuYxEBUwATK1w==
X-CSE-MsgGUID: NQTjB/69Rr6qxHiLC1iJIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="294124194"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:00:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/gpusvm: Fix MM reference leak in drm_gpusvm_range_evict
Date: Tue, 14 Jul 2026 10:00:25 -0700
Message-Id: <20260714170025.3487974-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kvmalloc_array() fails in drm_gpusvm_range_evict(), the MM
reference acquired earlier is not released, resulting in a reference
leak.

Fix this by dropping the MM reference on the kvmalloc_array()
failure path.

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index f45bf1d59a06..ac1f135abe68 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1778,8 +1778,10 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		return -EFAULT;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
-	if (!pfns)
+	if (!pfns) {
+		mmput(mm);
 		return -ENOMEM;
+	}
 
 	hmm_range.hmm_pfns = pfns;
 	while (!time_after(jiffies, timeout)) {
-- 
2.34.1

