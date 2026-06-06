Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746571917CD
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712323; cv=none; b=Z2EuSSdIoez4VrYmdjEDaee0KhAJphbP7hHmxmwTGy5Pl66+Oo2LdwpqXw/ay6gAfqNwdgGdU0E7vtE6QY/sM2ZeV2/wjtUw9xDTZft+NzVmgo/Rd0x5T6AQ/Zs985pFsq0QnzIwHNerbQDaDG59Vv1wzCjPr2LAki8iPoSGZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712323; c=relaxed/simple;
	bh=jof9rg/MET7H9gA27gYj57Bp+y+20LxToxkAKXUK5vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyZnla9DU4hB9zv9urDc5ZGA7nFr3Mf0m8ek3KOBtrB3AGg3WL+56StjpKkkQ4Ao4NKyLbOc1rPY3cCu9S0yBRXy+KUL2ZE5wnMYiuXEPfh/CqOwPEZbs+C/woeqHDCs5ow3RJ0mWNoLhbwjq5eYjek7jbyKcSAmJ55S4DCJR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7LL+Byi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7LL+Byi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BA91F00893;
	Sat,  6 Jun 2026 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712322;
	bh=cK7MhMr6JOCesZbg5kOH1CXWLCsStMbrQwqzPR5YfAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7LL+ByissjvAML+34KlrS2wGlUqECoJiLS6szBqevbnpfXgSTkBy4i/V91rLt88z
	 DoGs9ElgP6xtfQ2g1N6v9azHLIH1vN+tZrz8DJGhYJbmCiE9WHI01elQr+1VL64iz2
	 RhhMTVbk7U+0xlxXBSy4hYQfvvrLn5avX4RLtSZQBg3NEXLpfrk/MKR+ebCbkdfooG
	 hUf7ti56e8MacZpk5QuLBlrQkNtvhduwEhjzosXrDvFt62w+b8V1nTmyWehMgXyrzZ
	 9QkuGaV7XvdRV+Tcq/72mQScJcwQkdK52KUL8a68/946dkkGQfEc+0RkBDPKAh24au
	 8ve0ENu5GevzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/i915/psr: Block DC states on vblank enable when Panel Replay supported
Date: Fri,  5 Jun 2026 22:18:38 -0400
Message-ID: <20260606021839.2487627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060434-tattoo-wise-091f@gregkh>
References: <2026060434-tattoo-wise-091f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 8bb9093df555f9e89fdbe1405118b11384c03e04 ]

Currently we are blocking DC states only when Panel Replay is enabled on
vblank enable. It may happen that Panel Replay is getting enabled when
vblank is already enabled. Fix this by blocking DC states always if Panel
Replay is supported.

While at it take care of possible dual eDP case by looping all encoders
supporting PSR.

Fixes: 0c427ac78a1d ("drm/i915/psr: Add interface to notify PSR of vblank enable/disable")
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>
Link: https://patch.msgid.link/20260520104944.239797-1-jouni.hogander@intel.com
(cherry picked from commit eb5911f990554f7ce947dd53df00c114362e4465)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Stable-dep-of: 3549a9649dc7 ("drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 1da20065ea7763..138717cf664529 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3949,32 +3949,33 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 					    bool enable)
 {
 	struct intel_encoder *encoder;
+	bool block_dc_states = false;
 
 	for_each_intel_encoder_with_psr(display->drm, encoder) {
 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 
 		mutex_lock(&intel_dp->psr.lock);
-		if (intel_dp->psr.panel_replay_enabled) {
-			mutex_unlock(&intel_dp->psr.lock);
-			break;
-		}
+		if (CAN_PANEL_REPLAY(intel_dp))
+			block_dc_states = true;
 
-		if (intel_dp->psr.enabled && intel_dp->psr.pkg_c_latency_used)
+		if (intel_dp->psr.enabled && !intel_dp->psr.panel_replay_enabled &&
+		    intel_dp->psr.pkg_c_latency_used)
 			intel_psr_apply_underrun_on_idle_wa_locked(intel_dp);
 
 		mutex_unlock(&intel_dp->psr.lock);
-		return;
 	}
 
 	/*
 	 * NOTE: intel_display_power_set_target_dc_state is used
-	 * only by PSR * code for DC3CO handling. DC3CO target
+	 * only by PSR code for DC3CO handling. DC3CO target
 	 * state is currently disabled in * PSR code. If DC3CO
 	 * is taken into use we need take that into account here
 	 * as well.
 	 */
-	intel_display_power_set_target_dc_state(display, enable ? DC_STATE_DISABLE :
-						DC_STATE_EN_UPTO_DC6);
+	if (block_dc_states)
+		intel_display_power_set_target_dc_state(display, enable ?
+							DC_STATE_DISABLE :
+							DC_STATE_EN_UPTO_DC6);
 }
 
 static void
-- 
2.53.0

