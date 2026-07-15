Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F43CF204
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159725; cv=none; b=jm8dW4fnP1HNeYObeevEJR6sdohmOdTmS11xu/mgQgGWHBD7Dqxrv/VXkt5KeaBH6D+pIAAT6VXzXS3kvq9bYWEsjxgGLEdnAFc2OiUMkjuIYx/DWEU2ilCIzFchPodCXWV3mjKDctf+Dbk40B4Ok5G4Nk/PCnk+MGaX+sw+Bfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159725; c=relaxed/simple;
	bh=ZoP7rbJtiraXdfw81Ac6fPD09wRVTA2qajsPMHui9qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8ulkKphdW+lZihtLIIqU1pyEe2yw17sFV/+sdPH7N35Xc6XExJa6kWZdYhIuEq+V7Ta07Se4COgMLfcvf3LE4PPcbWwGXSLJ1eWRYW/QD48Ko1Kjq3ymeJ0kB1JV8cQ+jJObLP5K74/9JGbG9LA8ymqMwY+uxDUN6fau/Nfx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/Eus+eX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/Eus+eX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457CB1F00ACA;
	Wed, 15 Jul 2026 23:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159723;
	bh=/IBimKOK9cz0eDJ4cY6DAcvLe8+lILyXLyDUdsMruvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/Eus+eXgtfgwI9aavfh3X6yF80x2AQchsVZ4Dho9bdRBmIKp6X9E/Mks0TFwZIu+
	 G9/BfEtTu3IUloNtIWaIgdVW2Eyvf5Jpqo3IDS0mN5z57BDcLBFZRVG2DS292/fZ+L
	 oUtJPOHr2iAgrfu5zryftrZb/utudqHWjIF0JTupq8mGgWINp4sAdwYkbZAGT1LGWH
	 eJJrgp0iJ2tGpp1iiiFvchDOQfjk9PbhIgCxMRlMyS9j5aNIlgFZilBemaKlOmk8VS
	 vM4oqGEt2Sa7DMfutC4gVVmBqXuUcGAk6YgoWMzb815ByO0fUR4ly38jYxsqvahW6Y
	 JDdy0wjQMpBtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister
Date: Wed, 15 Jul 2026 19:55:18 -0400
Message-ID: <20260715235519.525147-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715235519.525147-1-sashal@kernel.org>
References: <2026071307-release-elongated-f82c@gregkh>
 <20260715235519.525147-1-sashal@kernel.org>
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
index dc3d1d5326e96a..de521a3501caf3 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -759,13 +759,33 @@ static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
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
@@ -1245,6 +1265,7 @@ static void disconnect_devices(void)
 			break;
 
 		new_dev->netdev = entry->netdev;
+		new_dev->hdev = entry->hdev;
 		INIT_LIST_HEAD(&new_dev->list);
 
 		list_add_rcu(&new_dev->list, &devices);
@@ -1256,7 +1277,7 @@ static void disconnect_devices(void)
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

