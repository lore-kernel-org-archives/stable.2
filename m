Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811008;
	b=g2QXEvx/mBPNpUm3fUDch8KKNhR6UWws8b3QEb6HKyBR/lT50TX5DMqZYeQdX9fWDW7K
	 QQdcynoLPT8roEAd1Tk0lS3o9cRPLvlZPpJHh99X6tJpzbhgLdXx9M9uQrDihwG/2V9P4
	 Gj5ArmPq88ItDsmi/MIEcgQEOsSwzjkSfEWa6InRwjAHxOBJXxPMHcYV+TX5yg8ehTYyO
	 GaavbmoQf+rF7iXa8TmX4edYx760I7SLAdz9t+QiT6tM0MKtvwg3z6Imb5tGHF41G+Y0m
	 1PmzKhdK4sfH1n+sTbM4CzfhAUoxgrLFIs6Wgwjni/UzsJOIIN2F9ExOf6jfPNahgvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811008;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WujFsV3gjG0i+ckuCGbgYSpPrbyh9VKnBFOmaysMMYs=;
	b=h9XWm/+YOAoiXPi2ikDJUD4dLMpVu6OR9iYDmi+mGx7Ui6MythfXMPGkoQxR97RY7IA0
	 sKpn68UBD/msTsZveaGeoWLLYVCnVhBYAXw2QwH47bWOVSyX4duocBzaxNQGWJ8o1bO/F
	 Xv6Xg8scTiD3TDFjJ1Faabnw3Dl+6Qf9c+eOW61cT5f50A0uzI5aUiPr55JEmNtNAZM+l
	 sfzVtZtNiLKBGdpWio//qoUL1Z6VmzuN7KYDfQ6IACtSNe5CkIDmECFcYtD5rivbg/5oY
	 3VsduCkgrQUOCf5mFAV4Plk3NGrmU0QC7g6vjgWaWNqZ8VBFxvwvkE554YXolaOqhjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DW2igUsU;
	arc=none smtp.remote-ip=91.218.175.87
Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E1606A88B
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B1E1606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DW2igUsU
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x+ILKz6xxEiLKXXwh6DdV6s8+QRN9mKFDeJnW/pi2rE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794811005; v=1; x=1795415805;
 b=DW2igUsUcdPCFUbampoKKGdzYOJVukxdpiESWPBzpP/uohgZr3dixRx2p8TOgm95ukQmNXjg
 PZW5QoCDUrXNlEjvevxeCsh+Ehz83Unx1CEJiGF9oRJ6alKsSN6k+jxwsJIM0Fnu3ZcJ1zRyOjW
 IXk9rRaDpsbGGkf+D5yEngfM=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 94084be275281595;
	Mon, 16 Nov 2026 06:36:45 +0000
X-Mizu-Trace-ID: 94084be275281595
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
Subject: [PATCH v2 3/4] fs/proc/task_mmu: don't read young/dirty from a non-present PMD in smaps
Date: Sun, 15 Nov 2026 22:34:57 -0800
Message-ID: <20261116063624.1382944-4-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261116063624.1382944-1-usama.arif@linux.dev>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
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

smaps_pmd_entry() passes pmd_young(*pmd) and pmd_dirty(*pmd) to
smaps_account() for every PMD, including softleaf entries (migration and
device-private), where those bits encode the entry rather than
accessed/dirty state. smaps_pte_entry() only reads them when the entry
is present.

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
index 164b4efc5e093..ad9fdcdaa2c40 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1029,13 +1029,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool present = false;
+	bool present = false, young = false, dirty = false;
 	struct folio *folio;
 
 	if (pmd_none(*pmd))
 		return;
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
+		young = pmd_young(*pmd);
+		dirty = pmd_dirty(*pmd);
 		present = true;
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(*pmd);
@@ -1055,8 +1057,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
 
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
-		      locked, present);
+	smaps_account(mss, page, true, young, dirty, locked, present);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
-- 
2.53.1-Meta

