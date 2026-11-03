Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692896;
	b=5jWFdKmv3V6P0mVYBgXoQeSsJmeEQy/OHli2K7F0rYVbD+q03LnuYfAfLvahGkTfBxdC
	 S/LlRDmgUfxm/uxPMJG7pLauvIWutgep0Rjo9eKSFQ0cjtKUoFX0bZJ9afjBNyL1KDI+z
	 9efAOaI9t0qQws8zBBG3I+Jvi6U2WcKjTjtrI7mBGX+IMIpANqPN47YWJX63aL9GzdbX8
	 fq2/kNjSTL9dGyG462g58cCFi+oPwMW8BgVQACFshn9vqzsZSjQ+Vhl8Z1Jv3VOzWcqbL
	 l4T6LoIXFoxrcohOoWnnSUshoZXkhaQ9KeoUTYn/crN5vU4Yl8mwOFGoMbMv2zzqA0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692896;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4EgA5xkJyAmBnEfHDvfxKLGqQoQIa9SsFw2zzB/YR1U=;
	b=5fJ3mjbbNpvhG9vvPm7iQx/tJfGLwoJT64iyKUZggxXiHxi8wdPs8oFr1im7/YhD4+sV
	 PP9RwMmQlCW8OrMGItmT9xiurZZoL3UJccJfEI4Vo7q26YIvDb+ZDJhFJ6rwcl/znOAmh
	 1grGGKJj1dyoqnjIWAfW1jezNpgpUM/HRkTLuzBLBNexF/MCMeq30rfa9rH3iDq34Nobr
	 rxgJZ6PJn/mWyUPro6/cc2B7r/+mRGf8/ht4fwHR3Ep0fh9Lt91WJBLEciImPwTtY+zK4
	 2u7OwUPGL+dVbfAa+n5AoJ2Os344bU5J8HvCL7/MvUVbPLigBH6hDldwetSdk2BF7MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jQ1mEG8I;
	arc=none smtp.remote-ip=91.218.175.107
Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE055606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE055606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jQ1mEG8I
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C2H3ojY+P3grZeC40yIYdvddeGt1gzpz1d1fTn5CZ9Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793692892; v=1; x=1794297692;
 b=jQ1mEG8IJtNHSeOiU3fvwCnyj7oLCu4Oiiq8NLzYDXxiQhsXGxpdHLUpAWXMJePF0rge4FeF
 4SPy+iUqqH8AyGrA7aLv9mIjpz2XbZ4h5Kpx3SJblVQWlQTA0WKDWe4tSZWq/XE58izSXAUDMQN
 ZP/E4/peV+8cBNyj4k49vOl8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c6f696fc8136050f;
	Tue, 03 Nov 2026 08:01:32 +0000
X-Mizu-Trace-ID: c6f696fc8136050f
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] mm: hugetlb: skip CMA when direct reclaim is disallowed
Date: Tue,  3 Nov 2026 16:01:06 +0800
Message-ID: <325d33655f29a2799a0859c788c48625feeb85f1.1793692578.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793692578.git.zhengqi.arch@bytedance.com>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

Switching HugeTLB CMA allocation from cma_alloc_folio() to
cma_alloc_frozen_compound() stopped forwarding the caller's GFP mask.
The new helper uses GFP_KERNEL, re-enabling direct reclaim even when
the caller explicitly disabled it.

The first MPOL_PREFERRED_MANY allocation attempt clears
__GFP_DIRECT_RECLAIM to try the preferred nodes before falling back to
other nodes. For gigantic surplus pages, the CMA path can therefore
enter direct reclaim while allocating migration targets during this
attempt.

Skip HugeTLB CMA allocation when direct reclaim is disallowed.

Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/hugetlb_cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index dde1c866406fb..90f8d718a1f16 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -59,7 +59,7 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 	const nodemask_t *nmask;
 	unsigned int cpuset_mems_cookie;
 
-	if (!hugetlb_cma_size)
+	if (!hugetlb_cma_size || !gfpflags_allow_blocking(gfp_mask))
 		return NULL;
 
 	if (current->flags & PF_MEMALLOC_PIN)
-- 
2.54.0

