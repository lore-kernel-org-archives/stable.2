Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E687BE63
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160258; cv=none; b=jJsiuVlRgMzJ5E9Mdve9FSbdtEFJjdyaCIbZl48knOxiUQTOB2forbic0PvJwL0uYR+KNpO6AlKM7cM+6eOpPvOogQQ7cMAxwKT38jiNYP7CRxmzG5hATQFQw6gZcy5ewjeeaOscDRQ6ZqTmLX8zZELyfg/bRNVwJnjDg1nmxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160258; c=relaxed/simple;
	bh=k0WPrn5y7qhfWJefxZuTvUlzRpYC3hcsPlTmtC9JiPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vjh+6/5sT/MrWybljIcG3SNhavDJnjF3xfW6HxXzBhUBusfixRIheoTph6htTJlG6Sv6TH2cBdkwJnKYoDzelsxUEAIavE6GkFYgK6Kiu0u1yf0Dq2xUx5PXzqCbXPm8nRVNJtZ/qXCnzPRoPiHjsxLyTgrpfIj30MPc+Rb2yFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC2mpRRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC2mpRRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4BE1F00A3E;
	Thu, 16 Jul 2026 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784160256;
	bh=c/q9UUE/rd1TW5ISaVnsTGaJ/h8jvJ3g+VCUcI79HeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JC2mpRRvoCBGavFV8sLfMYiYiG/2jVZ83h6jnejx/oSa6WO/h/oRmnb4T4x7ogmar
	 eHYL5B3Xct6BOa1Jqm3z5ZyeOtAY/8xQlyF3Y0UBFQCydL+WdWeNk1ptqagfsZZ0lb
	 TAM3PZWFb3aqfeanQETaRSMAi8Ql44S2TR3LjvpaBHv/lNN3g6C100s51P7as7wcl2
	 1Tm32g1isyCEdrijaop5XU6XUxE2wtI8CnFUumRu1+LHGWFVr/n0cbPNvG0+pKqPjb
	 45D1esR5snTZpOYCs0Czn938Bg+omkfoimJ+o/b/Re1ukgVjO+NZOUF6Oi6AiHuI1I
	 RXBLwfsmISZsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock
Date: Wed, 15 Jul 2026 20:04:13 -0400
Message-ID: <20260716000413.561625-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716000413.561625-1-sashal@kernel.org>
References: <2026071336-evolve-imaging-b852@gregkh>
 <20260716000413.561625-1-sashal@kernel.org>
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
index 09f1ea2d81bca5..8ac34cd7ad8d0c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1899,17 +1899,11 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	cancel_delayed_work_sync(&conn->info_timer);
 	cancel_work_sync(&conn->id_addr_update_work);
 
+	cancel_work_sync(&conn->pending_rx_work);
+
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

