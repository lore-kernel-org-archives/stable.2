Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BA7E0FF;
	Fri, 10 Jul 2026 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692602; cv=pass; b=pvGSZvRb6bZqKrdr7VyS8jbQV5uG5nmFJT5YPLyATfpXuIsIbJH+zUFCTmgyN6Ja+lfQhv8A+yahY635qrZjbASgNsRHCc+KOYjQ5n9ks3RkC8f4tuqb12TaH/yIa6S5X5DKe/ptvXG/wmWCuQ0mIZjguT9N4ajDk4zv7LdvB4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692602; c=relaxed/simple;
	bh=ljlWwhl4MSRmsGSt3hHwCd+GEOrvQNMsv6KnBv/Gqrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e64X0EI+Un0th5yX3nv0JdH80LkwuN+P7lB7naqLgP3XqYogmT1bKoDySUwONA2kzsVxR6gAZTPMVJ5wLGEXrGWbfQIYJI0dMXbjUiVsxhMNjw5EARXMXSD6VG2dMMhYQ6//yHh42GTB/1aanY9sHowalh2iHHO5bveZWJlxxGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=L42I8ROO; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="L42I8ROO"
ARC-Seal: i=1; a=rsa-sha256; t=1783692572; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hZt1XXdWXnyF+M0kkOS36AutrormeCoalrRP4+WUfesRkZkJBvFbd/vXqEkwkFe+oUi3TcWm4dwN+5KcpzGzgKsX9rRn3GSy9Sa6iJKoaTzw92xMBGMfuuScxbgkZV5N6dUtMR7ggHtcCrNwu/JRZtBPMOagR6NFSdU6ziG++Ls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783692572; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QCpA9hNQb2+dY/GdVuoFivLwBHgPhQwaGW2XRacNqTc=; 
	b=RGajrwKgKArpL0HaMw7yGQKsgxmzXauSIWadw6Lrc2k8gSCgirh7iiYirX7a+7MQ6T2NlbbfB/3F4GjcoJo1UYmcj63BlNkN4mumegs1/Yo4xGm0EEP96rKXEBJcNf9x8kxbNSiQBRvhW4xyuptpzu0Azb3YeJ51XxkA/2UlqOk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783692572;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QCpA9hNQb2+dY/GdVuoFivLwBHgPhQwaGW2XRacNqTc=;
	b=L42I8ROOJ/E7fJRbD4nEJ3eBzHmAOh1hFq+cD4Ez//jO+f4RFM6hzy5JpM/IfT33
	5SA/1z5SWRmAGHbTTvZ9D6OTgUQyRUWw9Ia/uRt0yWsZd/x6uS00snNDpNPRjL+iWLO
	wG7yNPh99CWhiiwIys/3/iGnKwHHgxsJ9hQR2lfU=
Received: by mx.zoho.eu with SMTPS id 178369256977454.46577705906941;
	Fri, 10 Jul 2026 16:09:29 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] mac802154: hold an interface reference across the scan worker
Date: Fri, 10 Jul 2026 16:09:27 +0200
Message-ID: <20260710140927.13228-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
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
  (also hit via ieee802154_mlme_tx_locked() from the beacon-request path
   and via _dev_err()/__dev_printk() formatting sdata->dev->dev)

Fix it by taking a reference on the interface while the RCU read lock is
still held -- so the netdev cannot be freed before the refcount is
raised -- and releasing it at every exit of the worker past that point.
This keeps sdata->dev valid for the whole iteration.

The reference does not defer the free indefinitely and does not
deadlock the single-threaded mac_wq. Each worker iteration drops the
reference before it requeues itself, and a teardown started while the
reference is held simply blocks in netdev_run_todo() until the current
iteration returns. It cannot be the worker's own rtnl_unlock() that
blocks on the reference either: the unregistering task removes the
netdev from net_todo_list under the rtnl (list_replace_init() in
netdev_run_todo() runs before __rtnl_unlock()), so it always owns the
todo entry, and the worker acquires the rtnl only afterwards -- the
blocking netdev_wait_allrefs_any() therefore always runs on the
teardown task, never on the worker.

Verified on a v6.19 KASAN build: racing DEL_INTERFACE against an
in-flight TRIGGER_SCAN reliably tripped a slab-use-after-free KASAN
report inside mac802154_scan_worker() before this patch, and the
same reproducer no longer triggers it with the fix applied.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Cc: stable@vger.kernel.org
Assisted-by: AuditCode-AI:2026.07
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
---
 net/mac802154/scan.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 0a31ac8d8415..48e661031cc0 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -209,6 +209,26 @@ void mac802154_scan_worker(struct work_struct *work)
 		return;
 	}
 
+	/* From here on sdata->dev is dereferenced after rcu_read_unlock() and
+	 * outside the rtnl: in the dev_err()/dev_dbg() traces below, in
+	 * mac802154_transmit_beacon_req() (skb->dev = sdata->dev) and in the
+	 * end_scan mac802154_scan_cleanup_locked() call. A concurrent teardown
+	 * of that interface (NL802154_CMD_DEL_INTERFACE ->
+	 * ieee802154_if_remove(), or a full PHY removal via
+	 * ieee802154_unregister_hw()) can unregister the netdev; the actual
+	 * free then runs asynchronously from netdev_run_todo() with the rtnl
+	 * already dropped, so neither holding the rtnl nor the per-PHY
+	 * IEEE802154_IS_SCANNING flag keeps sdata->dev alive here. Pin it with
+	 * a reference taken while we still hold the RCU read lock (so the
+	 * netdev cannot be freed before we bump the refcount) and drop it at
+	 * every exit below. This blocks the teardown's netdev_run_todo() until
+	 * this worker iteration is done; it cannot self-deadlock because the
+	 * unregistering task claims the net_todo_list entry under the rtnl, so
+	 * the blocking netdev_wait_allrefs_any() always runs on that task, not
+	 * on this single-threaded worker.
+	 */
+	dev_hold(sdata->dev);
+
 	wpan_phy = scan_req->wpan_phy;
 	scan_req_type = scan_req->type;
 	scan_req_duration = scan_req->duration;
@@ -262,12 +282,14 @@ void mac802154_scan_worker(struct work_struct *work)
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

