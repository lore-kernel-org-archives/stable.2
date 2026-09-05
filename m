Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465E4B26FA
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625839; cv=none; b=qZHKAnVLLReWaTUaDXlRoxL9wrBoWZA3oIAHx0T4gECC7XIn3a5VwWf8j0dZmjPDcid3vSzP6h7GE8wxgjjH3y9O21y0nnhjgArE9+EUl/6Lj6Y7I30ItZXkuIUwWNYz8TfJID8s2C7JEEiZKqRn1/CM89gDtuU2+Od9Ddcq5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625839; c=relaxed/simple;
	bh=FYUcp9AI8dgVEUhyn9b9RAewk6WlDyCgO+D5WF0cYNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxY0MgT1UPzlIbmrug86DuyUFSQYsp/lOEtsbOaahBolNewm/pywd9WENALbE+Z9wlrhMNTb3wPzpD1P/ZL6I7Kk8WSkcW/YpZ8fLXgcE65A4EyEYIIvlltb/7+YmyMiae/rNpmZgMmcIWMzbHpPQs6Sp6QkZqpQo/UjlhPhYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=mQdcl8im; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="mQdcl8im"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39266382df6so1657768a91.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788625824; x=1789230624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DTSljqCW+nuwJcWwpqgF8fLF7WImJ8NueVVB9p6phE=;
        b=mQdcl8im7BiHhmqsrlXaVZoh3KUtHnxQPtRuXgxnYqvhgSph0W6szs430Y2et/NYfo
         jQ9LgeCuRAthQ/MHlPVUFoGBQ4hFSNTt765rZlLg2S6CShMjPLfc3hw7ObX/AoBKPe3a
         HPHp7Z0K10s/OcFWhnmQTNC02x+fpo+qGNsN008rQKaobGeOCojXrizdGKbPcj1Z8fiw
         r7RXzXHlR7RbSGl3kZSb7rFwW3anNb1K0Bd0YojfN+TYzdthLFYEzXKPfxRWXzCiDTye
         wBLo/8JgRNmPzU8huYSGBZO5wMJjp0nytnYbwUsmqk/o5Hc+Z/V1CqTxe61EERSI7DE8
         CEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788625824; x=1789230624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6DTSljqCW+nuwJcWwpqgF8fLF7WImJ8NueVVB9p6phE=;
        b=XJGUbMiR3knRW6a4Utp0fkb2RRCKbBwazXTY1cIl1tyHbhaV7yRkVHZi1Z2JVdsFP9
         SvBrwXKX4PGXs13G57U6pGzwxonqYjrPXH0+5fdrVDPWvXr75rjENmY7YLlINJbBcl+c
         kL2oXIEHmY74Aou0KkzK3IqK9d7GqIEzkH1XCfSwCbHF65tqsfHtV3jCOx2dk1uS45Kp
         rJK/e3lUSvt7OA1De/DpfT9hOasjaEi1Yy5X+e0WGIwpxJ9VWRME47K5/I3VFsS2CSze
         X9N0RnL8CfM1ON9NDN8bolvD4swR+mqwofi/Gu/CqFiUMOF4zrdY4lVgclPzMeQ8TGPW
         2Lcw==
X-Forwarded-Encrypted: i=1; AKwUvBxFsVFdcNmSzSwdXcBKDdS0xyN+TBr6cVqjrb1vdl6boTfllke+ZQ1baeD4N4+G3En/E94SIRo=@vger.kernel.org
X-Gm-Message-State: AFuF++k6KFLcDD7LoFmlHf7ZWVk8xnBouaI6/O/Ea0kXlmdCNJVLbvv1
	ynEj6nxVCXnWbglpZTvgXg+InbYJaAUjYPDsGaYgeICTt0TeVPD+hZD26rRcfU8Axx7EOzRCHQx
	wY5lhhg==
X-Gm-Gg: AYBFou2991pcD663LPpaH8BalkqDrTdVy1YNj/w1t3q+/v9gDbBg9Y1sECrG+d1hFaZ
	sE15FZbvChne+kqUuVLcNKDFXjnh058PTZ98u5pxL+d1Skdph4KmlvnFbX5hi9OkxWO9oLo1hUt
	1siWeYERMT+oYnx5MKCnV/IT2aE3jANduT/qlQP2PQaytStWSky/dmuSlTQWKuYyUM8no3lHI+y
	3hl6YMV6u9vD6XFKgU2UKETzBlriM7xcdliHHOyBH5+V58o0zg26Ra2EvYp3zWFZ1uOjTSde1V0
	f0QmAxZJqrnBDwt7CVG6/N0r4YhLDXoRc0eDuo1FrquN2G7IWUf92zjkJA5RWyHVy+BnhjdlE/n
	wdMeFd4+oRFd4VUl8b2phy1oCXPtcR64QYMzl9C0Ba3xbWWHrP/FXsJ7QZhlML8meVL4Ho61wEj
	Q0iSAgv7V9r8UiiEUA9zaisQDouVjXedWAWpIairxkEOUeTvV7zUKzVxXUdKVgjjwUBvKx3gca4
	KoTLizBLa4uSBZCTo8zNUqKqWzGVw==
X-Received: by 2002:a17:90a:149:b0:39b:2b10:d05c with SMTP id 98e67ed59e1d1-39b2b115ba1mr13349217a91.5.1788625824146;
        Sat, 05 Sep 2026 09:30:24 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c397b1sm16781207a91.8.2026.09.05.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 09:30:23 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 1/1] ipv6: ip6mr: fix mr_table leak from MRT6_TABLE
Date: Sat,  5 Sep 2026 16:30:07 +0000
Message-ID: <5fc14a8ba754126b6897939e11154167281d4c5f.1788622674.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788622674.git.zihanx@nebusec.ai>
References: <cover.1788622674.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MRT6_TABLE is supposed to select a multicast routing table id, but
ip6_mroute_setsockopt() currently calls ip6mr_new_table() for every
unseen id. The new mr_table is linked into mr6_tables and is only
destroyed when the net namespace goes away.

A raw ICMPv6 socket with CAP_NET_ADMIN can therefore loop
MRT6_TABLE(fresh id) without MRT6_INIT, close the socket, and still
leave the tables allocated. Repeating this grows unreclaimable slab
until the machine OOMs.

The same lifetime hole remains after a successful MRT6_INIT,
MRT6_ADD_MIF or MRT6_ADD_MFC on a fresh id: ip6mr_sk_done() only
unbinds mroute_sk and flushes MIF/MFC state, so an empty non-default
table stays in mr6_tables until netns teardown.

Keep MRT6_TABLE as a selector: store the chosen id on the socket and
create the table only when a later command actually needs it
(MRT6_INIT, MRT6_ADD_MIF, MRT6_ADD_MFC, or MRT6_ADD_MFC_PROXY). That
matches existing users such as the ipmr selftest, which issues
MRT6_TABLE and then ADD_MIF without INIT.

Allocate the table unpublished, take RTNL, publish it, then run the
INIT/ADD command so a notifier cannot observe a missing tb_id. If the
command fails, unlink and free the still-empty table in the same
syscall.

Once a non-default table is empty again - no mroute_sk, no VIFs and
no MFC entries - drop it from mr6_tables on MRT6_DONE, socket close,
DEL_MIF, DEL_MFC, FLUSH or NETDEV_UNREGISTER. Leave the default table
in place. Do not call ip6mr_free_table() while the netns is alive; it
WARNs unless mr_can_free_table() is true. mr_table_free() already
waits for RCU.

A MIFF_REGISTER VIF delete with notify=0 unregisters the pimreg
device immediately. That nested NETDEV_UNREGISTER may already have
unlinked the empty table, so maybe_destroy must no-op if the table is
no longer on mr6_tables. The device notifier only reclaims when this
unregister actually removed a VIF.

Walk mr6_tables with list_for_each_entry_safe in NETDEV_UNREGISTER so
freeing the current table cannot advance a stale iterator. The netns
exit path already does this.

Read mfc_unres_queue under mfc_unres_lock. The expire timer and the
unresolved enqueue path mutate that list without RTNL.

If unresolved MFC entries delay that reclaim, retry after the expire
timer drains the queue. The timer cannot call maybe_destroy itself,
so bounce the work to RTNL. If GFP_ATOMIC allocation fails, reschedule
the expire timer instead of dropping the reclaim.

Control paths that used ip6mr_get_table() after dropping RCU now
re-lookup under RTNL or hold rcu_read_lock across the use.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Drop the shared mr_table refcount / list_del_rcu path that broke
    the ipmr forwarding selftest.
  - Limit the fix to net/ipv6/ip6mr.c; leave mroute_base.h, ipmr.c
    and ipmr_base.c unchanged.
  - Keep MRT6_TABLE as a selector and create the table only when
    MRT6_INIT, MRT6_ADD_MIF, MRT6_ADD_MFC or MRT6_ADD_MFC_PROXY
    actually needs it, so ADD_MIF without INIT still works.
  - Allocate the table unpublished, publish it under RTNL, then run
    INIT/ADD so a VIF/MFC notifier cannot race a missing tb_id.
  - If INIT, ADD_MIF or ADD_MFC fails, destroy the still-empty table
    in the same syscall.
  - Reclaim empty non-default tables on MRT6_DONE, socket close,
    DEL_MIF, DEL_MFC, FLUSH and NETDEV_UNREGISTER. Leave the default
    table in place.
  - Skip maybe_destroy if the table is already unlinked, so a nested
    NETDEV_UNREGISTER cannot double-free it.
  - Only reclaim from the device notifier when this unregister
    actually removed a VIF; MIFF_REGISTER immediate unregister must
    not destroy an already-cleared table.
  - Walk mr6_tables with list_for_each_entry_safe in NETDEV_UNREGISTER
    so destroying the current table cannot use a freed iterator.
  - Check mfc_unres_queue under mfc_unres_lock before reclaim.
  - After the unresolved MFC expire timer drains the last entry,
    queue maybe_destroy onto RTNL; do not destroy from the timer.
  - If GFP_ATOMIC work allocation fails, reschedule the expire timer
    and retry maybe_destroy when the unresolved queue is already
    empty.
  - Re-lookup the table under RTNL or hold rcu_read_lock across
    control-path uses, instead of ip6mr_get_table() after dropping RCU.
  - Place new_table locals in the INIT/ADD case blocks so the
    setsockopt declaration block keeps reverse xmas tree order.
  - v1 Link:
    https://lore.kernel.org/all/cover.1784795838.git.zihanx@nebusec.ai/

 net/ipv6/ip6mr.c | 327 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 280 insertions(+), 47 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3f2ed9b77deb5..26bd2ccd4201a 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/compat.h>
 #include <linux/rhashtable.h>
+#include <linux/workqueue.h>
 #include <net/protocol.h>
 #include <linux/skbuff.h>
 #include <net/raw.h>
@@ -368,6 +369,12 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
 	return mrt;
 }
 
+static struct mr_table *ip6mr_lookup_sk_table(struct sock *sk)
+{
+	return __ip6mr_get_table(sock_net(sk),
+				 raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+}
+
 static int ip6mr_hash_cmp(struct rhashtable_compare_arg *arg,
 			  const void *ptr)
 {
@@ -417,6 +424,124 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 			      ipmr_expire_process, ip6mr_new_table_set);
 }
 
+/* table_set callback used while the new table is still unpublished. */
+static void ip6mr_table_no_publish(struct mr_table *mrt, struct net *net)
+{
+}
+
+static struct mr_table *ip6mr_get_or_alloc_sk_table(struct sock *sk,
+						    bool *new_table)
+{
+	u32 id = raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT;
+	struct net *net = sock_net(sk);
+	struct mr_table *mrt;
+
+	ASSERT_RTNL();
+	*new_table = false;
+
+	mrt = __ip6mr_get_table(net, id);
+	if (mrt)
+		return mrt;
+
+	mrt = mr_table_alloc(net, id, &ip6mr_mr_table_ops,
+			     ipmr_expire_process, ip6mr_table_no_publish);
+	if (!IS_ERR(mrt))
+		*new_table = true;
+	return mrt;
+}
+
+static void ip6mr_publish_new_table(struct mr_table *mrt, bool new_table)
+{
+	if (new_table)
+		ip6mr_new_table_set(mrt, read_pnet(&mrt->net));
+}
+
+static void ip6mr_maybe_destroy_table(struct mr_table *mrt)
+{
+	ASSERT_RTNL();
+
+#ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
+	if (mrt->id == RT6_TABLE_DFLT)
+		return;
+	/* Nested NETDEV_UNREGISTER may already have unlinked this table. */
+	if (__ip6mr_get_table(read_pnet(&mrt->net), mrt->id) != mrt)
+		return;
+	if (rtnl_dereference(mrt->mroute_sk) ||
+	    mrt->maxvif ||
+	    !list_empty(&mrt->mfc_cache_list))
+		return;
+
+	spin_lock_bh(&mfc_unres_lock);
+	if (!list_empty(&mrt->mfc_unres_queue)) {
+		spin_unlock_bh(&mfc_unres_lock);
+		return;
+	}
+	spin_unlock_bh(&mfc_unres_lock);
+
+	list_del_rcu(&mrt->list);
+	timer_shutdown_sync(&mrt->ipmr_expire_timer);
+	mr_table_free(mrt);
+#endif
+}
+
+#ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
+struct ip6mr_destroy_work {
+	struct work_struct work;
+	struct net *net;
+	u32 id;
+};
+
+static void ip6mr_destroy_workfn(struct work_struct *work)
+{
+	struct ip6mr_destroy_work *dw =
+		container_of(work, struct ip6mr_destroy_work, work);
+	struct mr_table *mrt;
+
+	rtnl_lock();
+	mrt = __ip6mr_get_table(dw->net, dw->id);
+	if (mrt)
+		ip6mr_maybe_destroy_table(mrt);
+	rtnl_unlock();
+	put_net(dw->net);
+	kfree(dw);
+}
+
+static void ip6mr_queue_maybe_destroy(struct mr_table *mrt)
+{
+	struct net *net = read_pnet(&mrt->net);
+	struct ip6mr_destroy_work *dw;
+
+	if (mrt->id == RT6_TABLE_DFLT)
+		return;
+
+	dw = kmalloc_obj(*dw, GFP_ATOMIC);
+	if (!dw) {
+		mod_timer(&mrt->ipmr_expire_timer, jiffies + HZ);
+		return;
+	}
+	if (!maybe_get_net(net)) {
+		kfree(dw);
+		return;
+	}
+	INIT_WORK(&dw->work, ip6mr_destroy_workfn);
+	dw->net = net;
+	dw->id = mrt->id;
+	queue_work(system_dfl_wq, &dw->work);
+}
+#else
+static void ip6mr_queue_maybe_destroy(struct mr_table *mrt)
+{
+}
+#endif
+
+static int ip6mr_finish_new_table(struct mr_table *mrt, bool new_table,
+				  int err)
+{
+	if (new_table && err)
+		ip6mr_maybe_destroy_table(mrt);
+	return err;
+}
+
 static void ip6mr_free_table(struct mr_table *mrt,
 			     struct list_head *dev_kill_list)
 {
@@ -866,16 +991,25 @@ static void ipmr_do_expire_process(struct mr_table *mrt)
 static void ipmr_expire_process(struct timer_list *t)
 {
 	struct mr_table *mrt = timer_container_of(mrt, t, ipmr_expire_timer);
+	bool empty = false;
 
 	if (!spin_trylock(&mfc_unres_lock)) {
 		mod_timer(&mrt->ipmr_expire_timer, jiffies + 1);
 		return;
 	}
 
-	if (!list_empty(&mrt->mfc_unres_queue))
+	if (!list_empty(&mrt->mfc_unres_queue)) {
 		ipmr_do_expire_process(mrt);
+		empty = list_empty(&mrt->mfc_unres_queue);
+	} else {
+		/* Retry after GFP_ATOMIC allocation failure. */
+		empty = true;
+	}
 
 	spin_unlock(&mfc_unres_lock);
+
+	if (empty)
+		ip6mr_queue_maybe_destroy(mrt);
 }
 
 /* Fill oifs list. It is called under locked mrt_lock. */
@@ -1290,19 +1424,34 @@ static int ip6mr_device_event(struct notifier_block *this,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
+#ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
+	struct mr_table *mrt, *next;
+#else
 	struct mr_table *mrt;
+#endif
 	struct vif_device *v;
 	int ct;
 
 	if (event != NETDEV_UNREGISTER)
 		return NOTIFY_DONE;
 
-	ip6mr_for_each_table(mrt, net) {
+#ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
+	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list)
+#else
+	ip6mr_for_each_table(mrt, net)
+#endif
+	{
+		bool vif_gone = false;
+
 		v = &mrt->vif_table[0];
 		for (ct = 0; ct < mrt->maxvif; ct++, v++) {
-			if (rcu_access_pointer(v->dev) == dev)
+			if (rcu_access_pointer(v->dev) == dev) {
 				mif6_delete(mrt, ct, 1, NULL);
+				vif_gone = true;
+			}
 		}
+		if (vif_gone)
+			ip6mr_maybe_destroy_table(mrt);
 	}
 
 	return NOTIFY_DONE;
@@ -1618,10 +1767,11 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 
 static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
 {
-	int err = 0;
 	struct net *net = sock_net(sk);
+	int err = 0;
+
+	ASSERT_RTNL();
 
-	rtnl_lock();
 	spin_lock(&mrt_lock);
 	if (rtnl_dereference(mrt->mroute_sk)) {
 		err = -EADDRINUSE;
@@ -1637,8 +1787,6 @@ static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
 					     NETCONFA_MC_FORWARDING,
 					     NETCONFA_IFINDEX_ALL,
 					     net->ipv6.devconf_all);
-	rtnl_unlock();
-
 	return err;
 }
 
@@ -1677,6 +1825,7 @@ int ip6mr_sk_done(struct sock *sk)
 			mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MFC,
 					    &dev_kill_list);
 			err = 0;
+			ip6mr_maybe_destroy_table(mrt);
 			break;
 		}
 	}
@@ -1723,27 +1872,45 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return -EOPNOTSUPP;
 
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
-
 	if (optname != MRT6_INIT) {
-		if (sk != rcu_access_pointer(mrt->mroute_sk) &&
-		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		bool is_mroute_sk = false;
+
+		rcu_read_lock();
+		mrt = ip6mr_lookup_sk_table(sk);
+		if (mrt && sk == rcu_access_pointer(mrt->mroute_sk))
+			is_mroute_sk = true;
+		rcu_read_unlock();
+
+		if (!is_mroute_sk && !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EACCES;
 	}
 
 	switch (optname) {
-	case MRT6_INIT:
+	case MRT6_INIT: {
+		bool new_table = false;
+
 		if (optlen < sizeof(int))
 			return -EINVAL;
 
-		return ip6mr_sk_init(mrt, sk);
+		rtnl_lock();
+		mrt = ip6mr_get_or_alloc_sk_table(sk, &new_table);
+		if (IS_ERR(mrt)) {
+			rtnl_unlock();
+			return PTR_ERR(mrt);
+		}
+		ip6mr_publish_new_table(mrt, new_table);
+		ret = ip6mr_sk_init(mrt, sk);
+		ret = ip6mr_finish_new_table(mrt, new_table, ret);
+		rtnl_unlock();
+		return ret;
+	}
 
 	case MRT6_DONE:
 		return ip6mr_sk_done(sk);
 
-	case MRT6_ADD_MIF:
+	case MRT6_ADD_MIF: {
+		bool new_table = false;
+
 		if (optlen < sizeof(vif))
 			return -EINVAL;
 		if (copy_from_sockptr(&vif, optval, sizeof(vif)))
@@ -1751,10 +1918,18 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		if (vif.mif6c_mifi >= MAXMIFS)
 			return -ENFILE;
 		rtnl_lock();
+		mrt = ip6mr_get_or_alloc_sk_table(sk, &new_table);
+		if (IS_ERR(mrt)) {
+			rtnl_unlock();
+			return PTR_ERR(mrt);
+		}
+		ip6mr_publish_new_table(mrt, new_table);
 		ret = mif6_add(net, mrt, &vif,
 			       sk == rtnl_dereference(mrt->mroute_sk));
+		ret = ip6mr_finish_new_table(mrt, new_table, ret);
 		rtnl_unlock();
 		return ret;
+	}
 
 	case MRT6_DEL_MIF:
 		if (optlen < sizeof(mifi_t))
@@ -1762,7 +1937,14 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&mifi, optval, sizeof(mifi_t)))
 			return -EFAULT;
 		rtnl_lock();
+		mrt = ip6mr_lookup_sk_table(sk);
+		if (!mrt) {
+			rtnl_unlock();
+			return -ENOENT;
+		}
 		ret = mif6_delete(mrt, mifi, 0, NULL);
+		if (!ret)
+			ip6mr_maybe_destroy_table(mrt);
 		rtnl_unlock();
 		return ret;
 
@@ -1783,17 +1965,39 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		if (parent == 0)
 			parent = mfc.mf6cc_parent;
 
-		mutex_lock(&net->ipv6.mfc_mutex);
+		rtnl_lock();
+		if (optname == MRT6_DEL_MFC || optname == MRT6_DEL_MFC_PROXY) {
+			mrt = ip6mr_lookup_sk_table(sk);
+			if (!mrt) {
+				rtnl_unlock();
+				return -ENOENT;
+			}
+		} else {
+			bool new_table = false;
 
-		if (optname == MRT6_DEL_MFC || optname == MRT6_DEL_MFC_PROXY)
-			ret = ip6mr_mfc_delete(mrt, &mfc, parent);
-		else
+			mrt = ip6mr_get_or_alloc_sk_table(sk, &new_table);
+			if (IS_ERR(mrt)) {
+				rtnl_unlock();
+				return PTR_ERR(mrt);
+			}
+			ip6mr_publish_new_table(mrt, new_table);
+			mutex_lock(&net->ipv6.mfc_mutex);
 			ret = ip6mr_mfc_add(net, mrt, &mfc,
 					    sk ==
 					    rcu_access_pointer(mrt->mroute_sk),
 					    parent);
+			mutex_unlock(&net->ipv6.mfc_mutex);
+			ret = ip6mr_finish_new_table(mrt, new_table, ret);
+			rtnl_unlock();
+			return ret;
+		}
 
+		mutex_lock(&net->ipv6.mfc_mutex);
+		ret = ip6mr_mfc_delete(mrt, &mfc, parent);
 		mutex_unlock(&net->ipv6.mfc_mutex);
+		if (!ret)
+			ip6mr_maybe_destroy_table(mrt);
+		rtnl_unlock();
 		return ret;
 
 	case MRT6_FLUSH:
@@ -1807,8 +2011,14 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			return -EFAULT;
 
 		rtnl_lock();
+		mrt = ip6mr_lookup_sk_table(sk);
+		if (!mrt) {
+			rtnl_unlock();
+			return -ENOENT;
+		}
 		mroute_clean_tables(mrt, flags, &dev_kill_list);
 		unregister_netdevice_many(&dev_kill_list);
+		ip6mr_maybe_destroy_table(mrt);
 		rtnl_unlock();
 		return 0;
 	}
@@ -1824,7 +2034,14 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			return -EINVAL;
 		if (copy_from_sockptr(&v, optval, sizeof(v)))
 			return -EFAULT;
+		rcu_read_lock();
+		mrt = ip6mr_lookup_sk_table(sk);
+		if (!mrt) {
+			rcu_read_unlock();
+			return -ENOENT;
+		}
 		WRITE_ONCE(mrt->mroute_do_assert, v);
+		rcu_read_unlock();
 		return 0;
 	}
 
@@ -1842,6 +2059,11 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		do_wrmifwhole = (v == MRT6MSG_WRMIFWHOLE);
 		v = !!v;
 		rtnl_lock();
+		mrt = ip6mr_lookup_sk_table(sk);
+		if (!mrt) {
+			rtnl_unlock();
+			return -ENOENT;
+		}
 		ret = 0;
 		if (v != mrt->mroute_do_pim) {
 			WRITE_ONCE(mrt->mroute_do_pim, v);
@@ -1865,18 +2087,16 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		/* "pim6reg%u" should not exceed 16 bytes (IFNAMSIZ) */
 		if (v != RT_TABLE_DEFAULT && v >= 100000000)
 			return -EINVAL;
-		if (sk == rcu_access_pointer(mrt->mroute_sk))
+		rcu_read_lock();
+		mrt = ip6mr_lookup_sk_table(sk);
+		if (mrt && sk == rcu_access_pointer(mrt->mroute_sk)) {
+			rcu_read_unlock();
 			return -EBUSY;
+		}
+		rcu_read_unlock();
 
-		rtnl_lock();
-		ret = 0;
-		mrt = ip6mr_new_table(net, v);
-		if (IS_ERR(mrt))
-			ret = PTR_ERR(mrt);
-		else
-			raw6_sk(sk)->ip6mr_table = v;
-		rtnl_unlock();
-		return ret;
+		raw6_sk(sk)->ip6mr_table = v;
+		return 0;
 	}
 #endif
 	/*
@@ -1897,16 +2117,18 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 {
 	int olr;
 	int val;
-	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
 	if (sk->sk_type != SOCK_RAW ||
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return -EOPNOTSUPP;
 
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
+	rcu_read_lock();
+	mrt = ip6mr_lookup_sk_table(sk);
+	if (!mrt) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
 	switch (optname) {
 	case MRT6_VERSION:
@@ -1921,8 +2143,10 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 		val = READ_ONCE(mrt->mroute_do_assert);
 		break;
 	default:
+		rcu_read_unlock();
 		return -ENOPROTOOPT;
 	}
+	rcu_read_unlock();
 
 	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
@@ -1947,20 +2171,23 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	struct sioc_mif_req6 *vr;
 	struct vif_device *vif;
 	struct mfc6_cache *c;
-	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
+	rcu_read_lock();
+	mrt = ip6mr_lookup_sk_table(sk);
+	if (!mrt) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		vr = (struct sioc_mif_req6 *)arg;
-		if (vr->mifi >= mrt->maxvif)
+		if (vr->mifi >= mrt->maxvif) {
+			rcu_read_unlock();
 			return -EINVAL;
+		}
 		vr->mifi = array_index_nospec(vr->mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr->mifi];
 		if (VIF_EXISTS(mrt, vr->mifi)) {
 			vr->icount = READ_ONCE(vif->pkt_in);
@@ -1974,8 +2201,6 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 		return -EADDRNOTAVAIL;
 	case SIOCGETSGCNT_IN6:
 		sr = (struct sioc_sg_req6 *)arg;
-
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr->src.sin6_addr,
 				     &sr->grp.sin6_addr);
 		if (c) {
@@ -1988,6 +2213,7 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 		rcu_read_unlock();
 		return -EADDRNOTAVAIL;
 	default:
+		rcu_read_unlock();
 		return -ENOIOCTLCMD;
 	}
 }
@@ -2015,21 +2241,23 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	struct compat_sioc_mif_req6 vr;
 	struct vif_device *vif;
 	struct mfc6_cache *c;
-	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
-
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		if (copy_from_user(&vr, arg, sizeof(vr)))
 			return -EFAULT;
-		if (vr.mifi >= mrt->maxvif)
+		rcu_read_lock();
+		mrt = ip6mr_lookup_sk_table(sk);
+		if (!mrt) {
+			rcu_read_unlock();
+			return -ENOENT;
+		}
+		if (vr.mifi >= mrt->maxvif) {
+			rcu_read_unlock();
 			return -EINVAL;
+		}
 		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr.mifi];
 		if (VIF_EXISTS(mrt, vr.mifi)) {
 			vr.icount = READ_ONCE(vif->pkt_in);
@@ -2049,6 +2277,11 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 			return -EFAULT;
 
 		rcu_read_lock();
+		mrt = ip6mr_lookup_sk_table(sk);
+		if (!mrt) {
+			rcu_read_unlock();
+			return -ENOENT;
+		}
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
 		if (c) {
 			sr.pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
-- 
2.43.0

