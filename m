Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C504FD27B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783086; cv=none; b=rsA0rXWOTZnmVCna8+Bz89iRRPzH0QQBgmnzo4vk9SzuYL1e35JIykjFTDPO7EsLZ8wSQ+IYiDNKKw93uGM1OIJnV/QtDUi1b3gGC5fRr+ZdmnIq+M3C46SBuLBBxNbbzv0a2zhHYvCTQ1RXZVvk10AbbibQmLAELBnjO/7/MeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783086; c=relaxed/simple;
	bh=V5o6mG+2mlPYXrZzaZxAvZtP6B9Xa79Luj+Ud3xjwJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fma0zUbQNMDuDlbt8m/di23dhlGlt1YLl0woPMGdHLDUno0DgAEMVOPakEGI10C+2/uvK+hHmH0sERHM0WvrfWhvLkSfMoQZ3iXvMKmiKnq67c5uY1or1abvlsf69lsjjxCG4T55EXDlPboPKRVEJQEgbauXU19CrDx+F66aJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTRRuFKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTRRuFKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6BB1F00899;
	Wed, 30 Sep 2026 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790783077;
	bh=n76i/O8BrEpQ8ZAHuyFjNjr/WOV3dMZUSrC5wqjLcGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTRRuFKFHrFsMXdl0sehp6pDj8UU4gyWcxvRYkd/1xA5f2oNuY96m9iWXHVi6VYux
	 GC6B2llgDthiQHdnO3eD9wYLVw47lkYXU6mZvn6S5goKyko0iABLdRtJnoWKTeN57o
	 3I5sF1gOmEpld8QJRkfmm3wIHzNHjhcc18F898aLsIHNTzwBFTXiORrmkzovbQ/oud
	 61N74MU/Ii0R4fviI3oo1ye9aF2F5yR20AndJK3ZzHkgIRZfZBN2ECzmy6YkFLNAsu
	 nVFtSRjT62Q7eQXnudpIqMD7+r+wM62A64S+xXEF0JhVLK/lt5/Bday6/I3kpNNWzH
	 UczWkTOmvxDzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] netfilter: nf_tables: skip expired catchall elements on insert and delete
Date: Wed, 30 Sep 2026 11:44:34 -0400
Message-ID: <20260930154434.2936893-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930154434.2936893-1-sashal@kernel.org>
References: <2026092923-masses-playroom-aefc@gregkh>
 <20260930154434.2936893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

[ Upstream commit 70194dc37670bd08e44b471389861cc01bd3a3c9 ]

nft_setelem_catchall_insert() looks up duplicates with
nft_set_elem_active() only, while nft_set_catchall_lookup() and the
dump path additionally skip expired elements.

Once a catchall element with a timeout expires, this predicate drift
makes it invisible to userspace dumps, yet it still blocks
re-insertion: with NLM_F_EXCL the request fails with -EEXIST, and
without it the request reports success but silently inserts nothing.
The stale entry only goes away when the (user-tunable) gc interval
elapses, so the catchall rule may silently stop matching for an
arbitrarily long time after its first expiration.

The delete path shows the same drift: nft_setelem_catchall_deactivate()
picks the first active-next entry in the catchall list, so with an
expired entry still pending GC it retires the stale entry instead of
the fresh one, and it deactivates an element that userspace no longer
sees instead of failing with -ENOENT.

Align both walks with the lookup and dump predicates: only an element
that is active and not expired counts as a duplicate or delete
candidate, using the per-netns timestamp taken at transaction start,
in line with the set backend .insert/.deactivate and catchall GC sync
paths.

Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c1dffddd31be6..feb830a78ee3b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6079,11 +6079,14 @@ static int nft_setelem_catchall_insert(const struct net *net,
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (nft_set_elem_active(ext, genmask)) {
+		if (nft_set_elem_active(ext, genmask) &&
+		    !__nft_set_elem_expired(ext, tstamp) &&
+		    !nft_set_elem_is_dead(ext)) {
 			*priv = catchall->elem;
 			return -EEXIST;
 		}
@@ -6144,11 +6147,14 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
 					   struct nft_set_elem *elem)
 {
 	struct nft_set_elem_catchall *catchall;
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_is_active_next(net, ext))
+		if (!nft_is_active_next(net, ext) ||
+		    __nft_set_elem_expired(ext, tstamp) ||
+		    nft_set_elem_is_dead(ext))
 			continue;
 
 		kfree(elem->priv);
-- 
2.53.0

