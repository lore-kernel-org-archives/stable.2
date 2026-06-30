Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C031D72E;
	Tue, 30 Jun 2026 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855854; cv=none; b=cjg1bLN/8NkK2shn6LrhlyxdHzAH31hS9pzHdmxOar58Psm+haEvHxIqAZSmq+L9ZSHV1M0kHBwWhSywrC6tLePLd+IPinrZkwXy+axE5KPBm95+EH8NBt3nQMcFrTgdUEsrc3oK/LpYOq6c2i3WsK6/4hnWPJIDo7M7fGvZspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855854; c=relaxed/simple;
	bh=SlmsKtIIkfbMO1XsocZq5DP3MtDIX9HCDGvKoiP0GHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubgfE8ds8ge3YyUOk5T89VhhniAyVx9RPupLRFPy/cY5pe7S+SoKbF/hWHENbF+4HVT9ts0im0C+3XbvGSQZkf3q4shoWjVNLBl2PwzphM6RINbsu/4UUKjVsm2ySL35+2VsYugEA/NH6ubxZ6WYfN4azBcgNfWEnsAJfc2/zYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRG6/yZx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRG6/yZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782855853; x=1814391853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SlmsKtIIkfbMO1XsocZq5DP3MtDIX9HCDGvKoiP0GHU=;
  b=gRG6/yZxQNT3Sd4a71Qf6bgMxuP/uA6nk0Hm3c32ETaA9o4RyC6/AxE2
   50xgiccKqr5T4xAoSd3LhRFhEheT0jJVyWtQU7sLMWFkDXGOTsELbW+4U
   2iqythHaJTcDSksorM3J6UwlpQUpa8GoUOV4is4x5ybx6WRGvZHFEqy+B
   MoNG/o2Ey316FlH6DJJjdlbEFD8VQhNbeNUNSb75pH/v5ZWxXDV7rVHML
   NYfd8oJtx2zSl/EBmVak3jr0BXhOnR8WtOBGhSOkVrcwQ3TdgFMu/vcry
   twcUIoanP2FeVGIvPLVwCud2iACNPBnj6inXesd3vOamDNwr0OFup6+u2
   g==;
X-CSE-ConnectionGUID: DScVTpRLSA6d7qksWxnmDg==
X-CSE-MsgGUID: G1NNk7EHTn+K0n52/+P49w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83637568"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83637568"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 14:44:11 -0700
X-CSE-ConnectionGUID: 6zY0CAZYRVO3ULzDO2gkFg==
X-CSE-MsgGUID: UHZFWYhCS7uzUuH+52aPvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254296573"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jun 2026 14:44:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>,
	anthony.l.nguyen@intel.com,
	jbrandeb@kernel.org,
	stable@vger.kernel.org,
	Kohei Enju <kohei@enjuk.jp>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 1/4] ice: wait for reset completion in ice_resume()
Date: Tue, 30 Jun 2026 14:43:59 -0700
Message-ID: <20260630214404.930923-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
References: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Ma <aaron.ma@canonical.com>

ice_resume() schedules an asynchronous PF reset and returns
immediately. The reset runs later in ice_service_task(). If
userspace tries to bring up the net device before the reset
finishes, ice_open() fails with -EBUSY:

  ice_resume()
    ice_schedule_reset()          # sets ICE_PFR_REQ, returns
  ...
  ice_open()
    ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
  ...
  ice_service_task()
    ice_do_reset()
      ice_rebuild()               # clears ICE_PFR_REQ, too late

Reproduced on E800 series NICs during suspend/resume with irdma
enabled, where the aux device probe widens the race window.

  ice 0000:81:00.0: can't open net device while reset is in progress

Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
for the reset to complete before returning from ice_resume(). In
practice the reset completes in ~300ms.

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Cc: stable@vger.kernel.org
Reviewed-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fd2dab03e3..d88835482d3a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5637,6 +5637,16 @@ static int ice_resume(struct device *dev)
 	/* Restart the service task */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
 
+	/* Best-effort wait for the scheduled reset to finish so that the
+	 * device is operational before returning. Without this, userspace
+	 * (e.g. NetworkManager) may try to open the net device while the
+	 * asynchronous reset is still in progress, hitting -EBUSY.
+	 */
+	ret = ice_wait_for_reset(pf, secs_to_jiffies(10));
+	if (ret)
+		dev_err(dev, "Wait for reset timed out (10s) during resume: %d\n",
+			ret);
+
 	return 0;
 }
 
-- 
2.47.1

