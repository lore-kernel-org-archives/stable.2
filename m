Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168563;
	b=ixm/BKvhXMoXXbC+T3Ct69BYU0IDOYPJqlaU8MudymgeZVA1maSMkP+2K9kAhsQNTTgT
	 UBxPsRWtSOz/QjRLy/mIHMjfw91u2qQQtFwb785r1lMdUUoSztf0lCTWDbNMsvmbO8603
	 a1W9/cFzsybxBl5bSbYUmx4DqCAIgA5oWAX9tuJbQX6288rT4Fcq4pVAkgMPHy0qO1Ppq
	 NXsPa6453UeEaYYRfFz8E1kJ9ILOCe+EByA0FQILpKIl1g8UU/d+DWm02VLX3jxC10wsc
	 /46kKwHnWiYHmuIyN1KP4oACC85tS/TMs3eMJf1BwAHYt/y+dmkgz055BaG0ZpBVhbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168563;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Organization:Content-Transfer-Encoding;
	bh=cl+pmVy476uhB8d+g7wH1JjKqA6mI1kK5QAR+3Yzws8=;
	b=qyosLsdCMPEur+yiWJIeWz4t3Vaz5xYihintzvMOGLQYbfVGt4FsLjJjSpaGYqQvmy3m
	 IYtLY7NT16zX4XUU4eITsi3n3sNxceLa5UiKj2gbcUKd2cZS9t5NgTynNxi1+EzbVF5bo
	 wEyVcCbfKUsYHmHRAt9e4KwxXjmdgYqPERuQJKiO1hu9QZbriYGqIW7hEjr7e67N2zF0I
	 YIwUZGqR0yOO4l32Sk6IeBI95eEA4dcGjtjk2lv4t+sbb4zhENfCB6HgUVMkYY7JMo+AG
	 7PcFxa9GsoS6xDHTSyN9hFNP/cZx4nAmhZAH3wHeLXbhuNu5G8+Cnp/lDK94i8UKVfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="TCrU3/mm";
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE709606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE709606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TCrU3/mm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168564; x=1826704564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2ogfKDcDzDZAGajZNcvLth4J7bBJT83aPIgKjngeTU=;
  b=TCrU3/mmHKy7+PNQgGA6bfwV7C0A7ZF0k66EL9b41QkFA4dA0oFNgC33
   n0iHhMa9JdoBMkNzfp/IfhMc3fuYoOvwv/ehiGOK0X6rdyJISBpYO//UI
   BCSOsC5Q0/pJf99O98zHiAbyLZ7989M5DtfEU0P93uICFXwH1EW9wwnsN
   1LXjFhwVdS4/tFXgyThS8FWIwCsM0UdGKJ/on8BQr7P74+/Ksgx+cYe5q
   UBYuz+DZzr5J7IxhR8T/Vw/o0psiqMn1dD476OGjHPxhbW9cCIMjz1a9q
   wbfZ7wkTc7Z7HStFiiSINqqVqI8woeKO7zcvZNmwjlsuI1iCTG7QBnP+P
   w==;
X-CSE-ConnectionGUID: 0r7UrHXfQTyBydvd/sm35Q==
X-CSE-MsgGUID: 8qJRuFfJTPa8mZEpmrnwvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4072519"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4072519"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:56:03 -0800
X-CSE-ConnectionGUID: qT2GeUoJQQOczIQFZ1GsLw==
X-CSE-MsgGUID: Pcrd6OHtS0ySVRFeTNNn9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10566989"
Received: from lpankiew-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:56:00 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/i915/psr: Update planes when early transport SU start moves
Date: Fri, 20 Nov 2026 11:55:38 +0200
Message-ID: <20261120095541.1325118-2-jouni.hogander@intel.com>
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

With early transport the plane selective fetch position is relative to
the SU area start. Planes are updated only when their selective fetch
area changes, so a plane keeping its area while the SU start moves is
left with a stale position.

Update planes with a selective fetch area also when the SU start moves
and early transport is in use.

Fixes: b10c83af60cb ("drm/i915/psr: Disable linked plane sel fetch as well")
Cc: Mika Kahola <mika.kahola@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index bd16563603249..2c759f9e81fca 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3114,6 +3114,8 @@ static int psr2_sel_fetch_apply_su_area(struct intel_atomic_state *state,
 					bool full_update)
 {
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
+	const struct intel_crtc_state *old_crtc_state =
+		intel_atomic_get_old_crtc_state(state, crtc);
 	struct intel_plane_state *new_plane_state, *old_plane_state;
 	struct intel_plane *plane;
 	struct drm_rect display_area = {
@@ -3122,6 +3124,7 @@ static int psr2_sel_fetch_apply_su_area(struct intel_atomic_state *state,
 		.x2 = drm_rect_width(&crtc_state->pipe_src),
 		.y2 = drm_rect_height(&crtc_state->pipe_src),
 	};
+	bool et_pos_changed;
 	int i;
 
 	/*
@@ -3133,6 +3136,10 @@ static int psr2_sel_fetch_apply_su_area(struct intel_atomic_state *state,
 	if (full_update)
 		crtc_state->psr2_su_area = display_area;
 
+	/* With early transport the plane position is relative to the SU start. */
+	et_pos_changed = crtc_state->enable_psr2_su_region_et &&
+		crtc_state->psr2_su_area.y1 != old_crtc_state->psr2_su_area.y1;
+
 	/*
 	 * Now that we have the pipe damaged area check if it intersect with
 	 * every plane, if it does set the plane selective fetch area.
@@ -3154,7 +3161,8 @@ static int psr2_sel_fetch_apply_su_area(struct intel_atomic_state *state,
 		}
 
 		if (!drm_rect_equals(&old_plane_state->psr2_sel_fetch_area,
-				     sel_fetch_area))
+				     sel_fetch_area) ||
+		    (et_pos_changed && drm_rect_height(sel_fetch_area) > 0))
 			crtc_state->update_planes |= BIT(plane->id);
 
 		/*
@@ -3177,7 +3185,8 @@ static int psr2_sel_fetch_apply_su_area(struct intel_atomic_state *state,
 			linked_sel_fetch_area->y2 = sel_fetch_area->y2;
 
 			if (!drm_rect_equals(&linked_old_plane_state->psr2_sel_fetch_area,
-					     linked_sel_fetch_area))
+					     linked_sel_fetch_area) ||
+			    (et_pos_changed && drm_rect_height(linked_sel_fetch_area) > 0))
 				crtc_state->update_planes |= BIT(linked->id);
 		}
 	}
-- 
2.53.0

