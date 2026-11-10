Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274023;
	b=oKZL7xgE3nnQgsiUxWS5U89HNpCx5R5VcwR/R92e/RCtigGlBzTx4GWY9s1WUiG+vqA6
	 H7jq6R6KsYKEnwXxNRhoPhrM7sTc/jOANYG2PRew4R8/odzHJey25BnpdLvGp07kHzObe
	 FcAfKoRPV2zK0EQlKNUx/fDK7vi1jmenBRQ/1b8JY4bvRXogVbmF77ZiZ2cpyymbGvpYF
	 Tj2YEF33dXr+V2CeIqY4OIROfhbeyz3PFJ7iHiU4aAREFS7NH4QMj77jDcXK3RRusKyTk
	 /Jk/Gy6hGnhVA3u4t4kZYSPW4/o+qXyP7s9j7tebFTIc0vOx7Ye5r28jmymTZeMAxrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xEle8bhFBTh+zzC89BB+Bj9UXdjnT2qDvQsxYw3NeWM=;
	b=WchWR0cWMPhkgqcuRP/LKYKUxmlqdhqEvqlGhUmbo83KzeuMGfpJDpevvznIfQA7UWI0
	 7Q5sVsDxGTSN8AiDe/PMu3f+rGgeHko2auNzZaDNV3m5VeA6b7NZM4FjKt2iQVbaDC+p/
	 e3/JGRXhcazwjk/PzFg+8YzhosAaa6k2vXYMdCwEuEFM9VsIyfuOLEHbIKoTm3cZzdXMD
	 lwFaZekuNZxW3tqygseYbbQjqsT0z5HgX1bW5idVGlfhm9vXl9WdusNMTB+ZGL+IGAe5j
	 dh+JRacfpZjhzHiwlkSHL3SwZ+jTK9Gy8Kbmjwyenjx4CcBWTol7dysRu/S7t9Q7jZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CBsan/S2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A041606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBsan/S2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737471F0089F;
	Tue, 10 Nov 2026 01:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274023;
	bh=xEle8bhFBTh+zzC89BB+Bj9UXdjnT2qDvQsxYw3NeWM=;
	h=From:To:Cc:Subject:Date;
	b=CBsan/S2n0uqfvV4/og9rhkNqvtFUn2wrVsKKUfuqrmisDAVun8O3DQoY77vWbMqG
	 BL3eVEa0aVwUbKq8reiL4jQupo2p2XkQkXHXgHn2VJ7OcpYdOQ8o0U8kwL8dguOdRn
	 lqIHOpb5eTUXPzDa7Q/iwWEvapc3l2Xr91QEnowu1p7/ox8Yt2yXXMi4vZhqKG8HJZ
	 ng2u/UpYL/1K8HWQ2JMktEZfyuBsSs0uIBg6b7gHf3/RxAsoLcCe82yUUigxo4KTSK
	 1vZHauobfr9Koq1IeSz1zZRYw2Tm2UsV9Y94sT7ApZboQYScZrnhZR3Z9FjWgMmQp7
	 IMLjlLL6ksO7g==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	akpm@linux-foundation.org,
	sashiko-bot@kernel.org,
	ziy@nvidia.com,
	david@kernel.org,
	catalin.marinas@arm.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	andreyknvl@gmail.com,
	vincenzo.frascino@arm.com,
	odys.yuan@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/migrate: untag addresses when querying page nodes" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:00 -0500
Message-ID: <20261109202700-failed-5.10-7d8746d7dc9c@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7d8746d7dc9cc4003661011424e5880ea7ae364b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202700-failed-5.10-7d8746d7dc9c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7d8746d7dc9cc4003661011424e5880ea7ae364b Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Mon, 26 Oct 2026 19:53:29 +0000
Subject: [PATCH] mm/migrate: untag addresses when querying page nodes

When move_pages() is used with nodes == NULL, do_pages_stat_array() passes
each page address directly to vma_lookup().  A valid tagged address
therefore fails the VMA lookup and gets -EFAULT in its status entry,
instead of the node reported for the corresponding untagged address.

The tagged address ABI permits these pointers, and the migration path
already removes their tags.  Apply the target mm's untagging rules to the
query path as well, while holding its mmap read lock.

Link: https://lore.kernel.org/20261026195330.46757-1-dennylin0707@gmail.com
Fixes: 057d3389108e ("mm: untag user pointers passed to memory syscalls")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260721183257.706661F000E9@smtp.kernel.org
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <odys.yuan@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7bdcdb57652f8..d649a6cfce6c0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2461,7 +2461,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_lock(mm);
 
 	for (i = 0; i < nr_pages; i++) {
-		unsigned long addr = (unsigned long)(*pages);
+		unsigned long addr = (unsigned long)untagged_addr_remote(mm, *pages);
 		struct vm_area_struct *vma;
 		struct folio_walk fw;
 		struct folio *folio;
-- 
2.53.0




