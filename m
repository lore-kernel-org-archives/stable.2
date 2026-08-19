Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C05449B39
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138054; cv=none; b=cLOBBtM3Q8n7mPbL5aIWRRhx/37eWMskecQT+pIQSpQQklC4EpfZh1jTaJMVRKqUtQNk7rj7K4np/WY+eHuVv+qwdpjrd+2zpsVbJfjRDsyq6iwl8e5uVlOnrDnO9QPKo6xY3yo6k9PPEawg+JOZ4K/gHhkEgzBkw7fAJzmVn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138054; c=relaxed/simple;
	bh=kx/aNwm1er9BC9heMeTGg8asJqZh8rkC7rjDT3MjQHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e50JUQm77xv17z4NpUtjAldrUdkEtG6qPfsNEBJGiMFetzlwBfM7htv766mQ0TOPyF1O4daTU+k6rWQObSGd9EErIHUPLOvNV2maw/213l+ZDp7eZnagTrio+NgP6tSKFbQq5zXBQS8jXOzcL2VXjtEms8otavhNfA/BZm+1TAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDZvaez5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDZvaez5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2961F00AC4;
	Wed, 19 Aug 2026 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138053;
	bh=NMPM7jrcZstKalOIOhmctFSdMAFHew5ROlA6K9P7Q1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDZvaez5iqI9+gIhLBoai0BZmixUukmikOdJgjOJwTo5BbsZ27fiq0P7+C1wsIezz
	 bNz8LC+zZ9RHdGMbpRA4c62uvcJwqoQdTP3iewdqprPqFEfej4z0uoN9KBH8nPnhM6
	 uvJdvWuOR8OQc9O0AICNbofFTVCrRTl1OC9tyM2GCw/M558Bfu0kz6jrq1ch/Y15Ho
	 nWIJEtLcrA0bHCuYa5NK0SyLA8rO2h0CSyeON0jyjt1W+5zbTPX4/kTQxNIF6zU+GP
	 Qxm2kacxzFDpgvwdtxda2M9OUPbEFjUdy6CUnkMCHkUiuTv5UNpzoikIyHeZq9hjHb
	 i8kcCmYWrlpTg==
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
Subject: [PATCH 6.6.y 3/3] mm/ptdump: always stabilise against page table freeing using init_mm
Date: Wed, 19 Aug 2026 07:14:04 -0400
Message-ID: <20260819111404.3548740-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819111404.3548740-1-sashal@kernel.org>
References: <2026081756-undiluted-swoop-f836@gregkh>
 <20260819111404.3548740-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/pagewalk.c | 14 +++++++++-----
 mm/ptdump.c   |  7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 1dcbf6ed536a..ffb583e0b0c7 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -610,12 +610,16 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
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
 
 	return walk_pgd_range(start, end, &walk);
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 616a54c0cc42..48d1bcdc79a7 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -155,11 +155,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 
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
2.53.0

