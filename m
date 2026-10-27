Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106299;
	b=YBbP0mb4CvsTPeVZU0R6RY+20yFjP2HWW7aJnQK55iPelIUc0oIDOEPXfJX3UuGJENNE
	 53hLrOiQfaBDW/Oqj3RzpLBwrPS+mop7QMkufurH2bOtHLRxoYuagnXreba0y7D2PH1ye
	 A6ssBt/DbgCw598V1yxG5QksTJWhhqNbzkwTWpro9pPzoiW04MDd8Z90B5VcCZtFq4fYH
	 7Hpi6a6FVSRySUudDkndpKxF35yC+Pe+q0zghK2puBvQTEaC+HZa273tSYs1ki7a/JboM
	 B/wrv9qqJmFWoMcKYb6EOj6w0DoZA4Nw0eQP3GK5v8ArHSrjrcRaE5bIs2MiIDmv7mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106299;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7gxJz3iIJoPNXgIYD8eZpN5Cc5fZ+i/i2TMToAi82b0=;
	b=44wTsvyhsUJqGKj0BS8BAJXgpOKri2NKGSDKQwmHZUpCwme0whHET34xaJ5d1ei57G7a
	 8HJpGphXTSno7XdwvvvEWE7EKlM2TjWiLrWGL7y33wJBaBMMGB7XX1RBif5rVv8Yf616D
	 ktt4dWwvIikBvfo93EkiuD+4WUAqI/+SIviWtfS0xkHGAKGvOjiqYP0+SDOvrYPJPOemH
	 HH0dluzQ6AhBa0r4E4uDN3x8tFmn7JIgLpjwqO0S9DKQqE0uxUxgrvqajyU5mqC63bX7n
	 v2qfCuqiVRwwnIm/wjBCIg9Z5QgeTiPfF5M4OEMk3pXknB3E4RqXzlOmwGVyMoYcQWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=br7c+EMC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAD60A261A;
	Tue, 27 Oct 2026 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=br7c+EMC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5BF1F031E4;
	Tue, 27 Oct 2026 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106298;
	bh=7gxJz3iIJoPNXgIYD8eZpN5Cc5fZ+i/i2TMToAi82b0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=br7c+EMCQ/TUHTkzU1JNsz8yIvolUd0KfJ8Ylc1U6SapKJzc+kU6Cjcw+cwez9MIw
	 /fNWjPRORj3Xmz17hbpAxnrWX8WQUcy8tZqJoIaqbqqNRWdnbuXuLxj2YgpM4EpW4S
	 MrEKDu17GZd76+ilTKby1yR7hl9ehTRbx6NBcGqFX1pKCnz1ZwGtJS0tF5f2/yTgWA
	 yEWgQr9e5Uvae5C2ERsVG/iHRM/2BAmag2S07Jx/cIEmLJ1ZfkaWNrv/qBOkO4ndLk
	 4OSyA9iO8zYYk2fsjOJE1dRfJ9InjOveaA38Pfy2D6xX2gXegn2N24aQfuAKiheqrB
	 iHH2l93FfP0Ug==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:17 +0100
Subject: [PATCH v2 12/14] mm/shmem: fix truncate loop after boundary swapin
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
Message-Id: <20261027-fixes_shmem-v2-12-86a00952acb9@kernel.org>
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
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=david@kernel.org;
 h=from:subject:message-id; bh=ayo2+LBrXVmIoxC7jGBY+l1RAqeIKBFNE+ufUyO6RGo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBTaPenspq3NwRUi3Q+9vtUUNcad1tHZEW9w0Wc24
 z4x3Q+FHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzk6BOGf3YrrpYznN1uaBwc
 IOO57IHw/O39zBlXbVVONhd0tU2ULWVkuPfslOfxLdHuS/2DZnzoW+7Y7iT2VC1lYVTFTpnFx9n
 UOAA=
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9a11de010ed7b..4ece296a1ccf1 100644
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

