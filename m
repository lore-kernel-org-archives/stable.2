Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22CF3C1998
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102089; cv=none; b=KSsS6Iz1zs5o8pbyH6SrLoSv81DWHJqJZeCB6QBPsjW/bHD1Mt+dBtA9X5r8YYoXg4fSS9lg9RQvyZodhXaqX8caA9kYCFxlSsLOqNX2CPOb171zQFtHsjeoyUdkxKlHtEclkw5GQrxF2JatCKnP7sCDUXVtk8cBFyzQo4cdVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102089; c=relaxed/simple;
	bh=lBmRoRblKEEmrcGnDP1hIRZPyffcH99C0XLoNAypCEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaRNd4JG02WULs8B4o+jQ9iBkMee7eE827VVRcVupahteQPBzuwhm6ejgj7JEI0O1ci8OgN9WWMdIQifa98AFb70sC88j9fFpgDy2bMNPbE2QmnJhrVtA37kTqHXlXqN1qRG4JoGkkuUIDP+OIVTzQol8XkazpwmHPuGl7RRdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlO1Onqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlO1Onqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01DD1F000FF;
	Tue, 22 Sep 2026 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102087;
	bh=TDJGDboBcMvQ19bNsDhzxuEhiNH3uwaXsqD5+yK4a10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZlO1OnqjPRSOMy4tZaW81pBH6ERQXjxaU+w+x7OlP1kd0cqFjdXW1f3vgrCHMq2X/
	 1/NXhgpEyQyJqBGthy/M2S/6FTw7mkUDh0SUrNBJM1gpJrrzaMKZbGoiUsME8S5oa+
	 Iq9KLfYOMwxCyx0uTpmgY4Uf+yvimvnvSXfLCieJ3mwWTPx2l70cY8m2TmmAlEeYk2
	 aV0Uf+yJMGS8Xle6xhnZOWc44ZN//mYQBNqyp8x+JMvCkxLBv0zaT0EQhBTW8QF5ge
	 c5kSC6NaoOsikJj1l9vrgs9nc2JC6H8JwfFHIi54KZNoF3YTUzLLG3gEn0IGAyIw0t
	 /67LwOX6S9wyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] xfrm: save input state data before secpath resets
Date: Tue, 22 Sep 2026 14:34:42 -0400
Message-ID: <20260922183442.3692649-4-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index fb291d2954435..b1197607ceecb 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -477,6 +477,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_state *x = NULL;
 	xfrm_address_t *daddr;
 	u32 mark = skb->mark;
+	u8 xfrm_proto = nexthdr;
 	unsigned int family = AF_UNSPEC;
 	int decaps = 0;
 	int async = 0;
@@ -487,6 +488,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 	if (encap_type < 0) {
 		x = xfrm_input_state(skb);
+		xfrm_proto = x->type ? x->type->proto : nexthdr;
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
@@ -592,11 +594,13 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		x = xfrm_state_lookup(net, mark, daddr, spi, nexthdr, family);
 		if (x == NULL) {
+			xfrm_proto = nexthdr;
 			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
 			xfrm_audit_state_notfound(skb, family, spi, seq);
 			goto drop;
 		}
+		xfrm_proto = x->type ? x->type->proto : nexthdr;
 
 		/* Validate the destination before attaching this state. */
 		skb_dst_force(skb);
@@ -606,6 +610,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINERROR);
 			xfrm_state_put(x);
 			x = NULL;
+			xfrm_proto = nexthdr;
 			goto drop;
 		}
 
@@ -728,7 +733,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	} while (!err);
 
 	rcu_read_lock();
-	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
+	err = xfrm_rcv_cb(skb, family, xfrm_proto, 0);
 	if (err) {
 		rcu_read_unlock();
 		goto drop;
@@ -752,7 +757,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			xfrm_gro = xo->flags & XFRM_GRO;
 
 		err = -EAFNOSUPPORT;
-		afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
+		afinfo = xfrm_state_afinfo_get_rcu(family);
 		if (likely(afinfo))
 			err = afinfo->transport_finish(skb, xfrm_gro || async);
 		if (xfrm_gro) {
@@ -774,7 +779,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop:
 	if (async)
 		dev_put(dev);
-	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
+	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.53.0

