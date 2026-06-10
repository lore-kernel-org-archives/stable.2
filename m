Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB4287247;
	Wed, 10 Jun 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069018; cv=none; b=ZvFzuJTVRjz3PQzls5epfhvvWtrrgivqi33pnMeDouZXyFa3rfQmbNUP6f/15axHxWIqJpB+kFyVpzccS539ml9GZX0W+RgtUOVqfGNIE3p97Mx9gHI56zRp5wftFtEZEeIvK475yunl1lcq7XuYGixKTjyPjzGViMdIYtQVG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069018; c=relaxed/simple;
	bh=HE4lEGy8iqBTCMVeL2FcyJR8Nu9qDAf3h8TsC0voqFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hfc+Cc8kD8tPPLbc1b9eMmtsudmWIsL3TvDjM7b9IFk0EvKslDKOUHNMkm60Cl6bZVOPIGm/o4mO0JeKb9jR2V/adGNA5Kvyjr25n+ohZasuA9rEKUVKNECmZ38/UdCk4OjYqnwi6ApMrJvVOJG662MyzByllIzZefPvyUo+OaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=CiOL1JbL; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="CiOL1JbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=VUGDs
	FhLj35lrr7HYHF3oEkfgXS8z1sDQdbPZ0UR/Ig=; b=CiOL1JbL/rp1sB/5DbcWj
	sS1gTpV0hR15+EoV7dWDPR6koj8TPR0dbz+EMm2knXesr0bjWvNbUsJNkWLgQZsu
	YHVtfY/1kKOHULTm5CLvr/NsUGQXjFTmJUlUnWJPrk6AP921cbekZ4BAfEXkPz2J
	LYSvCEwEVxeGAYZbcogNpU=
Received: from localhost.localdomain (unknown [211.102.241.101])
	by web5 (Coremail) with SMTP id zAQGZQBH_77I9ChqY81EAg--.18163S2;
	Wed, 10 Jun 2026 13:23:21 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Kito Xu <veritas501@foxmail.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] appletalk: fix TOCTOU race in atalk_sendmsg
Date: Wed, 10 Jun 2026 13:23:14 +0800
Message-ID: <20260610052315.64504-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQBH_77I9ChqY81EAg--.18163S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyrCFyDWF4fXr4kXFW8Zwb_yoWxCw1fpF
	WxCa4YkayDJw1jgrs2qay7Cr1akr4kGryfGryfJ340vFs0gFy8uFy0y3WSvF90vFn7JrW8
	XFWq9a1YkF47Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYDGYDUUU
	U
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgIOAWookxu6vgAAsB

atalk_sendmsg() looks up an AppleTalk route, stores the returned
atalk_route and net_device pointers, and then drops the socket lock
around sock_alloc_send_skb().  The route pointer returned by
atrtr_find() is only protected while atalk_routes_lock is held; after
that lock is dropped, a concurrent SIOCDELRT or device-down path can
unlink the route, drop the device reference, and free the route.

When sendmsg resumes, it can still dereference the stale route and
device pointers while building or transmitting the packet.  A KASAN
reproducer using AF_APPLETALK sockets and SIOCADDRT/SIOCDELRT reports
slab-use-after-free reads in atalk_sendmsg(), with the object allocated
by atrtr_create() and freed by atrtr_delete().

Fix this by splitting the route lookup into a helper that is called with
atalk_routes_lock already held.  atalk_sendmsg() now performs route
lookup, copies the route fields it needs, and takes references to the
selected devices while still holding atalk_routes_lock.  After the lock
is dropped and skb allocation sleeps, the send path uses only the copied
route data and the held net_device references, which are released before
returning.

This preserves the existing route selection behaviour, including the
separate loopback route used for broadcast loopback, while removing the
dangling route/device window.

Fixes: 60d9f461a20b ("appletalk: remove the BKL")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/appletalk/ddp.c | 68 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 30a6dc06291c..e7fb4613c518 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -434,7 +434,7 @@ static struct atalk_iface *atalk_find_interface(__be16 net, int node)
  * the socket (later on...). We know about host routes and the fact
  * that a route must be direct to broadcast.
  */
-static struct atalk_route *atrtr_find(struct atalk_addr *target)
+static struct atalk_route *atrtr_find_locked(struct atalk_addr *target)
 {
 	/*
 	 * we must search through all routes unless we find a
@@ -444,7 +444,6 @@ static struct atalk_route *atrtr_find(struct atalk_addr *target)
 	struct atalk_route *net_route = NULL;
 	struct atalk_route *r;
 
-	read_lock_bh(&atalk_routes_lock);
 	for (r = atalk_routes; r; r = r->next) {
 		if (!(r->flags & RTF_UP))
 			continue;
@@ -477,6 +476,15 @@ static struct atalk_route *atrtr_find(struct atalk_addr *target)
 	else /* No route can be found */
 		r = NULL;
 out:
+	return r;
+}
+
+static struct atalk_route *atrtr_find(struct atalk_addr *target)
+{
+	struct atalk_route *r;
+
+	read_lock_bh(&atalk_routes_lock);
+	r = atrtr_find_locked(target);
 	read_unlock_bh(&atalk_routes_lock);
 	return r;
 }
@@ -1553,10 +1561,12 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	int loopback = 0;
 	struct sockaddr_at local_satalk, gsat;
 	struct sk_buff *skb;
-	struct net_device *dev;
+	struct net_device *dev = NULL, *dev_lo = NULL;
 	struct ddpehdr *ddp;
 	int size, hard_header_len;
 	struct atalk_route *rt, *rt_lo = NULL;
+	int rt_flags;
+	struct atalk_addr rt_gateway;
 	int err;
 
 	if (flags & ~(MSG_DONTWAIT|MSG_CMSG_COMPAT))
@@ -1600,39 +1610,50 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	/* For headers */
 	size = sizeof(struct ddpehdr) + len + ddp_dl->header_length;
 
+	read_lock_bh(&atalk_routes_lock);
 	if (usat->sat_addr.s_net || usat->sat_addr.s_node == ATADDR_ANYNODE) {
-		rt = atrtr_find(&usat->sat_addr);
+		rt = atrtr_find_locked(&usat->sat_addr);
 	} else {
 		struct atalk_addr at_hint;
 
 		at_hint.s_node = 0;
 		at_hint.s_net  = at->src_net;
 
-		rt = atrtr_find(&at_hint);
+		rt = atrtr_find_locked(&at_hint);
 	}
 	err = -ENETUNREACH;
-	if (!rt)
+	if (!rt) {
+		read_unlock_bh(&atalk_routes_lock);
 		goto out;
+	}
 
 	dev = rt->dev;
-
-	net_dbg_ratelimited("SK %p: Size needed %d, device %s\n",
-			sk, size, dev->name);
+	dev_hold(dev);
+	rt_flags = rt->flags;
+	rt_gateway = rt->gateway;
 
 	hard_header_len = dev->hard_header_len;
 	/* Leave room for loopback hardware header if necessary */
 	if (usat->sat_addr.s_node == ATADDR_BCAST &&
-	    (dev->flags & IFF_LOOPBACK || !(rt->flags & RTF_GATEWAY))) {
+	    (dev->flags & IFF_LOOPBACK || !(rt_flags & RTF_GATEWAY))) {
 		struct atalk_addr at_lo;
 
 		at_lo.s_node = 0;
 		at_lo.s_net  = 0;
 
-		rt_lo = atrtr_find(&at_lo);
+		rt_lo = atrtr_find_locked(&at_lo);
 
-		if (rt_lo && rt_lo->dev->hard_header_len > hard_header_len)
-			hard_header_len = rt_lo->dev->hard_header_len;
+		if (rt_lo) {
+			dev_lo = rt_lo->dev;
+			dev_hold(dev_lo);
+			if (dev_lo->hard_header_len > hard_header_len)
+				hard_header_len = dev_lo->hard_header_len;
+		}
 	}
+	read_unlock_bh(&atalk_routes_lock);
+
+	net_dbg_ratelimited("SK %p: Size needed %d, device %s\n",
+			    sk, size, dev->name);
 
 	size += hard_header_len;
 	release_sock(sk);
@@ -1675,7 +1696,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	 * to group we are in)
 	 */
 	if (ddp->deh_dnode == ATADDR_BCAST &&
-	    !(rt->flags & RTF_GATEWAY) && !(dev->flags & IFF_LOOPBACK)) {
+	    !(rt_flags & RTF_GATEWAY) && !(dev->flags & IFF_LOOPBACK)) {
 		struct sk_buff *skb2 = skb_copy(skb, GFP_KERNEL);
 
 		if (skb2) {
@@ -1693,20 +1714,21 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		/* loop back */
 		skb_orphan(skb);
 		if (ddp->deh_dnode == ATADDR_BCAST) {
-			if (!rt_lo) {
+			if (!dev_lo) {
 				kfree_skb(skb);
 				err = -ENETUNREACH;
 				goto out;
 			}
-			dev = rt_lo->dev;
-			skb->dev = dev;
+			skb->dev = dev_lo;
+			ddp_dl->request(ddp_dl, skb, dev_lo->dev_addr);
+		} else {
+			ddp_dl->request(ddp_dl, skb, dev->dev_addr);
 		}
-		ddp_dl->request(ddp_dl, skb, dev->dev_addr);
 	} else {
 		net_dbg_ratelimited("SK %p: send out.\n", sk);
-		if (rt->flags & RTF_GATEWAY) {
-		    gsat.sat_addr = rt->gateway;
-		    usat = &gsat;
+		if (rt_flags & RTF_GATEWAY) {
+			gsat.sat_addr = rt_gateway;
+			usat = &gsat;
 		}
 
 		/*
@@ -1717,6 +1739,10 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	net_dbg_ratelimited("SK %p: Done write (%zd).\n", sk, len);
 
 out:
+	if (dev)
+		dev_put(dev);
+	if (dev_lo)
+		dev_put(dev_lo);
 	release_sock(sk);
 	return err ? : len;
 }

