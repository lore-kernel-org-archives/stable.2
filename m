Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466354BC020;
	Tue, 21 Jul 2026 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630208; cv=none; b=gnYOdvD4WTRDt5c+cEafJdDbhanlY2QkR2M0gKZQJXOW1iZBLrSVSy4PxJ6kJo8xdLdf15cfm4jZOkgV2O0R07iHNOAiIkpvls/fsbAkGHjrOrdOwqA2VFY8bBq28XapaO2Vxhljg6njth3n3G5hvwHafxDeGHA/0nsvvjaNU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630208; c=relaxed/simple;
	bh=uk9+PAfhiDn1pJ0V7lxZBU/RUKIOyzf7ZqCPJq+EOwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qebJtowxcuNSrl/f1lzriITUZNDCvSAbbQMZV7WwoVPmB00S3tcXe4MxbBEfnGKW4DbMGyn7Zb1exGhZOto0nlXNG6kjmhp2jnGdAYxifP89ywlfXFGkSrJ+/luRSPtFXK1oE4gos7EfAfwYxLR/hukvyn/49nQ6KCdXbjqFSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mDO9LErl; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mDO9LErl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784630204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2zzTDGQly5AVxe/+9Ui/CdewjiD+JPqlP23irktRQUk=;
	b=mDO9LErlNCxVEWXtC6Il3c80LAKdHR3u+x2Qpwq/fp6/IQRcOAwqLPd+50t7sS4GaVxGZy
	zZ2dy1OxoDrzjbksQnnOz2qJ39F1xbbgmVcMrSkEmAg0yI2mvBzDz8qfqQO/BEqypTOge9
	BvcjPay13/VHzZf2SE6FoNxeB/Kpcm8=
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tj@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v1] igb/igbvf: disable work items before device removal
Date: Tue, 21 Jul 2026 18:35:39 +0800
Message-ID: <20260721103539.57990-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

A watchdog work item that is already running can queue the reset work after
the remove path has canceled it. The netdev Tx timeout handler can also
queue the reset work until unregister_netdev() shuts the interface down.
In igb, device reset interrupts provide another enqueue path. The reset
work may then run after free_netdev(), resulting in access to the freed
adapter memory.

Although igb_reset_task() checks __IGB_DOWN, checking the bit already
dereferences the adapter and therefore cannot protect its lifetime.

Disable the watchdog work first and the reset work second in both drivers.
Disabling the work items also prevents racing attempts to queue them during
device removal.

Fixes: 760141a53e5d ("igb[v],ixgbe: don't use flush_scheduled_work()")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a1e89a375744c..5ffc0ad318914 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3887,8 +3887,8 @@ static void igb_remove(struct pci_dev *pdev)
 	timer_delete_sync(&adapter->watchdog_timer);
 	timer_delete_sync(&adapter->phy_info_timer);
 
-	cancel_work_sync(&adapter->reset_task);
-	cancel_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->reset_task);
 
 #ifdef CONFIG_IGB_DCA
 	if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index ec308a5f5302a..c5ae15fcdca75 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2906,8 +2906,8 @@ static void igbvf_remove(struct pci_dev *pdev)
 	set_bit(__IGBVF_DOWN, &adapter->state);
 	timer_delete_sync(&adapter->watchdog_timer);
 
-	cancel_work_sync(&adapter->reset_task);
-	cancel_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->reset_task);
 
 	unregister_netdev(netdev);
 
-- 
2.43.0

