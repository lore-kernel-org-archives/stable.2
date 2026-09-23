Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09AB3B71DD
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135551; cv=none; b=f3IEtNrRJmNsH5AIKjcxZwdTIwIqyj70y4Uc2jnERaNQ1IiFv5GLQl/BROqUj/dsUQP8ug6FSd2CDhwRJGWGv+j+xe/FAJWeAZetutlCbAdiS8JneCTxQaqfVjrXJND4kTm+t76ILECE11jZmqQ/oGXgXpRjcvLNTkmOBFuyxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135551; c=relaxed/simple;
	bh=BmZpXZIROWkh1uBLxC5BPHaoeHBIpQma+jOBGh9frLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kfm+J1yBJKQbL6El45SYoLlElMEYsMW7uRxKtKel5slu6yc2zZX2XimZlkRj4SRol18C+7Z2Q+7NvAH//FZumIJ93ZM21qg6bKEXAc61xqGpYzq6tdfOLzReItePZR8GZ4wxJ4RHtJlc4EN71WJgaCG0i4VA1yn9UfE3uYuhEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KcBKn33h; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KcBKn33h"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a1b824e84so130877685a.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790135549; x=1790740349; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jB40GJdDU1KiJ/0C7Ze6Q+NzKDuFcyMLiRd5uNfD6U=;
        b=KcBKn33hQDzzarbkt0EgKW4bLe2JtmqhU3yUVUR/9Vo/lTwMlYlA9/Kszh30xbsXsc
         bdIZthWvKmh/gWnt0gUiHZnQKRn4op2D5SIAormklVrBv6Hap5itbm0P7MOKxhswl0hH
         cXMXpilIkVxl/YVIcBUXcrFeypSLxp8FknpcORZQNg7aDq+a0+ELSuiz+WmXa9wDAhLn
         csFEdjY2yNGWCMthFEjDXqkxzLmujCbN1hC3fl5s0mumuJaBEMYzaCJGbxMngt2w13JA
         0YTa3sAIYtHo/92RQB8tDnr3STpM29K0mRGE4wWqANb2WxAcPwZ9ceRZ+TRni+u4W1ij
         X/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790135549; x=1790740349;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jB40GJdDU1KiJ/0C7Ze6Q+NzKDuFcyMLiRd5uNfD6U=;
        b=xGNKPalm2ir/frYNpf37ZfNMO48pZfoDHavHZIK+ONMVZQ970giesNAuhPRslniglf
         rj5G2uYdqb98xG+2OuF35/UUhHz6hTaR9h4zlL1ksIEtdxOqo381QedByxeNHPBKDz+9
         31ZumTLWzRAjwHLm3GY7wMinwr2c8dVdqf2chOcfQ0MUWUhvuiaBszqsBQOdpjE0of3r
         wN2Rp8G0QpnxmrIOVF9vSfdMJtbC5Ousiy3iLjsoTekQ4G8TF4IpStszB9fxD2oYzrY7
         vCak7FDRpeTVclVTPdjxcoj/jSdG/CKIODdOtqu9KK2Ew4YX3wHH7SErOa4gI4bDkwu8
         D8Iw==
X-Forwarded-Encrypted: i=1; AKwUvBx1CJEC4sIPMsBhJRiSl0vdBt0XmbgZhVzIw4teoHPeNj7OTMApXp8dTc4CuNy/JWkW//U0Dds=@vger.kernel.org
X-Gm-Message-State: AFuF++mgyALYADLH3MN+YkzMrtCwuSCwxVIdStwpgQoowr9ljRqng8ea
	2IlCe2tCsPQZNKFARFGebo/4Pd9bX+/wWTpuDFCnk0VEM6nQ410MEGhXYpWEd/3UuqUDiCQsUp4
	EhlpXv00f403G0A==
X-Received: from qkmm2.prod.google.com ([2002:a05:620a:2142:b0:92e:6dfa:48a6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:439b:b0:93a:1b82:4962 with SMTP id af79cd13be357-93c251fda49mr228275485a.47.1790135548599;
 Tue, 22 Sep 2026 20:52:28 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:52:15 +0000
In-Reply-To: <20260923035217.179102-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923035217.179102-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923035217.179102-4-edumazet@google.com>
Subject: [PATCH net v3 3/5] ip_gre: compute tunnel lengths absolutely instead
 of by delta
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, William Tu <u9012063@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ipgre_link_update() shifts tunnel->hlen, dev->hard_header_len,
dev->needed_headroom and dev->mtu by the difference in tunnel->tun_hlen.
That misses any change to tunnel->encap_hlen, which ipgre_changelink() can
change through ipgre_newlink_encap_setup(). Such a request leaves @len
at zero: adding "encap fou" to an existing gre device keeps the MTU of a
bare tunnel, while creating it with "encap fou" from the start gets the
smaller MTU from ip_tunnel_bind_dev().

A difference is the wrong tool anyway: ip_tunnel_bind_dev() already
assigns dev->needed_headroom from tunnel->hlen, so changing the link and
the encapsulation at once is accounted twice, and ip_tunnel_encap_setup()
publishes a new tunnel->hlen before ip_tunnel_changelink() runs, making the
next difference bogus.

Recompute tunnel->hlen from tun_hlen and encap_hlen, as
__gre_tunnel_init() does, and add ip_tunnel_refresh_lengths() so that
ip_tunnel_bind_dev() is the only writer of dev->needed_headroom and
dev->mtu. ipgre_changelink() must then refresh on its
ip_tunnel_changelink() error path too, since the new encapsulation is
published by then.

dev->hard_header_len is recomputed the same way, but it stays in
ipgre_link_update(): for the ARPHRD_IPGRE devices installing
ipgre_header_ops it is the outer IP + GRE header, which
ip_tunnel_bind_dev() does not know about. Check specifically for
ipgre_header_ops: gretap devices also have header_ops (eth_header_ops),
where hard_header_len is the 14-byte inner Ethernet header that
ip_tunnel_bind_dev() subtracts from the MTU, and commit fdafed459998
("ip_gre: set dev->hard_header_len and dev->needed_headroom properly")
wrongly adjusted hard_header_len instead of needed_headroom for them.

@old_hlen survives only as a predicate telling whether the MTU became
stale, never as a difference, so it can not make the lengths drift. When
ip_tunnel_update() recomputes dev->mtu after a link or fwmark change using
the intermediate t->hlen published by ip_tunnel_encap_setup(), update
@old_hlen to that intermediate value so ipgre_link_update() still refreshes
dev->mtu if tun_hlen moves.

There is no memory safety issue: ipgre_xmit() cows dev->needed_headroom
at tunnel entry, which always reserves sizeof(struct iphdr) + lower
device headroom (>= 34 bytes after the GRE header), enough for
ip_tunnel_encap() to push the FOU/GUE header before ip_tunnel_xmit()
cows again for the outer IP header.

Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Fixes: fdafed459998 ("ip_gre: set dev->hard_header_len and dev->needed_headroom properly")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h |  1 +
 net/ipv4/ip_gre.c        | 63 ++++++++++++++++++++++++++++++----------
 net/ipv4/ip_tunnel.c     | 17 +++++++++++
 3 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7c9aadfe8fe396da10a47e93499a97141ac04f4c..fd0396aa5039538a0391a352ace6d15f554df874 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -429,6 +429,7 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
 		      __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
+void ip_tunnel_refresh_lengths(struct net_device *dev, bool set_mtu);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
 				   struct ip_tunnel_encap *encap);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index df4d2f1f1d60c7f3755e4f554f04a06480512909..27b3b4c584b1e1b4f1c9c9f42b5585b28101ece0 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -789,23 +789,36 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static void ipgre_link_update(struct net_device *dev, bool set_mtu)
+/* tunnel->hlen depends on tunnel->parms.o_flags and on tunnel->encap_hlen,
+ * both of which ipgre_changelink() can change. Recompute it the way
+ * __gre_tunnel_init() does, then let ip_tunnel_bind_dev() derive the device
+ * lengths from it.
+ *
+ * @old_hlen is only used to tell whether the MTU became stale, never as a
+ * difference to apply, so it can not make the lengths drift. It must be
+ * sampled before ip_tunnel_encap_setup(), which already publishes the new
+ * tunnel->hlen for us.
+ */
+static void ipgre_link_update(struct net_device *dev, bool set_mtu,
+			      int old_hlen)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	int len;
 
-	len = tunnel->tun_hlen;
 	tunnel->tun_hlen = gre_calc_hlen(tunnel->parms.o_flags);
-	len = tunnel->tun_hlen - len;
-	tunnel->hlen = tunnel->hlen + len;
+	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
 
-	if (dev->header_ops)
-		dev->hard_header_len += len;
-	else
-		dev->needed_headroom += len;
+	/* For the ARPHRD_IPGRE devices installing ipgre_header_ops,
+	 * dev->hard_header_len is the outer IP + GRE header, as set by
+	 * ipgre_tunnel_init(). ip_tunnel_bind_dev() does not maintain it:
+	 * it only subtracts it from the MTU, and only for ARPHRD_ETHER.
+	 */
+	if (dev->header_ops == &ipgre_header_ops)
+		dev->hard_header_len = tunnel->hlen + sizeof(struct iphdr);
 
-	if (set_mtu)
-		WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len, 68));
+	/* Only reset a MTU that the header length just invalidated, so that
+	 * a MTU configured by the user survives an unrelated change.
+	 */
+	ip_tunnel_refresh_lengths(dev, set_mtu && tunnel->hlen != old_hlen);
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags) ||
 	    (test_bit(IP_TUNNEL_CSUM_BIT, tunnel->parms.o_flags) &&
@@ -853,7 +866,7 @@ static int ipgre_tunnel_ctl(struct net_device *dev,
 		ip_tunnel_flags_copy(t->parms.o_flags, p->o_flags);
 
 		if (strcmp(dev->rtnl_link_ops->kind, "erspan"))
-			ipgre_link_update(dev, true);
+			ipgre_link_update(dev, true, t->hlen);
 	}
 
 	i_flags = gre_tnl_flags_to_gre_flags(p->i_flags);
@@ -1496,6 +1509,8 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	struct ip_gre_parm gparms;
+	int old_hlen = t->hlen;
+	bool link_changed;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
@@ -1509,17 +1524,35 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	link_changed = t->parms.link != p.link || t->fwmark != gparms.fwmark;
+
 	err = ip_tunnel_changelink(dev, tb, &p, gparms.fwmark);
 	if (err < 0)
-		return err;
+		goto link_update;
+
+	/* When the link or fwmark changed, ip_tunnel_update() has just
+	 * recomputed dev->mtu from the intermediate t->hlen published by
+	 * ip_tunnel_encap_setup(). Record that as the length dev->mtu now
+	 * reflects so ipgre_link_update() refreshes it if tun_hlen moves.
+	 */
+	if (link_changed)
+		old_hlen = t->hlen;
 
 	ipgre_commit_parms(t, &gparms);
 	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
 	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
 
-	ipgre_link_update(dev, !tb[IFLA_MTU]);
+link_update:
+	/* ipgre_newlink_encap_setup() has published a new encapsulation even
+	 * if ip_tunnel_changelink() failed, so the lengths must be refreshed
+	 * on that error path as well.
+	 *
+	 * IFLA_MTU only defers the MTU to do_setlink(), which rtnl_changelink()
+	 * does not reach if we return an error, so it must not hold it back.
+	 */
+	ipgre_link_update(dev, err || !tb[IFLA_MTU], old_hlen);
 
-	return 0;
+	return err;
 }
 
 static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 2a313b18134e2f0bafd52d59d8e173fa1a084f03..dd1b2f719f21670b02bfc1cafa62689b4a28a580 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -326,6 +326,23 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 	return mtu;
 }
 
+/* Recompute dev->needed_headroom and dev->mtu after tunnel->hlen changed.
+ *
+ * Both are derived from tunnel->hlen, so they must be recomputed from it
+ * rather than adjusted by the difference: ip_tunnel_bind_dev() is also
+ * called from ip_tunnel_create(), ip_tunnel_newlink(), ip_tunnel_init_net()
+ * and ip_tunnel_update(), and a caller adding its own delta on top would
+ * double count it.
+ */
+void ip_tunnel_refresh_lengths(struct net_device *dev, bool set_mtu)
+{
+	int mtu = ip_tunnel_bind_dev(dev);
+
+	if (set_mtu)
+		WRITE_ONCE(dev->mtu, mtu);
+}
+EXPORT_SYMBOL_GPL(ip_tunnel_refresh_lengths);
+
 static struct ip_tunnel *ip_tunnel_create(struct net *net,
 					  struct ip_tunnel_net *itn,
 					  struct ip_tunnel_parm_kern *parms)
-- 
2.55.0.1082.g2b9226bbc0-goog

