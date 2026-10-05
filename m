Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF254655
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187614; cv=none; b=gYY+qIvPbBIWn7xHfLjMhJ42S470umbVhVmTRqh8HrwiN7rUE39DiBR8qR1VUGl+sis3zuGSz1NCd2uf7FzvKoU/gT4IrNUMnXbkTHfRLQc36mKaxBwzWejoi9vZOKVRLCL8KQPk9atpVQr5xhlrkveZqy4Ul1xtCFILd13H1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187614; c=relaxed/simple;
	bh=FhKIW9HJFtVev7mns31evXtnpeKH+mcesqcVyoD2m0E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cv8lCg9wpe6deIDMo6kckFmgNcSEi2j2fztN16L5MknenI7i98Pui+p5X+AmCqSQOJreAdeoX3NtPxEEnpsaBhfIdQqQ5GzwEEwkhTZOO4iGju17lLHAshOkFNG0YacOXvmFbbQD24AX6USh/oko8Uf+nYvAm+BwNWdyOxD8FkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KSMaet32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KSMaet32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8821B1F000FF;
	Mon,  5 Oct 2026 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187613;
	bh=WMWvw1TMp2IvZXXJRf8Gl1r2Jpwlxw21GIOBSYHLOno=;
	h=Subject:To:Cc:From:Date;
	b=KSMaet32ZhpnwsfikocYmAVW/mZTTL3FO8XJWUHrj8yfdhhrKsn/IXlxpb+ao1KQj
	 jyGAD7VlnmMMUhRYtYbSnEajddiorZ5tacFM4P4fV2S2xxdpYdKUE0OTHs+1whWI4m
	 Ozj1DN2TEkR6bQ7ffkVZ4+0LI3kgui2PUa0lVGYE=
Subject: FAILED: patch "[PATCH] drm/amd/display: map PWM brightness through custom backlight" failed to apply to 7.2-stable tree
To: ray.wu@amd.com,alexander.deucher@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,jerry.zuo@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:06:50 +0200
Message-ID: <2026100550-splotchy-cheesy-cd92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 51cc916648d1421e0271090fb4fa86550a7a96d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100550-splotchy-cheesy-cd92@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51cc916648d1421e0271090fb4fa86550a7a96d9 Mon Sep 17 00:00:00 2001
From: Ray Wu <ray.wu@amd.com>
Date: Fri, 18 Sep 2026 11:05:46 +0800
Subject: [PATCH] drm/amd/display: map PWM brightness through custom backlight
 curve

[Why/How]
On the PWM path, convert the userspace brightness to an input signal and
derive the target luminance from the custom backlight curve, then pass
the resulting millipercent to the power module.

This keeps PWM programming and backlight curve mapping in the power
module, aligning the Linux path with the Windows behavior.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5723
Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Assisted-by: Cursor:Claude-Opus-4.8
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bc4e099caa85e8d4c3555851a0feb07058c4a1fe)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e0485d76dc59..1b42c4606002 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -426,6 +426,8 @@ static int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
 		init_data[i].use_custom_backlight_caps = false;
 		init_data[i].custom_backlight_caps_config_no = 0;
 		init_data[i].use_linear_backlight_curve = false;
+		if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
+			init_data[i].use_linear_backlight_curve = true;
 		init_data[i].def_varibright_enable = 0;
 		init_data[i].varibright_level = 0;
 		/*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index b9e90ea449ca..703d0617df6d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -39,6 +39,7 @@
 #include "modules/inc/mod_power.h"
 
 #include <linux/backlight.h>
+#include <linux/minmax.h>
 #include <linux/power_supply.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_utils.h>
@@ -118,6 +119,68 @@ static inline u32 scale_fw_to_input(int min, int max, u64 input)
 	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
 }
 
+static u32 backlight_signal_to_luminance(const struct amdgpu_dm_backlight_caps *caps,
+					 u32 signal)
+{
+	u32 lower_signal, upper_signal;
+	u32 lower_lum, upper_lum;
+	int i;
+
+	if (!caps->data_points)
+		return DIV_ROUND_CLOSEST(signal * 100, AMDGPU_MAX_BL_LEVEL);
+
+	if (signal < caps->luminance_data[0].input_signal) {
+		lower_signal = 0;
+		lower_lum = 0;
+		upper_signal = caps->luminance_data[0].input_signal;
+		upper_lum = caps->luminance_data[0].luminance;
+	} else if (signal >=
+		   caps->luminance_data[caps->data_points - 1].input_signal) {
+		lower_signal = caps->luminance_data[caps->data_points - 1].input_signal;
+		lower_lum = caps->luminance_data[caps->data_points - 1].luminance;
+		upper_signal = caps->max_input_signal;
+		upper_lum = 100;
+	} else {
+		for (i = 1;
+		     i < caps->data_points &&
+		     signal > caps->luminance_data[i].input_signal;
+		     i++)
+			;
+
+		lower_signal = caps->luminance_data[i - 1].input_signal;
+		upper_signal = caps->luminance_data[i].input_signal;
+		lower_lum = caps->luminance_data[i - 1].luminance;
+		upper_lum = caps->luminance_data[i].luminance;
+	}
+
+	if (upper_signal == lower_signal)
+		return upper_lum;
+
+	return lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
+					     (signal - lower_signal),
+					     upper_signal - lower_signal);
+}
+
+static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
+					      u32 user_brightness)
+{
+	unsigned int min, max;
+	u32 signal, luminance;
+
+	if (!get_brightness_range(caps, &min, &max))
+		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000,
+					     MAX_BACKLIGHT_LEVEL);
+
+	user_brightness = clamp(user_brightness, min, max);
+	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
+		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000, max);
+
+	signal = scale_input_to_fw(max, user_brightness);
+	luminance = backlight_signal_to_luminance(caps, signal);
+
+	return min_t(u32, luminance * 1000, 100000);
+}
+
 STATIC_IFN_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 			       unsigned int min, unsigned int max,
@@ -260,10 +323,10 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	struct amdgpu_dm_backlight_caps *caps;
 	struct dc_link *link;
 	u32 brightness = 0;
+	u32 millipercent = 0;
 	bool rc = false, reallow_idle = false;
 	struct drm_connector *connector;
 	struct dc_stream_state *stream;
-	unsigned int min, max;
 
 	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, head) {
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -286,12 +349,21 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	/* update scratch register */
 	if (bl_idx == 0)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
-	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
-	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
-	/* Apply brightness quirk */
-	if (caps->brightness_mask)
-		brightness |= caps->brightness_mask;
+	link = (struct dc_link *)dm->backlight_link[bl_idx];
+	stream = dm_find_stream_with_link(dm, link);
+	if (!stream)
+		return;
+
+	if (caps->aux_support) {
+		brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
+		/* Apply brightness quirk */
+		if (caps->brightness_mask)
+			brightness |= caps->brightness_mask;
+	} else {
+		millipercent = convert_brightness_to_millipercent(caps,
+								  user_brightness);
+	}
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
 		trace_amdgpu_dm_brightness(__builtin_return_address(0),
@@ -301,10 +373,6 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 					   power_supply_is_system_supplied() > 0);
 	}
 
-	stream = dm_find_stream_with_link(dm, link);
-	if (!stream)
-		return;
-
 	mutex_lock(&dm->dc_lock);
 	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
 		dc_allow_idle_optimizations(dm->dc, false);
@@ -316,10 +384,8 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 			AUX_BL_DEFAULT_TRANSITION_TIME_MS, false, true);
 	} else {
 		/* power module uses millipercent */
-		get_brightness_range(caps, &min, &max);
-		brightness = DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;
 		rc = mod_power_set_backlight_percent(dm->power_module, stream,
-						     brightness, 0, false);
+						     millipercent, 0, false);
 	}
 
 	/*

