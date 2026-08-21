Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7B37DAC0
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331119; cv=none; b=BOxG6dVPya822Mut4p5a/pAKRUkCgjaRgdDUk8+vZac/Hi0u0V4nLleJhnK3iAWZxz1scCGHSrOySF7tQVIRCKfE+PZcQovj2+6TZRhEo7Emq588ezLHtt1pI1bx+otVo1BrubG5HVU+YkfwhyNNYAzQqvzKG7u6g9ZeiPdghJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331119; c=relaxed/simple;
	bh=FbMx9WLdv+cGtq+3igE1hy48bmS/Rh/e1tqayG12ee4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xxx2xULrB9L8bHpN1+bcUPbEpdtyRC5XAA+5RE9RQPzPXCJdJgXbRvkQLpCIbZmfDBUVgkFnxVeD1OgB68fm+zgbH200L5mq4fsI/EvV18wwMiBXIyftPTRMbW2/B7lKVWQFhDSxso4wbVCroEOXO6ZtUw4m950Kt6l6mFcPyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdMABJFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdMABJFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526F01F01564;
	Fri, 21 Aug 2026 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331109;
	bh=rts0cu4R07nnSk5wFexEzdjtN2WYJH5HJ2o6qQ3Ykbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RdMABJFAyrq1NWI68+m7MwMok8sZey1ncagX0yPfOWd/7FAvys2QS1Dz4Hyw8U3bJ
	 isMQqNAd6fvoqYqXkiOHKNkBjkwt3NgNAR8S6KYkym5oJbLaHWz+d7HSWRekTTPwr3
	 DRDQYWbKPcSf7SRaugHBS+vHAzzmor7fwytNeFHbFlzsiEut1FEVXwmz6JVs4qUe9R
	 pPHFioRTRbaKO1kRRdoggPk7DsCZrOGkneVUxESKosDECEVbVHEiHizU1BNZ6LHbNU
	 ri8mo98AVE+mVIipo7xVoqRk4o+PL8wNBUY/MzVbYPLLGVq4SFDZg307hlSTmIw/77
	 h7kNXaL6svRHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] ipv4: frags: remove ipq_put()
Date: Fri, 21 Aug 2026 12:51:44 -0400
Message-ID: <20260821165147.3593301-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821165147.3593301-1-sashal@kernel.org>
References: <2026081750-scion-darkened-b02a@gregkh>
 <20260821165147.3593301-1-sashal@kernel.org>
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
index 42a1f6b7acac2..28798cf7faea2 100644
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

