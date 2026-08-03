Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EA3A7F61
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788832; cv=none; b=X5s+vmymiUajv5uu/AZsartnZ4+J0GSSjvP41X9GBPqufitZLjWQJxL2kznEc59LXHc8VIrtbgqcRYZCWsxfbQ0pT7wEXsPLIIfBaMBlxuoER0bZau32vPjw6ZiP8w0jVKfYKFODfp5/8dFuyQSLtcBvLfq17Lcp5qngTe96dM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788832; c=relaxed/simple;
	bh=YFAMosxxcOs9CKxFxJkccZqRqWCiBvTUD+RyDwucxN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sgamc6Fisfxv9uqkNpNtNsU08EgJWZdV2aF2TTDAcv+bAW4M+A+wHs9brDxdXoWW3gMFK5MCUPy1/iyd0To5ssX5NIVJw9xP32BvWcIlOQSbEIoTQN8238qxeiJZy4b/cV3letotJ+ZekjP2tl1tgmBMUDEvpR0S7yk/8/C/UiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLXyKdmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLXyKdmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5D51F000E9;
	Mon,  3 Aug 2026 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788831;
	bh=chasIrtx4zvYk520PHRmKmSxQJkbtXLEWSeyE4L+0q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QLXyKdmVY62v2uJW0OReKl3K8Gupc0b0ZXYygjC9SyCtI0zZTD8g9olf0ufjGY4/o
	 235QGVeqo/hiLjv7MYFgS9te3AxleHA0m7uE07Uh782xmvCoYjZ57wtg/B547yVWFr
	 z2v5Z2bDHfH7Mu+RpMYlV7727foxITHh7TRBO0ElEMY6Zkc6035wyeXNNl8LcvUZqn
	 AfnfzK6KXVPyrJko6sxNrf1XVH6ZxZL0ZMZxCBidhkx0fMKWfJCS4+imrUY2eFBe1X
	 i7yrRCUYX8MDl6963D+B+EQXsAbXmzKavmad0G23dvSFO7gZj0UNI5lWeAbR6B97PY
	 Sfaa6ZK1GDpWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/i915/vrr: require valid min/max vfreq for VRR
Date: Mon,  3 Aug 2026 16:27:08 -0400
Message-ID: <20260803202708.1647756-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072955-extent-livestock-97eb@gregkh>
References: <2026072955-extent-livestock-97eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit f8a9262c7a6fc2de9802e14b0228114f0333869e ]

Ensure the EDID provided min/max vfreq are valid. Most scenarios are
already covered (by coincidence) through the checks in
intel_vrr_is_capable() and intel_vrr_is_in_range(), but be more explicit
about it. At worst, a zero min_vfreq could lead to a division by zero in
intel_vrr_compute_vmax().

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 117cd09ba528 ("drm/i915/display/dp: Compute VRR state in atomic_check")
Cc: stable@vger.kernel.org # v5.12+
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260625131040.1051272-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 1765cf59f517b02f3b0591fe5120930d08bddeb6)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
[ adjusted context to 5.15's `intel_vrr_is_capable(struct drm_connector *)` form, inserting the guard before the existing compound `return HAS_VRR(i915) && ...` instead of upstream's refactored bare return. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_vrr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index c335b1dbafcf8..25abc437b6197 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -26,6 +26,10 @@ bool intel_vrr_is_capable(struct drm_connector *connector)
 	 * EDID monitor range also should be atleast 10 for reasonable
 	 * Adaptive Sync or Variable Refresh Rate end user experience.
 	 */
+	if (!info->monitor_range.min_vfreq || !info->monitor_range.max_vfreq ||
+	    info->monitor_range.min_vfreq > info->monitor_range.max_vfreq)
+		return false;
+
 	return HAS_VRR(i915) &&
 		drm_dp_sink_can_do_video_without_timing_msa(intel_dp->dpcd) &&
 		info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
-- 
2.53.0

