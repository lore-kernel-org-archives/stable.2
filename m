Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622966;
	b=fSo43H8cZjlOghaEDr25hj3WWBC6EZUXWCxBnz8YgCMr43eLXcksJqk9x4gPAK1Jw4gj
	 YkPE2ykqQc+YTvH2KQOWM0FlgadylW+3990Bg2mNd7RHYU/MZFrDk/BGIab4e+wsEbuQ3
	 IucrSsZUu+iWHp1SJnNyrfFqWSzhZ4SsXv1Vi9CEMv8lmjD2XO/KdERnTkVVpLmIG/E3+
	 ieUXAK+b76Dx9JRklBqf2+S3bESTVnuzvHfzpIMix6bp8kwi8Y6MuYiZOQbbixXvYC+en
	 eMy89/riKIznSSX6rLEnEOcc01S+eO3hIokfoeOAw1vPRK3dgT0UThTYU1Ff+sDIn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vReROrbXTTJcF0/nBIyfdUdpX6QfzgiKLX+tUlu37Tk=;
	b=HKOxbMs0QXl8+6zTWYb20o1u/q84D0sHgWGhJGkE2aAzF4/u7zKTkhxp9fKmIpNw0dPx
	 zBVfBgvhW3gEQMwoIad5MYmyzg/wun5niGSrNdjKY58LSjl7vd84Odl6si+VFbf1K6EYb
	 qw43D9Jh+19hZHGrmmGZ/IDydwsAz62y+Dm3S5jVduoreYv3GUsi0ep/Dsu6jmgxzx0yo
	 kChH+vv2k+72SgB/p9i7IL/8fM0p8pjqf1bJWBqTO5df68UR2eCx0DwlnkNtICUFZjNy6
	 0a3Jt0o0oMO3NMgVCwnvqc0e1uk4dYrHgCwmaFe6H84EUJA9PaP+ATtV3UxX9JJSAkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxNGL9Dw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BE606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxNGL9Dw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8801F000C0;
	Wed, 25 Nov 2026 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622966;
	bh=vReROrbXTTJcF0/nBIyfdUdpX6QfzgiKLX+tUlu37Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SxNGL9DwopjRgqdC6UtuDYT0py9UzCiYZTVMVBMQtAkivTM/JHpzMw+CN6YVP+JDM
	 /wifMhNxK5yGEpkAa29FIl2ZxoJfQ3LiojdflqtlogolZY5m48kqiLRhmr9jA68AZc
	 QWJez2ozK0lA08+YbBoVhWDRLXRkdCjbu9CSRTUrj2LTIff//34A1pPvDqkAluVmy/
	 8Ef/UKZOaZMYYDjkG8etKGUejqpJ2ErRa/mzDzI3woIB30spnTMLGzwMdT8HZzAvoJ
	 MFAbWO+LAKPCVX/8hRBo/gJHy0h+bia0kwN6ESSLD5nik1BP174fxA0cwmFaFCj7JR
	 H5FigPk0Vvd0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Naman Gulati <namangulati@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: wait for in-flight device unregistrations before netns dismantle
Date: Wed, 25 Nov 2026 11:09:24 -0500
Message-ID: <20261125160901.702522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112530-magnesium-segment-fd8c@gregkh>
References: <2026112530-magnesium-segment-fd8c@gregkh>
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
[ sashal: Adapted to the older per-netns dev_unreg_count and existing helpers, so no new dev_unreg_pending field is added and net_unreg_done() reuses the existing counter and wakeup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a06af07f9d369..e41dd9c18cc2d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9729,6 +9729,13 @@ static void net_set_todo(struct net_device *dev)
 	atomic_inc(&dev_net(dev)->dev_unreg_count);
 }
 
+/* Paired with net_set_todo(). @net must not be used after this call. */
+static void net_unreg_done(struct net *net)
+{
+	if (atomic_dec_and_test(&net->dev_unreg_count))
+		wake_up(&netdev_unregistering_wq);
+}
+
 static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
 	struct net_device *upper, netdev_features_t features)
 {
@@ -10579,6 +10586,7 @@ void netdev_run_todo(void)
 		if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
 			netdev_WARN(dev, "run_todo but not unregistering\n");
 			list_del(&dev->todo_list);
+			net_unreg_done(dev_net(dev));
 			continue;
 		}
 
@@ -10589,8 +10597,11 @@ void netdev_run_todo(void)
 	}
 
 	while (!list_empty(&list)) {
+		struct net *net;
+
 		dev = netdev_wait_allrefs_any(&list);
 		list_del(&dev->todo_list);
+		net = dev_net(dev);
 
 		/* paranoia */
 		BUG_ON(netdev_refcnt_read(dev) != 1);
@@ -10605,11 +10616,10 @@ void netdev_run_todo(void)
 		if (dev->needs_free_netdev)
 			free_netdev(dev);
 
-		if (atomic_dec_and_test(&dev_net(dev)->dev_unreg_count))
-			wake_up(&netdev_unregistering_wq);
-
 		/* Free network device */
 		kobject_put(&dev->dev.kobj);
+
+		net_unreg_done(net);
 	}
 }
 
@@ -11574,6 +11584,17 @@ static void __net_exit default_device_exit_net(struct net *net)
 	}
 }
 
+static bool __net_exit netns_dev_unreg_pending(const struct list_head *net_list)
+{
+	struct net *net;
+
+	list_for_each_entry(net, net_list, exit_list) {
+		if (atomic_read(&net->dev_unreg_count))
+			return true;
+	}
+	return false;
+}
+
 static void __net_exit default_device_exit_batch(struct list_head *net_list)
 {
 	/* At exit all network devices most be removed from a network
@@ -11601,6 +11622,16 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
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

