Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6B4C2259
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574507; cv=none; b=sGTUd0lwqgIGAStRZEOcX/lmnBNXDnUX7Nj01fhWdt83WPD6qDUrWg4WTi6BOv8L4k5hf2wvor1FMjPBB8SuIDBBZqMl6ojFrQWyCoHmgAog3V77ngSfOJ0ueY8XI22HhUuubADoIL/lyFme1SyYw0flID7tH0/ZtJ+64v3yWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574507; c=relaxed/simple;
	bh=u/X7WxMvRGr0vNXs96N5tTXDg8VGIpO74BZrPfTrIhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1GMoBKeox2WJqCPARi4fyXbDwqqVlYN35f2qjtGxmZqbioShwpMzLPzMYhi3kdrNmFkrwwqL/2P7wguQpa6vFkg25ZDloXiIb8JxnDRHKLFj2zSqVfl0iSDU0VOTEcsDYpLbwittKNgxobzyNmUE6OpHFkFVS/sVCS4RImx3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNr7rIVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNr7rIVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853B41F000FF;
	Wed, 16 Sep 2026 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574505;
	bh=9LEfzaqy4/F/GrMB/TfJ2ftF7HIliThV65MbqtDf7Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eNr7rIVkWKmzgAbCNQ36ftgqbIeOFQfQu09Y6K5qV83dDZasNfRT+ohfkzJ6k98yo
	 Z7jXjdjYeJY852rtfiwH7rJfk+VFjnWnPFtQTLVTvZVgg4UfUt8kEFa4BxaeGSLACC
	 Y5HtEhVYOepjrYZsttM1LZPazL3FSZtmUzP/qWAzjiUxNli61RiAXaYaWBmMkgQ72G
	 hIuIUDVpXgyVMQjiVa7GQSpXnwYhgYHqfx7nfoFEGC++fKhpHaGyzAlIyd+aLj2ouL
	 ECWKJ7DWL1vhy+BTvo/5tgkb1Z4LRg5aqj5LQvdu30f1gWIa5w3PDiQ0E+EE7Px7qt
	 CRDTavIsVH4Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ipmr: account multicast table and route memory
Date: Wed, 16 Sep 2026 12:01:43 -0400
Message-ID: <20260916160143.45991-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091606-neurosis-primp-db10@gregkh>
References: <2026091606-neurosis-primp-db10@gregkh>
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
[ adapted upstream allocation helpers to existing kzalloc() and kmem_cache_create() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c      | 3 ++-
 net/ipv4/ipmr_base.c | 2 +-
 net/ipv6/ip6mr.c     | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 5e582eab1ea19..d5ae2df481a48 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3115,7 +3115,8 @@ int __init ip_mr_init(void)
 
 	mrt_cachep = kmem_cache_create("ip_mrt_cache",
 				       sizeof(struct mfc_cache),
-				       0, SLAB_HWCACHE_ALIGN | SLAB_PANIC,
+				       0, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+				       SLAB_ACCOUNT,
 				       NULL);
 
 	err = register_pernet_subsys(&ipmr_net_ops);
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 8b5b6f196cdc4..fb9796e21074f 100644
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
index 909a2bc2a020d..a793dcd24813e 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1357,7 +1357,7 @@ int __init ip6_mr_init(void)
 
 	mrt_cachep = kmem_cache_create("ip6_mrt_cache",
 				       sizeof(struct mfc6_cache),
-				       0, SLAB_HWCACHE_ALIGN,
+				       0, SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
 				       NULL);
 	if (!mrt_cachep)
 		return -ENOMEM;
-- 
2.53.0

