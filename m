Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690EC30C632
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791177810; cv=none; b=H70wOcouXa0kxq0VCuHOeJX4JIM3frMVdQ5Glb69FQoKj1C+zuPW4SEFgwNrSIJhJrYfbMUmPT/L2U2rn/xHiGtXj9zb3exV/2Lji6hPHJs9CEnkjGkW+h7NHKDXENvM3I53F7sG3WA6e2Tf1wpN3zlnanCkCxRpg8IgFgH55RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791177810; c=relaxed/simple;
	bh=HvCCfJG7Kj4AzwyPWL74XPayQRFxzYMNbzWN/592PQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1M/SiCPjMAiIKWAAsEmKawrE+AB7U1brFQ7VV/G6d0YuNQ+0jWjt9Xrnkdy6pPVAoek4i76pDzInEwqZ5rhNK5t2th0BWQPFkKL/kxlsyJJlYz5iJg0eNspRw4a5W7tZEoIMPlnrTXWCtFPqk1efcntUwgvFCbcJXajFVxLFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9IJYLy8; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9IJYLy8"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HvCCfJG7Kj4AzwyPWL74XPayQRFxzYMNbzWN/592PQA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791177806; v=1; x=1791782606;
 b=I9IJYLy8QzPqdAqyDxJCc6wp3NlWaRvJhXv1CwRTO7cwyvygY6Wz3tlHvmZXqCJp5fn+6QbF
 ytbQ4NAXlmav/Io2IXiwS/il6SakYlN9bvsDelrEfdo3RIpUalHw2/bAkC6pc3Kbo/FFYKJD2we
 wcSYS8TnIKMvAjxvWCXbwtTQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0fbe826855e32b70;
	Mon, 05 Oct 2026 05:23:15 +0000
X-Mizu-Trace-ID: 0fbe826855e32b70
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: dave.hansen@linux.intel.com
Cc: luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	riel@surriel.com,
	linux-kernel@vger.kernel.org,
	qi.zheng@linux.dev,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	brendan.jackman@linux.dev,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com,
	mingo@kernel.org,
	stable@vger.kernel.org,
	toshi.kani@hpe.com,
	david@kernel.org,
	mikhail.v.gavrilov@gmail.com,
	pfalcato@suse.de,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with TCE
Date: Mon,  5 Oct 2026 13:23:02 +0800
Message-ID: <20261005052302.43042-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pud_free_pmd_page() uses a single-address invalidation to flush the
paging-structure caches before freeing the page tables. With AMD TCE
enabled, this only invalidates upper-level entries associated with the
target address. Cached PMD entries for other addresses in the PUD range can
still reference the PTE pages being freed.

The AMD manual quoted in the commit enabling TCE says these instructions
remove

  "only those upper-level entries that lead to the target PTE in the page
  table hierarchy, leaving unrelated upper-level entries intact."

Even with all PTEs cleared, speculative page walks can cache present PMD
entries after the earlier TLB purge.

Use a full TLB flush before freeing the page tables on CPUs with TCE. Keep
the single-address invalidation otherwise.

Fixes: 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")
Cc: stable@vger.kernel.org
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 arch/x86/mm/pgtable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 4a105f283cfb..6b7fa44f1bf6 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -727,7 +727,16 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	 * via normal page walks. Make them unreachable
 	 * in cached mid-level walks too:
 	 */
-	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
+	if (boot_cpu_has(X86_FEATURE_TCE)) {
+		/*
+		 * With TCE enabled, a single-address flush does not invalidate
+		 * cached PMD entries for the rest of the PUD range.
+		 */
+		flush_tlb_all();
+	} else {
+		/* INVLPG to clear all paging-structure caches */
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
+	}
 
 	for (i = 0; i < PTRS_PER_PMD; i++) {
 		if (!pmd_none(pmd[i])) {
-- 
2.49.0

