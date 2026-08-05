Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D340D590
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937437; cv=none; b=dV9vWEDh3ddEl5x9PNh15nfzwwk5PWGG1HuBsy9CV2h3J4t0OVQZwroJ6sqExKppWh2rRtqrz/FK9/28ALwcdUvW+a8jg4S1DgEO3oEev2BC5pi6OE5KP0QLNH8IY/OzForSu9VgPiUk0I6YpkBRvRQV2pTEPyYZxNOBWuyBRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937437; c=relaxed/simple;
	bh=m3BWMPAV6leAvjuiffG77WgDEYhP5Yhegi3Y5PEWxv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktfaupaLZYG48aq/Jm+7lxv71you6KdeFjAFwf6wZxCVTkwtTNttWsf5MEVJbjXq6DpN23va4XmdHaXCitMpEaXtg8gylbzYA5m1v5epaH/Km7Bf6V4+xG1Oq/F/b+laKDPgJ1uAQnneRVku4BFrVGCv7NdrEiPOGn5xL3FgAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=DmlklAZX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q24wxh3q; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="DmlklAZX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q24wxh3q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAE187A013F;
	Wed,  5 Aug 2026 09:43:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 09:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937434; x=
	1786023834; bh=sjSr/u6EAIPKA/2hljOHFGZwEyedxk31Dr0PD3SQC8M=; b=D
	mlklAZXOIOW/iBsFlKVo28xV3KaSN88zPAnUeE04JEqumP7fv5qFSSGMKtqJ6ZTs
	XEidxo9HjEZv8Nj+s0k3ExDPYDpSbo4k52ea4EfmYfvolWTgMad79ihFgn4AXVQh
	xO9J56NmnW8152CSvR+K6mjEWcvSPNewZaaXxK2fAGyi5bUod/UpoX3droP2GkXp
	Fm+vNsWIPlSnxUXYiCZqODjbauCv21Dqt53c0dnismHK5+U6Wj6P8Gtv20pYTAH4
	d0fMrDy9bwF6AwfDqKfPZ5T9e62AkzYzWUqwDojwIx90yivsS1W45DiTNrcAFO9X
	s5kv3wmufhBQm37gqJSnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937434; x=1786023834; bh=s
	jSr/u6EAIPKA/2hljOHFGZwEyedxk31Dr0PD3SQC8M=; b=Q24wxh3qiIioJyUCi
	u3qacykwsG6hpO3gJ0KzKkg25HVXcAY2zazI9o82kncJZ/WJr87TynW8ZYNSltYY
	BgijQT5AS8IvSYPP4yv7Z64nF2ZneQo+SyekEMUy0u8b0/ailHew+cbI25DDQxar
	pisepDqJlIsSsHV8xQhPyCX+hvUwgU52HggO+ucCRL8aBYgHg4eIJBeW4uydpbny
	hCbmh6o1LdP1mHcSJPd1CeiRR3TKwNN7EOmnZn1MyrT7Do6CQQ2ZEuZA+v8Y2R3L
	4e0gqBaFGJO2SNTTxCP7m5Tz2DNHNDSSPZLeLQtBpUkS4s0U0yJXPSdbQhmZflud
	Y82AA==
X-ME-Sender: <xms:Gj5zahh_3y-rxsKrY9ttZpkt4MX-_pRa62-Tkwf41GQmlTnujmOQSA>
    <xme:Gj5zaiYtWWlcdPmXx67ake0G6JnaBbN_QIA2l2eFGyRbrYx_1bLcttMO9EwetB6Wn
    IPMq-edOslmrYi8_h9aIbd66M-ExNzasyI00hPr7PTuiga0k73g0rSR>
X-ME-Received: <xmr:Gj5zaljuS89WYhWavA9W3DFnRRV0Et7-FO2oBOFQGiJj7po-C-Y8B3iNTvE>
X-ME-Proxy-Cause: dmFkZTG3OLJt0p9WL4NppxfoxRH8UUnETj2iaMz3+UuH1tkyjRW4ikhVvQ2gyhqCEBC6Bc
    sYWoSFljbpTgfkb+cAi9v0fLGHUtrMP2m7fRNyMV35Rd6xhBvI7CugOXDJ9vUmLcgE3t3S
    aSikudwY093ezmGJ1A6l6wZEsskmQxsazbLRFB3rrKqTkf7NwxixVKnYkH9F8MGPVORjLx
    6EyvDYKf/ylKz9vuSbjhDWhRhHLyPUGCeRPVaUeDs+0GeN1zpA6fmd4IE9I7H6C16JfKva
    ujX7qyWCNRrpnHbQdQ2U4w/I147GlAeuhheBXLHyFUQ8n/mjPbokc7aU1ynPQ8Ri0w0PLh
    XcGAjjVFoQZd/l5aYMTK/IwMekVHohcvtY8f1QjGTQ6BL2R5XuAt/diGWYpVMGMaHHwYZd
    v3RihmAqKjJUPy6CNa/4ISBahloHwkneja9DidogB5s2F8IS0nyU+/6sHehtJCHfqYaB1w
    J5X3Xczlq+fRpweW4wv7V6roowLu9TOWB44twSNajNydt9F3vhrH/fthl4trjSHKpbxzZ3
    cciXKwSep5EfdBl8iaYC7VjZwMW3SHM25GYPJvyixqArb5bqQmoIWN0dlSTShU7kVG+0i7
    HVkwFJQGjTIq4h3Ogi4UMbcF3iU7RlNK3bwzdpK56mQQQdvpz9RAEneOWdIQ
X-ME-Proxy: <xmx:Gj5zakagzAtDTfHJiNVUaB1SJNARc4iI8qRNsshWa4Oc3jp_wf6A1A>
    <xmx:Gj5zarPBbf8iCSnMGJwshvRWIgRBYucxjONVb9vxWuQWkkepFV5ZzA>
    <xmx:Gj5zalZvLUT_XUiisFYj3JpzzKrArKEvaYSkPtInsF6whLSltz9ABw>
    <xmx:Gj5zarWw0qTZrQdK2ZM_XygpPHVL-y8pAWT_PcIoWeABodFuX3TbMQ>
    <xmx:Gj5zanvwaN7kB0g7F9lm5Fmxe2YWiW068L9Ko3-DsGeTii71eDRpeBhE>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:43:54 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	David Hildenbrand <david@kernel.org>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for unpopulated ptes
Date: Wed,  5 Aug 2026 14:43:52 +0100
Message-ID: <20260805134352.2776545-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080503-unpaired-outclass-9b75@gregkh>
References: <2026080503-unpaired-outclass-9b75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

PAGEMAP_SCAN reports an unpopulated pte differently depending on which
path serves the request.  The PAGE_IS_WRITTEN fast path in
pagemap_scan_pmd_entry() reports a pte_none as written (and, under
PM_SCAN_WP_MATCHING, arms a marker); pagemap_page_category() returns 0 for
the same pte_none.  A request that cannot take the fast path (an extra
category bit, category_anyof_mask or category_inverted) therefore reports
the pte as clean and skips arming it.

A range that was populated and then MADV_DONTNEED'd reads as written via
one mask and clean via another, and in the latter case is not re-armed for
the next round -- an incremental-dump consumer (e.g.  CRIU) using a richer
mask drops the zapped range and stops tracking writes to it.

Report pte_none as written in pagemap_page_category() too.  A pte_none
carries no uffd-wp marker, i.e.  it is not write-protected -- the same
condition under which the present and swap cases already report
PAGE_IS_WRITTEN.  The fast path applies no VMA test, so neither does this.

The hugetlb and fully-unpopulated-PMD (no page table) scans have no
PAGE_IS_WRITTEN fast path, so they do not exhibit the per-entry divergence
and are left unchanged.

Add a pagemap_ioctl selftest that populates a range, drops it with
MADV_DONTNEED, and checks that the fast path and the generic
(category_anyof_mask) path both report every page written.

Link: https://lore.kernel.org/20260707151349.92143-1-kirill@shutemov.name
Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Assisted-by: Claude:claude-fable-5
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 07b4377bdbe74a3ec0c8da5849d014f70e003384)
[ kas: fix only; selftest hunk dropped (pagemap_ioctl.c differs on this tree). Add the pte_none early-return before the pte_present branch ]

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/proc/task_mmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4c5adfd4fc1f..22cf6620133e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2326,6 +2326,19 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 {
 	unsigned long categories = 0;
 
+	if (pte_none(pte)) {
+		/*
+		 * An unpopulated pte carries no uffd-wp marker, i.e. it is not
+		 * write-protected, the same condition under which the present
+		 * and swap cases below report PAGE_IS_WRITTEN. Report it here
+		 * too so this generic path agrees with the PAGE_IS_WRITTEN fast
+		 * path in pagemap_scan_pmd_entry(), which reports pte_none as
+		 * written and, under PM_SCAN_WP_MATCHING, arms a marker. The
+		 * fast path applies no VMA test, so neither does this.
+		 */
+		return PAGE_IS_WRITTEN;
+	}
+
 	if (pte_present(pte)) {
 		struct page *page;
 
-- 
2.54.0

