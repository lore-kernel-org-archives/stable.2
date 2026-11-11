Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357198;
	b=V2IkfI+IyPiWLwacbBshBJTdeoN1bkNZQ8ycXad/lBWFSdM0Yes6NdjJJ/jdFkYpHgqn
	 vO/n+B7os+CVLQF+kceWJ1kzZmfbMysGw5i47Bfj5m9kRu06m7617bErYPP060NtcZtnJ
	 xg8cJCL6dXHZcybkza6pxDZ7/4A+nSEyHJYXt2Q8jqKfVky2bsm9IR8AUgM1+HoO/+7Mb
	 wjx1OOSft9UZLC9+PHowgZ7UJH8Ks8JrXmKRcvR0e2fT/v8YCg/FjZK8PUdFh1cpFITMN
	 2cInJqB4WOv4AkGH9ibi/epTaNYQvjqmMN+iC8MOti0yJfFXLfiH56Z0NaSghr+8N9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357198;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QohPPlAGfu016FwPlR95b/xS0RQTMVipfNxGG9JDiPM=;
	b=wb32dpCjRHwHQqHhlwj47CYrbGpB9xU23UChlQBn8j7NdFUahVbI1nOITNPPL0jvD9vJ
	 DWQe9VNBXkSeOXx58dBdZg5CBIwov3gS7eBEYyJgW8G9DqZHBXKGuRZhhG3aMc+MbD7yB
	 TVn0n9+jAUbJm4+zRHs0oXPQ0aAzW500T6q2oPFxjf8OHlFKDD05vNA2rPKM1wXr5mb5I
	 Y0b3n7C5c7rJd0ciy1ufHxMzIio0Ugl5dLEsrEsepnQV0+VfLbMRi8GjCepzvpAgvJBy8
	 RTBiDdjSwql5Qijv9FRpHn8x2nIWo2lnf7KHCf/Xb/lzH3TsbcY6pF3Acr97cVYT1JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM+WRYRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6CA606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM+WRYRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2091F0089F;
	Wed, 11 Nov 2026 00:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357198;
	bh=QohPPlAGfu016FwPlR95b/xS0RQTMVipfNxGG9JDiPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AM+WRYRm07wWUE1Lgu7Vr0RcHD5ko1+TzHeU8eawN9QSqOjgAU7iaw1doSfF9n32O
	 T2whqslB0OnmoQHNd3+wzl+tb1z0y+ZSCGRssZSk8/wllf92un6YW5yRMq9lJaw5jx
	 oOqoC9slQcFOMMH6bC7YU2a2XtfmZLx27nL1aJcNY+ayCRuY3O5aanLnzuHZ3GHa1Y
	 wqQb/+a+PJTpCPcreQU/YyXx2HGMVgoMfX0sKFVUK+dbfEk9pQwJ7+G7W8sFWLF0v/
	 IBY2H+jceh4r7/jPYb27XMxx3CnNu6BlR+yeX3+9tzsJNPvwL448qjuRUJy7ts7HfB
	 KCCuP0pX8fMqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Usama Arif <usama.arif@linux.dev>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Byungchul Park <byungchul@sk.com>,
	Dev Jain <dev.jain@arm.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Nico Pache <npache@redhat.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] mm/mempolicy: skip non-present PMDs when queueing folios
Date: Tue, 10 Nov 2026 19:33:12 -0500
Message-ID: <20261111003308.271305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050938-failed-6.18-9057170a941f@kernel.org>
References: <20261107050938-failed-6.18-9057170a941f@kernel.org>
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

From: Usama Arif <usama.arif@linux.dev>

[ Upstream commit 2858b4027f491e6fdb8ee2d8923798b619bf2791 ]

Patch series "mm: handle device-private PMDs in walk callbacks", v3.

Since commit 368076f52ebe ("mm/huge_memory: add device-private THP support
to PMD operations") a PMD may hold a device-private swap entry whenever an
HMM-based GPU driver migrates an anonymous THP folio to device memory via
migrate_vma_pages().

pmd_trans_huge_lock() succeeds for such PMDs (pmd_is_huge() returns true
for any non-present, non-none huge PMD), so several MM walk callbacks that
used to assume present THP or migration entry are now reachable with a
device-private PMD.  The results range from a VM_BUG_ON() firing on debug
kernels, to an oops on a bogus vmemmap dereference, to silently isolating
an unrelated live folio from LRU in the aliasing case.

This patch (of 3):

queue_folios_pmd() is called under pmd_trans_huge_lock(), whose
pmd_is_huge() check returns true for any non-present, non-none PMD
softleaf.  Passing such a PMD to pmd_folio() treats the softleaf encoding
as a hardware PFN and can return a bogus folio pointer.

Mirror queue_folios_pte_range(): handle non-present entries before looking
up a folio.  Keep migration entries counted as failures, but skip other
non-present PMDs such as device-private entries.

Potential trigger: an HMM-based GPU driver migrates an anonymous THP folio
to device memory via migrate_vma_pages(), leaving a device-private PMD.
Userspace then calls mbind(), migrate_pages() or set_mempolicy_home_node()
on that range.

Link: https://lore.kernel.org/20260710105557.1987433-1-usama.arif@linux.dev
Link: https://lore.kernel.org/20260710105557.1987433-2-usama.arif@linux.dev
Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=6
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jann Horn <jannh@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 9057170a941f ("mm/mempolicy: use vm_normal_folio_pmd() in queue_folios_pmd()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempolicy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3dfd20b55a9d7..adc52341c97cf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -650,12 +650,14 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 {
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
+	pmd_t pmdval = pmdp_get(pmd);
 
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
2.53.0

