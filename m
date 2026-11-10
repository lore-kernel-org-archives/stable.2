Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273062;
	b=QDpfZy+9nbCWciodqV8ZZpaA9Rpfjr3ceJYjWgxCDRvoWiJeyGki4KNywVs6YQn2UjDA
	 71ZH7Qx/UD96NXeuPIabCAEHhrxIYC9X5nrf73CFMWuUG21v8A0z1XUgBDlopVsBqc/oQ
	 1/N7Kbkm9pgn4y04rYQaSDa8wYIjl8NNNasvFZfp/G0/32O9TdncahdIvjYDc00UpZTeT
	 c64197NQkIrZ9/vnK9u4UcFG7lioXV+MWJKg4A59Ny6odDAZGX/idodVoqOjyiRDsUr4J
	 mdKNVbHU+P6NupB8rENgg2FYqOh04dM+cPS096DGZTRABkqk6v5jVx6qYmG13m2fjGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Hr68yF+Kj7+Gz3XGY2oBOOA7B8NtE9n/Vy1q4BYF1g8=;
	b=fZrfHE48+y+x5cYjYvnRgU4xoih7trr1OETP1nYeBYEx61KOQvc8eb99NG4LLAizrhci
	 eGsbA5Ix6mjuQi2ooiVy2jvw0Hujlk4890jgchEC7et32A9cl3q0Lh+9AIoZiUfefudBe
	 kQ6MLrFeJ+wK6kLFWFFakcqq5FaBkJxnKKlvo1vsajPxWmZArQR2F3KptzmHSg1lFcUUW
	 LR/BRGZ3tJhA/jUQ0Uxbm9adBCzNdRs0zX1Z1ldmvF/GCLvB13zIp/+N+iGgHo8ISFDGH
	 5zUcHFVbDq85j8vLGVVUKEhmWXuDiObbGpNoJZwP1R6E08Fk0HcTjJ3isTUCaebFJ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InmUKhGP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECB606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InmUKhGP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F65E1F0089F;
	Tue, 10 Nov 2026 01:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273061;
	bh=Hr68yF+Kj7+Gz3XGY2oBOOA7B8NtE9n/Vy1q4BYF1g8=;
	h=From:To:Cc:Subject:Date;
	b=InmUKhGPHkYAvOQkVKd4TWjKUGwfPy5zEY1izGZ9akKnaH5lj/UvR11Tr/+cpUNna
	 2CML5ec5aet2LOcFvCZ8x15W41ol9oZYCLcoTBQvI6rfT9ANaPzWI+RGpJrPBvlB5M
	 hgQ5hxtgnoAq8Fnr0Cid8f5V01uOSTfTxoNQiLwqRBgxfRBXUeOHCQQIUJTpWAwN0y
	 E6gsOU82pg4+WL8+r+lWQbTa/3X9pndf6qUaEgH+i5zKKqPBoXUVKQQ67PrUcpDd82
	 YQIraZ6P9NvRgvCOj3vLDjZcifwIFMdRrQWXlIokJnGFsU+BExtUZfC1HMF1LWcD14
	 8O5kIUcDu7MoA==
From: Sasha Levin <sashal@kernel.org>
To: jouni.hogander@intel.com,
	mika.kahola@intel.com,
	joonas.lahtinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/psr: Clear selective fetch area when duplicating plane state" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:00 -0500
Message-ID: <20261109201100-failed-6.6-cbe565475988@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cbe565475988d3b22dc36f13c14d9f0eec1685cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201100-failed-6.6-cbe565475988@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cbe565475988d3b22dc36f13c14d9f0eec1685cd Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Tue, 29 Sep 2026 12:44:27 +0300
Subject: [PATCH] drm/i915/psr: Clear selective fetch area when duplicating
 plane state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are currently not clearing selective fetch area when duplicating plane
state. This is causing problem when plane is re-used for another
purpose. Fix this by clearing selective fetch area when duplicating plane
state.

Now as the state is cleared we need to ensure we have consistent selective
fetch area in plane state on full update. Earlier this was relying on
selective fetch area being copied from old state on state duplicate. Now
this isn't true anymore as we are clearing it. Tackle this by setting full
plane area as selective fetch area for each plane on full update. Rename
the label as skip_su_area_calc as the loop setting the plane selective
fetch area is not skipped anymore.

Move also psr2_sel_fetch_pipe_state_supported check after psr2_su_area
initialization. The loop is run on full update as well now and it needs
initialized psr2_su_area. Clip_area_update is only touching rect height and
x1/x2 are left untouched.

Don't set the area at all for planes not intersecting with the selective
update area. It is already zero sized after plane state duplicate.

Fixes: efab47658a6c ("drm/i915/display/psr: Calculate selective fetch plane registers")
Cc: <stable@vger.kernel.org> # v5.12+
Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260929094434.77129-2-jouni.hogander@intel.com
(cherry picked from commit bd58f0e221386808cd614bb205112e807dc6b159)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_plane.c |  1 +
 drivers/gpu/drm/i915/display/intel_psr.c   | 24 ++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index 25ca049009efb..f908eabe604bb 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -140,6 +140,7 @@ intel_plane_duplicate_state(struct drm_plane *plane)
 	intel_state->dpt_vma = NULL;
 	intel_state->fence_id = -1;
 	intel_state->damage = DRM_RECT_INIT(0, 0, 0, 0);
+	intel_state->psr2_sel_fetch_area = DRM_RECT_INIT(0, 0, 0, 0);
 
 	/* add reference to fb */
 	if (intel_state->hw.fb)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 00d0146b26002..e58a4ac2e06aa 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2923,16 +2923,16 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	if (!crtc_state->enable_psr2_sel_fetch)
 		return 0;
 
-	if (!psr2_sel_fetch_pipe_state_supported(crtc_state)) {
-		full_update = true;
-		goto skip_sel_fetch_set_loop;
-	}
-
 	crtc_state->psr2_su_area.x1 = 0;
 	crtc_state->psr2_su_area.y1 = -1;
 	crtc_state->psr2_su_area.x2 = drm_rect_width(&display_area);
 	crtc_state->psr2_su_area.y2 = -1;
 
+	if (!psr2_sel_fetch_pipe_state_supported(crtc_state)) {
+		full_update = true;
+		goto skip_su_area_calc;
+	}
+
 	/*
 	 * Calculate minimal selective fetch area of each plane and calculate
 	 * the pipe damaged area.
@@ -3016,7 +3016,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	}
 
 	if (full_update)
-		goto skip_sel_fetch_set_loop;
+		goto skip_su_area_calc;
 
 	intel_psr_apply_su_area_workarounds(crtc_state);
 
@@ -3052,6 +3052,11 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 			break;
 	} while (su_area_changed);
 
+skip_su_area_calc:
+	if (full_update)
+		clip_area_update(&crtc_state->psr2_su_area, &display_area,
+				 &display_area);
+
 	/*
 	 * Now that we have the pipe damaged area check if it intersect with
 	 * every plane, if it does set the plane selective fetch area.
@@ -3068,8 +3073,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		inter = crtc_state->psr2_su_area;
 		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
 		if (!drm_rect_intersect(&inter, &new_plane_state->uapi.dst)) {
-			sel_fetch_area->y1 = -1;
-			sel_fetch_area->y2 = -1;
 			/*
 			 * if plane sel fetch was previously enabled ->
 			 * disable it
@@ -3109,11 +3112,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		}
 	}
 
-skip_sel_fetch_set_loop:
-	if (full_update)
-		clip_area_update(&crtc_state->psr2_su_area, &display_area,
-				 &display_area);
-
 	psr2_man_trk_ctl_calc(crtc_state, full_update);
 	crtc_state->pipe_srcsz_early_tpt =
 		psr2_pipe_srcsz_early_tpt_calc(crtc_state, full_update);
-- 
2.53.0




