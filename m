Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32847ECF7;
	Tue, 14 Jul 2026 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049908; cv=none; b=rCcEXvnNamxNWS2mIG5KxR/cAtg8IVbFztS6k86C9WHkRU6ALD1K592q5we9ECpOFjkCLHTTgRhItu9VV1bC98W3Ldg9yhHo5CLeoiJIJohDA3YifalrqOvSV6d9lO/cfz2BxUOf8gF5qGYRNCakD4rSeGuZNH3MsZqho+7XRg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049908; c=relaxed/simple;
	bh=+da+wQab4iV0i+3djD3hSaZE5QbecH6NvEFAGihVKmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFnWwPm0/KczZsVHeuRVJ2lpP5peWKpuimf+nHlow+Xel4ZTDbbU/oYakhBHeBTRX2QZWdb5kEDN68DiNd1/BCNI1WPiBz8gvu4fmAIiSUOt3jcRLqrViXP8SRly3+38pGiux2kl74K/fIU9ZNQvoe8EN1rYsj4yte5DJyQknhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJlvXF9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJlvXF9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C221F000E9;
	Tue, 14 Jul 2026 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049906;
	bh=7c4JIh+xXXzUf3RuGROVnJmdpEMXk82+j8IbVgKDa6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OJlvXF9SDCYElXNumMqDXpyahca0HdWzyR4wK5diDEgqmbgJmZxbHSAmgZtsY66mJ
	 bxTgooysHMBrODx4u6eF8rwqriH74jqLi5TwDCa9BpCVWGUCoSreK/wp529S6l3A6W
	 JhsYCDV9C3rAa/ohqxc71Us0gLNQ8pn64J+rWkVgaiqooJHhXOaOJbJKLgxdEqY6t6
	 GnXC5B5wxHArdwF528qzs2ZmhWbkBl+6NoR29hMloLREUfslmoJi9qiPBpP78dWK9z
	 DQoD+2SamlgwqAqBjDfeB3EAsBSoyHc1Qh0CQKrfheXphhSAYkNR62Rh4avwgei7KB
	 MVtvAV6CyT3Uw==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Tue, 14 Jul 2026 18:24:25 +0100
Subject: [PATCH mm-hotfixes v3 3/4] mm/ptdump: always stabilise against
 page table freeing using init_mm
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-series-vmap-race-fix-v3-3-b812eccfa0f9@kernel.org>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
In-Reply-To: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: David Carlier <devnexen@gmail.com>, ljs@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218; i=ljs@kernel.org;
 h=from:subject:message-id; bh=+da+wQab4iV0i+3djD3hSaZE5QbecH6NvEFAGihVKmE=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLCCs5J7kqZej7tJJ/tEu1Z3zYd/lkiw+B3/oJ83J5XP
 brVjMFfO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRC7MY/pn16AjX77hp7Hdo
 +83gjqAb2f+WTop+GxJcrPMq0i7PeQEjw+FrCicDTl1s5Kz61Wepp/mPj/uT7MLn01UuO61Z+5/
 nADcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Previous commits have established the invariant that kernel page table
freeing is performed while an mmap read lock on init_mm is held, which
fixes races between ptdump and kernel page table freeing over init_mm.

However, x86 and arm64 can perform a ptdump over an mm other than init_mm
via ptdump_walk_pgd() and since kernel memory ranges are shared across
non-kernel mm's, this means that the race still exists for these cases.

Fix this by acquiring a nested mmap write lock for init_mm in
ptdump_walk_pgd().

This is safe as we take this after mmap write locking the mm, and nothing
acquires the init_mm lock first before locking an arbitrary mm, so no
deadlock is possible.

Also update walk_page_range_debug() to assert that init_mm is write locked,
add a comment explaining why and remove some redundant code, and eliminate
the unnecessary and confusing invocation of walk_kernel_page_table_range().

We can safely remove the non-NULL check for walk.mm, as the mmap lock
asserts would NULL pointer deref if it was (and of course no callers do
this).

The first point at which ptdump can race kernel page table freeing is
commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
table"), so we target this in the Fixes tag.

Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
Cc: stable@vger.kernel.org
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/pagewalk.c | 14 +++++++++-----
 mm/ptdump.c   |  7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index bbcfd68d0907..5d87c632a255 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -702,12 +702,16 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 	 * to account for page table freeing on vmap huge page mapping.
 	 */
 	mmap_assert_write_locked(mm);
+	/*
+	 * x86, arm64 ptdump allow walks of efi mm's and x86 ptdump allows walks
+	 * of arbitrary mm's.
+	 *
+	 * However, they both must also hold the init_mm lock to account for
+	 * concurrent kernel page table freeing.
+	 */
+	mmap_assert_write_locked(&init_mm);
 
-	/* For convenience, we allow traversal of kernel mappings. */
-	if (mm == &init_mm)
-		return walk_kernel_page_table_range(start, end, ops,
-						    pgd, private);
-	if (start >= end || !walk.mm)
+	if (start >= end)
 		return -EINVAL;
 	if (!check_ops_safe(ops))
 		return -EINVAL;
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 973020000096..5851096e6f65 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -178,11 +178,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 
 	get_online_mems();
 	mmap_write_lock(mm);
+	/* To stabilise kernel page tables we must hold the init_mm lock too. */
+	if (mm != &init_mm)
+		mmap_write_lock_nested(&init_mm, SINGLE_DEPTH_NESTING);
+
 	while (range->start != range->end) {
 		walk_page_range_debug(mm, range->start, range->end,
 				      &ptdump_ops, pgd, st);
 		range++;
 	}
+
+	if (mm != &init_mm)
+		mmap_write_unlock(&init_mm);
 	mmap_write_unlock(mm);
 	put_online_mems();
 

-- 
2.55.0

