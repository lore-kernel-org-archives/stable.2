Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1029ACC5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616161; cv=none; b=sJlTvyudZSKG/gC0ChydKrFo1weg/v3rCqYQLh78O64cdQgjuO0vr/AUm2kUpGHQY14Hu+xfKM8t7FQurzyXhnTWCwT4jiRCcplrmkBXgc+PztnOY21RbSqykV5hLXOpW651D/aHUVO8ropIIQCORJIDtjTEXz9pu4sbir3FHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616161; c=relaxed/simple;
	bh=4LvGTpF0rLLuQLYLKOX7KF8ZxtvQXpw8rKBCk5Lxw64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzhudGrbcAdTNJgc/PFNWnGaioPyTNr1iKbWO/QO7rTf7I10eTJb5m183YZIEgwblD0ash03LEh7a5U3EQcql4Bv/fzYIec0n0orBTtKIwy6BYGlK5ArCN8XkXc90Y+LVzxvif3oPbe3AMwYYgxj1v+7fZaSeqjmfHSl6uZxq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQJ0zOlU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQJ0zOlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE63A1F008A1;
	Thu, 17 Sep 2026 03:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616148;
	bh=fYD644biHm9nC9rUeM4PCO2dy6vTPDyV71VOR3RDYdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HQJ0zOlUroGqh0CxMFIyMa2trd1EqzqDSA9Jpsc+VKO2nbVzkJxHu3oPeo2/xuKJf
	 jsvRlVpDOGmcOq+0dDymBD3Sdv1BPYqDo3W6xjIlBEcNeXqXBsu5O0wejWhCM2LllG
	 KCkUBYB90qrLEA1v1n2UJIlQjQU1egFVmn9ITKHtDf5znpJ/x3dkVu9Wdid2frdxfQ
	 /C8nISktNhP3wi/ADsSDhRI9T0jaAL0rQQIm0eB6zrxWmUt2e5m2pJMMhgeooq5KkY
	 t5/oQQp1EXBUK6hKmXQRmt51H4kHO31uu65jKWEOqraUlGGkSjjJElXUnNCyWvUATy
	 G80jrcWWU+6AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Michael Chan <michael.chan@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] Reapply "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
Date: Wed, 16 Sep 2026 23:35:44 -0400
Message-ID: <20260917033545.4044963-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917033545.4044963-1-sashal@kernel.org>
References: <2026091648-flakily-icing-f492@gregkh>
 <20260917033545.4044963-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit b6197b386677ae5268d4702e23849d9ad53051ad ]

This reverts commit 850d9248d2eac662f869c766a598c877690c74e5.
This reapplies commit 325eb217e41f ("bnxt_en: bring back rtnl_lock()
in the bnxt_open() path").

Breno reports a lockdep warning in bnxt. During FW reset the driver
may end up calling netif_set_real_num_tx_queues() (if queue count
changes), so calls to bnxt_open() still require rtnl_lock.

  net/sched/sch_generic.c:1416 suspicious rcu_dereference_protected() usage!

   dev_qdisc_change_real_num_tx+0x54/0xe0
   netif_set_real_num_tx_queues+0x4ed/0xa80
   __bnxt_open_nic+0x9cb/0x3490
   bnxt_open+0x1cb/0x370
   bnxt_fw_reset_task+0x80d/0x1e80
   process_scheduled_works+0x9c1/0x13b0

The reverted commit was just an optimization / experiment
so let's go back to taking the lock.

Reported-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/ah726OtFX-Qw3U-R@gmail.com
Fixes: 850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260603195845.2574426-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Stable adaptation for dependency of 961e2a17c5e3559b3f8654d2daabdd25a42e770a:
Keep this branch's two-argument bnxt_ulp_start() calls, including error
notifications, and release RTNL before invoking them.

Reuse and rename the existing service-task lock/unlock helpers to add
RTNL coverage without adding functions. Inline their original netdev-only
operations in bnxt_fw_exception() and bnxt_fw_reset() so those paths keep
their existing locking and BNXT_STATE_IN_SP_TASK ordering. The RX reset
path then provides the bnxt_rtnl_unlock_sp() required by the target's
buffer-allocation failure handling.

Stable-dep-of: 961e2a17c5e3 ("bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 44 ++++++++++++++---------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9176b90f571fe..1555f337e3021 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14271,31 +14271,32 @@ static void bnxt_timer(struct timer_list *t)
 	mod_timer(&bp->timer, jiffies + bp->current_interval);
 }
 
-static void bnxt_lock_sp(struct bnxt *bp)
+static void bnxt_rtnl_lock_sp(struct bnxt *bp)
 {
 	/* We are called from bnxt_sp_task which has BNXT_STATE_IN_SP_TASK
 	 * set.  If the device is being closed, bnxt_close() may be holding
-	 * netdev instance lock and waiting for BNXT_STATE_IN_SP_TASK to clear.
-	 * So we must clear BNXT_STATE_IN_SP_TASK before holding netdev
-	 * instance lock.
+	 * RTNL and the netdev instance lock while waiting for
+	 * BNXT_STATE_IN_SP_TASK to clear.  Clear it before taking either lock.
 	 */
 	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	rtnl_lock();
 	netdev_lock(bp->dev);
 }
 
-static void bnxt_unlock_sp(struct bnxt *bp)
+static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
 {
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	netdev_unlock(bp->dev);
+	rtnl_unlock();
 }
 
 /* Only called from bnxt_sp_task() */
 static void bnxt_reset(struct bnxt *bp, bool silent)
 {
-	bnxt_lock_sp(bp);
+	bnxt_rtnl_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state))
 		bnxt_reset_task(bp, silent);
-	bnxt_unlock_sp(bp);
+	bnxt_rtnl_unlock_sp(bp);
 }
 
 /* Only called from bnxt_sp_task() */
@@ -14303,9 +14304,9 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 {
 	int i;
 
-	bnxt_lock_sp(bp);
+	bnxt_rtnl_lock_sp(bp);
 	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
-		bnxt_unlock_sp(bp);
+		bnxt_rtnl_unlock_sp(bp);
 		return;
 	}
 	/* Disable and flush TPA before resetting the RX ring */
@@ -14344,7 +14345,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_set_tpa(bp, true);
-	bnxt_unlock_sp(bp);
+	bnxt_rtnl_unlock_sp(bp);
 }
 
 static void bnxt_fw_fatal_close(struct bnxt *bp)
@@ -14443,9 +14444,11 @@ void bnxt_fw_exception(struct bnxt *bp)
 	netdev_warn(bp->dev, "Detected firmware fatal condition, initiating reset\n");
 	set_bit(BNXT_STATE_FW_FATAL_COND, &bp->state);
 	bnxt_ulp_stop(bp);
-	bnxt_lock_sp(bp);
+	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	netdev_lock(bp->dev);
 	bnxt_force_fw_reset(bp);
-	bnxt_unlock_sp(bp);
+	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	netdev_unlock(bp->dev);
 }
 
 /* Returns the number of registered VFs, or 1 if VF configuration is pending, or
@@ -14475,7 +14478,8 @@ static int bnxt_get_registered_vfs(struct bnxt *bp)
 void bnxt_fw_reset(struct bnxt *bp)
 {
 	bnxt_ulp_stop(bp);
-	bnxt_lock_sp(bp);
+	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	netdev_lock(bp->dev);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state) &&
 	    !test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -14521,7 +14525,8 @@ void bnxt_fw_reset(struct bnxt *bp)
 		bnxt_queue_fw_reset_work(bp, tmo);
 	}
 fw_reset_exit:
-	bnxt_unlock_sp(bp);
+	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	netdev_unlock(bp->dev);
 }
 
 static void bnxt_chk_missed_irq(struct bnxt *bp)
@@ -15257,15 +15262,17 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
 		fallthrough;
 	case BNXT_FW_RESET_STATE_OPENING:
-		while (!netdev_trylock(bp->dev)) {
+		while (!rtnl_trylock()) {
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
 		}
+		netdev_lock(bp->dev);
 		rc = bnxt_open(bp->dev);
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
 			netdev_unlock(bp->dev);
+			rtnl_unlock();
 			goto ulp_start;
 		}
 
@@ -15285,6 +15292,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_dl_health_fw_status_update(bp, true);
 		}
 		netdev_unlock(bp->dev);
+		rtnl_unlock();
 		bnxt_ulp_start(bp, 0);
 		bnxt_reenable_sriov(bp);
 		netdev_lock(bp->dev);
@@ -16273,7 +16281,7 @@ static int bnxt_queue_start(struct net_device *dev,
 		   rc);
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
-	bnxt_reset_task(bp, true);
+	netif_close(dev);
 	return rc;
 }
 
@@ -17101,6 +17109,7 @@ static int bnxt_resume(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
+	rtnl_lock();
 	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
@@ -17145,6 +17154,7 @@ static int bnxt_resume(struct device *device)
 
 resume_exit:
 	netdev_unlock(bp->dev);
+	rtnl_unlock();
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);
@@ -17310,6 +17320,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	int err;
 
 	netdev_info(bp->dev, "PCI Slot Resume\n");
+	rtnl_lock();
 	netdev_lock(netdev);
 
 	err = bnxt_hwrm_func_qcaps(bp);
@@ -17327,6 +17338,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 		netif_device_attach(netdev);
 
 	netdev_unlock(netdev);
+	rtnl_unlock();
 	bnxt_ulp_start(bp, err);
 	if (!err)
 		bnxt_reenable_sriov(bp);
-- 
2.53.0

