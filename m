Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234674F55B6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602137; cv=none; b=Vb6wv/q7TMsZ7Z4oOtu09x7LvwvX/chNgDeMj3yLiPp6LhmphgDKuNsDbqx66tpJNuhiwVb8cc+AySrgAxqClbkSYOq3xvrDGxiwiuA/YrLfSYpvyQCpw5+cVzPMCR8Ec8+nTRmpBiDr8K0RVKj7a45nsMIGY8vXolDqSvh4W/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602137; c=relaxed/simple;
	bh=rtKQJBT1pFTM+DWlHRlDtvU0eTVrag9owC6jFdcjn88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq9SfgbV+9l4bSxeLEslj7QvfhdM4bfyAjNZNj6KMF9fENIR52rO3lLyzXK5/+XcoSBhhMytp0Nd8FcM93NHq2DWqeyJhf1WN+ZzdAxftJSKRxxnymYDD/yLYKoFOn1WziNG+bz7YY+MOVkJe64Rqx+vMOwVhuh0i5K1JWAXNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiZHrikK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiZHrikK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215F51F00893;
	Wed, 16 Sep 2026 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602133;
	bh=nhcNnOUHnbVqd+o1Vl+MDviqHNrm9iy5Zd2V2SlNGrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HiZHrikKj0OggnFGBzhYqC+ntvPbUX7y6uHzgUwNEjy3rOf4ZFENU0KAHHQYMABGM
	 CsCfK2+sk7wMERTohBmlaqBsjLdQ8KT8YQaxSoWhZ2AubbduJ3ZUM2xKV2D7r+KuUu
	 GN4Hk4TdZwUPDIOuRjzkQ5AU/R8PMwSGs2cke5/L+x1azE0G0339QWwXMVI0r/WkI2
	 dEtMeeImVXZFUagHZhWJrAtyLtvwPSZZwbyyEqtNhYm+lXyK3cnDb0dJQgcGSGMSg1
	 XaDorwOtoDbbbE/oNVk/LEOTX0p+iWpEdiehGN+RGeEzWOiLwQaVvEszDK8UVVBIdx
	 3Azr2T04cyTWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Satyajit Roy <sroy14@alum.utk.edu>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
Date: Wed, 16 Sep 2026 19:42:11 -0400
Message-ID: <20260916234211.3296195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091655-squabble-justify-d868@gregkh>
References: <2026091655-squabble-justify-d868@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Satyajit Roy <sroy14@alum.utk.edu>

[ Upstream commit 7fca7acd60a228b62b4e9efa5f184738041e9564 ]

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
[ adapted the hunk to the older get_output_color_space() function in amdgpu_dm.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 06eb499f13637..5226224cf7027 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6511,10 +6511,14 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
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
 	case DRM_MODE_COLORIMETRY_DEFAULT: // ITU601
 	default:
-- 
2.53.0

