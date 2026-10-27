Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106211;
	b=LY6eRpMvEQh6BDT9J7XL5550tFS5yen/N2KA3WAEB9Ohhwyxp430rDtZlxd78K/GfVRc
	 z25K/GYPJ9ccfbK6zQs4UqsqMRouaypcGf3PViFh7sWuKUxjxHI4v/SuyuGRt0Fh5iBb1
	 2oiECTpYgWzhOC+PevVLaFjE9NjK81cVQMZN4kggmEgBt33yZmMaRvBImXYQupL1wrAv2
	 y6igpZLK/hbSU8yZ/rVIN3U16A7z0SeqmJhCXH2gFr5odVTgFPwSuVZIFqn0f8leXcedk
	 lKJIMpyWJvKE5zvbNWzhPN2V1mY0toQRt17Jy7KITvmYKHBKoijVMHts8HYMkD83a0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106211;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Q7D2pDXqbZSONsr/MmRGENltL8knHH0R9po0DYvSbu4=;
	b=NGHj0Rb+U6g+px1x2RPApyQgQHbQHOSEiBf5V9qZFLr+q1vo4tGA1EHW5C/EMBMW729N
	 wqGAGys5LglK42tajiIh7JIPtvM7rePvEWtjr3btLj4qCgD9nER0YxXFZQD59BuhWaWI3
	 bUMCnVgV2AmfmXyRphcbyh7oTLsLgQX0umwIIjMwIW/gZqSmfsEVSdfHhz7xCqpCWmZWx
	 IF6H6j+zbxplIJ0zmTkhs1iOA8S25Rs7rfJ7AA7ClmNpjh5ou7n67Vf0R2+In38D+304p
	 2acMpxNnvTixGqcaAchx/j5I5b9wEYJMugOQk/Ny5zUJZLe9UfVJjwtPQ/DZ9rvvk0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRpCV5Ea;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DA606A323;
	Tue, 27 Oct 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRpCV5Ea
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1FB1F01829;
	Tue, 27 Oct 2026 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106211;
	bh=Q7D2pDXqbZSONsr/MmRGENltL8knHH0R9po0DYvSbu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FRpCV5EaSLtVC8eEMDVo0u1FmULq5zDGV8G+kIfW8i6YVeXP/TraM30QNhy3KXjGF
	 TBnRw+JKmsEW853CgwTRSl8OoKlIpdTxwWbJMAFAK1gjL6W9P0tdldeDA4VYmSJsBY
	 fjHs9KsqiPI4s5TiR4sQD1nIN+sMvB6zVtyxz+YpiyNGseRZEbTNv0cVqSqDevw32+
	 jyhOI+3+bVZpLb5QwbsZvJVYVjx6dn6y8Qkmj279LOd+xdlGrO0ieT73YWk2/15IK8
	 EQds5zruV+Q+e/YrZFZQohlrg2s1XdBdfdN2c57USCYUbV9pDRzr1P/bb9RIqoiA/9
	 hAJ2HAAxOHgiw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:06 +0100
Subject: [PATCH v2 01/14] mm/mempolicy: charge shared policy nodes
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_shmem-v2-1-86a00952acb9@kernel.org>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
In-Reply-To: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; i=david@kernel.org;
 h=from:subject:message-id; bh=gtxaBrXycCbt80R146vYiuduiMmjXTomAHupfr8V11s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBQIF+jI+L1r94RdB436LiUluq0JODvPmOXDkYDLc
 8RbRe/md5SyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARnXuMDJf8uF6o6vkvbVxd
 X2Xi6Dqf97lx3XWHy3xh2TMUmPOnJjIynJtZssWR/ceS7r5nvheP35HT81T10/j9Kl6zoGkuo30
 1LwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

Any local user can bypass memory.max with mbind() on a tmpfs file, and
allocate unbounded kernel memory.

mbind() sets a NUMA memory policy for a range of a mapping. If the
mapping is of a shmem and friends, the kernel also stores the policy on
the inode, in a tree with one entry per range of the file.

Each mbind() on a single page of a mapping can add one shared policy node
(struct sp_node) and one struct mempolicy to that tree. They outlive the
mapping and stay around until the inode is destroyed. The tree is not
bounded by the file size, so the file can be empty.

Memory that user space can allocate must be charged to a memory cgroup. A
slab cache does that for all of its objects if it is created with
SLAB_ACCOUNT. numa_policy_init() creates the slab caches for both
structs without SLAB_ACCOUNT, so they are not charged to any cgroup.

Reproduced with mbind() on single pages of an empty tmpfs file, from a
cgroup with memory.max=8M: the global OOM killer killed tasks owned by
root, and the machine panicked.

Fix this by creating both caches with SLAB_ACCOUNT. This change implies
that mbind() can now fail when running into memcg limits. Further,
the policy_cache also serves task and VMA policies, so they are
similarly accounted now.

Note that per-file limits are not really helpful, as the user could
simply use many files; having limits per user is tricky as well.

Fix generated by an LLM and submitted by Chris Mason in private.

Fixes: 5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: smaller description tweaks ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mempolicy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0884c629670dd..4da1cb8777f68 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3372,11 +3372,11 @@ void __init numa_policy_init(void)
 
 	policy_cache = kmem_cache_create("numa_policy",
 					 sizeof(struct mempolicy),
-					 0, SLAB_PANIC, NULL);
+					 0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
 
 	sn_cache = kmem_cache_create("shared_policy_node",
 				     sizeof(struct sp_node),
-				     0, SLAB_PANIC, NULL);
+				     0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
 
 	for_each_node(nid) {
 		preferred_node_policy[nid] = (struct mempolicy) {

-- 
2.43.0

