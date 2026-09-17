Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA3374185
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611543; cv=none; b=giomtyc2i1raoV6dOj6IRag0Zn72FB8RoGsdC+IzTRfn8wVQ6G85dIRC8WG6vijkriQ69FyDJ4X4nnJ+JePiFfwsrlATsJAlreTvhHdczoCosRAo/QnyI7uKxats1+Eopj4JUEmXEByMkk+ljH+CEVhlCxxemN5H6nDaFb0Fd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611543; c=relaxed/simple;
	bh=meiwtw7qKAyI2mHw7ezTpgHAg2IhytBe6bs47zSy0Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+T5HtVI+Xx0LUvWYb3b94jlqHVUv9ETMqmDNMoN9AEj1Ik3+oRQWPxwovB30b1xltF+9VLD36y4PY0i6ZBVUUeBU9yiz+Xc5ZG4GhK0NE8JkGin5L34QFIg2pWg0S3Qwlzpp8SEuSsAZQahbb87/As7EBpY2tZwOF7EF+amREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQysRhYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQysRhYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D961F00893;
	Thu, 17 Sep 2026 02:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611542;
	bh=N4gNkt8j2RccEJkvA/y3mI9BnZ8G5Bw+sYrmkJFEdq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mQysRhYJxSrFZfykXVn+7l5ZdSPOznz1CkrQBKUu/RRt2pCM4y9biEJc2kAkTyOcS
	 oMVKIDidaD8mmQ8ghF+61yTivYzCkep3BLp1tkgWFR3efVJCJYrZ4G1WvNTJfZVt1G
	 OkSnHOzpEev3WOCdzEkPWCFqPrgQ4XdTaURL4dK/tn1C+1Yr/V6w4H5IwFp+uL9SSG
	 lvyHCPuDkDFtRqgpJd6BVtshGoLSlV2KvAt964FILpzMC7utwCUM41Imt52qm2bqgm
	 I3BpyT+yLP9tVE/iYMPsmX8yNs8WrdmogpPPWS66zsuvsrlkTnCy+fQk/osLJ5DoON
	 pivCRuI2F2RIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/7] ipv4: use rcu in ip_fib_check_default()
Date: Wed, 16 Sep 2026 22:18:54 -0400
Message-ID: <20260917021859.3810309-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021859.3810309-1-sashal@kernel.org>
References: <2026091655-dejected-hammock-755e@gregkh>
 <20260917021859.3810309-1-sashal@kernel.org>
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
index 6404005d4d97b..8c20209fbff35 100644
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
 
@@ -1638,7 +1633,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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

