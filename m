Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841283AFCFD;
	Sun,  4 Oct 2026 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791114334; cv=none; b=cBV87aUSFGWZW4f8N0dtxHqVt2bxre7u5lwe/SQ11eEGaEgkfIFgmtuZykqQsEPxvQibPqIsvmSWrlGx5lTLoHEjyyGEESG9BG9F2YFtiUWcaVk3gnxy0J8na620UtcKsqkaGrCu9iK5hUkLbgYVfqRmpp7PYE33bGRqulSlpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791114334; c=relaxed/simple;
	bh=IT5BxubQMI/Iak7U6pnOoT3QYzv2WNyRub1/q3h1l0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nB2pmFjNR6wt0WZHclqe+TorO5ykVCD2Yz6K0SMPWMn4X5xLYtIh5KzHTC/QUU2iRzuxrqDdsckzUubAxEV2euEC9mqCdFEbrbeXN4fWkI/fnsxpjCY0BmzQ2a3QOkXlUDULUo5SU2BSExnSKs1PW3jt10eBQJld1xCPltVqtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=bz7hXTdv; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="bz7hXTdv"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fec266c9;
	Sun, 4 Oct 2026 19:45:27 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] wifi: iwlegacy: serialize watchdog updates with device teardown
Date: Sun,  4 Oct 2026 19:45:19 +0800
Message-Id: <20261004114519.1233305-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa106bbb4d403a1kunm649ed7a833b323
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTE0fVkNCSB8fGUwZSx9KS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bz7hXTdvECGTBoTJ5JCbvoW27wsXw2HOi8l8SuZWanR+CdXge1E9+BcY75d0e92bUYELf2MeBWVovlNxEtTcDZgvEocVv4Q3ZLP81f9zCB0YFBvskXc9UNJgLqrVmXqxkQ/BzD/H9u+nbHduduw79/4pmhTtou1TUU33rM90A9o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=JPE5ptbZUkOvuHA147QHON/5zpeNHl6yD9nBynhAV4E=;
	h=date:mime-version:subject:message-id:from;

The writable wd_timeout debugfs file changes il->cfg->wd_timeout, but the
iwl3945 configuration is shared and const. The handler also rearms the
watchdog without taking il->mutex. The down paths hold this mutex, delete
the timer, and then free the TX queues, so an unlocked debugfs write can
rearm the timer after deletion. The callback can then access the queues
after they have been freed.

Store wd_timeout in per-device state. Serialize the debugfs update with
the down paths and only arm the watchdog while TX queues exist. Use
READ_ONCE() and WRITE_ONCE() for accesses that do not hold il->mutex.

Fixes: 1dc80798a8ca ("iwlegacy: constify local structures")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 1 +
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 1 +
 drivers/net/wireless/intel/iwlegacy/common.c   | 6 +++---
 drivers/net/wireless/intel/iwlegacy/common.h   | 1 +
 drivers/net/wireless/intel/iwlegacy/debug.c    | 8 ++++++--
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index cbaf250626..ee40cf534d 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3563,6 +3563,7 @@ il3945_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	D_INFO("*** LOAD DRIVER ***\n");
 	il->cfg = cfg;
+	il->wd_timeout = cfg->wd_timeout;
 	il->ops = &il3945_ops;
 #ifdef CONFIG_IWLEGACY_DEBUGFS
 	il->debugfs_ops = &il3945_debugfs_ops;
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 18bb556826..9a42a74cf8 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -6500,6 +6500,7 @@ il4965_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	D_INFO("*** LOAD DRIVER ***\n");
 	il->cfg = cfg;
+	il->wd_timeout = cfg->wd_timeout;
 	il->ops = &il4965_ops;
 #ifdef CONFIG_IWLEGACY_DEBUGFS
 	il->debugfs_ops = &il4965_debugfs_ops;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 0bb807ff8e..c2adb1ef63 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4774,7 +4774,7 @@ il_check_stuck_queue(struct il_priv *il, int cnt)
 
 	timeout =
 	    txq->time_stamp +
-	    msecs_to_jiffies(il->cfg->wd_timeout);
+	    msecs_to_jiffies(READ_ONCE(il->wd_timeout));
 
 	if (time_after(now, timeout)) {
 		IL_ERR("Queue %d stuck for %u ms.\n", q->id,
@@ -4806,7 +4806,7 @@ il_bg_watchdog(struct timer_list *t)
 	if (test_bit(S_EXIT_PENDING, &il->status))
 		return;
 
-	timeout = il->cfg->wd_timeout;
+	timeout = READ_ONCE(il->wd_timeout);
 	if (timeout == 0)
 		return;
 
@@ -4831,7 +4831,7 @@ EXPORT_SYMBOL(il_bg_watchdog);
 void
 il_setup_watchdog(struct il_priv *il)
 {
-	unsigned int timeout = il->cfg->wd_timeout;
+	unsigned int timeout = READ_ONCE(il->wd_timeout);
 
 	if (timeout)
 		mod_timer(&il->watchdog,
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 21f1c7702a..9c1c252dcc 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -1129,6 +1129,7 @@ struct il_priv {
 	struct ieee80211_rate *ieee_rates;
 
 	struct il_cfg *cfg;
+	unsigned int wd_timeout;
 	const struct il_ops *ops;
 #ifdef CONFIG_IWLEGACY_DEBUGFS
 	const struct il_debugfs_ops *debugfs_ops;
diff --git a/drivers/net/wireless/intel/iwlegacy/debug.c b/drivers/net/wireless/intel/iwlegacy/debug.c
index 8a9f79ff1c..13dfc263a2 100644
--- a/drivers/net/wireless/intel/iwlegacy/debug.c
+++ b/drivers/net/wireless/intel/iwlegacy/debug.c
@@ -1284,8 +1284,12 @@ il_dbgfs_wd_timeout_write(struct file *file, const char __user *user_buf,
 	if (timeout < 0 || timeout > IL_MAX_WD_TIMEOUT)
 		timeout = IL_DEF_WD_TIMEOUT;
 
-	il->cfg->wd_timeout = timeout;
-	il_setup_watchdog(il);
+	mutex_lock(&il->mutex);
+	WRITE_ONCE(il->wd_timeout, timeout);
+	if (il->txq)
+		il_setup_watchdog(il);
+	mutex_unlock(&il->mutex);
+
 	return count;
 }
 
-- 
2.34.1
