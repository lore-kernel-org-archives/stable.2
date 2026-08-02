Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214319DF6A
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785629234; cv=none; b=f3IMcbadz1OXUfKoug/la4O7QdeM49BhLdBcRlghdZCGzGv5XqA3ZYBPwI5/7g7KX9pbBZB39GgnmrtZlNiwaPfWfuXhAwx9rY13vY5emR8sPnDwVcrul873phGYlRC/Wp1Tse7GMf1D9pOxXJv1mGYPxoDrC0TNtpXY0bB7r8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785629234; c=relaxed/simple;
	bh=VQWHs+7F3Q24WouhAlcpqdOgxKaRyYWH26mQut7QmDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IR4Co+pCPUSclmZcQhnqnBFeEncvo0ndGXm8yTbhbBr+aeqPJziz8N5gVOH/Skf9FqAiNk0mkNdFbZ1xxUZI52SZg38vRjt/L0jHkYM8w91a4tkKx9/3+HFwXtanPj2TrQYR9f29fcy33HfNbFpf7D0iARi65EjGOOxnhFuZ+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKggTHVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKggTHVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE381F00ACF;
	Sun,  2 Aug 2026 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785629228;
	bh=butmcV5OI6L0m0nquT5qXzeqiW5+VURkLjEQNWxu2ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKggTHVIrP2JsElfykERpRmprAgMnl0J7n8iOABmb0j/4CouGk5LrSQrLXSCU6+G0
	 wYdJfpJJvHxd8lCsZrxQpwZr6UUmU1be2qkR8abtOCyCmH+ULgLc64TLRA9zM5Oq0M
	 QGbFh7R3SKf4m8jKC76y/AOoKSfNwS7ZmKwrXEJGGKLfFqvVIzNVLn8WeBapSfr/+d
	 QW2ynSDKmmDJeqEayCmdCOYgCM61/WBWViK/Ixv/yAvxQ4uvOw8ze6RnDWjjc6UnBS
	 gNlpF/u6o8ZEDuoKANDV6y+L89uKKysLQ/fC3pKZYdDVGTxh4/LHPWPubHW0yCwWz3
	 pLLTlHLY8SWRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/i915/vrr: require valid min/max vfreq for VRR
Date: Sat,  1 Aug 2026 20:07:04 -0400
Message-ID: <20260802000705.2176332-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802000705.2176332-1-sashal@kernel.org>
References: <2026072953-fetch-friction-d92c@gregkh>
 <20260802000705.2176332-1-sashal@kernel.org>
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
index 2d66319aeb8d..3ac6cd74ae15 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -49,6 +49,10 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
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

