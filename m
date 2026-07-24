Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD082F7F1B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856308; cv=none; b=dS5Fr7CRbVCxCvDGO/t3BCrDP274IQtXMDSkXp7ezSKxCEk/RFbH0jUMWcgJLHDgnQodhPZ7a2SIoWQ9m43FIBKh7e37e1GG95UWY0scoA0PD+y85TK7iDyy3UCghy70rPwC9FjGLc76O8BBACp+iNvA8n0W/oobMZVWgZQGNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856308; c=relaxed/simple;
	bh=dMc9CdSarGCjQ8RaufMtUUoeChWS8Qe5ZtQinbuBpk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuxKAw7kJ1I8saNuFj0ExUMv3QsdkpJprUdjh/WcIvMwon2k1Jtaxj55CL4SSNBcLCr3K47ymDxWPKMty4gzZ5qI362OFpTbxSMop0uiW5AzDPSwYsg1PDkvdufzAZh061pnTrBkIT6yxFmq4ngaG6yAp9kowBTaCvB3iTv9iKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJwGJtPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJwGJtPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC331F000E9;
	Fri, 24 Jul 2026 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856307;
	bh=3dZYfPRgR7AbpKRBAbI3zXGS08Qbif00gzRJZXjNZ30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nJwGJtPkVz1SRuZP7kKyOLvcAfCIMvf0O0eHi4YdyPeirZ9bFriPeDG+0cMIhh0w9
	 NMFAoE9Cj6oCHS4Ks6DABmzjr9CJoyOP0n+jK765sO38TyfV//AUyz86nf46OJXYmy
	 xpMalu7/aZIW4BjP62i4OEICUfssuZSAC5TmqjcH7oA6zxWALgKhKI11y4aJCAE+ER
	 bVnp5hI8T4Pgj+v4lJOOJ+UYVzPg/j+txf83Zkf+98LALtqF9H7RIuOz25GsDM32V8
	 CeAJ8OfKoIKycm0N9IYBfrZZFOlqAKpZDdOWNAztzWlDAkXh1mj/s/BOgA3eAQPefG
	 rjlRFLsjjgoRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Seesee <cjc000013@gmail.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 7/7] netfilter: nft_set_pipapo: don't leak bad clone into future transaction
Date: Thu, 23 Jul 2026 21:25:00 -0400
Message-ID: <20260724012500.3832837-7-sashal@kernel.org>
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

[ Upstream commit 47e65eff50691f0a5b79d325e28d83ec1da43bcf ]

On memory allocation failure the cloned nft_pipapo_match can enter a bad
state:
 - some fields can have their lookup tables resized while others did
   not
 - bits might have been toggled
 - scratch map can be undersized which also means m->bsize_max can be
   lower than what is required

This means that the next insertion in the same batch can trigger
out-of-bounds writes.

Furthermore, a failure in the first can result in the bad clone to
leak into the next transaction because the abort callback is never
executed in this case (the upper layer saw an error and no attempt to
allocate a transactional request was made).

Record a state for the nft_pipapo_match structure:
- NEW (pristine clone)
- MOD (modified clone with good state)
- ERR (potentially bogus content)

Then make it so that deletes and insertions fail when the clone
entered ERR state.

In case the very first insert attempt results in an error, free the
clone right away.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Cc: stable@vger.kernel.org
Reported-and-tested-by: Seesee <cjc000013@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 34 +++++++++++++++++++++++++++++-----
 net/netfilter/nft_set_pipapo.h |  8 ++++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 5b985ce8065f6c..d1303fae3c59d5 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -342,6 +342,8 @@
 #include "nft_set_pipapo_avx2.h"
 #include "nft_set_pipapo.h"
 
+static void nft_pipapo_abort(const struct nft_set *set);
+
 /**
  * pipapo_refill() - For each set bit, set bits from selected mapping table item
  * @map:	Bitmap to be scanned for set bits
@@ -1251,7 +1253,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
 
-	if (!m)
+	if (!m || m->state == NFT_PIPAPO_CLONE_ERR)
 		return -ENOMEM;
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_KEY_END))
@@ -1324,8 +1326,10 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		else
 			ret = pipapo_expand(f, start, end, f->groups * f->bb);
 
-		if (ret < 0)
-			return ret;
+		if (ret < 0) {
+			err = ret;
+			goto abort;
+		}
 
 		if (f->bsize > bsize_max)
 			bsize_max = f->bsize;
@@ -1341,7 +1345,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 		err = pipapo_realloc_scratch(m, bsize_max);
 		if (err)
-			return err;
+			goto abort;
 
 		m->bsize_max = bsize_max;
 	} else {
@@ -1352,7 +1356,26 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	pipapo_map(m, rulemap, e);
 
+	m->state = NFT_PIPAPO_CLONE_MOD;
 	return 0;
+abort:
+	WARN_ON_ONCE(m->state == NFT_PIPAPO_CLONE_ERR);
+
+	/* Two rollback cases:
+	 * 1) no previous changes.  nft_pipapo_abort is not
+	 * guaranteed to be invoked (there might be no further
+	 * add/delete requests coming after this).
+	 *
+	 * 2) we had previous changes: there are transaction
+	 * records pointing to this set.  Leave the rollback to
+	 * the transaction handling.
+	 */
+	if (m->state == NFT_PIPAPO_CLONE_NEW)
+		nft_pipapo_abort(set); /* releases m */
+	else
+		m->state = NFT_PIPAPO_CLONE_ERR;
+
+	return err;
 }
 
 /**
@@ -1427,6 +1450,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		dst++;
 	}
 
+	new->state = NFT_PIPAPO_CLONE_NEW;
 	return new;
 
 out_mt:
@@ -1849,7 +1873,7 @@ static void *nft_pipapo_deactivate(const struct net *net,
 	/* removal must occur on priv->clone, if we are low on memory
 	 * we have no choice and must fail the removal request.
 	 */
-	if (!m)
+	if (!m || m->state == NFT_PIPAPO_CLONE_ERR)
 		return NULL;
 
 	e = pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index ca90be37bc714b..8d71db17695f00 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -142,9 +142,16 @@ struct nft_pipapo_scratch {
 	unsigned long map[];
 };
 
+enum nft_pipapo_clone_state {
+	NFT_PIPAPO_CLONE_NEW,
+	NFT_PIPAPO_CLONE_MOD,
+	NFT_PIPAPO_CLONE_ERR,
+};
+
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
+ * @state:		add/delete state; used from control plane
  * @scratch:		Preallocated per-CPU maps for partial matching results
  * @bsize_max:		Maximum lookup table bucket size of all fields, in longs
  * @rcu			Matching data is swapped on commits
@@ -152,6 +159,7 @@ struct nft_pipapo_scratch {
  */
 struct nft_pipapo_match {
 	int field_count;
+	enum nft_pipapo_clone_state state:8;
 	struct nft_pipapo_scratch * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
-- 
2.53.0

