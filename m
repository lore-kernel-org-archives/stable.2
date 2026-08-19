Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A61F942
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180969; cv=none; b=OpD41LUOkQwqMcEwGgeMO6DHfWMWvJPdqTNEKqkwZJRLAf0f4Gg/9L2bZ7nkIKbZ5D+6jmfa7lpWUgzbIplxCbgEckl98sj1se9oPHzvBIDrvidYn9ibxHNpOYg40JjhvEftH2RaJQXJVAH/VDAztgRM98lT/7JmOZMrJoS7pic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180969; c=relaxed/simple;
	bh=ozj505FF93uUzZDHnV9kL9tqZZqCY0Tk3VgDDziF++U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKI+f6Ht+DgLeo3WKpf6CEXe7yhUxRhQsmNjg6xmwcjMCkHSUVpCeMxvkuVrNvJkCDH4dnsqO9g3ceJuBanfWFUp7yX2CKhfRjX60iqcIDjcYjeSDuIGhH7LwkZcDPwiD16OA5N5baVdBxEIUbc7BX4PWugvS7arSiCvQtUvAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrKfsHvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrKfsHvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBF01F00A3E;
	Wed, 19 Aug 2026 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787180967;
	bh=ab0cnhDZ9jxCG6ltcAI4SCYsK6LdxBG/HqQps8nZTfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrKfsHvENUh9XJCcFG2lvq5H1WrIF/DDPLSXFaTpp/R7fAdOpq/4iLtNU2Df+pnxy
	 HjP9teqyL5oqgRMyNIUC5Yxcwfcm3SsMhdojbrr522U/kXXoewvr29qi+GoMhTKAK4
	 MRuyToWojVcesTQNvAD06gtnQw4OTp8013w3b5uzqAq9TILlPwj7api/HF+jloWEXv
	 cfoRksSls2A31mtDeCYcRr3AAexkNOmUuoTc0kNTGcjaTD5DoYy/Y1Vh/qPJSr9T51
	 U3NoTqWzof3uNWNXkrBP2XjlMMGlGfIfaw5pLggI0v3ZIl2Wjl4zIgZLjB1ab7t0W/
	 vuTUsX0B0IhRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] net: expect instance lock in netdev_queue_get_dma_dev()
Date: Wed, 19 Aug 2026 19:09:25 -0400
Message-ID: <20260819230925.944372-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819230925.944372-1-sashal@kernel.org>
References: <2026081708-gracious-yard-1b78@gregkh>
 <20260819230925.944372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 92465f46f3c3a92e4758af20d2363b7adc43e1f5 ]

netdev_queue_get_dma_dev() uses "compat" locking assert which wants
either the rtnl_lock or netdev instance lock. This is not right,
the callers are taking the instance lock unconditionally. All entry
points for queue config are purely instance locked.

In other words the callers use netdev_get_by_index_lock(), not
netdev_get_by_index_lock_ops_compat(). All the state we will
access is effectively instance lock protected (it's const for
devices which are not ops-locked).

Update the assert to avoid false positive warnings.

Cc: stable@vger.kernel.org
Fixes: b6c5f9454ef34 ("io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock")
Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://patch.msgid.link/20260806225627.3998672-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netdev_queues.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 4d6864bb4f6bc..f5558b12877c5 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -40,7 +40,7 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
 	struct netdev_rx_queue *hw_rxq;
 	struct device *dma_dev;
 
-	netdev_assert_locked_ops_compat(dev);
+	netdev_assert_locked(dev);
 
 	/* Only RX side supports queue leasing today. */
 	if (type != NETDEV_QUEUE_TYPE_RX || !netif_rxq_is_leased(dev, idx))
-- 
2.53.0

