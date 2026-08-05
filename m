Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91E46AA8D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931909; cv=none; b=PHEygIQ4mEWuh0ESa5Eowc5x1IgPV/6Xx7RW2GuIshtN/nK4SEz5wP08EBsstjY785daQGhPWnMffwcT5G4c/F9cXGedQm9WdHjYU8T7jlz4SncrxJwMBhpC2qr9O4mBkZOfW/gI/wgGgK4UeV9F7KA2mfENy1UHbrouOca3V8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931909; c=relaxed/simple;
	bh=2okczt6oKWX/OATcG2oIG6Q4Q50Wpq9LQLF7PL6TF/A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QrJPnHK8+TxkbVNgz2nHYYiLJIZJF2Le4Px0Qd0oX/Uc/KROGKFQS/r8v2cDU/agquxaGhjRX5qlgrCyr4+saQlGWpwFojvK+1aRCZsK8ZRsRuGPx1bcwCMgB3bnhVpi265i9QYnK4UHTeIZIFDadnXPPe81ekAqaZPuVQPirvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RH/kmzUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RH/kmzUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F5B1F000E9;
	Wed,  5 Aug 2026 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931908;
	bh=vbSZsCpezMr4njPxlm0FGif2BFR0zNuVK2b00dPLKk4=;
	h=Subject:To:Cc:From:Date;
	b=RH/kmzUiTVHKy2f/1T+YlB2zGcGzjQo4pBtWcRRRj1xDlRFeGx/3SPthojcv0y89k
	 6Qc9OTUHeZMfQVhXwSNZs5Qn8K++GdJBVtpZiUdSVyfLJyY6Z6ULk7dJ4NQkDBIBgX
	 sy9GosqcbmWkg6JWXxaeJzoa1KR7u9O/uBZqDCRI=
Subject: FAILED: patch "[PATCH] drm/amd/display: use proper context for logging" failed to apply to 5.10-stable tree
To: jirislaby@kernel.org,Bhawanpreet.Lakha@amd.com,airlied@gmail.com,alexander.deucher@amd.com,bhawanpreet.lakha@amd.com,christian.koenig@amd.com,harry.wentland@amd.com,simona@ffwll.ch,siqueira@igalia.com,sunpeng.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:11:21 +0200
Message-ID: <2026080521-defeat-april-6e9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 114b42507b6a23d9d24e24e4ef165233332c64d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080521-defeat-april-6e9f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 114b42507b6a23d9d24e24e4ef165233332c64d4 Mon Sep 17 00:00:00 2001
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Date: Thu, 23 Jul 2026 06:25:48 +0200
Subject: [PATCH] drm/amd/display: use proper context for logging
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The same as the rest of the code, get_ss_info_from_atombios() uses
calc_pll_cs->ctx->logger for logging. But calc_pll_cs->ctx is
initialized only later in calc_pll_max_vco_construct(). Therefore, any
output using DC_LOG_SYNC() leads to a NULL pointer deference in
get_ss_info_from_atombios().

According to Sashiko, the very same problem exists in
dce112_get_pix_clk_dividers() and dcn3_get_pix_clk_dividers() too.

To avoid accessing the NULL context, use clk_src->base.ctx->logger
everywhere. That context in base is initialized earlier in
dce110_clk_src_construct() and dce112_clk_src_construct(). Before
get_ss_info_from_atombios() or Sashiko's get_pix_clk_dividers functions
above are actually called. This is done by redefining DC_LOGGER to
CTX->logger.

Before:
dce110_clk_src_construct() did:
 -> sets clk_src->base.ctx = ctx;
 -> ss_info_from_atombios_create()
   -> get_ss_info_from_atombios()   <- uses calc_pll_cs->ctx  # BOOM
 -> calc_pll_max_vco_construct()    <- sets calc_pll_cs->ctx

After:
dce110_clk_src_construct() does:
 -> sets clk_src->base.ctx = ctx;
 -> ss_info_from_atombios_create()
   -> get_ss_info_from_atombios()   <- uses clk_src->base.ctx

Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271175
Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@kernel.org/
Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6f16fcbb0c46a87e3d9685407e906573d60104b0)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index ecb8493ec523..8e3862f6dac2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -45,9 +45,7 @@
 	clk_src->base.ctx
 
 #define DC_LOGGER \
-	calc_pll_cs->ctx->logger
-#define DC_LOGGER_INIT() \
-	struct calc_pll_clock_source *calc_pll_cs = &clk_src->calc_pll
+	CTX->logger
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -287,6 +285,7 @@ static bool calc_pll_dividers_in_range(
 }
 
 static uint32_t calculate_pixel_clock_pll_dividers(
+		struct dce110_clk_src *clk_src,
 		struct calc_pll_clock_source *calc_pll_cs,
 		struct pll_settings *pll_settings)
 {
@@ -474,7 +473,7 @@ static uint32_t dce110_get_pix_clk_dividers_helper (
 {
 	uint32_t field = 0;
 	uint32_t pll_calc_error = MAX_PLL_CALC_ERROR;
-	DC_LOGGER_INIT();
+
 	/* Check if reference clock is external (not pcie/xtalin)
 	* HW Dce80 spec:
 	* 00 - PCIE_REFCLK, 01 - XTALIN,    02 - GENERICA,    03 - GENERICB
@@ -517,12 +516,14 @@ static uint32_t dce110_get_pix_clk_dividers_helper (
 		/*Calculate Dividers by HDMI object, no SS case or SS case */
 		pll_calc_error =
 			calculate_pixel_clock_pll_dividers(
+				        clk_src,
 					&clk_src->calc_pll_hdmi,
 					pll_settings);
 	else
 		/*Calculate Dividers by default object, no SS case or SS case */
 		pll_calc_error =
 			calculate_pixel_clock_pll_dividers(
+					clk_src,
 					&clk_src->calc_pll,
 					pll_settings);
 
@@ -568,7 +569,6 @@ static uint32_t dce110_get_pix_clk_dividers(
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
 	uint32_t pll_calc_error = MAX_PLL_CALC_ERROR;
-	DC_LOGGER_INIT();
 
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
@@ -600,7 +600,6 @@ static uint32_t dce112_get_pix_clk_dividers(
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
-	DC_LOGGER_INIT();
 
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
@@ -1442,8 +1441,6 @@ static uint32_t dcn3_get_pix_clk_dividers(
 	unsigned long long actual_pix_clk_100Hz = pix_clk_params ? pix_clk_params->requested_pix_clk_100hz : 0;
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
 
-	DC_LOGGER_INIT();
-
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
 		DC_LOG_ERROR(
@@ -1513,7 +1510,6 @@ static const struct clock_source_funcs dce110_clk_src_funcs = {
 	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz
 };
 
-
 static void get_ss_info_from_atombios(
 		struct dce110_clk_src *clk_src,
 		enum as_signal_type as_signal,
@@ -1526,7 +1522,7 @@ static void get_ss_info_from_atombios(
 	struct spread_spectrum_info *ss_info_cur;
 	struct spread_spectrum_data *ss_data_cur;
 	uint32_t i;
-	DC_LOGGER_INIT();
+
 	if (ss_entries_num == NULL) {
 		DC_LOG_SYNC(
 			"Invalid entry !!!\n");
@@ -1657,6 +1653,7 @@ static void ss_info_from_atombios_create(
 }
 
 static bool calc_pll_max_vco_construct(
+			struct dce110_clk_src *clk_src,
 			struct calc_pll_clock_source *calc_pll_cs,
 			struct calc_pll_clock_source_init_data *init_data)
 {
@@ -1808,6 +1805,7 @@ bool dce110_clk_src_construct(
 	ss_info_from_atombios_create(clk_src);
 
 	if (!calc_pll_max_vco_construct(
+			clk_src,
 			&clk_src->calc_pll,
 			&calc_pll_cs_init_data)) {
 		ASSERT_CRITICAL(false);
@@ -1822,7 +1820,7 @@ bool dce110_clk_src_construct(
 
 
 	if (!calc_pll_max_vco_construct(
-			&clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_hdmi)) {
+			clk_src, &clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_hdmi)) {
 		ASSERT_CRITICAL(false);
 		goto unexpected_failure;
 	}

