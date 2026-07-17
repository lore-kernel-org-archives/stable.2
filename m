Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F735E95E;
	Fri, 17 Jul 2026 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285940; cv=pass; b=gclLHWG4Cc+dJhy+CbcB4GV9xlSk0Pj4GqIOGsa7+c4woX1ezxHqudURV0lx4aBBfSrTjZfuMFaHNp5HMjQQJqxfcQEpWCY67ubk/BkIKyZZlT/ANFr7CiRQ4Iem3L3ZfcD8tSD8hYRo0f4BZ3Di3ssJoPoFmx3kiKh+bB/7E4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285940; c=relaxed/simple;
	bh=8u0whOsd+mmn1SMUmzQ5shT1J8XMawKQK2hsBsDrBwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQXpArxxFwnUyURIxkKSidsEV1Jgo4YKG1LS0hHxeV8jdDRTqEDV5ofvlbvdlWRZrtJ8+7BMD8vIG1Wx+YNzWZU1tvYSqmI3t8AX3/kUIgHEYiJ7UEzywJksFhhfZ3X/rX/V8q5q3scRWozjSH8TD2dY7hV1A5Qk3Ej9LL+W/ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=LGQtjftx; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="LGQtjftx"
ARC-Seal: i=1; a=rsa-sha256; t=1784285897; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EAckR6cqY7bIkEmftKPTAdk/2viGjnM3kMd2TKoUbiYz6PLQbsigAkzhBi4J/stQZdZ/fQ5eGrNbBaLTA2H26Y8rbylEQGBBsUfeiFy7dgpZHn3CpMxm+Kd+IpZUqWuV2uVA6OqItrxo7KQjg6bfriD+qqZfQhnuUhXTvf17MEc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784285897; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bg1KaixGUzd1fGg12IcFm179oJF5oYZKPHKuj76fMuk=; 
	b=Yy1fhaALace5hnB+YGI3mJjOoutiDP/9beuVGMkPduPf5k2hwvcxuJePn3QNGw3fcL9qdcQD9lU1LFyJ3zc4JZv7eegeeDArNvtIDNxJeuE/MCeR0OaOGAVWiIoxgPqsYOBM09P/98322rRjdtLIYGkX3cvBK6q1lobqS7IEVd8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784285897;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bg1KaixGUzd1fGg12IcFm179oJF5oYZKPHKuj76fMuk=;
	b=LGQtjftxoTRJrIvF48Rizd6Oo2QIfIvEkatmmeB9NvCFQ+e3ihigXcJM0eqyijFR
	SEeFzdxqo4wW0whdi3umE6XYaPMyEBSTLxn1aySDKeZEWjNe+Ri9C9Wa8mGgm6nixOr
	Gwy1Q/2mnv8qDx4FkZv6tCOT+ZgCcnMk+E4rU/qc=
Received: by mx.zoho.eu with SMTPS id 1784285893972518.5676848574119;
	Fri, 17 Jul 2026 12:58:13 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mac802154: hold an interface reference across the scan worker
Date: Fri, 17 Jul 2026 12:58:09 +0200
Message-ID: <20260717105810.26226-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260710140927.13228-1-security@auditcode.ai>
References: <20260710140927.13228-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mac802154_scan_worker() captures the scanning sub-interface once under
RCU:

	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(scan_req->wpan_dev);

and then, after rcu_read_unlock() and outside the rtnl, keeps
dereferencing sdata->dev: in the channel-change and restart failure
traces, in mac802154_transmit_beacon_req() (skb->dev = sdata->dev) for
active scans, in the final dev_dbg(), and in the end_scan
mac802154_scan_cleanup_locked() path. Nothing keeps that netdev alive
for the duration of the worker iteration.

A concurrent teardown of the scanning interface -- userspace issuing
NL802154_CMD_DEL_INTERFACE (ieee802154_if_remove() ->
unregister_netdevice()), or a full PHY removal via
ieee802154_unregister_hw() -> ieee802154_remove_interfaces() -- can run
as soon as the worker drops the rtnl between its two short
drv_set_channel()/drv_start() sections. The netdev is not freed
synchronously by unregister_netdevice(): it is queued to net_todo_list
and freed later from netdev_run_todo(), which drops the rtnl mutex
(__rtnl_unlock()) *before* netdev_wait_allrefs_any()/free_netdev(). The
freeing therefore runs with the rtnl not held, on whichever task next
drains net_todo_list. Holding the rtnl in the worker does not prevent
it, and the per-PHY IEEE802154_IS_SCANNING flag does not identify the
specific interface: a subsequent NEW_INTERFACE + TRIGGER_SCAN re-arms
the flag, so a stale worker iteration sails past an is-scanning recheck
and dereferences the already-freed netdev.

Triggering the race requires CAP_NET_ADMIN: both
NL802154_CMD_TRIGGER_SCAN and NL802154_CMD_DEL_INTERFACE are
GENL_ADMIN_PERM, reachable only from the initial user namespace, so
the attacker is a locally privileged (CAP_NET_ADMIN) user, not an
unprivileged local user or a remote peer.

KASAN slab-use-after-free, kworker reading the freed
net_device/ieee802154_sub_if_data (kmalloc-cg-4k) allocated and freed by
the racing NEW_INTERFACE/DEL_INTERFACE task:

  BUG: KASAN: slab-use-after-free in mac802154_scan_worker+0x... [mac802154]
  Read of size 8 ... by task kworker/u8:N
  Workqueue: phy0-mac-cmds mac802154_scan_worker [mac802154]
   mac802154_scan_worker
   process_one_work

Fix it by taking a reference on the interface while the RCU read lock is
still held -- so the netdev cannot be freed before the refcount is
raised -- and releasing it at every exit of the worker past that point.
This keeps sdata->dev valid for the whole iteration. The reference does
not defer the free indefinitely: a teardown started while it is held
simply blocks in netdev_run_todo() until the current iteration returns,
and it cannot self-deadlock the single-threaded mac_wq because the
unregistering task claims the net_todo_list entry under the rtnl, so the
blocking netdev_wait_allrefs_any() always runs on that task, not on the
worker.

Verified on a v6.19 KASAN build: racing DEL_INTERFACE against an
in-flight TRIGGER_SCAN reliably tripped a slab-use-after-free KASAN
report inside mac802154_scan_worker() before this patch, and the
same reproducer no longer triggers it with the fix applied.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v2: trim the in-worker comment down to the essentials, as requested by
    Miquel Raynal. No functional change.

 net/mac802154/scan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 300d4584533e..5b4ea2a895cc 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -209,6 +209,14 @@ void mac802154_scan_worker(struct work_struct *work)
 		return;
 	}
 
+	/*
+	 * sdata->dev is dereferenced below after rcu_read_unlock() and outside
+	 * the rtnl, and a concurrent DEL_INTERFACE / PHY teardown can free it
+	 * asynchronously from netdev_run_todo(). Pin it with a reference taken
+	 * while the RCU read lock is still held, and drop it at every exit.
+	 */
+	dev_hold(sdata->dev);
+
 	wpan_phy = scan_req->wpan_phy;
 	scan_req_type = scan_req->type;
 	scan_req_duration = scan_req->duration;
@@ -262,12 +270,14 @@ void mac802154_scan_worker(struct work_struct *work)
 		"Scan page %u channel %u for %ums\n",
 		page, channel, jiffies_to_msecs(scan_duration));
 	queue_delayed_work(local->mac_wq, &local->scan_work, scan_duration);
+	dev_put(sdata->dev);
 	return;
 
 end_scan:
 	rtnl_lock();
 	mac802154_scan_cleanup_locked(local, sdata, false);
 	rtnl_unlock();
+	dev_put(sdata->dev);
 }
 
 int mac802154_trigger_scan_locked(struct ieee802154_sub_if_data *sdata,
-- 
2.50.1 (Apple Git-155)
