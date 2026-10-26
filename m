Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007751;
	b=AWg2ZCGuof3hthdmDL/Dc5qfhFwomPAgLzJ7EJca0zk/xLogtwN76+nN+C8ZzJWH4AYw
	 Q/MBXkhzfinyCC4HR8Vs8FKrNBF3JiIHnczdZASYery6bfNbHflM64BxZgpyef5M1GWac
	 /zHIZc7jCargZslpwG7U7QwmOsA93pJx/BK6cJBCHM5oHTFSgX7d9lzyBCKlNWo8rAbRZ
	 2SgEfgXPq/T/BCy/pWQnr0h7YKg9+wWQA3EE5xG8jkZ0T8i8MIlucl5riRX7wMGax5ers
	 CYTZu/1JgnnXA2OZ3hzt3Mo7oGGiQ3V8IPPTBj5oKxYlHpgfhJF5xwWOqXfwnS4W16g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007751;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8/RI90jFt6s6Eh4bW/WHVCDQLbPUvPZ+hXvBqT9xgdc=;
	b=AoCj4aZfgIbttgBxy+Dki7UDFlJ3a06lDia/dvhEzsWNMOLbEzPbMbPN7Sv9RUrtgkgj
	 0EvEfoLZDeDt4kyn33K6iXO8/ZCYPQjhJoODsk+g4C7DrSgKsKbOoiMpODKjYsnn2C/uJ
	 Xv52aE4lOmAfrHpRXsxlccInaTq/jcgmJsP54OchTZET+j0EX07x/MXtjfILysTCR8mOV
	 IBP5gpi27ulXSVEh1MIQmhSai+3xhOT/o0I3uyepD0T+qeuowQeJWo84vEbZN2SiBGnwn
	 QmKIfM0KAkWeQZJ4QX0MRSFHpqt0SixkHwEjSuwMtbNT3qWuhGWOHLbsnOy8E9KqdFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1sAZwdO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA19606A329;
	Mon, 26 Oct 2026 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1sAZwdO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FD51F01480;
	Mon, 26 Oct 2026 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007750;
	bh=8/RI90jFt6s6Eh4bW/WHVCDQLbPUvPZ+hXvBqT9xgdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c1sAZwdOn//j+WRgSDK5lwhSRFxcmAQvjcKg1cQmn7luqsIzWO/lAyU/wqEyxg9by
	 fG3cEJlyEJmYeU+9z4qy530KQ6Y+bMuffQrzcWYxruV1/zHuN/nXIu23zS6S47cPM8
	 fNQIxIq5GTGU0SQmniWmmZpZGMNNKAhl9uTl8GNGwu603lmAnVDUfed4tb0nmK+U+k
	 XGbFMpwoeNJS2cbxdxYQsoCXLJWL/JQ8TOeeg/glU2jeqKvUidLbY7La0Zeosbf6/b
	 OU6cvL9uZra9lcmrFPFUMGynsmbInhE5iM1tfGHRdk2VPhqce5gcqLAPVwKRi/ADZg
	 ufYXRBBbpdt8A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:47 +0100
Subject: [PATCH 14/16] mm/shmem: fix truncate loop after boundary swapin
 failure
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
Message-Id: <20261026-fixes_shmem-v1-14-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=david@kernel.org;
 h=from:subject:message-id; bh=mrHTKT/tCNoSyP8HqQO+TaKIADR2BSuhhZ5/eY5uERw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4gv7wkK5NXW3Pfy9NKp3FyT1wveOLLpjvuOmOy+0
 ifbVFUsO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjI7LsMf/g990x6UynsbbHy
 wEOBBRGZ3GuzHwn5KDAe6pzgOPvT2k8M/9N+rNwZc19+EXPuzKa1U5+fsin3n3CYZWL2mvVdRvv
 nSrABAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

If swapping in a large entry at the new EOF fails, shmem_undo_range()
leaves the entry in place. Its final scan skips the entry, then restarts
from the same start index and finds it again. Truncation can loop forever
while holding i_rwsem.

Advance start past the skipped entry so that a restarted scan can finish,
as we already do for folios that cannot be split.

Note that this does not fix the missing zeroing when boundary swapin fails,
it merely prevents the endless loop.

Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d1716a8da9075..6b24b9d6db26e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1444,14 +1444,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 					order = shmem_confirm_swap(mapping, indices[i],
 								   radix_to_swp_entry(folio));
 					/*
-					 * If found a large swap entry cross the end or start
-					 * border, skip it as the truncate_inode_partial_folio
-					 * above should have at least zerod its content once.
+					 * Skip boundary entries when restarting
+					 * the scan to avoid endless loops after
+					 * swapin failure.
 					 */
 					if (order > 0) {
 						base = round_down(base, 1 << order);
-						if (base < start || base + (1 << order) > end)
+						if (base < start || base + (1 << order) > end) {
+							start = max(start, base + (1 << order));
 							continue;
+						}
 					}
 					/* Swap was replaced by page or extended, retry */
 					index = base;

-- 
2.43.0

