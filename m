Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056770;
	b=AgAiUHUtqodXUif8uO/e8ssMwzh4tpGvYL6nA1ploZLqn2Q5bOP+MJykRb4/K3gNm2H4
	 fdQy5xclNlGStmOc2yovOzMTpIfBmdR3UhBAqCs6efG4za5FuDgqxlPkI4t+GuXCK1AAj
	 dFEmnM6ugNRhJTiw1zMQBax+zAXDJqREOE60PHi/WGyPDfcqOn3aLAY53cjKVHsyEhSMq
	 cq6Nf4SpbzsITGvwcVhZiq0CrmuqUYtZ521Q2ukVg9/ImgjA9nuZy+YlphR52gCkT/JHs
	 Ozi2y9GzTqGor3DpmTH/Z7W54s/+3OTFDWq9yW+LNdTgGFeE2SjM5JbYYE9jPrR+Ncg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056770;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=H94VuGtG6BpRFhvFPWMMDLKdr76dloMuoWr2DscOb8Y=;
	b=gx7CBKegWBVhmIEJZ4BrdAYFFp90VJqdp4QbuycVEx9tjMzyf/UJWYRT5l4qJD6L9Ffp
	 gT3riPjTgvWcQPiVa0HOmLJxcGLS1HKa84E+WUibKeHA3HBfZhQo402FCoWAy35PO1tt7
	 7GWNKPaIJxQUp2t7l8YE4ckCKoRj4EiF+LFw7h4lx0Eri2hwV54Z/2g3L9YnWY5u85H8u
	 w3PWwR0XUI6NU02Tj68ZQjDZRG4Y6SvOGLh0W1XgN1oVNyFQDhC7HE4Ol3TIsSCMRNBiW
	 4xJ7hJSPL52abZfumeXzIVVyP5wOcWJMzTm6iCxap8xYN0nSFMFEc6w2HCBtR3TU1yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8iKZ2Bw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6436606A31D;
	Mon, 26 Oct 2026 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8iKZ2Bw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213BB1F01828;
	Mon, 26 Oct 2026 23:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056769;
	bh=H94VuGtG6BpRFhvFPWMMDLKdr76dloMuoWr2DscOb8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I8iKZ2BwWhRlGZKB5MDnIdv4P3Hsc5OC2Y8e+6o+Rsh4VMxS9ryGLhNAlqek22Dzv
	 aOPMjgNb3WIn+nbeA4Bl2OmEam6tNWnp7KP4P7Sq1Otq6EAEt/O6Cj5WgRFOq/NfHL
	 yBlHn5kU3RWZscpHxcqsXYx72K358Q3ElDuWj6xww/Ko7kKUPtLC86boj4WebUtPkx
	 xUkJamkiias1T6VaQVSwXWqfCm0Hp/O1QtXuUJ8+Z9MZCKAh2yqRJSLB67hCMzLNcP
	 SK31F0/mluevSG3880IFFKBePRADDkMxPRbxbohBQaya9pGvGPIvqBFBnXxalxeImC
	 /O0s/E/Fmnv9A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:25 +0100
Subject: [PATCH 05/46] mm/truncate: look again if a folio left the mapping
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
Message-Id: <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123; i=david@kernel.org;
 h=from:subject:message-id; bh=LCXJvaCAxM8DYeEIbqCybn9PrvO5kcWMg/840Mus1kc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/c8ljL9OqVuwY9+3suFMYJTzv25M8VW/u/KRKH4
 g0d8qyqOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjInEBGhr25c3sdnCbE9kXY
 7Lby7DvHeGTLeZsbTo/qpQ5tmW5moM7wV4x73/kDyy57H/0wL6f0q3Nz/cVdR5zMGn/pftq/I7l
 0AwMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

invalidate_inode_pages2_range() skips a folio which no longer belongs to
the mapping by the time it has got the folio lock, on the assumption
that somebody else has removed it from the page cache. But the folio may
have been replaced, and then there is a new folio with the same data at
that index.

For most cases, like folio migration, that is impossible. However,
collapse_file() only checks the refcount of the old folios, under the
i_pages lock, and relies on their folio locks from there on. That works for
users which repeat the lookup when they find folio->mapping changed.
The following scenario is, however, possible:

  CPU0 pwrite(O_DIRECT)               CPU1 collapse_file()
  kiocb_invalidate_pages()
                                      read the folio (old data), lock it
                                      refcount check
  the write completes                 copy to new_folio
  kiocb_invalidate_post_direct_write()
    find_get_entries() -> old folio
    folio_lock() ...                  xas_store(new_folio)
                                      folio->mapping = NULL
                                      folio_unlock(folio)
    folio->mapping != mapping
      -> continue

In that scenario, the collapsed folio with the data from before the write
stays in the page cache after the write has returned.

This used to be impossible, as khugepaged only collapsed files that nobody
had open for writing.

Restart the lookup at that index, like shmem_undo_range() does. The same
problem seems to exist in truncate_inode_pages_range() as well when
truncate_inode_folio() fails, so handle it there as well.

Fixes: 1b6444331beb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/truncate.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 733d2713a875a..6d8c0ec4623fe 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -499,7 +499,15 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			folio_lock(folio);
 			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
-			truncate_inode_folio(mapping, folio);
+			if (truncate_inode_folio(mapping, folio)) {
+				folio_unlock(folio);
+				/*
+				 * Folio might have been replaced: look it up
+				 * again.
+				 */
+				index = indices[i];
+				break;
+			}
 			folio_unlock(folio);
 		}
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
@@ -760,7 +768,12 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 			folio_lock(folio);
 			if (unlikely(folio->mapping != mapping)) {
 				folio_unlock(folio);
-				continue;
+				/*
+				 * Folio might have been replaced: look up
+				 * again.
+				 */
+				index = indices[i];
+				break;
 			}
 			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);

-- 
2.43.0

