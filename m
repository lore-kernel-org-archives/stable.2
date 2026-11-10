Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343018;
	b=I8S1ivELphEzNkP6ByYibx3nQewI1h+zTqzf3FQLha1FO9ekPEN3XbzL/VMbjrY0lQu3
	 0TxuVbBAJopRN0vQjRQDl42gl6J/LvwlgMmi26YIxrh12YBtNDDWY0BCEkcGxokqnwvOo
	 ZHtsrvwujI1pIw8ddyPBRa3O5x/D8tOUaxIV1UIsDpnUJjIqJ2ummZwwYREzbw3z2E6I4
	 g2UnJ6QMKG1bdSOKTXRGlm3bY1s9FF78JV3cyh8qvtKYL4B0kbe2nK6xWjNTIL73/hHm7
	 h8JXQilUfMoxphtZze6/CfY6WPPXHIa95ynr3cqxYozaRme9HN1Lezx1+nvmY+sr8MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343018;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NsXNV0XyuBkLuHvw0vNui+ESXIede1+4IrRZpzv3Eac=;
	b=khHMOBDObpLAb04F4fulxRov1NQzkCAZjrpM7CuJr2d5tCOs3Aaos3LyBHpqb/8lTewT
	 SC5kx+nuOtXeaLaJBCgMPWKkOp1dwynIw22fGbfmVJaNXW/S7s4U3CTPqtj+J7vf6upDN
	 ApspKZPsYLeZaSgTdEU81TPA9gNiHtN9MHB9/1dILwRPBKiZ0n4sPiWkZqakoncPuwgkT
	 RQHpgVL3U3HF7fDvYoxm1HaCpyb5qLIwbxw93Rq34dXTCNUjes7E26n/UsyaBU5IfFiM+
	 W+NI+LfXABgevD3jzhR/icNsM1uXvlz7FYC0PcWz9iS4g3UnrxuDLgPB21aCTGgGATA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9eO2xvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97559606A31C;
	Tue, 10 Nov 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9eO2xvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8FB1F0089F;
	Tue, 10 Nov 2026 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343017;
	bh=NsXNV0XyuBkLuHvw0vNui+ESXIede1+4IrRZpzv3Eac=;
	h=From:Subject:Date:To:Cc;
	b=Q9eO2xvSaqvUM1Ca6p37Eh3aXZqCRGpEydxMdPFyqtdmcJtzRSr8v1Da4pw8fDWCb
	 Jw59cJMUCzU4LL0P09FoewDxjCap75JL46oWVFfeBwPel88l+hFgjWtGmV+0jUMwLC
	 LbnS6wrl7TQOm3U2hht5l2nlf28lAqs3KEPNww3G7uvFFXHenM32nHs/XKBYCzmEdj
	 d4JL/t5+aalIYa9ifCPPmRjSF6fdk6QVcW9NQ/v8j0y0Nb6IYrabPDEPMaycv/AdSz
	 XKcVIysE6pD3gE6/RpXo+LUz5MBFMK9k7Nf9NaQZQUyntdzV35Tocw65eH1gyBXBrK
	 y/gXzME7Ww18Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v3 0/9] mm: limit pagecache folio refcount
Date: Tue, 10 Nov 2026 21:35:40 +0100
Message-Id: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBgFr0K6tqY/tIAr72EMoeUDqoSaFqqGc
 HcLbnRjXE4yb96MPDgDHh2SGTkIxhs7ROC7BOmuGlrApo6MGGGSUiKwg0bbaRhLG8A1vb2Xfqx
 UD1ikDAhLKScNoDi/RdM8tvTp/GY/qQvoce2tRmf8aN1z+w509f64CRQTnBFVaClEXXE4XsEN0
 O+ta9H6E9hnKftRYrGked7InBSKEvlVWpblBeS3KU4dAQAA
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
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11091; i=david@kernel.org;
 h=from:subject:message-id; bh=C6GCig3Dre4xDS+Hdl8CtipE1iBsILWdDMHO/rV5xmk=;
 b=owGbwMvMwCF2QOXvyb15Z08znlZLYsj63OD0O61NQvhn8Xeziyqz0q9mVD7cq6wVe4Bnln/rB
 8VVfVonOkpZGMQ4GGTFFFmurctJDV7T6lgWZegGM4eVCWQIAxenAEzEspvhf8S2xSe2X4jz39++
 r6fmZMqP88JLPijpG/2XSvG3s4qZvIWRYe7Jz73HE0N6wxsKYkrLnabfip82obQ2i9H7WJHufqE
 nvAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Note: I really would prefer doing something else right now, but this is
rather urgent.

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
possible with small pagecache folios, just not that relevant in
practice.

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
problematic. I'm attaching RFC patches as I am not really a net expert.
These patches similarly now use try_get_page(). These patches can go
in separately.

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

AI tells me that with the current changes, we should cover all relevant
unbounded page references. Needs more investigation.

For page table mappings, this is only a temporary solution for
upstream+stable, until we have something better, which will be harder to
backport. I have patches to:

 - Letting the mapcount of large folios be a long
 - Holding a single refcount if the folio is mapped, across all mappings
 - Reverting the limits introduced in this series

After that, most of patch #1 will be reverted, everything else will
stay.

Tested on x86-64 by lowering the folio refcount limits such that limits
can easily be exceeded, to then test fault (SIGBUS), fork(), splice and GUP
behavior briefly when we run into refcount limits on a shmem THP.
The net patches were tested similarly briefly tested, but more
excessive testing is required.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
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
- Link to v2: https://lore.kernel.org/20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org

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
To: Linus Torvalds <torvalds@linux-foundation.org>
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
      RFC: net: limit folio refcount when copying skb frag references
      RFC: net: limit folio refcount when rearranging skb frags
      RFC: net: limit folio refcount when splicing pages into skbs
      RFC: net: limit folio refcount when splicing from sockets

 drivers/iommu/iommufd/pages.c |  15 +++-
 fs/fuse/dev.c                 |   4 +-
 include/asm-generic/tlb.h     |   4 +-
 include/linux/mm.h            |  73 ++++++++++++++----
 include/linux/skbuff_ref.h    |  53 +++++++++++++
 mm/filemap.c                  |  32 +++++---
 mm/gup.c                      |  24 +++---
 mm/huge_memory.c              |  29 +++++++-
 mm/internal.h                 |   4 +-
 mm/memory.c                   |  37 +++++++--
 mm/migrate.c                  |  11 +++
 mm/mmu_gather.c               |  10 ++-
 mm/shmem.c                    |   7 +-
 mm/userfaultfd.c              |   4 +
 mm/util.c                     |  18 +++++
 net/core/skbuff.c             | 169 ++++++++++++++++++++++++++----------------
 net/ipv4/tcp_output.c         |   8 +-
 17 files changed, 378 insertions(+), 124 deletions(-)
---
base-commit: 2683df3b7eac1d91380194955ad0c9751454610c
change-id: 20261105-refcount_overflow_stable-542e024130fe

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

