Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47234915BC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908050; cv=none; b=mYk/87cbYFcnUbIrat0sgeK8KOou9JbWEcOJEV/nAye2Am0itCIbFX5rZvGBk569WfJ7cvEdkmElK1PZxWHGS0BMlgad8hvcjEBYpejUkc4UuV6Qf5JU0ajFg9Riz5jhldvnqktSClXLRp7NiRHcms0zxZ6idinWsrH9PW7HawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908050; c=relaxed/simple;
	bh=P4pzRqX9+JiI+AdjvA0X0fHe/uENMGgcd93q8wEoCpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEjAmAR+K9RP3oxPX1V70vlA0ZcXoLyAXWF2L4plrtZTswsG5HnLVpRDEkTALGcEm5l8chYr5rc6pGVDXPiNGdHkoP4wrLOpbSjTnZqGi9mVFv4lks9uKDQzORhTinXr32YDmakbotut67xDotAOzS8fjxT/EMHkoR2BtpaHKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX3pMwHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX3pMwHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4640E1F00A3A;
	Tue,  8 Sep 2026 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908048;
	bh=sfMJPRdH5JWN0GgCB8QRkD9u/i036gsKf9rk+j/rNXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GX3pMwHk1ZHlnK0jQclwcQ5fE2J3LzrDTvzJbT+R3isLBgDECOpWQczDiym+b5Pj4
	 WTKCd8bNp+s1S2sUISSd4m/vY5SSCcbVEP0kGcZHq9S/cGHZS+Z2aGCmCa5ONPpxUo
	 kzqh/NT92Hv6PuFx3lQZq0H89VUrsCTVkiQ2D8euvC3R2f1lWwZAF71pnbRI4Uipxs
	 Z/qrefZdRSMEgRGJ0NZu92sUXAX8zSolMFAqSQDn36u7dVc7WF4n/ZefgfRUn4xWWw
	 IYEWfi5oA3eTZ/v2FcB/+veI2bA96cAwJr2IALvODgTzoSSadIO+eLkPq//7LnnWKh
	 k6b7V7qy4M37A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ipv4: frags: remove ipq_put()
Date: Tue,  8 Sep 2026 18:54:05 -0400
Message-ID: <20260908225406.538697-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908225406.538697-1-sashal@kernel.org>
References: <2026090319-antiques-palm-c286@gregkh>
 <20260908225406.538697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a2fb987c0ecf0498cc17056339cb11d128c46ab7 ]

Replace ipq_put() with inet_frag_putn()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250312082250.1803501-3-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

For the stable backport, retain the existing ip_expire() error and skb
freeing paths.  Also brace the multicast delivery conditional so that
the dependent fix can add its non-local skb orphaning without conflict.

Stable-dep-of: e36ce6e78fe3 ("ip: orphan prefetched skbs before multicast forwarding")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_fragment.c | 15 ++++-----------
 net/ipv6/ip6_input.c   |  4 ++--
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 11dedc82b98da..34e85c552ac36 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -102,14 +102,6 @@ static void ip4_frag_free(struct inet_frag_queue *q)
 		inet_putpeer(qp->peer);
 }
 
-
-/* Destruction primitives. */
-
-static void ipq_put(struct ipq *ipq)
-{
-	inet_frag_putn(&ipq->q, 1);
-}
-
 /* Kill ipq entry. It is not destroyed immediately,
  * because caller (and someone more) holds reference count.
  */
@@ -138,6 +130,7 @@ static void ip_expire(struct timer_list *t)
 	struct net *net;
 	struct ipq *qp;
 	int err;
+	int refs = 1;
 
 	qp = container_of(frag, struct ipq, q);
 	net = qp->q.fqdir->net;
@@ -195,7 +188,7 @@ static void ip_expire(struct timer_list *t)
 out_rcu_unlock:
 	rcu_read_unlock();
 	kfree_skb(head);
-	ipq_put(qp);
+	inet_frag_putn(&qp->q, refs);
 }
 
 /* Find the correct entry in the "incomplete datagrams" queue for
@@ -484,14 +477,14 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 	/* Lookup (or create) queue header */
 	qp = ip_find(net, ip_hdr(skb), user, vif);
 	if (qp) {
-		int ret;
+		int ret, refs = 1;
 
 		spin_lock(&qp->q.lock);
 
 		ret = ip_frag_queue(qp, skb);
 
 		spin_unlock(&qp->q.lock);
-		ipq_put(qp);
+		inet_frag_putn(&qp->q, refs);
 		return ret;
 	}
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index cf577cc3b48cf..94d2ab8689d88 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -552,9 +552,9 @@ int ip6_mc_input(struct sk_buff *skb)
 			/* unknown RA - process it normally */
 		}
 
-		if (deliver)
+		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
-		else {
+		} else {
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.53.0

