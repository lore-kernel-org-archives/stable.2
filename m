Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA34248D6
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890154; cv=none; b=fN0NR2+z5aySKmHfhhoT8XL8YMhECZ6hY0tCQEtuZj38ZvvKBTpmSqMhikhHtq4rBzgmrvKVZYHc1DDSIDgnq/Un0m0SUVLnCQx/LyFef1dVJPlXzF9bqtrRfbVPIBhdxibNgc7QeTwqR2m56E2eVucmXnKg6H+FeQ+pmhsGMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890154; c=relaxed/simple;
	bh=B5xJH4AD+vhlaROE4KG03NjFL9hRyg4mAh2ELUB59GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaKFiEOiIecsNTfbEM8rTXA4UQeuOKKobfG6TkiYaJvLHkNFtaTcjLPGveW2RV04Il7CH8/kvZ22dtx1PzJ2odGxs34fB/CDBeGW0ha1UroHgS/U+ZVPEQ/2gKErNRM8mMgX7DcvLmNmgohnjPdrlSTFLmI/5hpSGMmJRFLt7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxeSMcza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxeSMcza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E93B1F00A3A;
	Fri, 24 Jul 2026 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890152;
	bh=dkkWKZUDccmtd+y6p/oariw120wryfKkXkYsuKgN/oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxeSMczaNqPRaN27efZu5IbuCA3rV8cDbzOXLqiECIEPGuvJihd67DklsUAdOH7Qi
	 rSPa2HuNgmvHUudij9dCgUSrtnphlugFGYoj+aKrIV6o/JTSVgXcssy8KBlviJQmxo
	 KiL6JPfisONhdF7AnAE777lldm34bjmBMT7EnR5eUfqIdFNqxzr8vSbtC8R3jJGwcp
	 R9hk1e8kfEdwuTg9ssKoaI9HnpwHnJuul+4aOIQwA2b8PiD/w5H433qy7cQhcznt2S
	 4J2vc1uAnOM7Ir3NbB214JTKXXZrXoYVqR1h1eFxnwLPRdZ3ggqLOK8YmZ2zTTsciV
	 lOHyG3cKnPlxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muchun Song <songmuchun@bytedance.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Georgi Djakov <georgi.djakov@oss.qualcomm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/4] mm/memory_hotplug: fix incorrect altmap passing in error path
Date: Fri, 24 Jul 2026 06:49:04 -0400
Message-ID: <20260724104906.3974254-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724104906.3974254-1-sashal@kernel.org>
References: <2026072010-unadorned-lubricate-bf28@gregkh>
 <20260724104906.3974254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

[ Upstream commit 2fac4afa0e2e68841334c78c1821e49f74fbc66a ]

In create_altmaps_and_memory_blocks(), when arch_add_memory() succeeds
with memmap_on_memory enabled, the vmemmap pages are allocated from
params.altmap.  If create_memory_block_devices() subsequently fails, the
error path calls arch_remove_memory() with a NULL altmap instead of
params.altmap.

This is a bug that could lead to memory corruption.  Since altmap is NULL,
vmemmap_free() falls back to freeing the vmemmap pages into the system
buddy allocator via free_pages() instead of the altmap.
arch_remove_memory() then immediately destroys the physical linear mapping
for this memory.  This injects unowned pages into the buddy allocator,
causing machine checks or memory corruption if the system later attempts
to allocate and use those freed pages.

Fix this by passing params.altmap to arch_remove_memory() in the error
path.

Link: https://lore.kernel.org/20260428081855.1249045-3-songmuchun@bytedance.com
Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Liam R. Howlett <liam@infradead.org>
Reviewed-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 721a73e30c9e ("mm/sparse-vmemmap: fix DAX vmemmap accounting with optimization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 40c7915dabe058..cf4f77108c43fc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1470,7 +1470,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		ret = create_memory_block_devices(cur_start, memblock_size, nid,
 						  params.altmap, group);
 		if (ret) {
-			arch_remove_memory(cur_start, memblock_size, NULL);
+			arch_remove_memory(cur_start, memblock_size, params.altmap);
 			kfree(params.altmap);
 			goto out;
 		}
-- 
2.53.0

