Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896137DEAB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611544; cv=none; b=AgSfrR//koh1Z/9x8MhttjjIi9rDa+iYSs+hBBgUDGFDtp3tb/KV/qDNsNBxneHfwD9pnwAbOvhJ5qCz/XHpl7xoxR2HVUAesmXLV0fpR1XfnvQQjeXWNJZE+jya4JgW5Lzpy7wRx+ngrCc8+XUkhGqMwutr5LnYjVvWK57bN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611544; c=relaxed/simple;
	bh=Gr+ZaYU5pw5plVhuT66H3bMCJ0TvNJ3vGg/jXhhSYJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlzTjjDSyRAr9lNfTZJus5OZYfaK+VOQ1Uaq61UPxpXx2XTOw658uLKHZaVFGBs+cra6+NOMPoDMyfxj39n0/Mb6DiDeiWll0nVY0RafDLKaeDjqfsdlihZ5Gnh1cp3K+qDFiBDrfSmTmOHiJ6iqQMuvK70A0XKxV8C+kypBTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDDfUKuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDDfUKuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DF61F0089B;
	Thu, 17 Sep 2026 02:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611543;
	bh=uSDp4J6mjwnqVpXhFoexGYoplVyIMho3mr2Lv33muNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HDDfUKuMvAqI96E9Rxqtm0RsIiCm6JU7jThpBvMnqhnaw7VRpzYP32TlLHr8vsdtS
	 3FKDPG+HRI1yMZkEkmgq01r45HI55yV6IoX29GcQBivZNCVWD6Ejzj+O+RsoPNBD49
	 PjI/ovrZRq/eXo5X2z+FR6boY/W8GBP6zls25/aHVG6Y2p+tHn2UJAuKnoGBIv1JBR
	 +ijeOXb3j/Ne0VQvHTZJRASboThW0WfXJ3sFxycy1IbmlNnJtNQimDD6HNNhu9xxZB
	 UP9EBY3/0Cf1bl5ucrShzIsGpi3qcNn5o/fIlAUDKwlUheKNXycivzMBBl66z0mpEo
	 vdghm3mKSxJUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/7] ipv4: remove fib_info_devhash[]
Date: Wed, 16 Sep 2026 22:18:55 -0400
Message-ID: <20260917021859.3810309-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021859.3810309-1-sashal@kernel.org>
References: <2026091655-dejected-hammock-755e@gregkh>
 <20260917021859.3810309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a3f5f4c2f9b6bc2aa6f5a3e8e23b7519e4f2e3e3 ]

Upcoming per-netns RTNL conversion needs to get rid
of shared hash tables.

fib_info_devhash[] is one of them.

It is unclear why we used a hash table, because
a single hlist_head per net device was cheaper and scalable.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20241004134720.579244-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  3 ++
 net/ipv4/fib_semantics.c                      | 35 ++++++++-----------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 22b07c814f4a4..a8e2a7ce03833 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -83,6 +83,7 @@ unsigned_int                        allmulti
 bool                                uc_promisc                                                      
 unsigned_char                       nested_level                                                    
 struct_in_device*                   ip_ptr                  read_mostly         read_mostly         __in_dev_get
+struct hlist_head                   fib_nh_head
 struct_inet6_dev*                   ip6_ptr                 read_mostly         read_mostly         __in6_dev_get
 struct_vlan_info*                   vlan_info                                                       
 struct_dsa_port*                    dsa_ptr                                                         
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0aa536df9cb59..8e6ed0079f381 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2217,6 +2217,9 @@ struct net_device {
 
 	/* Protocol-specific pointers */
 	struct in_device __rcu	*ip_ptr;
+	/** @fib_nh_head: nexthops associated with this netdev */
+	struct hlist_head	fib_nh_head;
+
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 	struct vlan_info __rcu	*vlan_info;
 #endif
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 8c20209fbff35..b3861d2740c6d 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -57,10 +57,6 @@ static unsigned int fib_info_hash_size;
 static unsigned int fib_info_hash_bits;
 static unsigned int fib_info_cnt;
 
-#define DEVINDEX_HASHBITS 8
-#define DEVINDEX_HASHSIZE (1U << DEVINDEX_HASHBITS)
-static struct hlist_head fib_info_devhash[DEVINDEX_HASHSIZE];
-
 /* for_nexthops and change_nexthops only used when nexthop object
  * is not set in a fib_info. The logic within can reference fib_nh.
  */
@@ -322,12 +318,9 @@ static inline int nh_comp(struct fib_info *fi, struct fib_info *ofi)
 	return 0;
 }
 
-static struct hlist_head *
-fib_info_devhash_bucket(const struct net_device *dev)
+static struct hlist_head *fib_nh_head(struct net_device *dev)
 {
-	u32 val = net_hash_mix(dev_net(dev)) ^ dev->ifindex;
-
-	return &fib_info_devhash[hash_32(val, DEVINDEX_HASHBITS)];
+	return &dev->fib_nh_head;
 }
 
 static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
@@ -439,11 +432,11 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
 	struct hlist_head *head;
 	struct fib_nh *nh;
 
-	head = fib_info_devhash_bucket(dev);
+	head = fib_nh_head(dev);
 
 	hlist_for_each_entry_rcu(nh, head, nh_hash) {
-		if (nh->fib_nh_dev == dev &&
-		    nh->fib_nh_gw4 == gw &&
+		DEBUG_NET_WARN_ON_ONCE(nh->fib_nh_dev != dev);
+		if (nh->fib_nh_gw4 == gw &&
 		    !(nh->fib_nh_flags & RTNH_F_DEAD)) {
 			return 0;
 		}
@@ -1632,7 +1625,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 
 			if (!nexthop_nh->fib_nh_dev)
 				continue;
-			head = fib_info_devhash_bucket(nexthop_nh->fib_nh_dev);
+			head = fib_nh_head(nexthop_nh->fib_nh_dev);
 			hlist_add_head_rcu(&nexthop_nh->nh_hash, head);
 		} endfor_nexthops(fi)
 	}
@@ -1974,12 +1967,12 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
 {
-	struct hlist_head *head = fib_info_devhash_bucket(dev);
+	struct hlist_head *head = fib_nh_head(dev);
 	struct fib_nh *nh;
 
 	hlist_for_each_entry(nh, head, nh_hash) {
-		if (nh->fib_nh_dev == dev)
-			fib_nhc_update_mtu(&nh->nh_common, dev->mtu, orig_mtu);
+		DEBUG_NET_WARN_ON_ONCE(nh->fib_nh_dev != dev);
+		fib_nhc_update_mtu(&nh->nh_common, dev->mtu, orig_mtu);
 	}
 }
 
@@ -1993,7 +1986,7 @@ void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
  */
 int fib_sync_down_dev(struct net_device *dev, unsigned long event, bool force)
 {
-	struct hlist_head *head = fib_info_devhash_bucket(dev);
+	struct hlist_head *head = fib_nh_head(dev);
 	struct fib_info *prev_fi = NULL;
 	int scope = RT_SCOPE_NOWHERE;
 	struct fib_nh *nh;
@@ -2007,7 +2000,8 @@ int fib_sync_down_dev(struct net_device *dev, unsigned long event, bool force)
 		int dead;
 
 		BUG_ON(!fi->fib_nhs);
-		if (nh->fib_nh_dev != dev || fi == prev_fi)
+		DEBUG_NET_WARN_ON_ONCE(nh->fib_nh_dev != dev);
+		if (fi == prev_fi)
 			continue;
 		prev_fi = fi;
 		dead = 0;
@@ -2157,7 +2151,7 @@ int fib_sync_up(struct net_device *dev, unsigned char nh_flags)
 	}
 
 	prev_fi = NULL;
-	head = fib_info_devhash_bucket(dev);
+	head = fib_nh_head(dev);
 	ret = 0;
 
 	hlist_for_each_entry(nh, head, nh_hash) {
@@ -2165,7 +2159,8 @@ int fib_sync_up(struct net_device *dev, unsigned char nh_flags)
 		int alive;
 
 		BUG_ON(!fi->fib_nhs);
-		if (nh->fib_nh_dev != dev || fi == prev_fi)
+		DEBUG_NET_WARN_ON_ONCE(nh->fib_nh_dev != dev);
+		if (fi == prev_fi)
 			continue;
 
 		prev_fi = fi;
-- 
2.53.0

