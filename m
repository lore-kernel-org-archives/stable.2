Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB53D79EF
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159729; cv=none; b=PEjGtC7YW9Bfd9c5UvN4FxHMzQutaIXs1eqYKDoy/cgXZbEV2egrz2MeGi+2qT3ZIEJDepA6Za7xQaRA/kifcCcQNOFI1hIbfzxwZmWBmg4epMiC05tfTHzQDtRGnZJ1FCx7B2CJ02flooMRMGjcA4ELEO+QesxIy5k/dGcEafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159729; c=relaxed/simple;
	bh=ovDEl8L+yXiw684ZhJkDkmA0UJ0b5oS3bq5iVTelYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9HrTLoHUdJ8JqROJz9ABuDyKy8Y6EokeeDn+TwaiIJJXcBMdd8QDpGS51B/UWtZmUUU2fL31OtyssLrFQKboc0pvF6ePcj7UlNXFCWfvHUexxZisi5ymR+lc8/ilaz34/pOUKc6OSUb1kcVkQHA6ubWT2BQV3Y+pPepHOVZZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWMZ7VNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWMZ7VNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720E51F00A3F;
	Wed, 15 Jul 2026 23:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159728;
	bh=WrWgRHp+ZuzhdiT2SwSQKqgTGE0K6rgWHoRHaf0rTj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HWMZ7VNz+d6PW8WdxpDjHdX77XBmFkAfgKqgLHWwruAtIMFbfhzMSgGo1sbo1WVjY
	 yz9jDfOpf+2p4adDVSppdiKZBsZ9TXrd9XAIu2C6C9CoN9jaY7fqNl+l2N9wnEoyEc
	 7Ec9nfPppeGrqHjyZFpNee2UKAjmYUWHKJhlio9N2/KE7z6g2sqskfQI+6locACJ/w
	 24slbRhegCqQhSfHEssyGeUDce+cZheguuJXerAZarYn/T/x1Nmfo3Pa+vqBmYD71q
	 3yYh/nwGDyF6E2mMLyV2hjpYw0nPMgyNoltU58JWXSD4RDaS4uIBYwtunsiT4HRnhg
	 Uea9qadvyRfYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
Date: Wed, 15 Jul 2026 19:55:24 -0400
Message-ID: <20260715235525.525483-2-sashal@kernel.org>
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
index e62f5aa38ab040..b4353a439ae0ff 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1920,6 +1920,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	cancel_delayed_work_sync(&conn->info_timer);
+	cancel_work_sync(&conn->id_addr_update_work);
+
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
@@ -1933,9 +1936,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	ida_destroy(&conn->tx_ida);
 
-	if (work_pending(&conn->id_addr_update_work))
-		cancel_work_sync(&conn->id_addr_update_work);
-
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -1960,9 +1960,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	hci_chan_del(conn->hchan);
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_timer);
-
 	hcon->l2cap_data = NULL;
 	conn->hchan = NULL;
 	l2cap_conn_put(conn);
-- 
2.53.0

