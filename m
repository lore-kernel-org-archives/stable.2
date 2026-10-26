Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007728;
	b=IzRC5o3Dx57vQamrbQYsFE6P/4IX37r7zl7QdffoZop+uncvhBRimtEEeM1PNCbuZTgJ
	 sasorSuu7S90NPTn+XLmMomVre4jQtIhntiL7GTXBkwHBYd0kc5CdyPKu5zIdj8KSu/HA
	 op6g7WrrFmSq8+tjf8dcu0XAzLtBSHgYT4gyVs93j4tliaQoON7J1Qtb79swsocGgmoLU
	 W70N/VVHVE9I2z3cSOZKlWhks2RtEi/PE9Qt4+o0pdJMrdTb72JYYe7a1RasU9ly/20Dy
	 IjRnpUjtrQ+wteI3UgXXr86igckYq24OmWApaT44SUJwUG9t/3NAtBhSR4yYLijA/Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007728;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xxsrvdQeklij5bNnoXCI3fI7ymOsyRK2is1t/Mfw9Uc=;
	b=EPb6VJ/0bU2BE6xzGZpbeRnF3XiDh1LpzOkUMERkjXPvWzKcokqVuOa5IIZJUmc0pKUc
	 0MqYwIsKkzMdIvl5d+SCX8wFK+6k2QGDan1XTKPwwMBxlVTdoKEcfIQvpvdcSKi6HTrOv
	 g7HOYIVz/Us7h2RGE1nRZwLRjl171vEHHrtfvLtyByiTM7YCGNw1N9eAvP9Mz+cyya15o
	 q0tQ7TEFHnUtLW3WRAbflLTd5210/DUI1zwApxDVD//cfvD6yGjfxFz3w71dE4LB9SIp0
	 5J2xxWIznBV5SeLFRZfJY6IIj7SKBLw/6M6zB12nGEplNHRHX8kykSOlYxZlcc+ph9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjVpZyiF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9D606A327;
	Mon, 26 Oct 2026 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjVpZyiF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BE01F01482;
	Mon, 26 Oct 2026 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007727;
	bh=xxsrvdQeklij5bNnoXCI3fI7ymOsyRK2is1t/Mfw9Uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LjVpZyiF//41fBlp/4QleJd9wySMgtYf11Q4g773yO5jjicIeHAR1b3GvLGFUmtKa
	 rAx0NSzVSEQDT4qr4lCgCQbWo6XaCjmHAUt0qPd7MuH2dcibosdTeYBtUgKG4DXAUO
	 7DEtVx+ODrpkOBjSGBG4gObiIBi0FDb6uZ0OxNGIiuZSzsajPqyKCFWMmOQ0X1L5lp
	 q+UmrAKYpWtQOcNUCBQzy0iYsQ3ZvJ6OMhFN4s8RTFwW7P7E27RYpwr99NdJ6bPdF8
	 4Yr8BljsTzEEJIPHEOTCoxHxRMPGtE4FaKFJqNBanrHneYrYUrJbKxx3hYBQ3r8OEh
	 6PwXAh6gDkxPg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:44 +0100
Subject: [PATCH 11/16] mm/shmem: rescan after nonuniform folio splitting
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
Message-Id: <20261026-fixes_shmem-v1-11-703206d5fa0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=david@kernel.org;
 h=from:subject:message-id; bh=e0DEI1Pn/7U6AfFOcXN2aY3ffxdCD7lHzQz5z/jQDwA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4hXd+vsuVVmmt4jYSMpFdqxnPlPrWL75m0Gx07+u
 8So/MS+o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIn83MvIMN9Pi69cpsSmzdRt
 RVrEnv9X5pt4Rb2Y57B2+tJHy2ZabmX4pxHl2M1QuPcE171vKmbVGnIG4qtrXe6XMDTWa64y0Hn
 IBgA=
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

Restart when the original folio is still in the mapping after partial
truncation, identified by checking folio->mapping. If the helper
removed the whole folio, no rescan is needed.

Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate operation")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c8608026e06ef..fcec40a2dd707 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1487,14 +1487,11 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 					truncate_inode_folio(mapping, folio);
 				} else if (truncate_inode_partial_folio(folio, lstart, lend)) {
 					/*
-					 * If we split a page, reset the loop so
-					 * that we pick up the new sub pages.
-					 * Otherwise the THP was entirely
-					 * dropped or the target range was
-					 * zeroed, so just continue the loop as
-					 * is.
+					 * If the folio was not removed, it
+					 * was split. Retry the scan to find
+					 * the split folios.
 					 */
-					if (!folio_test_large(folio)) {
+					if (folio->mapping) {
 						folio_unlock(folio);
 						index = start;
 						break;

-- 
2.43.0

