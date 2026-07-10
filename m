Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED12413245;
	Fri, 10 Jul 2026 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682089; cv=pass; b=oMnMHucRoZTFBRV+uvr86qsyH2S3sWF82K8TOco27NO2pNb0fFhg2QIf6vAtA1WHi+Ch8LD2x6UDAAzAEarPWC7rj3nVKJqkeSb0C5O4vL/JMm28lx1kZAzbnSsvud8DGQ6tkivYdYmb2pNkNAbTxROR4Co3kZuAPoeofSNHl8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682089; c=relaxed/simple;
	bh=F1KTYWnq+9g4j5MHk+R0ILEhmbsbyeXojT5qMs9y8d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoAmLSE9ORrH0Ri8EWjxyM+KAt94flR0A3TcR8D1tG/VS4XSfpACOYSn6I9lWE+7O08HE4FyyuW0ZvCIgXe6FWhmRjPihKZs9UMiUq/vVGTj5ocno74pJYTMP8Df8ZEr01AHjYOb26h2BhMRMWYcEL5F8Dkb5tjdwsr8u4wP6kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=laKUEiYk; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="laKUEiYk"
ARC-Seal: i=1; a=rsa-sha256; t=1783682040; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cC/ICZXfF1PPaasz/E3BNaljaXN+qnBbr8t0aYdAVdPzQQ3aXMlUSNFjgIpF+Z20jl9E1IDeU7jcX/IUBC+3ujOt07VwRF42Rx8aDZlR2SbuR1wS8IX62zAvyVCBIJmplwwL/uJurHzzQtam8MR7759N3/HqeS+UtO5A9vrmXgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783682040; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=n2VrqkVnW4B7S1gpVF6wwy16uSMDtNg0d+SAjOSYJeg=; 
	b=GjLHlQ+UiIysAtM4njkWSwm9tnItYHjUy+NXbcJMO33KRJEVxMhf1ugUB9ju8Ebpuu3AwMwznr3nOjYC76fF7QZ1Y4fChrOHneY0x6pc//uYCDItXwdeOrt9uj4EbkxVkOtnT0eU0VwVaPnAi5YHSnu44IdCNpyaaDuhmy9+c6M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783682040;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=n2VrqkVnW4B7S1gpVF6wwy16uSMDtNg0d+SAjOSYJeg=;
	b=laKUEiYkT5R79MzktC+t7ZYJtdMShEpX7mz1OyZO73MP2eQ9B9tTGGVF2m5I3pwk
	RRYwoCBaJsTD1M8nUsjbaseGjLQXuDiV8NRj1wp2CLoorN4p8AJvEjODsPYkB6MunsJ
	NFr6KSTO76R3uxB6ssrBkikSfwwNt93sxX0CcoyQ=
Received: by mx.zoho.eu with SMTPS id 1783682036480683.9563439480606;
	Fri, 10 Jul 2026 13:13:56 +0200 (CEST)
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
Subject: [PATCH net] mac802154: flush rx_mac_cmd_list before freeing sdata
Date: Fri, 10 Jul 2026 13:13:53 +0200
Message-ID: <20260710111353.12138-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mac802154_rx_mac_cmd_worker() (net/mac802154/rx.c) is queued on
local->mac_wq every time a MAC-command frame (assoc req/resp, disassoc
notify, beacon req) is received on any interface of a given phy. Each
queued struct cfg802154_mac_pkt stashes a *raw* pointer to the
receiving interface's ieee802154_sub_if_data (sdata) in
ieee802154_subif_frame():

	mac_pkt->sdata = sdata;
	list_add_tail(&mac_pkt->node, &sdata->local->rx_mac_cmd_list);
	queue_work(sdata->local->mac_wq, &sdata->local->rx_mac_cmd_work);

and the worker later dereferences it with no liveness check at all,
e.g. for IEEE802154_CMD_ASSOCIATION_REQ:

	if (mac_pkt->sdata->wpan_dev.iftype != NL802154_IFTYPE_COORD)

Neither teardown path drains this queue before the sdata it points to
is freed:

 * ieee802154_if_remove() (net/mac802154/iface.c), reached from the
   nl802154 NL802154_CMD_DEL_INTERFACE handler, does list_del_rcu() +
   synchronize_rcu() + unregister_netdevice(sdata->dev) -- which frees
   sdata via priv_destructor/needs_free_netdev -- without touching
   local->mac_wq or local->rx_mac_cmd_list at all.

 * ieee802154_unregister_hw() (net/mac802154/main.c) only flushes
   local->workqueue (the DATA-path queue) before calling
   ieee802154_remove_interfaces(), which frees every sdata on the
   phy; local->mac_wq is drained only via destroy_workqueue() much
   later, after the interfaces (and their sdata) are already gone.

Either way, if mac802154_rx_mac_cmd_worker() is already queued (or
races back in from a frame received just before teardown), it runs
after the free and dereferences freed memory -- confirmed under
KASAN: flooding a victim NODE interface with MAC_CMD frames from a
MONITOR interface on a sibling phy, then deleting the victim via
NL802154_CMD_DEL_INTERFACE, reliably produces:

  BUG: KASAN: use-after-free in mac802154_rx_mac_cmd_worker+0x463/0x630 [mac802154]
  Read of size 4 at addr ffff888004b22a18 by task kworker/u8:1/31
  Workqueue: phy0-mac-cmds mac802154_rx_mac_cmd_worker [mac802154]
  Freed by task 498: ... (the DEL_INTERFACE task, ieee802154_if_remove)

Verified on the same v6.19 KASAN stand with this patch applied: the
identical MONITOR-flood-then-DEL_INTERFACE reproducer no longer trips
the use-after-free report in mac802154_rx_mac_cmd_worker().

Fix it the same way mac802154_flush_queued_beacons() (net/mac802154/scan.c)
already flushes local->rx_beacon_list on scan cleanup, plus a
cancel_work_sync() step: rx_beacon_work's worker never dereferences
sdata, so the existing sibling doesn't need it, but rx_mac_cmd_work's
does. Add mac802154_flush_queued_mac_cmds(local, sdata):

 - cancel_work_sync(&local->rx_mac_cmd_work) waits out a run already
   in flight (still safe -- nothing has been freed yet) and blocks any
   new run from starting while we hold the RTNL;
 - every rx_mac_cmd_list entry whose ->sdata matches (or every entry,
   when called with sdata == NULL for full-teardown) is then dropped,
   so no future run of the worker can see it;
 - if entries belonging to *other*, still-live interfaces on the same
   local remain, the work is re-queued so they still get processed.

Call it from both teardown paths:

 - ieee802154_if_remove(), before unregister_netdevice(sdata->dev),
   filtered to the sdata being removed (other interfaces on the same
   phy may have legitimate entries in flight);
 - ieee802154_unregister_hw(), before ieee802154_remove_interfaces(),
   with sdata == NULL since every interface on the local is going
   away and local->workqueue's flush_workqueue() does not cover
   local->mac_wq.

This mirrors how mac80211 drains per-interface work (e.g. the
analogous per-sdata work items cancelled from ieee80211_do_stop()
before an interface is torn down) and the existing mac802154 scan.c
list-flush idiom, applied to the one rx_mac_cmd_list consumer that
actually dereferences the freed interface.

Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 net/mac802154/ieee802154_i.h |  2 ++
 net/mac802154/iface.c        | 10 +++++++++
 net/mac802154/main.c         | 11 ++++++++++
 net/mac802154/rx.c           | 42 ++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 8f2bff268392..e3c5c8d5b5d0 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -300,6 +300,8 @@ static inline bool mac802154_is_beaconing(struct ieee802154_local *local)
 }
 
 void mac802154_rx_mac_cmd_worker(struct work_struct *work);
+void mac802154_flush_queued_mac_cmds(struct ieee802154_local *local,
+				     struct ieee802154_sub_if_data *sdata);
 
 int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 				  struct ieee802154_pan_device *coord,
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 000be60d9580..a5aa213e25a2 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -694,6 +694,16 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	mutex_unlock(&sdata->local->iflist_mtx);
 
 	synchronize_rcu();
+
+	/*
+	 * Drop any rx_mac_cmd_list entry still pointing at this sdata
+	 * before it is freed below: mac802154_rx_mac_cmd_worker() runs
+	 * asynchronously on local->mac_wq and derefs mac_pkt->sdata with
+	 * no liveness check of its own (see mac802154_flush_queued_mac_cmds()
+	 * for details).
+	 */
+	mac802154_flush_queued_mac_cmds(sdata->local, sdata);
+
 	unregister_netdevice(sdata->dev);
 }
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ea1efef3572a..2f8c57e78db1 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -277,6 +277,17 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 	tasklet_kill(&local->tasklet);
 	flush_workqueue(local->workqueue);
 
+	/*
+	 * tasklet_kill() above stops any further frame reaching
+	 * ieee802154_subif_frame(), but mac802154_rx_mac_cmd_worker() may
+	 * still be queued/running on local->mac_wq and derefs the sdata of
+	 * every interface ieee802154_remove_interfaces() is about to free
+	 * below. flush_workqueue(local->workqueue) does not cover it --
+	 * that is the DATA workqueue, not local->mac_wq -- so drain it
+	 * explicitly first.
+	 */
+	mac802154_flush_queued_mac_cmds(local, NULL);
+
 	rtnl_lock();
 
 	ieee802154_remove_interfaces(local);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index cd8f2a11920d..0b167f76cb23 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -128,6 +128,48 @@ out:
 	kfree(mac_pkt);
 }
 
+/**
+ * mac802154_flush_queued_mac_cmds - drop pending rx_mac_cmd_list work
+ * @local: the mac802154 device the queue belongs to
+ * @sdata: interface being torn down, or %NULL to flush unconditionally
+ *
+ * Every queued &struct cfg802154_mac_pkt stashes a raw pointer to the
+ * interface it was received on (see ieee802154_subif_frame() below) which
+ * mac802154_rx_mac_cmd_worker() dereferences without ever checking whether
+ * that interface is still alive. Callers must invoke this before freeing
+ * @sdata -- or every interface on @local, when @sdata is %NULL -- so the
+ * worker can never run against freed memory:
+ *
+ *  - cancel_work_sync() waits out a run already in flight. That is still
+ *    safe to let finish because nothing has been freed yet, and it blocks
+ *    any new run from starting for as long as we hold the RTNL.
+ *  - every list entry pointing at @sdata (all of them, if @sdata is NULL)
+ *    is then dropped so no future run of the worker can see it.
+ *
+ * Mirrors mac802154_flush_queued_beacons() in scan.c, which does not need
+ * the cancel_work_sync() step because its worker never dereferences sdata.
+ */
+void mac802154_flush_queued_mac_cmds(struct ieee802154_local *local,
+				     struct ieee802154_sub_if_data *sdata)
+{
+	struct cfg802154_mac_pkt *mac_pkt, *tmp;
+
+	cancel_work_sync(&local->rx_mac_cmd_work);
+
+	list_for_each_entry_safe(mac_pkt, tmp, &local->rx_mac_cmd_list, node) {
+		if (sdata && mac_pkt->sdata != sdata)
+			continue;
+
+		list_del(&mac_pkt->node);
+		kfree_skb(mac_pkt->skb);
+		kfree(mac_pkt);
+	}
+
+	/* Other interfaces on @local may still have entries pending. */
+	if (!list_empty(&local->rx_mac_cmd_list))
+		queue_work(local->mac_wq, &local->rx_mac_cmd_work);
+}
+
 static int
 ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		       struct sk_buff *skb, const struct ieee802154_hdr *hdr)
-- 
2.50.1 (Apple Git-155)

