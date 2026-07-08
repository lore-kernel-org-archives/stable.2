Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4B43C7BC
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513256; cv=none; b=fZ67I1UhuLqVy8a9fxaee1pmEjC541fLs4W6ngK0biU8KK7Qc9La8EroUrCZ/YDyPA26lUkgd9f2QmztCc8jlfTHW4XOTOYFWAfjFnAExTg4RVgWkIfl4rah0NHq2P4N9GjekUKpfaw1FNdEpkviWNFQ831Pr2xXgNy7qp6HIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513256; c=relaxed/simple;
	bh=Wc2fyKWQGbPIlOiW6rC7gNOssOxY/9XvX7eni+gRYm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SANiuLo45bfuNv5b4jvZNkrc3jtuGADT9wGtnqW+YLZ7lv/nE+dwLjBXuOryWEhqnbDKgRLV2icQ21567sSHxw+Bs/W6nBUg81u+9C9bS3/Tm3fGREoM+oEX7Z90Lppej/b3e4UhbiB78OPORaZWnFuGhF1QLCfpKp8h1kaLpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=klKLKaKp; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="klKLKaKp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783513252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLR4NTdd81YwHMva27KFRdPfSNha1yNVphS6scVIA8Y=;
	b=klKLKaKplweSEQGqTSBhvVQKqIE/wZDOFqmqFojo/YESsUhqb8YNMex/lxIBX+G7/lD9SD
	W+K/4Kz5m9z+IKgKIIJx+u11F0X5XEv5iPIIfBDd64Z0U01DH7+k0MRgMmT21SDLSipEYD
	TTmx4fKshMqLGdALX4PfGjY6QRogNLU=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	balbirs@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	npache@redhat.com,
	rakie.kim@sk.com,
	ryan.roberts@arm.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org
Cc: sashiko-bot <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/mempolicy: skip non-present PMDs when queueing folios
Date: Wed,  8 Jul 2026 05:20:07 -0700
Message-ID: <20260708122040.861335-2-usama.arif@linux.dev>
In-Reply-To: <20260708122040.861335-1-usama.arif@linux.dev>
References: <20260708122040.861335-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

queue_folios_pmd() is called under pmd_trans_huge_lock(), whose
pmd_is_huge() check returns true for any non-present, non-none PMD
softleaf. Passing such a PMD to pmd_folio() treats the softleaf encoding
as a hardware PFN and can return a bogus folio pointer.

Mirror queue_folios_pte_range(): handle non-present entries before
looking up a folio. Keep migration entries counted as failures, but skip
other non-present PMDs such as device-private entries.

Potential trigger: an HMM-based GPU driver migrates an anonymous THP
folio to device memory via migrate_vma_pages(), leaving a device-private
PMD. Userspace then calls mbind(), migrate_pages() or
set_mempolicy_home_node() on that range.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=6
Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: <stable@vger.kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/mempolicy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 914f81863db5..4785b55c02da 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -654,12 +654,14 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 {
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
+	pmd_t pmdval = *pmd;
 
-	if (unlikely(pmd_is_migration_entry(*pmd))) {
-		qp->nr_failed++;
+	if (unlikely(!pmd_present(pmdval))) {
+		if (pmd_is_migration_entry(pmdval))
+			qp->nr_failed++;
 		return;
 	}
-	folio = pmd_folio(*pmd);
+	folio = pmd_folio(pmdval);
 	if (is_huge_zero_folio(folio)) {
 		walk->action = ACTION_CONTINUE;
 		return;
-- 
2.53.0-Meta

