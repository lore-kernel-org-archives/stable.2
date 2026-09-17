Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162F236453
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614836; cv=none; b=bJxJTTdVK1/aJWSG9GzTM4z6kZmVNUxCoaDVrD6dpN98dae6WZpnbIptOGyD/JwMfAS8SDJSnbWD/cE+bbPiUmI6f3Acw4So7HuBRUt4EiU0S13SLrOPXaT+7nquD0eDtBwHd5IZzNCAKwzmiUD4GNGtACJjUdYs1UY+3yFD56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614836; c=relaxed/simple;
	bh=mLl56zVhWFT6AR11oHhC81S4iZdTdM3dLAhioElqC6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+cmJ1EwvAny6BJ7A/3C7luyPqPRLONxtlEwR2DMHobScheFNwWMoeF0vWHNsZfRy4yttCLPTBqz9bBkWJx/EvuMfdgyUNDWiEcJTLxP9ZKQxsJJkV3TkmXhdovs6oQ5vtWYRxf8WAZEfWIynPOu3nxNpHIcmAZ6YGebwJ+5F+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bARcytj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bARcytj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723601F00893;
	Thu, 17 Sep 2026 03:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614835;
	bh=nJEE143Ccza0AZwU+B/8TNWuzaA07hC97tn8QqrFVhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bARcytj5SGS7vZvQamZF4dZFbz8g5e+zqevDI5ed60E+S5OSMdWURiauupn4UkoMj
	 W3k/3g5y2Eue4F+2ql48n0d4INmG0yRZ4QDJHIZLkwmMYbSv32rkylypt/abz06zJM
	 HIvaKBmZlvCzoueX+rhHgiKbxsScmkuvYvxrQ1p1JlDYQNXO/uu4TgkIlg4OsJxIln
	 nB4fRHl2VIYFZUCJ5+adZYvCJKu/+gVIrW1bvMkYXG2j455tOA1VzjAGnd1/CpKoWw
	 XwPIO4LsWeocOV5HBmwRzOZTiJafhHpebAT+5rlK0TtcRPG2BkPxg4nCBv2UsDZEU9
	 PX4hDu7/sOr+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] ipv4: use rcu in ip_fib_check_default()
Date: Wed, 16 Sep 2026 23:13:49 -0400
Message-ID: <20260917031352.3971853-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917031352.3971853-1-sashal@kernel.org>
References: <2026091655-synthesis-number-1f2b@gregkh>
 <20260917031352.3971853-1-sashal@kernel.org>
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
index c7d6b8402edbf..a31be77b93c1a 100644
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
 
@@ -1639,7 +1634,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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

