Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047271;
	b=AEWbR2+sTO28EQK8rXPAUzxl2esWXdtDYeOrzJ9coBvqzYZY3tul8my/19wS4n5SOPXZ
	 WNbNUeLN6l5Q1sty+1RB2Tr+u1MempgIGcxz/nQT3JNlrOg8gdQUo+2Fzrosd2jtKSS+Y
	 bpaQwdkFwAOspJrnzO740iAYIKEHG0Hc2BZfCfEAkwA2qvlxrun6VsiOIuBocKXDJPTEC
	 HoPCvvIZNKs5nYPAfcAuYod7WxS0zUNCQA+u59LYQHnl0op0oWBB94vJBnYSmdACUKqIg
	 lUGse/pjq5iA4x9a/ZB36AvXrpnWL6yTtyMI9LmOyp/Mn1Zf/0U0l6n1Ixsav9wZGqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QspNNbJL3e449/5O0gk+AVtS68AvgElj3aYDnQwrUhg=;
	b=peh8CjBOsQ4y9IHbHIWe9iNaZSIMU06lnKEFJ2t60SiLqKL+iaTjjBtnyRC+3hpnCpxU
	 O1O2n3ghCECAts3dhXI7iONzG05RFlcsNsklbMaGU+xjePfx83nFimQ9XlGh/udiwwtzc
	 wue2krV6lXdOVOMSDgNNdDBe80kdDIjO65CQXTb9UowTgEaaNqtzV5+Er7cYAGTr8JtQx
	 svkpX12zgaCqJmf2OmfLB76gFzi2etfiy9wbqababo4RUicvvtRs37VdNaYN8iAMo5JkB
	 G/iXqnR06KLFtCwvzdonyWtQDqzeLJG3OBWURIeolraTHmpL8I6atIqMAR0VC4SUHzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ym2ROt9M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ym2ROt9M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28551F008A1;
	Sat,  7 Nov 2026 10:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047271;
	bh=QspNNbJL3e449/5O0gk+AVtS68AvgElj3aYDnQwrUhg=;
	h=From:To:Cc:Subject:Date;
	b=Ym2ROt9MO7im3KCMCDg9grGtNzICo6hz8QqKaKu6Ss6H3jw8HfGFAbc0khCwemrtu
	 3l071fLzPRk2HggN7wS1PHzmebu82hkTfIQ0WEP82KcZ5FllIl2oWkAR/m5DQlcTtC
	 fPcXoo2v6WqKquYZST2iEd5fBNXyiUPf/ko4OtxrtNjYijJ6JiqXOHAFt1eiA+/sqQ
	 +BPXddWIzKRpZozHJp2qAmcLD722whfOcvaBYb51ZJ4Vor7C+nFqWXYaBRvVnsBu0U
	 V1r/bZ879HnzdbNS6BBc5yRlmjGPni0S9XZXpV7NL8gKkv+UieZEo9ut+bf82fhK61
	 hlDgKkt6CxmbA==
From: Sasha Levin <sashal@kernel.org>
To: echoowall@gmail.com,
	edumazet@kernel.org,
	jiayuan.chen@linux.dev,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Revert "net: advertise TCP MSS from the configured MTU, not the learned PMTU"" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:49 -0500
Message-ID: <20261107052749-failed-6.12-564313447e54@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 564313447e545eea13038f74ada9272ab129b3cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052749-failed-6.12-564313447e54@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 564313447e545eea13038f74ada9272ab129b3cb Mon Sep 17 00:00:00 2001
From: Yongjian Wang <echoowall@gmail.com>
Date: Mon, 26 Oct 2026 15:23:09 +0800
Subject: [PATCH] Revert "net: advertise TCP MSS from the configured MTU, not
 the learned PMTU"

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
Closes: https://lore.kernel.org/regressions/4F0FAEB6-A13B-47F3-BFF1-C706686C6F64@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Yongjian Wang <echoowall@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/ip.h        | 25 -------------------------
 include/net/ip6_route.h | 37 -------------------------------------
 net/ipv4/route.c        |  4 ++--
 net/ipv6/route.c        |  2 +-
 4 files changed, 3 insertions(+), 65 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 618b9806c10b0..0acc4ba5e5b34 100644
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
index 5f47cef0be469..95f936be32c6c 100644
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
index 595a3b7f17830..93b9f41895257 100644
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
index 94e5ef1c4f83e..5760a357e6e7f 100644
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
2.53.0




