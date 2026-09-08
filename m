Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D31596512
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907023; cv=none; b=VlcVd6K+gijCBr3mzrHuyGbMRoWEMTKpKmhbXqjkZiC3jyHzXepKDGo9jFGnnqJ0+w17e+rYeASdsRiDrwgWPFsYxBlBS0V4nKACP9HbCS6TvaZtVqtFfR+AUzGCvn1TES/BXlT3r+jhIxZFDXIeM6RpnUO2e27Co8vw0b0YkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907023; c=relaxed/simple;
	bh=USMFSyfOHS+7OCW9ClanEymsGcDYdgN14J7VIZXGylI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VawI0fsi5tXCqfK1Saov/85HIx/cAtJzO8LM+cOpKcPxHY0TWYlAupnCGB2GrPcvrTj14X98kL6dw6Ihgfw84/zT9CoTP8fy7jxzVqgNw4Kig1kzpHVyIdON9K/nsyxOqqwtZK+TRnghHUxLgjV4FiRnBoW/XNSgTbv7JTQC1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozP1r6q2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozP1r6q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEFB1F00A3F;
	Tue,  8 Sep 2026 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907019;
	bh=1AGcZdbzOkV+mQkb6uPT/H/LLX+oL1MXQdUIuOs1sJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ozP1r6q2cwYLOmC70kj3jPTOREd33I/THGK14V4EKTCWQySk5ZnDMORrwAmKzX7cK
	 4qSQiOoe9QzP3V0KcmrMwPYQq4Z/u4igtrtYnn/snPOv5Wknrk+wfNbmloK+Ywz3I4
	 CjCH2fLAkillbcO4i99wx/28qBcdVNc2FXGcyj2kiCwkCAPneA7t+56BytZ2KAELHx
	 LH8gAzxqu71fhQCQmXNgb6I4YiY2mw47xbZp3wadLVrzlQUSIADxicmbdpIzz7Qpsr
	 W/bbxSPgjy9oOfKNOI/+qQ42Q6KD6NOGH9K0dpnVpaWhCvuC7wc8rnaX0uemCV0dDw
	 4H4Nhfp7xka3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ipv4: frags: remove ipq_put()
Date: Tue,  8 Sep 2026 18:36:56 -0400
Message-ID: <20260908223657.503197-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223657.503197-1-sashal@kernel.org>
References: <2026090319-football-expel-7883@gregkh>
 <20260908223657.503197-1-sashal@kernel.org>
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
index dd1258d0ad051..5985cbe027348 100644
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
@@ -143,6 +135,7 @@ static void ip_expire(struct timer_list *t)
 	struct net *net;
 	struct ipq *qp;
 	int err;
+	int refs = 1;
 
 	qp = container_of(frag, struct ipq, q);
 	net = qp->q.fqdir->net;
@@ -200,7 +193,7 @@ static void ip_expire(struct timer_list *t)
 out_rcu_unlock:
 	rcu_read_unlock();
 	kfree_skb(head);
-	ipq_put(qp);
+	inet_frag_putn(&qp->q, refs);
 }
 
 /* Find the correct entry in the "incomplete datagrams" queue for
@@ -490,14 +483,14 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
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
index 1ba97933c74fb..a341427a5fa43 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -569,9 +569,9 @@ int ip6_mc_input(struct sk_buff *skb)
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

