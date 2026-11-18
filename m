Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795039165;
	b=5F2VEotpfOVeItYkDfM+7b96UZ3UdHUqx2D2rZX0XJdn4/wj8nXizKtcKkKECc2OxHt0
	 oDinKoK3EKqf/SfgReqNs2Cx2zGLJIpBmxIh9sqr6UYnjXL1Q1fQGz6ml2gae8MOUMqUa
	 mBOSeGuvk1l95ujJ8sOVn52iuJNaoqqHqLGS4KtT/MpHi0nq4ppUasbF8ljsog2CUIUQj
	 LB6HPZu5PfCu4Hy1zEkY7aUgNMRsS5Sj5SaGMVDdg/Yrzj/fv3+3B/9uq0iiOGRoVsPyJ
	 bZLwDbgDjNl21dO94plSI+wflE5RxFyuJeV6FGZgeci2clQ94NT3Sna3FvbA3Vue2dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039165;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4ZCDMReGT8kdAAJEPyl/oDR55ZrAEtce0UDwaaBcFh8=;
	b=dZn65nqWYjR730KgaBXa7IrvHHaPFNSp1f37d70ZCZsP0KG2qHfJzGKsaPIns7MS+un0
	 Eg+fBv3MurtmVhL9MZTwfZZIJRaKQPCg8HCwYFf5QZEPn5f2ttV31zbkNRR/vmVjRysd7
	 /6s9m6o0vBit/O9+w7ZpPqmpjamyk7RkDjQGqIvpjHg00izPv1lPVsYHFZfTkyowXjOfT
	 gLMqHB9Daf/QRE/pYexNiklfKMr3JaEpGJxrBwYVUPy4FQK5C5RZaPUTE1JYT5khcE/79
	 szAmVlTUhLHRNaSQQTWbmPwI5wdmdgeJgFXqTba50ZEdMyBCtPYy16MiVh8qe78+I9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ca9PoyOl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CE606A332;
	Wed, 18 Nov 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ca9PoyOl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795039165;
	b=V5d6uCeHfdiWupTIaMf6q66dnrV7+CaXOqDPI050gifPWcRIr2K7CNSoERy38usPPWsh
	 bTvjXjAf6Nv55pfvfabJFuBIFQCVZkFEIgku8u3K05tnxoleVsBvaP9UwIUi3X4c7Gh3Q
	 0ajtVN9T2DL0nOuSZzTUZbLv2Eaz1gpcYvhHoLCCF60U8JMX9+MSO6gm31EjhddwNJFdq
	 SqaHBFjlcqBTnJLG0TSxIUGbJhAtlwAHyoiBhec9KwpslHojEUVtJtzWK2dJOxOg72iqi
	 /2Tfz5+B4mw9sizo1o7G4BUS5nD428TWWeHLt1ubUgEv8NbQuHwGCCw4C1KBNvA5lag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795039165;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4ZCDMReGT8kdAAJEPyl/oDR55ZrAEtce0UDwaaBcFh8=;
	b=oxJznGWNLrywchLNefANwzdshLjbXpnb0prbuXOUJssNhaq40dIa7cleCH9+YOwHy5Rf
	 rq7o81h50bMwHazHdo1fx8VdXEW+N+OVE2t86BrJ3/t2YQe1oG0jZ6dxguwStHYcoM0Du
	 p+KZdV5keBpxhdNFXEzXkPU8+UNZP7tw8W0LToR5E8Qz1XTE0e4bRWHu1r6UWGzfGRPBJ
	 7cVM25si+Y3R1YUibsEUEVJmHEOXsMxGJFLhfvbWv6GKIE8vv57mBmazkUwekJCOiWtih
	 noSHNRx1v69Gq5Qkjo3OV4M5HZCEHIABwsKaMtCmCzalIYML5be9xXj/IjTs4MdHHZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A6FAF1F000C6;
	Wed, 18 Nov 2026 21:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039165;
	bh=4ZCDMReGT8kdAAJEPyl/oDR55ZrAEtce0UDwaaBcFh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ca9PoyOld873CKmQmRDFGXbPargZGbRMwzpmxt3azOypNQ7n3ayvaOKdTVwAay+KH
	 dsgJoa6h68gsexv7gB4Un3olyuaVG+hS78CFvbKjVSSCh6ROZ5s8JX+dFmbwU7j32C
	 +2DuFNX25O2ZJvTogzIOjkujL6fcAAOFwjbneHmFUHIV4lt+iH2gIJIj7MBf6VB32g
	 aRIbylHfbOdrKtMVhplvDqJfb3FrGolxQA23I2/mXq/9Xa1U4K7F/fJNMU8Ltyjae/
	 NkdAZVGHTOPCUgiMZGdrhPCXbnfDcGcPa62vaSxmXSObPlLwlKYv3SGoTFEhMiOQ42
	 WOuZgarvqhs3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2488A4AFE1;
	Wed, 18 Nov 2026 21:59:24 +0000 (UTC)
From: Harrison Crosse via B4 Relay <devnull+harrison.crosse.dev@kernel.org>
Date: Wed, 18 Nov 2026 16:56:41 -0500
Subject: [PATCH 1/2] mm/gup: make mlock() and MAP_POPULATE handle
 VM_FAULT_RETRY properly
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
Message-Id: <20261118-mmpop-populate-v1-1-9c561d178d11@crosse.dev>
References: <20261118-mmpop-populate-v1-0-9c561d178d11@crosse.dev>
In-Reply-To: <20261118-mmpop-populate-v1-0-9c561d178d11@crosse.dev>
To: David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>, 
 Harrison Crosse <harrison@crosse.dev>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795039163; l=8262;
 i=harrison@crosse.dev; s=20261117; h=from:subject:message-id;
 bh=o68P5YM1Dim45OasWUC3bF7sN6yAaM3DW9PetPgRC/s=;
 b=wMywT4ZYui4m+Gr0BQNzKVCKGUsOs8ElQLremHykfZO3gQlEasMlfWRhgJxvo670cC69t7XUb
 CtHOhvEHU2AAP+NoMgKynw/kYmxTgANI2mN8jBocLFjhxSZWR9nw9gp
X-Developer-Key: i=harrison@crosse.dev; a=ed25519;
 pk=fwi/XME2YaW/BDBQ76FmKgF9xHZwRb+dxlVCbxuyojo=
X-Endpoint-Received: by B4 Relay for harrison@crosse.dev/20261117 with
 auth_id=1552
X-Original-From: Harrison Crosse <harrison@crosse.dev>
Reply-To: harrison@crosse.dev
Content-Transfer-Encoding: 7bit

From: Harrison Crosse <harrison@crosse.dev>

If every read of a page of a file mapping fails, mmap(MAP_POPULATE)
and mlock() of that mapping do not return: the task spins in
__mm_populate(), submitting a new read of the page on each iteration,
until it gets a fatal signal. Touching the same page gets SIGBUS, and
madvise(MADV_POPULATE_READ) fails with -EFAULT.

The first fault on the page reaches filemap_fault() with
FAULT_FLAG_ALLOW_RETRY and without FAULT_FLAG_TRIED. filemap_fault()
releases the mmap_lock to read the page and, because it released the
lock, returns VM_FAULT_RETRY before it looks at the result of the read.
It cannot report the error then: a fault that has released the lock
returns VM_FAULT_RETRY or VM_FAULT_COMPLETED, and neither carries an
error. faultin_page() turns VM_FAULT_RETRY into -EBUSY, so
__get_user_pages() stops at that page without an error, and
__mm_populate() calls populate_vma_page_range() again at that address,
again without FOLL_TRIED. The page fault handlers and
__get_user_pages_locked() retry with FAULT_FLAG_TRIED instead, and on
that attempt filemap_fault() reads the page with the lock held and
returns VM_FAULT_SIGBUS if the read fails.

Commit 631426ba1d45 ("mm/madvise: make MADV_POPULATE_(READ|WRITE) handle
VM_FAULT_RETRY properly") fixed the same loop for MADV_POPULATE_* by
calling __get_user_pages_locked(). That does not fit here:
__get_user_pages_locked() retakes the mmap_lock itself and carries on
with the GUP flags it was given, while populate_vma_page_range()
derives those flags from the VMA that __mm_populate() looks up again,
and may skip, after each unlock. Retrying with a NULL locked instead
would drop FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_KILLABLE, so a
userfaultfd range would fail rather than wait, and folio lock waits
would not be killable.

Instead, have __mm_populate() remember the address of the page whose
fault released the mmap_lock. When the next iteration starts at that
address, fault in that page alone with FOLL_TRIED, as
__get_user_pages_locked() does, then continue with the rest of the
range as before. The retry reads the page with the mmap_lock held, as
filemap_fault() did for a page that was not uptodate before v5.1, and
as the other GUP retries do. With a persistent read error the retry
fails with -EFAULT: mlock() returns -ENOMEM
(__mlock_posix_error_return() maps -EFAULT to it), and MAP_POPULATE,
which ignores populate errors, returns the mapping. A fatal signal
still ends the loop, with -EINTR from __get_user_pages() or, if it
interrupts the FOLL_TRIED read, with -EFAULT. The other callers of
populate_vma_page_range() pass a NULL locked, so they cannot get
VM_FAULT_RETRY and are unchanged.

Reproduced with ext4 on dm-linear over a loop device, with the eight
sectors of one page of a file mapped to the dm "error" target, on arm64
(Debian's 6.12.116 and v7.4-rc3) and x86_64 (v7.4-rc3): mmap(MAP_POPULATE)
and mlock() of the file were still running in the kernel after 5 seconds
and ended when sent SIGKILL. On 6.12.116, the block layer tracepoints
showed about 280,000 bios a second being submitted and failed.

The analysis, the patch and this changelog were prepared with the help
of an AI coding assistant (Claude).

Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
Link: https://lore.kernel.org/all/20191105182211.GA33242@cmpxchg.org/
Link: https://lore.kernel.org/all/20240314161300.382526-1-david@redhat.com/
Cc: stable@vger.kernel.org
Signed-off-by: Harrison Crosse <harrison@crosse.dev>
---
Tested on x86_64 v7.4-rc3 under QEMU (TCG): with the error page,
mmap(MAP_POPULATE) returns the mapping and mlock() fails with ENOMEM,
MADV_POPULATE_READ still fails with EFAULT and touching the page still
gets SIGBUS. With reads of that page delayed by 1 s with dm-delay,
SIGKILL during the read ends the task within 2 ms. Without a read
error, MAP_POPULATE, MAP_LOCKED, mlock() and mlockall() map every page,
and the map_populate, mlock2-tests, mlock-random-test, madv_populate,
mremap_dontunmap, on-fault-limit and guard-regions selftests have no
failures, nor does populate_eio from the next patch. On arm64 v7.4-rc3
under QEMU (TCG), populate_eio fails its mmap(MAP_POPULATE) and mlock()
checks without this patch and passes all three with it.

Not tested: the other checks above on arm64, page sizes other than 4K,
transient read errors, userfaultfd ranges, file systems other than ext4
and FUSE, real disks, non-fatal signals, and the rest of the mm
selftests.
---
 mm/gup.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2b405cce2..e666761ed 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1795,11 +1795,12 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 }
 
 /**
- * populate_vma_page_range() -  populate a range of pages in the vma.
+ * __populate_vma_page_range() -  populate a range of pages in the vma.
  * @vma:   target vma
  * @start: start address
  * @end:   end address
  * @locked: whether the mmap_lock is still held
+ * @tried: whether this retries a fault that released the mmap_lock
  *
  * This takes care of mlocking the pages too if VM_LOCKED is set.
  *
@@ -1814,8 +1815,9 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
  * If @locked is non-NULL, it must held for read only and may be
  * released.  If it's released, *@locked will be set to 0.
  */
-long populate_vma_page_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, int *locked)
+static long __populate_vma_page_range(struct vm_area_struct *vma,
+				      unsigned long start, unsigned long end,
+				      int *locked, bool tried)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long nr_pages = (end - start) / PAGE_SIZE;
@@ -1860,6 +1862,8 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 
 	if (locked)
 		gup_flags |= FOLL_UNLOCKABLE;
+	if (tried)
+		gup_flags |= FOLL_TRIED;
 
 	/*
 	 * We made sure addr is within a VMA, so the following will
@@ -1871,6 +1875,13 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	return ret;
 }
 
+long populate_vma_page_range(struct vm_area_struct *vma,
+			     unsigned long start, unsigned long end,
+			     int *locked)
+{
+	return __populate_vma_page_range(vma, start, end, locked, false);
+}
+
 /*
  * faultin_page_range() - populate (prefault) page tables inside the
  *			  given range readable/writable
@@ -1934,7 +1945,9 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long end, nstart, nend;
+	unsigned long retry_addr = 0;
 	struct vm_area_struct *vma = NULL;
+	bool retry = false, tried;
 	int locked = 0;
 	long ret = 0;
 
@@ -1967,8 +1980,21 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * Now fault in a range of pages. populate_vma_page_range()
 		 * double checks the vma flags, so that it won't mlock pages
 		 * if the vma was already munlocked.
+		 *
+		 * filemap_fault() reports a read error only when
+		 * FAULT_FLAG_TRIED is set: on a first attempt it releases the
+		 * mmap_lock for the read and returns VM_FAULT_RETRY whatever
+		 * the result. So when the last call released the lock at
+		 * nstart, retry that page with FOLL_TRIED, and only that page,
+		 * so that later pages still get a first attempt that releases
+		 * the lock for the read. Compare the address because nstart
+		 * moves past that page if it is no longer mapped, or its VMA
+		 * is skipped, when the lock is retaken.
 		 */
-		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		tried = retry && nstart == retry_addr;
+		ret = __populate_vma_page_range(vma, nstart,
+						tried ? nstart + PAGE_SIZE : nend,
+						&locked, tried);
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;
@@ -1977,6 +2003,8 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 			break;
 		}
 		nend = nstart + ret * PAGE_SIZE;
+		retry = !locked;
+		retry_addr = nend;
 		ret = 0;
 	}
 	if (locked)

-- 
2.56.1


