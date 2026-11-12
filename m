Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524028;
	b=oEDZ/z0lIUEwxxLbFlgJclRhyaz7p0lbHE2Jue9AS0uu76oSP3No+lA8q5nnnwQW7Til
	 NbeP1rwGqb65B6Nl6cGhjRxxL1oy8xoLEhwGJaXxYF9TLnLB5hf2ca698UpbwJVyra+RB
	 d3zxnPRYN+0VlxooigH7UHAUxgLWDXi/toakY4iLapxwVKldAAseaNhxF2ie/9851HXej
	 w2aYkNJNG4Oic6aI2v7xyFBhYnYlHVbeFrgNm7TRSnWHXUOSZYceI6jtBmbudAS/j0xCx
	 6wBcwescFbVRlub2YWXG4HEia7MEHSkoGy+Cy5Q6ex/t4ocKuJiT+hLyiqg0jNHEE1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524028;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=spq45G9v+BHLuNkZrjDQvT1SZs0PrgnIjPW3DAqKBKs=;
	b=WToN0FKSSTlHRwtMABTSsdxSMynkru5JjaDnMn9o1mteP46t/iDCSRtVFfK4r6LXshtD
	 9SnEAMxB4tT6RVGcZ1AovS6AsYxfOUng6XJqu2aH6NoaxGo/Hj5BlHA3kDVDGznrnr2vU
	 e1CPtooh3CnRFJayyMhGq9qcyUnEFbWRGf42L1X9k+zIieBvoMg0Gmx+Lwc99QPEfku7Z
	 DP7TUE5ri9sIzIECYBR6kspalJgkvMtAFuDAPGwcydIV+dMPVmGuKn/snQ2i2/9WZGhUL
	 sbuT7q0CeMyciBuuvf3CbIT/wGoMIuFefkx9vLnaAo1T5gXQb10KHvdiVLQ0qCum2Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JK8Nn5N9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C879606A31C;
	Thu, 12 Nov 2026 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JK8Nn5N9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7231F000C4;
	Thu, 12 Nov 2026 22:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524028;
	bh=spq45G9v+BHLuNkZrjDQvT1SZs0PrgnIjPW3DAqKBKs=;
	h=From:Subject:Date:To:Cc;
	b=JK8Nn5N9JHISNyle4kultvpNlD1S1n89Z5RdxcoFOwCToi/GsdmU8RRJ+A03Li+60
	 qaphlHbUlh7XufdzL9lxxIsT8y6t6/e1heYsPck9aFybu3OvAI7PuToc/Z5qKRmQ7I
	 A6/LiPpjsUSolcouJQKeHtddhD4g19+GRAwkiwPGfgNt4gFwMZKBUiaj26b8K8Jppy
	 sXs1cmTFl0/nlad+R80hj5SsscnCFK0ACb5JJ8/sw+ntemKj5R5T+Owvi2W85cb93h
	 ZMyC/sI26/7ePrkwThYJBrkbmipcwePJYYzPlyQbEIezAOj191BvhAOCCaa41MoTCm
	 NR36aSSuK7ikQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v4 0/9] mm: limit pagecache folio refcount
Date: Thu, 12 Nov 2026 23:53:19 +0100
Message-Id: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43N0QqCMBgF4FeRXbf4t7mpXfUeEaHzN1fiYtNVh
 O/erJsikC4PnPOdB/HoDHqySR7EYTDe2D6GdJUQ3Zb9EampYyYcuGIMJHXYaDv2w8EGdE1nrwc
 /lFWHVKYcgadMQIMkzi+xaW4verd/Zz9WJ9TD7M2N1vjBuvvrO7C598dNYBRoBlWhlZR1KXB7R
 tdjt7buSOafwD+lbEHiUdIib1QORcVA/UjiQ2KwIIkoCZYrLmslyiL/kqZpegJXvn/KZwEAAA=
 =
X-Change-ID: 20261105-refcount_overflow_stable-542e024130fe
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11907; i=david@kernel.org;
 h=from:subject:message-id; bh=2Gj/c6wHdMlTndP/QzjShNSTBkLdOUwx55GM+aWYaps=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+OWc2fJGVsDy3Web4q569BYuPLnZRvJrsrTBjVnTOh
 0tXvKTbOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiInwDD/7BD/3d/Y52+IslH
 Q/H1mYXfj1XyOhVvdFqRm3MxWDarIoGR4XRcnpKA84T+FP0JNzv55Q88Ou34YEeM28rfidzdf86
 fZQMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

I'm resending this quite quickly, addressing Pedro's review (thanks!!!),
so I can replace the version in -next tomorrow and move forward with
this to get it fixed.

I un-RFC'ed the -net patches, but I will not pick them up. As mentioned
below, they can go in independently.

--

Users can create a lot of folio references to pagecache folios, making
it possible to overflow the refcount of large folios.

While we knew that one could in theory overflow a folio's refcount, we
mostly assumed that bad things would happen and it wouldn't go
unnoticed.

Not so sure if that is really always the case, and leaving that problem
unsolved is irresponsible, so let's limit pagecache folio refcounts.

This is mostly relevant for large folios / thps in the page cache, where
a single VMA can hold multiple folio references, allowing for many folio
references. But with sufficient (memory+process) resources, it is also
possible with small folios, just not that relevant in practice today.

With anon folios (including THPs), we should not be able to trigger folio
refcount overflows, as one would need so many processes that it
becomes impossible in practice. It was likely a problem for anon folios as
well before we had a dedicated pincount.

Let's limit the refcount before it turns negative, giving admin processes
some extra reserves (to recover a problematic system). We still leave some
headroom to allow for some slight limit overshooting, to make the
implementation easier.

But to make that work reliably, we have to make anybody that can take
an unbounded number of folio references obey these limits.

Patch #1 handles mapping references from page tables. We also have to take
care of mmu_gather, to not hold too many references when zapping (whereby
new page faults could remap pages concurrently), which we do in patch #3.
Patch #4 fixes iommufd cleanup when adding folio pins fails, which these
limits make easier to trigger.

Splicing pagecache folios to a pipe (patch #2) also needs care. After
feedback from Linus, these users really should be using try_get_page(),
where we now also implement the new limit check. We also teach GUP in
patch #5 to stay below the limit, to avoid negative refcounts that cause
trouble.

Doing some digging after getting a hint from Andrew, there are various
paths in net that can also take an unbounded number of page refs and are
problematic. Let's use try_get_page() in all affected paths.

Net paths that take page refs that I don't touch because the references
are either bounded or the paths are not relevant in practice:

 - skb_split(): can add one reference per split, but each split
   allocates a new skb that is charged to the socket, and the references
   go away once the data was acked. Reworking that to be able to fail
   requires more plumbing.
 - IP-TFS reassembly: needs one new inner skb per additional reference.
 - io_uring zerocopy send (managed frag references): each zerocopy piece
   is charged at least 4 KiB of TCP memory, so not relevant in practice.
 - kTLS software splicing: only transfers references from the pipe, so
   not a problem.
 - AF_XDP zerocopy TX, nfsd splice reads, sockmap / sk_msg, espintcp:
   bounded, or require privileges / special setups, so not a problem in
   practice.
 - Driver-specific paths (e.g., kTLS device offload): require special
   hardware, didn't look into these.
 - page_pool and net_iov frags: not pagecache pages, so not a problem.

For page table mappings, this is only a temporary solution for
upstream+stable, until we have something better, which will be harder to
backport:

 - Letting the mapcount of large folios be a long
 - Holding a single refcount if the folio is mapped, across all mappings
 - Reverting the limits introduced in this series

After that, most of patch #1 will be reverted, everything else will
stay.

Tested on x86-64 by lowering the folio refcount limits such that limits
can easily be exceeded, to then test fault (SIGBUS), fork(), splice and GUP
behavior briefly when we run into refcount limits on a shmem THP.
The net patches were tested similarly with AF_PACKET, nft dup, NFQUEUE,
software GSO segmentation, TCP receive coalescing with dropped ACKs and
socket splicing.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v4:
- Refine and update various patch descriptions.
- Pick up RBs + Acks (thanks!)
- "mm: limit pagecache folio refcount when mapping pages"
 - Rename __folio_ref_count_over_limit() to
   folio_ref_count_over_limit_slowpath(), pass the folio and print a
   ratelimited warning when we run into the limit.
 - Check in next_uptodate_folio() for fault-around instead.
 - Add comments for the VM_MIXEDMAP handling during fork().
- "mm: limit pagecache folio refcount when splicing into pipes"
 - Introduce __folio_ref_count_over_limit(), to avoid re-reading the
   refcount in folio_get_checked().
- "mm/gup: limit pagecache folio refcount when grabbing references"
 - Use __folio_ref_count_over_limit() to avoid re-reading the refcount.
- Link to v3: https://patch.msgid.link/20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org

Changes in v3:
- "mm: limit pagecache folio refcount when mapping pages"
 - Move IRQ disabled check over from GUP patch.
 - Add in_task() check to prepare for networking patches.
 - Only check for invalid refcounts in folio_get() and drop
   folio_ref_zero_or_close_to_overflow().
 - Improve documentation and patch description.
- "mm: limit pagecache folio refcount when splicing into pipes"
 - Introduce folio_get_checked() and use it in splice_folio_into_pipe(),
   fuse_ref_folio() and try_get_page().
 - Return -EFAULT and don't fall back to copying anymore.
 - Stop filemap_splice_read() after a partially spliced folio.
 - Update patch description.
- "mm/gup: limit pagecache folio refcount when grabbing references"
 - Moved the IRQs-disabled check to patch #1.
 - Update documentation.
- New RFC patches handling networking paths that copy or add frag
  references:
 - "net: limit folio refcount when copying skb frag references"
 - "net: limit folio refcount when rearranging skb frags"
 - "net: limit folio refcount when splicing pages into skbs"
 - "net: limit folio refcount when splicing from sockets"
- Link to v2: https://patch.msgid.link/20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org

Changes in v2:
- "mm: limit pagecache folio refcount when mapping pages"
 - Try not to fail fork() by skipping the PTE/PUD instead. We still have
   to fail in two scenarios.
 - Split helper into fast and slow path. Slow path in mm/util.c,
   exported for Fuse usage in patch #2.
 - Check has_capability_noaudit(current, CAP_SYS_RESOURCE) instead of
   capable(CAP_SYS_RESOURCE)
 - Extended patch description and improved function documentation.
 - Dropped RBs due to changes.
- "mm: limit pagecache folio refcount when splicing into pipes"
 - Return -EOVERFLOW; from filemap_splice_read() and
   shmem_file_splice_read(), and handle it in do_splice_read() by falling
   back to a copy.
 - Check in fuse_copy_folio() as well
 - Updated patch description and updated+improved comments/doc
 - Dropped RB due to changes
- "mm/mmu_gather: flush pending references early before the folio limit"
 - Adjust some comments
 - Update Fixes:
 - Extend patch description
- "mm/gup: limit pagecache folio refcount when grabbing references"
 - Keep all WARN_ON_ONCE() checks for negative/null refcounts
 - Skip has_capability_noaudit(current, CAP_SYS_RESOURCE) with disabled
   interrupts, skipping it for GUP-fast.
 - Properly forward try_grab_folio() errors
 - Adjust some comments
- Link to v1: https://patch.msgid.link/20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org

To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Nico Pache <nico.pache@linux.dev>
To: Ryan Roberts <ryan.roberts@arm.com>
To: Dev Jain <dev.jain@arm.com>
To: Barry Song <baohua@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
To: Kiryl Shutsemau <kas@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
To: Ying Huang <ying.huang@linux.alibaba.com>
To: Alistair Popple <apopple@nvidia.com>
To: Peter Xu <peterx@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Song Liu <songliubraving@fb.com>
To: Rik van Riel <riel@surriel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Hugh Dickins <hughd@google.com>
To: Will Deacon <will@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
To: Nick Piggin <npiggin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Kevin Tian <kevin.tian@intel.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Steve Sistare <steven.sistare@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
To: Jose A. Perez de Azpillaga <azpijr@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Neal Cardwell <ncardwell@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: fuse-devel@lists.linux.dev
Cc: linux-arch@vger.kernel.org
Cc: iommu@lists.linux.dev
Cc: netdev@vger.kernel.org

---
David Hildenbrand (Arm) (9):
      mm: limit pagecache folio refcount when mapping pages
      mm: limit pagecache folio refcount when splicing into pipes
      mm/mmu_gather: flush pending references early before the folio limit
      iommufd: fix cleanup when adding memfd folio pins fails
      mm/gup: limit pagecache folio refcount when grabbing references
      net: limit folio refcount when copying skb frag references
      net: limit folio refcount when rearranging skb frags
      net: limit folio refcount when splicing pages into skbs
      net: limit folio refcount when splicing from sockets

 drivers/iommu/iommufd/pages.c |  15 +++-
 fs/fuse/dev.c                 |   4 +-
 include/asm-generic/tlb.h     |   4 +-
 include/linux/mm.h            |  89 ++++++++++++++++++----
 include/linux/skbuff_ref.h    |  53 +++++++++++++
 mm/filemap.c                  |  28 ++++---
 mm/gup.c                      |  32 +++++---
 mm/huge_memory.c              |  32 +++++++-
 mm/internal.h                 |   4 +-
 mm/memory.c                   |  41 ++++++++--
 mm/migrate.c                  |  11 +++
 mm/mmu_gather.c               |  10 ++-
 mm/shmem.c                    |   7 +-
 mm/userfaultfd.c              |   4 +
 mm/util.c                     |  26 +++++++
 net/core/skbuff.c             | 169 ++++++++++++++++++++++++++----------------
 net/ipv4/tcp_output.c         |   8 +-
 17 files changed, 411 insertions(+), 126 deletions(-)
---
base-commit: 2683df3b7eac1d91380194955ad0c9751454610c
change-id: 20261105-refcount_overflow_stable-542e024130fe

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

