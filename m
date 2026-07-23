Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7353812FB
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816359; cv=none; b=Bt1vbzfYn0HRS/RrFgSSLhPZlrXP/PVQvP205L1fxVvLC7DJ3m5BaZ4ehrsDcUUohLp1/utfg0ClSMBvG9uSYi+cJ0l5bFrRjxPmrMxBQu/57gBhznkKJnCFUAKrMQT3jJMBk+uBqCTJfPsAVDuQ+duYo/zXa3Wzs/bfzDB2M78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816359; c=relaxed/simple;
	bh=qjQ0UE9+7iRxcWSXC1AvgZRDNWAPlQORH98tMV/lFDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVvfD45eC5P1qU0zsBPsVXVxJeEBEBEDQvYqnE8f68/xTstSTcyT66aPuCjZHBSV5jcItRyErsVCmSgCiXhUxta62olBqJ2Ys9/AnR8v1cOIgzsiyOg3JjMl7fCAo3t462gS5ZDWrG13KXlQeLO3LrtcJnZWB9R78FHRVOWxtnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360641F00A3E;
	Thu, 23 Jul 2026 14:19:13 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/8] netfilter: nft_set_pipapo: prepare walk function for on-demand clone
Date: Thu, 23 Jul 2026 10:18:51 -0400
Message-ID: <20260723141855.3217594-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723141855.3217594-1-sashal@kernel.org>
References: <2026072015-level-taste-bb42@gregkh>
 <20260723141855.3217594-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 6c108d9bee448a850b03e682836bfe91fca645cb ]

The existing code uses iter->type to figure out what data is needed, the
live copy (READ) or clone (UPDATE).

Without pending updates, priv->clone and priv->match will point to
different memory locations, but they have identical content.

Future patch will make priv->clone == NULL if there are no pending changes,
in this case we must copy the live data for the UPDATE case.

Currently this would require GFP_ATOMIC allocation.  Split the walk
function in two parts: one that does the walk and one that decides which
data is needed.

In the UPDATE case, callers hold the transaction mutex so we do not need
the rcu read lock.  This allows to use GFP_KERNEL allocation while
cloning.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 60 ++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 6c4f783f51ca5d..f489d62b00e4ac 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2109,35 +2109,23 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 }
 
 /**
- * nft_pipapo_walk() - Walk over elements
+ * nft_pipapo_do_walk() - Walk over elements in m
  * @ctx:	nftables API context
  * @set:	nftables API set representation
+ * @m:		matching data pointing to key mapping array
  * @iter:	Iterator
  *
  * As elements are referenced in the mapping array for the last field, directly
  * scan that array: there's no need to follow rule mappings from the first
- * field.
+ * field. @m is protected either by RCU read lock or by transaction mutex.
  */
-static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
-			    struct nft_set_iter *iter)
+static void nft_pipapo_do_walk(const struct nft_ctx *ctx, struct nft_set *set,
+			       const struct nft_pipapo_match *m,
+			       struct nft_set_iter *iter)
 {
-	struct nft_pipapo *priv = nft_set_priv(set);
-	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	int i, r;
 
-	WARN_ON_ONCE(iter->type != NFT_ITER_READ &&
-		     iter->type != NFT_ITER_UPDATE);
-
-	rcu_read_lock();
-	if (iter->type == NFT_ITER_READ)
-		m = rcu_dereference(priv->match);
-	else
-		m = priv->clone;
-
-	if (unlikely(!m))
-		goto out;
-
 	for (i = 0, f = m->f; i < m->field_count - 1; i++, f++)
 		;
 
@@ -2157,14 +2145,44 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		iter->err = iter->fn(ctx, set, iter, &elem);
 		if (iter->err < 0)
-			goto out;
+			return;
 
 cont:
 		iter->count++;
 	}
+}
 
-out:
-	rcu_read_unlock();
+/**
+ * nft_pipapo_walk() - Walk over elements
+ * @ctx:	nftables API context
+ * @set:	nftables API set representation
+ * @iter:	Iterator
+ *
+ * Test if destructive action is needed or not, clone active backend if needed
+ * and call the real function to work on the data.
+ */
+static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
+			    struct nft_set_iter *iter)
+{
+	struct nft_pipapo *priv = nft_set_priv(set);
+	const struct nft_pipapo_match *m;
+
+	switch (iter->type) {
+	case NFT_ITER_UPDATE:
+		m = priv->clone;
+		nft_pipapo_do_walk(ctx, set, m, iter);
+		break;
+	case NFT_ITER_READ:
+		rcu_read_lock();
+		m = rcu_dereference(priv->match);
+		nft_pipapo_do_walk(ctx, set, m, iter);
+		rcu_read_unlock();
+		break;
+	default:
+		iter->err = -EINVAL;
+		WARN_ON_ONCE(1);
+		break;
+	}
 }
 
 /**
-- 
2.53.0

