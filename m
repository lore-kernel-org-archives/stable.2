Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD513BB4A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154796; cv=none; b=gQsU2hyXHqJ0qldK1e9/kvyDckPZOIiy25Ra+JrVwV2BgqTym6JZ71SSuX14L2ctbd0VpdSbcoZfRr8zSeOeI2fBXGJ5Xyg2bCRo88QsTqY0Q+157wzByyybHB0QZ9JLH2x0DADIFTuaFfbRiMngoWhq6pMvV/z9LbVpwrGvDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154796; c=relaxed/simple;
	bh=Il5H0I5pmnyRYHS5/3AEaxnKnkQDB/GoJoHvuRqJSG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQdgm6/modaZfWL8rElTdqAeMnGMKpTF/pn2JyR6L+1wi80IDWiEeM479ZGQ8aCN5zTFXyv4jc6ZBiMIbJFXughdK3OVYacNAqr2HJfDV1kG8b9vy2Lpg7pQHALjxpPjEFAVum44Ha3bajf1JAid/ADY+wt47WEs0ocaV4eaG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fofJlbe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fofJlbe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E0D1F000E9;
	Mon, 27 Jul 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785154794;
	bh=S2e46e7dZvDuvX4Na9bQUuFvoSOoMQkHCx8U/In/ymo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fofJlbe9McJEJqPJuj44JRnC4RNSq8+te8Vq3kziJ+n+gO44DtBqMRpSg+83r6N6w
	 usE9fQs7J4zcYAQQZziap3m5pb2guQPT28jdVIAd7mbcif08vFX52Aat3ajtO7gkvC
	 +4ZaTX4zd68P67w1nN44j+zw/mmdK/zjeHO0EJ1PQIqqRDiRvftclQMrxDf/NuM2nA
	 iHYhcwuAIHgDpySpIHTLNzXFI64pi+LfuZ/rqqHYULMyJDL8Vi3n5XoxdmBtG/2L8H
	 Y1IwUB3RSvUgU9T5jvkbcLZ1a5pIrbjoKHAcoWKkE0YnUu0G6yRfmeACnbeQQ3g9Ch
	 N4jQqzJKZjJfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfrm: Use nested-BH locking for nat_keepalive_sk_ipv[46]
Date: Mon, 27 Jul 2026 08:19:51 -0400
Message-ID: <20260727121952.3778327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072015-entail-cartload-088d@gregkh>
References: <2026072015-entail-cartload-088d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 9c607d4b6589d4d380a85784514bcf4cceee1e11 ]

nat_keepalive_sk_ipv[46] is a per-CPU variable and relies on disabled BH
for its locking. Without per-CPU locking in local_bh_disable() on
PREEMPT_RT this data structure requires explicit locking.

Use sock_bh_locked which has a sock pointer and a local_lock_t. Use
local_lock_nested_bh() for locking. This change adds only lockdep
coverage and does not alter the functional behaviour for !PREEMPT_RT.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20250512092736.229935-7-bigeasy@linutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 226f4a490d1a ("xfrm: nat_keepalive: avoid double free on send error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_nat_keepalive.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 8a0379c8c41c8b..1856beee0149bb 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -9,9 +9,13 @@
 #include <net/ip6_checksum.h>
 #include <net/xfrm.h>
 
-static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv4);
+static DEFINE_PER_CPU(struct sock_bh_locked, nat_keepalive_sk_ipv4) = {
+	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
+};
 #if IS_ENABLED(CONFIG_IPV6)
-static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv6);
+static DEFINE_PER_CPU(struct sock_bh_locked, nat_keepalive_sk_ipv6) = {
+	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
+};
 #endif
 
 struct nat_keepalive {
@@ -56,10 +60,12 @@ static int nat_keepalive_send_ipv4(struct sk_buff *skb,
 
 	skb_dst_set(skb, &rt->dst);
 
-	sk = *this_cpu_ptr(&nat_keepalive_sk_ipv4);
+	local_lock_nested_bh(&nat_keepalive_sk_ipv4.bh_lock);
+	sk = this_cpu_read(nat_keepalive_sk_ipv4.sock);
 	sock_net_set(sk, net);
 	err = ip_build_and_send_pkt(skb, sk, fl4.saddr, fl4.daddr, NULL, tos);
 	sock_net_set(sk, &init_net);
+	local_unlock_nested_bh(&nat_keepalive_sk_ipv4.bh_lock);
 	return err;
 }
 
@@ -89,15 +95,19 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
 	fl6.fl6_sport = ka->encap_sport;
 	fl6.fl6_dport = ka->encap_dport;
 
-	sk = *this_cpu_ptr(&nat_keepalive_sk_ipv6);
+	local_lock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
+	sk = this_cpu_read(nat_keepalive_sk_ipv6.sock);
 	sock_net_set(sk, net);
 	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
-	if (IS_ERR(dst))
+	if (IS_ERR(dst)) {
+		local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 		return PTR_ERR(dst);
+	}
 
 	skb_dst_set(skb, dst);
 	err = ipv6_stub->ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0);
 	sock_net_set(sk, &init_net);
+	local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 	return err;
 }
 #endif
@@ -202,7 +212,7 @@ static void nat_keepalive_work(struct work_struct *work)
 				      (ctx.next_run - ctx.now) * HZ);
 }
 
-static int nat_keepalive_sk_init(struct sock * __percpu *socks,
+static int nat_keepalive_sk_init(struct sock_bh_locked __percpu *socks,
 				 unsigned short family)
 {
 	struct sock *sk;
@@ -214,22 +224,22 @@ static int nat_keepalive_sk_init(struct sock * __percpu *socks,
 		if (err < 0)
 			goto err;
 
-		*per_cpu_ptr(socks, i) = sk;
+		per_cpu_ptr(socks, i)->sock = sk;
 	}
 
 	return 0;
 err:
 	for_each_possible_cpu(i)
-		inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
+		inet_ctl_sock_destroy(per_cpu_ptr(socks, i)->sock);
 	return err;
 }
 
-static void nat_keepalive_sk_fini(struct sock * __percpu *socks)
+static void nat_keepalive_sk_fini(struct sock_bh_locked __percpu *socks)
 {
 	int i;
 
 	for_each_possible_cpu(i)
-		inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
+		inet_ctl_sock_destroy(per_cpu_ptr(socks, i)->sock);
 }
 
 void xfrm_nat_keepalive_state_updated(struct xfrm_state *x)
-- 
2.53.0

