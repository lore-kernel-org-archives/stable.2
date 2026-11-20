Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168566;
	b=DHS+ludaedUJyWceYy23n5Q7BI86ECLJOBgWAy4Y7NjlBYaIljD/Hy2OFwbVEmrQ0e3t
	 RXxIXkxKza6DjXUlZPR+98xXhcrsbfsAkH27KFweAcibWdNggVqrmdk0cBA1c9lrsPy50
	 Ld6tXiTfPG+K0ISiXmfWNYAkPZab0GmS84y87swcJk2SIojwoXLqEKqedwRERu+r5m7YW
	 M78GAXYK4mBml3OMMdeUc84lGsFBraIflcCoJj6xXZ6snoPLVn16FRpO1xvd6Obx2hSPk
	 asO2B6Cailp0Y+UC4zAbHeUhzztyicmnSCPPoIsxeo5IcZTMgAcXKYq3lt8Sfh2cI8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168566;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Organization:Content-Transfer-Encoding;
	bh=JZxrv6VcVC6qIahE9n2InA3CkhchLmWFc0K6FXtxu4k=;
	b=CHyBxLEHDUVeMzmr0YxN2rXXKXv8Ye5jGPI/IHf1x6vdlaGAw4mld8FOFXlOAzjmL61T
	 pSP75tMHcp7jZUL/driRbn6dbYD6kfq4rFB6R/8T8d/pGI8/ndTNNzTS49ju6LemYGilb
	 +E/lLbAsVU2ZkDAmWNd2jEV8xXYWuXoZ8L69cKALmFOnv2kaRAJY3bHIuraA/dPPBeza0
	 Mj1vZeuW3ae10cdFs+0FczQtf7zxoUhwOK5VGPKkhYu2PTm1i6SniFZMSrUeEE+eNnM5F
	 U/1TX3FI0SvPnCFK21BKP5LhIjsQvZRKr/e4UyaJWx3gDK5xsRnJnvNPgjcSjAD/CLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AyUNYLm3;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088B606A339
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6088B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AyUNYLm3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168567; x=1826704567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7sNYqCar3YO3sq+w2e4d6JhJGA4Jgi9zqg7118pXqeo=;
  b=AyUNYLm3Y0SrLfLTyjle2XXu5K60WO1W6Ejb+ATJqegxscJ1VbhRk5YF
   qVNW+rbJg3gSUnd0O4uBBONNM6fmLgGQIxXO75WdqhwU1hyra9uuh2EY4
   V8fcb3SkzGBZFX3TSXYZYsWET7RPxuie5vwvwjVM5CcBcnEJUfbE5wATN
   Bj4CyC/uH2XqjPQZsToYiFKvkn0g9lKcyqG2KgHkRQu97V4JgDzj84zwW
   qxSfAXfHK78ks2fk+xE/nfhmZo8i4+K47ZGXODO6NN/Q88e2rHci1N8mj
   KuG57Krg7zQdk4zWYZoba4NDXZMx6GzGm/9Z6KSg/J9lK5ur5FCAvhyco
   A==;
X-CSE-ConnectionGUID: B4gGMsxVRXCBJHB3EDq/Fw==
X-CSE-MsgGUID: CAd6jfswRbSfZBA7kVQ9dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4072525"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4072525"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:56:07 -0800
X-CSE-ConnectionGUID: TCsAfbQ8RnKVwpWTUTEPXg==
X-CSE-MsgGUID: WHBdD5jWT7WUWeUg8N42pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10567006"
Received: from lpankiew-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:56:05 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] drm/i915/psr: Don't add all enabled planes into state before SU calculation
Date: Fri, 20 Nov 2026 11:55:40 +0200
Message-ID: <20261120095541.1325118-4-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120095541.1325118-1-jouni.hogander@intel.com>
References: <20261120095541.1325118-1-jouni.hogander@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Adding all enabled planes before the plane checks puts them into
update_planes and makes their missing damage clips count as full plane
damage, so the SU area always covers the whole area.

Original resolution in commit 0d173898b111 ("drm/i915/display: Add enabled
pipe planes into state for selective fetch") was wrong and fixing visible
corruption with biplanar planes was fixed by using full update always.

This patch adds back logic adding enabled planes into crtc state only after
SU area is calculated. This is safe as we have workaround for issue with
biplanar plane in place.

Fixes: 0d173898b111 ("drm/i915/display: Add enabled pipe planes into state for selective fetch")
Cc: Mika Kahola <mika.kahola@intel.com>
Cc: <stable@vger.kernel.org> # v5.17+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_plane.c | 10 ----------
 drivers/gpu/drm/i915/display/intel_psr.c   | 23 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index d23de0f34e4b6..f908eabe604bb 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -1980,16 +1980,6 @@ static int intel_add_affected_planes(struct intel_atomic_state *state)
 		ret = intel_joiner_add_affected_planes(state, intel_crtc_joined_pipe_mask(crtc_state));
 		if (ret)
 			return ret;
-
-		/*
-		 * Add affected plane here to ensure UV and Y plane linking is
-		 * in place if UV plane is added as a part of selective update.
-		 */
-		if (crtc_state->enable_psr2_sel_fetch) {
-			ret = intel_plane_add_affected(state, crtc);
-			if (ret)
-				return ret;
-		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 11e3189360f28..efcc5ce1bfab0 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -51,6 +51,7 @@
 #include "intel_dsb.h"
 #include "intel_frontbuffer.h"
 #include "intel_hdmi.h"
+#include "intel_plane.h"
 #include "intel_psr.h"
 #include "intel_psr_regs.h"
 #include "intel_quirks.h"
@@ -3244,10 +3245,12 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	const struct intel_crtc_state *old_crtc_state =
 		intel_atomic_get_old_crtc_state(state, crtc);
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
+	struct intel_plane_state *new_plane_state;
 	struct intel_crtc *joined_crtc;
+	struct intel_plane *plane;
 	bool full_update = false;
 	u8 joined_pipes;
-	int ret;
+	int i, ret;
 
 	/*
 	 * Selective fetch is not always usable, for instance it is dropped
@@ -3291,7 +3294,24 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	if (!full_update && !psr2_sel_fetch_merge_su_area(state, joined_pipes))
 		full_update = true;
 
+	for_each_intel_crtc_in_pipe_mask(display, joined_crtc, joined_pipes) {
+		ret = intel_plane_add_affected(state, joined_crtc);
+		if (ret)
+			return ret;
+	}
+
 	if (!full_update) {
+		for_each_new_intel_plane_in_state(state, plane, new_plane_state, i) {
+			if ((joined_pipes & BIT(plane->pipe)) == 0 ||
+			    !new_plane_state->uapi.visible)
+				continue;
+
+			if (!psr2_sel_fetch_plane_state_supported(new_plane_state)) {
+				full_update = true;
+				goto apply_su_area;
+			}
+		}
+
 		/*
 		 * The WAs clamp the SU region that ends up in the per
 		 * transcoder PSR2_MAN_TRK_CTL, so they have to run on the
@@ -3307,6 +3327,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		psr2_sel_fetch_align_su_area(state, joined_pipes);
 	}
 
+apply_su_area:
 	for_each_intel_crtc_in_pipe_mask(display, joined_crtc, joined_pipes) {
 		ret = psr2_sel_fetch_apply_su_area(state, joined_crtc, full_update);
 		if (ret)
-- 
2.53.0

