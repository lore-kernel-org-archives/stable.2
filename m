Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397158;
	b=35i8jUjmlCVR9nHkXO/GU0HfpNMz+Vv3yfPnAOSJNu4HAmQGMUPTl39I44sGsk2HrsOn
	 ub2JM6Zah8h6UiI6cPSevfFC/QIHEp/NtV1a/fxNE7ZS2aIrp26QxdHr3Yygwm9fW4FeS
	 lViz4WZQMsqOAo6PwyGqDu48GX/ujNWFeidx4taudeUGY9jFQ1o+9dbg+uac7RC4xvwwQ
	 TDqcS1XatavGEf/yDpBr2OpWNDvbopJP46stbvFhH+mQxr30aSFWHDbf8/lswULrV/Z6/
	 q+tPQO8l8NSgFqKmRwNlHRytIVzZjZKcBH42h1C56iL5TUKQ+VoNk2dwVioEJ19UmNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397158;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JsSfYSFniRGmuPRfq48u5DDdTpeJF4QuAl3fe5dik5M=;
	b=qGRHQgWXksPo8rYkzJ40HSNdJqvdaGDXx3+W5jFEW8GOTgk9hiCdSOY2GXW44RptUq6b
	 kST9xBvn7oT+xvLeXlmFvtl4YMzwyxpwQ5FrAUoaFpg8iozg1Dzto6pKY6Em4qSjkFCRW
	 N2/KZbpEftZjeVE922VVjY2mIn5fWEmZf6kDMi1hzv5ONEQhZNP/nI0XkD+YLxQujivav
	 q2SreN6u7CA0Xy5wEJOGQN0MtXAgOLqHPnPodlsaEFNVM21qoTCadcEISvT9zl/7/M8Iw
	 1dTa1L7e5nSU29ODFlNtRtdJAdFgwWCXniDNceSGyLgQ2M5J5Psfpf6rAJBycj3FQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O7UvWw6D;
	arc=none smtp.remote-ip=91.218.175.146
Received: from mta0.migadu.com (out-146.mta0.migadu.com [91.218.175.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF58606A33D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF58606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O7UvWw6D
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zdZjBwRCrc/bJJQOamLttRr417Z2hw8mLNGL8JIUru8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794397156; v=1; x=1795001956;
 b=O7UvWw6DTIle1OGgNxQFMYG7hepijbTb6ERfRfSS5opxNxPUNoALMR57ZqMwxeWPXjU/2TcL
 d5lHg8gMznxqBQ7sVYZ5wcrU9YEz5a7c5OtjzW3+aKxDYzlHL0TfyA1MmkEND2mSznUtlVZrvne
 8gKn8dvxGTeZ3CBePG5C4EMs=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 780683f44d9afa50;
	Wed, 11 Nov 2026 11:39:15 +0000
X-Mizu-Trace-ID: 780683f44d9afa50
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
Subject: [PATCH 1/3] mm: don't PTE-batch a swap-in over a hardware-poisoned subpage
Date: Wed, 11 Nov 2026 03:38:29 -0800
Message-ID: <20261111113904.650722-2-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111113904.650722-1-usama.arif@linux.dev>
References: <20261111113904.650722-1-usama.arif@linux.dev>
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

do_swap_page() checks PageHWPoison() on the faulting page, but the
large-folio batching path then maps the rest of the folio without looking
at the other subpages. A poisoned subpage that is not the one being
faulted gets mapped anyway, and the fault that would have reported it
never happens.

Skip batching for such a folio and let each page take its own fault,
where the existing check catches it.

Scan the subpages rather than testing the folio-level PG_has_hwpoisoned:
memory_failure() sets PageHWPoison() on the subpage first and only sets
the folio flag much later, and the bail-outs in between - for example
get_hwpoison_page() losing a page lifecycle race - return with the
subpage marked and the folio flag never set.

Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/internal.h | 15 +++++++++++++++
 mm/memory.c   |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index cd3675c044e0a..e61c02f4019b0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -28,6 +28,21 @@ struct folio_batch;
 int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 
+/*
+ * Check every page of the folio for HWPoison, rather than relying on the
+ * folio-level PG_has_hwpoisoned, which memory_failure() can leave clear.
+ */
+static inline bool folio_has_any_hwpoisoned_page(const struct folio *folio)
+{
+	long nr = folio_nr_pages(folio);
+	long i;
+
+	for (i = 0; i < nr; i++)
+		if (PageHWPoison(folio_page(folio, i)))
+			return true;
+	return false;
+}
+
 /* mm/workingset.c */
 bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 			    bool flush);
diff --git a/mm/memory.c b/mm/memory.c
index d477a4f986bc8..4b7d456332200 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5158,6 +5158,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
 			goto check_folio;
 
+		/* Let a poisoned subpage take its own fault. */
+		if (folio_has_any_hwpoisoned_page(folio))
+			goto check_folio;
+
 		page_idx = idx;
 		address = folio_start;
 		ptep = folio_ptep;
-- 
2.53.0-Meta

