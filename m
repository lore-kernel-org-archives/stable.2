Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049910;
	b=nCMHAZLOuKWhLMdZ0l3+m5mio3yOXnuah1OFz/wcd/6+U1/aGtqlviSnmSb0120bGwNC
	 Z6nh6rto2dwXi3YX/kUs9KpBGVOLe1CTrdd753I2BvVy/+GxvxsLLydvYugOelbUORPUc
	 ifCqgWNhgNqJsxp15VBeSoxuU2wVSZ/Wc6Lv+790/UFNtyiHwK5NS/dKpKkq0qyziOvg0
	 ue406IsPQ2FtIL5283Q8BM/ixDKdnsgXxVASVWjBE0UmgYsUXzMz8mjHpTbaQAHWYQ2c2
	 OlZP2WINamVo/7JFDmtLpG6LXZizqV8IkD9Pm7sHybxpr9LEZFhbakANbLpvjv9c8og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049910;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qV0MP7kbu/sHRHuT1L/ofmSG3gwoV2xpUakfgwXNNYM=;
	b=41EXR6g/f2Byh5nH6oRckd6uT4YirzPN++jj2h1CLPNFqKbCW8+wCzvL6bItZouXJBQa
	 Tsjkl8Zyntic8Ert94rcDuLgL/gKYhjPx1vjkI/dzW4Qgw6xasxiqi/HE76KY7m7VwlM9
	 sO189A1w+7zm1A3oy7knMlo4JWFIBQK+2CMbDx0STxGFiJBWrKndauIlMTXqEjfbvIYHi
	 BiSVDhTdiAQCpWH+jPZ5y82jO4/JAji9Rmj1Z9pFNqMBpACSATbjUnJb5V+yeVhGEDCkA
	 7r6qyw60zzw1pkyMb4OmWiSHfxZmJU2qx6A3IqJrEm5dOpTIPgKJqeJ0n85iDDqdxng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho6JI7lB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13070606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho6JI7lB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E571F0089F;
	Sat,  7 Nov 2026 11:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049909;
	bh=qV0MP7kbu/sHRHuT1L/ofmSG3gwoV2xpUakfgwXNNYM=;
	h=From:To:Cc:Subject:Date;
	b=ho6JI7lBJtS5I/JsRWemEV6nJePdYaOuTAHOlScic+051pGxLE8RnTDW30Rqh3UaF
	 Mt6f+XcyaK8p4E3MPl5K40FcqYBA9WgKrwub4fbD9+DMVgYEZq4NE2rhYNZFg8c5d8
	 R951nLMGov8xP/dCoUR19uy1PICM/Sy2wJTblX3AfrFrHUEc7MQ+rgohFz9sv0jX6T
	 PxUBW3a7ZfpuHdfQlnTqt2LU+TzMU5T713F2viAm9lEqDWAMdCG6MgwhTffTGpr1CY
	 kAuDzIch0cWnnSmI9v2whO6p2P0u55nNj+teTvEO+O2ilkHNaRHAJGyGDlCeWhNRuq
	 uM68Z/9nQc+rQ==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	akpm@linux-foundation.org,
	joshua.hahnjy@gmail.com,
	david@kernel.org,
	ziy@nvidia.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	pasha.tatashin@soleen.com,
	mhocko@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mempolicy: apply bind policies against the scoped allocation zone" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:11:47 -0500
Message-ID: <20261107061147-failed-5.15-d4ea410ce4b8@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d4ea410ce4b8aa46a316476ea2624a357bf31fa9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061147-failed-5.15-d4ea410ce4b8@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d4ea410ce4b8aa46a316476ea2624a357bf31fa9 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Sat, 17 Oct 2026 22:33:49 -0400
Subject: [PATCH] mm/mempolicy: apply bind policies against the scoped
 allocation zone

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
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 70298fded1b4a..0884c629670dd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2302,7 +2302,7 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 		break;
 	case MPOL_BIND:
 		/* Restrict to nodemask (but not on lower zones) */
-		if (apply_policy_zone(pol, gfp_zone(gfp)) &&
+		if (apply_policy_zone(pol, gfp_zone(current_gfp_context(gfp))) &&
 		    cpuset_nodemask_valid_mems_allowed(&pol->nodes))
 			nodemask = &pol->nodes;
 		if (pol->home_node != NUMA_NO_NODE)
-- 
2.53.0




