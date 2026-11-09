Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220494;
	b=t/rxyCnKKSys2Kvs+iwtHXCYZ3yN5Y1Nd2W7DuwrKd09gIBugHLh9t/yMGOdSKySS6cK
	 ZYrghN8TQIjzmRTSVjOJCqyknkBClZ7D0sqfAcJ5DXI9nW+S/bjdZwXtVQYBZ8FRoMWx2
	 Gf7SfWgZ3bN5sYzPq5LfYvS4t0YmXjZyyvqcn6sIJsS32pwWSelR0GX+U9FCmXEY58x01
	 uAhhTLI2lPqQHw/OVwjAJWw57ZIlYQIoUHGN7go0LLg1pNjwGiOwyQzSvnRuyzKLXOMsB
	 qVnPZASytle6qaOBZfUrfCe+fNDpnRiMAM+PyIAJQrsrnzNpqfINoqLOfTcoxZ0m4Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220494;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=r7zFSuRHxbLKvLhaBXFfwZSQS8Ww63rMzgnhGg9p6Q8=;
	b=Ls4a/VIzFLfVlSsS3tHV3pFdRzCeO8IO/AsubhNddAXef5TOWd/bvW7HHGhRDNxAOA0W
	 C5LhuQVt4KqdcRZNsAM+6hF9Ox+nlquFe3oFnNptfGyoXyelFRGZla/F2dC550AdjCRue
	 xC6EH+ue1MeI8yqqrKvuEaumyxheyPcnFkjmBaCod366J7YYQ9yu5LthdFLQ0eluPRlvR
	 OwoHc+5XUhpkkyn8kIgfxlhxUuFiOmKzMNUySXkRfP7SAuZbQSvE0S67cZZthL8npJyKt
	 D3EI14QHsv4ErCWsBBJiNlqHyzlsRqq7d5Sl5zrHorTBn+L82JDogOk4iX79L3y3U1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rHEGSCfy;
	arc=none smtp.remote-ip=91.218.175.78
Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB0606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADB0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rHEGSCfy
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZowXYPpehaGrr4w7J2ZcT85zAd1vaHLiUEOsJbbNAQU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794220490; v=1; x=1794825290;
 b=rHEGSCfywrL7dGE5Au+uLy5I7FAEkuO+lt7l/b6GHu7OIP0LAtf9nnaoxBMhQvoBQRQFiRW9
 8W5rr4/d+JxYqC3r3ZweVR9i4iGDH1L8dXAq3K+Wjuxp5EtPTHFlazYcMdsGnCbTYXbHTmnpxk/
 KMaAADfF5n+MNPMhRoTq4JGI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a2580fc19b1d598;
	Mon, 09 Nov 2026 10:34:50 +0000
X-Mizu-Trace-ID: 4a2580fc19b1d598
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 09 Nov 2026 05:34:12 -0500
Subject: [PATCH v2 2/3] mm/filemap: read ahead downwards on descending
 VM_HUGEPAGE faults
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
Message-Id: <20261109-bug-mm-mmap-readahead-descending-v2-2-abac52890a9c@linux.dev>
References: <20261109-bug-mm-mmap-readahead-descending-v2-0-abac52890a9c@linux.dev>
In-Reply-To: <20261109-bug-mm-mmap-readahead-descending-v2-0-abac52890a9c@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 Vishal Moola <vishal.moola@gmail.com>, fujunjie <fujunjie1@qq.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

On a VM_HUGEPAGE file mapping, a synchronous fault reads the PMD-sized
folio that holds the faulting address and the one above it, and maps
the faulting folio with a PMD. do_sync_mmap_readahead() counts each such
fault in mmap_miss and stops reading ahead once it passes
MMAP_LOTSAMISS, while filemap_map_pages() lowers the count for faults
served from the page cache, but only when it maps them with PTEs.

A reader that moves towards lower offsets, such as memmove() copying
backwards out of a mapping, never finds its next folio cached: the
folio above is the one it just read. Every folio is a miss and none is a
hit, so after about a hundred folios mmap_miss passes the limit and
every page after that is read on its own. Since the PTEs mapped around
a fault no longer count as hits, nothing lowers the count for it.

When the folio above the faulting one is cached and the one below is
not, read the folio below instead, without a readahead mark, and count a
PMD mapping of the faulting address as a hit the way a PTE mapping is.
Such a reader then misses on every other folio and hits on the rest.
Reading one byte from each page of a 2 GiB file, last page first, in a
MADV_HUGEPAGE mapping with a cold page cache, read_ahead_kb 8192:

                   before       after
  time            42.83 s      0.57 s
  major faults     473189         514

Fixes: 0b9c0aeba938 ("mm/filemap: count only the faulting address as a mmap hit")
Cc: stable@vger.kernel.org # 7.2.x: needs the previous patch
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 mm/filemap.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c38f0e4cf6123..e445279cc561f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3336,6 +3336,27 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 	return 1;
 }
 
+/*
+ * Whether a miss at @index, right below @nr cached pages and right above
+ * @nr uncached ones, comes from a stream that runs towards lower offsets.
+ */
+static bool filemap_descending(struct address_space *mapping, pgoff_t index,
+			       unsigned long nr)
+{
+	void *entry;
+
+	if (index < nr)
+		return false;
+	rcu_read_lock();
+	entry = xa_load(&mapping->i_pages, index + nr);
+	rcu_read_unlock();
+	if (!entry || xa_is_value(entry))
+		return false;
+	return !filemap_range_has_page(mapping,
+				       (loff_t)(index - nr) << PAGE_SHIFT,
+				       ((loff_t)index << PAGE_SHIFT) - 1);
+}
+
 /*
  * Synchronous readahead happens when we don't even find a page in the page
  * cache at all.  We don't want to perform IO under the mmap sem, so if we have
@@ -3409,13 +3430,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		ractl._index &= ~(folio_nr_pages - 1);
 		ra->size = folio_nr_pages;
+		ra->async_size = folio_nr_pages;
 		/*
 		 * Fetch two folios so we get the chance to actually
-		 * readahead, unless we've been told not to.
+		 * readahead, unless we've been told not to. A stream that
+		 * runs towards lower offsets gets the folio below.
 		 */
-		if (!(vm_flags & VM_RAND_READ))
+		if (!(vm_flags & VM_RAND_READ)) {
 			ra->size *= 2;
-		ra->async_size = folio_nr_pages;
+			if (filemap_descending(mapping, ractl._index,
+					       folio_nr_pages)) {
+				ractl._index -= folio_nr_pages;
+				ra->async_size = 0;
+			}
+		}
 		ra->order = thp_order;
 		page_cache_ra_order(&ractl, ra);
 		return fpin;
@@ -3981,10 +4009,16 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	 * Make an exception for shmem/tmpfs that for long time
 	 * intentionally mapped with PMDs across i_size.
 	 */
-	if ((file_end >= folio_next_index(folio) || shmem_mapping(mapping)) &&
-	    filemap_map_pmd(vmf, folio, start_pgoff)) {
-		ret = VM_FAULT_NOPAGE;
-		goto out;
+	if (file_end >= folio_next_index(folio) || shmem_mapping(mapping)) {
+		/* Check before filemap_map_pmd(), which may drop the last ref */
+		bool hit = filemap_mmap_hit(vmf, folio);
+
+		if (filemap_map_pmd(vmf, folio, start_pgoff)) {
+			if (hit)
+				filemap_count_mmap_hit(file);
+			ret = VM_FAULT_NOPAGE;
+			goto out;
+		}
 	}
 
 	addr = vma->vm_start +

-- 
2.43.0

