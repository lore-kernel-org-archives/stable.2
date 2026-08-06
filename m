Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C99F388878
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027067; cv=none; b=Qx6tG8HJpfzll0MT9NpddA/R0h85talSq0GWR7GBEZeBL4GfaUsMR92c3d/w+VjTt8tvQLmVlRVkN8lINw9xIu4GRW0ytmY6NZVdMuspNTE2QB+7voZknB+qE279RT+9Ej8WX19Pg5vVarNKf9VHmPnlKZv128QUxId1RQC8RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027067; c=relaxed/simple;
	bh=vmLHm+zwXiWTCAu5G+/6YiSWRwAIifezyoYxoV4srLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZbvqSsF1DJeuAtjGiuvZRiXvzDzA1cGe+nf/j8xeGGOkfuQvcX7F3ZN3CB/wXAgZ5glvqjtTjs/Somr7idX+9uYmAGnda6dzNblteNweGIzuhqB0M/ch7GCkhG0ojrORTQ8UTHR0fJXO9PYdN8lz6ig88XMYAj6pqBfoFP2bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEMo0XmG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEMo0XmG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786027065; x=1817563065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vmLHm+zwXiWTCAu5G+/6YiSWRwAIifezyoYxoV4srLE=;
  b=kEMo0XmGN5l4if/kndj/abjL0HFNa9JOvoZ+c2h8YR8qXRx82rW/1HTc
   rsjhfqF7+O9Cf6MgEq+7/jg5qeHKAGVDTg0FbuXhh4vph/7Fy3tM3aWqq
   zxK//mNxzsnBfBdbmb2C4kcSL6lYfYpuhQXl5dDW4hT6LQEvRqIoak6Bu
   7qGtbuJsFBa7uYKdAcbOlaHvyPpWSGj9VPaxiISl+sXLyck4AL/PxGb+l
   93qvW2Tk4CF6KFHebbcBXRjvnf0pmLM2LxnkWQvv5bF/KbcKW7FcwYQRs
   M0xVwTiruZ7ae6v3MSWG94Pu/Fk4Yt6tLYEIg0FnH9JKZ3k9Rg3LYGndd
   Q==;
X-CSE-ConnectionGUID: PerswbPUTseHuAA0ERgq/g==
X-CSE-MsgGUID: nixLY4XQTGq1Wr4/Eq2XFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="109416254"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="109416254"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:37:45 -0700
X-CSE-ConnectionGUID: +c75znVoQ96J+9+dCL6P5Q==
X-CSE-MsgGUID: GXdJuoswS5q3r8vacfCuZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="265604190"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.228])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:37:44 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/display: Limit max joined dotclock on pipes available
Date: Thu,  6 Aug 2026 17:37:38 +0300
Message-ID: <20260806143738.2710312-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

Multiplying the max dotclock based on joiner availability on the
platform alone does not take into account the actual number of pipes
(possibly with some fused) available.

Limit the max joined dotclock based on the actual number of pipes
available.

This is still too optimistic due to other constraints on actual pipes,
but it reduces some of the false hopes at mode enumeration.

Fixes: f4f8f0eaaafc ("drm/i915/display: Consider ultrajoiner for computing maxdotclock")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 829d7a411dcc..44c5d1dde255 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -8113,9 +8113,10 @@ static int max_dotclock(struct intel_display *display)
 {
 	int max_dotclock = display->cdclk.max_dotclk_freq;
 
-	if (HAS_ULTRAJOINER(display))
+	if (HAS_ULTRAJOINER(display) && INTEL_NUM_PIPES(display) >= 4)
 		max_dotclock *= 4;
-	else if (HAS_UNCOMPRESSED_JOINER(display) || HAS_BIGJOINER(display))
+	else if ((HAS_UNCOMPRESSED_JOINER(display) || HAS_BIGJOINER(display)) &&
+		 INTEL_NUM_PIPES(display) >= 2)
 		max_dotclock *= 2;
 
 	return max_dotclock;
-- 
2.47.3

