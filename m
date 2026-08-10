Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA817B505
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359495; cv=none; b=dYBQqMvG16YAd9o6Fix4J8ZjYOWpqgAN+4cq29qp1mw3KdnM/9OfgKhnl5OP7l37IrJgJKLCMs6Sb5xg2MUQl5Sgb6lmtXpF7+h0jTGlJmmJnp6mtNL5IP7ai5rIO/hTgFpcXPfNCIXgdvyydUn6enLQGxUaEua148LfNCcZYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359495; c=relaxed/simple;
	bh=tjlS5pxnpCmgr6Gl9LYsPP06yNaghR9WwkpXQjjQ7Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j28J8batErTBzQb9x6kajs2aypthuUP92+UUn9tghIfcy5pnuyd/UIW909JX+5PCqxXFykxPfSLuZxKxooi6IZa858zXoNAGoD6SNTsttRfGvRnjb645VSlzBIsITP70OpiQDR5j8lBCl5tPlfoW+4pVliAXTOa1imNdlDbh38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5ejBUY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5ejBUY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1116E1F00A3D;
	Mon, 10 Aug 2026 10:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359493;
	bh=KdotRg4ENitzP0Ir6Ebm/nE6WXUDmGoDBFc4caAU0Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b5ejBUY8knbuH+c6O1XEx15dUsrbUWb1qwGjznWAznMpQ99NM71VojO3UmVSUgQFb
	 lyA6YzVT17AOML11J7PzKZMgPTDwiFU9vvhVdwUgqPIQRU4vY5+x9X32H6xBbqf7WV
	 lBoHHFFV+r8xqNBi3oRXM2zcSf6hX7GEdGWtNQBdZ3xFMPNAyYhiicypzrUBuDEgh1
	 QLgnXgz8Rf9QLCMrzOPtMbuHAQilO5mkXoRpI6kc3lEpeRVDSIpQuguZW8/GH9BcdB
	 +805nRzgZ4jbmkABqwGIX8L9toQxoRJ90Z6b1g01CZWTRrq0h0yuVOoInQJdnFipbX
	 fNkBC/yoexP1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Usama Arif <usama.arif@linux.dev>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] userfaultfd: wait on source PMD during UFFDIO_MOVE
Date: Mon, 10 Aug 2026 06:57:55 -0400
Message-ID: <20260810105755.579268-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810105755.579268-1-sashal@kernel.org>
References: <2026080544-exit-cesarean-7929@gregkh>
 <20260810105755.579268-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Usama Arif <usama.arif@linux.dev>

[ Upstream commit 4165b7d1c45c2da0dfefe528f8d1fb7d79f0d344 ]

move_pages_huge_pmd() snapshots src_pmdval under src_ptl, drops the lock,
and, for migration entries, waits with pmd_migration_entry_wait().

Passing &src_pmdval is wrong.  pmd_migration_entry_wait() must lock and
re-read the real page-table PMD; on split-PMD-lock kernels, a stack
address also resolves to the wrong lock.  softleaf_entry_wait_on_locked()
then waits without a folio reference, which is safe only while serialized
against migration-entry removal by the real PT lock.

Pass src_pmd, matching __handle_mm_fault() and hmm_vma_walk_pmd().

Link: https://lore.kernel.org/20260705131231.1499198-1-usama.arif@linux.dev
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=8
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3e72672b19c69..00f99ec85d8a1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2560,7 +2560,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	if (!pmd_trans_huge(src_pmdval)) {
 		spin_unlock(src_ptl);
 		if (pmd_is_migration_entry(src_pmdval)) {
-			pmd_migration_entry_wait(mm, &src_pmdval);
+			pmd_migration_entry_wait(mm, src_pmd);
 			return -EAGAIN;
 		}
 		return -ENOENT;
-- 
2.53.0

