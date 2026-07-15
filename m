Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40093D7D67
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159730; cv=none; b=IATf/UBWDziIf80/LA0Ljlr9mrwwQB8uJMYYvSjL/3F7dlG66YKs6OGvjEwhFdZ4GjEOewhKsLp872TfsRMUqrBPGUq0mqR5EqigaorpBfjUVdi2o41+AcfUzJMDFyRepYvfOSDofarICedzKQ6COu75mvafxF0fhapQZ8Vk3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159730; c=relaxed/simple;
	bh=Pv+zq+hKFgZ8gsnpL7IpFAVeGNrZJbF6lE53HN1ez+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+eYdqhkJSFSvkudhR8VP11JSRgkdg9PY9sdYfBN8dPcuiN9nd1eS+9W3dCztbZP5OYJivs2tOrI5QuFG3TE3dkW5IkWQMzslz6TMA3llDVQExV29Ep3RlfRMZaFa4QntK8oWarhOxg3Sa23Q2K08up6ntuqKY4j0UjYrku+Pi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EITdNQeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EITdNQeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC781F00A3A;
	Wed, 15 Jul 2026 23:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159728;
	bh=EzDrOuVLABs3ii508eelOOSvqT0DAu01Grjedtu0bQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EITdNQeI6EI/EX9FWcui1QVqJ+pxvlJxQx4piooRFZtL3qpK/zGGm7XMLu/JamiQj
	 +x6G+yGzKwOkpWo7niFQ9q0XdnOVLMv6TSdaPbYRjS5imu2yGxk7S0fRqvOqUf+2YP
	 KCgN4MgNoUasBm/5GQ4d+Ca43NhLooDOCPZ6cOSzgk1CLMHeNVblC5NIzKmQqZNXVM
	 dbTs6YOYCPSE7rPVO1zWBLJpUolzZPql9sC2ND/9VMoTsTZ159X4n3SMkAX0W0BuPz
	 7InIGLTvVbic5Ij/pWG3JZjntMMjbkvMpyuRx7+RrbNPszDA/9pFzNBjF6QyHhwx27
	 Iyd4kz2YuJG9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock
Date: Wed, 15 Jul 2026 19:55:25 -0400
Message-ID: <20260715235525.525483-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715235525.525483-1-sashal@kernel.org>
References: <2026071336-hastily-statistic-2a3e@gregkh>
 <20260715235525.525483-1-sashal@kernel.org>
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
index b4353a439ae0ff..86372809fb95b2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1923,17 +1923,11 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
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

