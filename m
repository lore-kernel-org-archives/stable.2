Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357200;
	b=PHmFI6W/irg5lse/krPycf2Y7mlG0p7qGw/YNsajrzLSbpJqhmQ7OxoaGrEboPnLQdiz
	 M8qDJ6ZB4P/5omKkezbvd0eZrnGRujYdvk2jZCa225PSIFPDYG5PD/B4Kh4Bi4eho4qXK
	 3d70I5Jrnt3i022anOpRgbbCXBJN53gOqqBHLDXk9u/68LYp0NoZvcDyIwNpWD696M9LE
	 u0cFLnNSnMNprvXnYqsCEEnZJ8UyHnoNd1DjYt6Teh8Psh8xmSs7nYE905+bw1yAC6Iq2
	 njiEcmY3sY/y+2azojdjcE8uAhDe4ffUeLXGDOT6wRm6aKmyY4zDbsHDYD+GdBOut7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5ejJedGb4c2HWFJx8OCG6dQjAPGEQ6uVcNvGD7Rkeho=;
	b=lVbgYMHIFddGy7+7a/7sKfoX3TKvkZ0LmzV/guwo+RR/4Y0jpTH208F6t8YLp93kdEF6
	 FtT0Ae3Gm9oYdy+R1laOS6Wyrrca0wtHFAz/FoCD8OYlCeWS6Xx7Pre7Eq/IfwkuoBDcT
	 U3BQSuEwPfTs+lDF0GwnCdv2t1WWy3Yhavx+pJk1tPN6hRG8H8PTKGAnDVmoI7Yvn5TOP
	 P8aIQYeNTl8zgDJ0pj4BrDMfHQBfKO6nGRjvGHMT9Lqqm8wErxmxgvncwa9u7JeJ0XvEb
	 kuucajFZoILqwM03LupliEsZF2/mngyheRyouMSYR4WNOMjoqFEfloUjQtQIlyHNQNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2w4x+Ay;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03F606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2w4x+Ay
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DAD1F00A06;
	Wed, 11 Nov 2026 00:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357200;
	bh=5ejJedGb4c2HWFJx8OCG6dQjAPGEQ6uVcNvGD7Rkeho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2w4x+AyThF8dlhLbdC9ZMQPxj6poIbdJ3lQLS57UB9aUmv2WYCdAf9r2qvXgD8Qk
	 Gwa5HEYcAYepk5L+V3KpabGhB26NCIhFNm9vtDmLqEfxoy0ru9U5eMBSyV+Km5p3VI
	 jZ59Ay8K+orDhnd92GFpN+ATxiJBYTUHSCehrV8bxlV8hkmmmbGq0bw72hxwFtvFtJ
	 J1xGJElw8oTF6wCJtSnpLsAUby+OEWaAc/79ehGM67uvJXth+Pc8JSN8I5YVgozRSD
	 CmMZ75CQYXaaTu9kT/hCQYd8qVT7e+WKjxjmoyHixI15JBvK4xWSc6LfE7fcOfO0FC
	 0FT2AySjsj15w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbirs@nvidia.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Byungchul Park <byungchul@sk.com>,
	Dev Jain <dev.jain@arm.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] mm/mempolicy: skip zone device folios when queueing folios
Date: Tue, 10 Nov 2026 19:33:13 -0500
Message-ID: <20261111003308.271305-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111003308.271305-1-sashal@kernel.org>
References: <20261107050938-failed-6.18-9057170a941f@kernel.org>
 <20261111003308.271305-1-sashal@kernel.org>
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

From: Gregory Price <gourry@gourry.net>

[ Upstream commit 1f834ba9b42e3f3c298c7e8ef1df21b9947c92b4 ]

queue_folios_pte_range() already pairs vm_normal_folio() with an explicit
folio_is_zone_device() check before adding folios to the migration
pagelist.

vm_normal_folio() alone does not reject zone device memory (a present
device-coherent page in a normal VMA is returned as "normal").

Mirror the explicit check in queue_folios_pmd() as well.

queue_folios_pmd() uses pmd_folio() directly and can encounter a present
zone device PMD - e.g. a device-coherent THP.

This is not filtered by existing checks:
  !pmd_present()   - only rejects non-present device-private and
                     migration entries

  vma_migratable() - excludes DAX and VM_PFNMAP.

The early return also means such a folio is no longer counted in
qp->nr_failed under MPOL_MF_STRICT.  This is the same pattern used by
queue_folios_pte_range() (skipping zone device without failing).

Link: https://lore.kernel.org/20260817220810.1175596-4-gourry@gourry.net
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Tested-by: Lance Yang <lance.yang@linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Stable-dep-of: 9057170a941f ("mm/mempolicy: use vm_normal_folio_pmd() in queue_folios_pmd()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempolicy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index adc52341c97cf..a6ee9526dc25e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -658,6 +658,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 		return;
 	}
 	folio = pmd_folio(pmdval);
+	if (folio_is_zone_device(folio))
+		return;
 	if (is_huge_zero_folio(folio)) {
 		walk->action = ACTION_CONTINUE;
 		return;
-- 
2.53.0

