Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD83C09E7;
	Thu,  4 Jun 2026 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552414; cv=none; b=DyadF10S4i5aU637RBMeBtxmgl0r2CxR3S/xoI9IIvdvchi7v3EMK9BOuIgM65FbSxsuVtLySBlUdKuRpAxZW1UkwbQpHu601tEAHIm17y86aOqyFPl03Ybs4mnE1xeimvM4RFjUpay/i1Pc94BEix08U3iSiAGao9ymkY0UBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552414; c=relaxed/simple;
	bh=fr1ZIAKStZBd1psxptXiTd8a10xNZESCVeJoWx72PSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkbevvxICrzGKH1pjx4C+yMbxOIQWZuo4yMN8DG4qllyxa4G8R4Vt4icX3hy5rqujSGQEZ9MVWvw7v3RhcobGV9r4GLP6SIO9O0XwoAn7/6efPCVTtrOFCnn4+sj6vw5/TAEu7dEHk0ZgYFssriehtFvSFeSE43WwwEd0mgDPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MSn4AOul; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MSn4AOul"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4C53161;
	Wed,  3 Jun 2026 22:53:26 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 690073F632;
	Wed,  3 Jun 2026 22:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780552411; bh=fr1ZIAKStZBd1psxptXiTd8a10xNZESCVeJoWx72PSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSn4AOuln+fZ2CVLJ6oX5bcQMRbDlPvZYZoMQ4eHlTUvTMK5Np1lmbcTk7jobKzHN
	 8ZftqXvWi5eO40qEL1SBCbcQqQZp8q8oAIv94LeQHM8Tev4qI9i3B0EsWM57JtrJmA
	 QKoxqVtIl2Z5nGJo+44H7uVSc+cVItHrU+DAlwn0=
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
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	usama.arif@linux.dev,
	stable@vger.kernel.org,
	Oscar Salvador <osalvador@kernel.org>
Subject: [PATCH v3 1/2] fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
Date: Thu,  4 Jun 2026 05:53:05 +0000
Message-ID: <20260604055308.1947679-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604055308.1947679-1-dev.jain@arm.com>
References: <20260604055308.1947679-1-dev.jain@arm.com>
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
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Tested-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
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

