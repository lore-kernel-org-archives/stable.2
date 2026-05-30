Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E57E39A05D;
	Sat, 30 May 2026 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131279; cv=none; b=nYvwvDxAPVSlieWPPLauWKyal0jz9DFsiUYif2DfHgnA7XqGd56yHONwsdj3kv8hzGUo/OirodFKDCQD75yDG+2CCd6rufdnDnhbWl+VrkhZ7uqWe1MusuSiHRhz9Ts8m9+n9amgeyQ/1zoPE2+Z2hjbnSLKY0FCBNhUjbOEYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131279; c=relaxed/simple;
	bh=Ak9G3LTYza/gCy6/RFFf4a29T76eDF8ntJacgmiggGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qup9hRTBD4mYECK8NcgvOsSqOeC9TwZAKPv+1leoNeLuT0v9ODqtSR2MQdNVb77KjyL9qc4860BaFfvdaeeQ9XItrghr/DkJ6K6K6dU1zeDx/aGoz47JN1zRBYtmt6IrCv9WEq4CFkdUTbuxJawkCbKCztiW0L8dfaCV1FVVxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yx5bwhs8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yx5bwhs8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90C393515;
	Sat, 30 May 2026 01:54:30 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D82313F632;
	Sat, 30 May 2026 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780131275; bh=Ak9G3LTYza/gCy6/RFFf4a29T76eDF8ntJacgmiggGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yx5bwhs8LeClLHtnd2KjyEtflEV4UCKNY1KLqTIVI/VHD2zmhNBQws0EmMy3+WBNB
	 RrwSVqyNK6yixYPKWJxweGMVpyLn80RLYlqSs3KxYBFOgoW6Py1NmRdlgSimr8fX/A
	 HoxuImJ3uvdr0xRxe/Uu8zZ1uf9ERKn/vV573SjA=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	david@kernel.org,
	shuah@kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	balbirs@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kselftest@vger.kernel.org,
	usama.arif@linux.dev,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
Date: Sat, 30 May 2026 08:54:11 +0000
Message-ID: <20260530085413.1270139-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530085413.1270139-1-dev.jain@arm.com>
References: <20260530085413.1270139-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
entry. This became false once device-private entries at the PMD level were
added.

Therefore, remove the stale migration-only assertion.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 fs/proc/task_mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1e3a15bf46f4e..58938e62154d9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2129,7 +2129,6 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_SOFT_DIRTY;
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
-		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
 		page = softleaf_to_page(entry);
 	}
 
-- 
2.43.0

