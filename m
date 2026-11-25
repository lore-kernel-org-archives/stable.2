Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622373;
	b=ajTO0+Db8gJr0kft13DCjmOR2kgwt30ON8bA94/sMCqmq8CxhC7a4G2SxUyFTKR3g+e7
	 fTXpFNpNfODV1jLfUarcEm92yw8cdmiDFt4LO8+YCsTg2/xtF+UWCNsAMA9IIGfwtQyYq
	 sfH3tiTXDEE1szuBVvzqmAAv1v1goTCeJOhHU+GgdQAd+6UCW2O2l0UoX/7xvgCIfvY4T
	 ZBYSjYHTzOtVO1Xq2PoZ0URGKLEc8b8l+e6w8lcmtpT10OL/t5qD8ANdv2rzGnTD9RQtr
	 AkNRZ4BytLYIK2w/uAJ4q3aeKK5Wj5SPOqwhq+1AJviJAeBZx1ysjc/LPJYv3Agw1NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XJL1ybkRsDna5i6HUgQb+nGNi8JKW7vDET7tRDscuZM=;
	b=qhdGIqC5hE7AJKHfj6TypwF9IcYAPs5DOguzg6l7RyKpEoAxlRhBg/uk77WMpVV/Dp07
	 kfpKi/1bOA56R8Gv6T589bNhbcNaUrjcApeZwipKpeAMLxKLOLW/v6s0zt2Sa+xmT1xst
	 jU+5PTEFhkfBB6XtbVUuBNNGrdWYRu35xNIKGybWLAKH4kxbfE7BpNvWoIROUcj2A2lnG
	 /F9642S4lY+As8aRz2alnS6ye8VIeGz24GwxrvXMqcldBMbzAaNCgEsmz0dUbhM/h0WQq
	 XBhKtM7D+EFOOk9HvuR2PKm0XO7ylgNRdaPCifJ79ZveTSopgSmHXrPji6H/tYqjnqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ed0pQDDd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB8606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ed0pQDDd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4D51F000D1;
	Wed, 25 Nov 2026 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622372;
	bh=XJL1ybkRsDna5i6HUgQb+nGNi8JKW7vDET7tRDscuZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ed0pQDDd6G/3ELuLm9DXbtCwWpkiwqoBdrfcGsjXcmOntjZmxYTbfSoxSSeQHbJ5D
	 2nZfmpMA81P2DN1iTBNZ0suodZC7z5ZUW4PFCpwn96BGg1qmZaw6OV7kk0zf8YR1AE
	 KOxY+x5bmvPu0ChmDZ1hBBEcLbolteFO0gOA1hephLRV+8fI/HbxIq0PyBpfk9InjW
	 YZYz6Ets2kd8b7BYUQVzjbWq2RoVOiM1QdJxPQRd13yy8GMW1HLv9tlS5GlceevO4P
	 5/90RambtoBhIPGYoFR3b7WBa7HC7iGwnOSiFqC5uSIF4L+vfwmlnLqhuIWPrelN11
	 2PFRPXV4yo7iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Naman Gulati <namangulati@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: wait for in-flight device unregistrations before netns dismantle
Date: Wed, 25 Nov 2026 10:59:30 -0500
Message-ID: <20261125155906.641582-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112529-purify-proven-454f@gregkh>
References: <2026112529-purify-proven-454f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@kernel.org>

[ Upstream commit c164a431a646983275d0076ff5b0e4c326fbc10b ]

A device can be unregistered by a context other than the cleanup_net()
of its own netns, for instance a veth whose peer in another netns is
deleted. If references on it are still held, it stays in
netdev_wait_allrefs_any(), which rebroadcasts NETDEV_UNREGISTER every
second.

Meanwhile its netns can be dismantled: default_device_exit_batch()
only takes care of devices still listed in the netns, then pernet exit
handlers free their state, and finally struct net is freed while the
device still points to it.

The rebroadcasts then run notifiers against torn down pernet state, or
freed memory. Three instances were reported so far:

 - netdev_genl_netdevice_event(): net->genl_sock is NULL [1]
 - nh_netdev_event(): net->nexthop.devhash is NULL [2]
 - nf_tables netdevice notifiers: use-after-free of the nftables
   pernet storage [3]

but any notifier using dev_net(dev) is affected, as is
netdev_wait_allrefs_any() itself (__rtnl_net_lock(dev_net(dev)) with
CONFIG_DEBUG_NET_SMALL_RTNL=y).

This was prevented by rtnl_lock_unregistering() until I removed it
in commit 8a4fc54b07d7 ("net: get rid of rtnl_lock_unregistering()"),
considering only the loopback dependency, and missing the notifiers one.

Restore a per-netns counter of devices sitting in netdev_run_todo(),
and make default_device_exit_batch() wait for it to reach zero, after
it has unregistered all devices of the dying netns(es). At this point
no new unregistration can be started for these netns.

Unlike the old barrier, this only waits for devices of the netns being
dismantled and runs after their own devices are gone.

Tested on a KASAN kernel with a debug-only hack holding a reference
on a veth device for 5 seconds after its unregistration: a nexthop
on the veth in netns X, delete its peer from init_net, then delete X.
Without this patch, the nexthop_flush_dev() null-ptr-deref from [2]
triggers. With it, no splat; netns churn and dismantle of a netns
whose own device is held still work.

[1] https://lore.kernel.org/netdev/6adf9f64.6200f071.51519.0ed1.GAE@google.com/
[2] https://lore.kernel.org/netdev/20261105114707.3030737-1-bsdhenrymartin@gmail.com/
[3] https://lore.kernel.org/netdev/20261105114817.3033625-1-bsdhenrymartin@gmail.com/

Fixes: 8a4fc54b07d7 ("net: get rid of rtnl_lock_unregistering()")
Cc: stable@vger.kernel.org
Reported-by: syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6adf9f64.6200f071.51519.0ed1.GAE@google.com/
Reported-by: Henry Martin <bsdhenrymartin@gmail.com>
Closes: https://lore.kernel.org/netdev/20261105114707.3030737-1-bsdhenrymartin@gmail.com/
Closes: https://lore.kernel.org/netdev/20261105114817.3033625-1-bsdhenrymartin@gmail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Naman Gulati <namangulati@google.com>
Link: https://patch.msgid.link/20261105144543.1624238-1-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: adjusted context for a missing dev_mc_genid field in struct net, and moved the wait_event placement relative to the rtnl_net_flush_workqueue() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/net_namespace.h |  1 +
 net/core/dev.c              | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index f659d1efcd3ce..7b53eb6c21798 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -68,6 +68,7 @@ struct net {
 	spinlock_t		rules_mod_lock;
 
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
+	atomic_t		dev_unreg_pending; /* devices in netdev_run_todo() */
 	u32			ifindex;
 
 	spinlock_t		nsid_lock;
diff --git a/net/core/dev.c b/net/core/dev.c
index bd1b0f10d9374..426f6d2e19524 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10145,6 +10145,14 @@ atomic_t dev_unreg_count = ATOMIC_INIT(0);
 static void net_set_todo(struct net_device *dev)
 {
 	list_add_tail(&dev->todo_list, &net_todo_list);
+	atomic_inc(&dev_net(dev)->dev_unreg_pending);
+}
+
+/* Paired with net_set_todo(). @net must not be used after this call. */
+static void net_unreg_done(struct net *net)
+{
+	if (atomic_dec_and_test(&net->dev_unreg_pending))
+		wake_up(&netdev_unregistering_wq);
 }
 
 static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
@@ -11034,6 +11042,7 @@ void netdev_run_todo(void)
 		if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
 			netdev_WARN(dev, "run_todo but not unregistering\n");
 			list_del(&dev->todo_list);
+			net_unreg_done(dev_net(dev));
 			continue;
 		}
 
@@ -11043,8 +11052,11 @@ void netdev_run_todo(void)
 
 	cnt = 0;
 	while (!list_empty(&list)) {
+		struct net *net;
+
 		dev = netdev_wait_allrefs_any(&list);
 		list_del(&dev->todo_list);
+		net = dev_net(dev);
 
 		/* paranoia */
 		BUG_ON(netdev_refcnt_read(dev) != 1);
@@ -11063,6 +11075,8 @@ void netdev_run_todo(void)
 
 		/* Free network device */
 		kobject_put(&dev->dev.kobj);
+
+		net_unreg_done(net);
 	}
 	if (cnt && atomic_sub_and_test(cnt, &dev_unreg_count))
 		wake_up(&netdev_unregistering_wq);
@@ -12298,6 +12312,17 @@ static void __net_exit default_device_exit_net(struct net *net)
 	}
 }
 
+static bool __net_exit netns_dev_unreg_pending(const struct list_head *net_list)
+{
+	struct net *net;
+
+	list_for_each_entry(net, net_list, exit_list) {
+		if (atomic_read(&net->dev_unreg_pending))
+			return true;
+	}
+	return false;
+}
+
 static void __net_exit default_device_exit_batch(struct list_head *net_list)
 {
 	/* At exit all network devices most be removed from a network
@@ -12325,6 +12350,16 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	}
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
+
+	/* Devices of these netns unregistered from another context
+	 * (e.g. a veth whose peer was deleted) can still be waiting
+	 * in netdev_run_todo() for their last references, while
+	 * NETDEV_UNREGISTER is rebroadcast for them. Wait for them
+	 * before pernet exit handlers tear down the state used by
+	 * netdevice notifiers, and before the netns is freed.
+	 * No new unregistration can start: all devices are unlisted.
+	 */
+	wait_event(netdev_unregistering_wq, !netns_dev_unreg_pending(net_list));
 }
 
 static struct pernet_operations __net_initdata default_device_ops = {
-- 
2.53.0

