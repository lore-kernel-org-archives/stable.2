Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907DB1D5174
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406994; cv=none; b=f8p3yatOjHqiR25pHcUpi3wUHrstlJ3MfPxDA7fCkz5Rq7Q2lenwifApwk6AqGIo+m5Wznk0av45Vl/646FPO6+Fu4rfh+kusSF8Wyep/93cz05BsZb3FkVOW40wqJrRPj1PSdNV7S9RNmmVIEzu2HskzFNQKzl9U5BPRdxXbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406994; c=relaxed/simple;
	bh=fcnuWjNDpxYoqPLJY8tZDCmNmusN3hivYrhzF//HNOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4GrTBGojDPMRfXR/VXUaPh/kYZFuHI4navgDRjmxZoTt88vZc+sy8YYuSIs2GF8vRGXFUfHpgfdAuJgHwKY46vbLW6jlcDiJT1nKmLlTjssG9gLjQxvRgf+z/lhs37KJ+JrDQvPIvlIn0ltT9VqN+ZQ/9yqbeQrQpWaqV+rjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asBWxr5S; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asBWxr5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782406993; x=1813942993;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fcnuWjNDpxYoqPLJY8tZDCmNmusN3hivYrhzF//HNOM=;
  b=asBWxr5SfmzMAFHZ1kDLbe7YGTuByxTqjogNoXuod6un8VDGO9BwHHsh
   QQ89HVNCfKWNzVuQiSDu2/uFzoVMzCCXVoFGfQt/OXqCi/Y4IvCnff6Jd
   p9o8aqC7XUzkwVrA/AxITVhiTWO0VnbWdzRYUFybvKk6AI6OU/zrB7GDp
   ISjvoJ8YZ8gRLO/KoJF/df7aX0rHW5qnaJPgpwkwo2hyYggtPnAhvpUsv
   b+opbPfDryZMIrrpozjpdmIu6Us00g3mEYeolUtQRMy7NPCmlARaMeSAR
   aQMxma2dmjqW/2X5231bN6jgAY4N7hVjoy9I8ajelTHpyat+bM62cHr8I
   Q==;
X-CSE-ConnectionGUID: VhN0uIytSoW8Lk0QnbAyTw==
X-CSE-MsgGUID: unynUmwRS4enduyDu9lUZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83289076"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83289076"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 10:03:12 -0700
X-CSE-ConnectionGUID: 6s39jCKiRr+xXiPP/nKRFA==
X-CSE-MsgGUID: zWSJR28ZToikF1c6x2A8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="274187306"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 10:03:09 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Martin Hodo <martin.hodo@intel.com>,
	stable@vger.kernel.org,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH] drm/i915/hdcp: check streams[] bounds before overflow
Date: Thu, 25 Jun 2026 20:03:04 +0300
Message-ID: <20260625170304.1104723-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

The data->streams[] overflow check is done after the buffer overflow has
already happened. Move the overflow check before the write.

Side note, emitting a warning splat with a backtrace might be overkill
here, but prefer not changing the behaviour other than not doing the
overrun.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: e03187e12cae ("drm/i915/hdcp: MST streams support in hdcp port_data")
Cc: <stable@vger.kernel.org> # v5.12+
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index e88fec24af49..521786a75c42 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -145,6 +145,9 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 		if (!new_conn_state || !new_conn_state->crtc)
 			continue;
 
+		if (drm_WARN_ON(display->drm, data->k >= INTEL_NUM_PIPES(display)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id =
 			intel_conn_to_vcpi(state, connector);
 		data->k++;
@@ -155,7 +158,7 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(display->drm, data->k > INTEL_NUM_PIPES(display) || data->k == 0))
+	if (drm_WARN_ON(display->drm, !data->k))
 		return -EINVAL;
 
 	/*
-- 
2.47.3

