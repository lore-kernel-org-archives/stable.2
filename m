Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACFD3C1D5E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766864; cv=none; b=T2lkWCVIU8zrRXxinyYrvNipl3dykbngZakssYb6l2R9f5qKPBQPexOlH+wlM12KBAOpmO6DRUYsnZOQPdOb6qpWXntv8KZJfFe6HoQSWmgZnZubJjydlxQxcyWunX2EMnlnzCd9u4XrE9fcDRQOd7nIn2jv6rXDoC5ZheJFJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766864; c=relaxed/simple;
	bh=tGMe/2ymFkieCu2uDU9SAOi5HoeIw46152V6MQSiigA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKqqQXsnIdTqJbFuNEUT+HBxjn8VzNpAKsySSJYmRIvuiVViuNlTBE+5KE3q5yfi7x8Bbb+SNTobZpQQu+vrfDZ2b64joz2Trk3JKP27B6M91tsmPjO2zbwgWBW0UP0hwKCTll7kPlaPbKUkZcbUKLx+j5KLOTWCMoAoKqfUGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUznWKUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUznWKUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994E61F00893;
	Wed, 30 Sep 2026 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766862;
	bh=cgBoFmUH/rT97lua7kfyGogxGnAyVt+N7V+IMBW69VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUznWKUp8z7WeU4K+AoIHKG6L7anfdEtirjHbVzE5YnpLck0elQfWMIS9H2Fgi8Te
	 SsKbAiebyeGqc/wgTrKISRQFOhQBTyaYn1Q0w+DLF6OKtaZGecrIQYUW8OJyNNmfHl
	 JoPHogvK/oSTVDrgX69CiDhRLG+1UJjrKM/cESj4fz3fVijaszAAlxjsgE/PH88KNR
	 ZZQwnSCFq06iLmEIITbd3FWpaCfBlUkcQhLFfkpiq7shdR1HzVBFOpyJITz29wJJUP
	 BMEPof4kE13N5P//MKBJ8gi6INKlJ6vTTBWnDE2YsaIiBJy7XBFWFynx0VfNMQShPQ
	 oaMGFl79N7wnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] netfilter: nft_set_rbtree: Remove unused variable nft_net
Date: Wed, 30 Sep 2026 07:14:18 -0400
Message-ID: <20260930111419.1207335-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111419.1207335-1-sashal@kernel.org>
References: <2026092922-sadly-mace-20a0@gregkh>
 <20260930111419.1207335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit 67059b61597c004e23b074547b40604222bee3a0 ]

The code that uses nft_net has been removed, and the nft_pernet function
is merely obtaining a reference to shared data through the net pointer.
The content of the net pointer is not modified or changed, so both of
them should be removed.

silence the warning:
net/netfilter/nft_set_rbtree.c:627:26: warning: variable ‘nft_net’ set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7103
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Backport notes for Linux 6.6:
Keep the net initialization and transaction timestamp introduced by
7fa2e2960fff8 ("netfilter: nf_tables: use timestamp to check for set element
timeout"). Remove only the unused nft_net declaration and assignment;
the timestamp remains necessary for synchronous garbage collection.
The target catchall fix 70194dc37670 applies unchanged to nf_tables_api.c.

Stable-dep-of: 70194dc37670 ("netfilter: nf_tables: skip expired catchall elements on insert and delete")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_rbtree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index ac0bd348a46c2..4ea4b65a4d793 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -653,7 +653,6 @@ static void nft_rbtree_gc(struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
-	struct nftables_pernet *nft_net;
 	struct net *net = read_pnet(&set->net);
 	u64 tstamp = nft_net_tstamp(net);
 	struct rb_node *node, *next;
@@ -661,7 +660,6 @@ static void nft_rbtree_gc(struct nft_set *set)
 
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
-	nft_net = nft_pernet(net);
 
 	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
 	if (!gc)
-- 
2.53.0

