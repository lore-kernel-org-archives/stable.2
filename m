Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621995;
	b=lM99Esn2nJxbCC7FarhSCpLFA9KQKCu2ytfXA6HBcJy+yxx3HE+/hwJ2zh9RO/iVoZM9
	 e600i7EkYNnFFuqPcEq9ltzJIGj2whVWtlP0GjFqndPq+Gqz7OVqAcfEhG8N+f1BYOPyu
	 ZSa4IYVdhbF9h8XkoWsiw9qKFRF6mmq97hqHP56lh4TL0eqcnO2owRmtkRmyG0kAY4vkb
	 PfzFZ7NjcA6hZWW5Dz0VAKAosBorIkMH40UbNKCc0sKuL1cGPldg4QvUVElgSIMfDpEuE
	 2KdrVx3CX8MCX1hrPH7mQNUZDOXSwEsP8MuJi2B1FjCUhvHJ2KacqHC6TR6hMk4Q/Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pCBvwMEWPsZSao/TU3mEwhN0BiMhP7I+vZFr9xcnsLU=;
	b=iSYr5q7Vy142W0DqtQwuypOgRqyKqHWxJM9ata7ruVSvflphDPl5WkSfQim1suYzhQOm
	 B7eZYju/5FtRwwyZrJ9UC+cqMPWVjJa9N3EfV09iokWKluSOs7kVbJUWDqXEV3lMDeAQ4
	 HnPLC72rNHSPdYFMBEcVZbjiFvOQ5fJrU4iUQz7ngkqVi6cSRnzLGGio4elmTJR6FGO8Z
	 OlM0Q8u9ZMRBCAPVox1lpuZ0PbuKl/Ssh2C4h/z7CJ5ofRiXW5c8UBRrvQb7aGw2NTCJ2
	 Vww5Merwxs7ZZ+rZWy6956n1SFjYdh0KNCAITokFUi2QeyfoP7mBptMn0gNrzDsEtlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llsejW18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C07606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llsejW18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDAF1F000C0;
	Wed, 25 Nov 2026 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621994;
	bh=pCBvwMEWPsZSao/TU3mEwhN0BiMhP7I+vZFr9xcnsLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=llsejW18mFc57r97d/l7Nk0dQQ6jnH6lEHdXg8q5cLJfohTDtni981YydMCZr4qzB
	 gGRaxptzhfgjn3JOw1TBEK3b8TKVB6wHdU39QuxAwzJ1b2NMqn7P5AUzC6S3iVr1eD
	 IHUbLuvcsVlaE84K/UwqcGAKtL9VNHEQVf3EkISgZslzG1il5uJJoDL0VYIi8rHanV
	 W1fc//vEPn/wc6kX6ppqR3KAQEIR2VfKsgBdTZqEb00Ue/RpVyCUQdMbXqCddhyVAX
	 P7Awc5C8CfMOFbSDZwNlhlQKMOxmrp5cml2QVBdR3N5GfTBxVEjHGoQZGQ9Zd3iHMC
	 dqqT7byu6jmiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Naman Gulati <namangulati@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] net: wait for in-flight device unregistrations before netns dismantle
Date: Wed, 25 Nov 2026 10:53:11 -0500
Message-ID: <20261125155248.603559-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112528-flail-frostbite-ecc5@gregkh>
References: <2026112528-flail-frostbite-ecc5@gregkh>
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
[ sashal: dropped the nonexistent dev_mc_genid and rtnl_net_flush_workqueue() context lines, keeping only the added dev_unreg_pending field and wait_event(), with fuzz in netdev_run_todo(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/net_namespace.h |  1 +
 net/core/dev.c              | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 9a1d7ef17c4e9..9f16cca93227b 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -68,6 +68,7 @@ struct net {
 	spinlock_t		rules_mod_lock;
 
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
+	atomic_t		dev_unreg_pending; /* devices in netdev_run_todo() */
 	u32			ifindex;
 
 	spinlock_t		nsid_lock;
diff --git a/net/core/dev.c b/net/core/dev.c
index 91da33c29aa18..0ea4224874628 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10793,6 +10793,14 @@ atomic_t dev_unreg_count = ATOMIC_INIT(0);
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
@@ -11682,6 +11690,7 @@ void netdev_run_todo(void)
 		if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
 			netdev_WARN(dev, "run_todo but not unregistering\n");
 			list_del(&dev->todo_list);
+			net_unreg_done(dev_net(dev));
 			continue;
 		}
 
@@ -11693,8 +11702,11 @@ void netdev_run_todo(void)
 
 	cnt = 0;
 	while (!list_empty(&list)) {
+		struct net *net;
+
 		dev = netdev_wait_allrefs_any(&list);
 		list_del(&dev->todo_list);
+		net = dev_net(dev);
 
 		/* paranoia */
 		BUG_ON(netdev_refcnt_read(dev) != 1);
@@ -11713,6 +11725,8 @@ void netdev_run_todo(void)
 
 		/* Free network device */
 		kobject_put(&dev->dev.kobj);
+
+		net_unreg_done(net);
 	}
 	if (cnt && atomic_sub_and_test(cnt, &dev_unreg_count))
 		wake_up(&netdev_unregistering_wq);
@@ -13028,6 +13042,17 @@ static void __net_exit default_device_exit_net(struct net *net)
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
@@ -13055,6 +13080,16 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
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

