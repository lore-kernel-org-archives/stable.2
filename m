Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10794E06E2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598798; cv=none; b=YqyUXbQ8CvcBlgPKFkFfKH5xvkW/3yvAcvZl8GOfj1cEWI3dj2uEP20C81Lk41U4haRicC/c+nAJrWYI6Lv/UWkMj5+vlIp9k3ZoAOuq3pF63ZRqctbB/YEwZnKQFQmFWd2+iKAep/T+cdqJ7vBaMBYtg2mwZyXcQgD/ekdglBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598798; c=relaxed/simple;
	bh=SeYxyODKU84DhOH95rBbGCC1CQCql/CvngXsqtFaF2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1UlbXYz/KJCajb7wUsIjQ4lrwUgMecPG8A2OMAAYF288uQsDj5f+qWX5yCRz2dGTaToIAHV+pWBH/SIPDgd3qgrJq9iFkXI0GCK/E+4WMLSLoGNpmWqPmukGKkkhUChCsySzNth7YJbNiCyf9ZQV/wO5wV9PJbcoopdNtW92yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZmALTcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZmALTcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9021F00893;
	Wed, 16 Sep 2026 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598790;
	bh=HTVpvD3HSgRVok0VY5arHvwnWTtBWCZCXki7aWzq0lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZmALTcRYw62v3JI1N6jyebaxHPWuqGVUBmg0N/I78R9ZKENU7+HJ0rb2c99dg/Xk
	 BX5QMtgaefDewsTw2n0nbtT5PUnfKOlMFm3tgErP7QpQ9GQSFF6P4AEs5OlzW6b09/
	 wVq47ispVr5alAicyp4pRcKIaTGFNOWwPI/kDpdL9hj2mv/Z5/FdOSZeUbZ4R/gv48
	 Ou2jogUgVcBrb4qcHcbXcnFhQGBijXmTIm6QIhDDaVvlTG/DJ/BDdct8f2ok+FMSrj
	 /v/HMO9PhUnSMGvVlJ6hB5+DwiYW9Xtj9dCGu21LjcTvhSCxZS7/wyaeqhcGjaP4pg
	 3i/TnSzoqAgwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Satyajit Roy <sroy14@alum.utk.edu>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
Date: Wed, 16 Sep 2026 18:46:28 -0400
Message-ID: <20260916224628.3197864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091655-camera-corsage-45ca@gregkh>
References: <2026091655-camera-corsage-45ca@gregkh>
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
index 170c6b8d0a5f6..b83778a660b46 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6891,10 +6891,14 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
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

