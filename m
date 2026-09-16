Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2A32B10F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573766; cv=none; b=c3yNfih8UJ4WTAvY5Kah7lsoiUqXvgiUuvpQ25mnSMpSXYBeP5YLcozL26MfHVCGpMXxj1hyT2ca/9C0RNoDC2w6eGRQs3dJQbV5hLzlg5h6eYCIMMVFmSbWHulAvleIsyXGFZyY23SHrN9vKQOUfqiZKMc0XHZ5y52grK6Bujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573766; c=relaxed/simple;
	bh=94LKG1C67NuEZOghWnWcDPYe6I+qR+unMjY0d2PJud4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeT1/IWMywp18x4zGsTb0zCsh3rEDeyg0mQnUMidsHeqykuyL9wmAJl2R3vdWLww2qQSYs3LxKBJKQslAcdgzx9XFQ3AmshhL8UecXekN2mECVdEo/RsOJeoYysXrE8r4QCjS9cTPpb6P5mCE3fIedaAf2w/WzcZ642ee1zbnMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Cd6amC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Cd6amC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78A71F000FF;
	Wed, 16 Sep 2026 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573763;
	bh=Yyu92bykOOiv6Ibzj7Ms1eW6TGCVNKYJ0PYX4bjnxg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/Cd6amCBK8ihEVf/Bekdth0fL28gwZX1jViq64C4KcyhAPE9mJl2qODGCdavu/qS
	 d2yTYZ+7Vv9WgRQo7MGNW2Z+lbzapPkOJ6wf/a4ThUh9fk9bPnC2zDkpoLgKCZCVme
	 Tp2DoNDKoJRhMQzTIjeAdDuYDXA4MMFFHoMBkudd/R66/+EvjOXEw5FEpVsiMmdBi0
	 jpPF1R+7LEAdLjBKd4pVliHVsddSy7h424pIFBys7WcPqn8Eo9FCg3KYXtaE5il5zP
	 9HlswWrZf4joYCk2gykntaDEgAc7jYcD+1S/Xd5RQGqMZBGyz2YeWk1ni+7PVH6z90
	 Daczk8qUtaOOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ipmr: account multicast table and route memory
Date: Wed, 16 Sep 2026 11:49:21 -0400
Message-ID: <20260916154921.4169091-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091604-blurred-reheat-c2d3@gregkh>
References: <2026091604-blurred-reheat-c2d3@gregkh>
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
index f39cd565569a5..127473aeb7e32 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3159,7 +3159,8 @@ int __init ip_mr_init(void)
 
 	mrt_cachep = kmem_cache_create("ip_mrt_cache",
 				       sizeof(struct mfc_cache),
-				       0, SLAB_HWCACHE_ALIGN | SLAB_PANIC,
+				       0, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+				       SLAB_ACCOUNT,
 				       NULL);
 
 	err = register_pernet_subsys(&ipmr_net_ops);
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 28d77d454d442..66fe1a253b9ff 100644
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
index 18451dfeae682..a7fa0d1d82b08 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1389,7 +1389,7 @@ int __init ip6_mr_init(void)
 
 	mrt_cachep = kmem_cache_create("ip6_mrt_cache",
 				       sizeof(struct mfc6_cache),
-				       0, SLAB_HWCACHE_ALIGN,
+				       0, SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
 				       NULL);
 	if (!mrt_cachep)
 		return -ENOMEM;
-- 
2.53.0

