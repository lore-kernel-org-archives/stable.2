Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181424;
	b=qNshRjOyUd+uOz73wDUwVN1CYpLbyNggyXGjBiB1ooxaN6o/tl/0LlJ4exdKOp6ZIE28
	 bSOjBUTLrsPxhu5B0D1nOTgEPiuxyXZPIuorGexG+MHflf8W6JYzxS1+ZJfYpV490Vvp9
	 HfSyh4tyAxMS2EnOjRaa/WHavNhAEBqCxidzhUKuKOsT/qQBbYuE3eYP1vckWJZADTL51
	 IqDskqaX3QuCsNk/HwH+xDepAMrTVwATDD2PwSenIC/Cqfh2qRJdOTg245IuH19Bsa4XY
	 /SPU6kVaEzC4a1tntI77CFTqvWDBwVutNDhfr8V6VxIxtmKfKbz9+0XawrXZ9Qep/4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181424;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/I7kmqBQ5Rj+UdU9RkgYygl6ZVbcADLceo09ZpBcid8=;
	b=erEJ5xZWCTCzCXBIHLYHgQwIoJOidl6YueRmm0cM5dtOwBDeeKXoOkwWKTSaTqM6+Z64
	 dsjYghGP7RGMX77Pcf6p8EVSJ78EFs+D5E+IuuRv5cM/+Idb1o82YgomP2LBFvuszrhYD
	 so28bdUDFR77KfKdTN129pwR4uF/X+2yvu+kqjFwVmOpp+bDU4DDOy0QwrgVAVq6NcB9f
	 NeSpKM4mS0jli/TSuxl/jEwUMaJQt+lx6xxZo3gMTTMh0YiSg4ln/iXw5RAA4lnUbmO6O
	 fISUsuYBvFhvi8AqC3Ja+CwIynq/clLWzleNHADkeP7bs/YBcYy4aD0ItuwlcsR84vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvhTdMYe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5AA606A325;
	Wed, 28 Oct 2026 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvhTdMYe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97261F01825;
	Wed, 28 Oct 2026 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181424;
	bh=/I7kmqBQ5Rj+UdU9RkgYygl6ZVbcADLceo09ZpBcid8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mvhTdMYeQE1SZlZGRbDzPEePCKXGHcOqwQU4FxxGTa8ULa2BI+M1yI6MGKCnlfYZU
	 gfsLbkzye3qlsB8yllb4Qp5PYhA4/kVpCDhlO2QgyJGoODoPa8JY90XgUzAc+6e6ZV
	 KrweLv8zYRfx/C86rLEsU7ShEZ6i0eQMoZ+R7ZQephWinoxt4X/pQk34mVzeHeY2CQ
	 Ds+vTdSb6NiwE+5l5cCGbtz8RRunI3BgxzvF8u+eMgKfSM0uAzMAorobIkdI8g99Qq
	 2IR5KmO3fDQ7tDV2W7YapgHXXORcvAqNvRnmnRzrYQiTgp8JmQ1u6/PQZGSLjZH0t/
	 b6aC+z6a8paOw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:11 +0100
Subject: [PATCH v3 13/15] mm/shmem: fix truncate loop after boundary swapin
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
Message-Id: <20261028-fixes_shmem-v3-13-4ce3baf2db4b@kernel.org>
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
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=david@kernel.org;
 h=from:subject:message-id; bh=28Zzh0mRi1ZJZ32G5y3wlP8eTabvStSa92BGfBa1RpA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmvyvrB3QckS5hwVvVP28Zw5HmGMl3KZeISffVr5T
 eioxqzEjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbCwcTwT+VfT3LoU8vyCYqH
 3+t0+d6tm2st1Fi1JmNysvTfoHsz7jP8ZlWbKNc478+zP7dUVv4Q2ctcekuJ+Q2v4N3Ah9ulf9a
 c5gYA
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
index da2f5cd37eee..63f7fccf2ff5 100644
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

