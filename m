Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7A386C25
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618099; cv=none; b=RJ3PZFK639H9nI7rmfa+Kg3f/cKq+3aZvasl8TLv3WrpsrUXEZJTJCE8JyHRIDk1c4nIuCF92EsHoBHtPeHM6RVrYZejKzp1E0ag0op4GxaSr9zM6+mRmF9oqTzi0iw5Y2sQygVcR/GAco7yaIiY7PolkfPOKJb4hs83XYmPROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618099; c=relaxed/simple;
	bh=CI+mdzVqXsLtxAHpYZ2SaPL6HRNt4OfKSKXdcLpdYks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7YEg+LiK7fZxGYv6tweBZyIzCNcAcQa3gxxPHc9fs2dZUbCJgTZaz1dl7yYC/gZRJqL5OvBVqxfa+yAB3khj+KPyZnNiz+JwJ+hpWjMv+q77WAX9YAZe3WOUCt4o6BQgF5ZSIDFNGnltibK83afw6zO7Hzpb0KH7z9QSy2sxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtIvQzgN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtIvQzgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6711F00899;
	Thu, 17 Sep 2026 04:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618098;
	bh=MhcllfWWpE3wmGvijv5C8AFFviAo9b7M0D32HYs1KaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtIvQzgNUrtJ60tR5EpiIdhI/t0bBgNUALMi75oyhpuwPWUmEJF2Nl70cHKdEye9Y
	 Am3hheo7NJf8NZy+vABBw6z+hNVV7Dwbq8F8g1+SCikc+dFjkKdxAkzr6WhDYCBxzW
	 aGnTWTZwOtTgHdhfnrUs5/nCBA7dVJy+W1AJRxxDIf4f7U2049TU74dBoy3CJb5aSi
	 dVMRxoKidHEIS2zIJLpBNfOZOZhk/QIaw1VZILBRH9dtqWC+xDSY8+HWoc8fKXa/zR
	 eJCj616h1r3hj8JyVY6ylczXcNkCLfy9paQBWYuNJhU+O6kVGLgXbppSdaAjCrtanM
	 KTOmqYfkoWBbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] ipv4: use rcu in ip_fib_check_default()
Date: Thu, 17 Sep 2026 00:08:12 -0400
Message-ID: <20260917040815.4171498-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917040815.4171498-1-sashal@kernel.org>
References: <2026091657-voter-although-5ad8@gregkh>
 <20260917040815.4171498-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit fc38b28365e5f1396209d2878a34065468765087 ]

fib_info_devhash[] is not resized in fib_info_hash_move().

fib_nh structs are already freed after an rcu grace period.

This will allow to remove fib_info_lock in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20241004134720.579244-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_semantics.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f82d1d93c1b55..9b47a931e5ed2 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -273,7 +273,7 @@ void fib_release_info(struct fib_info *fi)
 			change_nexthops(fi) {
 				if (!nexthop_nh->fib_nh_dev)
 					continue;
-				hlist_del(&nexthop_nh->nh_hash);
+				hlist_del_rcu(&nexthop_nh->nh_hash);
 			} endfor_nexthops(fi)
 		}
 		/* Paired with READ_ONCE() from fib_table_lookup() */
@@ -430,28 +430,23 @@ static struct fib_info *fib_find_info(struct fib_info *nfi)
 }
 
 /* Check, that the gateway is already configured.
- * Used only by redirect accept routine.
+ * Used only by redirect accept routine, under rcu_read_lock();
  */
 int ip_fib_check_default(__be32 gw, struct net_device *dev)
 {
 	struct hlist_head *head;
 	struct fib_nh *nh;
 
-	spin_lock(&fib_info_lock);
-
 	head = fib_info_devhash_bucket(dev);
 
-	hlist_for_each_entry(nh, head, nh_hash) {
+	hlist_for_each_entry_rcu(nh, head, nh_hash) {
 		if (nh->fib_nh_dev == dev &&
 		    nh->fib_nh_gw4 == gw &&
 		    !(nh->fib_nh_flags & RTNH_F_DEAD)) {
-			spin_unlock(&fib_info_lock);
 			return 0;
 		}
 	}
 
-	spin_unlock(&fib_info_lock);
-
 	return -1;
 }
 
@@ -1657,7 +1652,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 			if (!nexthop_nh->fib_nh_dev)
 				continue;
 			head = fib_info_devhash_bucket(nexthop_nh->fib_nh_dev);
-			hlist_add_head(&nexthop_nh->nh_hash, head);
+			hlist_add_head_rcu(&nexthop_nh->nh_hash, head);
 		} endfor_nexthops(fi)
 	}
 	spin_unlock_bh(&fib_info_lock);
-- 
2.53.0

