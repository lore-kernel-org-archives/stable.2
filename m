Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44812E091B;
	Fri, 17 Jul 2026 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309477; cv=none; b=iPbekwi7x730GvGdTHjjkpDXdvhR94uVIQEP8IptcEUbm69er8u+hI0Ca+Gfdb/bcYsiq6aHzxh1XYa5nQlMNOwrryHhi428uazoecM1Kar6eK4dEw9QqIBNslHLgqVTjD9P9t2jK2bfNSrm16SHNXJt2tl7TCaUSR0mhFVayAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309477; c=relaxed/simple;
	bh=VITXU838ytmI5wjkeVjJjzJ76fi6Ga2j8Ljay/OkRtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkFD7HoUEj2DGT9Xy2YEdGJcU4CVj8Pyg6NUl154IJZnmpIElON0pBdxtfCWH2ho6X9UGritfhyMWo/mJtiXF8UIYHkDEDEVr5WrfwKWX//ZDhbos/E0RoW53kzK1vs17n7fxJEps/yHMJ9EZAIdEe61+O8wQE0ahpsfd3eQgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7PegHdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7PegHdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E8F1F000E9;
	Fri, 17 Jul 2026 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309476;
	bh=4TmiXyJvQ92TKxUnkF2EBAbSx4BVAEx8E3qvkE5M06w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j7PegHdq1OFesFoUaayKABXnDJpVNSvSPDwYaiVx8/2g+pwbNCJ3ZfJja6eAtQZ8p
	 cIyc+DGp8cE1mY5T3MVxHeoEgCBsIQO/nHC6nOlsBe2FoOyLceFjBJ0vPPfhsUb9SM
	 5m/5O+dZndx9pKSDw52Ga8CFym1IitqeHcVgrB3OBwnEfcA6QcwjBgRM++V4FQwvYi
	 aOZwa7704A9u7bk3CoW7eomhkOF0zM5mBg5cz6qywFa0Ar92EAzklWTyarUQg4dv7m
	 BSQW/EW4hzjEqX2YoDLXo5uYFzkwDvt0LRfUvjOsP2TYV3cvXr7QKgDnltalcad/JW
	 +Q9P+xVsQPKwA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 17 Jul 2026 18:30:10 +0100
Subject: [PATCH mm-hotfixes v5 4/5] mm/ptdump: always stabilise against
 page table freeing using init_mm
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-series-vmap-race-fix-v5-4-606a0ac6d3e5@kernel.org>
References: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
In-Reply-To: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
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
 linux-arm-kernel@lists.infradead.org, "Denis V. Lunev" <den@virtuozzo.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3325; i=ljs@kernel.org;
 h=from:subject:message-id; bh=VITXU838ytmI5wjkeVjJjzJ76fi6Ga2j8Ljay/OkRtw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKi0rZ/XWP6/n/eThWz4m8aOyLm1Qpq9ujrr9sb/v3mt
 bR522oudJSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAih+MYfjHL3hNP3Nvg+Jtp
 1eU2vcCDZsmnLsjIzVir+DA4257NqJnhf4l0GpOQ+mypRYdmc1x2ZFwq37jKX7A5avOxL9Nz3lU
 KMQAA
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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
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

