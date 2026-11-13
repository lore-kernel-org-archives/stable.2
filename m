Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597715;
	b=OxitjFghHTiDbaLVvMZn3mSLw1etsS/k1vWXhHRNCFj2pXw4v87usf7dDdjJwsX2dQC5
	 hjtrwo7QdnVWydU4f16del0ZNf5M4QF8ltcbWLdm9M/qZWyA9GWVXqmdBrbY03XqOFwmB
	 SQtgwbJGfEIbPzUqyORafWm7Wy9Yf2T/X4jiIR1tiFOkZn5shoYO+C+oAEa7G1phJyJQw
	 /n87+IzfSlsezoZRDCyXzeZrMpE6UloTL0NGlh6slXD4mWEpO+JnRdWOQhVJ9b4KJCraw
	 QWnrKRiYJlSWwpnYbB197vTc3kKQ9U/eoXekuYy5zhLLxBkXTafG31aFTU+XM+kWe0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597715;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aF8KuXDpon6rUszD6voHdChDjD4FNUOlv7nF/G/VfP4=;
	b=IZ5Oo+E5+z3NfjYUnhMEoR0+7jjkgDS+7JWMjiK4PBavpuTARkU3sdzg2Mdr8ifmajVc
	 6ZFdVnZ+2t89H8vzSLSBMs8RHr68UA+55+eKVhVd8CU3nkKG+iIuOp4bxX7CPJDTgh2cc
	 a6twKzT2UIyegWLtzMrooy80k2B49rzj945433zb8BA1oLcOKEPxI0enklWj9ZD/a0Hp9
	 FTQqfhDL7a3irLdFSH6syGqjZykiMgxH7G33itrfvnP4OM/QEPimY2rEgT9vlIHoYmg9r
	 aaCnTbDz0atj/vTOAgMVn7mEvFTpUBaduY+WZbrOCIqxFvd7JlFqzvOtTSoki9ME6XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/4Cq6Xv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD8606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/4Cq6Xv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B451F000C4;
	Fri, 13 Nov 2026 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597715;
	bh=aF8KuXDpon6rUszD6voHdChDjD4FNUOlv7nF/G/VfP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/4Cq6XvszyPd45w3mmfSVQ3ZtgImL8Nt6Tz8MCepAqU0qex/kRGxfOCi4uNMBxed
	 ozcqCTpAb6KcEBjT0S3wvShLlDd6Ta8S3pgvtggixNfdng70+03/7jbXe+bSkV4sFv
	 sNZtCa1/iuy6Q4CacNWc42D+13tBl9shmITIzlMYehNlBA5gXHUfpljgKSAxBq2VEU
	 Srg4AmxvyrdapwVU7YsyuqHxdPyqZLtHNknKdovrvmrruMWte3eTkLL1e3Zpr1EB+n
	 5O3CClM25dbE9LtDXxDF5H3WKK0Qljxy9l6ROSedMFnhBz018dhAxUX0qytl2PHLQR
	 +UDlYkDKqaECw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/i915/psr: Clear selective fetch area when duplicating plane state
Date: Fri, 13 Nov 2026 14:21:53 -0500
Message-ID: <20261113192113.2256994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201100-failed-6.6-cbe565475988@kernel.org>
References: <20261109201100-failed-6.6-cbe565475988@kernel.org>
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

[ Upstream commit cbe565475988d3b22dc36f13c14d9f0eec1685cd ]

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
[ sashal: Used the existing pipe_clip rectangle instead of crtc_state->psr2_su_area. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_atomic_plane.c | 1 +
 drivers/gpu/drm/i915/display/intel_psr.c          | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 60a492e186ab8..2513e2bfe1be4 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -110,6 +110,7 @@ intel_plane_duplicate_state(struct drm_plane *plane)
 	intel_state->ggtt_vma = NULL;
 	intel_state->dpt_vma = NULL;
 	intel_state->flags = 0;
+	intel_state->psr2_sel_fetch_area = DRM_RECT_INIT(0, 0, 0, 0);
 
 	/* add reference to fb */
 	if (intel_state->hw.fb)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 416686a6566ba..107172e630aae 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2050,7 +2050,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 	if (!psr2_sel_fetch_pipe_state_supported(crtc_state)) {
 		full_update = true;
-		goto skip_sel_fetch_set_loop;
+		goto skip_su_area_calc;
 	}
 
 	/*
@@ -2136,7 +2136,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	}
 
 	if (full_update)
-		goto skip_sel_fetch_set_loop;
+		goto skip_su_area_calc;
 
 	/* Wa_14014971492 */
 	if ((IS_MTL_DISPLAY_STEP(dev_priv, STEP_A0, STEP_B0) ||
@@ -2150,6 +2150,10 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 	intel_psr2_sel_fetch_pipe_alignment(crtc_state, &pipe_clip);
 
+skip_su_area_calc:
+	if (full_update)
+		clip_area_update(&pipe_clip, &display_area, &display_area);
+
 	/*
 	 * Now that we have the pipe damaged area check if it intersect with
 	 * every plane, if it does set the plane selective fetch area.
@@ -2196,7 +2200,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		}
 	}
 
-skip_sel_fetch_set_loop:
 	psr2_man_trk_ctl_calc(crtc_state, &pipe_clip, full_update);
 	return 0;
 }
-- 
2.53.0

