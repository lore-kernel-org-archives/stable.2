Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790A142E83;
	Thu, 18 Jun 2026 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792670; cv=none; b=uyaG25tfR99ScTP02uj2deIp1e0yKhUFrRRf5FVonPApqyl/I2FZPkxiUC6tJ1EACxOEc5x75Y+18G1yB55efBd8/FEjfELOYzWnqCgC8sSTDyL4Ywtzy3uLTQMyYvdPG6dk4UXhfSHShebS0JY1DnzPYHa/dZBR1NoFNqaAMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792670; c=relaxed/simple;
	bh=oE0KH1yRN9OXm4MY+DgB7PZvgNPGXKJrmySL2yrGmuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CwkxfHGq4pXOLfEhRZlbnDTmRP8MT3uQXl1ppQ7SlFImjxoNqIoeodPOK3TQ/c4OFTb7qA34s10dd7E98SduWkVAZxZwwlxvxRMnr6A0Ysp0Mz1OkbZ6vymnxOrvG55fwGB3pYYwhXTuSlQMxeTZjhKDTZ+UGEZr8ExHqJiCpLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=VvQdcnNa; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="VvQdcnNa"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42ee4c3b1;
	Thu, 18 Jun 2026 22:19:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net] net: au1000: move free_irq out of the close-time spinlocked section
Date: Thu, 18 Jun 2026 22:19:01 +0800
Message-Id: <20260618141901.2954452-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9edb19963303a1kunmf6ad0178a5724
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0NCVkxDTU9NTUpOQkMfS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VvQdcnNaRvPvinh57fHWlS2HvqWO4YCowebcVVq5qoaJ/ip+jigvuphis5i4Xjnlt0PZS6Of2kVEUu5ZeDZTbFXgL4tmVbmRhDbTcEc4WYXIrgNkwS2bpEecosvKJN8qmqC9fuG62DbeexEk0QMQsiczXh/6uAlzmeGmNhdXZgI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=swwEH7uSGI7dhuLMMECUZpE4onbMrPdVNZF6LmhCEDk=;
	h=date:mime-version:subject:message-id:from;

au1000_close() calls free_irq() while aup->lock is still held with
spin_lock_irqsave().  free_irq() can sleep because it takes the IRQ
descriptor request mutex, so it does not belong inside the close-time
spinlocked section.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the ndo_stop carrier and the au1000_close() ->
free_irq(dev->irq, dev) path while the driver lock was held.  Lockdep
reported:

  BUG: sleeping function called from invalid context
  1 lock held by exploit/192:
   #0: (&aup->lock){....}-{2:2}, at: au1000_close+0x23/0x83 [vuln_msv]
  [ BUG: Invalid wait context ]
  exploit/192 is trying to lock:
  (&desc->request_mutex){+.+.}-{3:3}, at: free_irq+0x63/0x360
  free_irq+0x63/0x360
  au1000_close+0x65/0x83 [vuln_msv]

Drop aup->lock before freeing the IRQ.  The protected close-time work
still stops the device and queue before IRQ teardown, but the sleepable
IRQ core path now runs outside the spinlocked section.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/amd/au1000_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 9d35ac348ebe..5a04056e38fa 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -943,9 +943,10 @@ static int au1000_close(struct net_device *dev)
 	/* stop the device */
 	netif_stop_queue(dev);
 
+	spin_unlock_irqrestore(&aup->lock, flags);
+
 	/* disable the interrupt */
 	free_irq(dev->irq, dev);
-	spin_unlock_irqrestore(&aup->lock, flags);
 
 	return 0;
 }
-- 
2.34.1

