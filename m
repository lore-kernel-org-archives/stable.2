Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106284;
	b=gM1ZjHMomNbn5YKojQ0+icufa+o2QQ18537E4GSV+2hDCCsBX2fBEPSibDcW1hZ6zf5a
	 yJ/UCRoo/DsXwhOMZqYlj4jK2ILWscFwpFDCHCHvVSmcyY9b34002lR1YFu+8wo9pcwJ9
	 RK/2ZCip7G2T2FScwltosAvJ1m/XFW/nkis7HZ4THscV/7Dx4EUB1jutt9cHxOv8oghpm
	 itSdbF0aeZM9wJsVRkiJxE8Yygr3afKnOYq7m8Bf4FaW/ep656KuPFVogGYZpDc4SZtkJ
	 HWCoXf7zdA3BslKB33SLPFTT9rICHLgyEvuBZEmBiEOKEMfHn7OvcW5myf+hFD59z9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106284;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Nb6ulKqUTsolCYtjvAlQUATxpl411nI8E+8qSyC/Ov8=;
	b=lTXjoJdVK93sOMLqDc6K6er5VBPd4WjRQn7YQHxafpNkf/R08LZvTBs8spMd9UpINve4
	 vW5b2GP/6CiqJ53i59XtJf0h1N03Aex69d0lGS7VYKwZJ6K64DZhVF4MrXwMGVyrTKtcw
	 yQ0rTw2JxqY3OPNl/FBg28cEpdZCsekewiTnqGsvSrokEa/4K4gMaxsidKxT/Tz7kiLOH
	 wEG7KKoesii0yVytgaoOcZCg0FZ91BVjGoVXDZUeNVPwLRv+G8nM/KgBxoz80G8qPHXQ2
	 pVXBqycnX+O55/BguMhqmL8YbhjGiEBFSeMseoTSAKtIOro/uONhpw4i3uoVte7BgoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlsEmssp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A5606A32C;
	Tue, 27 Oct 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlsEmssp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9211A1F01825;
	Tue, 27 Oct 2026 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106283;
	bh=Nb6ulKqUTsolCYtjvAlQUATxpl411nI8E+8qSyC/Ov8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BlsEmsspTFSBsFErbdKXC9JvpvFEKjCcH9BZLFMRRF3mvn/GSgD9HCaxeKzjM9qBv
	 0BZgZuo+lUkJxyU8XGpDYcvv25jWae/iTq64VaorcVYWIxSdgZqOH95rO8UwlQp8Pj
	 MoY7xpWTwuxbYRelLf6EvLYRH3mQzVZ/qyNRyMBB2W3AYXmyA7rcMmOWcNFhtcagMV
	 FrWJ1CxPRc2TWrea0MSz4275A6pS2Wt2sIsFyjvjtHvK3PBBV+5DCPlkR0na2puGkw
	 WSq3xKt1lwC1fhnocAFKiEk/j+r6qW/YYT6ItHtQF0hZo978mixQ1wLzPyOar94uvo
	 XPzvVSLawy2Mw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:15 +0100
Subject: [PATCH v2 10/14] mm/shmem: fix truncate hang in large swap entry
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
Message-Id: <20261027-fixes_shmem-v2-10-86a00952acb9@kernel.org>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
In-Reply-To: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3893; i=david@kernel.org;
 h=from:subject:message-id; bh=IxGpYqkpOrH6z71YnOhyt90hjS7NavWmximCNN3fY0U=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBRk0fqg9XiWtcSlbQ3W/Z6cy0LzkwLtVqy/ZMrPt
 ItbI3BnRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABOZ4MLwT6Vt45szuzV/N0n7
 xR3od4uSL9S6tzdBfkf0o3/ZsU/fVTD8D/gVl/R0V7Nj1h5NwQc3Xi+NEZ/yVyBG0WjxZ0XhbU+
 leAA=
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
index d7cc45d7077a5..a538b37fe739b 100644
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

