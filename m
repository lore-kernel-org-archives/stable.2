Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B230AAD8
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771054; cv=none; b=LCDxZqg5AFSYOO10ewpV5qYelHvF2o4nEXDzs94gKcqZ1C3vBzpYHxiGG+MYMYDZL9jGI8xwOcmJi/EE3larZxyNMIgIsRBFyOF/e50rIj9qooEHkUvF7/zWauzni08YMoiaF4JHpbteX3hOkHaIGFNpBtafbZ8+x0MokTl4aGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771054; c=relaxed/simple;
	bh=hUDv5iQblZTXiESi3awE4XRoucYX07jlROF1hstOPYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is8GFQm0CGnjnmuZxlzd9r7ye4wEKeImN3qPE2GTnXz2dEy63MOosm3/qV/UBY/EZk/R6AL/eHYQzYEVaHMxdF3u5kKYz+yjtlR24dyYQgp/P4bg+pVk2+JzyPN4sJwgyJriMra+dguaycGXVG/X2Ig3nzv30KQAF4YsDkLwor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MydPA+Am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MydPA+Am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61001F000E9;
	Mon,  3 Aug 2026 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785771053;
	bh=zWEgHu0D4r4aqdJl32uiezHpyVMeRwTRt57B8wM8BGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MydPA+AmmKa6GmTRMvrpZSbv/X/edo9ZRYMomkh84F+k4yvSwQ2BW2ZN8AL1Kwe5Q
	 XTUnxkV7ce9eQlxxqHfQWD1qYQsgTVvJpA+07p79PQ9q1Xy3sevKYdyUL5WTPKDP+H
	 2LlYsYrnJzqD3Gq8eknDWYr6+2BqHGdshes6qc8hGTOKtWmOGXoRF9f9//PJrZWy1Q
	 tnLKzXJNwO7EBM3n2Phq0shI8IFqUaF+6DB2TAFdCxx6I1aMQQZVtBCDggq9rTXN20
	 l5ANMtvnTine2qIFRhyn2RngsMrJesMh735xNHtNI2wR6RkRRoh0vBdSNqXI+PDBcC
	 UEf1ZnuRQ4hkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] drm/i915/vrr: Check HAS_VRR() first in intel_vrr_is_capable()
Date: Mon,  3 Aug 2026 11:30:49 -0400
Message-ID: <20260803153050.879503-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072954-fiscally-stellar-5adc@gregkh>
References: <2026072954-fiscally-stellar-5adc@gregkh>
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
index 6615e4153f37a..695d4774cc967 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -15,6 +15,9 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	struct intel_dp *intel_dp;
 
+	if (!HAS_VRR(i915))
+		return false;
+
 	/*
 	 * DP Sink is capable of VRR video timings if
 	 * Ignore MSA bit is set in DPCD.
@@ -37,8 +40,7 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 		return false;
 	}
 
-	return HAS_VRR(i915) &&
-		info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
+	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
 }
 
 void
-- 
2.53.0

