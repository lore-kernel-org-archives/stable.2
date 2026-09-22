Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBB47C105
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102088; cv=none; b=Ho5RDHccg1On83myNyjXfJf57N/qI4IVROUKVzTtr/ZpJGklAU/0lvab6BMHBUU6q6xcFZ/x+XQOaEUjlhu4piH9aztdXHIx0oFqiE6ojVQ+/5anr3z1kgdbdk65pPk9uLeP+Cn2SIN4OM98MQRkijepzpaayQ46mJHvgHmpfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102088; c=relaxed/simple;
	bh=gWEYauroTf8hpPfsq2p+P/XTsZaBG6lP7u2dZLfIe40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsz/rVJJCimWM9yNueN1IV4r4+dmco8e5jPbNHQVT8TqT0n4O9Nm05JfwLYoUK7gPm3gcJKKuIU6QtsyCIwUzDfXVJ8mNVv+r4EeID5ndCih0mBwIZWFl0MNujKt4jDnX9cXxNDPOew5tH9mB+zb0B1mxbQ/UkeFEvfBA9A7dDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/HnwHdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/HnwHdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DFB1F00899;
	Tue, 22 Sep 2026 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102086;
	bh=423/pbPTOhsfgeMrmXhigAWESy1QcEnREFgPjWdrDhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/HnwHdx8UFfKLsMu6o2aHC6cfu65/vVAGTT03NcwQDyO9VFB103I6PYtx854DVC3
	 MFyJg99S+o2hsSPgjCoCueN+KJwcHZUOA5UTHJ3tCqZELoYjOVnrfMH6GBnITDvDa9
	 4fAExhYJg2XqoJm/UdK4PYmo73tzKgqLAvIls0/MwTFs60SUdEJc2rqKnUdnP6aWNG
	 bdfoet0sgFGI021bocHif8s70maxAZxPk0sdDzQzenPubVAM5ITQVPolHZpFOW/EEb
	 GCBU6j2UwGGHHsN/l15i6TNv3pNXgizMkYs++l+u08bgK+AOdvLYkX0CP3quWtMjLG
	 fWNAKY9sYStZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dong Chenchen <dongchenchen2@huawei.com>,
	Xu Chunxiao <xuchunxiao3@huawei.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] xfrm: Fix dev use-after-free in xfrm async resumption
Date: Tue, 22 Sep 2026 14:34:41 -0400
Message-ID: <20260922183442.3692649-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922183442.3692649-1-sashal@kernel.org>
References: <2026092228-detective-absolute-febb@gregkh>
 <20260922183442.3692649-1-sashal@kernel.org>
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
index 39e149a87cf0b..fb291d2954435 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -470,6 +470,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	const struct xfrm_state_afinfo *afinfo;
 	struct net *net = dev_net(skb->dev);
 	const struct xfrm_mode *inner_mode;
+	struct net_device *dev = skb->dev;
 	int err;
 	__be32 seq;
 	__be32 seq_hi;
@@ -495,7 +496,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					       LINUX_MIB_XFRMINSTATEINVALID);
 
 			if (encap_type == -1)
-				dev_put(skb->dev);
+				dev_put(dev);
 			goto drop;
 		}
 
@@ -504,7 +505,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
-			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			spin_lock(&x->lock);
 			goto resume;
@@ -598,16 +598,21 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
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
 
@@ -647,13 +652,16 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
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
@@ -719,9 +727,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
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
 
@@ -730,7 +741,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
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
@@ -738,26 +752,28 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
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

