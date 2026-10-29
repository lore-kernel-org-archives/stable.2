Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270702;
	b=LiZlfQct3MR6Oh3DXv5GQWSXVVD1xziiKlupFGAdjXfeRCKgzkAHwtwRb0vd2HJinfN3
	 b9dRUhsu5z9Zkj/Sof7MfCFUibdI0Pmd54e6nxiOfdpDpZC6oL+O1NCiAxQJ4zgUpCImH
	 AWODA4LfuhtGVv5tzNn3J6RTwinePGnvuVyBwhEB9xDvQoXy56+f10STwSaljhIJbY8sO
	 oa+iTiGd+R2eJ7YJ+lbGQOt8fdv66pMYCs2lw5jYlLIoGbe0GkUyITe4ptzfrtV6vT76F
	 aLCbcPxInylVfCyclhhk2cyjAI98CfJelGkvcYE/3oDbSvxhTUPiUOjFT8YLABr59Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270702;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Jklh+C8k6+z2h8BQBf1LZgJVYEa4PBy+2sbpk3zqCZM=;
	b=doxP2lKBvdHd1zENW3DJfPDz3wUUNH/OdLuvINIovzfbj2RaZEO1saso6HuMMlZqluNx
	 KTo2v/xG4vMp3DimFV1xkKSd3LAZ99RMQq9L/rhsfnRYx2lhG/PBZ2+lUvGxU9DNPYsQX
	 Cf6eJ3AaXe+mBVJ4WOiGr8UD5Xrkt5K7AJ1qBIw6uJxxBbADldI78LOtAOwVXuoYlTJEC
	 tChJeZqdTJdlMx6G1esJXkJNRCuum45Ho9uK3SI8o8mY9ZxluXqjtX2aZ8KuidQGV29A4
	 HTRCcxOADJzlFRbQMDvhzf+UYRv7XyjOaWUyF0Hkugj23is5vHRSkrQ/2o56gUi74yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqqCWDCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ADA606A31A;
	Thu, 29 Oct 2026 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqqCWDCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B17B1F01825;
	Thu, 29 Oct 2026 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270701;
	bh=Jklh+C8k6+z2h8BQBf1LZgJVYEa4PBy+2sbpk3zqCZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gqqCWDCHluvI/2m+PHmQwGqLQA70GogB+v7g1lQaBi0fWAEGof1xIZEe96KTIzueX
	 Fi3YmUKj4YMLoJmiL2RHrLrkDfiAFAPhYlgsamX5T87CLLb7COxN+K+1GGg4qXs9uh
	 hiXCNSM27GmH6n3equC4Qbm4zcMnAGIWDE0equkJEqaPLMQNkNbrQhL6a8M7HL0lH1
	 7hinojnZRSe97D+F0FDRmw4ENnZG87pgg4VN90B6ns6Fj18bjIJ44FIWS5uC3WEDxy
	 NeFkEeLoC8mKvjP91LeYl+of3mcY92SljhW2cJGlA7g0apkZ4Ded1A/KOw3pv5Y35u
	 yLCqA46yvCMcg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:29 +0100
Subject: [PATCH v4 08/15] mm/shmem: preserve data in clean folios when
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
Message-Id: <20261029-fixes_shmem-v4-8-392fc715d8f6@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3639; i=david@kernel.org;
 h=from:subject:message-id; bh=y+fkP3XRhSdYc9v7R6EE8urjEHODsYBOBASodiKGd7U=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4c/+Fn0dUn1XsE/mqYrVhsZ1datPZ1y+tOTGTyvz
 5+qO6nwuaOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJHLrB8Ifr1MRnSbP/hEfO
 ecL76WXbMonU2K8+blMffhY1YvtyYwM/I8PRL2yS+sJbDqYYGWu7/J2q+vmzTKyKHT/r3wxjdz+
 JXewA
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
index af49d6bf6382..11c3e6b1aa76 100644
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

