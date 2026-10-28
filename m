Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181409;
	b=sB1qjA7b58a4uOs789ft0zj9ddtuGKWno5M8+i5bfGpY6ejK8r5uQHAyXrBAbRjqS0uN
	 ZWrdmi9tyEI2W9abYQbXW69C4ePTCg4E+fxumHVYhTxyqm7QOLENp35Q/jbsGxTfHRpkO
	 oaKNdOcFXIQAp+7kwASX6lCoj1Pjg5FD2k0p1EY6zXSYq+wtrQCcrK8OtO2Y7uEE4CXj7
	 VRyUhunfmKTAEm4i6DOeQ5O+8uqyujo3kqylI9Va/EGOYOIQ180nnOBX6IYCeBmkjLxvQ
	 v3KK/6ZNENNBrnBf1BRzQCSiNwzoUeuKNsu6vGjvFGYL/OZW4GvBBC/tDoxKjayFBBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181409;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9K6LuntH9T4HIMxba+wTQAhrty/BEZYK/zZUmw09iQg=;
	b=p+rSALOF/uBaU1sb9rM2A55YO41XgBbyOHTcpMj0DiO//Ib2cjN9NQe6THpudcduZItt
	 16qh876MJmBZEBJA2tzLc768EEsPVTXJ2bKQCYX8op+LibR3M9x0rns3Ake9mC95mztUX
	 evcf5Vo8/VhuBCDzmpZAvR15N+5lRBRN7OKn3BVQAN8Do7MEWohqb4ZqKmhY9hINgUO0y
	 DzZ0RGME1iFoGsuP/bhh2LAqQWikwfrY3iXg/U2uoD62bfUBPbtB+Wr24rYra+j7ZF6C8
	 6BOEz9KaXSYME4eVCieTRCVus0kjyit4h3IjeQmxyTEYh6sdhzVvzFVd0AY3bZzlXKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dC6x6mp0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56914606A31E;
	Wed, 28 Oct 2026 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dC6x6mp0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98C91F01825;
	Wed, 28 Oct 2026 09:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181408;
	bh=9K6LuntH9T4HIMxba+wTQAhrty/BEZYK/zZUmw09iQg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dC6x6mp0CrCnPmvZRxEeyoOslOOH9vDbPicyPAx237mqoHjzDrh2nBB8VnKrGZbZS
	 RVoA8doKLR8SCFpYl6x5Civn1umJCktVgsaZ+0ScQ/mRCPZevSCw1YXe609a/wY8ai
	 1crQ/b9lXE0NENwwR1RR+4A6jU8TYGf35TKKhKogJrAeW0leTWEbgIwkBWvBXZJqpC
	 9x9vcwKJ3r84XTxC0sVpuTJcTIfZuE08brjSDjKW7qQIeZOtZaO7PHVRWbtuvHJccE
	 dAtEMpcu88OfE7WYR9+o3CvCWDhiZZ+6/eKozJcKOP5tXKhUZMCucKSoLgNVfbKQ3+
	 ZUlVVTfRXkMDQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:09 +0100
Subject: [PATCH v3 11/15] mm/shmem: fix truncate hang in large swap entry
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
Message-Id: <20261028-fixes_shmem-v3-11-4ce3baf2db4b@kernel.org>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
In-Reply-To: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3891; i=david@kernel.org;
 h=from:subject:message-id; bh=8QPoeV9STiSx5Xa/ZaTy76exQxrTdIRl5s6LBctDShA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmvKOja9bm5b0N1XbK0vNl1b69Otc/6Kwax/J467P
 vgirS30qKOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJLL7O8E9TdEkR/728ohqB
 zYeLLuortPAKfZCfcn5dkPHdmperOoIYGXaIN7JrvFz+5K9KAU9QQKm8k+2umt7KJzHmf9wKneW
 YOAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Truncating a tmpfs file or memfd to a page-aligned size inside a large
swap entry can loop indefinitely in shmem_undo_range(). The task holds
the inode lock and cannot be killed.

A large swap entry represents a whole swapped-out folio. For example,
truncate a file whose pages 0-7 share one swap entry to four pages:

    [ 0  1  2  3 | 4  5  6  7 ]
         keep    |   discard
                 ^
            new EOF, start = 4

i_size has already been updated when boundary handling asks
shmem_get_partial_folio() for page 4. Since it is swapped out, the helper
calls shmem_get_folio() with SGP_READ. That rejects page 4 with -EINVAL
because its starting offset equals i_size. Nothing is read back.

The final scan cannot free the entry without losing pages 0-3. It skips
it, restarts from start = 4, and finds it again indefinitely. An unaligned
truncate avoids this particular failure because the requested page starts
below i_size. Folios already in the page-cache cannot trigger it as the
direct lookup will return them beyond EOF.

Fix it by letting shmem_get_partial_folio() call shmem_swapin_folio()
directly for swap entries. This bypasses the read path's i_size check,
allowing the existing boundary handling to zero and split the folio. If
swap-in returns a smaller folio, it also splits the swap entry so the
final scan can free the entries beyond EOF. Retry the lookup if the entry
changes during swap-in.

Handling swap-in allocation failures remains broken and is unchanged by
this commit. Even when shmem_swapin_folio() correctly returns -ENOMEM
instead of -EEXIST, shmem_get_partial_folio() returns NULL and
shmem_undo_range() skips boundary handling. If the large swap entry
remains intact, truncation can still loop in the final scan, while hole
punching can return without zeroing the boundary.

This may read an entire large folio back from swap while holding
i_rwsem, only to discard part of it. Avoiding that I/O would require
splitting both the swap entry and any large folio still in the swap
cache. That, however, is much bigger work.

Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 21983cce9fcb..59907556369f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1298,12 +1298,10 @@ void shmem_unlock_mapping(struct address_space *mapping)
 
 static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 {
+	const gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
 	struct folio *folio;
 
-	/*
-	 * At first avoid shmem_get_folio(,,,SGP_READ): that fails
-	 * beyond i_size, and reports fallocated folios as holes.
-	 */
+retry:
 	folio = filemap_get_entry(inode->i_mapping, index);
 	if (!folio)
 		return folio;
@@ -1314,13 +1312,14 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 		/* The folio has been swapped out */
 		folio_unlock(folio);
 		folio_put(folio);
+		goto retry;
 	}
 	/*
-	 * But read a folio back from swap if any of it is within i_size
-	 * (although in some cases this is just a waste of time).
+	 * Truncation can look up a large swap entry at or beyond i_size.
+	 * Swap it in directly to bypass the size check in shmem_get_folio().
 	 */
-	folio = NULL;
-	shmem_get_folio(inode, index, 0, &folio, SGP_READ);
+	if (shmem_swapin_folio(inode, index, &folio, SGP_READ, gfp, NULL, NULL) == -EEXIST)
+		goto retry;
 	return folio;
 }
 

-- 
2.43.0

