Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884228;
	b=o9yUzorR9m65hkjhm7yiKgbiY7dN5mJawCXO4MzgMKeYCGfBr2+vr5/T00cfu7ZMmfoa
	 tLo91swDKSs3+e0Q4/4aP84l2mSDwIZIex22joMplZn/xxLthByV35aVXE+MkqQNHvO/3
	 8fPATPbcW3vC7juRDUWp3PI9RS3r9Nx/zjqoE9eXciPNNZFMy0R7p09ECw4w+H4FdceT6
	 J+cb63NMd5f01nE+5h5Ir9LIJt1lW8dGm8nn8/wuc2WWSdO+J5ubV2u/MQrs17pLxErDK
	 GgBxrTdWAYLmZEy41dVuDIt9anDI7MZuvz/W+I6Jw9ARrPWpLvA32VvwVYVmzju8mlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884228;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4JVtXgjnsEuq37SFb/p1jbhOS50fULU4Fu7t4ksVFwk=;
	b=kYhl57Z17qF7LjsZcUZ8rD59M3/ewkx+aP/I1aLWwnnWnZSS/Ywf6DdudTkEeB3OIan+
	 iHbykZqx1SnzJBCOstUdzExnGUZN29SrQkj1P9pxjT8FUwaXwyLDb5Kixm++QuvjSbnKa
	 ZQLJuIALj7ZScvV3QvcALsu/tS++eUSiHR3w5uW9LqY5bhdVPRnXctvS8gBLb8jgS0PmQ
	 xbQek7tv4CSXMeg6XBXE5Ca8ONznOM6D4A5lFc4WvB4UFFcS6N6oSc0OqF0cCuwU0/0cw
	 ayN6rH0fW7nrVOlItV257lwmP588QcROCS85aZwkggzBOe29o6K/dnnEOf085gFU5Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvG7UJAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E877606A329;
	Thu,  5 Nov 2026 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvG7UJAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78851F00919;
	Thu,  5 Nov 2026 13:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884228;
	bh=4JVtXgjnsEuq37SFb/p1jbhOS50fULU4Fu7t4ksVFwk=;
	h=From:Subject:Date:To:Cc;
	b=EvG7UJAAFso5sazSELc3T7U8SeTiF0WumSDWQqvbbeJubVZRt5xkyIpRNtFRBK8Yz
	 eadccCdYVey0fBS06FLj6OAeQRxr8N2wXCMfAzd9keVqEFbgjY7DUOBS8W4ENcSYi2
	 0Y+5yUw8I1QnXBbHWgkAM9Xk7/7hnNuT9Zb3rQSgSUWxjadNHQR14gBNyjM1cwQL+G
	 Z8bAyW4QcOtEG6qWMxXHGfLuGWiteReZchluVqwS/4hrej0HAbuiFrh+Rbdlus1lKY
	 kk5kbbueWuE2AZqDy7zFrg0BvH0K9c0pNobYApBIM8xvVJV+jOZ+Q6xOBL9S9BEJSF
	 iF4g5KJ6Pub4w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/5] mm: limit pagecache folio refcount
Date: Thu, 05 Nov 2026 14:10:09 +0100
Message-Id: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIADKA7GoC/yXMUQqDMBCE4avIPjeQpOqDVylFNJ3UFUlKNmpBv
 HvT9vGDmf8gQWIIddVBCRsLx1BgLhW5aQhPKH4Uk9W2NUY3KsG7uIbcxw3JL3HvJQ/jAtXUFtr
 W5qo9qNxfZcnvX/p2/1vWcYbL3x6d5weSn9hzfAAAAA==
X-Change-ID: 20261105-refcount_overflow_stable-542e024130fe
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=david@kernel.org;
 h=from:subject:message-id; bh=UI8M/ZLKqbJS5E9r1E06UCCyrA6rtpgRnEQYsXCV2PI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeNJhllz4v91n1qrjxV/3edtn8r9+VtnAxXUxNW5M1/
 cSiaSK/OkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiI7FlGhgf3grimRlw4XiR8
 eDOz36xl11/uWWy50rxs7b/UsDbz57cZGd592lpVPGWGJWc1o7uCpGA452cfxlfH932RefyQn0t
 iFQMA
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
some extra reserves (to reover a problematic system). We still leave some
headroom to allow for some slight limit overshooting, to make the
implementation easier.

Then, we also check when splicing pagecache folios to a pipe, and
improve our existing checks in gup. We also have to take care of
mmu_gather, to not hold too many references when zapping (whereby new
page faults could remap pages concurrently).

This is only a temporary solution for upstream+stable, until we have
something better. These fixes will be a bit challenging to backport to
stable, but it will be much easier compared to the RFC series I have here
were we do things properly by (what we discussed a couple of times
earlier):

 - Letting the mapcount of large folios be a long
 - Holding a single refcount if the folio is mapped, across all mappings
 - Reverting the limits introduced in this series

I'll polish that up and send it once we merged something that can be
backported to stable.

Tested on x86-64 by lowering the folio refcount limits such that limits
can easily be exceeded, to then test fault (SIGBUS), fork(), splice and GUp
behavior briefly when we run into refcount limits on a shmem THP.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (5):
      mm: limit pagecache folio refcount when mapping pages
      mm: limit pagecache folio refcount when splicing into pipes
      mm/mmu_gather: flush pending references early before the folio limit
      iommufd: fix cleanup when adding memfd folio pins fails
      mm/gup: limit pagecache folio refcount when grabbing references

 drivers/iommu/iommufd/pages.c | 15 +++++++++++----
 include/linux/mm.h            | 43 ++++++++++++++++++++++++++++++++++++++++---
 mm/filemap.c                  | 10 ++++++++++
 mm/gup.c                      | 12 ++++++++----
 mm/huge_memory.c              | 24 ++++++++++++++++++++++--
 mm/memory.c                   | 27 ++++++++++++++++++++++-----
 mm/migrate.c                  | 11 +++++++++++
 mm/mmu_gather.c               |  5 +++++
 mm/shmem.c                    |  4 ++++
 mm/userfaultfd.c              |  4 ++++
 10 files changed, 137 insertions(+), 18 deletions(-)

---

base-commit: 02f72aa35c5e7dff443c62cd9964686396c8b201

change-id: 20261105-refcount_overflow_stable-542e024130fe

--

Cheers,

David

