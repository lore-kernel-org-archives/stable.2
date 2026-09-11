Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEA14BF92
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085739; cv=none; b=DgHhcstYMOySXM/RM8LDjuPFzcFsi3e2X5Vlz2/3P8WHx8VE8MSI5FyueumFaIvtzHUBf8eMU2q11MgVgP/O2Vy5n1NsfOsJPTVm5OXTdWH9fn281LKjkzOs2YVUAcAwRChTK7R/u/Ei73aOqEk6Ycbf/3aAU2CxhbCKJuib0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085739; c=relaxed/simple;
	bh=OTVLUEAj0XKQPfQxTBRSDQDW5OpaCkS7e9CfjxgS3Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQs98p+8eiXjQIv7Sw7de/mQex+0HHWRtrw7hpHVEX/muTlHnzXN3iT/kHG3qqqJWtnoLpa9krFHRtnUnDNM67NCqrSjmUOwbDlie9ZxsyztLVXr2zUrSIztm4N8h36AvRBE7Hg9JNlmKn2zRzyUzS3T47VOI4v/30SF7Xnp9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM32AG6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM32AG6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D251F00893;
	Fri, 11 Sep 2026 00:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085737;
	bh=jz3w+31kFPeB+aoB1ducTkb44AndDU5IgYnJnpmee6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VM32AG6CtnXf0eNHDZgPMP7SBOC8D/F5lvOVf0T71ADQzpQiwEeTj3/VX2pz8Kt/H
	 CIcxkqhBMIQZKlxt0iwyeWxUsOIA9ZodydIPkr121u2tW8OSbexWv04iG7E2ZmiJ7A
	 AznN7PHfa5BNVMAe2ZKUIZ3zpuNYShyRz27ZgGSUgdemy4fGw84BvRHGNt+aCBRv3V
	 3NPJ5LZY79A7r751E2iB/m+udG8ZiC8UdllQEr28LVxSj3b1OgI+4Vy2OUKcL9LL3c
	 yuK1VTnz63G2d7v0riK0wdK/nrS4vdM96c661WhSHeK7w5h4mJjtCMZogN4RY3zvWK
	 haXV3znzdgvyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm: fix incorrect vm_flags usage when checking allowable orders for tmpfs
Date: Thu, 10 Sep 2026 20:15:33 -0400
Message-ID: <20260911001534.3302657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090905-parabola-lasso-d089@gregkh>
References: <2026090905-parabola-lasso-d089@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baolin Wang <baolin.wang@linux.alibaba.com>

[ Upstream commit 2fd4e7693674b17807a6d082feb01a3fbf86f5f8 ]

Lance reported that when nothing else causes the mm to be considered for
khugepaged collapse, an MADV_HUGEPAGE-advised tmpfs VMA alone does not
trigger scanning.

After commit 6beeab870e70 ("mm: shmem: move shmem_huge_global_enabled()
into shmem_allowable_huge_orders()"), the shmem/tmpfs allowable order
check reads vma->flags directly.  However, when MADV_HUGEPAGE is handled,
khugepaged_enter_vma() is called before the VMA's flags have been updated,
so the check uses stale flags and incorrectly rejects the VMA for
collapse.  As a result, khugepaged does not collapse the tmpfs file into
PMD order in time.

Fix this by calling khugepaged_enter_vma() with the new VMA flags in
madvise_update_vma().  Meanwhile we can remove the khugepaged_enter_vma()
in hugepage_madvise().

Link: https://lore.kernel.org/7d5b5eb27be798f89d563b06254c947ff53db0b2.1787020910.git.baolin.wang@linux.alibaba.com
Fixes: 6beeab870e70 ("mm: shmem: move shmem_huge_global_enabled() into shmem_allowable_huge_orders()")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Lance Yang <lance.yang@linux.dev>
Closes: https://lore.kernel.org/all/20260815181632.21453-1-lance.yang@linux.dev/
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted newer VMA flag APIs to the older scalar vm_flags_t interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 6 ------
 mm/madvise.c    | 8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b3ba903ba390..a11e56ef99236 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -353,12 +353,6 @@ int hugepage_madvise(struct vm_area_struct *vma,
 #endif
 		*vm_flags &= ~VM_NOHUGEPAGE;
 		*vm_flags |= VM_HUGEPAGE;
-		/*
-		 * If the vma become good for khugepaged to scan,
-		 * register it here without waiting a page fault that
-		 * may not happen any time soon.
-		 */
-		khugepaged_enter_vma(vma, *vm_flags);
 		break;
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
diff --git a/mm/madvise.c b/mm/madvise.c
index 73f56b18c337d..b8c25fea4fab9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -177,6 +177,14 @@ static int madvise_update_vma(vm_flags_t new_flags,
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
 	vm_flags_reset(vma, new_flags);
+	/*
+	 * If the vma become good for khugepaged to scan,
+	 * register it here without waiting a page fault that
+	 * may not happen any time soon.
+	 */
+	if (new_flags & VM_HUGEPAGE)
+		khugepaged_enter_vma(vma, new_flags);
+
 	if (set_new_anon_name)
 		return replace_anon_vma_name(vma, anon_name);
 
-- 
2.53.0

