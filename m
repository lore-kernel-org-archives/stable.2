Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D943B3C0;
	Tue, 21 Jul 2026 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668394; cv=pass; b=WVUC3BnhzXv8xi5F9/lv6ArfnEwvwSWiR3aaRrszvZtJ0s0JhqGQ+K0YTPV1mj6/IYLxDXiPACd3Xfzlcybrye9YZ0zIWn8OzsHCDL0AkqJKitgcXGyytJPor3tjlrYHuEbI6jKmzyLjrXE3QHdft/+HKjCb2kHZKFW6rnCosBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668394; c=relaxed/simple;
	bh=kopSzOLFv0LYRPvL5e3te8gpYYgGX/dfPD9eGvVZGlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8KxyZOfiCc1q+Q71/fHtRHHAo//DNsfkmEr8icJsc6n9e8esWy5/7BFVNTLHQC6okdZpUhBHNjes1UTzSIJ8CiUrgRE1AfEIsS+ES2beyKaBqID0ffs7YoTTOxbTwXT5c8JKnPBNTkNaNeDsRKqoHuVwahH78tv6VHOrVuM+1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=aIj0XNpi; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="aIj0XNpi"
ARC-Seal: i=1; a=rsa-sha256; t=1784668355; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=N5t9/eYwfyPRBYtAccYzkFs2bEU4XODrS9Ssp3RUxso+0qzB9Fnwqh5Z7xwjC0aPLfH/E6OQ/hlLPD2XY0DYaYufD7KFzCHD04hwlbJjlT/LkHT5rJySstFwnMVwfvVgOzARGcdD+MKt8A+cG4g96LxxGvTYshxNdNYfQvFBpqE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784668355; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QeFUDXTU+8c0zbYt8CslVaYA7kSqyrt/Ag6133VbfvQ=; 
	b=lko69w83d3DmqHwSD0GOnzepJu3qopXvQP4zQwiLrncaml4n4rqOQwoV3n4A+ivKrlCrN8d7M83eZ3afUZVSIc86KsgGqPu6V5RHWVRuo5yMBZ+lLs5z1S1xtkx1KwdOPL10FT4JyWZL3pC5BXDg1HGgfR437Xhvw8vlT2boZwc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784668355;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QeFUDXTU+8c0zbYt8CslVaYA7kSqyrt/Ag6133VbfvQ=;
	b=aIj0XNpi2vjLB8Oi0Di9tvDfGrkkBzf7PRv73sTERNDZ7cRyXnJQ80MaQBT32rSZ
	mqFSvQQ4ZOYK28b4Fx1FUK0xjxt5GKLMr6W6tiQCszqq+U3IEGBvwqlCEWcTKam6rey
	X5kMhRuRBvhm2DQqT12wsZ/ZGYwZewcgPLFxVbVE=
Received: by mx.zoho.eu with SMTPS id 1784668353161225.38155391120165;
	Tue, 21 Jul 2026 23:12:33 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	stefan@datenfreihafen.org
Cc: kuba@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] mac802154: hold an interface reference across the scan worker
Date: Tue, 21 Jul 2026 23:12:28 +0200
Message-ID: <20260721211228.34578-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mac802154_scan_worker() captures the scanning sub-interface under RCU
and then keeps dereferencing sdata->dev after rcu_read_unlock() and
outside the rtnl -- in the failure traces, in
mac802154_transmit_beacon_req() (skb->dev = sdata->dev), and in the
end_scan cleanup. Nothing keeps that netdev alive across the worker
iteration.

A concurrent DEL_INTERFACE or PHY removal can unregister the interface
once the worker drops the rtnl between its two drv_set_channel()
sections. unregister_netdevice() frees the netdev asynchronously from
netdev_run_todo() with the rtnl already dropped, so neither holding the
rtnl nor the per-PHY IEEE802154_IS_SCANNING flag prevents a stale worker
iteration from dereferencing the freed netdev -- a KASAN
slab-use-after-free, reachable by racing TRIGGER_SCAN against
DEL_INTERFACE (both CAP_NET_ADMIN).

Pin the netdev with netdev_hold() while the RCU read lock is still held,
and release it at every worker exit.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v3: use netdev_hold()/netdev_put() with a stack tracker instead of
    dev_hold()/dev_put(), per Jakub Kicinski. Posted standalone.
v2: trim the in-worker comment, per Miquel Raynal.

 net/mac802154/scan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 300d4584533e..d452b8d8fbb6 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -180,6 +180,7 @@ void mac802154_scan_worker(struct work_struct *work)
 	struct ieee802154_sub_if_data *sdata;
 	unsigned int scan_duration = 0;
 	struct wpan_phy *wpan_phy;
+	netdevice_tracker dev_tracker;
 	u8 scan_req_duration;
 	u8 page, channel;
 	int ret;
@@ -209,6 +210,14 @@ void mac802154_scan_worker(struct work_struct *work)
 		return;
 	}
 
+	/*
+	 * sdata->dev is dereferenced below after rcu_read_unlock() and outside
+	 * the rtnl, and a concurrent DEL_INTERFACE / PHY teardown can free it
+	 * asynchronously from netdev_run_todo(). Pin it with a reference taken
+	 * while the RCU read lock is still held, and drop it at every exit.
+	 */
+	netdev_hold(sdata->dev, &dev_tracker, GFP_ATOMIC);
+
 	wpan_phy = scan_req->wpan_phy;
 	scan_req_type = scan_req->type;
 	scan_req_duration = scan_req->duration;
@@ -262,12 +271,14 @@ void mac802154_scan_worker(struct work_struct *work)
 		"Scan page %u channel %u for %ums\n",
 		page, channel, jiffies_to_msecs(scan_duration));
 	queue_delayed_work(local->mac_wq, &local->scan_work, scan_duration);
+	netdev_put(sdata->dev, &dev_tracker);
 	return;
 
 end_scan:
 	rtnl_lock();
 	mac802154_scan_cleanup_locked(local, sdata, false);
 	rtnl_unlock();
+	netdev_put(sdata->dev, &dev_tracker);
 }
 
 int mac802154_trigger_scan_locked(struct ieee802154_sub_if_data *sdata,
-- 
2.50.1 (Apple Git-155)
