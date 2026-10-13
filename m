Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA63F5BD6;
	Tue, 13 Oct 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904573; cv=none; b=Y9uHTd/cVTlHLkWJM09bt/db/qGFiuiufaEEDv2Akh6vSW/s7Yq4PQcamo4PnhY6wEhbeXyIOVV0iJkC30IfK3kd3ZHtj2XPpzX/L3l6KirmWHlkkoFz9sGbKI3rNDolAL8Th7NY8v4R+cg9yDPNTpQ/7M6itNuvxakT5wW47SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904573; c=relaxed/simple;
	bh=mK+BqIvO4TiLfSQXIr9kIsyfliszEQqMsnDO8JqFKpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S71/AAuMBTc/2zD0k9oU4CFzkQv5ljBTFogkb6BcFiIewEymUM0aWOnph7q6QCmqAC3NiCwMIYHP9dKgT7DZR08ewjRfi3J7mHvW7Q5bRVPo9v5oXevQJoxJPI+8uFQRIIhUswyUyyqt+PzoPlbXOh2PzFG9zikODpJi668ecDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmYLtZWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmYLtZWt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD253C2BCF4;
	Tue, 13 Oct 2026 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791904572;
	bh=mK+BqIvO4TiLfSQXIr9kIsyfliszEQqMsnDO8JqFKpE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZmYLtZWtZWQro1+dcF7R4dsSMw0tWWGHSCycSn/fQoOLWgXsZ/VUVf8y01baNVmOG
	 eWaKxVonddQ1c7wg5pUy4lIcDziq3vjXlFlMiGQluUBQTkZgwm3K5NA2YPMBsod2Ke
	 F2soUz5wdYMY5YIVWf8SGQ1l11jdpbqAH/F9ro91ODhF56Cjsj4/FsWqIUtgM0zZRA
	 1dGQiVCjS1m5jeD0butVT0jDJsrZiJBBEOsG52/fbZpFM+wqgVQKcGEwN7RPiNYiRE
	 8gWfh7HhtN2viLkzPQ1BdlougJo+q3kwzMxz1Xv9oHC1HHN+2KuDi2H8DHmQTrZrLs
	 WganD5OVdW/DA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C98CC6B12;
	Tue, 13 Oct 2026 15:16:12 +0000 (UTC)
From: Vladyslav Yamkovyi via B4 Relay <devnull+hex.aleph0.ai@kernel.org>
Date: Tue, 13 Oct 2026 17:16:07 +0200
Subject: [PATCH] drm/i915/psr: Send a frame change notification for async
 flips
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-fix-psr-async-trans-push-v1-1-ee79bf31b66f@aleph0.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MwQrCMBBEf6Xs2cUk0hb8FfGQpFsTwRh206KU/
 ruJehreMPM2EOJIAuduA6Y1SnymCvrQgQ823QjjVBmMMoNW+oRzfGEWRivv5LGwTYJ5kYButkP
 fKzMqP0K9Z6a6/aov1x/L4u7kS/O1hbNC6KrBh1ZN/MAS8/GfsO8fv7BJdJ4AAAA=
X-Change-ID: 20261013-fix-psr-async-trans-push-bfa6550270c7
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Jouni_H=C3=B6gander?= <jouni.hogander@intel.com>, 
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Vladyslav Yamkovyi <hex@aleph0.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791904567; l=3338;
 i=hex@aleph0.ai; s=20261013; h=from:subject:message-id;
 bh=6OzSRSOPWRw5dMbojgR3kH8JziugVnnnlVANwZ+FMbg=;
 b=7JBBQ1l0eVLUQse6LiBcfstEJhvVF2lQK3NJy6s5xem1JCwHHrEd+peS8XqwjpYw5M9wbfkFM
 7VyRBgJ/a7iBgLXdBJP/CTV1qHiP4Ok2925QSZ6IpSAU6X35x3fOhuz
X-Developer-Key: i=hex@aleph0.ai; a=ed25519;
 pk=faUPQ+UBdMQ6ZcbVM9ytjGUZvrhV8mzf+ctgaoVsZy0=
X-Endpoint-Received: by B4 Relay for hex@aleph0.ai/20261013 with
 auth_id=1170
X-Original-From: Vladyslav Yamkovyi <hex@aleph0.ai>
Reply-To: hex@aleph0.ai

From: Vladyslav Yamkovyi <hex@aleph0.ai>

On platforms using TRANS_PUSH for PSR frame-change notifications,
intel_pipe_update_end() exits early for asynchronous flips, before sending
the push. The register-based notification is disabled on these platforms,
and an ORIGIN_FLIP frontbuffer flush does not force PSR to exit.

This can leave an accepted async flip without a completion event after
PSR2 enters DEEP_SLEEP. On Panther Lake, scanout freezes and the kernel
reports "[CRTC:152:pipe A] flip_done timed out". Intel IGT kms_async_flips
reproduces the failure with the compositor inactive when a 200 ms idle
interval is inserted before an asynchronous atomic flip.

Send the PSR frame-change notification after plane programming and before
releasing the existing PSR lock. Restrict the push to CRTC states that use
TRANS_PUSH for PSR, leaving other async flips and the synchronous and DSB
paths unchanged.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9582
Fixes: 129a4da11707 ("drm/i915/psr: Use TRANS_PUSH to trigger frame change event")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse smatch
Signed-off-by: Vladyslav Yamkovyi <hex@aleph0.ai>
---
Based on drm-tip (2026-10-13); also applies to v7.3-rc7.

Runtime-tested on Panther Lake (xe, eDP-1, 2880x1800) with Ubuntu-based
7.3.0-rc6 kernels, before and after this fix. IGT kms_async_flips,
async-flip-with-page-flip-events-tiled-atomic, dynamic subtest
pipe-A-eDP-1-4-rc-ccs, fails with Flip Timeout before the fix and passes
afterwards. An LD_PRELOAD interposer inserts one 200 ms idle interval
before the eighth async atomic commit without changing its request or
flags. Both runs enter PSR2 Early Transport DEEP_SLEEP with selective
fetch enabled before that commit.

Clang 23.1.2, W=1 builds and Sparse/Smatch checks of the CRTC, PSR and VRR
translation units for i915 and Xe produced no new diagnostics.

OpenAI Codex (GPT-6-Astra) assisted diagnosis, reproducer and fix
development, validation and patch preparation, following requests to
reproduce the freeze independently, trace its driver cause and prepare a
tested upstream fix. I take direct responsibility for this contribution,
have carefully reviewed the change and ensured rigorous local testing.
---
 drivers/gpu/drm/i915/display/intel_crtc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
index 10ed9bdfee76..8ef24cddbaa6 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc.c
@@ -736,8 +736,16 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
 
 	drm_WARN_ON(display->drm, new_crtc_state->use_dsb);
 
-	if (new_crtc_state->do_async_flip)
+	if (new_crtc_state->do_async_flip) {
+		/*
+		 * LNL+ uses TRANS_PUSH for PSR frame-change notifications.
+		 * Async flips skip the vblank path below, but still need to
+		 * notify PSR after programming the new surface address.
+		 */
+		if (intel_psr_use_trans_push(new_crtc_state))
+			intel_vrr_send_push(NULL, new_crtc_state);
 		goto out;
+	}
 
 	trace_intel_pipe_update_end(crtc, end_vbl_count, scanline_end);
 

---
base-commit: eb1bf4700d3b25a1a1e670ef31cc06969fa08019
change-id: 20261013-fix-psr-async-trans-push-bfa6550270c7


