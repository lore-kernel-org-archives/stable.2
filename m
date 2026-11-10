Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272678;
	b=TKmz4N8fcZvuNgdq9MiCoqXYgTfxneEe3xzZrIpdMWn5GpXbRfLr2wSxLo1yWGppVvmX
	 Xz23IO8bfDAl6/Eo279na+JVTYM3IWVyOYdTzMtBW1nXYS+0DTlK8I2ywWKWmNfKjFK4D
	 xk293G0IsxQLIFPzXLKc0QUXj+pct0XXL+rz+7z5Ql8hSiqhCIadGuJRJmzWjsiMPK4aG
	 GT7c1+s/NaeOLxcrSUWB53fXUa0dmEEaayy49vftxcbpxE53lnfyUQTC4/0NjQs8P8qxs
	 OJgI7xtLb4LYjGGhvepqjj3hElD5yqxjZSj0nueac/N8CRu3SDkFRQDwm7iVbhqinYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272678;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=E9GfAIkBIMSt7qWbMvy5HKatGrNyxnC/RXI2tupDNJQ=;
	b=0vxCa2Du59tVv4GXk3+KaqhFXpWvguvbQQOZM3YS8ZoX4Z0JPT/tElS6isnp/7G5dFU8
	 fC1q6BvvN1q4OhnHrQ/DzjJWgbnh17egzXD1FB2BVnjV0QMic432VtFGp6v5kA1pnlKIi
	 IFGuacx7XrYkiiMQrc81vRvIyXOE6CF2qUX4W9QblXwjAFYd7196tNt4ZjsMtT53D17h/
	 jIIrjLAJLWovudNHqqhFVsJLyE8UIr/4dymWCDIcLym1XCFiBQKOHWIPLzFHuTFMoQ97j
	 KyXVm51RKvFOpTsP0N0qjfaROMkPnYICjgfFcPpsiiZGfNODiMCGQt/383w0D3r6fuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C+uS5/N4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68B606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+uS5/N4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7211E1F0089F;
	Tue, 10 Nov 2026 01:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272677;
	bh=E9GfAIkBIMSt7qWbMvy5HKatGrNyxnC/RXI2tupDNJQ=;
	h=From:To:Cc:Subject:Date;
	b=C+uS5/N4Ej1MwvoisXZs6dTbcnH8ZzIqss53GdqYFQTHXNmZUsOgDcsSqYpl6gpZ6
	 nKTXdEvAizAGQ/V/MzPe3qyIxBdR2UmeiPJ5qN71vHa7/tANiD7YAX9mvtTcETaQ0T
	 uXr0UtXEvDVafwp8tlhr2of7yWewFKve/BOSVTwWBx5VaLkfwaHjO7fh0tzWPOOyPs
	 WEkVg2k2vR/2OJiddxGRp8QiTu+LwWjqC+kjwVxu06a1NOEujdqIJzwRAssuQhh9HL
	 fDmKmC424VrbyYy2fI1oNhDHij+ivjtg+nca8E/j2cTFZq1/23q10gHonsnbp4731C
	 orXVpiU5OrTfg==
From: Sasha Levin <sashal@kernel.org>
To: kas@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	peterz@infradead.org,
	fvdl@google.com,
	willy@infradead.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb_vmemmap: map the shared tail page writable" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:04:34 -0500
Message-ID: <20261109200434-failed-6.18-0120a603afad@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0120a603afadba8ab4954bb1ce60f8195f80efc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200434-failed-6.18-0120a603afad@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0120a603afadba8ab4954bb1ce60f8195f80efc8 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Wed, 28 Oct 2026 13:26:21 +0000
Subject: [PATCH] mm/hugetlb_vmemmap: map the shared tail page writable

page_ref_add_unless_zero() reads the refcount and then updates it with a
cmpxchg.  A lockless get, such as a page cache lookup or a PFN scanner,
can read a non-zero refcount from a page that is then freed and reused as
a hugetlb tail page.  If HVO remaps its struct page to the shared tail
page in between, the cmpxchg writes to read-only vmemmap:

    CPU0 (lockless get)               CPU1
    c = atomic_read(&page->_refcount)
                                      page freed
                                      page allocated as a hugetlb tail
                                      HVO remaps the struct page RO
    try_cmpxchg(&page->_refcount, &c, c + 1)
      -> write fault on read-only vmemmap

The refcount is zero by then and the compare fails, but a compare-and-swap
instruction needs write access whether or not it succeeds.  The kernel
oopses when hugetlb pages are allocated at runtime with HVO enabled while
a lockless get races with it.

Commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN
walkers") closed the window with RCU on both sides.  The RCU was removed
together with fake heads, on the wrong belief that it was only needed for
them.

Map the shared tail page writable instead of restoring the RCU.  Every
struct page on it is a tail with a zero refcount, so a late cmpxchg
fails and leaves the page unchanged.  RCU would put rcu_read_lock()
back around every get and synchronize_rcu() back into hugetlb
allocation and freeing.

The cost is the protection against stray writes to tail struct pages.  The
shared page is shared by all hugetlb folios of the same order in the zone,
so such a write now corrupts all of them instead of oopsing.

Bootmem folios optimized when the memmap is set up keep their tails
read-only.  Nothing does a lockless get on them before hugetlb takes them
over.

Link: https://lore.kernel.org/20261028132623.2560146-1-kirill@shutemov.name
Fixes: 32c440d67e6c ("mm: drop fake head checks")
Fixes: 01b1d0ffb6f7 ("hugetlb: remove VMEMMAP_SYNCHRONIZE_RCU")
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: David Hildenbrand (Arm) <david@kernel.org>
Closes: https://lore.kernel.org/r/ebc7bde1-f52e-4da8-b16f-822d6c0a4d74@kernel.org
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frank van der Linden <fvdl@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: <stable@vger.kernel.org>
---
 Documentation/mm/vmemmap_dedup.rst | 15 +++++++++++++--
 mm/hugetlb_vmemmap.c               |  8 +++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 8c287ae3f86cc..5e792b7a27f07 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -130,8 +130,19 @@ pages of ``struct page`` (page 1 to page 7) are tail pages.
 The optimization is only applied when the size of the struct page is a power
 of 2. In this case, all tail pages of the same order are identical. See
 compound_head(). This allows us to remap the tail pages of the vmemmap to a
-shared, read-only page. The head page is also remapped to a new page. This
-allows the original vmemmap pages to be freed.
+shared page. The head page is also remapped to a new page. This allows the
+original vmemmap pages to be freed.
+
+The shared page is mapped writable. A lockless get of a page reference can
+read a non-zero refcount before the remap and attempt its atomic update
+after it. The refcount of a tail page is zero, so the update fails without
+changing the page. Nothing else may write to the shared page: it is shared
+by all HugeTLB pages of the same size in the zone, and a stray write would
+corrupt all of them.
+
+HugeTLB pages whose vmemmap is optimized when the memmap is first set up at
+boot keep a read-only mapping of the shared page. Nothing can do a lockless
+get on them before they are handed to HugeTLB.
 
 Here is how things look after remapping::
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 0057fa2a16a89..9aa8af5c8856c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -222,10 +222,12 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 		VM_WARN_ON_ONCE(!PageTail((const struct page *)addr));
 
 		/*
-		 * Remap the tail pages as read-only to catch illegal write
-		 * operation to the tail pages.
+		 * Map the shared tail page writable. A lockless get that read
+		 * a non-zero refcount before the remap can still do its
+		 * cmpxchg after it. The refcount is zero, so the cmpxchg
+		 * fails and leaves the page unchanged.
 		 */
-		entry = mk_pte(walk->vmemmap_tail, PAGE_KERNEL_RO);
+		entry = mk_pte(walk->vmemmap_tail, PAGE_KERNEL);
 	}
 
 	list_add(&page->lru, walk->vmemmap_pages);
-- 
2.53.0




