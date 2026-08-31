Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFA40B111
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180753; cv=none; b=VzMYzABYfMU7QfYKiVnFzZ6gcJbkatAq8yZ3wHbnExQeUygNlsr5F3YJk7mbwU8MeT8eQBRkPGdvUnhCXO+3NWnmQwdlZe6UVCG1raYAGCPaPn2m7VE3gejAX/fbo/F+VNDBehiF1Lf6lRmJ4Efvr6CpDP5jP+pE+NF8g4FIDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180753; c=relaxed/simple;
	bh=IE+rjU0arnCPYeTCwhbRJR6ZUXi0Bnu+9WHV6H5XQpA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T/Ljifuo3gfu5eXo/FbOf7H8SYc5FL/s6bSVZEjnR6l+suYEsXYMfvOHcSxuWJScqg9aPOg1r1itDGff9eT+SKQ0w+iIC2f2+uN0es1wDFK7Euq30fdfcheuTI/06oivqA5K+aPHNc2fAOuVhATNM50vkyZp35J76NWiWgvdfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VyhQpsTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VyhQpsTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C291F00A3E;
	Mon, 31 Aug 2026 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788180742;
	bh=mwmwKuzVVXkLAZ6iOnvv7Oh8PtTPhfw8usBdrRqjgFM=;
	h=Subject:To:Cc:From:Date;
	b=VyhQpsTAwXXAY9SmRQ/kjOnTQYMj4fsko7lDQt+LV0IgxyXlW7sLj4Cab4U/2IsM9
	 FF7X0scYJItshv/+fMsBoZbuJdxqLPxsP93zq+aqdqzk1Tgj0HWTcq+VqcjE7ee67W
	 O1tCN0Ets5hcJRKW3cTr/AVOauo5L4J54aiaME/U=
Subject: FAILED: patch "[PATCH] net: advertise TCP MSS from the configured MTU, not the" failed to apply to 6.6-stable tree
To: jiayuan.chen@linux.dev,edumazet@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:52:16 +0200
Message-ID: <2026083115-payer-hate-2a8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2640e64195948a601430d230c9864f5426574cde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083115-payer-hate-2a8e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2640e64195948a601430d230c9864f5426574cde Mon Sep 17 00:00:00 2001
From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Sat, 15 Aug 2026 15:03:36 +0800
Subject: [PATCH] net: advertise TCP MSS from the configured MTU, not the
 learned PMTU

The MSS a host puts in its SYN tells the peer how big a segment it may
send us. Right now we can shrink it with a PMTU we learned on our own
send path, which is the wrong direction entirely.

On asymmetric paths this bites - think DSR load balancers, where the
request side goes through a smaller-MTU overlay. We learn a small PMTU
going out, then advertise a small MSS, and the peer stays capped for the
whole connection even though its path back to us is wide. MSS only shows
up in the SYN and never grows back.

On symmetric paths we lose nothing by dropping it either: the peer runs
its own PMTU discovery and usually already knows the real path MTU.

So work out the advertised MSS from the configured route or device MTU
and ignore the learned PMTU. Our send side is unchanged, still clamped by
tcp_current_mss(). Add ip_dst_mtu_configured()/ip6_dst_mtu_configured()
and use them from the two default_advmss() paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 164a5e7ad531 ("ipv4: ipv4_default_advmss() should use route mtu")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260815070413.294559-1-jiayuan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/net/ip.h b/include/net/ip.h
index 7f2fe1a8401b..a8f57b4f4aa2 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -506,6 +506,31 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	return res;
 }
 
+/* Configured/administrative MTU of a route, for advertising the TCP MSS.
+ *
+ * Unlike ip_dst_mtu_maybe_forward(), this deliberately ignores the
+ * ICMP-learned path MTU (rt->rt_pmtu).  The advertised MSS bounds what the
+ * peer may send to us and must reflect our receive capability (the device or
+ * route-configured MTU), not a path MTU learned on the reverse (send)
+ * direction, which may not apply to the peer->us path and outlives the fnhe
+ * for the whole connection.  See RFC 2923 section 2.3 and the comment above
+ * tcp_advertise_mss().
+ */
+static inline unsigned int ip_dst_mtu_configured(const struct dst_entry *dst)
+{
+	unsigned int mtu, res;
+
+	rcu_read_lock();
+	mtu = dst_metric_raw(dst, RTAX_MTU);
+	if (!mtu)
+		mtu = READ_ONCE(dst_dev_rcu(dst)->mtu);
+	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	rcu_read_unlock();
+
+	return res;
+}
+
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 					  const struct sk_buff *skb)
 {
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index cc045705862d..c69f1c871922 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -387,6 +387,43 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
+/* Configured/administrative MTU of a route, for advertising the TCP MSS.
+ *
+ * Unlike ip6_dst_mtu_maybe_forward(), this ignores any ICMPv6-learned path
+ * MTU (which is kept on the RTF_CACHE exception route) and returns the MTU of
+ * the underlying route (fib6_pmtu) or the egress device.  The advertised MSS
+ * bounds what the peer may send to us and must reflect our receive
+ * capability, not a path MTU learned on the reverse (send) direction.  See
+ * RFC 2923 section 2.3 and the comment above tcp_advertise_mss().
+ */
+static inline unsigned int ip6_dst_mtu_configured(const struct dst_entry *dst)
+{
+	const struct rt6_info *rt = dst_rt6_info(dst);
+	const struct fib6_info *from;
+	struct inet6_dev *idev;
+	unsigned int mtu = 0;
+
+	rcu_read_lock();
+	/* IPv6 keeps the learned PMTU and the configured MTU in the same
+	 * RTAX_MTU slot: the learned value sits on this (possibly RTF_CACHE)
+	 * dst, the configured one on the underlying route.  Reach the latter
+	 * via ->from (fib6_pmtu), populated by ip6_route_info_create().
+	 */
+	from = rcu_dereference(rt->from);
+	if (from)
+		mtu = from->fib6_pmtu;
+	if (!mtu) {
+		mtu = IPV6_MIN_MTU;
+		idev = __in6_dev_get(dst_dev_rcu(dst));
+		if (idev)
+			mtu = max_t(unsigned int, mtu, READ_ONCE(idev->cnf.mtu6));
+	}
+	rcu_read_unlock();
+
+	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
+	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+}
+
 u32 ip6_mtu_from_fib6(const struct fib6_result *res,
 		      const struct in6_addr *daddr,
 		      const struct in6_addr *saddr);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 604cc51dfd9b..37674d76f90f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1363,8 +1363,8 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 	net = dst_dev_net_rcu(dst);
-	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				   net->ipv4.ip_rt_min_advmss);
+	advmss = max_t(unsigned int, ip_dst_mtu_configured(dst) - header_size,
+		       net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 526535387512..93b4168044d9 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3261,7 +3261,7 @@ void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	unsigned int mtu = dst6_mtu(dst);
+	unsigned int mtu = ip6_dst_mtu_configured(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);

