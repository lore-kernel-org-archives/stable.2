Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0E4F93DA
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675111; cv=none; b=Gd80Usd1bpYds+ckx6ikRZsOwZ+83X6QGlv90o/SV6JSBqESqtrii1Ukpthzo0Cs73pMvpQ2ROSbLa9nxxGcT0g8DqmR+9Kfz3LEOtf1Zk9HBywl9/6P2s/HwuiMJdqARBhmOwXDc0wgGH6FGJ3GX8Z73bIJup/crW0lj/sRkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675111; c=relaxed/simple;
	bh=P1cuXnO4K1GNtuUfH0ej8OHMzUajKE8ugZMPTZPsdcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJiPdGHUBHtBs92UYSsJI+gnTsFry6Va4ZmW73+9gxAN1TPGQHgYsJH/wxvbhx+8dA2pzT5O00gy2+AVWHpNgt8RBxkJRyvl9RVyrYEe4vujiGYnUVEj1uvEGjey2ZvsCY6aio93kstV+ecePVbMmW/FNBSOJA4aBIbo7Bxu63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCYPFKXo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCYPFKXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790675109; x=1822211109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P1cuXnO4K1GNtuUfH0ej8OHMzUajKE8ugZMPTZPsdcw=;
  b=KCYPFKXo5jtIcgrtKCfzPjFl/5R/l4R3/o5C8vE1JxAym0Aq4TTbSFCP
   yIjTCymYsYJizAY8762EM1uGG+QdqRMpCfFOw8UIez1RW3rpOj+vSeGPi
   2Mq0WZXiOq/DQ7EotAqfo7Fj5mORGFy+FhMucUzQArNBtVAPKG/XWuMwi
   xy4jhPeProhMXhjEIi3CmedRRCg/d0iXNLiVXImisWOAVOUyHOk3qFy/9
   52uzuyubz+UN2GJOGCi/ve5GFJe2UOqsP07qYPyyLoxhtjfwTni3+jDVi
   almeZfVfVolANUdv1IjloI7e52gnjbt5iFTSv01vwcmSmDBS5keTx+YtJ
   Q==;
X-CSE-ConnectionGUID: w3dbuD97TcO3p5ZVQsdsZg==
X-CSE-MsgGUID: iCT5PXWqQ0e+567i+PJfkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91250085"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91250085"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:45:04 -0700
X-CSE-ConnectionGUID: e4ZERtAvTPeq9zBT62EmmQ==
X-CSE-MsgGUID: pnuJW//uRVeDlL9Zbkiakw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="283415121"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.120])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:45:02 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 8/8] drm/i915/psr: Don't clip plane state destination rectangle
Date: Tue, 29 Sep 2026 12:44:34 +0300
Message-ID: <20260929094434.77129-9-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929094434.77129-1-jouni.hogander@intel.com>
References: <20260929094434.77129-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

clip_area_update() uses drm_rect_intersect which modifies passed r1
rectangle. Early transport alignment passes the cursor uapi.dst rectangle
to clip_area_update, so the cursor uapi.dst is unintentionally modified by
drm_rect_intersect.

Fix this by using local copy in clip_area_update(). Also make the damage
and the display area const.

Fixes: 1bff93b8bc27 ("drm/i915/psr: Extend SU area to cover cursor fully if needed")
Cc: <stable@vger.kernel.org> # v6.9+
Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index d8fefb13c2790..99603a486c278 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2709,23 +2709,25 @@ static u32 psr2_pipe_srcsz_early_tpt_calc(struct intel_crtc_state *crtc_state,
 }
 
 static void clip_area_update(struct drm_rect *overlap_damage_area,
-			     struct drm_rect *damage_area,
-			     struct drm_rect *display_area)
+			     const struct drm_rect *damage_area,
+			     const struct drm_rect *display_area)
 {
-	if (!drm_rect_intersect(damage_area, display_area))
+	struct drm_rect inter = *damage_area;
+
+	if (!drm_rect_intersect(&inter, display_area))
 		return;
 
 	if (overlap_damage_area->y1 == -1) {
-		overlap_damage_area->y1 = damage_area->y1;
-		overlap_damage_area->y2 = damage_area->y2;
+		overlap_damage_area->y1 = inter.y1;
+		overlap_damage_area->y2 = inter.y2;
 		return;
 	}
 
-	if (damage_area->y1 < overlap_damage_area->y1)
-		overlap_damage_area->y1 = damage_area->y1;
+	if (inter.y1 < overlap_damage_area->y1)
+		overlap_damage_area->y1 = inter.y1;
 
-	if (damage_area->y2 > overlap_damage_area->y2)
-		overlap_damage_area->y2 = damage_area->y2;
+	if (inter.y2 > overlap_damage_area->y2)
+		overlap_damage_area->y2 = inter.y2;
 }
 
 static bool intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
-- 
2.43.0

