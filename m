Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF965221F0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572566; cv=none; b=Yyy4XfxZsWvD2OCMVww0+x7k2xFoEJfClsUyA7i/5yZj62a3GxbOpKOGRw/+QV4Xv7lKzQ3TtaRbnBj+WQhF3QMmDjzQGMNatcElJBzFQnAdYcDzCdop0MK/40XAuzk6AT7Z1ir33OJ0DdvlTBXoZmfBO6JV7L9+P/gdPSmXGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572566; c=relaxed/simple;
	bh=nCxoN1S+5qr4laghMzy718xyyBRtMvEyDPbAReVBB14=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jAjf3xaTTSinE2Z+A3jlRr9mjnzFxjh0qeRaGazhNx2m5RCbogti5nbiyv9nwOxdv3JsyLdoMzT3p0PQMl9BFgtXEbVQryjMQqFChEv4gSYKvlzw9QHKDo0/Pa1bgJ/oMJzLeIZl5xOa3AZo7aFZCTfWY8DtL5LMyeo8zoXhPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ny8EEzzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ny8EEzzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9D61F00893;
	Wed, 16 Sep 2026 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572562;
	bh=sHz1NrOxQuruXMqDhWDuZ7UVNMV0odKI4qsoQxW1jVI=;
	h=Subject:To:Cc:From:Date;
	b=Ny8EEzzOjbMMZouYzGV9+5KC6RpDT2NKRsauOFcPyi4NvBDPjJWIdMh6H0sOssiij
	 hZKSBG4AMQ2c94OPCSDy4kOCwXqh7OI/+JeFJO9/92kbff1mv36sLTuFeECYdlx8sh
	 SyMv1l3QUCNtv1n09shlnUz6GJINq87AL1Ke3w20=
Subject: FAILED: patch "[PATCH] drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output" failed to apply to 6.18-stable tree
To: sroy14@alum.utk.edu,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:19:55 +0100
Message-ID: <2026091655-squabble-justify-d868@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7fca7acd60a228b62b4e9efa5f184738041e9564
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091655-squabble-justify-d868@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fca7acd60a228b62b4e9efa5f184738041e9564 Mon Sep 17 00:00:00 2001
From: Satyajit Roy <sroy14@alum.utk.edu>
Date: Sun, 30 Aug 2026 03:52:06 +0000
Subject: [PATCH] drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output

amdgpu_dm_get_output_color_space() applies the Broadcast RGB connector
property to default RGB output, but always selects full-range output for
BT.2020 RGB. Consequently, explicitly selecting Limited has no effect on
the output CSC or AVI InfoFrame when HDR uses BT.2020 RGB.

Select COLOR_SPACE_2020_RGB_LIMITEDRANGE when the output encoding is RGB
and Broadcast RGB is Limited. Keep Automatic and Full at full range, and
leave YCbCr output unchanged.

Add KUnit coverage for limited-range RGB output through both BT.2020
connector colorspace values.

Fixes: 6eb4c13a3845 ("drm/amd/display: Support "Broadcast RGB" drm property")
Signed-off-by: Satyajit Roy <sroy14@alum.utk.edu>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 022236eaa63bbf65761aa8aec43f661451a94654)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index d03773887214..154e1f35dcb1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -756,10 +756,14 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 		break;
 	case DRM_MODE_COLORIMETRY_BT2020_RGB:
 	case DRM_MODE_COLORIMETRY_BT2020_YCC:
-		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB)
-			color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
-		else
+		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB) {
+			if (connector_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+				color_space = COLOR_SPACE_2020_RGB_LIMITEDRANGE;
+			else
+				color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
+		} else {
 			color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
+		}
 		break;
 	case DRM_MODE_COLORIMETRY_DEFAULT: /* ITU601 */
 	default:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 0d2f9dbce0a9..212a7536e65b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -567,6 +567,23 @@ static void dm_test_output_color_space_bt2020_rgb(struct kunit *test)
 			(int)COLOR_SPACE_2020_RGB_FULLRANGE);
 }
 
+/**
+ * dm_test_output_color_space_bt2020_rgb_limited - Test limited BT.2020 RGB
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_bt2020_rgb_limited(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+
+	timing.pixel_encoding = PIXEL_ENCODING_RGB;
+	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
+	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_LIMITED;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
+}
+
 /**
  * dm_test_output_color_space_bt2020_ycc - Test Output color space bt2020 ycc
  * @test: The KUnit test context
@@ -638,6 +655,24 @@ static void dm_test_output_color_space_bt2020_ycc_rgb_encoding(struct kunit *tes
 			(int)COLOR_SPACE_2020_RGB_FULLRANGE);
 }
 
+/**
+ * dm_test_output_color_space_bt2020_ycc_rgb_encoding_limited - Test limited
+ * BT.2020 RGB output selected through the BT.2020 YCC connector colorspace
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_bt2020_ycc_rgb_encoding_limited(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+
+	timing.pixel_encoding = PIXEL_ENCODING_RGB;
+	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_YCC;
+	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_LIMITED;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
+}
+
 /**
  * dm_test_output_color_space_bt2020_rgb_ycc_encoding - Test Output color space
  * bt2020 rgb with non-rgb pixel encoding falls back to limited ycbcr
@@ -5422,10 +5457,12 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_output_color_space_bt709_y_only),
 	KUNIT_CASE(dm_test_output_color_space_oprgb),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb),
+	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb_limited),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_ycc),
 	KUNIT_CASE(dm_test_output_color_space_default_ycbcr709_y_only),
 	KUNIT_CASE(dm_test_output_color_space_default_ycbcr601),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_ycc_rgb_encoding),
+	KUNIT_CASE(dm_test_output_color_space_bt2020_ycc_rgb_encoding_limited),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb_ycc_encoding),
 	/* Tests for amdgpu_dm_convert_dc_color_depth_into_bpc */
 	KUNIT_CASE(dm_test_convert_color_depth_bpc_mappings),

