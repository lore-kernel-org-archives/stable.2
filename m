Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D72F8EBB
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629317; cv=none; b=rRL/fxVUNRh/mNKXkEZCe3brpXqE2478NaM7UbsLloAbp/e1V1EPRPjKsDxTL+yWmBM9702ZVb+xsaDvOApE0gsfpQKEM/kBH3SZcirWfT+tab6rZa0TsoK4rEPvSwG6U/wvxrFG/N3VSZxSyUKsvGakgp4PJxd+aizwFOyXsyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629317; c=relaxed/simple;
	bh=pPkaNIiYoGVwJ+CeUBHiYmuN3T8+eXfS/30X+Uh7QtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNhJE8eoicGkmsSXv83soJvCn5qL+9edpW2TB40EBYCl5hDzuge965IrYeKbPW7YOasq1MA9RJgMCKIWwdgaQq3tfxu1QFPbtvQ2qrl3gMP6X2809gdkKi5ODM36MhYhA++N8pdPF6BhdupdkEWdC/ThQB2uNeSvtt6Zwl9zaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxZP1nhV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxZP1nhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787629316; x=1819165316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPkaNIiYoGVwJ+CeUBHiYmuN3T8+eXfS/30X+Uh7QtU=;
  b=FxZP1nhVNLRcCQtMhO4uUjAppaG1wCgmcr+TGzwwl70WxylhJzocyWMu
   eKq+c45irUKf5jYTLeHy8u2Kv/c8PA7/y5X7v2F+YSeEQxBX9NEIc1A7D
   Tzjfwz6jvMqHsRCFF+D73LRErxgSc5l7Yfmr8iHAII5fqeVY9yMmSohgp
   /HU4cdm/IzE8FvYa1e4FFKX4vlxcdcbkaaE+8XVmaKhJLKnWjoyIFlSwQ
   F3hFeGsE4AkLLPuEFI+C9QsmidpiMqw4rJYeh/KTzbiqpnS/hUitJ0ISc
   RpHYIgvyzsm75mN747AMOX8ZhyusRPnm32PHoraMqOuHbyWa6C+UYirAH
   A==;
X-CSE-ConnectionGUID: UG1ogtovT7aK5iGjT5DuuQ==
X-CSE-MsgGUID: eJMfEgnXS6uY3DNT9WaAOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91767796"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="91767796"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:41:56 -0700
X-CSE-ConnectionGUID: QAwskcFaQcOX8+FgNhBqrA==
X-CSE-MsgGUID: m/Fjb8r3Q3uuC+s9fEx5lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="266632678"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by orviesa008.jf.intel.com with ESMTP; 24 Aug 2026 20:41:55 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.12.y 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Tue, 25 Aug 2026 03:41:13 +0000
Message-ID: <20260825034113.642528-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825034113.642528-1-jia.yao@intel.com>
References: <2026082037-mutual-coroner-efeb@gregkh>
 <20260825034113.642528-1-jia.yao@intel.com>
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
index 35168447a90b..a4932a45120b 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -413,7 +413,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

