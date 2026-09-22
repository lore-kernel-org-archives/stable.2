Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE340DB20
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099463; cv=none; b=VPnCsFTqec3Lv2pGM9c6gchKyoqUm0oO2LKeGNzwasHrzznAbOlgab36Gx8BhaXzTXP5+duEQJ+/EyaJ0u/dKQv6dxZk/JGGk62pQsGF0Uyr5drmv7q9hmx8WdKE7Ml+ZOZW/HWPGtjvRIsllSg8gMvLtIPktwH1g/Z5XpLQjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099463; c=relaxed/simple;
	bh=VR5tFn3rSX7//VD301sT6UCne+8HG8+J1jyY2RsKEIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9bIdgsHqTB8jmGeCQFNKA0nP4hPSe+Xt1ASg5YsqoI5yYGr8SbFZRZgVBA/FkaqViVThSObCt4H4NYmZgCgaRZDbgoDdRlVBuPVgGCisrFWipiwVAO4nXDVKtFxrKGQiEcY438qYtPwvadivDmSjpAHd/hXCam2FkbZMZRIuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWeJLqe5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWeJLqe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331681F000FF;
	Tue, 22 Sep 2026 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099461;
	bh=S9oBD45P8SyruGvgdh+CRPLKdbAtvZSrzWc/XbEhpqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iWeJLqe57bdHXznEPl0rUMDWVvemJuB28rbDU5G4DYUZtwQxD23AKEbjtqFxj7V0T
	 f6BQqXcDUYbSEeyIXsCYO45TtdjD+DNxV3JKS9hfkettKhhVjrLlcmagSLTsWRZaDn
	 PG8X2QfETFpPXPSSr2nSrFmRzbLbnV16R+0kwWFP8Z1BPwcHJ6r5JosBuD017mVqqz
	 ZdwhvE+lcfJNDVk5orRWrBMcWF89dMA8e5b9cLPNKjsRq5kYui/8pXEo4KRCNs6Hr2
	 wO/duAvErPnUne/o1u5bKom1IOp0QtEppvOelX/h4LTD6G7N5/WGEdJlhDpJLzu0Od
	 Ptf89AWpieERg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfrm: save input state data before secpath resets
Date: Tue, 22 Sep 2026 13:50:59 -0400
Message-ID: <20260922175059.3307828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092227-quarry-haggler-ba0c@gregkh>
References: <2026092227-quarry-haggler-ba0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 3cf5cdecd99c9c186a5ea518d93bbf3045b6e3aa ]

xfrm_input() stores the current xfrm_state in the skb secpath while it
continues receive-side processing. Some input paths can reset that secpath
before xfrm_input() has finished dereferencing the state.

Receive callback users such as VTI and XFRM interfaces can reset the
secpath. The VTI receive path does so before checking whether the packet
crosses network namespaces, while the XFRM interface path does so only for
cross-network-namespace packets. The XFRM_MAX_DEPTH error path can also
reset the secpath before the final drop callback reports the current
state's protocol.

If secpath_reset() drops the last state reference while the state is
concurrently deleted, xfrm_input() can still dereference the freed state
when selecting transport_finish() or reporting the drop callback protocol.

Save the state protocol on the stack while the state is still valid,
and use the already saved address family for transport_finish(). A larval
XFRM_STATE_ACQ state has no type, so retain nexthdr as its protocol. This
preserves the existing drop-path fallback while avoiding the post-reset
state dereferences without adding an extra state reference to every
received packet.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ omitted the protocol fallback assignment for the state-direction rejection branch absent in 6.6. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 1483770f84564..26f2fd7e01da9 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -462,6 +462,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_state *x = NULL;
 	xfrm_address_t *daddr;
 	u32 mark = skb->mark;
+	u8 xfrm_proto = nexthdr;
 	unsigned int family = AF_UNSPEC;
 	int decaps = 0;
 	int async = 0;
@@ -472,6 +473,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0))) {
 		x = xfrm_input_state(skb);
+		xfrm_proto = x->type ? x->type->proto : nexthdr;
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
@@ -572,11 +574,13 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		x = xfrm_state_lookup(net, mark, daddr, spi, nexthdr, family);
 		if (x == NULL) {
+			xfrm_proto = nexthdr;
 			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
 			xfrm_audit_state_notfound(skb, family, spi, seq);
 			goto drop;
 		}
+		xfrm_proto = x->type ? x->type->proto : nexthdr;
 
 		skb->mark = xfrm_smark_get(skb->mark, x);
 
@@ -693,7 +697,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		crypto_done = false;
 	} while (!err);
 
-	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
+	err = xfrm_rcv_cb(skb, family, xfrm_proto, 0);
 	if (err)
 		goto drop;
 
@@ -714,7 +718,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		err = -EAFNOSUPPORT;
 		rcu_read_lock();
-		afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
+		afinfo = xfrm_state_afinfo_get_rcu(family);
 		if (likely(afinfo))
 			err = afinfo->transport_finish(skb, xfrm_gro || async);
 		rcu_read_unlock();
@@ -734,7 +738,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
-	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
+	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.53.0

