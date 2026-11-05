Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889949;
	b=AqAu9qF2+dHjNbAmvZaE1kkG1rJdp89Wo93cdbemC9W9HawxUS6WiB7Fe+5XH5vzj4eU
	 RSTc9cRdshrHCVd8kHRL7WzfaCRpCg3INnsW6/MhRjcsH4ZeGZV3Ow9JPCX2RFpPBUCrj
	 HYGa5gvDX1cy5RzIgiiOIp5pLN36UwhDNI8hf6Mf74B7/l4+ZvRYRwBNfMmD0MpO/LIDq
	 eC/m8wVR9JgH3i0KaDES158Ittj9edKOFxyfGdKgdX7qlV3VtgSKnYhAoaLzwSAn2RnXr
	 3mE0uzMZz6bKBkS8jBrEWHADyxCqVhztIHvDYH9lvRVAc10lO7vaIXbHtLjSAi5+BwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889949;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Zu34Cc+4z4zqK1o2AvPJS8yRQedGu7fZhaCkUqNETgs=;
	b=qyriCE9JtnmmlBoi7xhRZzDjZrpMoGFcmsTYwWMxdthK5plgOotUuVgtJ97WzgGu8K1l
	 cwjtVW3IdFYwEsu8tnoOqTmmNdm3w0qTPDGxglltXu8liFvrKQqeWXE88IwfcWjgDE7QK
	 MW2PeQ6/DBb5+PT5lhj/2Gj5RvhB0YpUf4qusuclyq9sQlndDRAVf2Y1qU5xbGdUM8QFx
	 LwYbq9NbWKSsCGz5sRjiBjlwmtIy6x29uV8rbG2CF0jJa7qsJzkHYV73jRWQ662oVOFVa
	 7Opg5zjeV/Vvs59BjXlwv6dL+Tg2lWNakZ6HtbvRJDVX0lesulCqT3D1vsAtkRdPXpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTRyNiQO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D7606A32D;
	Thu,  5 Nov 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTRyNiQO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06B61F000C1;
	Thu,  5 Nov 2026 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889948;
	bh=Zu34Cc+4z4zqK1o2AvPJS8yRQedGu7fZhaCkUqNETgs=;
	h=From:To:Cc:Subject:Date;
	b=XTRyNiQO/V21Ov1TY41mm4EDStlwgN2ad85tDP7V7IjoZ7YnacAc0KCnuBYogFoSG
	 CGvOCszTgwyayt5jmSQjNPf2WWt2RZjIHPArEJzh56/uuzzk7Ul9wgrYFFgCo72jnZ
	 D2JpZnLVYKl+er6PcgsYPbOnXj9WAejV9U3V+AFUUGZOL+KTh6IPaBLskFcKdmdOrt
	 BeUM1bzlf+6dc5ve2N6DLg6TCBysrhz/spfSXp2jl6sHNC6lHPUG6z8rTBWSosS8mG
	 CVH95GyBkNhgUM3xQiCY/PndnvkRMxWeCaOmaawbN1ry/M140R3ajixpwhNkze5gaR
	 zCgr3TeVRDttQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	stable@vger.kernel.org,
	syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Naman Gulati <namangulati@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net] net: wait for in-flight device unregistrations before netns dismantle
Date: Thu,  5 Nov 2026 15:45:43 +0100
Message-ID: <20261105144543.1624238-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Naman Gulati <namangulati@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
---
 include/net/net_namespace.h |  1 +
 net/core/dev.c              | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index c29a22ca178fa678c0468247b9f85f53eec86184..4a4d72080acdc787797bffd3a5a1bc0e6d4b46c7 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -72,6 +72,7 @@ struct net {
 
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
 	atomic_t		dev_mc_genid;	/* dev->mc membership changes */
+	atomic_t		dev_unreg_pending; /* devices in netdev_run_todo() */
 	u32			ifindex;
 
 	spinlock_t		nsid_lock;
diff --git a/net/core/dev.c b/net/core/dev.c
index df1a840b033437a168d4290f19611e6a23507d08..5d25b65e20dc4dc012492970dde42210808de17a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11101,6 +11101,14 @@ atomic_t dev_unreg_count = ATOMIC_INIT(0);
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
@@ -12000,6 +12008,7 @@ void netdev_run_todo(void)
 		if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
 			netdev_WARN(dev, "run_todo but not unregistering\n");
 			list_del(&dev->todo_list);
+			net_unreg_done(dev_net(dev));
 			continue;
 		}
 
@@ -12016,8 +12025,11 @@ void netdev_run_todo(void)
 
 	cnt = 0;
 	while (!list_empty(&list)) {
+		struct net *net;
+
 		dev = netdev_wait_allrefs_any(&list);
 		list_del(&dev->todo_list);
+		net = dev_net(dev);
 
 		/* paranoia */
 		BUG_ON(netdev_refcnt_read(dev) != 1);
@@ -12038,6 +12050,8 @@ void netdev_run_todo(void)
 
 		/* Free network device */
 		kobject_put(&dev->dev.kobj);
+
+		net_unreg_done(net);
 	}
 	if (cnt && atomic_sub_and_test(cnt, &dev_unreg_count))
 		wake_up(&netdev_unregistering_wq);
@@ -13486,6 +13500,17 @@ static void __net_exit default_device_exit_net(struct net *net)
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
@@ -13527,6 +13552,16 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 
+	/* Devices of these netns unregistered from another context
+	 * (e.g. a veth whose peer was deleted) can still be waiting
+	 * in netdev_run_todo() for their last references, while
+	 * NETDEV_UNREGISTER is rebroadcast for them. Wait for them
+	 * before pernet exit handlers tear down the state used by
+	 * netdevice notifiers, and before the netns is freed.
+	 * No new unregistration can start: all devices are unlisted.
+	 */
+	wait_event(netdev_unregistering_wq, !netns_dev_unreg_pending(net_list));
+
 	rtnl_net_flush_workqueue();
 }
 
-- 
2.53.0

