Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181332;
	b=QaOpOvVRderry2ZMq1S0sTgtQ+Xo0xIe3QzVVDoD6kS32NtNb0mCpAqKoKuxew+/f49m
	 e6EExBLNitpfJJyNUVqx9UDw0rGyz/+cpr393RmQda1A+se82ONshXR2lSW/43kSltNo7
	 CTkSW+onLl8a/1NO9jPMdAIApCmomKEiBjpKEBEMHdmlUyXfhh10I9WcofNu06+AyTxhs
	 RfvIMJU9heO25MSeENP+GHNMg6rvLKn53un5JjRHjgB1HA8K6zlNBOKQUVMLo3NgbRC/b
	 YRe20Oc+S8WEiXIJq3fWzS77XpX+ptxjLLudNAFHQ53I/q6mLZNOUsELww2rsi3g1vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181332;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=F8pPM/bRUTziIOodg42WNv0yxbRY0HbfS2ntsfLX70E=;
	b=5TH3m8OF5WXTDhadR9amMDCtolRbvn+j+WFpt4vBcomGKUX8L3WowXV+2SF9ilTug1xE
	 oEpdHi1c3icbi+LeR2BNyh7m/zsgN3r9USh4N9we2n9YDZVM3avM2wvrtKaa24RfIQ400
	 bHyk+f9CgxiLLevVAv6r0dPr1jNvlUj9Sa6TcEoNDeMGw82GPfESjnCmzier2ZClXQGcu
	 wR4qDNfZAKIOI4lgJoNsx9ru68pUykhHhznPq5LIw9SAi0/9+8vGENIiSGMNluxheGAtw
	 RIBFyN2Jgkh4VZcwzoSSfgQq/IDBXZZj/TZhc2W0BYqpCT6QCkIQp9Ys2AZ97zDvhyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAohb4eg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54901606A31E;
	Wed, 28 Oct 2026 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAohb4eg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A703C1F01828;
	Wed, 28 Oct 2026 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181331;
	bh=F8pPM/bRUTziIOodg42WNv0yxbRY0HbfS2ntsfLX70E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dAohb4egrc9euupGLmqj2Zinirntj2xoQNsartLNbJPRvK8bxD5jn20KboSV6G4UD
	 kjBCDJicWJUe3+lR1pn9RbpG2X6cPOTDCM4lW7cOHGmkoGscInpmcQRWnaj7fGrZTM
	 eJqL8ZfQCl+QdJFER8Wl0opx6v5Jz0BFzkLgK1WJ6xi87CQ2X0wvSDBBXegC9qZGHY
	 GSLxWxFkMwspJL33RpJIyO4ReBvyVjdfVHuWOPJ+YCZwEPf/6CpH80BP3p2+VIBWvt
	 zrv7Ywxn8NFEBdFyyeAodSm2Tgzm72mssDrmczMckeNwV+MeSnM6UVfIiL9CK80I5M
	 3L1BMHU8CWOcg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:54:59 +0100
Subject: [PATCH v3 01/15] mm/mempolicy: charge shared policy nodes
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
Message-Id: <20261028-fixes_shmem-v3-1-4ce3baf2db4b@kernel.org>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
In-Reply-To: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; i=david@kernel.org;
 h=from:subject:message-id; bh=8g2Q09MddcGiWaBBqP4q1RNteEaljuHdjt5+KbfoFWM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHms8eqlr1cuWXaKtM6/v2H5yg/HvY7c3zrU9ss1NM
 z9r0eOUqI5SFgYxDgZZMUWWoOD7Bi9frqutduNjhpnDygQyhIGLUwAmsm8Cw1+hgMMvFITffrb0
 fXJv+947Vq6xpReuCSxLcatZvOsm780Ihv91h1yeBBvUVdo+trpZELJH3CdR8ePbN4Hm+ZyrmWS
 iOnkB
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

