Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53E32E128
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148584; cv=none; b=b/toUt6SUjjHNTvMme3Fc7EDTe6kKoUySNyvrxWE6Kzej2k0Nq2x+Kz1hrr8Lt4c3fT3ZzBjZjGTT8M8MfLdUN3KXXTfsXU6rx28mxbSUayazdGzMTvIry4rWZ4T38/mLCHwMwxIHxjxw7OkNU9z4GdngaN7fPaj42h4NeGMVM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148584; c=relaxed/simple;
	bh=9f/bOpyPyIUAuCdlQX4qYHE1Y4ru1wIeJeUnrVe0BPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Coovc7yPeZSvHe3+qQZ1e1K1nzkvB45c6It9tqONTcj/o1H8AVi9EZ4O/vdRZOB8ijIx100HhVKwhkU5HusEuUomg4CHQXRRumBZvJ3jMWgZXMyiKk8NbPgJkW/SRDQbvFtEB2NDW5a8yQENcXIT/ZPTM1078Zok+WVM54Xog78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZjvRbWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZjvRbWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097311F000E9;
	Wed, 15 Jul 2026 20:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148582;
	bh=PFjXbao5lLjelfp265K0o8btPXx/OaSDhgYZsOJ6akM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jZjvRbWA8GKk8yUaB63c/A2VSARA62m3bmi8aY8Tyr9qHlZJNPRsg+VQcz4efWvDY
	 v5rkHAsCSO45E6e8fVwfSBKyLZDAC9Pt9oraWG/jQglz3Nor9+6mhUuoTmzoaLSt3x
	 1csnDTCEklHMIhZBZXcPJII2cMlCJOBRBcKLkLxZelmOeo6SdS07OAu/yCTkwrPp42
	 j68Rxf42c+U7JxLrsVYCe/V0uh7gJoox/Ft4GaHPxws/JSIrdq2iR2/3om559cBWc6
	 Uk5NTUQi92m19/HE0XkhRaVw1WjMdyBqw1dmQqtPGnrDJgDC4fWXKq/aR1f8EZaYzT
	 9SZjD6KE94MAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister
Date: Wed, 15 Jul 2026 16:49:39 -0400
Message-ID: <20260715204940.205049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071306-outflank-referable-b441@gregkh>
References: <2026071306-outflank-referable-b441@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 9707a015fe8f3ba8ec7c270f3b2b8efb38823d6b ]

6lowpan.c has theoretically conflicting lock orderings, which lockdep
complains about:

    a) rtnl_lock > hdev->workqueue

    from 6lowpan.c:delete_netdev -> rtnl_lock -> device_del
    -> put_device(parent) -> hci_release_dev -> destroy_workqueue

    b) hdev->workqueue > l2cap_conn->lock > chan->lock > rtnl_lock

    from hci_rx_work -> 6lowpan.c:chan_ready_cb
    -> lowpan_register_netdev, ifup -> rtnl_lock

Actual deadlock appears not possible, as hci_rx_work is disabled and
l2cap_conn flushed already on hdev unregister. Hence, do minimal thing
to make lockdep happy by breaking chain a) by holding hdev refcount
until after netdev put in 6lowpan.c.

Fixes the lockdep complaint:
WARNING: possible circular locking dependency detected.
kworker/0:1/11 is trying to acquire lock:
ffff8880023b3940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x8b/0x130
but task is already holding lock:
ffffffff95e4f9c0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30
Workqueue: events delete_netdev

Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 6fef032af009 ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/6lowpan.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 960a19b3e26da1..cb1e329d66fd4e 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -760,13 +760,33 @@ static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
 	return chan;
 }
 
+static void unregister_dev(struct lowpan_btle_dev *dev)
+{
+	struct hci_dev *hdev = READ_ONCE(dev->hdev);
+
+	/* If netdev holds last reference to hci_dev (its parent device), this
+	 * leads to theoretical cyclic locking on lowpan_unregister_netdev:
+	 *
+	 * rtnl_lock -> put_device(parent) -> hci_release_dev ->
+	 * destroy_workqueue -> hci_rx_work -> l2cap_recv_acldata ->
+	 * chan_ready_cb -> ifup -> rtnl_lock
+	 *
+	 * However, hci_rx_work is disabled in hci_unregister_dev, so this
+	 * should not occur. Make lockdep happy by postponing hdev release after
+	 * netdev put.
+	 */
+	hci_dev_hold(hdev);
+	lowpan_unregister_netdev(dev->netdev);
+	hci_dev_put(hdev);
+}
+
 static void delete_netdev(struct work_struct *work)
 {
 	struct lowpan_btle_dev *entry = container_of(work,
 						     struct lowpan_btle_dev,
 						     delete_netdev);
 
-	lowpan_unregister_netdev(entry->netdev);
+	unregister_dev(entry);
 
 	/* The entry pointer is deleted by the netdev destructor. */
 }
@@ -1252,6 +1272,7 @@ static void disconnect_devices(void)
 			break;
 
 		new_dev->netdev = entry->netdev;
+		new_dev->hdev = entry->hdev;
 		INIT_LIST_HEAD(&new_dev->list);
 
 		list_add_rcu(&new_dev->list, &devices);
@@ -1263,7 +1284,7 @@ static void disconnect_devices(void)
 		ifdown(entry->netdev);
 		BT_DBG("Unregistering netdev %s %p",
 		       entry->netdev->name, entry->netdev);
-		lowpan_unregister_netdev(entry->netdev);
+		unregister_dev(entry);
 		kfree(entry);
 	}
 }
-- 
2.53.0

