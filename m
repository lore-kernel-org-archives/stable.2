Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507024;
	b=CEOmb9ptqko0MMDl5sGhahfetgA3ytOaX0WPrbJ8hH4XXAWr4Oo/NkA6iym2VgTrxXkc
	 f262K6umc51ZogkPOpL9KwM1G8Hy1Cg8Gx1SytLRWkO7j6gy0biEPvN4L3fFHPQDtKIMx
	 4FCdgYvSkax3vZ7i5OL33oWoUA5Bf3wDAzXsY3sM0P/5z2S+FpXTvMhbPAR78F43la88H
	 nuOB7GhYs/FeVilHWQcaobxoSlwOybyT7IQF3s0DXVcUpTERgHvzaJGqfUOWpQsEUv6kf
	 rDv/RAzxB6vCFzh4AZ1IMiugy08go5HINvNLRq1u/o+PYS/fHSowgK8+RijxXOvSZag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507024;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sWC/0IiDWu/WZWqTxX3lta5UTbGrGNqTUaVbZk3NCrQ=;
	b=i6jZcZ/Ck6hSGY/e1zA7MOhl9AkO78Jwn3uR44mKcW9uCSzCTIfl7UBxJgxXqa/NkapA
	 1RQflMy+2ggo1jr1VCBcqpOXr57Nj/lZVsUXCytbMJj1Lke/QDN0TiHnjbwe+zYmzvYfb
	 bguJtL/PiM4Vk+AI5iE6avZx7E0k7gbuUSCdIh/wS84i6VW15T5BpxikF3g7zuMTXWfP0
	 UeJ6tIAJqtCrQnCeFU2OVYMMEmuROYXriMqccURrgl8VEQJewW4XhvtoH6lQzS+uBT7Xl
	 7ooaJQlw9EgxsNUSycJoC0ilS80QnSUqzLmoCOo8dH19xAkgQVvuNNUcmX/TlgClYSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCWQ43Vl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF435606A326;
	Tue, 24 Nov 2026 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCWQ43Vl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7350D1F00A3E;
	Tue, 24 Nov 2026 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795507024;
	bh=sWC/0IiDWu/WZWqTxX3lta5UTbGrGNqTUaVbZk3NCrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jCWQ43Vl/X6+1imSMYtmfu4epf84/AtQZBQ6EatnOqP1uWNH9LlQWD/ckRAYttVDt
	 vEGl7Ia+4MQBC+O95ewenwYL7rIH6gTId7V12t2PM9Kj3xu1cj5bRCPeSZhtdSdrTI
	 N3QeKoOzNp2+bWguvzS7GD3MQyVACNSfG9WfwFl9vXCUk+0u2kgEozI73TMQBGUpL2
	 o5M8jAknsqG5lgMwmCmtJIqtlWohLUjKuJ6q0M885aXAvih5QE2Vy6JEbK44zheNDF
	 MVqZFcRVkTNCZT5dqiys16EBCtUzw0W7QcjvXPEtMoA8WrvIMOtwOb7bVn3ZqMN9Ef
	 TudVim5GcFjAw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 24 Nov 2026 08:56:43 +0100
Subject: [PATCH v2 1/2] mm/huge_memory: use NOFS when allocating while
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
Message-Id: <20261124-migrate_reclaim_deadlock-v2-1-03cc147e1e36@kernel.org>
References: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
In-Reply-To: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
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
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3933; i=david@kernel.org;
 h=from:subject:message-id; bh=ANBAHYNyZ+2A0JQUk/v0Mas4rhbNOvSUUQKPMwG3HAw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJZne10tX99m/Qt+m3+VdeW0zx7VrXZTt1ynJcvcyPrz
 Ef6lQYPO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiIkzEjw9Hfs3t+ByypL3N/
 5Hi7vmGVpqfr7u+nZPbWpj4RqTVboMHIMOFKYfTGQA/VFykrWT/ZOnccvHWgN7PEW/IhQ83jqLn
 9vAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Splitting a file folio might allocate memory for the xarray and call
filemap_release_folio(). If either ends up in direct reclaim or
compaction with __GFP_FS, we can deadlock on the folio lock.

For example, when reclaim evicts the inode through the dcache shrinker
it can wait in truncate_inode_pages_final() for the folio that we hold
locked:

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

This example requires that nothing else holds a reference on the inode,
and can be triggered most easily with FUSE, which evicts inodes on the
last reference.

We really must not allocate with __GFP_FS while holding a folio lock. As
Willy explains [1], direct compaction can also trigger deadlocks.

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
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Chris Down <chris@chrisdown.name>
Link: https://lore.kernel.org/r/awSgk1VTUsiVQOAT@casper.infradead.org [1]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e22daf846dbe3..44424af08cdd0 100644
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
+	 * We might allocate memory while holding the folio lock. Direct
+	 * reclaim or compaction could try evicting the inode, isolating and
+	 * locking our folio, or wait for writeback on cgroup v1, to then
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

