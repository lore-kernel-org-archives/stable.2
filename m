Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3847142C
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817282; cv=none; b=VG6uGnPR4l2aODlcU9jPIX6csSTyPoUZ+dJqdmT/29Dj/TIapjtsm7+L3WUOR7rWaQxV3Y1qcUgXgEEuFQKiteGJz2b7H4hQ32b4ebcbOm6kUogP1ffP3gfKkncLo82LEr9R1/1ow4puv2tC0wAISBuJTOcytENa+Uzfnke/gpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817282; c=relaxed/simple;
	bh=nb6qJqcjZU74lMmAy/bf55oyER9k7YQpBJANTzOtvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY0iuDH2k0ETrYuHu7NUsYbA4/KVikY6ixFCVv5CCZaSTgkJoh0Muu0kVUtsn4/H5DFxgSaaroJMXTF9kSQSBC3yJLCJz9errmA1d4NdebjOc+AucfMml1hKMB0MFNaHjCowkDvKVg0jWGlYjsQ39ch2tdX0XvjYlbKXkt4shaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxlwjRz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxlwjRz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29ED1F000E9;
	Thu, 23 Jul 2026 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817277;
	bh=qXmq610QnUJ7cPreJkrUE8wZhrDcG8NeLvh2rTSSkMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZxlwjRz5wON+HIvRviv9UUZBvPnAl+L51h2h+2TulHIT3s1bN6Ib2wPKqXZ3pQ5vx
	 QM/J+zi/4Im8trYmvvE2ku4YOeegV3HC1I8dPxL4RboBGMwyrYZTuGi1JpbKX5+owu
	 +DjTHruazAmtE7fokfNylkKoxUmOuoXf9ETkUyXgq2ehMdsLQb2tF6VNyDE6QvAEVc
	 txYH3zX2PjlVdYhplYMvj8fMxA1NToOiSYHku50Lz7q0z/49lyr7mMBOXZCxvvCYQW
	 pxXSGMkpvmGXVLonUp8E0k5IN1wRgZCi1MQn9hu7X115FBWOkwtSghzGUwfHE9oS7g
	 ViatTSSGxl1RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/8] netfilter: nft_set_pipapo: make pipapo_clone helper return NULL
Date: Thu, 23 Jul 2026 10:34:28 -0400
Message-ID: <20260723143433.3226555-3-sashal@kernel.org>
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

[ Upstream commit 80efd2997fb9343a0283cf3cac5524a4595c8ff4 ]

Currently it returns an error pointer, but the only possible failure
is ENOMEM.

After a followup patch, we'd need to discard the errno code, i.e.

x = pipapo_clone()
if (IS_ERR(x))
	return NULL

or make more changes to fix up callers to expect IS_ERR() code
from set->ops->deactivate().

So simplify this and make it return ptr-or-null.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 502193505bb26d..012d853db79afb 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1358,7 +1358,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
  * pipapo_clone() - Clone matching data to create new working copy
  * @old:	Existing matching data
  *
- * Return: copy of matching data passed as 'old', error pointer on failure
+ * Return: copy of matching data passed as 'old' or NULL.
  */
 static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 {
@@ -1369,7 +1369,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	new = kmalloc(sizeof(*new) + sizeof(*dst) * old->field_count,
 		      GFP_KERNEL_ACCOUNT);
 	if (!new)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	new->field_count = old->field_count;
 	new->bsize_max = old->bsize_max;
@@ -1445,7 +1445,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	free_percpu(new->scratch);
 	kfree(new);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 
 /**
@@ -1799,7 +1799,7 @@ static void nft_pipapo_commit(struct nft_set *set)
 		return;
 
 	new_clone = pipapo_clone(priv->clone);
-	if (IS_ERR(new_clone))
+	if (!new_clone)
 		return;
 
 	priv->dirty = false;
@@ -1825,7 +1825,7 @@ static void nft_pipapo_abort(const struct nft_set *set)
 	m = rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_held(set));
 
 	new_clone = pipapo_clone(m);
-	if (IS_ERR(new_clone))
+	if (!new_clone)
 		return;
 
 	priv->dirty = false;
@@ -2267,8 +2267,8 @@ static int nft_pipapo_init(const struct nft_set *set,
 
 	/* Create an initial clone of matching data for next insertion */
 	priv->clone = pipapo_clone(m);
-	if (IS_ERR(priv->clone)) {
-		err = PTR_ERR(priv->clone);
+	if (!priv->clone) {
+		err = -ENOMEM;
 		goto out_free;
 	}
 
-- 
2.53.0

