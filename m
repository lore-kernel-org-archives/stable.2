Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007657;
	b=0B4rFu143wTi7PmvGZkpTHOTmH3LGU68K85VtkVQOZFBlyk6YEtFtUPH5BgqfSH008xZ
	 fNXsf6A9r3eAZ1IntvbYhiDWW/6lWE7diYzXRe3zimi7IEmI06NCO1qWJzAfP2F4RVi4i
	 3DFfxu+5xHfPVomzVo3KegOvp9pCDeP9zPT2ZKe1GJ7DClgDZrvB4DSBgqOqfPWF+rcga
	 06q634bonQuPpMy7UQ5a8QY2Bm2RCTd/zOy1x0u78ysFm/+OBsg7dVZM/vxfC7TbROgGc
	 i4hR4igiSxgpg1+5Olu5rSNxw9FHQyczFTBBm3uH9MKhXeCIFWb6E278bv+GvKcNyEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007657;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=P8sRDgQW1w3D4pWC1B8XyfoJvD5sWAzdleJVC62/pts=;
	b=Q7ghn4AiUMmc7XxAR7onTRuKq5U8AHWQjcnavMUekQxFFRIXRMJml3Ukuh2c1EpQcQqJ
	 RxSH4rpGcJU9gUN6MsTm0aIPwdJFiko5T4S9e/+h0431sNtRt/xGtuOa8sSksAiWHCyDF
	 mZpSb/dDx3vNGLXzp4dn27aTQtplEWClEsMfUThzdD5vm+R3FM4WqPEvFHpzO5CRqSAHG
	 MgiSPI2YN4hb8KHxjDMX6kWsGbTyu9b5uYe+d9SYjfD8uBFzwecniVYvuypg1xciLKU3Y
	 nH/7e69+f5Zm7Li+WKyIvS/pWEeYOB/BdZmxYf/2PB6ebFwgvgYom/aaZbCkaWMmLwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7Bbv5tH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3ED606A31A;
	Mon, 26 Oct 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7Bbv5tH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2A21F01829;
	Mon, 26 Oct 2026 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007657;
	bh=P8sRDgQW1w3D4pWC1B8XyfoJvD5sWAzdleJVC62/pts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M7Bbv5tHudJU27SzaTTiM57hAYPlMRoINrrJZbFPMn2lw3yOmpkdpT/uKJEKi2Zam
	 sBxTY6XSDaJESuHbZ+MuIOhOYEoo/wuWGYZl1c4zpTJRX13i9J1zZmtNJz1E2h/JbE
	 GpcrXhvetmnVnbe1KHwKauk+2G/b4hlM7yEnvN81Kmwo8VWcku8xlBJ+m+rqv9nDdy
	 yD8gBW7SYzxQEAYfk+oa98UiNarMStxkokouevqUGo16SrxNCTqfwx1+z3lYYckupV
	 oMS6GdTI+6LAQOW9s9MlVCx6RWFVUPdURQoIpzGUlOty5l2YirUkSEk567VIKDeqOK
	 4nkxf+Wv2+xhw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:34 +0100
Subject: [PATCH 01/16] mm/mempolicy: charge shared policy nodes
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
Message-Id: <20261026-fixes_shmem-v1-1-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=david@kernel.org;
 h=from:subject:message-id; bh=owxyvXACeldrYZYA+sOC4Awt4JHmThu8F6n4QgaspJk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4jp79RZ5tcrUla5uSki/OCNtluGRZceX/jvuc/iO
 9v1bwf9OkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiI3W1Ghhalibzvju9h2pho
 cZ7rkd3FRdvkV9xm8XcymFA5oXvK2maG/xHv3HWWqG8NeM7bO/3Y7jXFYZ+i/lttEpix7SeXdlN
 UBD8A
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
[ david: smaller description tweaks ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mempolicy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e9860fb9f73f8..ad49b7524064a 100644
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

