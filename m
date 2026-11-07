Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090255;
	b=DVP2WIOzh51LeVAFnNxPEOo9SVfm1f+mcTlZPWC43wBEwq9exXp4hH0HKyZCQOxPsBU+
	 /KUjKqEmNjMaZvU0Eu6mvLaM1sbbp46SRZucqPwtHaXzkc2Sdvyo5VqmCffxbxPJybYqP
	 a7cZzcA6Ec8cLPpev1uTjMUU4HBFyBgOCvtkZBtj91jCtd9kJhuzFg4yZ2Y2umzHaeuGN
	 qjoD2Pd3r9CVfCdDMPTFs0uiBK6SXoOnRGn1doP+HXU2wVvhSYTxpxdcPtL3BC15JROvu
	 8EJT7NgXz3jW7uI653kbFFmMDd7KJjGdValslb9cnoPOJerxbNne5o3ry7XWf5oXCgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090255;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eg5b15u+rTVmwb11gnjCWgwIU3XL9azsyPKK5bBy5wk=;
	b=f7GHR9iD/0fz4wfzRI74oZpg8Us3JqVCrJOw2hxICvHnA3wXOWiJk+L29vJwSIRIhdLV
	 BE31Wrd4xVnU59dKnm5mElE0bW7I3FYb3YJo7Ncpy8q2U5JgPE1I7T8QK0zlZzM1HvGVz
	 nRrc1FKQ1ngSrZGschjzLrPk6hhdbkGGNMNj+h9rj2X8hvyMOsP1uhmXMMW95vMkDSxQp
	 gXOXaaHNKRZYzhXiWOoD7KIAKIY1PYLvBOLyYwAlipAFHHB02hYMReRF1vFqXguVU036w
	 oJES+qD/tv6LUBZadL1G8VsdibealT0q9nBpiRkzIoGd/sd/MaUeXyJAWCLQa/9vddw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWg5Gcle;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18626606A32C;
	Sat,  7 Nov 2026 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWg5Gcle
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C641F0089F;
	Sat,  7 Nov 2026 22:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090254;
	bh=eg5b15u+rTVmwb11gnjCWgwIU3XL9azsyPKK5bBy5wk=;
	h=From:Subject:Date:To:Cc;
	b=GWg5GclejkN5ISovErIV30qR90Bi6M6LkEDCS66iT3mU4aWIxfBW6GdXWslhQ7KgU
	 bK2z7C57+zrCBW1sTMdPz5zM7FsbRSYjesUJapWWIfNDcDrmzfUmIvmtu49TM1mwxv
	 ja1zpWR8RkkSLTFEnixGVPpPY0u8Xgu8/gYQTOLGb0/w3HPLSLRNl56SVK2CUNW5pY
	 JlunxVAYzoMCU+KA+V4Dtqk7hhaPNpIozWOFRDahW+dJZjvK1w1mq3LuA5OlkeEcCB
	 G1EoKFs0B4WAyNe/gXvpNnVuxDikDZCpzZS8c+I6ZujIA9lxQT8fFBeby/7BqHJ+jn
	 hfh70rDjAL5WA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 0/5] mm: limit pagecache folio refcount
Date: Sat, 07 Nov 2026 23:23:36 +0100
Message-Id: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0JmbU1bKEZX3sMQAmWAKmnNtFQN4
 e4WvIDLl7z//gIeyaCHS7YAYTTeOJtAHjLQY2MHZKZLDJLLUgiuGGGv3WxD7SJSP7lX7UPTTsh
 UIZHLQuS8R0jzZzLNe0/fqh/7ub2jDltvM0bjg6PP/h3F5v1xEwXj7MTbsy6V6pocrw8ki9PR0
 QDVuq5fdtdUVdMAAAA=
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
 Josef Bacik <josef@toxicpanda.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6873; i=david@kernel.org;
 h=from:subject:message-id; bh=9KzEE59aveBB6sn+9WVX/Ykd3tcmn6ZAgwUHPEnyXys=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeL/k3/57Hr8ubliccFjHQiduuuuG/ekXyhtzI5NMb9
 Zdem5tq31HKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBE9hcw/C/1mMcyeUuf7K+r
 rEYBB6allwjdUjOSUxbg4TJ88WqS3HtGhvl/6sWuuraz8F5ZxhSsye66MPqM5p6Gvzs/mLi+dWt
 gZwMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Users can create a lot of folio references to pagecache folios, making
it possible to overflow the refcount of large folios.

While we knew that one could in theory overflow a folio's refcount, we
mostly assumed that bad things would happen and it wouldn't go
unnoticed.

Not so sure if that is really always the case, and leaving that problem
unsolved is irresponsible, so let's limit pagecache folio refcounts.

This is really only relevant for large folios / thps in the page cache.
With anon folios (including THPs), we should not be
able to trigger folio refcount overflows (until we get PUD-sized ones ;) ).

It was likely a problem for anon folios as well before we had a
dedicated pincount.

Let's limit the refcount before it turns negative, giving admin processes
some extra reserves (to recover a problematic system). We still leave some
headroom to allow for some slight limit overshooting, to make the
implementation easier.

Then, we also check when splicing pagecache folios to a pipe, and
improve our existing checks in gup. We also have to take care of
mmu_gather, to not hold too many references when zapping (whereby new
page faults could remap pages concurrently).

This is only a temporary solution for upstream+stable, until we have
something better.

These fixes will be a bit challenging to backport to stable, but it will
be much easier compared to the RFC series I have here were we do things
properly by (what we discussed a couple of times earlier):

 - Letting the mapcount of large folios be a long
 - Holding a single refcount if the folio is mapped, across all mappings
 - Reverting the limits introduced in this series

I'll polish that up and send it once we merged something that can be
backported to stable.

Tested on x86-64 by lowering the folio refcount limits such that limits
can easily be exceeded, to then test fault (SIGBUS), fork(), splice and GUP
behavior briefly when we run into refcount limits on a shmem THP.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
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
 - Return -EOVERFLOW from filemap_splice_read() and
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
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: fuse-devel@lists.linux.dev
Cc: linux-arch@vger.kernel.org
Cc: iommu@lists.linux.dev

---
David Hildenbrand (Arm) (5):
      mm: limit pagecache folio refcount when mapping pages
      mm: limit pagecache folio refcount when splicing into pipes
      mm/mmu_gather: flush pending references early before the folio limit
      iommufd: fix cleanup when adding memfd folio pins fails
      mm/gup: limit pagecache folio refcount when grabbing references

 drivers/iommu/iommufd/pages.c | 15 +++++++++----
 fs/fuse/dev.c                 |  5 +++--
 fs/splice.c                   |  8 ++++++-
 include/asm-generic/tlb.h     |  4 ++--
 include/linux/mm.h            | 51 +++++++++++++++++++++++++++++++++++--------
 mm/filemap.c                  | 17 ++++++++++++---
 mm/gup.c                      | 24 ++++++++++++--------
 mm/huge_memory.c              | 29 ++++++++++++++++++++++--
 mm/memory.c                   | 39 ++++++++++++++++++++++++++++-----
 mm/migrate.c                  | 11 ++++++++++
 mm/mmu_gather.c               | 10 +++++----
 mm/shmem.c                    |  4 ++++
 mm/userfaultfd.c              |  4 ++++
 mm/util.c                     | 15 +++++++++++++
 14 files changed, 194 insertions(+), 42 deletions(-)
---
base-commit: df3c65887715e66e2cba69116924020c37996cd8
change-id: 20261105-refcount_overflow_stable-542e024130fe

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

