Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273409;
	b=oKP8zDmoAyrLxug5hU3f2UQBVoJsov7CE6mP/qxJ4fLIsF3PDWGanR5ycvkJQwBb8Pwu
	 Lp2kH1Y5bRGqngV4PXhlG5usvQ87HxRn30rIzxXV2OWg2483jxEDI5RZCFq5bgwQUcJOo
	 ICqZT6D5OwObzePsLX0Ig8NQrqNzdmTLuOM68uYCTtd5hM8EFf32bqLPv46hYTVjWub7h
	 2RpclHuIbfxWBFSVY+VIQvSAOTWkeNePWJF+KNIXoGaTHjkf4BjhsVVI24iVxs1gA2Nbt
	 OMa6NlsghPuNq2Bs2QJ3MpuiiqkIdeEJ2a5PvtE9A0qGS0bcOhgYqZ047qTFej+K6Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4cqOeXfBOVN/drgNZ6obbKGOCckx8A+hqYjYHq0uplU=;
	b=4U+KuUlOyzLr9tsC5+M7QhSvMghVWD4m8pGkyNyYe5E/+/khYXV1P5TNKcTnkDQVX1p9
	 9Pcv0nhuaNxDDbRZp4ivK1uHRDrWI1T4s0x/gK0CWK1lZHQeacX4qIR6eDHc4VYU/C40m
	 7dJ7fwIzEjJATon56VJAL8BFgVpNkeQ5d/n7WQyUGMB5oyTRXjdtbzWyZhhaZjdHE2JPG
	 DaVwunDUIQLVn6hB+wNdZxbOyE3UKVEoUbkYGMrHALghf4Xuhys+6H+AD1Wly+SNWZOcE
	 PdBkotiBre5aUgfX7soBiHD2Jz3K9+SKuomMwwoqqOn9WSxDtK5SAdKJPa6EbSqMLZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8pWhvzU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC0606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8pWhvzU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44241F0089F;
	Tue, 10 Nov 2026 01:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273409;
	bh=4cqOeXfBOVN/drgNZ6obbKGOCckx8A+hqYjYHq0uplU=;
	h=From:To:Cc:Subject:Date;
	b=J8pWhvzUoNmuKpIO1O4dFcxRTIOdFERz4/wIVhhd14AoD4nA7yvQ9WAlFCY3aslA0
	 HEizzgSLA5EwC+qn6s7mq7DBJBeUohB7eWJI7+IyG+pNQxE9bYbhEpe7Z/UN1+DVke
	 P5mKIbLi99fMmyaGOU6uPh/746//ifs4n7e33aYarpSepG+IUlbVT4fgB50IQzeq3p
	 +ftzjGb3Mk1zzeRRU5mqz2BQ3wQejZxEDMQQp5kWPX95PBne9BVNW2NSTJ4P5kwB82
	 MxW+ySZ8OfFpML1TnkNbSRNRTthv1T4YZX8/MDvQ/tf8Ra64J0v+OaJHvhYZ6vwLgh
	 UqMBKkURebe3A==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	hughd@google.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	usama.arif@linux.dev,
	willy@infradead.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/khugepaged: flush deferred unmaps before dropping a failed folio" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:46 -0500
Message-ID: <20261109201646-failed-6.1-854e5ff8b3ce@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 854e5ff8b3ce2a776586cabebaeae645c992345b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201646-failed-6.1-854e5ff8b3ce@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 854e5ff8b3ce2a776586cabebaeae645c992345b Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Tue, 6 Oct 2026 21:10:01 -0700
Subject: [PATCH] mm/khugepaged: flush deferred unmaps before dropping a failed
 folio

collapse_file() can fail its reference-count or dirty-folio check after
unmapping with TTU_BATCH_FLUSH.  Both paths put back the isolated folio,
then unlock it and drop the lookup reference before reaching the common
try_to_unmap_flush().

The page-cache reference does not keep the folio stable once the lock is
released.  Another collapse can replace and free it.  With its PTEs
already gone, that collapse cannot flush the first task's per-task TLB
batch, and retract_page_tables() skips short or unaligned VMAs.  A CPU can
therefore retain a user translation to the freed folio.  This has been
reproduced with unprivileged MADV_COLLAPSE on a memfd.

Flush at out_unlock while the lookup reference and folio lock are still
held.  The common flush continues to cover the accumulated pagelist on
both success and rollback, preserving batching on successful collapses.

Link: https://lore.kernel.org/20261007041001.43181-1-kylebot@openai.com
Fixes: 6d9df8a5889c ("mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
Assisted-by: LLM
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
---
 mm/khugepaged.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4b71d010b2aff..da91762f6358f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2467,6 +2467,11 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		index += folio_nr_pages(folio);
 		continue;
 out_unlock:
+		/*
+		 * The folio may have been unmapped with TTU_BATCH_FLUSH.
+		 * Flush before releasing the lock and our last reference.
+		 */
+		try_to_unmap_flush();
 		folio_unlock(folio);
 		folio_put(folio);
 		goto xa_unlocked;
@@ -2477,9 +2482,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 xa_unlocked:
 
 	/*
-	 * If collapse is successful, flush must be done now before copying.
-	 * If collapse is unsuccessful, does flush actually need to be done?
-	 * Do it anyway, to clear the state.
+	 * Flush before copying the folios, or releasing them in rollback.
+	 * This is a no-op if out_unlock already flushed the batch.
 	 */
 	try_to_unmap_flush();
 
-- 
2.53.0




