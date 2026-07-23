Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C35284883
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817282; cv=none; b=mvS4nDz81vO0uv784C5tz2J5fmQecN2eLBUDt1w7eruFzwcF/shu+0UMtbypQ9cKoOv+uga47dcR688dkp93hVvkXJwzAxJ4N/v07bI7LK4w5MgcBH2MvGXrbylNQkMfRt0KQ+NYNIcxH/SlOSGQ9ZaJZsj1vFN3mZf0ZQcevUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817282; c=relaxed/simple;
	bh=+4X8kxZCKJIPheWDbbD9j/oGe0lqxd0c4RTvEbftgcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNWstpXpWs1xFUp1exGQCMFTSzOM7QOBOsP+mykKJZf2THUxcTaSheGtj1h7L7Kb1FeR4x4uiyPem/j4H5cAcBdYlYLF74ZbBTZv3zIrYT2iHvtBZ0QUxmQdZgITcahiCiub/E/zZJshuvMJW/r2TU0AtOsRD0QNxg2WIyz/0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biDipZn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biDipZn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AF81F00A3E;
	Thu, 23 Jul 2026 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817278;
	bh=Jq2AxmXZ3FP52LGW7elgIsFwYwiH9LDO7GiS5//WFhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=biDipZn33qjGk/i32jG+CdTXxbxgAemLZ7MVkBOOCGfAGbEQLI9aNpNuM5s/oF2NL
	 q7OBLgtP48ATJi/3k3rc5bOLLrNx7+BM6NaLNANETit0KbxAdKSZRU2LVhFIpuJaTc
	 qZsIix64Vsq0BzBktqebB942fhkAkLZWNZQa0kTSrlJLTcFYkus2lUHKGQ7/nU2NcU
	 rHJJrB8ZWASej8c5AMMEoivfPS++J0eqzOHYkGfiihfoBbhAg0FtHeVga4g9WrKxjR
	 McfIcIMTIUPCDAGHiWfmJEcLD0dC4ECPeGkZu2wJlO+SCFiHbW5UX7R56NZ65Axl9M
	 GXV8jg1u+TBtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/8] netfilter: nft_set_pipapo: prepare walk function for on-demand clone
Date: Thu, 23 Jul 2026 10:34:29 -0400
Message-ID: <20260723143433.3226555-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723143433.3226555-1-sashal@kernel.org>
References: <2026072015-dating-wanting-8baf@gregkh>
 <20260723143433.3226555-1-sashal@kernel.org>
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
index 012d853db79afb..99c3339075640b 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2110,35 +2110,23 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
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
 
@@ -2158,14 +2146,44 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
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

