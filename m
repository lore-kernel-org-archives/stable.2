Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15435479892
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242393; cv=none; b=iuQEkKOkdonfrJN1EdOonFXOhrfb0T7c17js34Hu+V9ncOJU+/aPdZWXELQRBfaNv1/YWvln6TAj+deVZSiNDBxgLaX2jECABABqlnd0f/YSiEKGflKAMDcbATxA6VaCAxSzyyqNIFBhcg4vTSYnNRImso3qZURJZuvBRB1YaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242393; c=relaxed/simple;
	bh=g+Zvczh6A7coCLeKduqBrq/FGaLwDjCA5vq7GVQoWlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REPOIhUVyPIDhGFlOn5ESHVQig3boxtVsdCidjLvxZcRwwz5aycJLr1N+4js5348fnbzBIbYvOxwWLbYT0rRbyori7bGF4pYIZBF6i7L2ScCKYMbaHpVQ10O7mIUETg8M4OCzFFqTrpRjC1VlIhFcHKf08KVNyrT8pD6Gbr127A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuaXNRf0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuaXNRf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787242392; x=1818778392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g+Zvczh6A7coCLeKduqBrq/FGaLwDjCA5vq7GVQoWlA=;
  b=TuaXNRf0HHlYYz4Ich3XuqcYYtNm69Mgr9NtOwbRJx0aXz762QzLFWhh
   kDQqfRH/tCNPZI4KBIZaTdq0ShRs74K7nE2VtVv0HE4CD21IHCMeJIiXV
   Bd8eQarYrpGmMbbZBtr2UjCwwxcx7Mx2rZ0NnG1jV35HHqpOdKdG7D/ao
   I2nx9IXb+Fd6KBiY9LIkXy6WK6goJsvo1ic2J3cmzOkx2hhPmtvv4hk/J
   y9AXYA9J5HF9ZXUyUXHkm6OMGHVPu5OBS+BqsvkCy5rcsMgzZuRG9z+CK
   ++sDxiO3/zuCtMEE4821q+MIMxtdiYZEqJn6DpVneiS+0i39XdcLsOo5g
   g==;
X-CSE-ConnectionGUID: UeD5J9+GQa2W8X+FGzoMcQ==
X-CSE-MsgGUID: 1R0b3bPTQESPYq1vUp6TcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="105320002"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="105320002"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 09:13:12 -0700
X-CSE-ConnectionGUID: O6xtHDHuSmyIYw2QQWzwXg==
X-CSE-MsgGUID: DYFVHOj+RdyUhCEtfTtGdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="270319913"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.54.89])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 09:13:11 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18.y] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Thu, 20 Aug 2026 16:13:09 +0000
Message-ID: <20260820161309.1340665-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082055-unvaried-abnormal-f1b2@gregkh>
References: <2026082055-unvaried-abnormal-f1b2@gregkh>
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
(cherry picked from commit 8d5134ae4177fa4f5a9bc8e71e6656cfc2852882)
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

