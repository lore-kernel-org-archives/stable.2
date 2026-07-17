Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70939DBE4;
	Fri, 17 Jul 2026 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314432; cv=none; b=Zt+gi5XG1ki/2eBh7mPdeRKBnVoJLPlNThzEm00SgOHDMj1/NnxpWbZ2A1xdVlrWc+UNlCvb7cAa9yw/xMFQFEDVSjLuKPHZgFdOr4zmZFM+mcrhT0pubRe3GHkalIJxQCrXJiopfVjpIEOgLMkZzvHvZVc2my4rjw3kP6FnLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314432; c=relaxed/simple;
	bh=1AO5W78NhVX0WLOqrDInGhKoC0dyNJy9H267o/k3x0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYx2HniuAqTvELmwXYdWwmVfDWvfgFqsZYKJbjZ2cTm0gNoewCWpZvSxMoYYwZItDoFM4Jddcbtmex5822yGWJmGTen+XOxNHkIYwzfLyfJvmUksR8iobpph9nsoyvqt+sVbhnPcaZPyFKYkJRf4qwdXv1EpjkPfEZFjCCTkRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dc+VszDy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dc+VszDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314431; x=1815850431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1AO5W78NhVX0WLOqrDInGhKoC0dyNJy9H267o/k3x0w=;
  b=dc+VszDyRRJMPnM3TkSTk/nFk0gbHBWZJKunQg8zcFCy2xLr2vntqzzs
   PgWwLJ4PSZ3mxHD06BJxUo+YLza7wlrNSEi/sRVpvCa+CgD/bMXW/9/l6
   ewdi245CryN1r9yYsG7SudfpYrnMT5K2serZm9UNH24Vrc8MT4RVoenUG
   E3BzIXS5rw8llOg2yEF2hK6t7suRgqt4885LYnBLWYa0vxmH1utISiXUI
   7Qc7xRsJAtliQeLlQpFEyXQpbxuN9lecgoBeeSZHbBjHFsta1S0puHodk
   KhyXdy7v9O8i74kbJAQa1TZ+5jKIF6aFmSoTUVDvD4tbPmLqE/aknYBbw
   w==;
X-CSE-ConnectionGUID: /vHKrlgUQWKXEcOsz1CvAg==
X-CSE-MsgGUID: IZyM+gE8SPmyMNz3j8xF4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347631"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347631"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:48 -0700
X-CSE-ConnectionGUID: RXfXfxzPRlWSjNwAP51I4Q==
X-CSE-MsgGUID: sXhcT6FnTmGb+QP95TeDiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827248"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 08/13] ice: use READ_ONCE() to access cached PHC time
Date: Fri, 17 Jul 2026 11:53:30 -0700
Message-ID: <20260717185340.3595286-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

ptp.cached_phc_time is a 64-bit value updated by a periodic work item
on one CPU and read locklessly on another.  On 32-bit or non-atomic
architectures this can result in a torn read.  Use READ_ONCE() to
enforce a single atomic load.

Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ec3d89d8d4d3..1469038bc895 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -346,7 +346,7 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 		return 0;
 	}
 
-	return ice_ptp_extend_32b_ts(pf->ptp.cached_phc_time,
+	return ice_ptp_extend_32b_ts(READ_ONCE(pf->ptp.cached_phc_time),
 				     (in_tstamp >> 8) & mask);
 }
 
-- 
2.47.1

