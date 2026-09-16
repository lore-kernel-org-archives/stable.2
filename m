Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1745111B6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566717; cv=none; b=SQcVsntMv95xqCJs0dkzfLtKAfT0QzEd/6VX1O/mLHJ0uVadlXBTQOMS2NlqM2YKja/4s3sf5vFHrkghmkAZx9PLcYjXbWoKt5MT25r0irAGxv6r3MSLaIfk2KgeQ+do8alR9fGNnghG+AiQ8HPk6q9ZPJMkCK4Jc6oXAK4X6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566717; c=relaxed/simple;
	bh=uXCi4fuCSiCT9Tu7CjX7MpfH+Gsem97J1P4sGaOmqgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMsPujyiENR/UbYHEbiVFxXpaSWmn7AvBex5bk6jNPdHBK0ygLlG0f3LsA2EMTJyPI+it1GSCeNngkm0m91qUa+4kyxPVQSmXx2E27r/2EQlgA1Uv7ROpUcRT3XPF6VUKXoK8F7tJ140UE1o++8Ad6/Mgqudl61QQDtc2rlB03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUaTCj85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUaTCj85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7480B1F000FF;
	Wed, 16 Sep 2026 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566706;
	bh=b3sNjpRBG9FFu/WN9kZqtY6U8mr5Pw+U2y+NvldSXC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FUaTCj85DFwPrPw36rr8A1aN7NUOYvIUeFjY1KS7vJW/VM0jBwOvpk8spzt7dpdXE
	 X7X0V8VHGVTP6fgQj30vczGZ9t3DeYio0DMAoCNcS3Fd0CUzl+gQrn5VAIBLw/rcGi
	 olMlvGCq0/SurBWJxWL07qLWy+LDwMs+uXofNOGSwP6x/8Bcze5BiVenJ6gX5+R12c
	 3y8oWTEAP/XXsoMCVH/oVaJZMgJR+NlhudnXcdjmDsLFeVMfdQ6+5ahA/95mEZ0nPJ
	 Q9ARF4o9L6l5p+4lnaUok94+xyDcRbKqFmXtEpVqbXjaerZsvGGg5gWmITuajtlThQ
	 /aruHVbzTa++Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ipmr: account multicast table and route memory
Date: Wed, 16 Sep 2026 09:51:43 -0400
Message-ID: <20260916135143.2732471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091602-anaerobic-outskirts-27e7@gregkh>
References: <2026091602-anaerobic-outskirts-27e7@gregkh>
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
index 6cf95defb01e1..b1282c01a77e0 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3325,7 +3325,8 @@ int __init ip_mr_init(void)
 {
 	int err;
 
-	mrt_cachep = KMEM_CACHE(mfc_cache, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	mrt_cachep = KMEM_CACHE(mfc_cache,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 
 	err = register_pernet_subsys(&ipmr_net_ops);
 	if (err)
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index e6bb023e8dbd4..15f90658659a1 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -52,7 +52,7 @@ mr_table_alloc(struct net *net, u32 id,
 	struct mr_table *mrt;
 	int err;
 
-	mrt = kzalloc(sizeof(*mrt), GFP_KERNEL);
+	mrt = kzalloc(sizeof(*mrt), GFP_KERNEL_ACCOUNT);
 	if (!mrt)
 		return ERR_PTR(-ENOMEM);
 	mrt->id = id;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 61e61e36f0907..d59d31ab960a5 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1393,7 +1393,7 @@ int __init ip6_mr_init(void)
 {
 	int err;
 
-	mrt_cachep = KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN);
+	mrt_cachep = KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT);
 	if (!mrt_cachep)
 		return -ENOMEM;
 
-- 
2.53.0

