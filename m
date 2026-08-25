Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3640302146
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629359; cv=none; b=LtlbB85k1v955r8BMjLZLS4jpgJEON/LjoEgCeFY8/TjaECeyZAEx3rd3E6+xaSEoniY17nEJ7z/+sWQKafZaqZ76DJ05AHjoiiWMsP8KhujUWVYxBZ2Dw3Q3vdoHHoz1MbrM4jFZ9KTqj8zk6tkg+Ws8LJtt1esdXFKNWSYj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629359; c=relaxed/simple;
	bh=E9W0mol4tPnmq7b9Z9SmxLz+9q5fRhyTUR2y3Pqbu6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwpNTcWzkzVWK4h6fSiTmwHoxGnHR6PpmrWUgyR1dZnaxdt/vAbWCzNMh90AW0bRMY3yU6D3p3AzFSuzHno3h0ApJkmJOQmXQuyMst+/sCDci7FIk+9yQBY5fUpKxkX/KW2sGGuQRlFOgofyeBe0Vw8RsBrETx+7Y9mgpZxAc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpGeUTMF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpGeUTMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787629357; x=1819165357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9W0mol4tPnmq7b9Z9SmxLz+9q5fRhyTUR2y3Pqbu6g=;
  b=dpGeUTMFfpIV7dzI2qo+RAM1xn4v6Y5ZD6AYyzHbrWQiw2Xbyz/EuBFy
   y0cB19hhim9M+pEhHYL1fIJhIT6VoMn2RhdBPyHcMKBXgmHgJ96QGER5g
   fHvtWff5GvMrKJgzTDfR2I5ptNpCRO9/TGo5A/y8jsaCY6CLw7ML2PMbG
   A2KSGGei6Jn75Y/JipwSuN6KdTwtTetay/k0PTJD3crSDejgWHOScIPSj
   6WTYOwEQARlxyf8IazcGjy4V4QNzb7TeN1O36YYW9fAhTKUGUpItYZCQ4
   26QDlb08U/CqzyLkccH80oYA5HOcVZckVsA0aA4O0YoBwdWK8umemzNIg
   Q==;
X-CSE-ConnectionGUID: ZEcXC1pYRiWOyF3SqTF7FQ==
X-CSE-MsgGUID: CAF4lUbVRK+ZLTFblDBHOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="105469230"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="105469230"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:42:37 -0700
X-CSE-ConnectionGUID: Yi/HAfqdR06Q1nzmHhfjKg==
X-CSE-MsgGUID: RmIVK7JiSDq+DvKzJyGxwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="267228507"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by orviesa007.jf.intel.com with ESMTP; 24 Aug 2026 20:42:36 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18.y 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Tue, 25 Aug 2026 03:42:24 +0000
Message-ID: <20260825034224.642641-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825034224.642641-1-jia.yao@intel.com>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260825034224.642641-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC reads the queue via GGTT (WB), stale data may be observed
when the cacheline has been polluted by another agent.

To match the GAM's UC writes, configure the GuC mapping as UC as well.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-4-jia.yao@intel.com
(cherry picked from commit 9daa302a82590eeee7bdc68023ddad302df4b88c)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 4c3e21b5e60e..ecd07d76ec4a 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -405,7 +405,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
-			       XE_BO_FLAG_PINNED_NORESTORE;
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC;
 
 		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))
-- 
2.43.0

