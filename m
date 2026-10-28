Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181387;
	b=x4zPuwnkF+9DMZ9gT7Cm84G23YBScUqjisWehH74z1tq6+fuN1GHEz1Ojxf/oSDLIWzc
	 Sq8b6HOkfG0erlUwfADCW10VEfbnNgZl/61OAKNDZ8EDtYl6D2zagOWrLJOecwavFaf5U
	 H/Td/E9TkzUUBr7cyCHmlddFFndiBwg4vS5QtRBnWcXdSZ4omBNgG7zcGvRJEEsm89kcK
	 2zYJdxiei851Cv1UAEY3k0k2fmJkTALiLJ40ZVyNDp8Om3f2+sGqlgbl4HtkC7leSJ+Q5
	 wVjiZhQfQiQBHJQoFA1IxXI8bYXHjukzhMXIPloQKpBaOzQyW/dIGbJ2jYT1p0q74pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181387;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DTFrfwyATFzlD7oFB0faIDoeDkfv/OEfzxq3WEUQcw4=;
	b=fmbHDnVoy2222lV2LAN2M5rC8K4LVpd/zvF9olmxd7QVbRe8YBSfGClDro0i+1VR5Dgk
	 KLoxskEd4Truekfvav4on5U8LJJCg7EtbRTEe+Pq5R6zx1YTqDNNKs2z+eKWYG4Wzn/Uf
	 5w2UdYhHFsYB59gGejwA0PtMnc0SZ+Cl3vnlKUloWivV7LXZPBcZ5w1DPE9rCe6tDa2Hf
	 969gT34otFqpYdvZ/uI9h75vmRAuMnx4Faccp5N6NM1K13gJmhdPFN8+qq2IgxnCEfZ12
	 91m6Vc/opFTDfZ8GVljF+sMoyPIuFCNxFVMp8PupHoZETUjf8/qWg4xjlKD0Pg9f6mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSZfw6Ng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B0606A31C;
	Wed, 28 Oct 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSZfw6Ng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720F61F01825;
	Wed, 28 Oct 2026 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181386;
	bh=DTFrfwyATFzlD7oFB0faIDoeDkfv/OEfzxq3WEUQcw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gSZfw6Ng/724IXC3V4Uz1Dru+nw652GarxIa4RjukdE330gBrqtLmOtPKK0NnQqZH
	 Jjt7JL/+CNPrGBQLOO5tTcijNCPDPYmq32RTTe1wJh4F8C1uw6gl2jxsxyHOePlIq+
	 9ek8/6ojBBVTvBx9lN9V4nNaQp4b8r6aPNx9+9OQsyp3nKnU9/WMCAPblIwr0cmy96
	 sc55V00HaUVuSJJA2haxiCzMyhcg2GwrwOv8c8ypj7VQpJ5te5u8px2ch9mro0wtWU
	 LXW30ysiwpxErXuHQxgWchO53hxpRAEGMSd5ceSRYZpuJhSnaTXfrFhR7GiHK/b1a+
	 Yj62kCUuzjX2w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:06 +0100
Subject: [PATCH v3 08/15] mm/shmem: preserve data in clean folios when
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
Message-Id: <20261028-fixes_shmem-v3-8-4ce3baf2db4b@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3639; i=david@kernel.org;
 h=from:subject:message-id; bh=qRxbYmef81DsO+iuJnbFf2IXu09HY8IXlLHGqp7GkUQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmt6V9t86qfEv3k8NyOM8x9MjFjlsPzWvSvzp+iHO
 Pcqlsbf7yhlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAi+r8ZGZ7U2726yqfuOI/z
 mIEMT5RNsH5CrHlJ7MWtXYcmbpwjsZqRYWJNlYuwmOpEhaVaJ6fNnvXtZjVTv/SK7n9VHguaGT/
 2cwAA
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
index 50d526edc2d4..f52bab8176d7 100644
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

