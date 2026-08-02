Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742A2E8B67
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642169; cv=none; b=OyF6vsy+LQGEh/GLLkJqxC2IW8wjix6eC00hmzyHVqvZrhuOlN88TGKKtWFyD+lxRElT5QwlIYQ94X29E0Dva6F1T+QjU6Evi4w6UM270AryK9K6gGpR3WrBZ7ZTOH8mhXxQn1GaF+F+WvJfEe/R/x3/pY3ziYyXXVJI5Nsj2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642169; c=relaxed/simple;
	bh=J7e4WePFlBZk8Q1+AJKPpf1BMHAgOm4AenHrcQwa58Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmM32V+xiYd2HUGlJvp2Dwa5sk5N2m6Wo5TEClLuBnAq3QSVPHxMSUIR99IlZppTdqqpyPqQVqF3MnfYx2vY2fQwTiJXwEEV8uirTZvFHWLLQoyHvbrc1WJqGJIh3+GKzbpaMnM+2eRF39XkK32LEKP7lq4IbbE+WGHWzwJ3q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfp/ShY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfp/ShY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A9B1F00AC4;
	Sun,  2 Aug 2026 03:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785642167;
	bh=e0RkjIlMoYxAHsxTEUaJRZ6Bj/rXXl7EMWKL8kEBdZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sfp/ShY04nRwJQsSoNKOmES48BV3mv1uNoZnz9qhUqz/LIUd0IQr/1kvNYuVBL/wy
	 JDIz0TZ++RkoE2MLzQuHnX2XYL0YUKU7ebQUK+qq4l6mCSPxT+DXeT7Rq9kYEqCPdf
	 Z/G4fIyyvZRuho1QBDF+1rOLq6V1WHav7LgijFyYLBT7ZJnVzOWPrtxMpR1gquS3cF
	 x/4RT8YmXxq8qyKs/LkvRmAMUICDDbdp/9iyNcrmbBxP1Ki/aWb91ImXIQg6KxGnwA
	 UDI2EQheg4rcuz6gI2UxY+ZdeDbOBjYbMG/wvIKMGqw+wKBrU3BFh2INkEOXTpYfn+
	 ZXtH4juJczYmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/i915/vrr: Check HAS_VRR() first in intel_vrr_is_capable()
Date: Sat,  1 Aug 2026 23:42:44 -0400
Message-ID: <20260802034245.2976489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072954-entail-overdrive-8a88@gregkh>
References: <2026072954-entail-overdrive-8a88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 4b274b0b61ab2a529e5c22e9aa033f3028e639fc ]

There's no point in doing all the other checks in
intel_vrr_is_capable() if the platform doesn't support VRR at all
Check HAS_VRR() before wasting time on the other checks.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20251020185038.4272-23-ville.syrjala@linux.intel.com
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Stable-dep-of: f8a9262c7a6f ("drm/i915/vrr: require valid min/max vfreq for VRR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_vrr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index b844bdd16de9..9c4c46cf3d3b 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -16,6 +16,9 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	struct intel_dp *intel_dp;
 
+	if (!HAS_VRR(i915))
+		return false;
+
 	/*
 	 * DP Sink is capable of VRR video timings if
 	 * Ignore MSA bit is set in DPCD.
@@ -38,8 +41,7 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 		return false;
 	}
 
-	return HAS_VRR(i915) &&
-		info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
+	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
 }
 
 void
-- 
2.53.0

