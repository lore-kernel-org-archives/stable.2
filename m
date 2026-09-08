Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8D3BCD10
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908551; cv=none; b=j2+GR/BVQu35IIYsUTbjZZRJZobLnio0VkHy0e+JW+xv460RMJ1GFZozgPmktnfc4uITitmjEJqf/v+PtFOtCkcOG8NRcXwT58hHtBDc1aOKBTXX4Gy513JJC/1lt+Hcp432ihO4c4gxWwOuEg0FRep3CdV1foIR08sp0LzG1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908551; c=relaxed/simple;
	bh=VF2NZH3NIlbg+caI2iau9a6eHhwYQz4TB/dLxyBGvu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKC0/HjFXeveYhMnSOJxUhfZrBf9l+Kuh5W3dkf1J878/k0RylGHZ4UIkQy5c0IThSakpUWXbA+a1CmUOjtQl8NR7EPtOibVyiWOxL/mJvdyMCWG8dKvVgEtiuMHi0IXakfRUX+1jK+ThulY10zmlGwuOUSMPnFgXkEQBaPSaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuxL3sxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuxL3sxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8E81F00A3D;
	Tue,  8 Sep 2026 23:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908550;
	bh=OS1ay9dDb0G+H5pFZ8MnfZ5HQleP4ieAznuanRM3NOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MuxL3sxBQ4Q9udLPPRsqDqhd3b5qrjA/rxqQ6yJjeJA+c46/q3DLSsOKgYHnnuogQ
	 hogeHjYr/eqTX3yNrBxEriCxZHWiqx+4Xeol9q3KRRw/Wh3ol9tOMYSb7O2F4XK2V/
	 gzGcKYdvq9XwTIG09LnKM4mQpw3e8V4/SRZKUncLWGGxt9UcHGog6bwjm7AM1gfFaW
	 bOdJKebsIx02P9kKjrK9lgBkR0HDyVITJlC1cFSIs1YPPlTH5BFnJnzy2faIVU82w3
	 xpyz9icaarSknEZ4Xs5DnKNKLupwIU0riPA64Hh2VYZhS4mtU5M5Zr42BbCNFo4Mcu
	 swYQ0E0DvWwKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] ipv4: frags: remove ipq_put()
Date: Tue,  8 Sep 2026 19:02:26 -0400
Message-ID: <20260908230227.559723-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908230227.559723-1-sashal@kernel.org>
References: <2026090320-tiptop-scrooge-9ea0@gregkh>
 <20260908230227.559723-1-sashal@kernel.org>
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
index f24e498dd1efc..53186d06fb27a 100644
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
index 8cf5b10eee695..493666b0c6098 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -554,9 +554,9 @@ int ip6_mc_input(struct sk_buff *skb)
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

