Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4C2BE033
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617566; cv=none; b=UpQ6of3C7a5LK6PxOOgiWKeX9vpWbi6+BLqQwGgyEyXOcf09t5CCWGH0VsZJcH/XdwG9C2jr05JKC52PCwvBJ+2vpZPn9abx+zfjBuXDI/mVxBTo3loBIwPbQ1YiSLGB/QPaSUiK6OXRF577JlVsIpxakj8JPpSv+Cg2RyJI7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617566; c=relaxed/simple;
	bh=2KtuJedEMzQdUKTkSlIXvB68BUlDsd9cRDv7RXWTOvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJ4e+SsBTmtwBX0IxH044lUwpPrHsTu+JvPN+vSME/UW3D6dSXGC6N3Kq437bmMzoiSOUAgvkgc2h9DSFUyUPWTSeHYLaUh64ojyZ8z100OiGxgfV8wNyfv1YqrN+oXkqpjDR3J++JPjhOFRQiYr5O5hVd9EcsCBRnop6nWDbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5xbm9JB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5xbm9JB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1475C1F00899;
	Thu, 17 Sep 2026 03:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617563;
	bh=Kvd4R2eRaAIXvNRfLpcJD2df1u9InHYGrTZ5gMeyHGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5xbm9JB892O4q4oH4jTC5e+ImQm7LzCw4Xo452D4TNBhWgLHKyPCMR2vN6ZqZxLC
	 1iGJeZpD3rSxzIzXENsKyitNEoZo+oFtWLMU/d9M0gN/CEXVV2j6XdWKEWIFaf0z4m
	 Ele3wmqpG1oM+CWjyg9O/9SO1Mw2ofHaWfjIWBpRoMs70kqDA/qstQ/W8nwlyO3LaW
	 EZM/xdJqxxamzyz5NLhXBmIs9eR81QtraDDa00cUU9R3zZ1L2D+0/41Y0Y8HZyYHQ8
	 ziDk20x2EgTa2dJn/shwB1zxmQyWRBJwZ4qTEW+DxVK3TSPYK5pzSgdmsHc/mcMezX
	 09GPwAixU52pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] ipv4: use rcu in ip_fib_check_default()
Date: Wed, 16 Sep 2026 23:59:17 -0400
Message-ID: <20260917035920.4132418-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917035920.4132418-1-sashal@kernel.org>
References: <2026091656-disparate-pang-cc22@gregkh>
 <20260917035920.4132418-1-sashal@kernel.org>
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
index 473725e77267e..aade1806f933d 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -275,7 +275,7 @@ void fib_release_info(struct fib_info *fi)
 			change_nexthops(fi) {
 				if (!nexthop_nh->fib_nh_dev)
 					continue;
-				hlist_del(&nexthop_nh->nh_hash);
+				hlist_del_rcu(&nexthop_nh->nh_hash);
 			} endfor_nexthops(fi)
 		}
 		/* Paired with READ_ONCE() from fib_table_lookup() */
@@ -432,28 +432,23 @@ static struct fib_info *fib_find_info(struct fib_info *nfi)
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
 
@@ -1640,7 +1635,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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

