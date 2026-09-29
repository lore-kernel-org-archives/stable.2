Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0B52842D
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691169; cv=none; b=imrqFNsPN0vrvMfeBqAI4WyAcpsc7p5Ik7dTHPYh3zqHrIkr50CmpCvPVUK4Za5eVWJuw3BYpa0hYULBh5rA4bnDoqEvADzpq936L/DCq3JM/30Oe+KEPyVPK49Y9jWY4H8NRn4oOLDkNmMmsfnJn2A4RbrQjR08Ts655WBaJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691169; c=relaxed/simple;
	bh=MW0IhFbOc62YIEcl1wzGETfd+jEmZvrbQeU7MJiuESk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKdw/DvOsY57IDd4XAWZ0jdP4CSDv8JD8TCO8AXLbMCmR9TmTXVhTFTfDmkO/JFX83vUhk/+PnR6oUe7PgVEiZu8cpU/HdLM85N5Ea9n1mfmvsrRz5R7Ia69K0OMeNljCBFkxnvE9Uyo3/OwJE5yFLZgThryYL73KrYtRsdp9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A26KwE9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A26KwE9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B51D1F000FF;
	Tue, 29 Sep 2026 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691167;
	bh=9egzJSsuBZ2JlsXnwJ4dDTin5OdzGVxaMfPzcfAavY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A26KwE9NAniZ46NvNUcptEe56rsK2iMsOONd2TcDeVoTHLcBcaWhMxeDBEVXr+BKq
	 WDT2/Jpq75LfdkliVjzAytTod4V8ZtBOCOXIJFuC3ReBxwtPHJ+ieNy3qbD0xiAPOB
	 atdClR1Fd4gAhgU1ICmHwSuQNYF1girrDvK9O5oh+6DjHqGrsoZVVKhIEvK6TlHpHg
	 UYAJOGh0pVOP6SqPfZ+EO28C3LhsQx6Auw5F9HoR1moPmwYnljZ+4YNhugXQvTfq5l
	 s4Im2zmdoBHw5dOylPvNQ5oz000iz/VzwbsfOn3rfNwfOMbB/gpb1BKHv1T3xXoF6M
	 EVAtcWBEurqzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] drm/i915/psr: Disable Panel Replay on Dell XPS 14 DA14260 as a quirk
Date: Tue, 29 Sep 2026 10:12:42 -0400
Message-ID: <20260929141245.3537826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092942-evaluator-keenness-e26b@gregkh>
References: <2026092942-evaluator-keenness-e26b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 45c77d4bf8d4d15453d709b9b828e498898e0751 ]

Add new quirk (QUIRK_DISABLE_PANEL_REPLAY) for disabling Panel Replay as
quirk for problematic setups. Apply this newly added quirk on Dell XPS 14
DA14260 if specific panel model is installed.

We are observing problems with Dell XPS 14 DA14260. This device has certain
LGD panel model which seems to be problematic. We have seen other LGD panel
model with same OUI is working fine. Due to this we can't apply the quirk
only based on panel OUI. There are also cases where same device model has
differing panel model. We don't want to disable Panel Replay on such
devices. Best we can do is to apply the quirk based on both device model
and panel model.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7521
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260317062402.1888624-1-jouni.hogander@intel.com
Stable-dep-of: 5271d81f99dd ("drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c    |  7 +++++++
 drivers/gpu/drm/i915/display/intel_quirks.c | 17 ++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 1eeae3243bd5d..8c95e6dc8e4f4 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -49,6 +49,7 @@
 #include "intel_hdmi.h"
 #include "intel_psr.h"
 #include "intel_psr_regs.h"
+#include "intel_quirks.h"
 #include "intel_snps_phy.h"
 #include "intel_step.h"
 #include "intel_vblank.h"
@@ -592,6 +593,12 @@ static void _panel_replay_init_dpcd(struct intel_dp *intel_dp)
 	if (intel_dp->mst_detect == DRM_DP_MST)
 		return;
 
+	if (intel_has_dpcd_quirk(intel_dp, QUIRK_DISABLE_PANEL_REPLAY)) {
+		drm_dbg_kms(display->drm,
+			    "Panel Replay support not currently available for this setup\n");
+		return;
+	}
+
 	ret = drm_dp_dpcd_read_data(&intel_dp->aux, DP_PANEL_REPLAY_CAP_SUPPORT,
 				    &intel_dp->pr_dpcd, sizeof(intel_dp->pr_dpcd));
 	if (ret < 0)
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 1abbdd426e587..8f1bf8f418ec7 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -86,6 +86,14 @@ static void quirk_edp_limit_rate_hbr2(struct intel_display *display)
 	drm_info(display->drm, "Applying eDP Limit rate to HBR2 quirk\n");
 }
 
+static void quirk_disable_panel_replay(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	intel_set_dpcd_quirk(intel_dp, QUIRK_DISABLE_PANEL_REPLAY);
+	drm_info(display->drm, "Applying disable Panel Replay quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -251,7 +259,14 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
 		.sink_oui = SINK_OUI(0x38, 0xec, 0x11),
 		.hook = quirk_fw_sync_len,
 	},
-
+	/* Dell XPS 14 DA14260 */
+	{
+		.device = 0xb080,
+		.subsystem_vendor = 0x1028,
+		.subsystem_device = 0x0db9,
+		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
+		.hook = quirk_disable_panel_replay,
+	},
 };
 
 void intel_init_quirks(struct intel_display *display)
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 06da0e286c67c..77e490caed0d8 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -21,6 +21,7 @@ enum intel_quirk_id {
 	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
 	QUIRK_FW_SYNC_LEN,
 	QUIRK_EDP_LIMIT_RATE_HBR2,
+	QUIRK_DISABLE_PANEL_REPLAY,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.53.0

