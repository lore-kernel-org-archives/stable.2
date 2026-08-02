Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FF3C07A
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635366; cv=none; b=admpQWE1DLauqkA3c/513dozzBHx9Xmfza0usEx5uhtSfMmEN9lLcj2QA3TgHytKALUiMcGmasUjXKwOl+pJZ2t0QLWkFnhy39kQOzNYw2arZohCp9K7kUWLvJZgENuQvavCfuD1cqxdrgF1LUpJVGWkj99+1pEyFuTHvG24p3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635366; c=relaxed/simple;
	bh=3NbLx4u2t4eVSB555K6l0eH7LrS+lp0z72iGxw9ucf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=as3Adz2gVgHFxZcE5Llzz/QUN+6gGpf7tQw+h3Y8WWd4EhIgWKOYdgSz+Vb5IqzQ2GnI4qRQ3yR+K/6VXfQHiP7Dd1pFCw3r8q/x6aD9qSlw8546yh9H84yVCo4UgPeJdc9Pf+NiBsRMbpHZb40Fo2xdPbeXKSPpzxDKWmIjpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHeKTaCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHeKTaCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18EA1F00AC4;
	Sun,  2 Aug 2026 01:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635365;
	bh=ineTLq5Z4KBdmmDpY1LoReYXUXPYRuETkYmZUWQBQgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kHeKTaCdx2i6ozmOXeuVw1J2gDHVANpESOjXWvXT29bMRPFSCVhcvODpepWCVjWeX
	 uqjRbwGKom5n5o26Ad8ZCbJmWtKc/GDncz6UMpkVm/FFq6hNiatnFZLfKUed0WcEdO
	 Omx4M7Xc12jzbTMweZyOWqTUT56+I1BloPgygmv1eUUwVo8h9rU65hViUK/ILUPNLH
	 6MsYbvoB0Vv390Mw0PFwarjEdkVAxatBjK6AHP0lyOritGa94XJ+wyesAdyJ2DX1Sr
	 sGplfADXYFDC4X9eCviQcoi5bBMqFFu+amiWVpnFH02Xt5AOH84ens3FcmRMFBf9IG
	 XyjC/jTY5S3mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/i915/vrr: require valid min/max vfreq for VRR
Date: Sat,  1 Aug 2026 21:49:20 -0400
Message-ID: <20260802014920.506109-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802014920.506109-1-sashal@kernel.org>
References: <2026072954-ditto-footprint-1e46@gregkh>
 <20260802014920.506109-1-sashal@kernel.org>
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
index d7f5a5b55bf0..96de5e82af38 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -46,6 +46,10 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
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

