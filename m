Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270719;
	b=V/X/P9ghYP3svJQENYB0lhFZR3l6u+dQ+jIYlARg78v6Ebtg2wsK+l056Mk8EGTs6l6+
	 YjTRRKDH7jddrynkA44Y+sPEFB1MihrY9WS8JutrOEiBRd2shKL69xP9Ezq4og00/62xy
	 QGGx0zC8nGGg5Yn3nXSdL68Wb8vcPeG//G7bEiQoMLbyogt80+TvWnkruh+XKbGFfkI/A
	 zNv+uOJezVxqIn9/wBkceUFVvQ5Qn1B8uWC9zjFTDKOwe+ZGU3MIMt+01L3PVwBSTgiCr
	 jwv6A9bx9aWs7UIUV7IXeeZ+dFEfr/nv1lrXgHrYREc4xAypRwN5JysqsUTObkz17lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270719;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KrlUP/ZvlGc5IBrSE/vc/ZS/JIkQTUYQoM3NoqrkTR8=;
	b=WnuVVlopGTKtyliluT56W+Ts+qSfUYKIqdVFyEtBOd6biuSzZ8X66ASzTTWzbxNwZ69V
	 PZ9NpqCwHhCCbm0cWAxH/1ubYnvt9ImFHuzit9DilgCZp8hOCknfPybUMpNABlQoeO/lu
	 U+RkWlYtn6NyExEDYNOm5fziNorjQVpt5gZ36dXr9x7sog4cQp1fOxT3yE3CHsZtyBfG/
	 A5PAj2wB7iWgsqyZky2zM5xwHzQSGPgQoKpYGKHbSAc4v+x8b4VyjlHIFpP2uNe84RDGJ
	 17HoRKW2c/kRVDgW9DbSbV/0SjogeDVHdyqAsP5VPM8hH7rrC387wzGMXqIsxUAzSgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2BwoQyu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F0606A31D;
	Thu, 29 Oct 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2BwoQyu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139701F01825;
	Thu, 29 Oct 2026 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270719;
	bh=KrlUP/ZvlGc5IBrSE/vc/ZS/JIkQTUYQoM3NoqrkTR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l2BwoQyuZ+oF9QNPeaUtnWV5JSntj0e1vnoMQBz9wns/uANzpXw7Tr/H7GxNGJAou
	 EJ3yltUb69l70g1tRQaxq23O/UcPEO596qNbfLf9EtT/maRPt+XEefSoLxyJzd3EDz
	 tz9Euv9VyogvCcpFTqGzxM2EgF8YKi+kO3QjzcLbhUHPSjfdzu3rAugJ/RP39Ej3dt
	 7ljQogqUNosOjXEdOGU4/KKtkqmCm7VWkJLZb50V8v40RgMsSve4ZKwBzpP0D4nJuj
	 5wzv4DlbP3V7trXTjfTCRbbArmokLuCQ1w8fYoo8KTXOR1SiJE1IAEMRzPJGTJtwCy
	 0JvIVHnHkAWdA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:31 +0100
Subject: [PATCH v4 10/15] mm/shmem: rescan after nonuniform folio splitting
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
Message-Id: <20261029-fixes_shmem-v4-10-392fc715d8f6@kernel.org>
References: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
In-Reply-To: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
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
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=david@kernel.org;
 h=from:subject:message-id; bh=tP6Y9HYT3IriJ53/PLcZLnjGjErO+gkjaV3Q3Q6DoUk=;
 b=kA0DAAgWx+nLGEVVu3kByyZiAGrjI1fINc1XMBrtRJM6n2JK8MFsom5e+rrEFGq+ePjrl0nN2
 oh1BAAWCAAdFiEEUlPfMOnprn17Rg4Dx+nLGEVVu3kFAmrjI1cACgkQx+nLGEVVu3nGMQEA90Qz
 nbS+Naf5R8v1aGtwlsVKdAZnBenkSGX3FleX0DsBAOYu6EUj3/6SkGv8L1zOlZi620h/DEwmOqK
 90KOkVQYD
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

The final scan in shmem_undo_range() restarts after a successful split
only if the original folio is no longer large. A nonuniform split can
leave that folio large, so the scan skips the newly created folios.
Hole punching then leaves pages within the hole allocated even though
they could be discarded.

For example, a fault below the hole can allocate a 2 MiB folio after
boundary handling. Punching a 1 MiB hole at offset 64 KiB splits the
folio successfully but leaves the original folio at order 4. The scan
continues past all 512 pages, leaving 2 MiB allocated instead of 1 MiB.
The hole reads as zero, but the pages and their block charges remain.

Fixes: 7460b470a131 ("mm/truncate: use folio_split() in truncate operation")
Cc: stable@vger.kernel.org
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 151704b2091d..e96dc3beac95 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1478,18 +1478,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				} else if (truncate_inode_partial_folio(folio,
 						lstart, lend, NULL, NULL)) {
 					/*
-					 * If we split a page, reset the loop so
-					 * that we pick up the new sub pages.
-					 * Otherwise the THP was entirely
-					 * dropped or the target range was
-					 * zeroed, so just continue the loop as
-					 * is.
+					 * The folio was split. Retry the scan
+					 * to find the split folios.
 					 */
-					if (!folio_test_large(folio)) {
-						folio_unlock(folio);
-						index = start;
-						break;
-					}
+					folio_unlock(folio);
+					index = start;
+					break;
 				} else if (folio->mapping) {
 					/*
 					 * Splitting failed, but the part in the

-- 
2.43.0

