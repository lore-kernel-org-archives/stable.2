Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BE39DBFC;
	Fri, 17 Jul 2026 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314433; cv=none; b=CuZWny8T3gVWXzvxoZUsrFOY+/Gf/G4VbB/M3ic74uE87cWtFIz+huRe4FqyC4ZtDBtoqDxSxD84dFC6yZ2Rq4gNuQ8D1O782OlgXO/V3fAqLmjEznngEkAftckqwY9c2F0KaoLik6PMv1ijtd2BO+K8JX9Ky1Gj7VZFC3zyv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314433; c=relaxed/simple;
	bh=nZ70++5OQd2qI/EgwJYyFBbsjrqoZEdjl9QcQwO74q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMkUsu19ICFTytY0+NrwwefDRqjcnXUw/ncL5Nkvp/2I83dwd6MgW2lMYq2itkJfW/BlUJVGKjs6KHDNZPWfZzz7RTQc0DXz8ldv3WH9DhjMzjwwVwWeboz1m0MEhYk7pQWtqxY9S1+Hh0DPnDb/2C1QsGC2E/HrUlRXN71vzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoDArHxF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoDArHxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314432; x=1815850432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZ70++5OQd2qI/EgwJYyFBbsjrqoZEdjl9QcQwO74q0=;
  b=WoDArHxFE4MmazVy3zpqYHazfy6Fnq4PVo+9rLbO5GO9NKLjkWuNWpTZ
   PAJRtUir+AG+T96vjQWNbeQkMaImh0e/XVWvmlXsc+UKw0CcYdILdcNLy
   VSuYNIpL9thY35ih0SHaSeMIe1VMUP5tavCOs1R9lQaP1XGgS5/t9XjBS
   eXptFQAKuKgkf64jPP6N1O22ruRVwaE3AcFHkci5uHJrt/SfzZjr4ffQM
   fWP4GqioUHe/KBjNEejVRmMcE4iPzc1DOmUnPwEQK5VmGyrHMGE50UDJI
   Ibvmx6Me/oi87QaVDnFWOyue39VLODtDxc29dJ8m1iQ+9j1EMcwW0rbIH
   g==;
X-CSE-ConnectionGUID: +batF9PQR+2DDKUHp0OGcw==
X-CSE-MsgGUID: v9PSwjqGQLegYgDT2tFgLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347639"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347639"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:49 -0700
X-CSE-ConnectionGUID: pfqfVWw4Q9+vl2iyDrq40Q==
X-CSE-MsgGUID: 8BqFY3DJRVSAfEX28i9mXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827253"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 09/13] ice: fix PTP Call Trace during PTP release
Date: Fri, 17 Jul 2026 11:53:31 -0700
Message-ID: <20260717185340.3595286-10-anthony.l.nguyen@intel.com>
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

From: Paul Greenwalt <paul.greenwalt@intel.com>

If a PF reset occurs when the PTP state is ICE_PTP_UNINIT, then
ice_ptp_rebuild() will update the state to ICE_PTP_ERROR. This will
result in the following PTP release call trace during driver unload:

    kernel BUG at lib/list_debug.c:52!
    ice_ptp_release+0x332/0x3c0 [ice]
    ice_deinit_features.part.0+0x10e/0x120 [ice]
    ice_remove+0x100/0x220 [ice]

This was observed when passing PF1 through to a VM. ice_ptp_init()
fails because ctrl_pf is NULL and sets the state to ICE_PTP_UNINIT.

Fix by detecting the ICE_PTP_UNINIT state in ice_ptp_rebuild() and
returning without error, preventing the invalid state transition to
ICE_PTP_ERROR. The only valid path to ICE_PTP_ERROR is from
ICE_PTP_RESETTING after a failed rebuild.

Fixes: 8293e4cb2ff5 ("ice: introduce PTP state machine")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1469038bc895..eaec36ab6ae3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3037,6 +3037,11 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	struct ice_ptp *ptp = &pf->ptp;
 	int err;
 
+	if (ptp->state == ICE_PTP_UNINIT) {
+		dev_dbg(ice_pf_to_dev(pf), "PTP was not initialized, skipping rebuild\n");
+		return;
+	}
+
 	if (ptp->state == ICE_PTP_READY) {
 		ice_ptp_prepare_for_reset(pf, reset_type);
 	} else if (ptp->state != ICE_PTP_RESETTING) {
-- 
2.47.1

