Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795351369;
	b=VNuQ1udMnLbCUiXwIjNRq157a8cbKUJGwCx2T3tzpOba+QV/+8A5qwCL4KvyoAcmpGas
	 iq0pGtFV2tNOIW5bd1Vxja7sjl9AbWreC2QgUVhZ6tpYrOGf1Qj1mZUaOT4LJOe/EFKHV
	 DTRpZlrShGotlztoqufHicjpR6je01+gm+svzsG3ndvpUEM8s6bP0xRuKeXkSrd4UML0p
	 mqgzc8ywnxhsgC1xO/jtC2ofcTE1jEQiqfM0IxR0qnLjpHBOPd4n5KEFFv/KpzSKAePsk
	 Z4LFF2w7hMOVBMQITAgLIT8IWOOvPpZfPSwUhyKIJRmz4wCrXCbMh8TtHCbzqbWxCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351369;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ppxr18V13ksnrm9EzUd2RjXo/8ry52+v8MzRoDOJVzs=;
	b=CPfCbZ90N4CsU+Oip/hY5ei4UvVseXygEd9u0wfECUUW22oeldZoH5xrOQ++bN1nkU9q
	 otohkGaK0CXLc20CAAfIodsLCn8yYKxXHEi7gGGWLBf2lwlnHuzRuTqPhx+kINsUHCQqP
	 1c7CMSlQVxjhT6gA2oJYvhnohwoonKLKFTfq2WzbuJnWzLbkUENp0/VMbo5novCXPvyWQ
	 YaqUC36x8iYvR7vYGHGbf1Pti76k3ubUdjps5uH8pNgPmJyotdzbKrmRis8RJwtaDxICS
	 MOBsQH6UHLrWGn5jRNh6tC7oPCxOmWTp6wwE67vXG96Rw5CXrXeSm4OgjxbRsNnIlMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLE2cbyM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C89606A320;
	Sun, 22 Nov 2026 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLE2cbyM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7437C1F000C6;
	Sun, 22 Nov 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795351368;
	bh=Ppxr18V13ksnrm9EzUd2RjXo/8ry52+v8MzRoDOJVzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OLE2cbyMVO4gaFeDzqvX1rjr+CwWSlQzdzRcoUhJ9UbdgSPvZax08+Xvn3jz78zV7
	 R9sOAJqcGH8oycehCMl8I687bz5EppKCoHeKGT1Wblio5u5HW1uBmvYPlMoeZ7sOm9
	 ca0vwXQgPqdPoiTyvxPvQvAiURYhgYROc1SfgjNiacb8s/AGE9yVL+D5OvMdABKyna
	 7ykiswr7+k5AJiwAbIkpbIrA3CssPlAJtGcGaUpGiWQUf9ilvOEX81DwO2TJWjkVTD
	 oxV1cKAdhZWUaVAVv+ivw0bQ/Ff3NX+6gO0zA6OlQ8pKne8l42rk9bR+B03JfIxFhk
	 WaEWXzJpElNmw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 22 Nov 2026 13:42:17 +0100
Subject: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
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
Message-Id: <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
To: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=david@kernel.org;
 h=from:subject:message-id; bh=dIRn4KbtPfU2Ckte5ZbEP8iOqeN2wNX4jIBv2nXxLTI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZHpvOMGjcYrCkWGTW1eSItc4TPISVq6SOPDkr8po59
 cGCn3F9HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEwkvZORoX+BeADTCftzi9me
 luy8rnjkz/3Q+LsVD/0fN3P0ClfFSzL8DzFj4Pp+NrW/9TL39u/KfU+vndFWT+2f5D/j0pQVh1J
 vcgEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Various callers (migration, memory-failure, s390_wiggle_split_folio) split
locked folios without holding a reference on the folio's inode.

Splitting a file folio might allocate memory for the xarray and call
filemap_release_folio(). If either ends up in direct reclaim with
__GFP_FS, reclaim can evict the inode through the dcache shrinker, and
wait in truncate_inode_pages_final() for the folio that we hold locked:

    try_split_folio()
      folio_lock(A)
      split_folio_to_list(A)
        xas_split_alloc()
          try_to_free_pages()
            super_cache_scan()
              prune_dcache_sb()
                iput_final()
                  evict()
                    truncate_inode_pages_final()
                      folio_lock(A)

This requires that nothing else holds a reference on the inode, and can
be triggered most easily with FUSE, which evicts inodes on the last
reference.

Further, xas_split_alloc() charges the XArray nodes to the memcg, and on
cgroup v1, memcg reclaim waits for file folios under writeback if
__GFP_FS is set. That can deadlock if writeback waits for a folio lock
that we hold, for example with ext4.

Let's fix it by splitting folios in a NOFS scope, so callers don't have
to care. A NOFS scope also covers allocations that filesystems make with
their own gfp flags, for example in filemap_release_folio().

On NFS, splitting folios with pending writes or ongoing writes to
fscache might now fail slightly more often, until these writes have
completed. On netfs, only folios that are being written to fscache are
affected. All fairly irrelevant.

This has medium urgency.

Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Fixes: eef88fe45ac9 ("s390/uv: Split large folios in gmap_make_secure()")
Fixes: 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e22daf846dbe3..c4f6c642c2620 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4425,11 +4425,20 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	const bool is_swapcache = folio_test_swapcache(folio);
 	int old_order = folio_order(folio);
 	struct folio *new_folio, *next;
+	unsigned int nofs_flags;
 	int ret;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
 
+	/*
+	 * We might not hold a reference on a locked folio's inode, but we might
+	 * allocate memory under the folio lock. Direct reclaim could try
+	 * evicting the inode, or wait for writeback on cgroup v1, to then
+	 * deadlock on folio locks.
+	 */
+	nofs_flags = memalloc_nofs_save();
+
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
 		ret = -EINVAL;
 		goto out;
@@ -4478,6 +4487,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (is_pmd_order(old_order))
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	count_mthp_stat(old_order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
+	memalloc_nofs_restore(nofs_flags);
 	return ret;
 }
 

-- 
2.56.1

