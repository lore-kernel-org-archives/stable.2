Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E440EBB6;
	Tue, 28 Jul 2026 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272969; cv=none; b=Zo1MwyvhhnKIzBVIRVAaLC5afumEQ3Md8IurKbV3YLphM+WXRhiJ+FnMt4uFynWuciswiFxiIrV9uDAVS5YxA/VavgPit7xBIeiv6jpjgeBJlKp4fra8no085K0oYSPwwXB4lhfhZ5Oic3rGZKgf9cRVzI6+25OIUWr9frJ2fvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272969; c=relaxed/simple;
	bh=LQGutdPaBE5PsJVGXjfnXYFyZkUy6a62869WKuQchHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCkXuD+BRM1nr4lKOdzsKJ6DE0wm0ZAN+lsyDQTT5CUeN1nKnUF/xOKNiRi6vvJa15/MVo2mJMSJjU9htODcPwUD7EvCP6ALu/hEU7kY6cYw1uhqxUF9QMPMj+OFjCVZBqqlgTS3VBT2UZ5FFlJ+fIJG7p1AZWb4IQeNYHd53Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/owGCJn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/owGCJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272968; x=1816808968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LQGutdPaBE5PsJVGXjfnXYFyZkUy6a62869WKuQchHo=;
  b=N/owGCJntwQ/Y7Xjp8kzwmSEq+lc7ukQqZnuNVyXaxmQoEhWBr3f/Jrj
   qe4efX52klrjS7tTZnUK8rnzGV7LsDK1cXQ4a5jQBKWnEVtXE00e+yMWF
   TGiH9ARR19R51a31sH5WoeSncWmbaTweQf/frrrWkoKZu5JpevmMtS8UN
   KFko9bp21txxGdNrdeJhKN9f/jXn0l9ayU59oVpnj582Tz7PPho/VWvOY
   qCXnKK6lwLJuEYAdr1XHnlrgOoXQB7LdXy2dnOMCybuy9AGWnTVAOXnfA
   /c4od13LUo+HNlZ/5gdf3dyimuqqbUiGyNdv1Z8HmTx1FFx5b7vBMlc+q
   A==;
X-CSE-ConnectionGUID: DUSc5Pj7RXGxMZMz7d9l3w==
X-CSE-MsgGUID: IZSv16zfS5yDmropQcmXzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85885033"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85885033"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:18 -0700
X-CSE-ConnectionGUID: ZzZ56lHAQ+i0yh9bIietCQ==
X-CSE-MsgGUID: swYgu5UtQ1OKC6xQop2f+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558949"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:17 -0700
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
Subject: [PATCH net 04/10] ice: wait for reset completion in ice_resume()
Date: Tue, 28 Jul 2026 14:09:01 -0700
Message-ID: <20260728210909.3042004-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
References: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
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
There were comments from Paolo which Aaron responded:
https://lore.kernel.org/netdev/CAJ6xRxVwD9nLk96y6-HNSFt1AL8o=24UMUGxCYZdht2_+36Xhg@mail.gmail.com/

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

