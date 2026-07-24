Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDF31197C
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856304; cv=none; b=Kcn5CZEAzk1hJeVLvEwYJtBQd+TupB+mwzEOnCq1/CurGlGvMOgsLeGXzQo3kddTfDYiUEceFa3aqUGkMj7SgOfz8mP6FrevVR6eZ5F0UuBxMALNifK7Lb5mvFVeao6Z+kSHurDCVBjkMNNMR6CJD3cBSUZfafjBQltIxM9WcKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856304; c=relaxed/simple;
	bh=2dVibRm4208C8bZeWP2Le1YTbq6KPBC9gBfRtbXA6YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaCgttXIX7j19LVGxCQtgz5Hk6p9nUH1xUxW2MZ39CpB2iBkidf6qXnMHijf+R6cQGOiOScTFAdhzQ56RjsIPaP3ILQ/+j0TYDagFVMl1sIDYdY/LYEDionb6dy3dYLKcKEbsXw+S90QjmsNV2PXXfnV3goOp8tEVio0ekVTnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQm7OOwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQm7OOwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9611F00A3E;
	Fri, 24 Jul 2026 01:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856302;
	bh=Ru6Ife5MdOTwf32DaQ0+CUm+pgBfdzgHqhJTR3Kp+v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NQm7OOwDoIUBx+X9wPxnhD/iBLfnGGyufLae1qtYGgWMtBMRNjXO3Psul2qFjqqGZ
	 MiVIm2rx0bxi9Z44aG3caA35ll2pOxsxGog4dh6FigNNgrxlT10xaPmHi8jFPJu8Qy
	 tm/MAloXdvgwzNEZthucv/n0SE8tYBbrPMJQkz3fQ1h03YKmJEPilP30PLeSlIQoKk
	 4IGmG8rvgBihXltLH0MtPd2KjcSNee4xd3Yf+wD09DJV86cMi/+gUFz0onL3O5OdSc
	 o3PcVOxz0R9MYRXM7AjitgYCFO1PSdM3LKPUqSq1u2sNNQqhLrqf7v1JDX6uA5MqE/
	 2eBeWMb8hS1Vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/7] netfilter: nft_set_pipapo: make pipapo_clone helper return NULL
Date: Thu, 23 Jul 2026 21:24:55 -0400
Message-ID: <20260724012500.3832837-2-sashal@kernel.org>
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
index a01905381b5365..5f2885a878dda7 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1318,7 +1318,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
  * pipapo_clone() - Clone matching data to create new working copy
  * @old:	Existing matching data
  *
- * Return: copy of matching data passed as 'old', error pointer on failure
+ * Return: copy of matching data passed as 'old' or NULL.
  */
 static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 {
@@ -1329,7 +1329,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	new = kmalloc(sizeof(*new) + sizeof(*dst) * old->field_count,
 		      GFP_KERNEL);
 	if (!new)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	new->field_count = old->field_count;
 	new->bsize_max = old->bsize_max;
@@ -1403,7 +1403,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	free_percpu(new->scratch);
 	kfree(new);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 
 /**
@@ -1743,7 +1743,7 @@ static void nft_pipapo_commit(const struct nft_set *set)
 		goto out;
 
 	new_clone = pipapo_clone(priv->clone);
-	if (IS_ERR(new_clone))
+	if (!new_clone)
 		goto out;
 
 	priv->dirty = false;
@@ -1769,7 +1769,7 @@ static void nft_pipapo_abort(const struct nft_set *set)
 	m = rcu_dereference(priv->match);
 
 	new_clone = pipapo_clone(m);
-	if (IS_ERR(new_clone))
+	if (!new_clone)
 		return;
 
 	priv->dirty = false;
@@ -2214,8 +2214,8 @@ static int nft_pipapo_init(const struct nft_set *set,
 
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

