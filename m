Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792999392;
	b=TfhJfM2LsdAmtBRTGrredXNOlzaSA6bVpvpyt2OomGX6z7QzIfVLh9dGRD5kVfG+7ruf
	 4oONi1NVWYx4EEJaFds0MveVyghlpQSpFO28UB86qtTrtvSI4l9gea4eC7uhhE8/g7QX4
	 a7CZnZai9bhTUCwZFUhV3Im55uAcM3n58eBH/M7FwFqypeb9/XS27E+nHK5zxfQpyWDAO
	 hfR5y/fnrcX+pRFbuJhQPrIPOdVU8XZX1zeyaeBvU7wra6PUGvmi+ny8M8kZgSesAg/q7
	 u6qil7LpGD6F1/X/CNz/fe3cNd5GHnnmjrdfuYCte/mA02fjps1Z7nFV+o1sI/CHbCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999392;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=t3ZjtwgrD/gzd7YIbWTU8D3+CAezX9gdRtFNrEWBVK0=;
	b=CrkmBMs9Gyfw01kIKZpkNh3tW3O4NDpF0RNE3x/+gvBK6+PIncY/5Dl8F4eITcBP0r3p
	 Bqkhk5K4nW1NDiOAPxllAF5pNLSm7gOaRXfYruudQ7NtU563zreCkDo/VvLX3Vr2lHvHR
	 Ub02c9CUggue9O4P53NlYOJOUitM72PAQKVa1YOMgiZtrnh77EkEjx3le2pFgn1EMsaCe
	 zIGp326PZZCGzhtRmya6jlBg2I4Sn8T6nM/DsR5zLl4fahs28NIoiEXQRYyDJMDtvh5iw
	 7w3xMqXmPChmiUKzSd/fZcCYWRaBNWwjnUK1C0FnGPqKJxDeqhw57OvS7I4PtSs8DjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FealGjTE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C8606A325;
	Mon, 26 Oct 2026 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FealGjTE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792999391;
	b=2GdBrx/HJxTNmzkf3ge6cHhBHiBXjwQRWHAjCsLdrTFjqS/tsQgKszefYEZpuAWsj6dS
	 z7Rglxm2+IEdnpyN8no2jQeL4y+8CJZHtw1lIWiKCz5DMbV7ysy+HwstcApcddptJKk9M
	 D7x2PZw66gh8WaYtjxaoN40RN8vodLI5iULjOZ1tGznxZ4xyaog+VP7NeRXGKdSUc4gTo
	 /R360RVt6dCU1rqs/+/s45fKz7AKO9q1ZF7Sj9JUnGc1ooe/VmH847rEH5KTy2V2WZhUl
	 qvs8U8GsOOW48XZ3PfBQioWj0DzjV92QhpGYoiYo8SB72wXoFjMei/mDe7iji+18l7Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792999391;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=t3ZjtwgrD/gzd7YIbWTU8D3+CAezX9gdRtFNrEWBVK0=;
	b=V4Kuhd6RkF3aHl+2JiC4lw3fb1G1Z1L1ltHAOGCGu1FuaJ6k0SL5CWsXBJ4jYH8pvJAf
	 Bs1/XZxNufattxPa5ZwqchhOzP1KoMrDK2Bo5HpGtFIihOftzYeZKVx2q4SZA+goUMChl
	 R0EMd9U5HXJ+mafxhZrS84CiyvkVfLa8f9nnEf+piUXVNgWXjUyWksfw2KZFlPZMJdIs5
	 gP4tN4O7arHnEowc4lC2YLkjPNNmMYqFs6B45FPJgaZJV7ekDr58+K9rl+HR1gFdEq9BV
	 ywQlPUvzlGOZJgioDlfR3Hk031Vht3aHY6TQ4pj3ILoo8916KlYcFHaK+o5esJIjuWA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 58BD41F01829;
	Mon, 26 Oct 2026 07:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999391;
	bh=t3ZjtwgrD/gzd7YIbWTU8D3+CAezX9gdRtFNrEWBVK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FealGjTEYVZ9QPNXMLYxBlSHiyWkNzb5HMAvQ6rFSTWLG7K8KJnWHIUu6enqqjVrU
	 WFHB35luN3wK28AGH+kUgO7aDj2WM410nI0kWu05Ya+BQjYcjW/1kpXW+T2JehdnQl
	 GuicV0akvVEZfud2vromRaVLFhRnS23ZdPtR8XRhdqwc65SdBiY/UGK7cHwl2OK0ud
	 nMJgI1Nk7Akvanjf8C69aKYSRSvh076MN1RVLDCWsuGlUA2sSUj28nQOb5Lm5J7eV8
	 KNbIjE++3zTW/Y7C/uOdrk914b9+tNmXyEBKGwWvElYAM6G9+RtjQQu4fo3BDlI4IY
	 2ZPPgZwbF2ogA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D9BFB44C4B;
	Mon, 26 Oct 2026 07:23:09 +0000 (UTC)
From: Esko Mobius via B4 Relay <devnull+echoowall.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 15:23:09 +0800
Subject: [PATCH net 2/2] Revert "net: advertise TCP MSS from the configured
 MTU, not the learned PMTU"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
In-Reply-To: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Esko Mobius <echoowall@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792999388; l=7106;
 i=echoowall@gmail.com; s=20261026; h=from:subject:message-id;
 bh=fL0gKXuPe+I5V6mRdeFfmPyR7mfZWM2UrUUi/fbzPNQ=;
 b=PwtWXbh/QSU8s8/6UZXtK7P2iALPCmzcQe2h88iYL9ZiLRSFfrVpjL0toZoDDrCUpykbJHxxh
 87/1+l0HfDLAC9s0m+bTv7L12i7SWDqAr5P0gEVgmwSoh9z9LEpKKll
X-Developer-Key: i=echoowall@gmail.com; a=ed25519;
 pk=9XP6JhqjjPsHCF6UZZZTeqTRnXIa4+ufggnxXtTJ+no=
X-Endpoint-Received: by B4 Relay for echoowall@gmail.com/20261026 with
 auth_id=1323
X-Original-From: Esko Mobius <echoowall@gmail.com>
Reply-To: echoowall@gmail.com
Content-Transfer-Encoding: 7bit

From: Esko Mobius <echoowall@gmail.com>

This reverts commit 2640e6419594 ("net: advertise TCP MSS from the
configured MTU, not the learned PMTU").

That commit stopped the learned PMTU from lowering the MSS we advertise
in SYN and SYN-ACK. For symmetric paths it argued that "the peer runs
its own PMTU discovery and usually already knows the real path MTU".
That only holds if ICMP "fragmentation needed" can reach the peer. When
the peer sits behind a firewall that drops inbound ICMP, its PMTU
discovery is a black hole (RFC 2923, section 2.1), and the smaller MSS
we advertised was the only thing keeping its full-size segments off the
narrow hop.

Inbound ICMP filtering is very common in enterprise and carrier
networks, and it is pervasive in mainland China. We hit this in
production after the commit was backported to 6.12.111: TCP connections
that reach a server through a relay with a smaller-MTU hop complete the
handshake, then stall as soon as the client sends full-size segments.
Clients on networks that let ICMP through, and connections that bypass
the relay, are unaffected, which made it hard to trace back to the
kernel.

Reproducer, network namespaces on a single host:

  cli --(1500)-- r1 --(1456)-- r2 --(1500)-- srv

r1 drops ICMP frag-needed towards cli. srv has already learned PMTU
1456 towards cli, then cli uploads 1 MB to srv:

  kernel                     SYN-ACK MSS   1 MB upload
  6.12.107                   1416          OK
  6.12.111                   1460          stalls, times out
  7.3-rc7                    1460          stalls, times out
  7.3-rc7 + this revert      1416          OK

The asymmetric case the commit was written for does not need a new
default: the advertised MSS can already be set per route with the
advmss metric, which takes precedence over default_advmss(). With this
revert applied, on an asymmetric path where srv learned PMTU 1456
towards cli while cli->srv is 1500 end to end:

  srv route to cli           SYN-ACK MSS   largest cli->srv segment
  default                    1416          1404
  advmss 1460                1460          1448

So DSR-style setups can opt in with "ip route ... advmss <mss>", while
hosts whose peers cannot complete PMTU discovery keep working by
default.

Fixes: 2640e6419594 ("net: advertise TCP MSS from the configured MTU, not the learned PMTU")
Reported-by: Esko Mobius <echoowall@gmail.com>
Closes: https://lore.kernel.org/regressions/4F0FAEB6-A13B-47F3-BFF1-C706686C6F64@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Esko Mobius <echoowall@gmail.com>
---
 include/net/ip.h        | 25 -------------------------
 include/net/ip6_route.h | 37 -------------------------------------
 net/ipv4/route.c        |  4 ++--
 net/ipv6/route.c        |  2 +-
 4 files changed, 3 insertions(+), 65 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 618b9806c..0acc4ba5e 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -513,31 +513,6 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	return res;
 }
 
-/* Configured/administrative MTU of a route, for advertising the TCP MSS.
- *
- * Unlike ip_dst_mtu_maybe_forward(), this deliberately ignores the
- * ICMP-learned path MTU (rt->rt_pmtu).  The advertised MSS bounds what the
- * peer may send to us and must reflect our receive capability (the device or
- * route-configured MTU), not a path MTU learned on the reverse (send)
- * direction, which may not apply to the peer->us path and outlives the fnhe
- * for the whole connection.  See RFC 2923 section 2.3 and the comment above
- * tcp_advertise_mss().
- */
-static inline unsigned int ip_dst_mtu_configured(const struct dst_entry *dst)
-{
-	unsigned int mtu, res;
-
-	rcu_read_lock();
-	mtu = dst_metric_raw(dst, RTAX_MTU);
-	if (!mtu)
-		mtu = READ_ONCE(dst_dev_rcu(dst)->mtu);
-	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
-	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
-	rcu_read_unlock();
-
-	return res;
-}
-
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 					  const struct sk_buff *skb)
 {
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 5f47cef0b..95f936be3 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -396,43 +396,6 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
-/* Configured/administrative MTU of a route, for advertising the TCP MSS.
- *
- * Unlike ip6_dst_mtu_maybe_forward(), this ignores any ICMPv6-learned path
- * MTU (which is kept on the RTF_CACHE exception route) and returns the MTU of
- * the underlying route (fib6_pmtu) or the egress device.  The advertised MSS
- * bounds what the peer may send to us and must reflect our receive
- * capability, not a path MTU learned on the reverse (send) direction.  See
- * RFC 2923 section 2.3 and the comment above tcp_advertise_mss().
- */
-static inline unsigned int ip6_dst_mtu_configured(const struct dst_entry *dst)
-{
-	const struct rt6_info *rt = dst_rt6_info(dst);
-	const struct fib6_info *from;
-	struct inet6_dev *idev;
-	unsigned int mtu = 0;
-
-	rcu_read_lock();
-	/* IPv6 keeps the learned PMTU and the configured MTU in the same
-	 * RTAX_MTU slot: the learned value sits on this (possibly RTF_CACHE)
-	 * dst, the configured one on the underlying route.  Reach the latter
-	 * via ->from (fib6_pmtu), populated by ip6_route_info_create().
-	 */
-	from = rcu_dereference(rt->from);
-	if (from)
-		mtu = from->fib6_pmtu;
-	if (!mtu) {
-		mtu = IPV6_MIN_MTU;
-		idev = __in6_dev_get(dst_dev_rcu(dst));
-		if (idev)
-			mtu = max_t(unsigned int, mtu, READ_ONCE(idev->cnf.mtu6));
-	}
-	rcu_read_unlock();
-
-	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
-	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
-}
-
 u32 ip6_mtu_from_fib6(const struct fib6_result *res,
 		      const struct in6_addr *daddr,
 		      const struct in6_addr *saddr);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 595a3b7f1..93b9f4189 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1365,8 +1365,8 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 	net = dst_dev_net_rcu(dst);
-	advmss = max_t(unsigned int, ip_dst_mtu_configured(dst) - header_size,
-		       net->ipv4.ip_rt_min_advmss);
+	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
+				   net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 94e5ef1c4..5760a357e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3239,7 +3239,7 @@ void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	unsigned int mtu = ip6_dst_mtu_configured(dst);
+	unsigned int mtu = dst6_mtu(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);

-- 
Git-157)


