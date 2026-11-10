Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272641;
	b=FlMK147E3bUGHqRyGYmgiJBtWZaOP4+s00aI8vUOt+HkS9pCl7zPHBNeRwxoMgoXScCp
	 rMBunAA+LouCGtw38KFj8M+Aa/r6cqD6S8dX2sYEsFpNn9EFK9kzk+oK80jVVWRCCGw97
	 5bDftKKip9l9StMwVKaDZZFGfW8y5xQtTsz2qkmIe0CRGx02jNZRdrjREADSU29dPbdSZ
	 Ciec6rclXpHzScLi+CNuJHKbTLYw77Aj7PxsCc6VS1WytIh2Q7QauZsq2weQlLtRclLhz
	 GxuuOvqla4Guk5V+p0d7ZW8Oxka2CtJZ8fvc4aer98ZYiBhrUolWWOTGNzvWxNUavdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NCtcvCTKhP5ELagZYpK0U1OC8uSuJWA6BvTO7OjU0P0=;
	b=hAyFzbuR/jdJCQQzf0ug/l4KfxUmrv2s1DDaKddOW4HUU6yVCUQZVl6OcmdCzc5CIpOD
	 V6LBZ6vkfP1m1oaFZXzrZyDDDDCZf92H90ggnorCe+GxmiwU2DJGqArIxsJyhlcYrTLbV
	 8PaPT1nuX7TO1+c59BA2KTIE8A8pUMFkHECW3vnd8/hWxM8sg9VzQw59nMwFYPg/MjdeM
	 HbZTs0I7O3NnLVl1KMwOVy1fDMMu9Oh69RBXjeojqH9lP06+m1mC2mHMFKwhwp8mIKA36
	 ygOY5ONi6f5z7+VwlIOHJX/ZnjgL5C8cEE4wrNU6yIzwrCIHDJRKjy0OZ8Rc3B684iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RR/SNPiG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RR/SNPiG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FA21F0089F;
	Tue, 10 Nov 2026 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272640;
	bh=NCtcvCTKhP5ELagZYpK0U1OC8uSuJWA6BvTO7OjU0P0=;
	h=From:To:Cc:Subject:Date;
	b=RR/SNPiGn3ikWKp/PoT99402IrC7WIVeQIWl8iLr2mH81164MU61US0uYqrCaz5wl
	 5yxJMhOW8zj9izgZsQP5EMSi6YxxIFU5LDoxVVIwwc+P1bfmlGFiNDf/r5CZtEsH+D
	 9R17a6qqpN22KvwKuLcTHY3qCEbpL0+sHnrr2JFxJPtvOQk80wo1wdLb6jeo0tQfUu
	 4WaYV/cnViFY1Kkss0mYSWECaFN6oCGLBTLYrUkerCQ1n7u2Vkcr9vhKVmxLuh7Pcs
	 QakTq8thUqB5P1jV12v41JZ3Ti9UrsO0kyvj4UMVeKiRfbIAL5stT+YkZzoGVAK8t+
	 /ppT/hU7SE14Q==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	flyinrm@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page_alloc: let the highest memory node recover from hopeless state" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:58 -0500
Message-ID: <20261109200358-failed-6.18-83367658a010@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 83367658a01087375ede31ae343c99da03f72ac8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200358-failed-6.18-83367658a010@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 83367658a01087375ede31ae343c99da03f72ac8 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Mon, 19 Oct 2026 14:48:50 -0400
Subject: [PATCH] mm/page_alloc: let the highest memory node recover from
 hopeless state

free_frozen_page_commit() clears a hopeless node's kswapd failures once
its zone recovers above the high watermark, but only if another memory
node exists for allocations to fall back to.

The test `next_memory_node(nid) < MAX_NUMNODES` finds only memory nodes
with a higher id.  The highest-numbered memory node therefore never
recovers on this path, and its kswapd stays disabled until reclaim on that
node makes progress and balances it, or demotion is re-enabled.

In many cases, direct reclaim many never fully run against a lower node
(CXL/kmem), and that means its kswapd can end up full disabled in rare
situations.

To reproduce, fill the highest memory node with bound, non-THP anonymous
memory and no swap until kswapd gives up, then free it: /proc/zoneinfo
keeps showing node_unreclaimable 1 for that node.  A lower node recovers.

Count the memory nodes instead.  Adding first_memory_node != nid to the
existing test would also work, but a count says directly what the check
means: some other memory node exists.

Link: https://lore.kernel.org/20261019184850.3427905-1-gourry@gourry.net
Fixes: e7a5f249e6db ("mm: re-enable kswapd when memory pressure subsides or demotion is toggled")
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chanwon Park <flyinrm@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8cac5e01066c..31ba24411d36b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2929,7 +2929,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 		 * kswapd work again by resetting kswapd_failures.
 		 */
 		if (kswapd_test_hopeless(pgdat) &&
-		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
+		    num_node_state(N_MEMORY) > 1)
 			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_PCP);
 	}
 	return ret;
-- 
2.53.0




