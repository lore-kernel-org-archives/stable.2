Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597877;
	b=wtkEm9fPLTJbpb028yE6zQjMfN8c5rJ8mKJSm2sQ8B672k/fhV3YA9PcdFhkFgWVFmkX
	 EpvKPxE2DLYoksIhHTXPkAcgUjMrNNcXB76mmmI1egKOLrP0Efr+8QLL+jzmYxGF2iqJ8
	 /khubfKhi6rAzvXC6D+iG9+QdHiac4ux2RTYbCtMf0ybbAZWAzQ4zJaOZ+96i3WHBczYF
	 xJlpP5FwGCt1HRy9tOVr0VfbRoVHKQzQpoJ4AfGuPRJgtZZYgUKFtXj/qi6lfj/p9Npk0
	 opZp4NCKNafoL3YSeOqcOQKEizk4RdDMESTYetwfcfHjKAuSGMATcy43idPtYbVQNnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+YBXzEehPseVraIUWVmet5n/zqT/bd2cTLeYKg9ZHv8=;
	b=4u5cXEJW1xfzS9ZXdh6GHFkmwDhnZitFjZWhYdk28Ovi8y4PWrGyHzcmHbn6VWlhVwa3
	 SOKcSxAnDK+hC48nJ1qQw5Rkth1o1EvLF+6qIxeAi39wEGvL+q95XDqb2Mwc7oAr7rdwq
	 1bV2DL2gJDHy02X9pqks+4MdZR1abHpTDi4hIjdThWpWxW5baOEsyLsAF4G+ZqAWmoN7D
	 y4KpbB7Hwik/4iWOn+BmyMZy6rqnl3EpZYNgC6yZ/DVwipXt/NTTH58qRa5sFSwNCx9st
	 XD4cWBYBD5ukS901NIdbOr/Hmlb4SL0rR6CrHOEVOHrz3app31EIrzt/9vdqpt2w2ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nT4tfXzi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60698606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nT4tfXzi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA9A1F000C4;
	Fri, 13 Nov 2026 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597877;
	bh=+YBXzEehPseVraIUWVmet5n/zqT/bd2cTLeYKg9ZHv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nT4tfXzi/n/XZ14OxoWyDYuWTZgAvJad14KEDvwL2hJLykT/iIv3P894vXlAnGzHJ
	 S4njIrJZ8i5CDNW+wSyfuPjcjK35c4fWyA/1HPvbgYjlUsDPl2zPjU38WFcE2TQ0eO
	 Az9LKifQxuTC3nY9NPjzMyVnxm/gn+jeqjlS07F0tbuOeKp4AIqRQfhN9h+XJWWONo
	 GZ3LuvfUBP+4hyxacZVA+UCfZfyxw3fkd9XCpQa/U8P5kkWMjZ6DR+MEkp66H7Dwhh
	 PVUf/qmgA/6mTkHh20vmGpy/8tIRWRZ1Wm43mToRNaIzNnyEimjywuCMdCPluVV6/b
	 t84rMj61nWNmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Michal Hocko <mhocko@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/mempolicy: apply bind policies against the scoped allocation zone
Date: Fri, 13 Nov 2026 14:24:34 -0500
Message-ID: <20261113192416.2279504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053912-failed-6.6-d4ea410ce4b8@kernel.org>
References: <20261107053912-failed-6.6-d4ea410ce4b8@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit d4ea410ce4b8aa46a316476ea2624a357bf31fa9 ]

QEMU fails to start a guest with a VFIO device when guest RAM comes
from a memory backend bound to a movable-only node:

  vfio_container_dma_map(0x55b1b1317800, 0x0, 0x10000000,
                         0x7f39a2200000)
    = -12 (Cannot allocate memory)

VFIO pins guest RAM when the device is realized, and the pin faults
the pages in. io_uring fixed buffers fail the same way. Faulting the
range in before pinning lets the same pin succeed, since resident
pages are migrated off the node instead.

A long-term pin faults under memalloc_pin_save(). PF_MEMALLOC_PIN makes
current_gfp_context() clear __GFP_MOVABLE, but policy_nodemask() tests
apply_policy_zone() against the caller's gfp.

The bind keeps its movable-only nodemask, and the allocation finds no
usable zone:

  page allocation failure:
      order:0,
      mode:0x140dc2(GFP_HIGHUSER|__GFP_ZERO|__GFP_COMP),
      nodemask=1,cpuset=/,mems_allowed=0-1

  Call Trace:
   warn_alloc+0x136/0x150
   __alloc_frozen_pages_noprof+0xed8/0x1720
   alloc_pages_mpol+0xaa/0x170
   vma_alloc_folio_noprof+0x65/0xd0
   __handle_mm_fault+0x137b/0x1ac0
   handle_mm_fault+0xa0/0x270
   __get_user_pages+0x250/0xfd0
   __gup_longterm_locked+0x116/0x870
   gup_fast_fallback+0xcfc/0xdf0
   pin_user_pages_fast+0x47/0x60
   io_pin_pages+0x9a/0x110

Base page faults fail with -ENOMEM.
hugetlb faults fail with -EFAULT.

Check the policy zone against current_gfp_context(gfp), so a pin-scoped
fault falls back off the movable-only nodemask, like any other
non-movable allocation under the same bind.

Tested in qemu with a dax/kmem movable-only node 1. io_uring and VFIO
pins of unfaulted base pages and 2MB hugetlb pages now succeed and land
on node 0 (correct). QEMU now starts with the same backend binding.

Link: https://lore.kernel.org/20261018023349.1697434-1-gourry@gourry.net
Fixes: 8e3560d963d2 ("mm: honor PF_MEMALLOC_PIN for all movable pages")
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
[ sashal: adapted the switch-based MPOL_BIND check using pol to the existing conditional check using policy ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 393b2f1fee9ce..c991376056923 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1839,7 +1839,7 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
 	if (unlikely(mode == MPOL_BIND) &&
-		apply_policy_zone(policy, gfp_zone(gfp)) &&
+		apply_policy_zone(policy, gfp_zone(current_gfp_context(gfp))) &&
 		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
 		return &policy->nodes;
 
-- 
2.53.0

