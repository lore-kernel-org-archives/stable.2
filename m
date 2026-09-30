Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37F47425C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766864; cv=none; b=VYOlj2Ybyi0FYtD3AJ6MkM013dHmmsITPMr3tSUncy3/w28B/Clr3XoyuTI1AO3zYZ/XYf91qxJRxhPcNA2a+cEDJyVeKHSw0x8sAKpZ8vU6VD9p3QJIp9gR1FrwmMoZOEcVJcsx6MVLLYaJLPsdRscoGMY11QrFPYHTPjWO+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766864; c=relaxed/simple;
	bh=e9AAiu9MmMIjj+2d0DucEisxL9rOwlUPGSkydNUaMLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCvzNbbvhfLWH5yBR3PjTES2M8/q/eGRv4Yc0pTBlSz6a09PWQZGFECI7/+NmNYkQmfiipwtL3ByWGgVm9t48tT89HMBTzOVhG3NJHm/bL6oMHlAULl92guQeMG+z1NVCeSB/UoTxhjImF0Nm2wgeb8suLWmA/nkBK7PBuSMPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXxtCM3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXxtCM3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833751F00899;
	Wed, 30 Sep 2026 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766863;
	bh=6JljoI09HKfsFQdy3mTopfEOARsTMStDZcFf8N6Wl9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXxtCM3tTjIddyTCIsysbNM2mEuTSvygHqKkhXP8cijvs5y3cpnA8EuTxpOk8V0ZP
	 b+mNVPdT72VBviol6bEr+zy48eCvLNyR8NlCDBAqI+FX/HlzCTS4QiKxJhivZSLXre
	 JW1yRXcGYlrt8cS4Su8jT/dgBetcaKmAPJATQ/902vTSk4AyEvb/tQrpNPu9oxFOXK
	 yFpEliXJXIBX2yGo//G84miarQUGHrwMUSad+75fgk+1TcYMtnoSlRlvpYaZubzUni
	 B1CvRHCPlP52Hmgro4R6jzuHra+hxbberfdnVHS8Fhgkz842893vF7MVBiQCu2mTBe
	 WFpb+HHuL8D7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] netfilter: nf_tables: skip expired catchall elements on insert and delete
Date: Wed, 30 Sep 2026 07:14:19 -0400
Message-ID: <20260930111419.1207335-3-sashal@kernel.org>
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
index 66bebe2f25f9e..1709cf4434f68 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6557,11 +6557,14 @@ static int nft_setelem_catchall_insert(const struct net *net,
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
@@ -6622,11 +6625,14 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
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

