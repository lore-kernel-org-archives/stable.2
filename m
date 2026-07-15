Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269B3911C3;
	Wed, 15 Jul 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126562; cv=none; b=FCHoIdzF8vCfpdzvXVMT9Fa9VDd193uX0IUFF0RmX28Gb3s9h5n7iVak5PEUYaNoqgc2KOuJ/jrgE+d6d+Vw/EoUL5oYoJAKodfGMMPK6aTEO7BPMge/AVOe9qLeUGInHD0zixfHncDKG1WfEiADVPovM5WoCC01gRF3nrjPJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126562; c=relaxed/simple;
	bh=SSzkX6oNizzBnclV1Ddd+dh7jyeGSrDze8n0jH5wfH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaFokMjD2uM2tDLi88cv/kTvZfwFcAt1Ewc8F+Dojf2mcmgWynsOAxYidO7ISwIpQvSWfPY4xvgBaoozsOT/8Pt6yXfxMgCug0oRZC23s6nSZFzmW1AaIHdGZYw3mhCOlHWXKdFK2uLCQHg1+d9VeDPK5v9h7FP1VK8ovRhBvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=S7wsrVLS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAu5UZ1g; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="S7wsrVLS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAu5UZ1g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38F317A0074;
	Wed, 15 Jul 2026 10:42:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 10:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784126559; x=
	1784212959; bh=c6y1OnV7h9p9VSS3Eo9dyWcx32lCPnRRb24lSIuTS7g=; b=S
	7wsrVLSUrX7PLozhBcCnjCMHt0zF4MSEfZelyna+Lgkm0ILrnGPu7tqWPkmEW3U0
	d1DFOzr7UDa5okXVdw4pPX9NnkohORX7eh8feJxi3Kjix8QX1GzPlY/uLOZnrJ8U
	X+IH5ahfY5xGU9FXziC9VauHaKPNZtsaMyHsvyCLz6lEOFma5fn5OoDa/dCvuEwn
	GRDaigW5XdxoBX5e8lo/LY9iIVWBZwqw3JgZGjLTm0tYHvwaXgKyRZ+ro8HJ/kKu
	a7hqZhM6sqZFpAZfrj25YVcdwcXycOt+SNi1vBhz5Wqj8Qs6OWRNsKPZLWWPUUx/
	XJxzrqJlr2NfO4YOSmX4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784126559; x=1784212959; bh=c
	6y1OnV7h9p9VSS3Eo9dyWcx32lCPnRRb24lSIuTS7g=; b=UAu5UZ1g+NviFP2aL
	zFiUYYsrfGPzGwBpemVQP96GbrzE7IMRH5St1igYVyJOU+qxUXvmLUb2Wh2kNo8D
	2vB9r/2SVy9EreIMisqekTd8dOR1NHXv/6rUXsHcNf0G4x3cJL3Y2q1oOM3qp1IC
	PWLWvAianvIDJ3n3Cf0tUI0HR4/PuEQH1WfYf+mSA6MJ1ME7VlCvz6vwN8yv+3tW
	FQABGdFvFQs84Y/NKgn0YedoE8IX76G7rAVUEZWvcSBphJ6jwfzevWG5zIBBSBpS
	eHbTp8nmCU/0f8t9xVI0jdlhBjlxdObKZTWG8zBSzIbqGIjb9qNUSE7Qelhj5ohL
	lnHAA==
X-ME-Sender: <xms:XpxXahCzPV2rHO6kBmYBPqs21r9LupMs-XSbWTlbCfBPRuEyTo8Djw>
    <xme:XpxXarbs6PCZgGSzDqub7P36ascHv6AuNaasu8xjQU_x6DN6rZJt3W4wTmn2Nuq1o
    1rNrQHuHrMZ1wfn9y3QP3RiG4Zo5S8cJJS5d_82HVf8Oeo5oX0ziwA>
X-ME-Received: <xmr:XpxXaoE0tOydOAW98NfZvtMuWIP9_vfd9cv6kF2-6mIpWHA2DRuqCDck5XdoWA>
X-ME-Proxy-Cause: dmFkZTE+1A7G2hcqjwTbd4NRJ5r4x4RfmVHJ6LuBasDsbTedLKkIGrXMzo/e7fvs3eYrxf
    xqqYMvP4JoIfzcFji00RgKJm+Bn6eWtD5ed6C0tv1cpux/uttaDpuuMNYsoEUNt9QuPW2M
    jC0NyfpbU7rJr5JSIm23/GSVx0/9lMHXugOVcpbcHrgPp0lcDb9yXVv4G0g0+bHdyr7bUB
    c20Qq9n8+5OtMzrvilDcvz1aa1x0reXY36Ph+vv4DaSveM9xjORw2DvgBtC/tXbYuYB4pL
    y9lcY54Jn4NeKuES2FI5oILnXweeAoZ/O1OlmZcgvd4TkHypjHj+Ht/vmnm3LvAvJ2m1Ke
    U+lP1Z1Ob0xIAUNFlTT5j2rJpSmWGaKjoZ3MLfGKua+djy3XiBIP3RN5R4lUZbiOTrGJk9
    bFVzj3tdos5WHMJT1+QNHzrMVXoXymWPzJgcHjVZCCi4RIH/ujQhiRh4p6C2+VOv1wfGJG
    5O+OthCGEWJw9oCLknkDGawk8zYBLjB4EmEusNhti9QkcC/DJzTAvuj8ia+o3Jbcf3TW3s
    vG2BfIg/S69ZEYO6o6Xq2JZHCeKtlKUjAtrZYdan6K8KczYHtilPiOOI3jQXw/J7WFGbvT
    KDAHCtr4c+TpNbD6jc7Q6QCiJ3kFQ+uNEokIkTan2cV4gO/RUNCIaKILICeA
X-ME-Proxy: <xmx:XpxXavsqRUhE1LMdpgxWM4f3_4NKsGHPsnu7KMhbYAANBC1s-vodcg>
    <xmx:XpxXauKH4K4TzomsqcvE-j1tG2uxOefONOkgpZkL8_VivWpbYpTiqQ>
    <xmx:XpxXatN9YjANdFOtyk2gH0ZR1PGJeUrDb1bU3Yg015TCIsMu8qcPkA>
    <xmx:XpxXamZGSRmR7jNsU2B16LeL176N3x7-KTO2yVtCmdYeb6gjPYQoRQ>
    <xmx:X5xXat2doLTvRO0mweI3bsc5lqShZUy7ATv7v_iv3ssDSUPVKrRvvUNS>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 10:42:38 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org
Cc: usama.anjum@arm.com,
	peterx@redhat.com,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	david@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	zenghui.yu@linux.dev,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 1/2] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD holes
Date: Wed, 15 Jul 2026 15:42:33 +0100
Message-ID: <20260715144234.442721-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715144234.442721-1-kirill@shutemov.name>
References: <20260715144234.442721-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written, but
a range with no page table at all -- a PMD hole -- is skipped:
pagemap_scan_pte_hole() tests p->cur_vma_category, which never carries
PAGE_IS_WRITTEN, so the hole is neither reported nor (under
PM_SCAN_WP_MATCHING) armed.

In a uffd-wp VMA, WP_UNPOPULATED installs uffd-wp markers when protecting
a range, allocating page tables as needed, so an unpopulated slot is
treated as written -- see the pte_none() handling in
pagemap_page_category(). A missing marker therefore means the range was
zapped, e.g. via MADV_DONTNEED. This applies to anon and shmem VMAs.

An anonymous THP is write-protected in place as a huge PMD, so a
full-PMD MADV_DONTNEED clears it to pmd_none -- a hole with no page table
-- and pagemap_scan_pte_hole() misses it. For a MAP_PRIVATE|MAP_ANON
mapping MADV_DONTNEED has fill-with-zeros semantics, so a write-tracking
checkpoint/migration tool (e.g. CRIU) treats the range as unchanged and
keeps its previous contents; after restore or live migration the process
reads stale data instead of zeroes -- data corruption.

Report a hole in a non-hugetlb uffd-wp VMA as written, matching the
pte_none handling in pagemap_page_category(); the existing
PM_SCAN_WP_MATCHING path then arms it via uffd_wp_range().

hugetlb is excluded: pagemap_hugetlb_category() reports an empty hugetlb
entry (huge_pte_none) as not-written, unlike pagemap_page_category(),
which reports pte_none as written. pagemap_scan_pte_hole() fires for a
hugetlb slot only when it has no page table; keeping that not-written
matches how an allocated-but-empty hugetlb entry reads, so the hole and
the empty-entry cases agree within the VMA.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260707151349.92143-1-kirill@shutemov.name
Fixes: 2bad466cc9d9 ("mm/uffd: UFFD_FEATURE_WP_UNPOPULATED")
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-fable-5
---
 fs/proc/task_mmu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d45c729ab6bb..229d1fc3d7f1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3049,12 +3049,28 @@ static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
 {
 	struct pagemap_scan_private *p = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	unsigned long categories;
 	int ret, err;
 
-	if (!vma || !pagemap_scan_is_interesting_page(p->cur_vma_category, p))
+	if (!vma)
 		return 0;
 
-	ret = pagemap_scan_output(p->cur_vma_category, p, addr, &end);
+	/*
+	 * In a uffd-wp VMA an unpopulated range is treated as written:
+	 * uffd-wp registration populates page tables and installs markers
+	 * with WP_UNPOPULATED, so a missing marker means the range was
+	 * zapped. See the pte_none() handling in pagemap_page_category().
+	 *
+	 * hugetlb differs, see pagemap_hugetlb_category().
+	 */
+	categories = p->cur_vma_category;
+	if (userfaultfd_wp(vma) && !is_vm_hugetlb_page(vma))
+		categories |= PAGE_IS_WRITTEN;
+
+	if (!pagemap_scan_is_interesting_page(categories, p))
+		return 0;
+
+	ret = pagemap_scan_output(categories, p, addr, &end);
 	if (addr == end)
 		return ret;
 
-- 
2.54.0

