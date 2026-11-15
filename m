Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794705530;
	b=QnnIYTwL6qF4/pudCPdNd/rxfY4WsSESqeS6P47LiLePgu3/VyWerTCYSpyGiP5hi0rr
	 tV0Yq1A/hQF7Jx8NWB9xsHPmsL1B36GefvL/mnY4rcfl6uVyBFv/LPnmc+ZaaA1j5/IX7
	 80LSYwkX9xgAzBDZ9SW4ARhKaQiv+DZymDh0/f4zOnNI4Z5Mbd6KJq4s+SUrfmXJarzuQ
	 i4Nya7WO+il4SO0EE+yIzmNJQf5Z6bDFvsJu+pTtVLLYssnDmp0X2eecz64wyyokNRlJF
	 Y/ixv0lPAg1OHpKDMt776IxHYIeJKD7WrGV+WEV5QcDWcaDUJiS2nGmJZglMFAduTIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z3CPdADV6moy4vZas20KVEa0m6bNzbLyLGpoL86eqQs=;
	b=RtI55guGWbBYgCt1neyRK8l3rQax5b2qybvRNpm3vuVOfAFBtF2ipQN5q2vZ1I9EtzI4
	 XxcmQgvdHH5w5w9kUjVXFBSklbH10+d2QkUPK4qQxPyRuVSiRlyiL8nPRui7iDcetlNlz
	 h3jrnNAq3n6/SgqqiIVSnr+UgG45CHEGMGyPCz50LyW65nYUxgVJG5oosJHYwG30BBn+6
	 MS0V3dL69qT0aSJBA4gteN6VXrOOGNep7JR2Ce4oZXUSUlt5v3ptpnLhfqNDPf4QA50Rz
	 kqX+SFoaQO9PaPzPfyihy0KxFWRsrCMv12Pj6RO04sGLnCK+aZ5tDeDd1FsaSEVi4Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw+r0qHE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073F606A32D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw+r0qHE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4071F000C5;
	Sun, 15 Nov 2026 01:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794705529;
	bh=Z3CPdADV6moy4vZas20KVEa0m6bNzbLyLGpoL86eqQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pw+r0qHEPYkZcHcIecOsMXYXPaB79h1JCRAHe/Z9+JT4VxKYyCM0ajoKJbYNU5gOp
	 7S5EVqEyr5rCrlBUyrZJczagQZdnYsD8/iC9mgkLiUcONgB3JnuPaVul6XK5vdy/mv
	 p7p1mSW4KgsF2yxruVRp61nekczsoYUCO6Nzz2x65yZ32ZIanSIiK0Naq4Jd8bwTfu
	 wf53hOXVuPWIug71na87TIb+y4xvDgz0o3PU1eJvXlw6da+9bbMgepDxW3DsPHXxO+
	 JeHGkhiPcVlRVlvIZbJgq40Jz1nfwrb1MIX2N4lHzOC9NjSMnYAn7metyThcW8Pw9s
	 8BwGNkT/q1jXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/i915/display: Add enabled pipe planes into state for selective fetch
Date: Sat, 14 Nov 2026 20:18:48 -0500
Message-ID: <20261115011437.621430-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201102-failed-6.6-94cb1f08b197@kernel.org>
References: <20261109201102-failed-6.6-94cb1f08b197@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 94cb1f08b197d9ae932ff98c741bd0dbc96e17e8 ]

Selective fetch support for biplanar formats relies on linking of UV and
the Y planes. Planes that are not part of the atomic state are pulled in by
the drm_atomic_add_affected_planes. If the UV plane is added into the state
by drm_atomic_add_affected_planes in the selective fetch calculation, the
linking isn't done anymore and the Y plane is left disabled.

Fix this by adding affected planes already in intel_add_affected_planes if
selective fetch is enabled.

Remove redundant drm_atomic_add_affected_planes from
intel_psr2_sel_fetch_update and redundant check for plane selective fetch
support that is not needed as all planes are already in atomic state on
first loop iterating them. Also switch to intel_atomic_get_new_plane_state
for linked plane new plane state.

Fixes: 3809991ff5f4 ("drm/i915/display: Add initial selective fetch support for biplanar formats")
Cc: <stable@vger.kernel.org> # v5.17+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260929094434.77129-3-jouni.hogander@intel.com
(cherry picked from commit 0d173898b11157d37de3e5f01ef28a48582167d8)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
[ sashal: adapted early plane collection to intel_atomic_check_planes() using the existing intel_atomic_add_affected_planes() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c | 12 ++++++++++++
 drivers/gpu/drm/i915/display/intel_psr.c     | 17 ++++-------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 28d132c238d19..f8c3cba3ca620 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5672,6 +5672,18 @@ static int intel_atomic_check_planes(struct intel_atomic_state *state)
 	struct intel_crtc *crtc;
 	int i, ret;
 
+	for_each_new_intel_crtc_in_state(state, crtc, new_crtc_state, i) {
+		/*
+		 * Add affected plane here to ensure UV and Y plane linking is
+		 * in place if UV plane is added as a part of selective update.
+		 */
+		if (new_crtc_state->enable_psr2_sel_fetch) {
+			ret = intel_atomic_add_affected_planes(state, crtc);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ret = icl_add_linked_planes(state);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 416686a6566ba..aba5ce55eeba4 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2043,7 +2043,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		.y2 = crtc_state->hw.adjusted_mode.crtc_vdisplay,
 	};
 	bool full_update = false;
-	int i, ret;
+	int i;
 
 	if (!crtc_state->enable_psr2_sel_fetch)
 		return 0;
@@ -2144,10 +2144,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	    crtc_state->splitter.enable)
 		pipe_clip.y1 = 0;
 
-	ret = drm_atomic_add_affected_planes(&state->base, &crtc->base);
-	if (ret)
-		return ret;
-
 	intel_psr2_sel_fetch_pipe_alignment(crtc_state, &pipe_clip);
 
 	/*
@@ -2167,11 +2163,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		if (!drm_rect_intersect(&inter, &new_plane_state->uapi.dst))
 			continue;
 
-		if (!psr2_sel_fetch_plane_state_supported(new_plane_state)) {
-			full_update = true;
-			break;
-		}
-
 		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
 		sel_fetch_area->y1 = inter.y1 - new_plane_state->uapi.dst.y1;
 		sel_fetch_area->y2 = inter.y2 - new_plane_state->uapi.dst.y1;
@@ -2185,9 +2176,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 			struct intel_plane_state *linked_new_plane_state;
 			struct drm_rect *linked_sel_fetch_area;
 
-			linked_new_plane_state = intel_atomic_get_plane_state(state, linked);
-			if (IS_ERR(linked_new_plane_state))
-				return PTR_ERR(linked_new_plane_state);
+			linked_new_plane_state = intel_atomic_get_new_plane_state(state, linked);
+			if (!linked_new_plane_state)
+				return -EINVAL;
 
 			linked_sel_fetch_area = &linked_new_plane_state->psr2_sel_fetch_area;
 			linked_sel_fetch_area->y1 = sel_fetch_area->y1;
-- 
2.53.0

