Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E03BB67B;
	Sun, 30 Aug 2026 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104139; cv=none; b=CrOFdzOAKCKrvFB0OP9bVTzFou0ZuahPeEGyEz+DgCLtoiVuGDdSRlAYj/xxqr2UzjzzvxeFiWevPgkDTxxC9EoOfrISraQ4a/dK7KW34x94ZUscuiroDfq/m3yjcvX1rjAxxogvGXlysqEp+kq8JC39hJgwGv5YxUVqSotXyEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104139; c=relaxed/simple;
	bh=RFNpnfMp6x166CoMAVeIa0ulHLzLrT4Rw5ijlTELv0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FTZCzJ3+OYQ/k7svGftATTdRsNERbDyWjm8eywJOzLBz6JcS85EJagA5BLiVzGjZ1pJbVuPs2icvjDJ96EIRL9jzCZ+Px9DBtZMCYio4azLt1TjdmyDXuV6JEvALnmng5udmGL5WbBlF5vCNnlxj1ks7imYLOfV0vLzLxPp5/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=WacYdhAx; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="WacYdhAx"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd7a1ff6;
	Sun, 30 Aug 2026 23:35:28 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: nicolas.ferre@microchip.com
Cc: claudiu.beznea@microchip.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net] net: macb: initialize PTP lock before registering clock
Date: Sun, 30 Aug 2026 23:35:20 +0800
Message-Id: <20260830153520.2710520-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0534fb82e03a1kunmc421144b105b5c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGhgdVk4dSkpPHU8eTRlKSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WacYdhAxcypX7/RofuxM7oYmUXkh5EJolLpm8N4tkPXeHGirlK/kK6w5y4DXU6CXzvdqeBb1PS8J/1SuQD+NgZeafhDyyS4C13Iim096l0N+rPeMUn/iGCpc7p9JcCjPFI1l8/9oNxn8Ff5hzC7qHtg9ZTWl/2FNywxWCDmbZk0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ZM4cjofOAm1isMTLn9AY1gPKotHGVH+P4ZFGKGKbUVM=;
	h=date:mime-version:subject:message-id:from;

gem_ptp_init() registers the PTP clock before initializing
bp->tsu_clk_lock. ptp_clock_register() publishes the PTP character
device, so a userspace operation can enter a PTP callback as soon as
registration completes. Those callbacks use tsu_clk_lock and can therefore
observe the lock before it has been initialized.

Initialize the lock before registering the PTP clock so all published
callbacks see valid synchronization state.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7da..055160c42 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -330,6 +330,8 @@ void gem_ptp_init(struct net_device *netdev)
 
 	bp->ptp_clock_info = gem_ptp_caps_template;
 
+	spin_lock_init(&bp->tsu_clk_lock);
+
 	/* nominal frequency and maximum adjustment in ppb */
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
@@ -345,8 +347,6 @@ void gem_ptp_init(struct net_device *netdev)
 		return;
 	}
 
-	spin_lock_init(&bp->tsu_clk_lock);
-
 	gem_ptp_init_tsu(bp);
 
 	dev_info(&bp->pdev->dev, "%s ptp clock registered.\n",
@@ -467,4 +467,3 @@ int gem_set_hwtst(struct net_device *netdev,
 
 	return 0;
 }
-
-- 
2.34.1
