Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD03C8C5E
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148589; cv=none; b=o00hfi4injyJNfipHRZNSDGijXx6JdUlB5zWUJcpdjVNOa6sjlxGjdYAoNNMDzPFLOx2h4XLZJfq4+/GKZ8PGP16l6nvDGYJXstrwycFbkxPAoUGj3F6QGqdQ4SwBbZchwRHLV8rqAiGR8c/ncAYnzNdZ+XG7sTCmC0/vf3VCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148589; c=relaxed/simple;
	bh=rEWdLArwXeciA1Ovtw4zB3eooXgnYGquqV4fCH2o+P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qhi8Dv7SNnXTKxYluadlGCpPpMoE7q/lcsMNpicjrkDGBIYBukvPz36dFoasILCmjZT9IV/NWwbctlMlif9GDlYxJOfoDg0U3awy5AQchBR3u8HzpvUkGhF28y/CWPxBCcdZT66sI05IVHyV1Or0oVRxaelDZqYJ3En3MkeyKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nudm/0/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nudm/0/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0831F00A3D;
	Wed, 15 Jul 2026 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148587;
	bh=cg5t5tay48yXO3giKfN0KjrbR5h+OpQvlIad/m/fxEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nudm/0/jd42uwbupNbts5ndiFTss/uVhsmTlIgmKku+sWrs0PaQ2eaNN8nfVgt0GF
	 3Uji2+p0IEtSz7AIIujvSkXpD12Sqc+C5RAlKOtTjyhbYEIQKQvFE3VkOTHzgUxRgZ
	 j1kg+7oQ6FWhjGUH0qrHzfkd2fnKIDd6wfYKlKY/or4oPDwqTmlK5gpwEZk91A/9z0
	 t/AwJQb9M3XY5HSo+eOHSw8TglLlwUnZPAX+op29uzGBkkSua0KpBfJCi/9v51+OVM
	 6NBzXVu/XE0VBXWgrhTFvE9kMafl9rAU/vW8j8X53NV2/N1m+mRAdQ4K/Z6Hmr2nFe
	 eFF6GnwZDzR+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock
Date: Wed, 15 Jul 2026 16:49:44 -0400
Message-ID: <20260715204944.205221-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715204944.205221-1-sashal@kernel.org>
References: <2026071335-renovator-imprison-ad7b@gregkh>
 <20260715204944.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 2641a9e0a1dd4af2e21995470a21d55dd35e5203 ]

l2cap_conn_del() takes conn->lock and then calls cancel_work_sync() for
pending_rx_work.  process_pending_rx() takes the same mutex, so teardown
can deadlock against the worker it is flushing.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the l2cap_conn_ready() -> queue_work(...,
&conn->pending_rx_work) submit path, the l2cap_conn_del() ->
cancel_work_sync(&conn->pending_rx_work) teardown path, and the
process_pending_rx() -> mutex_lock(&conn->lock) worker edge.  Lockdep
reported:

  WARNING: possible circular locking dependency detected
  process_pending_rx+0x21/0x2a [vuln_msv]
  l2cap_conn_del.constprop.0+0x3f/0x4e [vuln_msv]
  *** DEADLOCK ***

Cancel pending_rx_work before taking conn->lock, matching the existing
lock-before-drain ordering used for the two delayed works in the same
teardown path.  The pending_rx queue is still purged after the work has
been cancelled and conn->lock has been acquired.

Fixes: 7ab56c3a6ecc ("Bluetooth: Fix deadlock in l2cap_conn_del()")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 90e2ec9d20bb8a..e2671c7d2e0585 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1753,19 +1753,13 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	disable_delayed_work_sync(&conn->info_timer);
 	disable_delayed_work_sync(&conn->id_addr_timer);
 
+	cancel_work_sync(&conn->pending_rx_work);
+
 	mutex_lock(&conn->lock);
 
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
-
-	/* We can not call flush_work(&conn->pending_rx_work) here since we
-	 * might block if we are running on a worker from the same workqueue
-	 * pending_rx_work is waiting on.
-	 */
-	if (work_pending(&conn->pending_rx_work))
-		cancel_work_sync(&conn->pending_rx_work);
-
 	ida_destroy(&conn->tx_ida);
 
 	l2cap_unregister_all_users(conn);
-- 
2.53.0

