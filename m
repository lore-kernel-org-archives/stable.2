Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023CE409102
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825672; cv=none; b=ZE3/4SqioneVhGC00zHXYfz/d0B6M7Lsz4eHZc2cE/AF+5OtwhiXSCd8OpNd0/ODP8JuCjMyX9j0yrvjx05oOF+EmygENXhjbz/5WS2NCGZdXpqMvkUNuC4lhfHbfjrj3WQLLDU+vDlCd3TNRWOiZMhg3bSbW7tsaR2JnFL0L1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825672; c=relaxed/simple;
	bh=TV2HRGZMF34mP8Ovd5tiaNTW7dYxYlmymuSLFwq6Mnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+WkSbHWzvH//Hl3VgIaJUmQhcYHH3ac7PYkbm0CZ9Oyn6fGldtVuh/gqt4JLdGyO959Q1gNMasqeg0S62KZ19P8YeBi3sEmkdGa1byKCqK4vp6Mard8CRurWLPtoWGcWYmi4csuKt3fhkG77U5hMJssmHwi+yyhiSY9UhUL+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFw4GqRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFw4GqRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E121F00A3E;
	Thu, 23 Jul 2026 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825670;
	bh=inGrT0QZiZ1By1l3pBvyfdQZHV4WjA62CL0WZ+RbKZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFw4GqRNGvBa2OLNtb94JzbVrAtBkPf9CYVGK0l1ndG5+aoIdcYkLxQqPoOMRoU0P
	 /KH/ImkhdlRg12ggj4eASfGfrEDxbcVvFH5d9BLAT4vVF126TZBoKfyLde2pXoDqxi
	 JyKECALfl/WzOm8xhNjYovwnluHiPNhSEtx4u3UvHCNMSOpkjif11/jPnHT44yUKpN
	 4naC22Z4SjlJg7tYamJU1YQom3AEq7m7bTk5IZEqmkWgNnZJC8efjfpPG1itw5s05f
	 l+oZDrAoitceO8kPb3KDywYvPLJchZO3pvYEtii9gc/npWEiBISf5i8rEY8rOMOXeH
	 YRiSh0M3A8TPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/8] netfilter: nft_set_pipapo: make pipapo_clone helper return NULL
Date: Thu, 23 Jul 2026 12:54:22 -0400
Message-ID: <20260723165427.3390871-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723165427.3390871-1-sashal@kernel.org>
References: <2026072016-hurling-turmoil-5fb2@gregkh>
 <20260723165427.3390871-1-sashal@kernel.org>
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
index a7175f7a21a79d..1f40ba3bada0b6 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1331,7 +1331,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
  * pipapo_clone() - Clone matching data to create new working copy
  * @old:	Existing matching data
  *
- * Return: copy of matching data passed as 'old', error pointer on failure
+ * Return: copy of matching data passed as 'old' or NULL.
  */
 static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 {
@@ -1342,7 +1342,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	new = kmalloc(sizeof(*new) + sizeof(*dst) * old->field_count,
 		      GFP_KERNEL);
 	if (!new)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	new->field_count = old->field_count;
 	new->bsize_max = old->bsize_max;
@@ -1416,7 +1416,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	free_percpu(new->scratch);
 	kfree(new);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 
 /**
@@ -1770,7 +1770,7 @@ static void nft_pipapo_commit(struct nft_set *set)
 		return;
 
 	new_clone = pipapo_clone(priv->clone);
-	if (IS_ERR(new_clone))
+	if (!new_clone)
 		return;
 
 	priv->dirty = false;
@@ -1796,7 +1796,7 @@ static void nft_pipapo_abort(const struct nft_set *set)
 	m = rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_held(set));
 
 	new_clone = pipapo_clone(m);
-	if (IS_ERR(new_clone))
+	if (!new_clone)
 		return;
 
 	priv->dirty = false;
@@ -2241,8 +2241,8 @@ static int nft_pipapo_init(const struct nft_set *set,
 
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

