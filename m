Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270745;
	b=d88Hg0+ObkU09SdvH6mRijbd5o9iorwvPwPRNX8HAUSDepIzmDS3prSi8HeBuyTMaVkZ
	 zjtk97XyExMD02GGxBWBt39+FdH/E/HEhsvXHvjFHYcZx941l5wae9NItYUhUxQlRLNBm
	 Nersre4WG+NnltwJ2lGLYORBgA5Su6JrkzMqjJPAVu5RMNo3iUq5DkURT540Kc48bT4Qn
	 RmVhFEv36319VuHJ+xgvX3qNtCZvIK1pgtEmfj4a0pXKMpkw6FazAtYtR0dPzLHhDbNTH
	 8ep0nm6pUpLIGNZ9N0cInGKAOucIuK5DEu++7mcB4cwYpB/0jGOKuEXtKmBCDDhW4BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270745;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Qf8qG507wre4SONZUotxgYcBHB/n//LoEtT0ilQ0jRc=;
	b=P0HRM6OLlMnuCzARoVGZ2cuXf1eiTLYEEebjF5auY1rZUKzxQJy7Kpfe3qGHqWhrqcFf
	 /ZIzCRNbjgitIYwYqAURAcGzPRefxVVAEnVUVLSQzK99q4uAUuazBmWd92C/G2I/n0CK0
	 EopBhZglAUtxhLFEGVHwwPez/mKFW8AfB2s/clTTxuVkzXO3CxAYG3n87Xr6AGTQ6Xnjd
	 wylNh8MmyAAq3HF6VFPwGJ8CzarqKSaoah3/JqRWAIFI0WyOZiffjwG4xR5MvwTyODb0i
	 YGcxXSoGNqfLw+XFhXO5pdJZsQNTZF4zBjxPdYM+yuUFuZbYUjSUiaCE1sN0b8RrWLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFxz1lIy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E54606A31C;
	Thu, 29 Oct 2026 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFxz1lIy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7498C1F031E2;
	Thu, 29 Oct 2026 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270744;
	bh=Qf8qG507wre4SONZUotxgYcBHB/n//LoEtT0ilQ0jRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PFxz1lIyQ9tq7f0NdG088fn/h2vXLU77RNHMMgt9PFlS9psyh9gYNvZo7eo8PTS5x
	 pqR/abniRuuQqzrpHtJR5vGIY4Vc5fU9gLeMOGoFKNy90leSggqwhMbdhxcaFuJ8o4
	 Kc8PzSAXTGDA6JwXu37HTpMjB+Y28E2anP2vuwZoiL/D3YAcQzTm8PxXltuhBcbQtM
	 6CEEGQDtVn2E0jJPByvw2LL0shlyLZPEB+9LQH4DuYe4SSIX+/+5G6wXuIdo2U3YEW
	 tqsk+KwH4sRTgD2VpwTsNUNBN7H4QBS7UqXsmLMELC6CROD+oCMgEE9oZywZddBnKl
	 eEnboukpwQVpw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:34 +0100
Subject: [PATCH v4 13/15] mm/shmem: fix truncate loop after boundary swapin
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
Message-Id: <20261029-fixes_shmem-v4-13-392fc715d8f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=david@kernel.org;
 h=from:subject:message-id; bh=Iz/Ns6ilvBHJdxwO3TPj304o+BNdiHuhjsO9UbzV6vw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4d/WhZaPuvJcYe1etXn+2++mFf6Pr6zOftw8ENj+
 67JO5e+6ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAi2asZ/lmcWZd06cS9vI/+
 B0JKL05T3rPA8q7xjiO6dku6J164/3YNI8M1q8PXc2zcHGLlc377pu+vml1cL8NZwBA9e+6y1n5
 9C2YA
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
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 02de6326ef3b..eb2e6e50630c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1434,14 +1434,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
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

