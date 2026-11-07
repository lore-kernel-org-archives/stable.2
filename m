Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087935;
	b=S45Vo6uXGBV/ttL3B+w1pdNM5NW7Y5GIjT2z3OrJ7fcYvpC55n2gmjOj5YzwcBMbZ3jH
	 02YGKo4V0d59WqXeCUbXu0+LDO9DKuAu62SpAlgc3cyi9JSAxPMR+sOHcqrc1AIm0pBJf
	 4pgVx+MpqXlsXPR78OdcYx2hMIvElkiQjPiaSMVhEO6EclE598Jg8fnu20QKE+b8z0QKw
	 MxK2tJtb4g8LZ7zboChBuJ1xAgvmsNxuxRUdETd1bnxJMisijhiRzonJ87kVo+3zCKFlU
	 XAYFvxBXye1SjWDvoGD03HzPDeoj5gfwEU6gWz3fajLjiZAw9o5CQQoOboGeZLxoMPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WPf2icVK/e9KPEuHFkG431PIxwdSKi/zxFeSHw01Gc8=;
	b=tiZ75oNAn5cVTo9Y3db9630mwwua0ZkPJLR1EMBp3kWSGGD2xAW66rfgap25RzZ3DlBp
	 HpZsivP3PrgQq5ki+oQXf683RtWH+4Lozm9sa9jY3ncaAj2ghBEedgHxkWhtokYN8CpBW
	 Ba5udaiRI/mQtqmbfTyf18v1Nyo0Dg09nRvnmnyC4zAzIBh84NmO5bDaETf3SkSqd648p
	 gW25PuS9qJ1l+5QrDIdUyRAjvBnJkXVWt6OaLGtUzAVBgrPFS8R14+v+OKd8xe2aeKE2F
	 2923ODpsW40KXri6oxjefU7zL7+2boEFe2wbkT6atyx0G4qir7V4qeKNTHkxlNVfmZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZKP33Cl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FE606A331;
	Sat,  7 Nov 2026 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZKP33Cl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01531F008A1;
	Sat,  7 Nov 2026 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794087935;
	bh=WPf2icVK/e9KPEuHFkG431PIxwdSKi/zxFeSHw01Gc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oZKP33ClNFoSGATo0q5PTPN25UDr1CaEy9FVsDI//fftn/U6S1OkqegWFde7R+wZ3
	 loW/lpUpE0rMV5fwDFFGtNzvdSoxyUXb9ddSvQ+q/1mkMsdUfbIyWK3W3ql66P/fJN
	 bwGEw+jGHG/RiR3ICsvqqK2IJz35FgjhfgJz+Ws+BAYaMBshWq9MFSivQc5hwcbqxA
	 0Rz1CC1HzXce9xlIeUzij/vABIwGyeWo33PV5GSKFw7I9J+JrLSTLiv6rDdlS5rkne
	 WUiGWRp1IzZHIqCYrkQx8EHjBoBG4iw/8IJc2uvBgM2jb0BN6jcZP5Bl6eIyOMLX1g
	 l7YOmN3YWjJ6w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.12.y 2/5] mm/damon/paddr: respect folio end for DAMOS actions except STAT
Date: Sat,  7 Nov 2026 13:45:21 -0800
Message-ID: <20261107214525.304638-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107214525.304638-1-sj@kernel.org>
References: <20261107214525.304638-1-sj@kernel.org>
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

A few functions for applying DAMOS actions including pageout, lru_[de]prio
and migrate_{hot,cold} in DAMON physical address space operation set
(paddr) collect folios of the given region by getting the folios of
region-internal addresses.  Then, those functions apply the action to the
collected folios at once.  The collection starts from the region start
address and advances the address by the size of the folio of the address
until it goes out of the region.  If the start address is in the middle of
a large folio, and if the next folios are small, some of the next folios
could be skipped.  Fix the issue by advancing the address to exactly the
start address of the next folio.

The user impact is that DAMOS action is applied to less than expected
amount of memory.  Given the best effort nature of DAMON, it is no big
problem, but it is clearly a bug that is better to be fixed.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260901131850.98037-4-sj@kernel.org
Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
Fixes: 3a06696305e7 ("mm/damon/ops: have damon_get_folio return folio even for tail pages")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org> # 6.15.x
(cherry picked from commit 1613ac9edf385c35f171a25610e2706a7e6afad6)
---
 mm/damon/paddr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index a6b1de97b1e8a..6bac269cd679e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -273,7 +273,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	if (install_young_filter)
@@ -306,7 +306,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	return applied * PAGE_SIZE;
@@ -483,7 +483,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 				folio_is_file_lru(folio));
 		list_add(&folio->lru, &folio_list);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
-- 
2.47.3
