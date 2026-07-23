Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6BA4749CF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817286; cv=none; b=gyfZx/lrT/wNFDrl56QkuJHJLJVLTJJGy/PD+u0nyR93804WLgexlGgc9j+R+0DT5XnGPtHoimFOzsWCA7hpF2i+/iAjfaqnITm+bMND8cyNHTPTDAcEkY3V8nglbCO1SIJrp75Lejzx/QG+fOtJRJiu1ZM00cuLa/4VeCmpywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817286; c=relaxed/simple;
	bh=UsWJo5jU8UHhnFEdfGmQekxvPcBxkDK+6pZL/a3VdIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0tccPluFpueXPJYvmPSu+N/l0yl+Nf5uAkt1hAAHj3nVbQh/IN99uyNO2oZwkE0zg3QqlVENaBHYG5KqSNYRL+LYgDKwINJcQGGdtXwSFT+sPZKKmvFJXVYxAn7EikspU2657PHcNDUrMGEp7mUB/t2ctcXV2+Ry1Vuy6YmMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfNqr6sV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfNqr6sV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622FE1F00AC4;
	Thu, 23 Jul 2026 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817278;
	bh=uL2OzqGhMVj0R0zj2NASGr2dbJvJlWJhT/AFvbo90n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfNqr6sVVBWsBIJofXneHy2Vqldvqz8hqi81earEK2bGX05TpFdfAhH8sf4FUw+8L
	 sZ5p9pJ6kYlI/WNvtaJz5Tzfha5ruksaD6d0IxK4efI3oU5+qKtSzTkqZ15t61i7/s
	 y7//fyHBjAk4XJ37QbUHtxNrgMbvS+w8zgguzZPdrVrEJ9v4cHhG9uCCkmBLImp9Mx
	 QxuJHHS8WWGvPIFFmL451LkM2MCBQefiYt1modTm0NRkuKDd2w515ospaDRC31Xl+i
	 R7LKM52Ji7xrna37gGu+RYY6LM2kMHGAnI+4FwWujcL5p0qbHvfAwciD94YtclKbc0
	 mjgSdbk9bCcVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/8] netfilter: nft_set_pipapo: merge deactivate helper into caller
Date: Thu, 23 Jul 2026 10:34:30 -0400
Message-ID: <20260723143433.3226555-5-sashal@kernel.org>
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

[ Upstream commit c5444786d0ea2417a5e2cee7bd67137fc8bad687 ]

Its the only remaining call site so there is no need for this to
be separated anymore.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 39 ++++++++--------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 99c3339075640b..3807d82697857d 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1855,52 +1855,31 @@ static void nft_pipapo_activate(const struct net *net,
 }
 
 /**
- * pipapo_deactivate() - Check that element is in set, mark as inactive
+ * nft_pipapo_deactivate() - Search for element and make it inactive
  * @net:	Network namespace
  * @set:	nftables API set representation
- * @data:	Input key data
- * @ext:	nftables API extension pointer, used to check for end element
- *
- * This is a convenience function that can be called from both
- * nft_pipapo_deactivate() and nft_pipapo_flush(), as they are in fact the same
- * operation.
+ * @elem:	nftables API element representation containing key data
  *
  * Return: deactivated element if found, NULL otherwise.
  */
-static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
-			       const u8 *data, const struct nft_set_ext *ext)
+static void *nft_pipapo_deactivate(const struct net *net,
+				   const struct nft_set *set,
+				   const struct nft_set_elem *elem)
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net),
-		       nft_net_tstamp(net), GFP_KERNEL);
+	e = pipapo_get(net, set, (const u8 *)elem->key.val.data,
+		       nft_genmask_next(net), nft_net_tstamp(net), GFP_KERNEL);
 	if (IS_ERR(e))
 		return NULL;
 
 	nft_set_elem_change_active(net, set, &e->ext);
 
-	return e;
-}
-
-/**
- * nft_pipapo_deactivate() - Call pipapo_deactivate() to make element inactive
- * @net:	Network namespace
- * @set:	nftables API set representation
- * @elem:	nftables API element representation containing key data
- *
- * Return: deactivated element if found, NULL otherwise.
- */
-static void *nft_pipapo_deactivate(const struct net *net,
-				   const struct nft_set *set,
-				   const struct nft_set_elem *elem)
-{
-	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
-
-	return pipapo_deactivate(net, set, (const u8 *)elem->key.val.data, ext);
+	return &e->priv;
 }
 
 /**
- * nft_pipapo_flush() - Call pipapo_deactivate() to make element inactive
+ * nft_pipapo_flush() - make element inactive
  * @net:	Network namespace
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
-- 
2.53.0

