Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC74FECDD
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567023; cv=none; b=cQoTzSVSOYYE7793F2CCgu+ekOopDqO6t6hoZFWgkmvH+3eTj2xV19w3w+S5I9jMPj/sQsqbgb2aa4ct4PvNnlqqcnwSlFEmJDCaaWlDKzi1yQkMAbXEslhenPpPcBAt0Iy0deKUX0X4AFkcphrqSZ/KOS4RUf+CKtpJEtBQhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567023; c=relaxed/simple;
	bh=R6zZgA4+dxBCZuC93z/Dn4bSURIgZMOE8dnPxTSHyxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJiG8ZHSyTKHcsN9TU/uZ+IZHzWld/NxAq1vcfIrhzvoCQriUTOkbJ53TCTUMsJx+NrcnqVeCpuMlnMtxev/76xDDJBYjOfbJaq+/lP04GwngGaGJTYpFTrjLMPne4BdoXhhuxhdwx4pmeXdXv49QGbccWUURo113H7vT9TrHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzWqQxFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzWqQxFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF2E1F000FF;
	Wed, 16 Sep 2026 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567019;
	bh=kbafuMiNoRatGTL0afSvAztaZx3wqfJA8bivuqi1tbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzWqQxFcOrrkPFWL2hJHeqvoTF/mZRQ2QapT320456QNQEPvYJLjxm7ZjCGyWz60q
	 K+l+YllzBbvsPuzbScs+WDmdwfnGrrrDTpgZoJtdqOaMa5vWCEWhzqk1xugIjB35zT
	 qjgBsQEcqKUzUiI93gFz2SdUm2WI9/popTHS0vf54SqfrBC/Wa4/852iEa1qwtzscj
	 lyKJHCh1TFurlCRNj7L2RYCZKG0WdnT3Fiwdk1GInNpnBUaA28gDSj5/HROF6cfgJ4
	 JJKcrrirc0rGXEc5ldHsLu5ix8zKwvw0MJUVnStnBJXRWQtKPMj16SdwQ6SIMhYrGn
	 7O2VOVRRbHb7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ipmr: account multicast table and route memory
Date: Wed, 16 Sep 2026 09:56:56 -0400
Message-ID: <20260916135656.2747801-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091603-unstuffed-goes-e540@gregkh>
References: <2026091603-unstuffed-goes-e540@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit b7ee18725f2292ab554aa96a101ae42d45f008bd ]

A netadmin in a user+net namespace can create many IPv4 and IPv6
multicast routing tables with MRT_TABLE and MRT6_TABLE. Each unseen
id allocates an mr_table via the shared mr_table_alloc(), links it
into the per-net list, and leaves it until netns teardown. Those
objects were not charged to memcg, so the host unreclaimable slab
grows with the table count.

Account mr_table allocations with GFP_KERNEL_ACCOUNT and mark the
IPv4/IPv6 MFC caches SLAB_ACCOUNT. This matches the established
handling of IP addresses, routes and alternate interface names.

Unresolved MFC entries are still allocated from softIRQ with
GFP_ATOMIC and are not charged. They expire after 10 seconds and are
bounded by the socket receive queue; see commit 0079ad8e8dc3
("ipmr: remove hard code cache_resolve_queue_len limit").

Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/050b58f7fc6b45da0fb12768ebb62d18fa46133d.1788784801.git.zihanx@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ changed kzalloc_obj(*mrt, GFP_KERNEL_ACCOUNT) to kzalloc(sizeof(*mrt), GFP_KERNEL_ACCOUNT) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c      | 3 ++-
 net/ipv4/ipmr_base.c | 2 +-
 net/ipv6/ip6mr.c     | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index f0294b1148246..3b31189fea883 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3159,7 +3159,8 @@ int __init ip_mr_init(void)
 {
 	int err;
 
-	mrt_cachep = KMEM_CACHE(mfc_cache, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	mrt_cachep = KMEM_CACHE(mfc_cache,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 
 	err = register_pernet_subsys(&ipmr_net_ops);
 	if (err)
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 28d77d454d442..66fe1a253b9ff 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -38,7 +38,7 @@ mr_table_alloc(struct net *net, u32 id,
 	struct mr_table *mrt;
 	int err;
 
-	mrt = kzalloc(sizeof(*mrt), GFP_KERNEL);
+	mrt = kzalloc(sizeof(*mrt), GFP_KERNEL_ACCOUNT);
 	if (!mrt)
 		return ERR_PTR(-ENOMEM);
 	mrt->id = id;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 68bc518500f94..9bcd64e99f159 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1387,7 +1387,7 @@ int __init ip6_mr_init(void)
 {
 	int err;
 
-	mrt_cachep = KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN);
+	mrt_cachep = KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT);
 	if (!mrt_cachep)
 		return -ENOMEM;
 
-- 
2.53.0

