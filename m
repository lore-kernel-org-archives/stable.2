Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E453376A03;
	Mon, 22 Jun 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165671; cv=none; b=BdtDIW210bH4csSF3W5+0ah/xZoImYND77ij7CA1K94UhN6X2GIHw837KGIsuY8D6V8/+0b9I7YPEokbLvYr6zFM+eROR4CVFR7z0U/Sc3GftwGFQ9TXbLJ7EkupdruwcDpo0bTQIPg3CLkZyGA4uXAjCB+H1dd0WhUP+2pisOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165671; c=relaxed/simple;
	bh=78Jq1Dj8kEiG1qk4UyHAziYDZVlH2hpxdJI/v/L9er0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5Ded+9iFGMQ1JZrVxLlfy/p2/cED6U/gmWe9wD7Sy8swchmEWoFKVSnJ9RS0IcNkcfkR9bN+XU1JS2zE5fVufAWeSYUGHF5jo2foCfrSdFoN6FY7cf7+wq1/mW2jItsOHoYF6kujGltD7r2TCoQEWROKR8n95xA43NOi7g6kZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gn25p1pl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gn25p1pl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782165670; x=1813701670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78Jq1Dj8kEiG1qk4UyHAziYDZVlH2hpxdJI/v/L9er0=;
  b=gn25p1plaNuOnRNJxzl0ubsAfC00iKjAycsJWX8tnW7YFITIDeTjHysN
   FC2VfOYu/zbOK2TN6e4aa2fG/1TOmz+DkKOqJalMgGUlIrmrixGSIxiPY
   nL6tU4Pt5hfbYJ+Chkg8WYxLINlo7DFH/YkUbZtyUn2L1f+7mQaV8iH8V
   ixfOixNmh8twGPTmAle8yeOKaDnHHGVDbqt6m2jzWZIsuDqttiNuJDb4c
   qjUAAvz7VL9qZl73uELC3ILu9Pqrc/nYzjGPMtC1NIYOkjctMzc63F5vT
   8njq9vbzYDPWYmP2ob1pahDahvzwGx/AC+PuG4FRXJKh8uG/+6nrafU2m
   g==;
X-CSE-ConnectionGUID: J62n6YLdTwePJMRISGm9Mg==
X-CSE-MsgGUID: 0ImHcn4IRm+Kcq1RZLjJmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82675566"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82675566"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 15:01:05 -0700
X-CSE-ConnectionGUID: dA+pLScgRTCWlDVpe071wQ==
X-CSE-MsgGUID: D7OImcEmS2Sbp7KxGorQ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248205713"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2026 15:01:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 3/8] ice: fix ice_init_link() error return preventing probe
Date: Mon, 22 Jun 2026 15:00:50 -0700
Message-ID: <20260622220059.2471844-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
References: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

ice_init_link() can return an error status from ice_update_link_info()
or ice_init_phy_user_cfg(), causing probe to fail.

An incorrect NVM update procedure can result in link/PHY errors, and
the recommended resolution is to update the NVM using the correct
procedure. If the driver fails probe due to link errors, the user
cannot update the NVM to recover. The link/PHY errors logged are
non-fatal: they are already annotated as 'not a fatal error if this
fails'.

Since none of the errors inside ice_init_link() should prevent probe
from completing, convert it to void and remove the error check in the
caller. All failures are already logged; callers have no meaningful
recovery path for link init errors.

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fbe111f849..e2fd2dab03e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4789,16 +4789,14 @@ static void ice_init_wakeup(struct ice_pf *pf)
 	device_set_wakeup_enable(ice_pf_to_dev(pf), false);
 }
 
-static int ice_init_link(struct ice_pf *pf)
+static void ice_init_link(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
 	err = ice_init_link_events(pf->hw.port_info);
-	if (err) {
+	if (err)
 		dev_err(dev, "ice_init_link_events failed: %d\n", err);
-		return err;
-	}
 
 	/* not a fatal error if this fails */
 	err = ice_init_nvm_phy_type(pf->hw.port_info);
@@ -4838,8 +4836,6 @@ static int ice_init_link(struct ice_pf *pf)
 	} else {
 		set_bit(ICE_FLAG_NO_MEDIA, pf->flags);
 	}
-
-	return err;
 }
 
 static int ice_init_pf_sw(struct ice_pf *pf)
@@ -4982,13 +4978,11 @@ static int ice_init(struct ice_pf *pf)
 
 	ice_init_wakeup(pf);
 
-	err = ice_init_link(pf);
-	if (err)
-		goto err_init_link;
+	ice_init_link(pf);
 
 	err = ice_send_version(pf);
 	if (err)
-		goto err_init_link;
+		goto err_deinit_pf_sw;
 
 	ice_verify_cacheline_size(pf);
 
@@ -5007,7 +5001,7 @@ static int ice_init(struct ice_pf *pf)
 
 	return 0;
 
-err_init_link:
+err_deinit_pf_sw:
 	ice_deinit_pf_sw(pf);
 err_init_pf_sw:
 	ice_dealloc_vsis(pf);
-- 
2.47.1

