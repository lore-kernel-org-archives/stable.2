Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332675349C6;
	Fri, 16 Oct 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167826; cv=none; b=HG7iBz8D2dxpXBsGNEgxZL7zsfuwqkOtD6eUL8aRavQhG1I31R8ZLvrmHCtblfPETJOMRSQJGiNfsoZHKQzOLPyg2bUY1P4hjoCYPENsJ9IWskFDvG/A65G4526v/WqZl+WPJgpeqHfBh0hmM9w1/9XWDsEZ2IIICQ76NuOYCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167826; c=relaxed/simple;
	bh=q6T4Dv2v/mXNrs3uQuUFpY0sF+PJOAwaKezFrrkwt9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NWLAwXHGt2R4pXtgHUQZzwG8K63gUABQOQBk/RGZuL0ANsYjzOXGBJtUyKY+8kkQG04B98SNcMf7Y7TLCGKWgmZC3laZ0iExkkmwunI2UIwNJqssMHnKvsgmdqk6Vxb6jVosCqlgb0l9SzswpvE/TZ2p9gRuuwEiEwLt7IcqINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=WEPhCVq7; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="WEPhCVq7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=PctlGfnjnOkrY4m3yhTfahJhe981R8/UVToXJo783RI=; b=WE
	PhCVq7Oo6d4nfXjLLjKaPYSJVQdKxUhUXREhIyrepDpOhSoCpKcRUMcO9htwCBev4HSTS0iXr7fEV
	XebkoZTs05aUxw8oNrhpb5pZZMk0i2p+hfxZKnarDXKrqsnWCU+n79giGrLDB/Rdu3AALOSy3ayrL
	Tl6HIyjrOVE1imjffl0ONmiGIU0eSZimzZYzKNuSVEo2FsDtpo04GN3diAlzssoyCDJBfCMPhwnVs
	1lGKt5mZXoyJlmA7PRklJ5cpHwa0up0uipiXY/cE9dnVRFp5/G7wBIqZlkhO5Li+7BQShNnmqrwQf
	heujZ5DjTacX2C74Jeh0WUQJMq6RHWOQ==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xHki5-00000008odn-34kZ;
	Fri, 16 Oct 2026 16:23:09 +0000
Date: Fri, 16 Oct 2026 12:23:04 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 fvdl@google.com, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, Baoquan He <baoquan.he@linux.dev>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain
 <dev.jain@arm.com>, stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: count guard pages as free again when their
 buddy merges
Message-ID: <20261016122304.5b1eba8e@fangorn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

With debug_guardpage_minorder set, expand() turns the unused halves of a
split into guard pages, which page_del_and_expand() leaves out of the free
counts. Freeing the allocated half credits only that half, and
__free_one_page() then merges the guard buddy with clear_page_guard(),
which no longer touches the counters.

The merged block goes on a free list with the guard pages never counted,
so NR_FREE_PAGES falls behind the free lists by every guard that merges.
Before commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
accounting"), __set_page_guard() and __clear_page_guard() adjusted the
counts themselves; that commit dropped both adjustments but kept the
subtraction implicit in expand().

Count the guard pages under the merged block's migratetype when the
buddy is cleared. account_freepages() skips an isolated block as it does
for every other free page, and moving the block off the isolated list
counts it then.

Booting a 16GB VM with debug_pagealloc=on debug_guardpage_minorder=1,
check the difference in free pages reported between /proc/vmstat
and /proc/buddyinfo.

At three points (idle, after a read and file-creation load, after
a second load), check the difference between nr_free_pages and the
buddyinfo numbers in the normal zone, as a number of pages:

                idle   after load   after second load
    unpatched   -130        79205               99121
    patched      -16           45                   0

The small remaining difference seems to be due to the numbers
not being read at exactly the same time, and is also seen
without guard pages.

Fixes: e0932b6c1f94 ("mm: page_alloc: consolidate free page accounting")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c483..4658af97be010 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -988,10 +988,12 @@ static inline void __free_one_page(struct page *page,
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
 		 */
-		if (page_is_guard(buddy))
+		if (page_is_guard(buddy)) {
 			clear_page_guard(zone, buddy, order);
-		else
+			account_freepages(zone, 1 << order, migratetype);
+		} else {
 			__del_page_from_free_list(buddy, zone, order, buddy_mt);
+		}

 		if (unlikely(buddy_mt != migratetype)) {
 			/*

