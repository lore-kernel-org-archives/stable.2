Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818681;
	b=4s/6mdEJl0/E1QxhUsPdiiFCZZQZDzUSju9TrQ4kGx9qLNXoCnn1HSwn1PgxmUlPUnWx
	 4Dmxo1mBRVJ6YrG8k87oEiM4ecbkH5q9El0V/uys4AXkA/IWZ2QBghWH+WbM752sutR2y
	 aJxLVbP4xaVr61jPkpnwD+WyaXFBlOROa1xHwWZUUnysvH483sVKIdPtq8aaZwgmXrzu9
	 YTQ5J/6DOPgKaBTuC0AX5u27HWAwvekMhpnY0berprqB6aWFhhvXqmT3fCDUR3bntv2Us
	 XMuJOwvDh8Pb1nF35u+qPL8kBeYU2NI9mU3fhsd9+UGAuJ/WSsurgOdJ8dtjJM4iFdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818681;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jDMEgU3pAAkuzBbptHC17mrC+iYnBOL0PE3ezJSQuwQ=;
	b=24OVYkCovxz7ZFp0bdAV4jpjHCdlgOZFncTbtTey47+eI7vEgQDiXjiNl8O6FceuESAv
	 VJWmr0BVnx8TTqfAIdKfieOytN01OqSBti1rOKOwXDIrTRAptj4yVL1RkxpX2e9pqB814
	 ZDLMBEG1RdEFVEs1NwlDiAg1m1nSVvB41Jmz2Ao/6cgdAjnymnAOjbSD7mkHUSi0gETuu
	 dujpM74qMl8sVhw2miU5qo9zLN9QeFSfYFtyi78Ux/puJAg+WgPSOATv9T7DiXFh0Hp5k
	 /rBVmIUHnHFtzR2/ft1v59iBTYmsFhhIr/DRM8q9kQlwuEBaIwoVts+rj8ZeojqdReg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iRrTV024;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96985606A331;
	Mon, 16 Nov 2026 08:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96985606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iRrTV024
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 336051713;
	Mon, 16 Nov 2026 00:44:37 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4A643F673;
	Mon, 16 Nov 2026 00:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794818680; bh=MVIVrVn+MfbtQKO5pcUer4ZuZBQC3obEsrNsqTq1eow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRrTV024bR3xM4wt4Y+GDGzJFOIok626HqtD6WoUf8mZVHKvYoa7IChfyBlzt3IAg
	 MFSZkEqCAUAMSHtBMt/3O0oCdMzJfe0UNoXDBaNvmM6DbxSbmGVP+eNgbqHjbDuTEf
	 P5YJs8DqtKPk5YD3LEzs5LybhlQABZLk6yIerVsQ=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	philip.radford@arm.com,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/2] firmware: arm_scmi: Fix deadlock between reboot notifier and forceful work
Date: Mon, 16 Nov 2026 08:42:10 +0000
Message-ID: <20261116084211.3066460-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116084211.3066460-1-cristian.marussi@arm.com>
References: <20261116084211.3066460-1-cristian.marussi@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengyu Liu <lui2012qwq@gmail.com>

scmi_reboot_notifier() calls cancel_delayed_work_sync() while holding
sc->state_mtx, but the work it waits on - scmi_forceful_work_func() -
takes the same mutex.  If a forceful transition work is in flight when
the reboot notifier fires, the notifier holds the lock and waits for
the callback while the callback waits for the lock: deadlock, and the
reboot wedges.

Moving the cancel outside the lock is not sufficient on its own, as the
callback also calls unregister_reboot_notifier() unconditionally, which
blocks on the reboot chain rwsem (down_write vs. the in-progress
chain's down_read) while the notifier waits for the callback - the
deadlock would just move to a different lock.  Fix both sides:

- Notifier: compute the decision under state_mtx, drop the lock, then
  cancel.  A callback that slips in between sees state ==
  SCMI_SYSPOWER_REBOOTING (not IN_PROGRESS), skips the forceful
  request and finishes, so the cancel cannot miss it.  (The callback's
  own system_state early-return does not cover a work item that
  started before the reboot began: kernel_restart_prepare() runs the
  notifier chain before setting system_state.)

- Callback: only unregister the reboot notifier when actually forcing
  the transition - that is the only case that needs it, because the
  forceful kernel_restart()/kernel_power_off() would otherwise
  re-enter scmi_reboot_notifier and self-deadlock on state_mtx.  When
  the state is not IN_PROGRESS there is nothing to force, and skipping
  the unregister keeps the callback from blocking on the reboot chain
  rwsem while the notifier waits for it.

Found by static analysis.

Cc: stable@vger.kernel.org
Fixes: 2c4b97fee94a ("firmware: arm_scmi: Add SCMI System Power Control driver")
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
[Cristian: drop lock before triggering forceful reboot (needs_forceful)]
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../firmware/arm_scmi/scmi_power_control.c    | 26 ++++++++++++++-----
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
index e791a206768c..e0680e33180e 100644
--- a/drivers/firmware/arm_scmi/scmi_power_control.c
+++ b/drivers/firmware/arm_scmi/scmi_power_control.c
@@ -121,6 +121,7 @@ static int scmi_reboot_notifier(struct notifier_block *nb,
 				unsigned long reason, void *__unused)
 {
 	struct scmi_syspower_conf *sc = reboot_nb_to_sconf(nb);
+	bool cancel_work;
 
 	mutex_lock(&sc->state_mtx);
 	switch (reason) {
@@ -138,11 +139,18 @@ static int scmi_reboot_notifier(struct notifier_block *nb,
 		break;
 	}
 
-	if (sc->state == SCMI_SYSPOWER_REBOOTING) {
+	cancel_work = sc->state == SCMI_SYSPOWER_REBOOTING;
+	mutex_unlock(&sc->state_mtx);
+
+	if (cancel_work) {
 		dev_dbg(sc->dev, "Reboot in progress...cancel delayed work.\n");
+		/*
+		 * cancel_delayed_work_sync() waits for a running
+		 * scmi_forceful_work_func(), which takes state_mtx - it must
+		 * not be called with the lock held.
+		 */
 		cancel_delayed_work_sync(&sc->forceful_work);
 	}
-	mutex_unlock(&sc->state_mtx);
 
 	return NOTIFY_OK;
 }
@@ -181,6 +189,7 @@ static void scmi_forceful_work_func(struct work_struct *work)
 {
 	struct scmi_syspower_conf *sc;
 	struct delayed_work *dwork;
+	bool needs_forceful;
 
 	if (system_state > SYSTEM_RUNNING)
 		return;
@@ -188,13 +197,16 @@ static void scmi_forceful_work_func(struct work_struct *work)
 	dwork = to_delayed_work(work);
 	sc = dwork_to_sconf(dwork);
 
-	dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
 	mutex_lock(&sc->state_mtx);
-	/* avoid deadlock by unregistering reboot notifier first */
-	unregister_reboot_notifier(&sc->reboot_nb);
-	if (sc->state == SCMI_SYSPOWER_IN_PROGRESS)
-		scmi_request_forceful_transition(sc);
+	needs_forceful = sc->state == SCMI_SYSPOWER_IN_PROGRESS;
 	mutex_unlock(&sc->state_mtx);
+
+	if (needs_forceful) {
+		dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
+		/* avoid deadlock by unregistering reboot notifier first */
+		unregister_reboot_notifier(&sc->reboot_nb);
+		scmi_request_forceful_transition(sc);
+	}
 }
 
 /**
-- 
2.54.0

