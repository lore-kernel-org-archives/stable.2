Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A754135A53
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778410; cv=none; b=Ale3gG3SbfNlp3oqG9outXrHgFau0QtBRK6atE5rmsYqX9WTM4Ns57SHiLU7FmNIQPeGADgEmyKCti7o8WnHu65oVV8Rk7gM6wYJdrYJdSwR1mKOy+e5T23QJ07lS5Ls6EbEe8JbbJL59Kf8DRSWPzepkth0u3AvYiAnWUpkwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778410; c=relaxed/simple;
	bh=u2I0AUsfGydr1mXfffQfNFBUoEQnKwDa6IZkjCHNXWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pr9yDz4V9C1ZELEzyJY6LxToMQdcKzGOlUYs5pXsiKPgXss2qXYqrB2tbXNmjiImXNGTycmQPHObEw7eBCnBt6DZkZDSvB4c6q//y7G8sJIYEAbernxM4nrNe1cKD4kO3AL7rKe9AanTuVpq7PAeuK0I3mFO4mfAMvyighoEcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hz2NcBlx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hz2NcBlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791778408; x=1823314408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u2I0AUsfGydr1mXfffQfNFBUoEQnKwDa6IZkjCHNXWk=;
  b=Hz2NcBlx28xek+M0FpcUHRQg/GJaR4yrDURjM7KmBvCg9uTEu6F5CGgB
   UK4fqf9VxfNTRdiGO53+aRziW2CvTSD7XfM1JtrJWPhS7k7bzASpBbt3d
   0dZMJEtcdcMNQgsgg4jO4kDvFfkw2sZ1YxBZctiKYGgJ0z+XYEk77f7mM
   vjnvI5UNgsve405VuNnhWgEIAyiOgmKuXE6z076SPa9B1HJzJJcLBVkFs
   I/f75k5ypYKUJ8jDjWFasfgYO85Q2hx0sxPZ184vYGSWdDF4f6FzIz9ii
   iGawK0tG0t6x2cqKAqaO3qZnmdk+8qsA6+3rjEjSYdvAoKpQYPUbpMA/q
   A==;
X-CSE-ConnectionGUID: BTB/jbFsSma7sFed9HsDuA==
X-CSE-MsgGUID: Wf8BvfX7Ttm4071Q8b/uOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="470704"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="470704"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 21:13:28 -0700
X-CSE-ConnectionGUID: IMEdxLHcTa6M+WRxMHmihw==
X-CSE-MsgGUID: 2bP6F2T5QwmQvH9V4E2Adw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1095115"
Received: from mgolanimitul-x299-ud4-pro.iind.intel.com ([10.190.239.114])
  by fmviesa008.fm.intel.com with ESMTP; 11 Oct 2026 21:13:27 -0700
From: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v1] drm/i915/display: Allow port sync on PTL
Date: Mon, 12 Oct 2026 09:34:02 +0530
Message-ID: <20261012040402.3332398-1-mitulkumar.ajitkumar.golani@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some dual-SST tiled displays exhibit visual corruption on PTL, with
one tile's image vertically shifted or wrapped by a random amount
that changes on every hotplug.

PTL supports port sync, so allow it to be used to avoid these
display issues.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8991
Fixes: 05cffc074938 ("drm/i915/display: Implement Wa_16024710867")
Cc: stable@vger.kernel.org
Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a46ab5d3d70f..a0aff087fafa 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4629,7 +4629,7 @@ intel_ddi_port_sync_transcoders(const struct intel_crtc_state *ref_crtc_state,
 	 * From, xe3lpd onwards we have defeatured this with reference to
 	 * Wa_16024710867
 	 */
-	if (!IS_DISPLAY_VER(display, 9, 20))
+	if (!IS_DISPLAY_VER(display, 9, 30))
 		return 0;
 
 	if (!intel_crtc_has_type(ref_crtc_state, INTEL_OUTPUT_DP))
-- 
2.48.1

