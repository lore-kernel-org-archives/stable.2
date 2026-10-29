Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270638;
	b=YPZ7eW1GSnjVYJb0quh/prSZVz/i3DgD3DmFY5S/9EBiYFkcSGwjTWub4bjod2EwVrhH
	 nYQrEwdQgAH1tlYQTDza90uFCHRVgPjokN6+CD4sgRXRZ66DiVnp8ikbbna+XvNUcFQPO
	 gVMpxgkDc4vYPcL7ZjQc5IlHtG03C9K2jOACa1wdnbriYahuXODP9WF0d1rke2Ir2KQSh
	 W4hp/TlB+rEgRQocHwv7hkl9jGk1LH091/cDv7kRke/zynCRN4B0g6ACdhHKo+3Ar/MNg
	 zCkrh6P0uzlmcX4JA22/SCzG64o/NPneNi4CIYIyazUCseta8+YEWSx6W1jNQmpTowA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270638;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4Nlw0Pnf5KuWb7HS/hkfHK24u0Jr83mMZGFwCShmQGg=;
	b=EeaNZDFdeaZiTvHm7OhSE6Vuxe8Xtgqtk1YP+TgrGMSZYJdom9qIWTqQUp+4mS09RZMB
	 kr6kdWphXzJ2vSylBTV+0rx1iukikpQ5QT3//aiH5r47InhaWmN7NCNb595Pq/Cyqm/Gz
	 KZNuHc09N31pwMEbXoTohEUJ9cb6AEuf0aQ9T+qhcRK1Pvnaygk7ZcCXKCt4EMVW3XGfe
	 Wa/1YGMtTD23BqvbrXEV6l9gQMmJXi/ecccSBVkBFQZpjobKZq7rIKx0nqZHZyRagtYh9
	 kjDVNrHnxItXMfABtx3EPoUmFnPX02mhem1GyDSgBbqVNgF6R1iKDunaeWE7POA80GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkJpBq0A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6C606A31E;
	Thu, 29 Oct 2026 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkJpBq0A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B771F01829;
	Thu, 29 Oct 2026 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270637;
	bh=4Nlw0Pnf5KuWb7HS/hkfHK24u0Jr83mMZGFwCShmQGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bkJpBq0A7tLgFWdOTeb28VWNLmlbxVWYyp8pS+qu2QrbBVm9OwZ/S9+36Ujn4s2Gx
	 ACnwcqZFOCZRHWLVSzlcr51tmv+fL3cxOVyAHrNO0VcNkwZnTQXp+9+4i9wIywZolS
	 juvTmqzAS9IxqhjP7/JPq9eKLcDjiToJkMzmDsfSimQ/4f+fvhoc09ZS0lkYCvlO6O
	 UuwseDQcQ4yUr0bNdr8P6+033fTHXYJ+EJAlafH3AuJ52tUJEIfdMAHcouX8XYRIQ7
	 XWHHrbBG1nQQVs3FBD5sM0y9m6K1Rw2rhtUrHeuRx80aLsKt+jJsw1oxp4kSPra1nR
	 tWYvqiNf7ez0A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:22 +0100
Subject: [PATCH v4 01/15] mm/mempolicy: charge shared policy nodes
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
Message-Id: <20261029-fixes_shmem-v4-1-392fc715d8f6@kernel.org>
References: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
In-Reply-To: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
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
 Pedro Falcato <pfalcato@suse.de>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 Balbir Singh <balbirs@nvidia.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; i=david@kernel.org;
 h=from:subject:message-id; bh=EMJxHgy6I/JyLvzzM0S9yIHJ5L/vHfGKZm51JgH5rxI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4f5M12OPnCuXMrPfaWEh+5c9pdbo4KrZyUl5x/o2
 jGl9MbLjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACYyy5ThN9ssdY2JtWedy/3Y
 Wi7q8qcnfZa8xvWx/0dD8q7cJTdyOBn+Ssv4dP2++1eqkv+1Y6Mzd7OhXtUjPjYDWYmWgIAeKXE
 +AA==
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
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mempolicy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0884c629670d..4da1cb8777f6 100644
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

