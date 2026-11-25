Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607547;
	b=cZebXzRRn0EP2lFtJu9mW6cMZUWtuMomRXPimfFrYfE4pppkDCBPb1+yWMPvQIxZE/6w
	 CfBLzlKz5Xj4Qu6n/1fCgsGdyr5QMpP80dVkCWR4GEL1GNO8d4Q7PFJcwGbl+B6ezIz+/
	 THnqypXBAa23Ueq57XBKZ2723S6dH0MLYwO7mC+6mwdGSdmRqRafMlXX9MIwwweR3+FXc
	 ZNmCXKW1H9uYk58F15dMIqCdIl20ov3MQMHX+XRFwieA/fnDjBRyPJgGTEY3lRVPiLVo0
	 VYrvb3W5kkE7eAdsGO46fQ7uLrMsEJiicCwB7jcSPqWRAXa0FcwpQydlgu/qfRrnw/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607547;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=liDtjMCYWCVrpCiVXsPu6BPJfflyuRnHj5CWksRn/08=;
	b=W6V9+hsrlnfhdT9toYl9/KS3GgkJ756Qiu1fKG5LCaqUEdo/ESJTR+9cE99GcJowG1QB
	 uqyHz1wvaYWeRtzkhSTap0mh8zxGpsMUBgWp9q4zlNneNSzk6kRl8gM2aC8KyIC74+lhy
	 c/wurfLtogZTx0qDfbIh7t6x9KF6UKPhx5f43VU5ALChpPYQ12SNtF9+5Uw7O2fcKfFaB
	 6r/puM+kfaeHt8xz99wz8jTIPHqylgCDiHsqDrb7KQin0+lvpoFdzeX4/jSG+t9kuy35D
	 AQNiXnHT4CzQVBLBHOgaxi3d7+ckSSAZwbqCvOGG8h9z/lhPvvwdEwhNr/dM+lvQQnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YYsQfrYx;
	arc=none smtp.remote-ip=91.218.175.74
Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69709606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69709606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YYsQfrYx
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x1fNkb2uruRr6K+ePqbhT3N1TY6nC237qiyCXj/fHh0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795607544; v=1; x=1796212344;
 b=YYsQfrYx+qaJeGGIkTbL5MPYdVRQYVDB4IkLt7Ck6B54fwlLuqb8XJjLDRoTNLcJ2hW79lOB
 +QEXgWUl4Ve/qi38to/M7Q7pIrevuqmPYCB8amLirysVey01nlgOmK8dHTmsod4SONJy8aX96/q
 N0qrkB5zF3+dbBifF+aoD4Bo=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7eece8749f71e3f0;
	Wed, 25 Nov 2026 11:52:23 +0000
X-Mizu-Trace-ID: 7eece8749f71e3f0
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] fs/proc/task_mmu: don't read young/dirty from a non-present PMD in smaps
Date: Wed, 25 Nov 2026 03:49:58 -0800
Message-ID: <20261125115014.4014507-3-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261125115014.4014507-1-usama.arif@linux.dev>
References: <20261125115014.4014507-1-usama.arif@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smaps_pmd_entry() passes pmd_young() and pmd_dirty() to smaps_account()
for every PMD, including softleaf entries (migration and device-private),
where those bits encode the entry rather than accessed/dirty state.
smaps_pte_entry() only reads them when the entry is present.

On x86_64 the entry's offset is stored inverted across bits 9-58, which
overlap _PAGE_SAVED_DIRTY, so pmd_dirty() returns garbage: a clean 2MB
device-private mapping is accounted as 2048 kB dirty, and lazyfree
accounting is suppressed. pgtable_64.h also warns that the hardware can
set the accessed and dirty bits on non-present entries by mistake.

Only read the bits when the PMD is present.

Fixes: c94b6923fa0a ("/proc/PID/smaps: Add PMD migration entry parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cb5e335bf05da4..cf1732935c73df 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1020,7 +1020,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool present = false;
+	bool present = false, young = false, dirty = false;
 	struct folio *folio;
 	const pmd_t pmdval = pmdp_get(pmd);
 
@@ -1028,6 +1028,8 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return;
 	if (pmd_present(pmdval)) {
 		page = vm_normal_page_pmd(vma, addr, pmdval);
+		young = pmd_young(pmdval);
+		dirty = pmd_dirty(pmdval);
 		present = true;
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(pmdval);
@@ -1047,8 +1049,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
 
-	smaps_account(mss, page, true, pmd_young(pmdval), pmd_dirty(pmdval),
-		      locked, present);
+	smaps_account(mss, page, true, young, dirty, locked, present);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
-- 
2.53.1-Meta

