Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8CEEC3
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635365; cv=none; b=u2B99rIW+GFPCUBYRvZrcnKyj1lAY9Z4KIrLHFOw8+ZU2a6igiS4Ug3FTVcss9K+lh+uGOWGIqU4Av9bkqTkVrKEa4Tp5iSyeBD5W3ii9mtKuGxZEJ58YQ2lwwHNwRbu0wU1UQjOewWQAloxLRN9MQNAAWA3QQlaMeunKVugRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635365; c=relaxed/simple;
	bh=nt/UhjYstZUdIHimoNsODJDeahqT9hjacZhBFz94MPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFrupuWBcKsgCqFRcdu4fshvmm175wbhHT3dGCNHJ1mHhEajDdDSxrHZ/zfEYoH/Rr4IRapHLpVGsDBfApZMlE9L0hZlbXu5HRBAbnSDlGMng181qyRcUpGw4ztLJlTEKTd8jY0KYvJsFc1IIVPUc+exmlz0IwhdXeCqp31RcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm0dqQNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm0dqQNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA461F00ACA;
	Sun,  2 Aug 2026 01:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635364;
	bh=5MPQkv98bX9sMNf4FsMIC0Aj9k5SX+QULiqZBhmf8Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mm0dqQNWeO2cFs5d86Eq3A+CSHUY8Xp8gZ/POClreVTI0rL7CFldk+ojQROhgSefQ
	 hVkEjo4XFyKix9KfNN5sMTmMKEcqqWEbV5PfWurV1qQYalmF/2VyGX2WsXDRgy7uYZ
	 hI8mDvX0x31BgAgb2tjEDrqSnV56LYITCYMjibIX/Hz5rlqNvmjmMaXZDWWunAlLNX
	 FEVTXTySF2g4HkgKvidjabXhvgKrbh7vmJKhLGqAMlcyatNV3EgTdrDbO7sxHyYxrY
	 B7q0EcHPSCzs8PLMa/VhxUZvMaKtJsDZllF23rRW1O3ZpshUHzVovgFYedloznKfj5
	 9yjozYsEgclng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/i915/vrr: Check HAS_VRR() first in intel_vrr_is_capable()
Date: Sat,  1 Aug 2026 21:49:19 -0400
Message-ID: <20260802014920.506109-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072954-ditto-footprint-1e46@gregkh>
References: <2026072954-ditto-footprint-1e46@gregkh>
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
index 9a51f5bac307..d7f5a5b55bf0 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -21,6 +21,9 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 	const struct drm_display_info *info = &connector->base.display_info;
 	struct intel_dp *intel_dp;
 
+	if (!HAS_VRR(display))
+		return false;
+
 	/*
 	 * DP Sink is capable of VRR video timings if
 	 * Ignore MSA bit is set in DPCD.
@@ -43,8 +46,7 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 		return false;
 	}
 
-	return HAS_VRR(display) &&
-		info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
+	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
 }
 
 bool intel_vrr_is_in_range(struct intel_connector *connector, int vrefresh)
-- 
2.53.0

