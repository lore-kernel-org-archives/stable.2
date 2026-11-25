Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589620;
	b=3X8Z9ArUjDf1sJHlnrPARoCcIKgok7imJRSi27CHmAiI5HOlx7bXkT/kxLJaBx3l+S00
	 x/qRHmc83SufAPHE7torc4dNmR3HoJQPCcoYlPgTREm1ELle8rKrcK21MmEZvtoAMVPrH
	 0+htaMUA1qtfC55kYNRM0gKCEZpiWWIhG1PiTLnC6Ra2wF0ij2LZYP8e2rbP/rJSDEeVw
	 p7qKcvW0uvdCga+YBQ4lI2Zr9V8FDABozUQyShdDt/JzyK1MimxGQWYjWlWZiRPdnUex1
	 daN/nlGzwS9HGXZBdK/Jh7LsqHc5+m1Ll5G2SRJxEh6lr4H9Wx8Ze4D5d18iBTdZxnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589620;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:Subject;
	bh=Dqt6DaQK+/ILwEG6W5V3a06/GqmDZB86Dc26lkXrVJo=;
	b=aP7vlaG/r3uBH1tTgGLuV94QK0l5HoPZW+rOELC6YC3Z91d1m1onmLQPMTQeTGZug0rd
	 KoNFY1GyX84SgTXbLuY4qzvVucdH4+/dOO0bWwgTOKYxr7IrDnQbeLits5ckfpt2GGGMU
	 LTCe5KNW8Y/uZXtO+k7+zDQMZ+8Mbmy87dxAFPIPY6jwMu6yRi6dtaGQdKJYyhJQqZnRI
	 wW2rMm7PnBP6hkKZ0WaEB1dNhAd+wYrCpMOJywa7QQ+riJIsdEbkJ0vTUwmcugWTBu+Xz
	 3zslNcI1wbOxi0XtLXhUDgcZWxbMTMWGhnvw7YtC4Ys5zooR6VMopFZVkpP/0VJOd4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=IAPMaKU5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10841606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=IAPMaKU5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669921F000D4;
	Wed, 25 Nov 2026 06:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795589619;
	bh=Dqt6DaQK+/ILwEG6W5V3a06/GqmDZB86Dc26lkXrVJo=;
	h=Date:To:Cc:From:Subject;
	b=IAPMaKU5nts/5uCKxYRGxGmJjtOjnrm5rs39P+06ZUpsMkhTRKAFMJwybOGY4uXoY
	 bKsfQWs5VyzLZmdS2o43R+tS39X8rXRyhYqlpVGqGUAy+HRmMQ02mKW9yWtWZlfysp
	 X7C/4PC2fuWIVY3lNaJkZIbTDCkvju5c1fTeUoxU=
Date: Tue, 24 Nov 2026 22:53:38 -0800
To: Mika =?utf-8?q?Penttil=C3=A4?= <mpenttil@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Aveline Noir <jm5905938@gmail.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 stable@vger.kernel.org
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
Subject: [PATCH] lib/test_hmm: invalidate all mirrors on device-private migration
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Andrew Morton <akpm@linux-foundation.org>
Subject: lib/test_hmm: invalidate all mirrors on device-private migration
Date: Sun, 22 Nov 2026 08:53:12 -0800

When one open of the fake HMM device migrates a folio to device-private
memory, a second open can fault the same address into its mirror page
table. The second mirror then stores the inaccessible device page, which
can oops the kernel when dmirror_do_read() copies from it. Store the
corresponding RAM backing subpage instead.

That conversion also makes the backing page's lifetime significant to
the second mirror. migrate_vma_setup() notifies all mirrors before CPU
faultback, but dmirror_interval_invalidate() skips the notification for
every open on the same device. The faulting open clears only its own
XArray entry. The other open can read or write the backing page after
migrate_vma_finalize() frees it. Aveline reported a KASAN use-after-free
and stale data through the second open.

Handle migration invalidation for every mirror under its mutex. This
clears pointers before faultback can free the backing pages and waits
for an active mirror read or write. During system-to-device migration,
the migrating open installs new entries after migration; other opens
refault on their next access. Remove the now redundant XArray erase
from the faultback copy loop.

Extend the PMD migration selftest to read its last device-private
subpage through a second open, then fault it back to RAM, change it,
and read the new value through that open. The trigger is available to
a process permitted to open /dev/hmm_dmirror* when CONFIG_TEST_HMM is
enabled; it does not depend on physical GPU hardware.

[akpm@linux-foundation.org: fix device-private backing subpage selection]
Link: https://lore.kernel.org/r/20261122015246.d8b6b98ff5a8157168156339@linux-foundation.org
Link: https://lore.kernel.org/r/179535872126.34.4789080961796247940.b4-reply@b4
Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Aveline Noir <jm5905938@gmail.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>

 lib/test_hmm.c                         |   20 +++++++-----------
 tools/testing/selftests/mm/hmm-tests.c |   25 +++++++++++++++++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

--- a/lib/test_hmm.c~lib-test_hmm-invalidate-all-mirrors-on-device-private-migration
+++ a/lib/test_hmm.c
@@ -292,6 +292,12 @@ static int dmirror_do_fault(struct dmirr
 		page = hmm_pfn_to_page(*pfns);
 		WARN_ON(!page);
 
+		if (is_device_private_page(page)) {
+			struct folio *folio = page_folio(page);
+			struct page *backing = BACKING_PAGE(&folio->page);
+
+			page = backing + folio_page_idx(folio, page);
+		}
 		entry = page;
 		if (*pfns & HMM_PFN_WRITE)
 			entry = xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
@@ -327,14 +333,6 @@ static bool dmirror_interval_invalidate(
 {
 	struct dmirror *dmirror = container_of(mni, struct dmirror, notifier);
 
-	/*
-	 * Ignore invalidation callbacks for device private pages since
-	 * the invalidation is handled as part of the migration process.
-	 */
-	if (range->event == MMU_NOTIFY_MIGRATE &&
-	    range->owner == dmirror->mdevice)
-		return true;
-
 	if (mmu_notifier_range_blockable(range))
 		mutex_lock(&dmirror->mutex);
 	else if (!mutex_trylock(&dmirror->mutex))
@@ -1198,7 +1196,6 @@ static vm_fault_t dmirror_devmem_fault_a
 
 			src_page = pfn_to_page(page_to_pfn(spage) + i);
 
-			xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
 			addr += PAGE_SIZE;
 			copy_highpage(dst_page, src_page);
 		}
@@ -1822,9 +1819,8 @@ static vm_fault_t dmirror_devmem_fault(s
 	}
 	migrate_vma_pages(&args);
 	/*
-	 * No device finalize step is needed since
-	 * dmirror_devmem_fault_alloc_and_copy() will have already
-	 * invalidated the device page table.
+	 * The migration notifier has invalidated all mirror page tables
+	 * before the backing pages can be freed.
 	 */
 	migrate_vma_finalize(&args);
 err:
--- a/tools/testing/selftests/mm/hmm-tests.c~lib-test_hmm-invalidate-all-mirrors-on-device-private-migration
+++ a/tools/testing/selftests/mm/hmm-tests.c
@@ -2087,6 +2087,7 @@ TEST_F(hmm, migrate_anon_huge_fault)
 	void *old_ptr;
 	void *map;
 	int pagemap_fd;
+	int fd2 = -1;
 	int *ptr;
 	int ret;
 
@@ -2143,12 +2144,36 @@ TEST_F(hmm, migrate_anon_huge_fault)
 		}
 
 		close(pagemap_fd);
+
+		/* Read a device-private subpage through another open. */
+		fd2 = hmm_open(variant->device_number);
+		ASSERT_GE(fd2, 0);
+		buffer->ptr = (char *)map + (npages - 1) * self->page_size;
+		ret = hmm_dmirror_cmd(fd2, HMM_DMIRROR_READ, buffer, 1);
+		buffer->ptr = map;
+		ASSERT_EQ(ret, 0);
+		ASSERT_EQ(buffer->cpages, 1);
+		ASSERT_EQ(*(int *)buffer->mirror,
+			  (npages - 1) * self->page_size / sizeof(int));
 	}
 
 	/* Fault pages back to system memory and check them. */
 	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
 		ASSERT_EQ(ptr[i], i);
 
+	if (fd2 >= 0) {
+		/* This open must not retain the freed device backing page. */
+		ptr[(npages - 1) * self->page_size / sizeof(*ptr)] = -1;
+		buffer->ptr = (char *)map + (npages - 1) * self->page_size;
+		ret = hmm_dmirror_cmd(fd2, HMM_DMIRROR_READ, buffer, 1);
+		buffer->ptr = map;
+		ASSERT_EQ(ret, 0);
+		ASSERT_EQ(buffer->cpages, 1);
+		ASSERT_EQ(buffer->faults, 1);
+		ASSERT_EQ(*(int *)buffer->mirror, -1);
+		ASSERT_EQ(close(fd2), 0);
+	}
+
 	buffer->ptr = old_ptr;
 	hmm_buffer_free(buffer);
 }
_
