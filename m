Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090F2AD2C;
	Sun, 30 Aug 2026 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104968; cv=none; b=PiU4TldWZ6WutmpNN9+TAjP/8jpx503+6IsoqMK1q1RpLyWUfuJJsnMyacfSmJKff1D6MZ+6nX1FwhXZhYAdGnwssGMLnev6zC1yClRVM0HUIv9QmWtBI0inKF70E4NqEllOogFOdksmlGzBdD/7ZGFH8s8OB5rOhf/8UEbheDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104968; c=relaxed/simple;
	bh=oYOXAs5m6/yltOsQ25/2RCcA+bN/zLr8dqhSca4eIPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AoAs8iPMEd4WaUeW/NcQZpmNLTIksGvEzUiHJKsVhmaWShreaurF7OJxRGXZYY2QZ4JQfJDOxReonEstoehzRJiVXst8BPu6/WRt2XA/wfxdM7dEUUQxY/z8b4bxJ79yrlYgDfRd4qenm3pDgvnWE8da5D3K07GwUlwflorDOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=X4nyemi6; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="X4nyemi6"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd7a2105;
	Sun, 30 Aug 2026 23:49:20 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net] igb: initialize PTP lock before registering PHC
Date: Sun, 30 Aug 2026 23:49:12 +0800
Message-Id: <20260830154912.2712900-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0535c69c303a1kunm233e997d10627a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxkfVkpCGk5CSUJCT09CGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=X4nyemi6vu4tmw1fy1QRs7Noc2eW3bgUHCE3J2Hs95OvYpBt94IemQkqthL4A6mgBbZKFWOrsQlrQNx6mgJDVwsU2sneMp9t9s6vl3DtGjhmQCDSon3tD4OjmmsJi3ZezoQ295OAjbcXhEnRl2hw/2KRsUKjO/GC0J6pXRxguS8=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=f1gzZMaQn/1LyNKQ9BDeU2sp9XpnY13ijo2O/3Sv6sg=;
	h=date:mime-version:subject:message-id:from;

igb_ptp_init() registers the PHC before initializing
adapter->tmreg_lock.  ptp_clock_register() publishes the PHC device,
so a userspace PTP operation can enter a callback and take the lock
before it has been initialized.

Initialize tmreg_lock before registering the PHC so all published PTP
callbacks see a valid lock.

Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 638d8242b..2a4ea327a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1378,6 +1378,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
+	spin_lock_init(&adapter->tmreg_lock);
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1388,7 +1389,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
 
-		spin_lock_init(&adapter->tmreg_lock);
 		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
 
 		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-- 
2.34.1

