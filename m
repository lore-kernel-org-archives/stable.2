Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117364FC33E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777149; cv=none; b=lDWd3oGjL743EVylot5OTXugDQrUoB8wB5xk+jZ0bbZSOp4efdDK8w/IJJRplcPm64BeNx6Za53+7ErpliQkW8dr9e2KG6UsQEBzk1xE1uFrOxGNMMt4egQVWsyGsgOHr0LLwk21RwxsEklrOOs3Aoc3ac95IRNykszELt7teRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777149; c=relaxed/simple;
	bh=mVDys4gkD788vYBpq5bSHkKtk/RYx9qHuU5XLg9nH5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDCEwXh96Hny+7+9i+65+HEHSe4VQmDDupV4zDCvBApWtEdvvuASXeOYfNe7nYxnpuh90NSMr8/1h/8lfgdJBjwbQyE+sN2ffoaLCEaAyUafaABjbd3y1/LF8s5LxYgKDwbF/xYvB7XlQ7TfQqGsFGbK3pzh57uuuy6vE0Gq6HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5CmKfF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5CmKfF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5961F0089C;
	Wed, 30 Sep 2026 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790777136;
	bh=kuV4QadfumiI6CTj1BHvfIQVZvFEUflifed6JP0D0ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5CmKfF1zcMI8Z6EfqGQ0gnPTbDGO7xgAK0olXn6Y+JlCw/Ld9/nLSIyoANx4TksF
	 ipr/VNj+/gd6qXYEoIswuwYMHksbaBVKsEi1pXTeX+/of3Or91jICTOIQr1md6Vku5
	 Ut1wgfH51cyVntC+FvVvJmytsH5EY/PzDXQPYYZquB0ioHHULvVD0kT4iTc4MrDsQ3
	 v2p1BVUZKN0vc5+iOys+phgCfbsFvK/1m4rWYaJBIrolasOWq7xiaAeYjq37MnthEa
	 aESYgR/OPlmSm2eO5ZxD7uouU+RNoI4mvRCb6lWux8VOHYcJw/zwT6x8duhruqqtdJ
	 e1GPn+tz7T7bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] netfilter: nf_tables: skip expired catchall elements on insert and delete
Date: Wed, 30 Sep 2026 10:05:33 -0400
Message-ID: <20260930140533.1823830-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930140533.1823830-1-sashal@kernel.org>
References: <2026092923-thievish-makeshift-9a83@gregkh>
 <20260930140533.1823830-1-sashal@kernel.org>
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
index 5238241c9a0b3..b64f25ef13dd7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6222,11 +6222,14 @@ static int nft_setelem_catchall_insert(const struct net *net,
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
@@ -6287,11 +6290,14 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
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

