Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33889175A8D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161015; cv=none; b=ai0DSyasTWJomMo0gahUQpqcabmYEIIHKA/JSymqpO1fLSmeq0OCot8SLNZ0hMiy0/+pSt/2PgXoM+vxPaGXzvc3iozDNf3iTJ2+ad51pvgmS2UO0B9gN6Pab/kfpuQSALXji7U8Qrxe8QERQv4J+tWtIvbGEIi6357NxXM/0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161015; c=relaxed/simple;
	bh=+K9oeJ+n7vld5d1/ADl6JGWEax8idAN4rJz4lgk2saY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMIl6b5Ul9uhbqGgR4Tqw7gR1nzzAuNPwhv3ozCPXjoK5/UMyX3+zUgbCThOHCZFHCwr12D+KDZ3MavZGoIbreb0zktPm+irR//fDfHaaLVhjnrSyz38Vbdac4TJR68NSQWb1t9ERXylSWauMj930QCEKVQXtE5yEX2lch50HRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM6uQlTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM6uQlTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F8E1F00A3E;
	Thu, 16 Jul 2026 00:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161013;
	bh=QWNnj/nDuOWnJrcw64UmA2iwdTzf9jkpw2RcRmoB+2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JM6uQlTy69vGxMHNitZ+nwuVrR353FofYYn6mHtTGOXXOQt2KSG4n2SLVfkRu1+/Z
	 saWnYwRMBBnH1RlKFRRNiKoyfV6SIVLryS6Lo0+MwsM/gTpXdo2TO/b7xpEyQ+Xg15
	 4f+cr5HiuxfQJ7wXgZSlAJmcYM4G8rwXBYKbCTW49RqUWGC3ozYCeN402zAwOP1qcZ
	 QZY2etPwu1rKQEt8l3158kJHCOIxvut4hhJOTLYLOfAggq8P0Igvhl2gUME7YKNyom
	 7cW2YnKdGJqaZ9O5LLIWIiG9iV0ErylSs0nmGewuKdSFQmNM678Rdvd7mxAe9uayg+
	 tYt3nhdhFCE0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock
Date: Wed, 15 Jul 2026 20:16:50 -0400
Message-ID: <20260716001650.589781-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716001650.589781-1-sashal@kernel.org>
References: <2026071337-culminate-graveness-5fc7@gregkh>
 <20260716001650.589781-1-sashal@kernel.org>
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
index 273aefd2e2686e..c4c698086c2918 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1901,17 +1901,11 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
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

