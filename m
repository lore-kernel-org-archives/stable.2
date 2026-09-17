Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B736E477
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618589; cv=none; b=rifK3oyvMptuYgCrvduOeAoE0qlPL0AonB9s3gq2QpsIUH5Ux2y/n7pBCH8n5NUvS8hRQmlKtvSw7H+XUFP51qVIK/ACgUtkbNapakdZEWqylDTIsjpBbbGe36/nxI0fKhtrzigQh5PFc8Gskj0db4JAiXVP8jokPql/rQqwXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618589; c=relaxed/simple;
	bh=GvCfAGWfryb9EVfuNcbjLpROssqHTMPPZMs/ORw1+FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmnjp4okixppyzfUr0nxKujJQTCSeLOxAdsn308r7QYftYv/zh2BUGz7o983hI/GUPkqgjq2p6Iqhgp887GwceX3MopUv79TsSsW4SGjLqEAQi+ibpPcgMO0GiudKzulcr/tY73TCDhpFvEdK+u0jjYjtxQzZb4DjpGFeWyADsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgrXaexG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgrXaexG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACABB1F000FF;
	Thu, 17 Sep 2026 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618588;
	bh=yC89rfKhllr73TONSKJ1f68uknez3bagwneOrnK3Tqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RgrXaexGKo5bhbAVyWl7l5HVdwYu2BTp3GPfrGVLDzkAhNVIaQio6eMDAuLkrAtKd
	 5OW5jmXeQcijq0aC1fRfNwOjIHAt9FIYXeCrEVipcD+dky+KfBldyDtjnD9UOo40bj
	 9698K3YXQmstfwcQiKxejOW/7pl5KYxgt6C3uVg0X70IOzx/KCIBcKrwFqBVxWzYBv
	 +spog5vn4xr39zPKiXFvezovfxSQPFI0yHNhJ8qdrE53V7owOxvApIxAm8T8TVF5FI
	 RAIxDMRKlNqYa6u5eS5PwlqyztGRUiH6vpzH+nnqKZpb1JgRB2QZS161fLL24c8bgc
	 qUwNRGvCYS3Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] ipv4: remove fib_devindex_hashfn()
Date: Thu, 17 Sep 2026 00:16:22 -0400
Message-ID: <20260917041626.4188780-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091657-spree-snowbound-d932@gregkh>
References: <2026091657-spree-snowbound-d932@gregkh>
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
index bf722eb5efac3..bff948df756e5 100644
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

