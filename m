Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440068;
	b=4KqRvzmRPozgpnyc7cuzrOCC3kd6zDufW5bqTVxnahfSREvh8NGw0QugTKc7/GJadkbO
	 7gXOj1ZdVGTWQht+Yov96Jle9t17rOR9QCQyGctWidZaJeHsG7/YW0wu8SOReIAURi9bv
	 AcqmxLTnQjqkoSNjOOX53Qc00Mesv7zj5D7h4hXIyn7QC+OrUA5onGRysdoXkeCFpXzen
	 K6cvlExE0wCwUUJw7KpkVKlO2OoisSNxhQPr8oNlHlTIDwpDzUK6xptCR3lGC81EF0bxl
	 fYDnLZ4gbXNepwWCP6j/Kp4oKZN3yCs7ogqJHMC5ZmLUehrE6z5sxavwVPZFgLB7ONQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440068;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MOMq9Bo/X1WC/1XHARd8rol7WFT4eC651ZyNYelwklc=;
	b=ArQydOrt/B9rTlpQ9k1NvUBCN/BF9uC+bgnzZNncZPTymZzv0sTD92jw5KCv2x0Unktg
	 8ITo8mkE4zzdHGc1ms/JavX82V4Dw5F94uTfjVhcECH3m7EacBrwQBQCvSFz1tae/rjoU
	 sqirkoUxNY/NTEPJVj0M8TPXssuuyExMK6COLRolNBsaY+vc+w9bbPLVLSvNtCqugALXC
	 ZNPUDyZAHvMXlnbcXkCgSIeLLop9GsWGKxctpAcOBpIbZN31KAKrPmhxuc1i7dzkACiP6
	 jR3DnWPtjaT/mO6CaaDRI4Yj4ADqNj29h3S4tBH/HkdtOvClEMKPG8+ub/24Fd8raIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0NtaK+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D97606A31D;
	Sat, 31 Oct 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0NtaK+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A551F00A17;
	Sat, 31 Oct 2026 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440067;
	bh=MOMq9Bo/X1WC/1XHARd8rol7WFT4eC651ZyNYelwklc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O0NtaK+zWEOTRhNj0gXjp5K/M/sd/Bb90jRBQ8hxQ8xq45quOyyco+pKYVCv/e+rC
	 jhx/NuTe97ABxZM0ywKwuAkVP/8zauiAIanlyRXXeBf2qcu+GpTU8kayuT4pTPc6wP
	 wRjJ+K+z15pP5Xqspp73jz1pH/YGC4A2MVaJImK2lf4YyVGpw4whdScowfQepp5Q0Y
	 jgsWDMbZxDZIlwn7aVN8S7cUelh61nAK+j4mm7sfZGhXW8W5C5pVHlip46qyApgRNG
	 CrNeTqwbPD0FxGz/bDqMXdcwxziaTEUSFttaYaxf6kT6j7DISoD3IkgQ64ctLSxHq/
	 4Vue8gfskydlw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:58 +0100
Subject: [PATCH v3 29/47] mm/mmu_notifier: set ->mm only after mmgrab()
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
Message-Id: <20261031-fixes_core-v3-29-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
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
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=david@kernel.org;
 h=from:subject:message-id; bh=uqLLH/rw09nvp1DiWb73Ctop723Qk+Rw11zrHd74dEM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs+MUvecmTf/44Prj77M0zh96qmzHf/nTzWHYufcL
 FbkPxt5tqOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJFDAw/DO/tLAiQThmaQNn
 jOOMa6u7DA9Y/vJat7y89k8vY2/2w6OMDPOV0/VfJLit+PLmfbHWH8PrXodfyJ0Kvdr66tLOiTJ
 Pn/ACAA==
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
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mmu_notifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 2e20f88e162d7..a7bae5de5fedc 100644
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

