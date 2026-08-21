Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FC435A86
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323770; cv=none; b=i0mW6dFh8H5wCL17DU/8itQQN5sjS/ihzqYDDmh2VCVdQQs7PIN4P+JMZqFjXbM4m/z+49rVet4DjnN2AthZnIOWMx6IjB1iviVw1Lo9s1lChRNo6YOffJio4vTjTOwNRi6raHIA8YNgok0Q6H7iwQ/vwaL6kFj12bXA8LzqjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323770; c=relaxed/simple;
	bh=IrfsoYqBF2eQPB8jqwltjMzVvEbj+hkuP+RK9CGdsXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4OEqZby4xrGh9J9epbaxxUl2SsU2rVftv5wW2XLpnjyr+3TfgQ+SiBYAkbn/ruxPPWy4p2jphMDFJQnDlXt2gGM2GetM4ESebH8m9MM4rmA0RWEhgXh8TsaxFZdhUV1z8qVq7uJvMpOZoyJHuJDTnE3+BBA6eLCxG/ptDvPYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9z/nj8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9z/nj8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6401F00A3A;
	Fri, 21 Aug 2026 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323769;
	bh=BMNSYxm5kR8uqiUaIhOZXeHEnvGpP+4LXFadn9psDDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N9z/nj8poPa37gq3jzQyJlQH/uzyUonzSTIRDdxRwib0EaTFETCRVe8LMykFAhQST
	 U328GI53FI28/v0YvXyWRh6kDvYnwXkvrNICoeTsKrWdgtJPoAFsqcQFPfUY7pQdoJ
	 yjw5AY65DMg3bXw4iLs1mkclABqEetU7ZzNAabMYlDZqINL9ivNy11Lcr0iLtcQiPe
	 O3JBj7KF7ZTeRUiNN5TfFBtp9yTmeT/XMbbQrxMI+98tJ2rcJzGRMEULJ+71+pAyqO
	 aSNMicdOCT0Zx+QejXeLO5g6HAU1EatfZllfu7D4bI5ZxPv8FVVvX/Tnaaj+SDGtIx
	 zHa5BwcGIaMYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] ipv4: frags: remove ipq_put()
Date: Fri, 21 Aug 2026 10:49:23 -0400
Message-ID: <20260821144926.3428433-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821144926.3428433-1-sashal@kernel.org>
References: <2026081749-cash-armed-755d@gregkh>
 <20260821144926.3428433-1-sashal@kernel.org>
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
Stable-dep-of: 653d7ddf6cba ("inet: frags: publish queues before arming timer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_fragment.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index b3c5ca0ad156e..460e140f9648b 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -107,14 +107,6 @@ static void ip4_frag_free(struct inet_frag_queue *q)
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
@@ -142,6 +134,7 @@ static void ip_expire(struct timer_list *t)
 	struct sk_buff *head = NULL;
 	struct net *net;
 	struct ipq *qp;
+	int refs = 1;
 	int err;
 
 	qp = container_of(frag, struct ipq, q);
@@ -203,7 +196,7 @@ static void ip_expire(struct timer_list *t)
 out_rcu_unlock:
 	rcu_read_unlock();
 	kfree_skb_reason(head, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
-	ipq_put(qp);
+	inet_frag_putn(&qp->q, refs);
 }
 
 /* Find the correct entry in the "incomplete datagrams" queue for
@@ -492,14 +485,14 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
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
 
-- 
2.53.0

