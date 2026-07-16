Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C49460
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161014; cv=none; b=QqWYQvr+2fBoBg7VKWKq9O/1J163XggwHlFhR6BTkrp8nJr15kZzT9s+1Z4ZZP988q7vlixATDNbddy+AWinOTbOwlWvDmsUUa1ola4XAouLIRTjllRIrDalcNrgHFmA19GTBdSFvOeToPUjuypSAiNUeCzzsj/A9g8nHbjH4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161014; c=relaxed/simple;
	bh=vYkqKJzgIbk8OpsAH609e5OHNAZ2toyd2+ql9gFVlDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ap9hd37sWMAIKmqhRBuohoQ8sDzdni4Hk8QIj5qT00RFMxIXLSeJe2vzK4Sc5lWXnm+al575DP/804ym76bejnxUTrxQRRf/Th3k3Wrf0Am1VXWEIyqLCNkoVQifxcskFjf3ftCA/UobCpuLX2pfmJNqWm/cgfiRUOhARMfi8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arNJs5PV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arNJs5PV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85311F00A3A;
	Thu, 16 Jul 2026 00:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161013;
	bh=9IUfriwPPzlXd2kPevJiqagNrnQg8AMiyfwHZTExPX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arNJs5PVOZkYWx5BolYyKnqyBhYrEruqkGrC8wUKoPvReX2xrsiRfg1HXBLUyF7AR
	 4+V25Jg0OpilBRTprNbWjp3tArwUj0JiYsqpI/HdT/igiKcrLrKSNIQFVeNvMAt9L6
	 IZxgcBgHu72BUKhCs6FG8UJnSTrxO3IObi3gPdwvD6KRXwWUuo1ARh7qLLKlyz3UQg
	 1qG3LsyMaUhbsoyYpvs3XsNpN13Yp3NjHJXwdfSfoVJl1SzoO9QCvw9Xm3wx7uaVMH
	 keFcgEO7/bwY98QWrac2fugZFYQD6Kn3IsENxdWrTem5bJ6UAvUU2p5U5aP05KCTLa
	 j4EkzuAIN4yqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
Date: Wed, 15 Jul 2026 20:16:49 -0400
Message-ID: <20260716001650.589781-2-sashal@kernel.org>
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

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 00fdebbbc557a2fc21321ff2eaa22fd70c078608 ]

l2cap_conn_del() calls cancel_delayed_work_sync() for both info_timer
and id_addr_timer while holding conn->lock. However, the work functions
l2cap_info_timeout() and l2cap_conn_update_id_addr() both acquire
conn->lock, creating a potential AB-BA deadlock if the work is already
executing when l2cap_conn_del() takes the lock.

Move the work cancellations before acquiring conn->lock and use
disable_delayed_work_sync() to additionally prevent the works from
being rearmed after cancellation, consistent with the pattern used in
hci_conn_del().

Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 2641a9e0a1dd ("Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f1e230f6d6f866..273aefd2e2686e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1898,6 +1898,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	cancel_delayed_work_sync(&conn->info_timer);
+	cancel_work_sync(&conn->id_addr_update_work);
+
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
@@ -1911,9 +1914,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	ida_destroy(&conn->tx_ida);
 
-	if (work_pending(&conn->id_addr_update_work))
-		cancel_work_sync(&conn->id_addr_update_work);
-
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -1938,9 +1938,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	hci_chan_del(conn->hchan);
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_timer);
-
 	hcon->l2cap_data = NULL;
 	conn->hchan = NULL;
 	l2cap_conn_put(conn);
-- 
2.53.0

