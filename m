Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8F40D590
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937434; cv=none; b=TCFqqXqbUCjBkOALiJ+rbfb2fbBsDwKH+jiVwVTt42j7t3PSrzphUuHZMWEUbUCR204Nblz+MIwc1a8bNSnBUHHMEdheVywiX+kF3gpzzLU4IPf30+AJCgXmTDreaDnJzVYttc2UEXYTQYakZtQ/AxdsyjBfHuxViPmr8ohnYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937434; c=relaxed/simple;
	bh=0xmTlPsMG8HwTIBzsb8WyfEAk8CXKCUYUnskhAl5qBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEObjPYGnLA0H+1MvRkc7yxwWhd6vkIFKC5F+C5U7ulZynNw9ptPZECx1rmD8qTfVksg2vwN45yLH0Fb2K6oX62qQdYjMjgj6PMXI42Z5IkMBRL6uM/nF5aZb8jQWk3UdNSSeuyRpl2hgThGbvqL7DednjjJrl3wKu8LDRb7Va4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=UE8pkU1L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mOxaTQWQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="UE8pkU1L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mOxaTQWQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C47E27A0152;
	Wed,  5 Aug 2026 09:43:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 09:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937431; x=
	1786023831; bh=Mgfwv5z0Brlh3y6VSL8fs6pGUUOGwKT89l127VblliA=; b=U
	E8pkU1LksAJYLJJlGEyRjGXR/Oi0AhA4go+y8Nfj0PEfRJCDwrT0K7u3rFTBs+ck
	aHjvgTUqhohPO4r0B0DIz4lTYLBcnO+Jo1ubqpTjNd3WlSeCTh5aZgEg6f7lT48N
	TzLw/65BphFLH09kQbazmmFmFhbSm8kvm0V2ezfGQIbD5vFhhv3XcpI+38Uz7mH/
	J5ffZaqxaa5TTGf2uHD3yA6brz0aFvBhv4L1xXSen/anvrKqIyiwDohiI6coT/Vq
	sD8WvZZI7f0d+xhFFL9h+QQI/OR4x2FDiH/ArWSM/qEpQOU2M24eTJ5oqio7bFOm
	llOq6YUyQwNasVw8Paetg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937431; x=1786023831; bh=M
	gfwv5z0Brlh3y6VSL8fs6pGUUOGwKT89l127VblliA=; b=mOxaTQWQ9rBVDkB34
	w/+eAxYCpgZf48B9akOneGXUyDT5HvA+xUizOzpZpt7PkG17hI+pE2qvfLEBVIzQ
	N4qH/HDGyD+wm7cxkn1btNRtxxUwTBZSgyMcdIBaXYePnNFSz+2vqkd/RVuzENl+
	PUVQFR9D7Sc/AtUWlt1YAm74cFSHAj4R/YPligp5YxOUOaP5F3eipnfGlnvRgI3M
	efMSYh5NX30VKKV2I+TRo+vZRAD58qN/v9Zd3e2e+HbG1K28dD1rjPnuq2z9Ok6y
	FNsbrb3xlRnJdWxrEcogtsmIrxyEH/idDhMKdHt36fymQ98uDGVFnsAS0aU/11cN
	E2NyA==
X-ME-Sender: <xms:Fz5zauukv9UUeDNClGcRKId4rbe0v36UiJyhIhxC6q3yn3jDUisd_Q>
    <xme:Fz5zav3ZSETwxHza4RMDzrguenJH9aMnE3TkAd8TcLGJVIIMldQpS_dqXWCd3CJuj
    14_aZbopIMx3fPIOHsM4nZXNNMHVACnemVe4-dMiCN8NyOKhF13sqg>
X-ME-Received: <xmr:Fz5zauOv1SRY5auDUKqg79Lw_-YVH224zBn0lkf0o5vVAcuA2lvE3HH9hjA>
X-ME-Proxy-Cause: dmFkZTFu7qtgJ94GvBO56d5NB9i9RxY+vT76bN+VdHOM6ACSSVXkdli2AUWlJPI7ZTliqo
    FWLlpbne/YuV75c2Pg4lxAIwDq3h/XuUMFDy93k0ybaA13N1rAGTiIejKH2yi7AMgsTcig
    yjOghgxkIfoPHfnODZnYUz4SIt457YDBUylJ/L8S4LIC4ZlEO8rD74mEB908/JFQ/qmMdK
    a4XkfXLOugWT9D0c9ZU6SrhUS6IkxhibSLhvvh2EDPJmlcPyLQqgnldRy6yjmeH/YZoej7
    j50uCiMow1NHmic8I3ZiKr4oTGPaPszYtGSBMkqJ0aci5zth7LupxsFWer9WHpOb6u86e+
    klAmIedPVOK8sC51kKg8LYjp48Jo91BPNhgZxccwk1OzlxcPOOfF/LKi4iluJA3VJ25QBc
    +5reUMyNTcaaVBybfhjylgBpN5liyrqHnXCFE9uM27zOL+gtFEJZ2TyVll6Rdls4Byc1oV
    tKwtELHWP4sBFyXJ5YrRSbxrC1PA/9ecAfnaFIyNIjL2ezpSOYyoUiyjywBF0D/LCbNVpz
    uMRjtNQFoV8X7H8dyTIAVPUahHMuAH56YyBxHCmMtuLERZ4AASeKcXKGt+n5OxqjgeaiA3
    fsre15F0RnNRIBObryGIwHIoQrOCLuvTBOoOpL015MiI1ag5VVqDp6bxvQTw
X-ME-Proxy: <xmx:Fz5zanXqejG_5jqEHPoqHgP6cFSp2s58qbot3gV3uMjQUbcXATZuxw>
    <xmx:Fz5zaraRncasvI9MgJ0izBdwLPcwyaNcZqM3meRvaJPz18ZlT0oNcg>
    <xmx:Fz5zap2yL2UF8EQR95LU9Xk2GGjDsw6PjBX0q-l3-bYCykyZXUVrpg>
    <xmx:Fz5zavAfr1IC25ZhbYSv3wiPUVYo8bQhqogW5RxvOHiBTqC2VbHc_Q>
    <xmx:Fz5zalP4hx2EE5YZqx94aHeCQLFzL8jPPR_zYj30-zolxpKXo1Zi4SZ6>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:43:50 -0400 (EDT)
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
Subject: [PATCH 6.12.y] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for unpopulated ptes
Date: Wed,  5 Aug 2026 14:43:49 +0100
Message-ID: <20260805134349.2776535-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080504-lagged-gutless-4701@gregkh>
References: <2026080504-lagged-gutless-4701@gregkh>
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
[ kas: fix only; selftest hunk dropped (pagemap_ioctl.c differs on this tree) ]

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/proc/task_mmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fb01a071b83d..a245330abebd 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2097,6 +2097,19 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
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

