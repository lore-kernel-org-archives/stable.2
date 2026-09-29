Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08F52D2A7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691170; cv=none; b=JdPXi0HS+jOGQ/7Ecea5s8c/ihmjYfypI+rMc8lLVyi/eGGJtkpBrxIScE0hfE2epIyWY2ItC+wlXgDaQwJqjxwfBc+KPjIjoiCWduSt5fWvp1S6OGMXgh2c4dkBgUi9wAMlwBAzPYeiRYzQQd4dW6hglIj12UqR+wxHXqOHxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691170; c=relaxed/simple;
	bh=nUuAC18pmAttTx9A2b/i6yOleKqeOwOM1lLzIRv23q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEAm2SOzI1DWuFBKF/wOvb+EoqB0JOaAlWeJxRtydap4NZmAW31L+djMqwWNV0OFB29m6vwyIaiDDyWjvsKjFiPLAQ++vAlUCdSPubtg1jdydOlCa8bpM2DnWGCNLdX7JZ2QB9M342GmQ4oJc/ZA7p+mFaE2eWQiUKnIknmBPP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFtUOILQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFtUOILQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193C01F00893;
	Tue, 29 Sep 2026 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691168;
	bh=aPQv964mKll7EcrKaCw6DMKjj/Y3s9avDYHFMKOgf0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XFtUOILQPgGAYoh4zMLkphv4q7ll4u22hffv8kwfsF/5KIdutJWuynbsSwUfVVL6P
	 s1VgZ9wr7Wl9u6Pi0Jt2LiaCuJ8vcbdS1WOysH3ucaOkjKaE0tl8VKxJdD08/0Jtxe
	 j3+vGc2j3jsNWX/GyKj7BLyy6pQBzW2U6GN2afgSgkZ4Pj/LjDMflx7/0PmmIxpAs4
	 fFd1AyDnZ/5uHUIqOujCdx9BBIhw52SOD/eoubQ4bYwkcgflhKafPdnC8bi3IaIKpA
	 hQGJVaf+JGj5PRJAJAZuWJYx+IrPfbpPZYEjKvZ8jxY95/XcBzKZZl4eUywgMDzkfG
	 B2/RH32P6cwBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] drm/i915/psr: Fixes for Dell XPS DA14260 quirk
Date: Tue, 29 Sep 2026 10:12:43 -0400
Message-ID: <20260929141245.3537826-2-sashal@kernel.org>
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

[ Upstream commit 1de647abdfda9dc307503d0a85152161850ba52c ]

Dell seems to be changing device ID even within same device model. Due to
this we need to ignore device ID when applying quirk for Dell XPS 14
DA14260. Do this by adding DEVICE_ID_ANY and assign it to Dell XPS 14
DA14260 quirk. Also apply the quirk only for eDP Panel Replay.

Fixes: 45c77d4bf8d4 ("drm/i915/psr: Disable Panel Replay on Dell XPS 14 DA14260 as a quirk")
Cc: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260320080403.1396926-1-jouni.hogander@intel.com
Stable-dep-of: 5271d81f99dd ("drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c    |  3 ++-
 drivers/gpu/drm/i915/display/intel_quirks.c | 16 ++++++++++------
 drivers/gpu/drm/i915/display/intel_quirks.h |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 8c95e6dc8e4f4..3088230fef8b6 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -593,7 +593,8 @@ static void _panel_replay_init_dpcd(struct intel_dp *intel_dp)
 	if (intel_dp->mst_detect == DRM_DP_MST)
 		return;
 
-	if (intel_has_dpcd_quirk(intel_dp, QUIRK_DISABLE_PANEL_REPLAY)) {
+	if (intel_dp_is_edp(intel_dp) &&
+	    intel_has_dpcd_quirk(intel_dp, QUIRK_DISABLE_EDP_PANEL_REPLAY)) {
 		drm_dbg_kms(display->drm,
 			    "Panel Replay support not currently available for this setup\n");
 		return;
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 8f1bf8f418ec7..883f297d4b837 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -86,11 +86,11 @@ static void quirk_edp_limit_rate_hbr2(struct intel_display *display)
 	drm_info(display->drm, "Applying eDP Limit rate to HBR2 quirk\n");
 }
 
-static void quirk_disable_panel_replay(struct intel_dp *intel_dp)
+static void quirk_disable_edp_panel_replay(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 
-	intel_set_dpcd_quirk(intel_dp, QUIRK_DISABLE_PANEL_REPLAY);
+	intel_set_dpcd_quirk(intel_dp, QUIRK_DISABLE_EDP_PANEL_REPLAY);
 	drm_info(display->drm, "Applying disable Panel Replay quirk\n");
 }
 
@@ -116,6 +116,8 @@ struct intel_dpcd_quirk {
 
 #define SINK_DEVICE_ID_ANY	SINK_DEVICE_ID(0, 0, 0, 0, 0, 0)
 
+#define DEVICE_ID_ANY		0
+
 /* For systems that don't have a meaningful PCI subdevice/subvendor ID */
 struct intel_dmi_quirk {
 	void (*hook)(struct intel_display *display);
@@ -261,11 +263,11 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
 	},
 	/* Dell XPS 14 DA14260 */
 	{
-		.device = 0xb080,
+		.device = DEVICE_ID_ANY,
 		.subsystem_vendor = 0x1028,
 		.subsystem_device = 0x0db9,
 		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
-		.hook = quirk_disable_panel_replay,
+		.hook = quirk_disable_edp_panel_replay,
 	},
 };
 
@@ -277,7 +279,8 @@ void intel_init_quirks(struct intel_display *display)
 	for (i = 0; i < ARRAY_SIZE(intel_quirks); i++) {
 		struct intel_quirk *q = &intel_quirks[i];
 
-		if (d->device == q->device &&
+		if ((d->device == q->device ||
+		     q->device == DEVICE_ID_ANY) &&
 		    (d->subsystem_vendor == q->subsystem_vendor ||
 		     q->subsystem_vendor == PCI_ANY_ID) &&
 		    (d->subsystem_device == q->subsystem_device ||
@@ -300,7 +303,8 @@ void intel_init_dpcd_quirks(struct intel_dp *intel_dp,
 	for (i = 0; i < ARRAY_SIZE(intel_dpcd_quirks); i++) {
 		const struct intel_dpcd_quirk *q = &intel_dpcd_quirks[i];
 
-		if (d->device == q->device &&
+		if ((d->device == q->device ||
+		     q->device == DEVICE_ID_ANY) &&
 		    (d->subsystem_vendor == q->subsystem_vendor ||
 		     q->subsystem_vendor == PCI_ANY_ID) &&
 		    (d->subsystem_device == q->subsystem_device ||
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 77e490caed0d8..83214eb94b0c4 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -21,7 +21,7 @@ enum intel_quirk_id {
 	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
 	QUIRK_FW_SYNC_LEN,
 	QUIRK_EDP_LIMIT_RATE_HBR2,
-	QUIRK_DISABLE_PANEL_REPLAY,
+	QUIRK_DISABLE_EDP_PANEL_REPLAY,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.53.0

