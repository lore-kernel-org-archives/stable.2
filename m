Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152933C4B83;
	Mon, 15 Jun 2026 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514454; cv=none; b=MhyyAkYcMZiTiKc03/mUKdhfO9Wy3X7WRIRPLCuxbIDk+4SwkEMQLRbgHcKXxch1BOKgiCTfgqCvzDbl2T0APW84cYy/ieVMcNW0P36xatGce6BNmWHMJBSjpist1Z+ni+Uzqr4h1FFHtn27q/N0yi2UIXRog/D6wZ4/kzsSfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514454; c=relaxed/simple;
	bh=cYbJKriM1c5oNg3f0KPq+HRDkoJqBGFt0Bko99VEAUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCT5U81S4zwiPD0xPM8g+2Imx2iYa7isJ2Pz2tki5Wrbm1rXAU4+GuaNtJyMI42uD8nZgwMPpZij7KkgnbEqYnpsC2ogCg3dfZsmE57qV3hfuFC1/EoLS4HfC5ouc4CQ0mv/nbbWf+BaHfKdw/5Al8f8GH2RkdY+7vNeIP5uuTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=AZGi31R/; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="AZGi31R/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=eFxRL
	SPb51yd/Kd9E61uwcifN1eEx8Lok5rrcuSCZZw=; b=AZGi31R/pzxSrbi08k8Fh
	QwYECCQp174JrHqP+2RIICNlHs9YlrG8OSe2onkktFsgz1F5DaHB/OnLIfT5tV0x
	6aXy+/th3qRTwuRbWof7+RIGLSDl9Mw+hLzgImTMmMl/VAn/CW5knnJNw/28Kce7
	BMrzRpCROkqpAAznbxMv5A=
Received: from DESKTOP-35NLEVI (unknown [166.111.239.35])
	by web3 (Coremail) with SMTP id ygQGZQAnc5C6wC9qEmpzAg--.19721S2;
	Mon, 15 Jun 2026 17:07:07 +0800 (CST)
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
Subject: [PATCH net v2] appletalk: fix TOCTOU race in atalk_sendmsg
Date: Mon, 15 Jun 2026 17:06:33 +0800
Message-ID: <20260615090635.1549-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:ygQGZQAnc5C6wC9qEmpzAg--.19721S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyrCFyDWFyDAFyUJFWUArb_yoWxKFyxpF
	WxCa4YkayDGw1jgrs2qay7Cr1ayrs5GryfGryfJ3y0vFs0gFy8uFy0ya4IvF90yF1kJr4r
	XFWqva1qkF47XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjWxR3UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgETAWovr8QmuQAAsg

atalk_sendmsg() looks up an AppleTalk route, stores the returned=0D
atalk_route and net_device pointers, and then drops the socket lock=0D
around sock_alloc_send_skb().  The route pointer returned by=0D
atrtr_find() is only protected while atalk_routes_lock is held; after=0D
that lock is dropped, a concurrent SIOCDELRT or device-down path can=0D
unlink the route, drop the device reference, and free the route.=0D
=0D
When sendmsg resumes, it can still dereference the stale route and=0D
device pointers while building or transmitting the packet.  A KASAN=0D
reproducer using AF_APPLETALK sockets and SIOCADDRT/SIOCDELRT reports=0D
slab-use-after-free reads in atalk_sendmsg(), with the object allocated=0D
by atrtr_create() and freed by atrtr_delete().=0D
=0D
Fix this by splitting the route lookup into a helper that is called with=0D
atalk_routes_lock already held.  atalk_sendmsg() now performs route=0D
lookup, copies the route fields it needs, and takes references to the=0D
selected devices with netdev_hold() while still holding=0D
atalk_routes_lock.  After the lock is dropped and skb allocation sleeps,=0D
the send path uses only the copied route data and the held net_device=0D
references, which are released with netdev_put() before returning.=0D
=0D
This preserves the existing route selection behaviour, including the=0D
separate loopback route used for broadcast loopback, while removing the=0D
dangling route/device window.=0D
=0D
Fixes: 60d9f461a20b ("appletalk: remove the BKL")=0D
Cc: stable@vger.kernel.org=0D
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>=0D
Reported-by: Ao Wang <wangao@seu.edu.cn>=0D
Reported-by: Xuewei Feng <fengxw06@126.com>=0D
Reported-by: Qi Li <qli01@tsinghua.edu.cn>=0D
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>=0D
Assisted-by: GLM:GLM-5.1=0D
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
---=0D
Changes in v2:=0D
- Use netdev_hold()/netdev_put() instead of dev_hold()/dev_put().=0D
- Drop explicit NULL checks before releasing temporary device refs.=0D
- Link to v1: https://lore.kernel.org/netdev/20260610052315.64504-1-zhaoyz2=
4@mails.tsinghua.edu.cn/=0D
---=0D
 net/appletalk/ddp.c | 67 ++++++++++++++++++++++++++++++++++++-------------=
----=0D
 1 file changed, 46 insertions(+), 21 deletions(-)=0D
=0D
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c=0D
index 30a6dc06291c..9b95dd06f600 100644=0D
--- a/net/appletalk/ddp.c=0D
+++ b/net/appletalk/ddp.c=0D
@@ -434,7 +434,7 @@ static struct atalk_iface *atalk_find_interface(__be16 =
net, int node)=0D
  * the socket (later on...). We know about host routes and the fact=0D
  * that a route must be direct to broadcast.=0D
  */=0D
-static struct atalk_route *atrtr_find(struct atalk_addr *target)=0D
+static struct atalk_route *atrtr_find_locked(struct atalk_addr *target)=0D
 {=0D
 	/*=0D
 	 * we must search through all routes unless we find a=0D
@@ -444,7 +444,6 @@ static struct atalk_route *atrtr_find(struct atalk_addr=
 *target)=0D
 	struct atalk_route *net_route =3D NULL;=0D
 	struct atalk_route *r;=0D
 =0D
-	read_lock_bh(&atalk_routes_lock);=0D
 	for (r =3D atalk_routes; r; r =3D r->next) {=0D
 		if (!(r->flags & RTF_UP))=0D
 			continue;=0D
@@ -477,6 +476,15 @@ static struct atalk_route *atrtr_find(struct atalk_add=
r *target)=0D
 	else /* No route can be found */=0D
 		r =3D NULL;=0D
 out:=0D
+	return r;=0D
+}=0D
+=0D
+static struct atalk_route *atrtr_find(struct atalk_addr *target)=0D
+{=0D
+	struct atalk_route *r;=0D
+=0D
+	read_lock_bh(&atalk_routes_lock);=0D
+	r =3D atrtr_find_locked(target);=0D
 	read_unlock_bh(&atalk_routes_lock);=0D
 	return r;=0D
 }=0D
@@ -1553,10 +1561,13 @@ static int atalk_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t len)=0D
 	int loopback =3D 0;=0D
 	struct sockaddr_at local_satalk, gsat;=0D
 	struct sk_buff *skb;=0D
-	struct net_device *dev;=0D
+	struct net_device *dev =3D NULL, *dev_lo =3D NULL;=0D
+	netdevice_tracker dev_tracker, dev_lo_tracker;=0D
 	struct ddpehdr *ddp;=0D
 	int size, hard_header_len;=0D
 	struct atalk_route *rt, *rt_lo =3D NULL;=0D
+	int rt_flags;=0D
+	struct atalk_addr rt_gateway;=0D
 	int err;=0D
 =0D
 	if (flags & ~(MSG_DONTWAIT|MSG_CMSG_COMPAT))=0D
@@ -1600,39 +1611,50 @@ static int atalk_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t len)=0D
 	/* For headers */=0D
 	size =3D sizeof(struct ddpehdr) + len + ddp_dl->header_length;=0D
 =0D
+	read_lock_bh(&atalk_routes_lock);=0D
 	if (usat->sat_addr.s_net || usat->sat_addr.s_node =3D=3D ATADDR_ANYNODE) =
{=0D
-		rt =3D atrtr_find(&usat->sat_addr);=0D
+		rt =3D atrtr_find_locked(&usat->sat_addr);=0D
 	} else {=0D
 		struct atalk_addr at_hint;=0D
 =0D
 		at_hint.s_node =3D 0;=0D
 		at_hint.s_net  =3D at->src_net;=0D
 =0D
-		rt =3D atrtr_find(&at_hint);=0D
+		rt =3D atrtr_find_locked(&at_hint);=0D
 	}=0D
 	err =3D -ENETUNREACH;=0D
-	if (!rt)=0D
+	if (!rt) {=0D
+		read_unlock_bh(&atalk_routes_lock);=0D
 		goto out;=0D
+	}=0D
 =0D
 	dev =3D rt->dev;=0D
-=0D
-	net_dbg_ratelimited("SK %p: Size needed %d, device %s\n",=0D
-			sk, size, dev->name);=0D
+	netdev_hold(dev, &dev_tracker, GFP_ATOMIC);=0D
+	rt_flags =3D rt->flags;=0D
+	rt_gateway =3D rt->gateway;=0D
 =0D
 	hard_header_len =3D dev->hard_header_len;=0D
 	/* Leave room for loopback hardware header if necessary */=0D
 	if (usat->sat_addr.s_node =3D=3D ATADDR_BCAST &&=0D
-	    (dev->flags & IFF_LOOPBACK || !(rt->flags & RTF_GATEWAY))) {=0D
+	    (dev->flags & IFF_LOOPBACK || !(rt_flags & RTF_GATEWAY))) {=0D
 		struct atalk_addr at_lo;=0D
 =0D
 		at_lo.s_node =3D 0;=0D
 		at_lo.s_net  =3D 0;=0D
 =0D
-		rt_lo =3D atrtr_find(&at_lo);=0D
+		rt_lo =3D atrtr_find_locked(&at_lo);=0D
 =0D
-		if (rt_lo && rt_lo->dev->hard_header_len > hard_header_len)=0D
-			hard_header_len =3D rt_lo->dev->hard_header_len;=0D
+		if (rt_lo) {=0D
+			dev_lo =3D rt_lo->dev;=0D
+			netdev_hold(dev_lo, &dev_lo_tracker, GFP_ATOMIC);=0D
+			if (dev_lo->hard_header_len > hard_header_len)=0D
+				hard_header_len =3D dev_lo->hard_header_len;=0D
+		}=0D
 	}=0D
+	read_unlock_bh(&atalk_routes_lock);=0D
+=0D
+	net_dbg_ratelimited("SK %p: Size needed %d, device %s\n",=0D
+			    sk, size, dev->name);=0D
 =0D
 	size +=3D hard_header_len;=0D
 	release_sock(sk);=0D
@@ -1675,7 +1697,7 @@ static int atalk_sendmsg(struct socket *sock, struct =
msghdr *msg, size_t len)=0D
 	 * to group we are in)=0D
 	 */=0D
 	if (ddp->deh_dnode =3D=3D ATADDR_BCAST &&=0D
-	    !(rt->flags & RTF_GATEWAY) && !(dev->flags & IFF_LOOPBACK)) {=0D
+	    !(rt_flags & RTF_GATEWAY) && !(dev->flags & IFF_LOOPBACK)) {=0D
 		struct sk_buff *skb2 =3D skb_copy(skb, GFP_KERNEL);=0D
 =0D
 		if (skb2) {=0D
@@ -1693,20 +1715,21 @@ static int atalk_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t len)=0D
 		/* loop back */=0D
 		skb_orphan(skb);=0D
 		if (ddp->deh_dnode =3D=3D ATADDR_BCAST) {=0D
-			if (!rt_lo) {=0D
+			if (!dev_lo) {=0D
 				kfree_skb(skb);=0D
 				err =3D -ENETUNREACH;=0D
 				goto out;=0D
 			}=0D
-			dev =3D rt_lo->dev;=0D
-			skb->dev =3D dev;=0D
+			skb->dev =3D dev_lo;=0D
+			ddp_dl->request(ddp_dl, skb, dev_lo->dev_addr);=0D
+		} else {=0D
+			ddp_dl->request(ddp_dl, skb, dev->dev_addr);=0D
 		}=0D
-		ddp_dl->request(ddp_dl, skb, dev->dev_addr);=0D
 	} else {=0D
 		net_dbg_ratelimited("SK %p: send out.\n", sk);=0D
-		if (rt->flags & RTF_GATEWAY) {=0D
-		    gsat.sat_addr =3D rt->gateway;=0D
-		    usat =3D &gsat;=0D
+		if (rt_flags & RTF_GATEWAY) {=0D
+			gsat.sat_addr =3D rt_gateway;=0D
+			usat =3D &gsat;=0D
 		}=0D
 =0D
 		/*=0D
@@ -1717,6 +1740,8 @@ static int atalk_sendmsg(struct socket *sock, struct =
msghdr *msg, size_t len)=0D
 	net_dbg_ratelimited("SK %p: Done write (%zd).\n", sk, len);=0D
 =0D
 out:=0D
+	netdev_put(dev, &dev_tracker);=0D
+	netdev_put(dev_lo, &dev_lo_tracker);=0D
 	release_sock(sk);=0D
 	return err ? : len;=0D
 }=0D

