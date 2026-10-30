Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380417;
	b=HURc+OlLwNNi4vBLiyTg1l2mQUUKIfGlljJurHY1YPznEE+eqg+7xI3xlRr2lFTITzN4
	 My4NqxqLWirkLs0pvqFug51uieQolTLOpodSrzqfefQGi2hBOntTpbrOa4R4yoUB2PHGu
	 bZgIwT7nPqH+XaSKkUQMPztv+LYdtAvDhsO1y/hZ/jwmWqkM6WRnZ0topy69ZAvBnf5+w
	 i2nzGzSikpE0QmhpMfNXq5JhTV9YP5rGTlU3b9WwdndLboUaiDzvRCWnF/GXqbYlHrGDu
	 PWmkUi6R5WvUwc6g1Hcqh/8oLSj1Ygh4i0XM6dKTzDIQ+XMrYDw+4UwD5w+0UW+WoJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380417;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Organization:Content-Transfer-Encoding;
	bh=YsvkqUolOyVqy42ItvaKFQgNFXxGNmzaNP5avNiLKKU=;
	b=DGEI5WX+OfU95SxtPcFWtirc1R/H7LhJtNmQEBLRzvHI8GuvAfR1MbjCkxaM9vuiLa/x
	 2bwilMWdWwtpQBELErvqmhtOzxx41FGhOf93DQI+HzKM0mPiwfDRcuVtp/aP2ZpDUNhte
	 PhSlxL9Hfy5n1kMbiGtCQLnk/j1Su7/9TWXVnyCXjmcg00iQdLq/PtBnMu0aLES4aH5in
	 mN0tosdygmcF30zlhqYVW9esNVFoYcZp+ouQF4JK1GQKJoYFOupGVxYil42F3Wk7FrLnJ
	 AONDdjYBtdzzJzZnMRpKkVv725Vi9S0vsnL8gvuvGg1d4ROdTfE92YAnjuS4BpsRuIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="RAue/9ED";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7B606A32E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7C7B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RAue/9ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793380417; x=1824916417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dn66xtlWVM5p5roDqExY1oIyYiZ3koqc9OpCuTzbkdg=;
  b=RAue/9EDVqgUndqRtW14AXW6nlz4022wXndnk2ysZVhVDzDe78iJScmv
   ucgt1StMqeqZfvI+BxZOF5L3sM/6eCVtGo4vtO5W+tYXLmKeVMTNyfb5P
   +6yZ1awjnSE1rkOsux25rqhVncNlOCcMHDkKr/6eV8sBYTaYhQycrSarS
   Oqu3cSP0K1l/Cx+Pv0gKbG7geS4JHSIQxoOm90KBXT7Isdu9mGB99MHq/
   Z/cWzOxeKRFXxhZXpBtaFW6M/ntiBUMqKWMhL7YAOw+EdDFAGIG2bWvDr
   J3UQG/gGZE0vpJMZw8zgD1wxwL0o0Nm1YYR02nG3RCBHXGUrL3qqXI7an
   A==;
X-CSE-ConnectionGUID: VifQMztbRrGHe2ZjEkXS9Q==
X-CSE-MsgGUID: UmVE/MbHQOysJE9BAKI65A==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2174307"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2174307"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:13:36 -0700
X-CSE-ConnectionGUID: STNttM4kSjeOD7TdnJQMMA==
X-CSE-MsgGUID: dlD91MbBScG/Y1pNBqCJZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7311367"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:13:34 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 01/10] drm/i915: Disable port sync if VRR is enabled
Date: Fri, 30 Oct 2026 19:13:17 +0200
Message-ID: <20261030171327.29829-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030171327.29829-1-ville.syrjala@linux.intel.com>
References: <20261030171327.29829-1-ville.syrjala@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Using both VRR and port sync together would require extra
work, which we don't do. Trying this with the current code
will anger the hardware. Disable port sync if VRR is enabled.

This will of course allow the previously synced outputs
to go out of sync. It would probably make more sense to
reject VRR instead when port sync is used, but that's not
possible right now because VRR state is computed from
.compute_config() and port sync from .compute_config_late().
So let's take the easy way out for now, which at least
keeps the hardware happy.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a0aff087fafa..ed7d4cbbfb5a 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4599,9 +4599,12 @@ static bool crtcs_port_sync_compatible(const struct intel_crtc_state *crtc_state
 	/*
 	 * FIXME the modeset sequence is currently wrong and
 	 * can't deal with joiner + port sync at the same time.
+	 *
+	 * TODO VRR + port sync needs special handling
 	 */
 	return crtc_state1->hw.active && crtc_state2->hw.active &&
 		!crtc_state1->joiner_pipes && !crtc_state2->joiner_pipes &&
+		!crtc_state1->vrr.enable && !crtc_state2->vrr.enable &&
 		crtc_state1->output_types == crtc_state2->output_types &&
 		crtc_state1->output_format == crtc_state2->output_format &&
 		crtc_state1->lane_count == crtc_state2->lane_count &&
-- 
2.55.0

