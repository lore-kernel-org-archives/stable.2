Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AE4F85D7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675108; cv=none; b=Vmz9TIu6g+P/TmXGiNmbxIVog1UTi1UhQcaeQ+g6F2r9YSH3X0bBhOfR0fSPqejGa0e2UBcKkdi2rkbr4/ScObY1+dF8hwz1yNm90Fz55efAcFQh6Cs64JB+chs7qK01wJSumzmJ9XgeZTmTkHOUJeFv0ky73oW3E1apI6dgzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675108; c=relaxed/simple;
	bh=MVmXUnBjOenICh1yyRgj9f8Knp/0Q36f3RawBrNMaiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/mvVpmHUtq5726BgHaI3z1dkWz4yZTLuN/c48WNUzgU8ynHwTZho9mppU5qt3evhs6FaMagA4foLPwjwUtwHOywI3jxxAApkJSYUu7PxfsUZQAUo2sA/BNNW6xBSr51PjEDbtCHC66JvJtPDutmqpzUTkBBW1MLp6Occ0t62s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6uEEyM4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6uEEyM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790675106; x=1822211106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MVmXUnBjOenICh1yyRgj9f8Knp/0Q36f3RawBrNMaiI=;
  b=i6uEEyM4TseaXDA8UhIsDWJOMSPRJadkKsTOhLInQgkg2rruLkCjNgSE
   xR3uV8jqSE/x949gie3xIIfb18h0a0by3ebOLADIt5jwnNMBk7Z1K1lsd
   jyeyidECzv8HGedpdTQu1FIP1QAjeWAqp7VBtyrEZ26Jf+p58zuRxLJOQ
   fQSG90tuz1wpG+TnJQQT9GH//Odh2zXwsY4tcmiE9W9SE3lRD/De6eNps
   ZNv34BdppuwCOwSkmcRoryr7Aeb73LS9KCEoLa5BVMd/Blf/bZ6Y7YaRm
   EpzTJQEO7wklUu3030FMSQNClTQCCppWQJfMMhMkXv8JXCVa++YUgknPb
   w==;
X-CSE-ConnectionGUID: ZEoq16W+SsOYhYgqXn6+mg==
X-CSE-MsgGUID: Q26ejvzOTayUfPlQoCEGug==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91250060"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91250060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:44:56 -0700
X-CSE-ConnectionGUID: OL2yPaEKTOexGlNovH1GxA==
X-CSE-MsgGUID: EYypfGSURZu3nRZZvfbneQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="283414981"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.120])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:44:54 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/8] drm/i915/psr: Disable linked plane sel fetch as well
Date: Tue, 29 Sep 2026 12:44:29 +0300
Message-ID: <20260929094434.77129-4-jouni.hogander@intel.com>
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

Currently we are not setting linked plane selective area when selective
fetch is about to be disabled for the UV plane. Fix this by simplifying the
loop by just handling plane selective fetch disable and area setting same
way.

Also set the update_planes bit based on comparing old and new plane
selective fetch area. This way both the plane and its linked Y plane are
updated only when their selective fetch area changed.

Fixes: a4f477e6ac17 ("drm/i915/psr: Add proper handling for disabling sel fetch for planes")
Cc: <stable@vger.kernel.org> # v6.8+
Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 27 ++++++++++++------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index a9e9215200015..f2ec7b0e0668c 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3065,21 +3065,14 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 		inter = crtc_state->psr2_su_area;
 		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
-		if (!drm_rect_intersect(&inter, &new_plane_state->uapi.dst)) {
-			/*
-			 * if plane sel fetch was previously enabled ->
-			 * disable it
-			 */
-			if (drm_rect_height(&old_plane_state->psr2_sel_fetch_area) > 0)
-				crtc_state->update_planes |= BIT(plane->id);
-
-			continue;
+		if (drm_rect_intersect(&inter, &new_plane_state->uapi.dst)) {
+			sel_fetch_area->y1 = inter.y1 - new_plane_state->uapi.dst.y1;
+			sel_fetch_area->y2 = inter.y2 - new_plane_state->uapi.dst.y1;
 		}
 
-		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
-		sel_fetch_area->y1 = inter.y1 - new_plane_state->uapi.dst.y1;
-		sel_fetch_area->y2 = inter.y2 - new_plane_state->uapi.dst.y1;
-		crtc_state->update_planes |= BIT(plane->id);
+		if (!drm_rect_equals(&old_plane_state->psr2_sel_fetch_area,
+				     sel_fetch_area))
+			crtc_state->update_planes |= BIT(plane->id);
 
 		/*
 		 * Sel_fetch_area is calculated for UV plane. Use
@@ -3087,16 +3080,22 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		 */
 		if (linked) {
 			struct intel_plane_state *linked_new_plane_state;
+			struct intel_plane_state *linked_old_plane_state;
 			struct drm_rect *linked_sel_fetch_area;
 
 			linked_new_plane_state = intel_atomic_get_new_plane_state(state, linked);
 			if (!linked_new_plane_state)
 				return -EINVAL;
 
+			linked_old_plane_state = intel_atomic_get_old_plane_state(state, linked);
+
 			linked_sel_fetch_area = &linked_new_plane_state->psr2_sel_fetch_area;
 			linked_sel_fetch_area->y1 = sel_fetch_area->y1;
 			linked_sel_fetch_area->y2 = sel_fetch_area->y2;
-			crtc_state->update_planes |= BIT(linked->id);
+
+			if (!drm_rect_equals(&linked_old_plane_state->psr2_sel_fetch_area,
+					     linked_sel_fetch_area))
+				crtc_state->update_planes |= BIT(linked->id);
 		}
 	}
 
-- 
2.43.0

