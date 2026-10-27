Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106260;
	b=wS+zFDdkxKxgh+jp2aGEA1W3P3mN0+PrXogjs0TbipBO1AdX9xvKhT/DGYpqxzk2Odeb
	 YL2FbapzXPEDBEk9ZJE4vp2j+ugqkqY6iY64yGfXO/270D0s6wYfkOTYFDeocCGzWCSkN
	 X/lleWgD5eJRXW0TwuB0Z8Hwwk+HLi7mzvbRMIm3Hr1GAxbwnichQnkHyRz36LIyV+xqL
	 wowCeEDOu9RMS1QHZQCooJPsP3C/6XieFemhVaS7nf1e8FnJPw8rVom+yC3HOMNAyKOaD
	 EGqnsfS2Z63jkxt/TtdhBQP1qIYKoNxWnfoubz/QiaoBilZ+DWLM1nR/4LiZo9jwhjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106260;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lZQnjGr+7zqAkUOcYsYc+HBCm7IFXBoUv+E4NCOAhu4=;
	b=wQKxbh8FKThMnXLVXV69/yn70upz/59l+MGoPaA8lvpTtLrr91HgjqGXIeLp0H09S+DB
	 MIcsHjb0ymJeONYDcQUYcefA0+kEO0WYL1T2q5J90ulxn16lS30I9FNvgk04nfhbzW3mp
	 ZGWzX5YAydZESRa8X5Ra8Y9eqbyJmLXOxI1SES4TKDhMetBFu/9K1cUBXQQWSKsM0oriB
	 6QcAYq2XYhX9wrvY3C7RnwJnBf4Z8qQOXs+TXrW+BRuHoyUuawhLki8VBX82hhk9obErH
	 JxauhfwxEBX/EK/P3YfEb0tfVYX+v2OK8OT1bJUVMsPEZ6g6l+amVgtGQ69R3xw17Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1Xnx4sq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C711606A31B;
	Tue, 27 Oct 2026 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1Xnx4sq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDBF1F01825;
	Tue, 27 Oct 2026 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106260;
	bh=lZQnjGr+7zqAkUOcYsYc+HBCm7IFXBoUv+E4NCOAhu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I1Xnx4sqE9jldE4r0IuDBNkjaKVACPM/Y5b9c6/UmLWn5lMRQmxPgq67uXu8V8V+F
	 AmKwsgAKsyPxyb6d5isPOOH+N+X+yOm2ibKX6jN1Ph0YSBvYmS50t9ckWri7MQNEWk
	 nIMK+bm+ZgR0NZqfcgO6D/4NF9H0IVMdXT+I+/2AbCxu3WxUS5IpP/q4ldK8KBlBnk
	 TrE+9CyCj/G2hYiJ5lzZL21yrZF7v4b2agW5xTmAiWUB8asHxACtTAy05ZQXGPGnhw
	 DYzK7NxUE98gHJyBcDBpzQpe5YzVcI6uZbbbgO/BCMtXgPKqsliqhYc1WF7CsIN7Wk
	 iIyKC04Mge4jg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:12 +0100
Subject: [PATCH v2 07/14] mm/shmem: preserve data in clean folios when
 splitting fails
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-fixes_shmem-v2-7-86a00952acb9@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; i=david@kernel.org;
 h=from:subject:message-id; bh=odgGbKts8VBN1JHhKCe+8QzRLyJJiUf0Jtw5O8U8cvw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBR8eKzItSjQYqGyX7Dm53vPCqY+lU98vTpm6p05r
 R72TknFHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkmz8jw9NJ9w/yaWvquTza
 2Wtw/zZn50qjW7Yfl5wIK+lZuctnChsjw0aubeLlIWpMyoHhXnlZpd6ygYHLduya8GvytQ7TWRP
 OMgEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A shared writable mapping can have dirty PTEs while its shmem folio is
still clean. A read fault can install a writable PTE, and a later store
sets the PTE's dirty bit without marking the folio dirty.

After shmem_undo_range() has handled the boundary folios, a concurrent
read fault into a hole below the new EOF can allocate a large folio.
For example, on a tmpfs mount with huge=always, the fault's offset must
be within the file, but the allocated folio can extend beyond i_size.
The final scan then finds this folio and calls
truncate_inode_partial_folio() without marking it dirty.

Splitting normally collects the PTE dirty bits when unmapping the
folio. An extra reference, for example from vmsplice(), can make it
fail before that step. The fallback unmapping on split failure excludes
shmem, so the helper still sees a clean folio and drops it, losing data
outside the range.

CPU0: ftruncate(fd, 3M)                CPU1: MAP_SHARED, tmpfs huge=always
─────────────────────────────────────  ──────────────────────────────────
i_size = 3M
shmem_undo_range(3M, -1)
  first pass: hole, nothing to do
  boundary folio at 3M: hole, none
                                       read fault at 2M+x (below EOF)
                                         PMD folio [2M,4M), crosses EOF
                                         writable PTE, folio clean
                                       store to 2M+x
                                         PTE dirty, folio still clean
                                       vmsplice(2M+x)
                                         extra folio reference
  whole_folios: finds [2M,4M) folio
  truncate_inode_partial_folio()
    zero [3M,4M)
    folio_split()
      unmap_folio(): extra ref
        → -EAGAIN, PTE dirty bit
          never reaches the folio
    folio clean
      → truncate_inode_folio(whole)
        [2M,3M) dropped
                                       read 2M+x → refault → zeroes

Mark large folios dirty before partial truncation in the final scan,
as the boundary handling already does. Exclude failed-fallocate
rollback, which must discard the folios it added.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: simplify descriptions, adjust comments ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5d21cdf5fb0a5..b615301a311e0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1464,6 +1464,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
 						folio);
 
+				/*
+				 * A shared mapping can have dirty PTEs while
+				 * the folio is still clean. Mark the folio
+				 * dirty so a failed split cannot discard data
+				 * outside the range.
+				 */
+				if (!unfalloc && folio_test_large(folio))
+					folio_mark_dirty(folio);
+
 				if (!folio_test_large(folio)) {
 					truncate_inode_folio(mapping, folio);
 				} else if (truncate_inode_partial_folio(folio,

-- 
2.43.0

