Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598074;
	b=Nm/dBnXNb8QRU0gteMAGMRdpmq4d94zI70oNtOLt/EPMTfPQ4QUZ5cjk5EZ4upJ/YM9Z
	 rIFsuoOrX5oXbonhK4M3VEAmwwyEPVAlpxeoOsm0MuXB2JhagK9HqAOinrKPh6DtOyAI2
	 +8IV2IgUtCN2Fvq7mDUbadp+sFBlEJ+g8lfVHhfCd0oCTBsez0XNQsEztCJx9tT/FkmNG
	 yADqRkvXqmMh0T4uqJrozn2k/ZNpT7B0HL10SmZezfBUGN1EFK4TNxfN7uGafQVUks+WV
	 O4bxlnicGRMmmGn+ulYOQruKZ0lOY/Awpz4L/x1QQwTgb0Ivqyla5FXwkoqzFw1Roew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598074;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U/6ZGVW+yW15M/1+SLW+qt7gXKWGwvYaSscRM0egeXQ=;
	b=1PIRAUTY9K5n2m7r1osE0jr8XexvAZ1MTl7YrGd6EPapeYiBB9/ix5cQyLyPiGj/xF82
	 u/kK7/iD/Kjy6WdYPe5Y44Ln0tWKB/UFCLMT0rIeefaton7U/EtiHXzBUS7s3dKx7D671
	 SJudEphygQyc2H2eekKNlaAgNqWFjVI3MQQ3fi0lp+14W8LVOJDuE4iwOpjcBwcCTbX4l
	 4+0jAHnZ29kOzTy1tOlZ3kJsw64N5PkeRDYe6nRIDKQhapIsR9lLWwoHA26xjl7JEJFT/
	 eL1hwxfBci89ENX9anOH2J2S89v7tPhwot4iCI5MTRDhWGmvGWmW8DpUSIxwEL+maMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeAvq+rN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FB606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeAvq+rN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BEE1F000C4;
	Fri, 13 Nov 2026 19:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598074;
	bh=U/6ZGVW+yW15M/1+SLW+qt7gXKWGwvYaSscRM0egeXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aeAvq+rN1A2szkMS4tWX3ZisUaxfGqnvKprmUPpeZU96bJIascX0JJZGBYoe04IVk
	 rR0Dvg6oA03Ac/w0rc/Ubwubn2DgK6CZNGnANwm1D4HDTnNKOK3eLQDZduDoJw41v2
	 WjpVv/sZaA74EXeO5eV2nnuyLnHIs2jShoYznCF20qlYLM0SgVpre3UM9ymauLO3fX
	 MqN00hsFfiKhucwp/mmdf46sjVE8fxqZvGYt8rMkR1UZXa+yWtSCH5zPY32cmbcToR
	 em9wRaex1YhUPVlcYIAzuDPepw5Vn/TW8veETayefmEVOzRQc4WKo+voTRjQnojfUi
	 C7jMAd8K/Khig==
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
Subject: [PATCH 6.1.y] mm/mempolicy: apply bind policies against the scoped allocation zone
Date: Fri, 13 Nov 2026 14:27:51 -0500
Message-ID: <20261113192734.2434712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055447-failed-6.1-d4ea410ce4b8@kernel.org>
References: <20261107055447-failed-6.1-d4ea410ce4b8@kernel.org>
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
[ sashal: adapted the MPOL_BIND switch case change to the existing conditional in policy_nodemask() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5bc8ba6fa5189..a8e990a6aa0c0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1838,7 +1838,7 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
 	if (unlikely(mode == MPOL_BIND) &&
-		apply_policy_zone(policy, gfp_zone(gfp)) &&
+		apply_policy_zone(policy, gfp_zone(current_gfp_context(gfp))) &&
 		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
 		return &policy->nodes;
 
-- 
2.53.0

