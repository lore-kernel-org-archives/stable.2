Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BB3C2E
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160257; cv=none; b=BY0mY5//vkLghz9AQt3qLd1neUaLHKfpKiYvRHoK11VbuHQjhKzCeSpsEBXtVp4ybCjXGo8sNIFw4GJQVEJQ5knuSOTtpI8b4JcrHV42KC7/uVdzpITz3g2QM7/MiLj3dwBmX9r7qEL4/My75bK7/VxyAsdOKrLKBBdN3YT8BpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160257; c=relaxed/simple;
	bh=OTt88YPNZrwP9Kz7toxRFfOwKleyLmrw0cuFIHizdpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ+ZBHb3DvAM56SgNPzSvpsejGozB+hIeHI7mWj15ur2llgc/Km9OkKcsIeN5sr+JihJt0NofdPqYArEPuggDjOMnRPzJFNiFW1FUHkXu3zSfvnTuZYPottHbT9liRfAg3Oa7FX2gIQHROAnr2wo3J/DQ2uC2ASX/dUwnPzHt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFnqo8/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFnqo8/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843261F00A3A;
	Thu, 16 Jul 2026 00:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784160256;
	bh=Lhyze5CUUER93/bLj1orqS2K1e0WhP5eAPCexkWqOUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nFnqo8/4b6Ix7lLAgSiTOQsCawPP9EN5fyiW3EzbHXDhkUCVc/27z9gsVUnttQu7+
	 2SUfvlR+XBDkDxW6beSKSUv0AW82U99fntmVCGajzxwemJ5sor9zKN4+qIqYu8gG7m
	 EzDgj2JWDh7nsYQrbUSoeZK/NsrLjiSXW3fUP3vU7PnIVmYoIcLctOYZrLafiqZ3rB
	 sWHuu46k5+gibn6zhoTTuDDrPHP9uoCtDIwwDMdo4KWllzOlptKX0mcV6d8T7Dt+vg
	 zN+zDhYI3fHS6D9whmKhRE4XZKDC16AYjiU5XOvhDJrdGoZMlrcnSXBgL0GO5TKTAa
	 8XRkZDeFpZZeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
Date: Wed, 15 Jul 2026 20:04:12 -0400
Message-ID: <20260716000413.561625-2-sashal@kernel.org>
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
index b3eb416eaebd18..09f1ea2d81bca5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1896,6 +1896,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	cancel_delayed_work_sync(&conn->info_timer);
+	cancel_work_sync(&conn->id_addr_update_work);
+
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
@@ -1909,9 +1912,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	ida_destroy(&conn->tx_ida);
 
-	if (work_pending(&conn->id_addr_update_work))
-		cancel_work_sync(&conn->id_addr_update_work);
-
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -1936,9 +1936,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	hci_chan_del(conn->hchan);
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_timer);
-
 	hcon->l2cap_data = NULL;
 	conn->hchan = NULL;
 	l2cap_conn_put(conn);
-- 
2.53.0

