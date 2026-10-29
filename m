Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306438;
	b=zFrEy8jIMyfB11/rIxqHjPxgMnqVd3KDBHH9DmIlyUVk5r/JeVcLTxBN0V/m1RVA3YG4
	 PGdEGqrZ95aDea1GpWz4TVlSXbWldcZgFcyPyij2CWM+00QT9GONpvlZcyo8HSAwIGHfu
	 QD+FaRP1Cszn3jfqbtM+Lwyx+h6vgmndPSjLpsO7b3czz5/F9WbBlQTYnR33SHBPMv4Cq
	 IyvNuQEeVRdVzIu9/Trs8l1JxN7po3qt7Iln5KUvK1JgOMv13KyJk+zNbAka4x5gdFoE/
	 uA5ulSuwofHp9tJfwDgG1cBZc7xLAzRD6KDMqD30gdbsYGpeDTDX3xcfnWIKpptHqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306438;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QSDRgnr69YPTIztges5CfT2KnEGoLvf21RQ7Ru6EwMk=;
	b=zsQNgr/nDgxTBZ/bRndCZHcS42K3OXaOnMhoO5vjGnxobxn5MULUZR/2vgWRBJ7Gt6jP
	 fYxwBfvnjBUSp09dG+o83Nv3GgQCUCJ19ldaIiWb2kHj551bla482pak3Xpj4bTjWOSOe
	 JyoZpGHtRr0mmkf2JltxldmHamTk0MEEgDbqBthP+Swu5mBKwf9vFEjmwkzqpgJm/eR5U
	 xdETh5E/bCJN/7Ky7BabNNEK1Om4BnPXukL0pgTxkr6iTRc5sDQ8tQr5rpGypXuP5tzhC
	 /D0OJPRmQIlRy3jIp2puyDl9DqV28VNAP2FjjjsyUuPeEJEjw4zCvZbERuQL1n+fJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSJM4jh0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D4606A321;
	Thu, 29 Oct 2026 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSJM4jh0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16E01F01826;
	Thu, 29 Oct 2026 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306438;
	bh=QSDRgnr69YPTIztges5CfT2KnEGoLvf21RQ7Ru6EwMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kSJM4jh0HrN4VoBlBOqhsPGwGw2Ay3L6UkwB26SEadkf6ghUVo2z8TB8QCJ9muHku
	 5O77SDUckn2sO3yoVq/4XT6gpdq26chxpQr5jmd+TFr7yyyjMEAT7vJlAlHNi2G586
	 9dRzcbSiqzIJZhkYCZd0MkRZjlSqG4A/IqkIfPVXCSD+uJYrJlLddKokdFu1Lpj4s+
	 AM4Rg32kxI2Hn7JiuuOIn7WunGYp4G6VoTkDjcU1gizGyXkzJyZ9GEOxzwegUo/KUo
	 f8ea/Z5QTtcFqqdC8XZvDhfq5KUMWVmWRyPkk5jZK+YupM1MEDamRB8Ea2ZIKljyXO
	 MS5d+tWdUKOVw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:24 +0100
Subject: [PATCH v2 29/47] mm/mmu_notifier: set ->mm only after mmgrab()
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
Message-Id: <20261029-fixes_core-v2-29-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=david@kernel.org;
 h=from:subject:message-id; bh=c82hKzDD/9RIfU3f00HaLlK2GVigMUUm/EjoMU8UlA8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+3QEZsaWVS8/Mt/6UkCdn1zjjE9rGt3nrrZJ0dxZ
 1tMXZtlRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABOJ9WX4H/prQtCmW1M9M2oK
 9NuZ999n01ZTbl/OzdHgtG6HjKPSZ0aGF04lWz43hK3uUjCvqbrEzXLhdlBiS+zbzR6tTzNsL7N
 zAgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

Radeon uses a non-NULL notifier->mm to decide whether to call
mmu_interval_notifier_remove() when freeing a buffer object.
__mmu_interval_notifier_insert() sets ->mm before validating the range,
so a wrapping userptr range can leave ->mm set after insertion fails.
Cleanup then tries to remove an unregistered notifier for which no mm
reference was acquired.

Set ->mm only after mmgrab(), once insertion can no longer fail. While
we could fix radeon's code instead, setting ->mm on success only makes
the code more robust.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mmu_notifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 2e20f88e162d..a7bae5de5fed 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -947,7 +947,6 @@ static int __mmu_interval_notifier_insert(
 	struct mmu_notifier_subscriptions *subscriptions, unsigned long start,
 	unsigned long length, const struct mmu_interval_notifier_ops *ops)
 {
-	interval_sub->mm = mm;
 	interval_sub->ops = ops;
 	RB_CLEAR_NODE(&interval_sub->interval_tree.rb);
 	interval_sub->interval_tree.start = start;
@@ -964,8 +963,12 @@ static int __mmu_interval_notifier_insert(
 	if (WARN_ON(atomic_read(&mm->mm_users) <= 0))
 		return -EINVAL;
 
-	/* pairs with mmdrop in mmu_interval_notifier_remove() */
+	/*
+	 * Pairs with mmdrop in mmu_interval_notifier_remove(). Drivers take a
+	 * non-NULL ->mm for "registered", so set it only with the reference.
+	 */
 	mmgrab(mm);
+	interval_sub->mm = mm;
 
 	/*
 	 * If some invalidate_range_start/end region is going on in parallel

-- 
2.43.0

