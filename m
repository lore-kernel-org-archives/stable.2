Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78036334C3C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150325; cv=none; b=emRCvHff+hPUR/OncxlohqiUkaoWaF3aMz3XHIH/hjjES6el6qo95HrCe9G2QyqcEPN4LvHCg3LE1NvvyyZF8hxXBCVagej/qbO5tRerZjyw3uN+uENH3V/ndWS7R/NpvGhhhFxI/GmNb7QHqBasCHRcokNIQugpDfP628Qsbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150325; c=relaxed/simple;
	bh=RQubne6QaRARcfxZzqRDU+CEmPTu6h0dDlt+5UcTjGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8VEMkUyeyQw56w2CL5aDUm0n7Ysxs7JCNrFJkTiD/Kj6nDa1AYfYqRVvHPKE2kEeVpSVY0oZBmHLQSiXmq2VQ5pPYpR/mlhY4c9DTU+cPhBWiKF9xjU1acxdcLpwGBnQf/4ygOb+oj+N7BXpIoM7IkPuS1Y7yUmpyFPWc0MfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9efB9ku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9efB9ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A01F000E9;
	Wed, 15 Jul 2026 21:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150324;
	bh=OurxIxYyGFwxLLgR4P8+JcrZ6H1huhfiOtkXHkC8koA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n9efB9kuSDyQfqPCHOMqDk5tFxBhwpQCiTN4DF6qmi3068tjmQrC+RJHuzSm731jq
	 FTBKpBK58wvHwOOrY8EpmbZOu6IdWN0TcyTZ8RDDGeJ6MhLhghkZbhfknVgFH4we/W
	 79UlEnSgF6Ljcrshd1Anp6NCNToZ/U7fnoce9kkjmkvY8JV//gVqEhQHsKCWqGnoEU
	 PI8317kRsXSGbR2f3bPCHvQY4Zco3SqpJX6jyMb1OsA3vwofxQm31yThOFBMd3HXv3
	 eeL/3CB2FdIk/Nvw6HInzqSDzj+t4GdbdAOt8Ns7VodJ//7KCKxIg0KicCrAv3MKV5
	 7Va9DSHr4wmQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock
Date: Wed, 15 Jul 2026 17:18:42 -0400
Message-ID: <20260715211842.270885-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-canning-tyke-381a@gregkh>
References: <2026071335-canning-tyke-381a@gregkh>
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
[ adjusted context for 6.6 lacking the disable_delayed_work_sync() conversion and the ida_destroy(&conn->tx_ida) line from the tx_ident IDA dependency ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3426eedf20ad96..8ce0cb30bb92b4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1758,19 +1758,13 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
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
 	cancel_delayed_work_sync(&conn->id_addr_timer);
 
 	l2cap_unregister_all_users(conn);
-- 
2.53.0

