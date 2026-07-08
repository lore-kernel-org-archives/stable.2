Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC653A5E9F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 04:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483988; cv=none; b=myURBhPU9sfleQIj1WR6A0Mfx57zG03I9JHpaVgu7cP45PExSw30KPYZdsfeaFSs7syEKBT7M83mufZf/346AVsM0SsnGaZhNOfWXpbv5HloGYUia9fL/giA58kDrAafcJheuhzA1CYzCaVRLvbmGxptBw3fVWKBMwW0ba6dNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483988; c=relaxed/simple;
	bh=jWw+aAZ1Xdf8v0sBvBbMi0reFRXGyYyRf0eUbjNV5dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkGsjw/6K+PHwnTYz/1qRVEf+7GZ10auLphUm0KRS8PNNZSLtYp6d7xs5xWP087BhjOn1BTbloch3kSxgJBLj/No4PHsYg3f3C4VsAmPrewmk/CuD+e9NOwxDx/Pi8+dy1/oxi9+XCBPpOmUbv/8KUwuxLUSjkRkbCMZ6IglhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XisPliXw; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XisPliXw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783483984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZiJokuQxVfAJpsiEey7YS1EwQOtYiv53Kf+q+DJltM=;
	b=XisPliXwGD7r66MNwvPo8dSl731WjYnm5BjYbglvCteLzzHzH5d1qjVh9eQS4X15YMjBhM
	64gnefgI5wpz5YxhmYkD5x1FyM+ODovvIXiDd2n7JN7P6wXidzuCR0znVXjuL7xkg86x+W
	xeBYOSsVL6joY35x6HATZ7OiThyCsV8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: stable@vger.kernel.org,
	linux-mm@kvack.org
Cc: jiayuan.chen@shopee.com,
	jiayuan.chen@linux.dev,
	yingfu.zhou@shopee.com,
	willy@infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y 6.1.y 6.6.y 1/1] mm/vmscan: flush deferred TLB before freeing large folios
Date: Wed,  8 Jul 2026 12:12:36 +0800
Message-ID: <20260708041237.289026-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260708041237.289026-1-jiayuan.chen@linux.dev>
References: <20260708041237.289026-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

In reclaim, shrink_folio_list() unmaps PTEs with a deferred, batched TLB
flush. The batch is only flushed by try_to_unmap_flush() near the end of
the function, just before the order-0 folios collected in @free_folios are
handed back to the allocator.

Large folios don't go through @free_folios -- they're freed inline at the
free_it label via destroy_large_folio(), which runs before that flush. So
a large folio's pages can be returned to the buddy allocator and reused
while another CPU still holds a stale TLB entry for them, and that CPU then
reads or executes through the stale translation into the reused page. For
file-backed large folios (e.g. executable text) this shows up as random
SIGSEGV/SIGILL in user space, with fault addresses that don't match the
code being run.

Flush the deferred batch before freeing a large folio inline, the same way
the order-0 path already waits for the flush.

Upstream this is fixed as a side effect of commit bc2ff4cbc329 ("mm: free
folios in a batch in shrink_folio_list()"), which is a larger change; this
is the minimal fix for -stable.

Reported-by: Yingfu Zhou <yingfu.zhou@shopee.com>
Fixes: bd4c82c22c36 ("mm, THP, swap: delay splitting THP after swapped out")
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
destroy_compound_page was recently renamed to destroy_large_folio.
So it would be conflict when this patch was applied to 5.15/6.1
---
 mm/vmscan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index aba757e5c597..8eb498351d9b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2123,10 +2123,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * Is there need to periodically free_folio_list? It would
 		 * appear not as the counts should be low
 		 */
-		if (unlikely(folio_test_large(folio)))
+		if (unlikely(folio_test_large(folio))) {
+			try_to_unmap_flush();
 			destroy_large_folio(folio);
-		else
+		} else {
 			list_add(&folio->lru, &free_folios);
+		}
 		continue;
 
 activate_locked_split:
-- 
2.43.0

