Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299A2F8E96
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771055; cv=none; b=W17qo8ZuYUwdNnhzKoCiFOgoZ2QdZ2PV8M60gGup8rDCh0nyVIHzce4ry2DJeRqco3E9JdORry28v6DkZGtfIsDy6KlHD8KnY+xQZdR9MMpYch4v3wBGhtVo0f9HZcnjmxbukEgj7+Zbwh3NhAXkP/RmLEpTd/v64r/VIu2BGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771055; c=relaxed/simple;
	bh=tIn9M0BBRiWoSgI1RPbHCKkiLlUz4Bn2Zt+uO9EqOQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcYEdpElsNG815mGv3SljgjasVNKr24pOavLoeBBygWjhdTUEEPSM0PXw4p5Y30xDEI9/iGhj6dKznLvjM2O9dGd92h84euYfI+q6h0zEvmu1eMO8nu4igEk6Z7DlZT2vWi/LjWtbCoWLwx7YZKaLg51z4JCsLZ1Rumjy7prbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atVM8AmG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atVM8AmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831831F00A3D;
	Mon,  3 Aug 2026 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785771054;
	bh=0sQ3HfDOhyAD9g9xT5YbFvP2KErZBwuLajf8bzNbQxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=atVM8AmGXkI+QgMdxcqhQX5NEou0Of0FAhGuRbEyom+mQgOxf9NuTjsJtlZRktRwI
	 FrNdqMdpsbatG9nSCTIcfnZ41UP0M1j9fUIxU+fji+H1UYvfKEJezPjqpMFicEaAOg
	 5yaiXoGbu2vGmJ5D3I+A2+7+y8W87F/2PV6ZBA2wPYL6Ix5l1o7T2WZ3J9e/SeGj9F
	 tsecXvOdaFV+U2MG7/4cVxwceHNkJIa7TKUS6dObJu6I9DHlqh4L7Fe59b/GX21B0f
	 2Xh4QFrhgsxrRR5Pl98PhvTws/Q7TR2rNrkIIaRwTDAa0yRv5FSkcVNg10Eg/cVkO5
	 0dSMgAx7xH7XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/i915/vrr: require valid min/max vfreq for VRR
Date: Mon,  3 Aug 2026 11:30:50 -0400
Message-ID: <20260803153050.879503-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803153050.879503-1-sashal@kernel.org>
References: <2026072954-fiscally-stellar-5adc@gregkh>
 <20260803153050.879503-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_vrr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 695d4774cc967..69b514198624a 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -40,6 +40,10 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 		return false;
 	}
 
+	if (!info->monitor_range.min_vfreq || !info->monitor_range.max_vfreq ||
+	    info->monitor_range.min_vfreq > info->monitor_range.max_vfreq)
+		return false;
+
 	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
 }
 
-- 
2.53.0

