Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C43B27CE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617566; cv=none; b=GoKwDypIZd2vWLwQYXCIhG5KMoQVjmdxk2nqpXUuaa+ZUu1FG1Khmpv9ku7znun4ZWmeD10THtK5NMm0ZAl7LWZ1oe6qbMbWeRPZjaaEy+qjYAZuoYBZrhN24U4f176/+5iudKXaOXAOkODwmAt7XZQDYIam6TgALqbyCpzHia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617566; c=relaxed/simple;
	bh=bQoFmGjygcaHjTOvYtacmfAN6yEc1v9wvu2OE+dFbks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ7puuSy30p9nK2jlu/Rd6sNtlpkGGTqh7CUdmFjGFamTyBxQFWOJt/gWPRNmC/ySXvDLBVfGlInBqlTb8mtvtarSHetnwi+eRFwYTXnvRRvf8uUR4KWqlWgaNiSSYGuSqHxdSdLYXwGRRD1pvU8PoQwAye2NLw06Q8MdCZLF70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY8fqpDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY8fqpDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBB01F000FF;
	Thu, 17 Sep 2026 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617562;
	bh=Y2tcxT7AnWRFkcWuYHmZhNkLX1xlzD7JwM+raqGw5t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HY8fqpDkY+K6lSEgGi4dIluQvVSdKPKLqcM8AVot5lW7QYYlFVbQWo6KZQXbI2VJb
	 l42FXZ0LIq7AC9yN05cSOao2Vct+ovKr3bym++0ks7vnJwIXpw6GKCeBoJivb7QxBH
	 2PfdK9zdadv5zwQwSZJZGLyVS0unsU8HwwV5HASz5Kuo25nmJhOIrRx7gL7y8ltrHm
	 ZXLb6kwzLAAxNmEk1lH6V/nZP1+48V6Iui81iYVcQVMrZqAeuyMfUpLTIUhpvtwtVb
	 riDNwi/CCrzWvFt3Q5EO5+8lH0gRKc0gH1iTjyW4QMBNQJlr8BKecqTMIgW7Plk2q8
	 +JgfQ51PIc3cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] ipv4: remove fib_devindex_hashfn()
Date: Wed, 16 Sep 2026 23:59:16 -0400
Message-ID: <20260917035920.4132418-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091656-disparate-pang-cc22@gregkh>
References: <2026091656-disparate-pang-cc22@gregkh>
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
index 674062511ce0d..473725e77267e 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -322,17 +322,12 @@ static inline int nh_comp(struct fib_info *fi, struct fib_info *ofi)
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
@@ -363,10 +358,10 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
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
 
@@ -381,7 +376,7 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 	struct fib_info *fi;
 	unsigned int hash;
 
-	hash = fib_info_hashfn_1(fib_devindex_hashfn(cfg->fc_nh_id),
+	hash = fib_info_hashfn_1(cfg->fc_nh_id,
 				 cfg->fc_protocol, cfg->fc_scope,
 				 (__force u32)cfg->fc_prefsrc,
 				 cfg->fc_priority);
-- 
2.53.0

