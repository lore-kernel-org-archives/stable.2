Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1B477E20
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261083; cv=none; b=mrUC1klfZMjr+MAgw7E8ejLLO2aj5vTgqp/xMQfRGuPh/41DKP4GpjZLu+g0yQwfg8xyBbVOl6qWdBCFeaVuq281oO7hfPMpBAvE3ssJToqRBn/imcn0hMJxcPkWS475PlzNrzg7WbPPiFCLRWWt3xnlRDUdrT47sW2W6xE6eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261083; c=relaxed/simple;
	bh=unbBJyDjUujbPJVQUM505Y6Bqv/8JosD0gX1jcV25QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdnDaw+ogScCJLgW7wPmcLVnfhp+pg5PCoL7K88/Seo73QG0Bis1/U4vAWCurlzUvs5C3309y5tel9A4t/SLI3eIlBKV13HhXB7W/HdYXyu+zg1gzOry5TSERayTzb5K7rTSLCcB1Fb2nP/JL3lV0gjU1RrNhsmr8kMlhJALfLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abTX7BZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abTX7BZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE471F00A3D;
	Tue,  1 Sep 2026 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261081;
	bh=W+/uZhF820uT46/tqOl9s16EAN9/Q3CibjEtg+LiSYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=abTX7BZhKfh5iCEDUjhIQn+7PmCn1uE5Hb3cUtgOeJjmzAvQMpPxGoyiuJEprVX4c
	 53wwiX7kFynKLVWK4z/pfUoaqh1yZn5q8R4TQEnYXGn9YL41u0PHDdJfDPTiN72B4O
	 TA7xrO9UrZrjQuntrH1rW0KbJvmcMCF0vtp1umxfe9hNg7apbNdcgRBsXx5wteAtOr
	 FLid0NXAz6EsrWhjfruEUvgApqYmxMeRM1V1fci9Aj1HVKx1hIvn6yX/CwS2qTdmzo
	 QsDjvSuROvOmS5Cb3abyJYturwDMp5b12YhGNWNgDBEHrM4UEKkxIm2rKWuWHHKG3G
	 iSJbIXUn/i44w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] net: advertise TCP MSS from the configured MTU, not the learned PMTU
Date: Tue,  1 Sep 2026 07:11:15 -0400
Message-ID: <20260901111115.4175900-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901111115.4175900-1-sashal@kernel.org>
References: <2026083114-maturing-resize-d958@gregkh>
 <20260901111115.4175900-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 2640e64195948a601430d230c9864f5426574cde ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip.h        | 25 +++++++++++++++++++++++++
 include/net/ip6_route.h | 37 +++++++++++++++++++++++++++++++++++++
 net/ipv4/route.c        |  4 ++--
 net/ipv6/route.c        |  2 +-
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 39c6a4033aeda..d8ce127278367 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -508,6 +508,31 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
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
index 07c87c239511e..4806529ee2105 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -349,6 +349,43 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
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
index 9135a9dc8f297..e27486313c04a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1356,8 +1356,8 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 	net = dst_dev_net_rcu(dst);
-	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				   net->ipv4.ip_rt_min_advmss);
+	advmss = max_t(unsigned int, ip_dst_mtu_configured(dst) - header_size,
+		       net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f7a138e317bad..20924262434e5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3246,7 +3246,7 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	unsigned int mtu = dst6_mtu(dst);
+	unsigned int mtu = ip6_dst_mtu_configured(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
-- 
2.53.0

