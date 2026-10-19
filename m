Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440D4DA548
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409654; cv=none; b=fAbyy0tnWT5Sz5KlAwBYnEPUUWgVz6Tie9iXipf81U+brEwn1VnqSpBy0NLEuGGawJvJ6IcNDJkDHZ8OOT+d0w8i5hoW11lLWD6vVkc8LrT+aCu/bBQwsrg1h0tyc8BJUYF2GrXHmifV8C4qubQzewrarBivlwUg6BxQbOMEYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409654; c=relaxed/simple;
	bh=ihfiDfoieI6RGkGQq9OLZlprHMM8mG9TsCU0BGiOO2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltokQj4zC+LeVUBBLtEmPI6BJtwWejkAzIDvCdqEUQ1f+Q74XM9n96/YrzwSTYpTGSh1/qqbwDPws4EPdW6gPgxDudBrt+5U1eo63SHCKQgUQ5IaB5Rycn8w9xFmA15lJzXBkMKPgjawsHRhmfecs2YFPMl3hZmsrxBqrRr5E54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ns4Tt/yx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns4Tt/yx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792409650; x=1823945650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ihfiDfoieI6RGkGQq9OLZlprHMM8mG9TsCU0BGiOO2g=;
  b=Ns4Tt/yxCjCYYO3UIjuHm/c9qHVa26Fb5HP62X5cv1QJyBm8LNvxE4nm
   XMRoXlqO/5Rfl9LOYKtWcX1P0lcgFW6FP1GtPNw6M+ApNTeLvTcHTZYQ2
   6xy2CmdwdWYmlZTT2H/0Babch6Rmw+cSn+mab99LtS+OQ3KgKz8SrPFtm
   lWKsGgEOZckM/wKO8y5xGpLI7dxzWMH+j1du/9MoU1nZUWz2WK2KYqDc9
   hUMd6dxWB2wrmOVOz592fh/mBJ8qpxGHNOHgGnoY0F0t1TyH2VjlU9xvB
   NJXBVYvQpVxGoMJ1103/BxE1vKgUFGR1nqmKWI9ugxEAIKIljHszX2FNW
   Q==;
X-CSE-ConnectionGUID: 5VPFQMQQQg6nec9otGJFug==
X-CSE-MsgGUID: Vrx3Sl7lRt2PPWCsn4fFNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1109788"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1109788"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:34:09 -0700
X-CSE-ConnectionGUID: 6gtdcHEYQTag4WgzELjoUg==
X-CSE-MsgGUID: oIrclKQpRk+D+1Xr14KPGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2930791"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
  by orviesa010.jf.intel.com with ESMTP; 19 Oct 2026 04:34:07 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com,
	ville.syrjala@linux.intel.com,
	imre.deak@intel.com,
	jouni.hogander@intel.com,
	Xiao Lu <xiaolu.xie@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/dp: Fail the DSC slice config if the minimum slice count is 0
Date: Mon, 19 Oct 2026 19:31:51 +0800
Message-ID: <20261019113151.2258239-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_dp_dsc_min_slice_count() returns 0 if DSC can't be used for the
given mode: if the mode's pixel clock or hdisplay exceeds the maximum
overall throughput or line width reported by a DSC branch device, or if
the sink's maximum slice width is invalid.

Before commit 15f908bce5d9 ("drm/i915/dp: Factor out
intel_dp_dsc_min_slice_count()"), these checks returned 0 from
intel_dp_dsc_get_slice_count(), which its callers treat as DSC not being
possible. After the refactor, intel_dp_dsc_get_slice_config() uses the
returned value as a lower bound and since 0 is less than any slice
count, it selects the smallest slice config supported by the source and
the sink instead of failing.

This was seen with a Synaptics SST branch device (OUI 90-cc-24, dev-ID
SYNAR) in a USB4 dock, which reports the same 340 MP/s per-slice DSC
throughput as the monitor behind it. For 3840x2160@240Hz (2315950 kHz
pixel clock) the minimum slice count computation bailed out due to the
branch device's overall throughput limit, so the mode was not pruned and
was enabled with 4 slices on two joined pipes, ie. ~579 MP/s per slice,
resulting in a garbled image. With the monitor connected directly, the
same mode is enabled with 8 slices.

Fail the slice config computation if the minimum slice count is 0, so
that such modes are rejected as before the above refactor.

Fixes: 15f908bce5d9 ("drm/i915/dp: Factor out intel_dp_dsc_min_slice_count()")
Cc: Imre Deak <imre.deak@intel.com>
Cc: <stable@vger.kernel.org> # v7.1+
Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d8c0d9381..404839a2a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -910,6 +910,10 @@ intel_dp_dsc_get_slice_config(const struct intel_connector *connector,
 		drm_dp_dsc_sink_slice_count_mask(connector->dp.dsc_dpcd, is_edp);
 	int slices_per_pipe;
 
+	/* A 0 minimum slice count means DSC isn't supported for the mode. */
+	if (!min_slice_count)
+		return false;
+
 	/*
 	 * Find the closest match to the valid slice count values
 	 *
-- 
2.43.0

