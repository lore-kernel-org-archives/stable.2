Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597980;
	b=XB4cjOCZWvuCCYfkRdHNTlzPWVSj7SEm1w7VX6tcg+USWa1Wbr1vLF/TL6eagtJJ+9uY
	 tmDDSRkd1B2l5gzgh7rxSkoB9IVBto/LIY3CMlkA0A0ysTxWYfCbA1lhb/jypnq+UYGMh
	 zYrb6X2jRtTy3sQDjgYQEc+NgtkwUyOoQ3UvAts9RrkbhcHBgC+w6BxZZdD1p7p3LK7ba
	 Sep8dNxzAdIBbhepFoB2yHmLSoCEWSbiY4Dk7Xk6twwRmT+WxgaH+KFD0M/hPE5laqXFH
	 zST+PLabuTf+7hQyFAJtMlbtI0dfEmr/Thzz7GdPw/cM0ePSrLAzSLLJrL2B5PBh9uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597980;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=agDsfLRB9+Zsay0v0aVxtyL4iuRs24LUg/yC37fswmA=;
	b=UE9tf79ErxLcx5qW6RBe0ENAQGjNHuEAMfQlC/tHAVFrk3Y2rLn2O9RnULlAn3VSmoIq
	 ngai22TxBacACvP5AAjV/CgUsdcdwk+h/k7Sd3o7GsqD6ZLKNu/JzNfuqH8rzmiUeHYXr
	 or/BX7k7sup4TJB5q1uSXnIUCGdmdQ/h1TU2Eo1xnpB6uOPJ+iy4uvUmO0X7VCVHQLVFn
	 sLvNubVTPJMxg3SB7xOhUyPK8kUpfY9Tf/SyhMcsQBvTf+c48uTl0d/lEWsqK9kcEvLUH
	 9aROzGIx1636B4Mvmjvg5b/q6jMVhhZcyZP89ZDR2ZG74RsUOauchTXaVjqrxOEqjIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="eWgxz/BS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431D606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eWgxz/BS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42211F000C4;
	Wed, 25 Nov 2026 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597979;
	bh=agDsfLRB9+Zsay0v0aVxtyL4iuRs24LUg/yC37fswmA=;
	h=Subject:To:Cc:From:Date;
	b=eWgxz/BS00er2muIh775i+0HPnL+MTkRqfkuYk9TRJ/AR3FCj9UGvM6jgeZzRkSkX
	 yARlOSIgv3tT2uaSXnHEMkMXDqg4lcZ/oR+CZBfpW8WkPC+RSfELKpb2kRcHxW047C
	 IscIyPK3ePo7nmw6GA2iWW9OApDfnbyI/zYlCV/o=
Subject: FAILED: patch "[PATCH] net: wait for in-flight device unregistrations before netns" failed to apply to 6.18-stable tree
To: edumazet@kernel.org,bsdhenrymartin@gmail.com,kuba@kernel.org,namangulati@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:05:28 +0100
Message-ID: <2026112528-flail-frostbite-ecc5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c164a431a646983275d0076ff5b0e4c326fbc10b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112528-flail-frostbite-ecc5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c164a431a646983275d0076ff5b0e4c326fbc10b Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 5 Nov 2026 15:45:43 +0100
Subject: [PATCH] net: wait for in-flight device unregistrations before netns
 dismantle

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

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index c29a22ca178f..4a4d72080acd 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -72,6 +72,7 @@ struct net {
 
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
 	atomic_t		dev_mc_genid;	/* dev->mc membership changes */
+	atomic_t		dev_unreg_pending; /* devices in netdev_run_todo() */
 	u32			ifindex;
 
 	spinlock_t		nsid_lock;
diff --git a/net/core/dev.c b/net/core/dev.c
index df1a840b0334..5d25b65e20dc 100644
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
 

