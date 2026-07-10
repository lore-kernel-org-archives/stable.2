Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B642316C;
	Fri, 10 Jul 2026 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690177; cv=none; b=DCNla9KMHOXOosrRPYCT0HqkthudAEqRDHuZBYPcVYVZwd/FlknO++XAdHpw/eVR73QW8h4bBhGc7FG4fZEso2EiywRtYuP1ZvCfnD0yKxEF8nH6k1B7BKkpC3eBb7HmvLjt2UE6TCC8TQ/s9u62Y1Q7ZisS8KSdcjnCMY0pu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690177; c=relaxed/simple;
	bh=VzRMeEZwR/QyRzaOWZ5WDpsIG/pAI9hskscf2ZRld7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pKNQROxIDKbe7jHc780e3hj8TwKpDq7GaMQ+QZU8rZoN9Zzf3nRLMjjQQ0NGwfShlN6SwGyX4ZjgBrRlD1JfAVdsQKt0FICxhTOSgIS+pvaju1aucjG74z6ikjgveprb+ID+WkMMyA0Dq9ZQ6wefKEh+j+mCClsJCNJenRbdeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQg8+2jI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQg8+2jI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398761F000E9;
	Fri, 10 Jul 2026 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783690175;
	bh=kcYVIiskpfne6Z9qwfXmo8J9FegSGRAbeyuNySWrJRQ=;
	h=From:Date:Subject:To:Cc;
	b=fQg8+2jI+DZhHyrmCjhaf+XXo3+Dey6mmIsYXWahDztTlHY4efdHpEdxnGSms1m1p
	 ESAV/+FQMAxXRpCaK3rAOc2FlQEaO3NTtzMBcjptfTZ0urNw8K1SpGo3WdluebnYPt
	 yGJib7lxN5Y052I8znAi4whgIWh9+P3asFtsDViKhtpZHaPjle4dEQUXCUr07mkgKV
	 jNKQdrqlM00J/7Hx1Z7Y0qfftrojwoa53xj1KGlq4x/D7JOh2HakJ+a3gZiu0tcG7m
	 XuPs00VU3RdVnNCWVXEblnbKXrIxmUEDmEGS3C932iCpK39TY/Z9E7MF56I1Hrsy1R
	 P6UqsXUbHfSXg==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Fri, 10 Jul 2026 14:29:21 +0100
Subject: [PATCH] mm/ptdump: always stabilise against page table freeing
 using init_mm
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org>
X-B4-Tracking: v=1; b=H4sIALDzUGoC/yXMUQqDMBBF0a3IfDuQhJJKtyKlJDptp5AxJFEK4
 t6N+nngvbtCpsSU4dGskGjhzJNU6LaB4evkQ8hjNRhlrLprhf6Gb/6jTIIsXF4hYCzjHCIqbX3
 XkXHGWaj/mKguz3b/vJxn/6OhHEHYth1d9m/cfQAAAA==
X-Change-ID: 20260710-b4-fix-non-init_mm-ptdump-016b88e2a2a6
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Toshi Kani <toshi.kani@hpe.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 David Carlier <devnexen@gmail.com>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Will Deacon <will@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, ljs@kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2446; i=ljs@kernel.org;
 h=from:subject:message-id; bh=VzRMeEZwR/QyRzaOWZ5WDpsIG/pAI9hskscf2ZRld7I=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLICPm8qsutP+HlMPtWn5S/3I/l0k5Dnzw7m75idUS3oO
 OWVZFx9RykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACZiGMbwv+aPW2eDfPSKFX+e
 za5M8ElZdP3SukO3itN/C3JJpXtsXc7IcGj/jQ/vPXbePimxrfLQvof31k3QO2ozl1Pn8n6LJVu
 Pm/ADAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

x86 and arm64 invokes ptdump_walk_pgd() with non-init_mm mm whilst still
walking kernel page table ranges.

For x86 this is done in ptdump_curknl_show() and ptdump_efi_show(), the
first passing current->mm, and the second passing efi_mm (we reach kernel
mappings that init_mm protects for current->mm due to x86 cloning shared
kernel page tables for arbitrary mm's).

arm64 does so via ptdump_debugfs_register(), configured by efi_ptdump_info
for efi ranges against efi_mm.

The init_mm mmap lock is used to stabilise page table freeing against
ptdump, so take a nested lock on init_mm to ensure that we are correctly
stabilised.

We take this after mmap write locking the non-init_mm mm. Nothing acquires
the init_mm lock first before locking an arbitrary mm, so no deadlock is
possible.

Other fixes have been sent which update the two cases which can cause races
with ptdump in init_mm ranges to acquire the init_mm mmap write lock - vmap
and x86 CPA huge page promotion.

For arm64, commit fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump")
already provides exclusion against init_mm for the vmap case, which this
patch also pairs with.

The first point at which ptdump can race kernel page table freeing is
commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
table"), so we target this in the Fixes tag.

Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/ptdump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index 973020000096..6bef47b1a073 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -178,11 +178,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 
 	get_online_mems();
 	mmap_write_lock(mm);
+	/* To stabilise page tables we must hold the init_mm lock too. */
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
 

---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-b4-fix-non-init_mm-ptdump-016b88e2a2a6

Cheers,
-- 
Lorenzo Stoakes <ljs@kernel.org>

