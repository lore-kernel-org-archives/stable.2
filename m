Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1992EA498
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642170; cv=none; b=d8vhQjUuhD2Ei6Ki2fJPMWxHlhCvJ2XdpFiJSQOoNXWbq70Kmnc3GXsrPwovxf+qowEF4AEQl4CMXhfSb2sxXUHRNtpJnFYKm22kaCzqGywyWKjKl+9vRaqXxxcx4GA/9tu/EXHW8d226ntAKQvaDCq7S2NUtZXbwH/bzQNkkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642170; c=relaxed/simple;
	bh=/XlE53LnOnMURXELT5dl7LZI0QvFTsaj4lx8FBXRJOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTYvLx+2i1wWXicEJv+/HcRX5udna8FWKFcDnQ2+tHxcYWErygBw0mfMD/a9i1GKhYn/w41kG4SC1NMFsYvu17O3a/p9XHzGfqyYCxQwkaUCbd+f/P4Ztont16R5D2rIUOzTYKEz+q6aJBxnb3fsNv+T8TVsV27X02amDX87Bro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1Lh1A25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1Lh1A25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270881F00ACA;
	Sun,  2 Aug 2026 03:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785642168;
	bh=rAQdD54xXPSjsRIdK9VILSSMyEb2IHLZ4kO2SZcJjxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1Lh1A25juUQKTMI0ApsAQ6l5cGEXVfkpiXkNcUG7G6bG033jOm6vw8hBulNF5h06
	 8AvoMsgYHl7rZBetGQNDtnh5ouEAkPTiy5BmyNz0lyFxyKvz/puvZH3PKoi8MfP8LP
	 RZG4VeQ4EcIT4P2QVBjOUSPwhCjBLsJNAcf8dylsWOa6pdZ+2bO/TdvnVrDeqCKvCu
	 4xCArb/rC/hgoQNpvXjjMYeE+sAjtuX7xOVoqkE7ZfGTIfJz0zh8wygf6yAvSzqUCp
	 kxQGFGLR7IW26QdKLOZkuFQSM9TPcJQjR9TR6WeUUOmHMGcgUNcDH8H8fSFQJDGQdG
	 LX6LdqK06Cz5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/i915/vrr: require valid min/max vfreq for VRR
Date: Sat,  1 Aug 2026 23:42:45 -0400
Message-ID: <20260802034245.2976489-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802034245.2976489-1-sashal@kernel.org>
References: <2026072954-entail-overdrive-8a88@gregkh>
 <20260802034245.2976489-1-sashal@kernel.org>
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
index 9c4c46cf3d3b..0082b822a30e 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -41,6 +41,10 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
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

