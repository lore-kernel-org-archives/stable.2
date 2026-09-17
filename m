Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86782DECCC
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618098; cv=none; b=ibpJO4lMoaFzA8IXMCwgM9ESajFtEHG333YAwfWXOE+FwCdYaP5E2+DihimFwZdNjRSeK2hLvGw3scyP23yUqE2MuIgqDoJ7X3HkfA7vGIoSQoRiCmQS9XUbbNY5QnpetqUIQQUePNeB6sPx2nJ4n+4EKTg+yf6VdYsSXXqeOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618098; c=relaxed/simple;
	bh=Ae80rqDW+mhkOfpDTkrTy/MeJktnWY0xCTEfktz6avg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urxkSQ5mX4jcipsuQwkxjYIe/Iq68Qpezn1hekJoKNY2SM7kKuOmYS7kgY4fcS8ExnSXCrqjBR5Govm2MEwlz+AecTvkD//xQxaSuwUCme9vtytdh45f3zmbolAs8TPxjv79OJ87HmeXv694GwgUWrQ2acjcboskJTnnvoHDD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwDeU73e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwDeU73e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8891F000FF;
	Thu, 17 Sep 2026 04:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618097;
	bh=syGCaYs6qIvTnItA/vTtFQnQ1p6FdiplWtmTIoZmEik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwDeU73eASj1/b5R+cDPpzoWXsz79NxznIDdEL9GO6lo2Rv5ktX6+lEGS07to7Ftl
	 zEI7ZYKmELSXRCcWijFc6EJ+ouEp9bUmb4A75yKQiMg1F6rfkm9I/T3vKsr0sgN6C8
	 YA+WfQW+/SW0/etjePn2Zp/6pIQ299mk39ehzxCxODROLkhpMKWtgDnI4A5W7id01C
	 R5fcXk+05jwxODbPWM4hckRdobP/U7BzsOm2uBIKBlsKDkbDwMKikBTgbCCn1jo+x0
	 Au6gnkyOReEImIZshkH2EH/F6nAFPNJo67++DrjrymxfbMnm4scwH6A6uxqFfpwq9P
	 YKXYtEDSZh4fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] ipv4: remove fib_devindex_hashfn()
Date: Thu, 17 Sep 2026 00:08:11 -0400
Message-ID: <20260917040815.4171498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091657-voter-although-5ad8@gregkh>
References: <2026091657-voter-although-5ad8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8a0f62fdeb9ea66ad3d0e959c7c4addbabeac1be ]

fib_devindex_hashfn() converts a 32bit ifindex value to a 8bit hash.

It makes no sense doing this from fib_info_hashfn() and
fib_find_info_nh().

It is better to keep as many bits as possible to let
fib_info_hashfn_result() have better spread.

Only fib_info_devhash_bucket() needs to make this operation,
we can 'inline' trivial fib_devindex_hashfn() in it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20241004134720.579244-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_semantics.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index ccc59b4ca019e..f82d1d93c1b55 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -320,17 +320,12 @@ static inline int nh_comp(struct fib_info *fi, struct fib_info *ofi)
 	return 0;
 }
 
-static inline unsigned int fib_devindex_hashfn(unsigned int val)
-{
-	return hash_32(val, DEVINDEX_HASHBITS);
-}
-
 static struct hlist_head *
 fib_info_devhash_bucket(const struct net_device *dev)
 {
 	u32 val = net_hash_mix(dev_net(dev)) ^ dev->ifindex;
 
-	return &fib_info_devhash[fib_devindex_hashfn(val)];
+	return &fib_info_devhash[hash_32(val, DEVINDEX_HASHBITS)];
 }
 
 static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
@@ -361,10 +356,10 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
 				fi->fib_priority);
 
 	if (fi->nh) {
-		val ^= fib_devindex_hashfn(fi->nh->id);
+		val ^= fi->nh->id;
 	} else {
 		for_nexthops(fi) {
-			val ^= fib_devindex_hashfn(nh->fib_nh_oif);
+			val ^= nh->fib_nh_oif;
 		} endfor_nexthops(fi)
 	}
 
@@ -379,7 +374,7 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 	struct fib_info *fi;
 	unsigned int hash;
 
-	hash = fib_info_hashfn_1(fib_devindex_hashfn(cfg->fc_nh_id),
+	hash = fib_info_hashfn_1(cfg->fc_nh_id,
 				 cfg->fc_protocol, cfg->fc_scope,
 				 (__force u32)cfg->fc_prefsrc,
 				 cfg->fc_priority);
-- 
2.53.0

