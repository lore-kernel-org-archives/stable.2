Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9113374E5B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565403; cv=none; b=cjy78jCBP43LEVSwVGJI2j+GSydSEQl1VpKr+E24JiW3r5+PN9iwc30iEYtjkkjtCRjJMlX4i60EDukZHEUz9RfR7Vi5l7vGprXIsp6m7tdKy1K3pJdXIHARsLRjjqqC+O48wijcil87fXujXMftLhSUQi+E3x0LhXhMv0ncAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565403; c=relaxed/simple;
	bh=HBWylYDvj9c3gHww4IwHeqdvIBCPHzDN4M6n0+vIaAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Un7eC0cnYvdEzfOVpedN2sYe8c5wIp0iJTRtuejEZnwgSK45pNGndZ7RA5yDf7UC3twBoaJt3u9cx5DU0C0vgP8hip4BEmKmRXF8JErFGg0Q5RPZmPBnJ61LrOPVbjUbJ3WqWZAvTOGfo84v5UgjGuR388RO3tIEFGJQNRiW+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBpS3ME1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBpS3ME1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FBC1F00A3D;
	Mon, 24 Aug 2026 09:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565401;
	bh=i4IqAPWiby+EA9Piol6lGGmj6ieyb9yCbxKSVqXJ7Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBpS3ME1JJudEwhcuXNuhlEWWHEhcaSjyaE3hhrvnAgwqa15NSppt+2tHPItVtmCs
	 iDFi2aKlpwFHNn+uLBz4ZivvzgSsvtoM0TFuyoqQWcvCQFPIbXOkD8O3UbrUg33cWR
	 LNYpnBe8udwbxvwvmgF/LNh4xOzakHlYUcnBhJmXIMs4omDY0NNWa9Au9f/w8T5X8Z
	 pBW9fNbtH/6V3lZKE6GigJS+Au9iqwR/7SSKzE4ZVXOqTwhMsigwTQ9hkoZenDsJ16
	 ks9R6BbGYnD9twrCSpuVBRa7T4ebj+5jrWpnNW8eZGpIB/x55UlvjUuUPE/mSmUWTR
	 rnUUXrGL2NErQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
	Krunoslav Kovac <krunoslav.kovac@amd.com>,
	Roman Li <roman.li@amd.com>,
	Robert Mader <robert.mader@collabora.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/amd/display: Fix BT2020 YCbCr limited/full range input
Date: Mon, 24 Aug 2026 05:56:38 -0400
Message-ID: <20260824095639.4067078-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082006-fable-army-ffc8@gregkh>
References: <2026082006-fable-army-ffc8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[ Upstream commit 07bc2dcbcf403d47d6f305ef7f0d3d489491c5fb ]

[Why]
BT2020 YCbCr input is not handled properly when full range
quantization is used and limited range is not supported at all.

[How]
- Add enums for BT2020 YCbCr limited/full range
- Add limited range CSC matrix

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 2f9a5c0f018d ("drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 6 +++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/basics/dc_common.c           | 3 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c       | 5 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                | 4 +++-
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c     | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c | 3 ++-
 .../drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c  | 3 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h                 | 6 +++++-
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c   | 4 ++--
 11 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7ae94daa969a2..7c72caac7b4d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4937,9 +4937,9 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 
 	case DRM_COLOR_YCBCR_BT2020:
 		if (full_range)
-			*color_space = COLOR_SPACE_2020_YCBCR;
+			*color_space = COLOR_SPACE_2020_YCBCR_FULL;
 		else
-			return -EINVAL;
+			*color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
 		break;
 
 	default:
@@ -5430,7 +5430,7 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB)
 			color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
 		else
-			color_space = COLOR_SPACE_2020_YCBCR;
+			color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
 		break;
 	case DRM_MODE_COLORIMETRY_DEFAULT: // ITU601
 	default:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4b8101bf62e9d..2e779f5cd43e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1091,7 +1091,7 @@ static int amdgpu_current_colorspace_show(struct seq_file *m, void *data)
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
 		seq_puts(m, "BT2020_RGB");
 		break;
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 		seq_puts(m, "BT2020_YCC");
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/basics/dc_common.c b/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
index b2fc4f8e64825..a51c2701da247 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
@@ -40,7 +40,8 @@ bool is_rgb_cspace(enum dc_color_space output_color_space)
 	case COLOR_SPACE_YCBCR709:
 	case COLOR_SPACE_YCBCR601_LIMITED:
 	case COLOR_SPACE_YCBCR709_LIMITED:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
+	case COLOR_SPACE_2020_YCBCR_FULL:
 		return false;
 	default:
 		/* Add a case to switch */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2eae1fd95fd06..4c88dbdb69f43 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -173,7 +173,7 @@ static bool is_ycbcr2020_type(
 {
 	bool ret = false;
 
-	if (color_space == COLOR_SPACE_2020_YCBCR)
+	if (color_space == COLOR_SPACE_2020_YCBCR_LIMITED || color_space == COLOR_SPACE_2020_YCBCR_FULL)
 		ret = true;
 	return ret;
 }
@@ -244,7 +244,8 @@ void color_space_to_black_color(
 	case COLOR_SPACE_YCBCR709_BLACK:
 	case COLOR_SPACE_YCBCR601_LIMITED:
 	case COLOR_SPACE_YCBCR709_LIMITED:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
+	case COLOR_SPACE_2020_YCBCR_FULL:
 		*black_color = black_color_format[BLACK_COLOR_FORMAT_YUV_CV];
 		break;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 802c0e19d03b3..84474d5122284 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3296,7 +3296,7 @@ static void set_avi_info_frame(
 		break;
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
 	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 		hdmi_info.bits.EC0_EC2 = COLORIMETRYEX_BT2020RGBYCBCR;
 		hdmi_info.bits.C0_C1   = COLORIMETRY_EXTENDED;
 		break;
@@ -3310,7 +3310,7 @@ static void set_avi_info_frame(
 		break;
 	}
 
-	if (pixel_encoding && color_space == COLOR_SPACE_2020_YCBCR &&
+	if (pixel_encoding && color_space == COLOR_SPACE_2020_YCBCR_LIMITED &&
 			stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
 		hdmi_info.bits.EC0_EC2 = 0;
 		hdmi_info.bits.C0_C1 = COLORIMETRY_ITU709;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 00de342e5290b..3050807c8da02 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -616,7 +616,8 @@ enum dc_color_space {
 	COLOR_SPACE_YCBCR709_LIMITED,
 	COLOR_SPACE_2020_RGB_FULLRANGE,
 	COLOR_SPACE_2020_RGB_LIMITEDRANGE,
-	COLOR_SPACE_2020_YCBCR,
+	COLOR_SPACE_2020_YCBCR_LIMITED,
+	COLOR_SPACE_2020_YCBCR_FULL,
 	COLOR_SPACE_ADOBERGB,
 	COLOR_SPACE_DCIP3,
 	COLOR_SPACE_DISPLAYNATIVE,
@@ -624,6 +625,7 @@ enum dc_color_space {
 	COLOR_SPACE_APPCTRL,
 	COLOR_SPACE_CUSTOMPOINTS,
 	COLOR_SPACE_YCBCR709_BLACK,
+	COLOR_SPACE_2020_YCBCR = COLOR_SPACE_2020_YCBCR_LIMITED,
 };
 
 enum dc_dither_option {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index f810825322ba9..57de41f3c0332 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -420,7 +420,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 			dynamic_range_rgb = 1; /*limited range*/
 			break;
 		case COLOR_SPACE_2020_RGB_FULLRANGE:
-		case COLOR_SPACE_2020_YCBCR:
+		case COLOR_SPACE_2020_YCBCR_LIMITED:
 		case COLOR_SPACE_XR_RGB:
 		case COLOR_SPACE_MSREF_SCRGB:
 		case COLOR_SPACE_ADOBERGB:
@@ -432,6 +432,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 		case COLOR_SPACE_APPCTRL:
 		case COLOR_SPACE_CUSTOMPOINTS:
 		case COLOR_SPACE_UNKNOWN:
+		default:
 			/* do nothing */
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index f496e952ceecb..f8f1e98f646e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -393,7 +393,7 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 		break;
 	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 	case COLOR_SPACE_XR_RGB:
 	case COLOR_SPACE_MSREF_SCRGB:
 	case COLOR_SPACE_ADOBERGB:
@@ -406,6 +406,7 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 	case COLOR_SPACE_CUSTOMPOINTS:
 	case COLOR_SPACE_UNKNOWN:
 	case COLOR_SPACE_YCBCR709_BLACK:
+	default:
 		/* do nothing */
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 45143459eeddc..1e756c0858d04 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -323,7 +323,7 @@ static void dcn31_hpo_dp_stream_enc_set_stream_attribute(
 		break;
 	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 	case COLOR_SPACE_XR_RGB:
 	case COLOR_SPACE_MSREF_SCRGB:
 	case COLOR_SPACE_ADOBERGB:
@@ -336,6 +336,7 @@ static void dcn31_hpo_dp_stream_enc_set_stream_attribute(
 	case COLOR_SPACE_CUSTOMPOINTS:
 	case COLOR_SPACE_UNKNOWN:
 	case COLOR_SPACE_YCBCR709_BLACK:
+	default:
 		/* do nothing */
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index f4aa76e025185..119fb97d0532a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -94,10 +94,14 @@ static const struct dpp_input_csc_matrix __maybe_unused dpp_input_csc_matrix[] =
 		{ 0x39a6, 0x2568, 0,      0xe0d6,
 		  0xeedd, 0x2568, 0xf925, 0x9a8,
 		  0,      0x2568, 0x43ee, 0xdbb2 } },
-	{ COLOR_SPACE_2020_YCBCR,
+	{ COLOR_SPACE_2020_YCBCR_FULL,
 		{ 0x2F30, 0x2000, 0,      0xE869,
 		  0xEDB7, 0x2000, 0xFABC, 0xBC6,
 		  0,      0x2000, 0x3C34, 0xE1E6 } },
+	{ COLOR_SPACE_2020_YCBCR_LIMITED,
+		{ 0x35B9, 0x2543, 0,      0xE2B2,
+		  0xEB2F, 0x2543, 0xFA01, 0x0B1F,
+		  0,      0x2543, 0x4489, 0xDB42 } },
 	{ COLOR_SPACE_2020_RGB_LIMITEDRANGE,
 		{ 0x35E0, 0x255F, 0,      0xE2B3,
 		  0xEB20, 0x255F, 0xF9FD, 0xB1E,
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 84f9b412a4f11..09b14aeb3c840 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -383,10 +383,10 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 				colorimetryFormat = ColorimetryYCC_DP_ITU709;
 			else if (cs == COLOR_SPACE_ADOBERGB)
 				colorimetryFormat = ColorimetryYCC_DP_AdobeYCC;
-			else if (cs == COLOR_SPACE_2020_YCBCR)
+			else if (cs == COLOR_SPACE_2020_YCBCR_LIMITED)
 				colorimetryFormat = ColorimetryYCC_DP_ITU2020YCbCr;
 
-			if (cs == COLOR_SPACE_2020_YCBCR && tf == TRANSFER_FUNC_GAMMA_22)
+			if (cs == COLOR_SPACE_2020_YCBCR_LIMITED && tf == TRANSFER_FUNC_GAMMA_22)
 				colorimetryFormat = ColorimetryYCC_DP_ITU709;
 			break;
 
-- 
2.53.0

