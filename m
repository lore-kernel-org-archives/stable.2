Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B324949FA
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102449; cv=none; b=NbObBc+zvw0H1Le55Y8uBrYuigMYYRqt35FCMrmXq0t9jfLAP/DesfAOjX2SKqs+xMgm6mhnt7P609ikbD6kEYpWFOsWuQD/oGYAERz+Wk39RAMthFxf9xOGnTdpEduIRogCE4vten78I3JTrUAb4jEBCVcdPTnzk2msVYXGAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102449; c=relaxed/simple;
	bh=cL9Fy4xBMIDKPoN3rztaSZViN9++PFqvTrWy+uJ09WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Izi6tYmsnq2cMn4S9Ykm3MAPynDTfIfnOOvNMu9x8/EUs7uzbA3rjQ1mP7fcvEIaqO9qaVz0IBdzpu35cfDwX/C+EYHVa9+M9Q+J2cvqURD6HucyjDFP03OVM2QsfczzgMQSSLDGvRLJ0JETNy+N41O3bK1hFa7aMMuF0xpfI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFeOAwEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFeOAwEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0EF1F0089A;
	Tue, 22 Sep 2026 18:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102447;
	bh=hLaUuH6dHQb9McuvfqKoJU1STsO2YrgivwA2ovnO7yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aFeOAwEXV0wInIDSBECABlusMnVQYBPDnDh80btX2Ib2Cn7GdW3xcqprxOl9jLGS3
	 KgQB6sgirHxpcPTIInRtWFdJt1vLhgyVEZolopEz9s6fC9Nq5xDxV1r9KgNrFvm8iS
	 6QaMKNivyzwxhqEACUfpdfA6ONN6zGgNz6B8BOvPL93qKI53mKz/Wp8jsD3Hm7ouvF
	 WrkQzUIOhLwRQsAl95v+qVTntWCB5wCUe2JODhaRBe0HFFFV9DWX/9O8TPFV+EsihY
	 LwUcQKTQLUmzf1ghUQbEwTXleE02k9Ua3cWDn858xhwiIK5iCpVry89K3lGZIOhjjx
	 s+RB2rHl5VPGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dong Chenchen <dongchenchen2@huawei.com>,
	Xu Chunxiao <xuchunxiao3@huawei.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] xfrm: Fix dev use-after-free in xfrm async resumption
Date: Tue, 22 Sep 2026 14:40:42 -0400
Message-ID: <20260922184043.3743838-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922184043.3743838-1-sashal@kernel.org>
References: <2026092229-tuition-manmade-0086@gregkh>
 <20260922184043.3743838-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dong Chenchen <dongchenchen2@huawei.com>

[ Upstream commit 8045c0df98d4f14c54e5cb875f1c9c0ce89fe4ff ]

xfrm async resumption hold skb->dev refcnt until after transport_finish.
However, xfrm_rcv_cb may modify skb->dev to tunnel dev without taking
device reference, such as vti_rcv_cb. The subsequent async resumption
will decrement the tunnel device's reference count, which lead to uaf
of tunnel dev and refcnt leak of orig dev as below:

unregister_netdevice: waiting for vti1 to become free. Usage count = -2

Stash the original skb->dev to fix refcnt imbalance. The new skb->dev set
by xfrm_rcv_cb can race with device teardown. Extend rcu protection over
xfrm_rcv_cb and transport_finish to prevent races.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Reported-by: Xu Chunxiao <xuchunxiao3@huawei.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

[5.15 dependency adaptation for 3cf5cdecd99c]
The prerequisite 1c428b038400 is absent here. Retain the device reference
on async re-entry and release it at each final exit or when handing off
to another async operation. Always use the saved original device and
extend RCU protection across the receive callback and packet handoff.

Keep the 5.15 inner-mode API and unconditional skb_dst_drop calls. The
IPv4/IPv6 transport_finish dev_put removals and asynchronous inner-mode
hunk do not apply to this tree. Use props.family for transport_finish;
state initialization requires matching inner and outer families in
transport mode, so this preserves the existing family selection and
provides the context for the target's saved-family replacement.

To prepare for the target without introducing SA-direction support,
validate the destination before publishing the lookup reference in the
secpath. If it is unavailable, retain the output mark update, reset the
partial secpath, release the lookup reference and clear x before drop.
The existing XFRMINERROR accounting remains; resetting the secpath also
prevents callbacks from inspecting a partial path after the state is
released. This lets the target's x = NULL protocol-fallback hunk merge
into this applicable error path instead of the absent direction check.
No functions or new XFRM features are added.

[ sashal: Reduced backport -- upstream 8045c0df98d4f touches 3 file(s), this
  backport carries 1. Not backported here:
  net/ipv4/xfrm4_input.c
  net/ipv6/xfrm6_input.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 3cf5cdecd99c ("xfrm: save input state data before secpath resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 44 +++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index b310a0d3bc93f..a9855cb118186 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -469,6 +469,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	const struct xfrm_state_afinfo *afinfo;
 	struct net *net = dev_net(skb->dev);
 	const struct xfrm_mode *inner_mode;
+	struct net_device *dev = skb->dev;
 	int err;
 	__be32 seq;
 	__be32 seq_hi;
@@ -494,7 +495,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					       LINUX_MIB_XFRMINSTATEINVALID);
 
 			if (encap_type == -1)
-				dev_put(skb->dev);
+				dev_put(dev);
 			goto drop;
 		}
 
@@ -503,7 +504,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
-			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			spin_lock(&x->lock);
 			goto resume;
@@ -597,16 +597,21 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-		skb->mark = xfrm_smark_get(skb->mark, x);
-
-		sp->xvec[sp->len++] = x;
-
+		/* Validate the destination before attaching this state. */
 		skb_dst_force(skb);
 		if (!skb_dst(skb)) {
+			skb->mark = xfrm_smark_get(skb->mark, x);
+			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINERROR);
+			xfrm_state_put(x);
+			x = NULL;
 			goto drop;
 		}
 
+		skb->mark = xfrm_smark_get(skb->mark, x);
+
+		sp->xvec[sp->len++] = x;
+
 lock:
 		spin_lock(&x->lock);
 
@@ -646,13 +651,16 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		if (!crypto_done) {
 			spin_unlock(&x->lock);
-			dev_hold(skb->dev);
+			dev_hold(dev);
 
 			nexthdr = x->type->input(x, skb);
-			if (nexthdr == -EINPROGRESS)
+			if (nexthdr == -EINPROGRESS) {
+				if (async)
+					dev_put(dev);
 				return 0;
+			}
 
-			dev_put(skb->dev);
+			dev_put(dev);
 			spin_lock(&x->lock);
 		}
 resume:
@@ -718,9 +726,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		crypto_done = false;
 	} while (!err);
 
+	rcu_read_lock();
 	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
-	if (err)
+	if (err) {
+		rcu_read_unlock();
 		goto drop;
+	}
 
 	nf_reset_ct(skb);
 
@@ -729,7 +740,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		if (sp)
 			sp->olen = 0;
 		skb_dst_drop(skb);
+		if (async)
+			dev_put(dev);
 		gro_cells_receive(&gro_cells, skb);
+		rcu_read_unlock();
 		return 0;
 	} else {
 		xo = xfrm_offload(skb);
@@ -737,26 +751,28 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			xfrm_gro = xo->flags & XFRM_GRO;
 
 		err = -EAFNOSUPPORT;
-		rcu_read_lock();
-		afinfo = xfrm_state_afinfo_get_rcu(x->inner_mode.family);
+		afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
 		if (likely(afinfo))
 			err = afinfo->transport_finish(skb, xfrm_gro || async);
-		rcu_read_unlock();
 		if (xfrm_gro) {
 			sp = skb_sec_path(skb);
 			if (sp)
 				sp->olen = 0;
 			skb_dst_drop(skb);
 			gro_cells_receive(&gro_cells, skb);
-			return err;
 		}
 
+		if (async)
+			dev_put(dev);
+		rcu_read_unlock();
 		return err;
 	}
 
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	if (async)
+		dev_put(dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
 	kfree_skb(skb);
 	return 0;
-- 
2.53.0

