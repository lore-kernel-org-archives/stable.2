Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0091714AA
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785629231; cv=none; b=UVUthHSBSC68RmTHd5+oM5Uds8W0qaxiXnSEYdaB7L/Hdczoee19P0J7cAnbZGHn740KvBv548p/QxjT2/XmD9K5HbaKFpcS5+n3Nn0aowxSY5L7TG2Aswg+qU3KnOfsUfRFlmoJVpVQgI8SRapWuC2jO0CRWbhvL5i2vbHnfbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785629231; c=relaxed/simple;
	bh=yeNhvo/VGUufIidINGmC4ZSIqMtBVkY5Bp/aY+l0Fyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwGbiIufczM3jgXZ1LVVGI3soCAVv7HnXr15gM9CFHSId735Zjs8UfrErR3zsfoQexYHVtFxGSN3JJXvBFxkDJgkQ0RrtOm4esYym/9JQVc7gQzEz9Ji+XDcA1M5tKgTH4QaQmk4c0a9KZuqReC91vQm6rGcu2eZqbwXleUSnVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfUnUuyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfUnUuyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993E21F00AC4;
	Sun,  2 Aug 2026 00:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785629227;
	bh=LWxKcJHtQuBuU0UfRgSFXXHg5ybAJL5hK+2B9rDNv8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfUnUuyFUcCg+XRqa2R9zj4+3O2iCLMgTaqO9HBlI2EuVKd88hZ/qTm+F+rwRWpJF
	 9QTZZzrRmWYYt3qboQmknJblwFHLtvBpTXw7QaVzAPqQmt7a36bm4lV//xa+VyrQ8l
	 khRJ4a+j2XFb+IC2aF+ngD7Mo/Vpm+Aj1kf0aysbwKDWLRPW2/IKAB5ntvKme/v2Hj
	 Ykrojr9bVqnMSL2dShLE7T+L3o6EoDfgvBP6FSAZvnGmZO/omZfnkyIMNK2NyTSpQS
	 S0m5m6/VtFcy5GgiGpumTTMG0hy0DXz9I2lNHxIvBSRz+PD54ZLc0nuD5GHEL08Y/O
	 PjBz0FVURvVQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/i915/vrr: Check HAS_VRR() first in intel_vrr_is_capable()
Date: Sat,  1 Aug 2026 20:07:03 -0400
Message-ID: <20260802000705.2176332-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072953-fetch-friction-d92c@gregkh>
References: <2026072953-fetch-friction-d92c@gregkh>
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
index 04a2ea086fb2..2d66319aeb8d 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -22,6 +22,9 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 	const struct drm_display_info *info = &connector->base.display_info;
 	struct intel_dp *intel_dp;
 
+	if (!HAS_VRR(display))
+		return false;
+
 	/*
 	 * DP Sink is capable of VRR video timings if
 	 * Ignore MSA bit is set in DPCD.
@@ -46,8 +49,7 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 		return false;
 	}
 
-	return HAS_VRR(display) &&
-		info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
+	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
 }
 
 bool intel_vrr_is_in_range(struct intel_connector *connector, int vrefresh)
-- 
2.53.0

