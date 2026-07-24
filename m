Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120A311973
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856305; cv=none; b=HC9IHhuzAeZCe4Kb6D5ga03MnGVtdTFdmUarndod+PPpfOplFFmFDVzvEnDlLzoSBpAUFcNiOtpkvywAuooyBs74ag2S01opM2XpwdKBxySl5M0GG6jcwDAPwFeEgOB6/UOYoZLNGugiC72u6t0am82KDrb3kEhRCUOV9qaWvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856305; c=relaxed/simple;
	bh=ILTOHWv4jcmhhlbvrMSRjr1GSknwaBNVMjQlHcJe5Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjT1im/bPB18faH0YkAJhd2+URu1sCz1xGhAj5xXHLoW+7QCreaw0YQz3l+7VS6gUVcxxqhoqaMUPesySAYqNlL58t3chHBWzvMM5blFLf+ruGyxhM4vICFa2j+8JTbM60rjj+FM0sPbbA3BnwNXMtKOGw+H+rTNC5Vrzke31io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEqj9J5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEqj9J5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CED1F00A3D;
	Fri, 24 Jul 2026 01:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856303;
	bh=e8N7bQTfVeDYpmsyvxm2eZJ855X+k0d0Q4Q6VEqejwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BEqj9J5a3Dw6loRq8+Bf+ZJBQ/csDecTTL/ERhNni2Ia21bpf8fRrCv87ZROlUIl/
	 ZLIke3oHwarPXCbRunppRwOJOMTaUEiLqU0BiI03eYMehZuN+/SAHqH2Abwkc93O61
	 j6LgZm9xQ/yQIwEBwbgQZpBMNAbG1COkzl3lx2sz44P5gldPmROj5pKVw59F8p3pYv
	 Wqk7JBVK0DPKqQ9wnHtS/WZgCS73uYqbbTskj0arW5pNmpuSX/zXObZE/zzbYIRZ6L
	 LwhWMEMcDwDwOl9FWG9HLQzklIFQbw8gnpf8kGsHPJnvydZTqW5hkc0kitDsAc8gmU
	 SQIwmfmM0g3Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/7] netfilter: nft_set_pipapo: prepare walk function for on-demand clone
Date: Thu, 23 Jul 2026 21:24:56 -0400
Message-ID: <20260724012500.3832837-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724012500.3832837-1-sashal@kernel.org>
References: <2026072016-unplowed-brush-0ff9@gregkh>
 <20260724012500.3832837-1-sashal@kernel.org>
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
 net/netfilter/nft_set_pipapo.c | 64 ++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 5f2885a878dda7..a1361691ef225c 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2054,34 +2054,22 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
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
-	struct nft_pipapo_match *m;
-	struct nft_pipapo_field *f;
-	int i, r;
-
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
+	const struct nft_pipapo_field *f;
+	unsigned int i, r;
 
 	for (i = 0, f = m->f; i < m->field_count - 1; i++, f++)
 		;
@@ -2105,14 +2093,44 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
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

