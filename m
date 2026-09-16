Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516C4E66A3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567624; cv=none; b=lv0tKqdMmGOJPjQBj/OdVFexvea5TTzQj/znGZzy4SgXG2r4taKFsypd59AuHke91s0ZGJu/nuaT9SvYB5DOYn7vFnttABZrTbjlUkwY5Yp8Xb6F6qt7ub9hE1fzQ4lvKyZZ7pw9larB+0YBesUm6d0l0YJCKPzuDqsCmzz2aAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567624; c=relaxed/simple;
	bh=GQLnVzanyi/bvPSCodct6kCVSMrkGvJ2NZSM7Ya5P9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f44irUWrefj2sg51e1vYWR1/GImkF7nIQ0+0gjhCYrnUT8PKOIERR24056fatAj4PB9lbG1GyNkhVr+AYXhgVBi5qqP+K/mjdE4U/rTa0a5SCUXlo8IN0qPTh5D8RKAEmw2NSei7rpC3Llwug0rWHWmeWO2Oqmx4p5PXz8rpUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aasDl0Vr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aasDl0Vr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C11D1F000FF;
	Wed, 16 Sep 2026 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567622;
	bh=VL11VhKcp60NZdRDC96aiImms3QLsPnV2GBcy7//Vjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aasDl0VrqHtLQBsWi4h6++RHK1/wODMGt5QWNEYGwntADTirlwDiC1vMuRGcfrlI4
	 d+z8Gz26sZnvv/otV/gDQxKWK5jUR1azOmO3wrt20bWNI38Ix5Q7cT/9c7lvoGT7TJ
	 N7eEOz7v296berpkDJGjEKxslIn2zPdZM63TLwwAISH/OOXNKaeqEpI824aNFOsi1V
	 9e4aQ4eVECfKbUh0+Z10fKoL/EoXde0qOvPvp2nVTA9vfqMoFuJAkj/20CfzsQsyzk
	 nwTCiKDg1r4Nka+vo2d9f8fwYf6KUHD9swR9XW5SCIpor14NRFOvFcX+QnF4nuBIUf
	 tjFrZqbsKTdjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Kalra <radheykalra901@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] platform/x86: hp-wmi: Introduce board-specific feature data
Date: Wed, 16 Sep 2026 10:06:59 -0400
Message-ID: <20260916140700.2892359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091627-nephew-drained-5a51@gregkh>
References: <2026091627-nephew-drained-5a51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Radhey Kalra <radheykalra901@gmail.com>

[ Upstream commit 08ecf6d131f38595a1e7f5441c8e1d29302cc718 ]

The hp_wmi DMI table is about to carry more than thermal-profile data.
Replace the direct thermal_profile_params .driver_data pointers with
hp_wmi_board_params and rename the table/setup helper accordingly.

No functional changes intended.

Signed-off-by: Radhey Kalra <radheykalra901@gmail.com>
Link: https://patch.msgid.link/20260615091034.987029-2-radheykalra901@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: ee02ed6308fb ("platform/x86: hp-wmi: Fix board_params typo for 8DD6 board")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 127 +++++++++++++++++++------------
 1 file changed, 80 insertions(+), 47 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 94147102cca43..16aadf27bf391 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -133,11 +133,35 @@ static const struct thermal_profile_params omen_v1_no_ec_thermal_params = {
 	.ec_tp_offset	= HP_NO_THERMAL_PROFILE_OFFSET,
 };
 
-/*
- * A generic pointer for the currently-active board's thermal profile
- * parameters.
- */
-static struct thermal_profile_params *active_thermal_profile_params;
+struct hp_wmi_board_params {
+	const struct thermal_profile_params *thermal_profile;
+};
+
+static const struct hp_wmi_board_params victus_s_board_params = {
+	.thermal_profile	= &victus_s_thermal_params,
+};
+
+static const struct hp_wmi_board_params omen_v1_board_params = {
+	.thermal_profile	= &omen_v1_thermal_params,
+};
+
+static const struct hp_wmi_board_params omen_v1_legacy_board_params = {
+	.thermal_profile	= &omen_v1_legacy_thermal_params,
+};
+
+static const struct hp_wmi_board_params omen_v1_no_ec_board_params = {
+	.thermal_profile	= &omen_v1_no_ec_thermal_params,
+};
+
+static const struct hp_wmi_board_params *active_board_params;
+
+static const struct thermal_profile_params *hp_wmi_thermal_profile(void)
+{
+	if (!active_board_params)
+		return NULL;
+
+	return active_board_params->thermal_profile;
+}
 
 /* DMI board names of devices that should use the omen specific path for
  * thermal profiles.
@@ -187,83 +211,83 @@ static const char * const victus_thermal_profile_boards[] = {
 	"8A25",
 };
 
-/* DMI Board names of Victus 16-r and Victus 16-s laptops */
-static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst = {
+/* DMI board-specific feature data for Omen and Victus laptops. */
+static const struct dmi_system_id hp_wmi_feature_boards[] __initconst = {
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8902") },
-		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+		.driver_data = (void *)&omen_v1_legacy_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8A44") },
-		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+		.driver_data = (void *)&omen_v1_legacy_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8A4D") },
-		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+		.driver_data = (void *)&omen_v1_legacy_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BAB") },
-		.driver_data = (void *)&omen_v1_thermal_params,
+		.driver_data = (void *)&omen_v1_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8B2F") },
-		.driver_data = (void *)&victus_s_thermal_params,
+		.driver_data = (void *)&victus_s_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BBE") },
-		.driver_data = (void *)&victus_s_thermal_params,
+		.driver_data = (void *)&victus_s_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BC2") },
-		.driver_data = (void *)&omen_v1_thermal_params,
+		.driver_data = (void *)&omen_v1_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BCA") },
-		.driver_data = (void *)&omen_v1_thermal_params,
+		.driver_data = (void *)&omen_v1_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BCD") },
-		.driver_data = (void *)&omen_v1_thermal_params,
+		.driver_data = (void *)&omen_v1_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BD4") },
-		.driver_data = (void *)&victus_s_thermal_params,
+		.driver_data = (void *)&victus_s_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BD5") },
-		.driver_data = (void *)&victus_s_thermal_params,
+		.driver_data = (void *)&victus_s_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C76") },
-		.driver_data = (void *)&omen_v1_thermal_params,
+		.driver_data = (void *)&omen_v1_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C77") },
-		.driver_data = (void *)&omen_v1_thermal_params,
+		.driver_data = (void *)&omen_v1_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C78") },
-		.driver_data = (void *)&omen_v1_thermal_params,
+		.driver_data = (void *)&omen_v1_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C99") },
-		.driver_data = (void *)&victus_s_thermal_params,
+		.driver_data = (void *)&victus_s_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C9C") },
-		.driver_data = (void *)&victus_s_thermal_params,
+		.driver_data = (void *)&victus_s_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D26") },
-		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+		.driver_data = (void *)&omen_v1_legacy_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D41") },
-		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
+		.driver_data = (void *)&omen_v1_no_ec_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D87") },
-		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
+		.driver_data = (void *)&omen_v1_no_ec_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
@@ -271,7 +295,7 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
-		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+		.driver_data = (void *)&omen_v1_legacy_board_params,
 	},
 	{},
 };
@@ -1878,7 +1902,10 @@ static int platform_profile_victus_s_get_ec(enum platform_profile_option *profil
 	u8 current_dstate, current_gpu_slowdown_temp, tp;
 	const struct thermal_profile_params *params;
 
-	params = active_thermal_profile_params;
+	params = hp_wmi_thermal_profile();
+	if (!params)
+		return -ENODEV;
+
 	if (params->ec_tp_offset == HP_EC_OFFSET_UNKNOWN ||
 	    params->ec_tp_offset == HP_NO_THERMAL_PROFILE_OFFSET) {
 		*profile = active_platform_profile;
@@ -1890,10 +1917,10 @@ static int platform_profile_victus_s_get_ec(enum platform_profile_option *profil
 		return ret;
 
 	/*
-	 * We cannot use active_thermal_profile_params here, because boards
-	 * like 8C78 have tp == 0x0 || tp == 0x1 after cold boot, but logically
-	 * it should have tp == 0x30 || tp == 0x31, as corrected by the Omen
-	 * Gaming Hub on windows. Hence accept both of these values.
+	 * Boards like 8C78 have tp == 0x0 || tp == 0x1 after cold boot,
+	 * but logically it should have tp == 0x30 || tp == 0x31, as
+	 * corrected by the Omen Gaming Hub on windows. Hence accept both
+	 * of these values.
 	 */
 	if (tp == victus_s_thermal_params.performance ||
 	    tp == omen_v1_thermal_params.performance) {
@@ -1928,12 +1955,12 @@ static int platform_profile_victus_s_get_ec(enum platform_profile_option *profil
 
 static int platform_profile_victus_s_set_ec(enum platform_profile_option profile)
 {
-	struct thermal_profile_params *params;
+	const struct thermal_profile_params *params;
 	bool gpu_ctgp_enable, gpu_ppab_enable;
 	u8 gpu_dstate; /* Test shows 1 = 100%, 2 = 50%, 3 = 25%, 4 = 12.5% */
 	int err, tp;
 
-	params = active_thermal_profile_params;
+	params = hp_wmi_thermal_profile();
 	if (!params)
 		return -ENODEV;
 
@@ -2199,6 +2226,7 @@ static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
 static int thermal_profile_setup(struct platform_device *device)
 {
 	const struct platform_profile_ops *ops;
+	const struct thermal_profile_params *params;
 	int err, tp;
 
 	if (is_omen_thermal_profile()) {
@@ -2230,13 +2258,17 @@ static int thermal_profile_setup(struct platform_device *device)
 
 		ops = &platform_profile_victus_ops;
 	} else if (is_victus_s_thermal_profile()) {
+		params = hp_wmi_thermal_profile();
+		if (!params)
+			return -ENODEV;
+
 		/*
 		 * For an unknown EC layout board, platform_profile_victus_s_get_ec(),
 		 * behaves like a wrapper around active_platform_profile, to avoid using
 		 * uninitialized data, we default to PLATFORM_PROFILE_BALANCED.
 		 */
-		if (active_thermal_profile_params->ec_tp_offset == HP_EC_OFFSET_UNKNOWN ||
-		    active_thermal_profile_params->ec_tp_offset == HP_NO_THERMAL_PROFILE_OFFSET) {
+		if (params->ec_tp_offset == HP_EC_OFFSET_UNKNOWN ||
+		    params->ec_tp_offset == HP_NO_THERMAL_PROFILE_OFFSET) {
 			active_platform_profile = PLATFORM_PROFILE_BALANCED;
 		} else {
 			err = platform_profile_victus_s_get_ec(&active_platform_profile);
@@ -2697,24 +2729,25 @@ static int hp_wmi_hwmon_init(void)
 	return 0;
 }
 
-static void __init setup_active_thermal_profile_params(void)
+static void __init setup_active_board_params(void)
 {
 	const struct dmi_system_id *id;
+	const struct thermal_profile_params *params;
 
-	/*
-	 * Currently only victus_s devices use the
-	 * active_thermal_profile_params
-	 */
-	id = dmi_first_match(victus_s_thermal_profile_boards);
+	id = dmi_first_match(hp_wmi_feature_boards);
 	if (id) {
+		active_board_params = id->driver_data;
+		params = hp_wmi_thermal_profile();
+		if (!params)
+			return;
+
 		/*
 		 * Marking this boolean is required to ensure that
 		 * is_victus_s_thermal_profile() behaves like a valid
 		 * wrapper.
 		 */
 		is_victus_s_board = true;
-		active_thermal_profile_params = id->driver_data;
-		if (active_thermal_profile_params->ec_tp_offset == HP_EC_OFFSET_UNKNOWN) {
+		if (params->ec_tp_offset == HP_EC_OFFSET_UNKNOWN) {
 			pr_warn("Unknown EC layout for board %s. Thermal profile readback will be disabled. Please report this to platform-driver-x86@vger.kernel.org\n",
 				dmi_get_system_info(DMI_BOARD_NAME));
 		}
@@ -2749,10 +2782,10 @@ static int __init hp_wmi_init(void)
 		}
 
 		/*
-		 * Setup active board's thermal profile parameters before
-		 * starting platform driver probe.
+		 * Setup active board feature data before starting platform
+		 * driver probe.
 		 */
-		setup_active_thermal_profile_params();
+		setup_active_board_params();
 		err = platform_driver_probe(&hp_wmi_driver, hp_wmi_bios_setup);
 		if (err)
 			goto err_unregister_device;
-- 
2.53.0

