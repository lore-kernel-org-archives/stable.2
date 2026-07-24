Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E51419A4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856305; cv=none; b=NRHLM/a5VwQNmj5g5sZ+WNGgOVXipoMYT2zEZGd/ElJPUYvvSU66j0lrIBwk/+quAYFx1vsEM4T5hfjiLpwt4MBx4O8tFD3XuGiJQXZolHZmO3E66bXcPq6z1lnYnO/pxg3J+jlqjeeDbJuAcorCFg6fBMPJnPw/jsLFhrsDRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856305; c=relaxed/simple;
	bh=pMXQaRZIWm1tm+73ffS4ENxpw0JxnlKuXBgUDUEs+oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXPsnuV/jw2L9EC9TaRKlnXtiv1NzxfFvyF/MgMljeFNu+3uro96CNco/2uHwxFn1yAw496nlXutzBc1hI14vhTZphERdoU6IeWdEaYzfFePdYRCRk9KMhTxyjH0HGoPF+N8kX8OfW+Pi7fp7HuosZfInUWwzAjTEwxas5ZgZ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBmWt0fR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBmWt0fR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097C61F000E9;
	Fri, 24 Jul 2026 01:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856304;
	bh=7JLCt0ybvUlVhOUV8gKCsPMS4326EndSnNnUBvI8eKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fBmWt0fRQtRUmHcgyvx60DZkl6iqXiYg6Bds9iTmBu08yxTprb3UpCiSrJ8rVqF2n
	 MCMp3uVO4Y8zMdZ0OW4oQkY3b4u+1SOVaCEcu5C09drJa+/gMzSh7NJocho4/3dfdK
	 bxuRIfdJPo21Vq1f/kfpE2G/5US6t3IpAquvbdGMXBB40/0Z2ALMqsd76OHdLpesgD
	 x7r6hQ0YNjbsm14LMKzZ0zrW2CZiVtIKWZJRsXvMbcPoUNdCnfBRxmHimog+6LmhAQ
	 zs9h88dMxBaQ0l6JAdHJfttuVR4kZ7T4sDP4BwuAxov1VRze7Jwg7bcEZRJt9G9K1a
	 sdpMVlm+5wesQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/7] netfilter: nft_set_pipapo: merge deactivate helper into caller
Date: Thu, 23 Jul 2026 21:24:57 -0400
Message-ID: <20260724012500.3832837-4-sashal@kernel.org>
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
index a1361691ef225c..9b574fb4ed7e7a 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1799,52 +1799,31 @@ static void nft_pipapo_activate(const struct net *net,
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

