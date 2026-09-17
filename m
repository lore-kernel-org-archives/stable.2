Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904931E9B3D
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618590; cv=none; b=ks84nkkbOQarIza/gSTuV0fiPdW8hT87mJM7Sg+MI344UbWTSgZOP7Osn5BG57VWQAb5xX4xfoc/wHDJwlkNN/JNm/lh4/iQHz65vDRKRoOUPGhi+/TexihhZBuDtJ9OB5eG838+e+3kLpp8Y3n+bjCtaU+Tgtt5QBLs9o0eSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618590; c=relaxed/simple;
	bh=zeTG/7KSea3d7aucI7WjPUuzFKrQIe653E0jxSe6dZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwVwOIlLYFvq5L/AXfQwzELHHmmbG6WH5aRa1EMlztkyrRScrdf365IbWdF3SLuWyZNQOsexg4bXriZhuWGEWiKBleCxPSr0xzr+5sl6oErI99T4xcY+BEh4xO5QvVDvPzJyb4S5TpBgvst7uh7KdFXuBjjVcw3cbshE1Kv0JxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emMbWkvJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emMbWkvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9439B1F00898;
	Thu, 17 Sep 2026 04:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618589;
	bh=zaHiUu0atfdExcW4ejnrd6edcwSr4lzHxH5MFeXXJR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=emMbWkvJz99Sh9wQI4x2A50sSLc+j8Euj85NaMxNX5OxI2Jz+J1f8w/4SbS6ESiIL
	 31DRvnq9yONyLqJYz9jJng5Wp/vAUblx4sZFa7Yicss9MShO7/yk6nBjgA1j1RZeDJ
	 wYqT428SRVfbYkNHvppwbNz/m9eVMs++y9kwTL6Wmtcs51FWcJ91pzC+LJGaJYmKNJ
	 P+Skxe2PNwywKS01Qhnmi2mm0xsvFX8wkYc8/Vk4JwWob6TC37wGw4Ij9sAgJLg7Z3
	 fVNnUCEgsfBEg801mulfUDXo89ziKIK+ztmCS6Lec2wc8ofOffqEgU0969begXZaRg
	 hUhjaM8akFlHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] ipv4: use rcu in ip_fib_check_default()
Date: Thu, 17 Sep 2026 00:16:23 -0400
Message-ID: <20260917041626.4188780-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917041626.4188780-1-sashal@kernel.org>
References: <2026091657-spree-snowbound-d932@gregkh>
 <20260917041626.4188780-1-sashal@kernel.org>
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
index bff948df756e5..2dd1a1498d5de 100644
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
 
@@ -1656,7 +1651,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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

