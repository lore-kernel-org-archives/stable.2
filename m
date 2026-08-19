Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427A1F942
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180965; cv=none; b=SnW97g3xk9lcF+SivE6Lnz369krJIWeemuS2++MFVlZxDZSqY2MvnhRpA7yGKjfrv5a4hvhi4IC4pNhMeGqP8a21Bw4D1rA5Y36u/vU+agzrKllpgq2ZwAS1fJ0ttSg5MaHhI4srb+rLN3egTHja8FI/dhWqegfSh0kzyHJRVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180965; c=relaxed/simple;
	bh=9WHnJivb1uKYy6i8sRyys8KKju1C0kYMQL5T9Ikwtes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHT+BFkxF17bNOsfaX30WtR5ChHW1ZZw0nSuOPIyoEG4cRzQUqTBdSgefX6C9aDVdSKaC9UkA5vFbeOvoRGnsBb1lMmTuf126MFO41hrtTqcvXSj6mP1LvwnYNWi0BFD7dsz27bmHUc0Mj8SELd3K4k0D/6B+ppCOfef5cFrKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEqFIIGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEqFIIGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D46F1F000E9;
	Wed, 19 Aug 2026 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787180963;
	bh=3ny9U6i5wIflE7c0Ju0MpCZkajJgZne5C1+c9xGNe/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jEqFIIGdMCHPF/HnXGX4ewLQsz5382nCnz6aGODMy/N4pepMgiqmaKLW8+2DkSEzk
	 JpJ50QAPN1hc0/8RcxKcE52yq5XS5sCpY6EKZ6KOmTqBjrGrtGLOTPboOOVPVblh+M
	 mGoE9w26L5bG4Y0RvbIovxb7zJS8U0ZFPf60MxvK+Oy+x6/SoYPZBUdEmneKiaVp/7
	 g5Afjm8I3NOvL/kTBHdTjqGxKy7bLoP7ykCNxvZuIZ2YAYnWiWKmnKMdat3nH+2SX4
	 V1Y/sWsl7qe5NCbHaawOkT61RQJhJ9fUs0iJ6TYooTC3jrtdQn+4h+cTrGFCujc0H9
	 SgXp0kDk8FnCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Carlier <devnexen@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/ptdump: always stabilise against page table freeing using init_mm
Date: Wed, 19 Aug 2026 19:09:18 -0400
Message-ID: <20260819230918.944241-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081759-chaps-reluctant-4a0a@gregkh>
References: <2026081759-chaps-reluctant-4a0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 27c32e5538344b13c1505a08861e04620c125d47 ]

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

Also update walk_page_range_debug() to assert that init_mm is write
locked, add a comment explaining why and remove some redundant code, and
eliminate the unnecessary and confusing invocation of
walk_kernel_page_table_range().

We can safely remove the non-NULL check for walk.mm, as the mmap lock
asserts would NULL pointer deref if it was (and of course no callers do
this).

The first point at which ptdump can race kernel page table freeing is
commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
table"), so we target this in the Fixes tag.

Link: https://lore.kernel.org/20260723-series-vmap-race-fix-v6-4-8cc77dcc0018@kernel.org
Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Carlier <devnexen@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adapted the hunk to `walk_page_range_novma()` since 5.15 lacks the `walk_page_range_debug()` rename and the `walk_kernel_page_table_range()` dispatch, keeping the existing `!walk.mm` guard. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/pagewalk.c | 8 ++++++++
 mm/ptdump.c   | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3f5cbd6eb4e1b..da5888d5397aa 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -457,6 +457,14 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 		return -EINVAL;
 
 	mmap_assert_write_locked(walk.mm);
+	/*
+	 * x86, arm64 ptdump allow walks of efi mm's and x86 ptdump allows walks
+	 * of arbitrary mm's.
+	 *
+	 * However, they both must also hold the init_mm lock to account for
+	 * concurrent kernel page table freeing.
+	 */
+	mmap_assert_write_locked(&init_mm);
 
 	return walk_pgd_range(start, end, &walk);
 }
diff --git a/mm/ptdump.c b/mm/ptdump.c
index adbc141083c77..9e11894393d65 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -143,11 +143,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 
 	get_online_mems();
 	mmap_write_lock(mm);
+	/* To stabilise kernel page tables we must hold the init_mm lock too. */
+	if (mm != &init_mm)
+		mmap_write_lock_nested(&init_mm, SINGLE_DEPTH_NESTING);
+
 	while (range->start != range->end) {
 		walk_page_range_novma(mm, range->start, range->end,
 				      &ptdump_ops, pgd, st);
 		range++;
 	}
+
+	if (mm != &init_mm)
+		mmap_write_unlock(&init_mm);
 	mmap_write_unlock(mm);
 	put_online_mems();
 
-- 
2.53.0

