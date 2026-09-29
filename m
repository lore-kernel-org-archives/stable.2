Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A64F4043
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691171; cv=none; b=EIVn7EPY1O/nP4hpOOOPNXHYVdO2FiHS4+yVwYgdHmEyo+2PMgsPTvqxuhbwuPCyp+PdDuuK4GjxXdmoFw5SdkofznMOCJIPjooZb6vy0ZdMbnASm57JEHrxZu3fx51mCjvCpZqi+tqQ0eEKnf06vqwsnWgGyuu/qB1JzUzbK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691171; c=relaxed/simple;
	bh=HzyWLq8qgM0vVfKCyeN3wacDLsBacUAQnZqB0lHMnB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJ5fDxswVBLukwiuauzGJ2SPaLZ/3h6q7lJ8em+YdXF+RQxqrWHcotc0GNDdvFcxBmjYN9EVdyosP0swVwzxPdzfBnoufcLfalH6zy5Lkp1EJmx8Hr0Uu41Zvs/SY7zMzS6kaxt2NAwQJLweu5spBTre7brGVf4WHMWgQuXUwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyiBnHYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyiBnHYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64291F00898;
	Tue, 29 Sep 2026 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691169;
	bh=13D1/xyxgNUT/yRV53sJ2cuh4nsOe5x1ykx6G85Ju3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fyiBnHYhXWgU4yKlrM3JhP0sczy7l3rn/KLdNFIHfSolWB3sg1PBt72TrvcPAgzBs
	 MJg+WhXIyYvtClOm/3Uk0dHtC6tlgrXTOpy3YsWiSIHwloS6kCNGnaY6S60mN/AgJt
	 8dX4IZo30Bj4UAT48tbIKLaHhlwtRYbNh9JBv4wabhl3zeiNf0y5GH/YTJYzBr5V+L
	 JpYROsC337Om/dPtWPt2669OiSkXQruNDpWamrDvh03P1PciSQ1I5gWNab52rrFnRk
	 HJo2svQm7OdUagARHE5KZf2ILIVY/XFdMRFEkElKf/igxxFBCG+2CojZ2fbC+go6JT
	 5KBuGGpwzZNlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] drm/i915/psr: Disable PSR2 on Xiaomi Book Pro 14 2026 as a quirk
Date: Tue, 29 Sep 2026 10:12:44 -0400
Message-ID: <20260929141245.3537826-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929141245.3537826-1-sashal@kernel.org>
References: <2026092942-evaluator-keenness-e26b@gregkh>
 <20260929141245.3537826-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 5e79af5db00b2a5f4667aaf16cfe4ecb7759383b ]

Add new quirk (QUIRK_DISABLE_PSR2) for disabling PSR2 as a quirk for
problematic setups. Apply this newly added quirk on Xiaomi Book Pro 14
2026.

v2: logging adjusted

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7677
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260417102350.28328-1-jouni.hogander@intel.com
Stable-dep-of: 5271d81f99dd ("drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c    | 3 +++
 drivers/gpu/drm/i915/display/intel_quirks.c | 9 +++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h | 1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 3088230fef8b6..b6c5dbe259648 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -668,6 +668,9 @@ static void _psr_init_dpcd(struct intel_dp *intel_dp)
 	intel_dp->psr.sink_sync_latency =
 		intel_dp_get_sink_sync_latency(intel_dp);
 
+	if (intel_has_quirk(display, QUIRK_DISABLE_PSR2))
+		return;
+
 	if (DISPLAY_VER(display) >= 9 &&
 	    intel_dp->psr_dpcd[0] >= DP_PSR2_WITH_Y_COORD_IS_SUPPORTED) {
 		bool y_req = intel_dp->psr_dpcd[1] &
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 883f297d4b837..d1c428eeb6083 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -94,6 +94,12 @@ static void quirk_disable_edp_panel_replay(struct intel_dp *intel_dp)
 	drm_info(display->drm, "Applying disable Panel Replay quirk\n");
 }
 
+static void quirk_disable_psr2(struct intel_display *display)
+{
+	intel_set_quirk(display, QUIRK_DISABLE_PSR2);
+	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -250,6 +256,9 @@ static struct intel_quirk intel_quirks[] = {
 
 	/* Dell XPS 13 7390 2-in-1 */
 	{ 0x8a52, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
+
+	/* Xiaomi Book Pro 14 2026 */
+	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
 };
 
 static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 83214eb94b0c4..970a4fe52fafc 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -22,6 +22,7 @@ enum intel_quirk_id {
 	QUIRK_FW_SYNC_LEN,
 	QUIRK_EDP_LIMIT_RATE_HBR2,
 	QUIRK_DISABLE_EDP_PANEL_REPLAY,
+	QUIRK_DISABLE_PSR2,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.53.0

