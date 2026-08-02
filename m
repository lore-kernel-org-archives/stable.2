Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A83BD657;
	Sun,  2 Aug 2026 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688003; cv=none; b=QngXtv2ZJUX1TFTuem1W60UH7EYkEWIgcXqG2YNrqwSKp9WmMoX0aTdunwM7yLn7tA4X45Bbp2A2Xd6Lx3H+QpdU/7ddz9AlDluu/o4vT9likhgDyEXnPPs1gcYZxL2BLTdACEJsNGSyM+7sspzXcfQlFs4bVll34y/o5HUXNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688003; c=relaxed/simple;
	bh=3tuXFYxnY5whCfMb9BBfKAgRQ7zxuSBaL+SQQ8TayGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD/4knNdhWqAXAMOOgI2PTO6jN1SKKCHRB7TD+au5jyWBaP2Gvp4K5+VRhx70cCR32d1IkhZwOy5WVdm1jLqA78bqJGFoJgVna2f9DFLPHCF0bEteQlpsHtvcl/tQnJxgaBt5qDT7oKrZnKbFxcNc7AmMUbdXgHpLmSk2ZF5i0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0eYjzrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0eYjzrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951841F00AC4;
	Sun,  2 Aug 2026 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688001;
	bh=l4DJBfV8Ln2wiu4MTHaklCvhtPpo+9nKnYvuVasq3nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L0eYjzrxKQgFu++2Z1fBClKpatsUoHdYaOJZBYub+Nw5sxEri0fzDzGtBDsgDsKWg
	 s54N8ydwKySGmQlCi8y6ZqdqP9gtxY7dtM04MtvffC8Eo3YL/q6Mu1QdgeiRsqvNvj
	 JwDM6oTaIGTwvhgPZ+F1dmdWn6vtzSIsMCfP92J0F4Ph6lGHDkpRw3rHBdrwZhTMSA
	 bA9HOfaWSXQq2H0mXX6cMc+u4jRH3wsvqDlpT67rfKJRZ25Mxdt0O60W0L1/iNUK7d
	 4ABzC9WYhyyguy7cIQoAxBRy8vYloDUn8EOtCJL41puoOrQvEBJaf26Rd3ot8jUptZ
	 oCqj8NAvfe/Qw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 4/9] mm/damon/paddr: respect folio end for DAMOS actions except STAT
Date: Sun,  2 Aug 2026 09:26:25 -0700
Message-ID: <20260802162631.90304-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802162631.90304-1-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few functions for applying DAMOS actions including pageout,
lru_[de]prio and migrate_{hot,cold} in DAMON physical address space
operation set (paddr) collect folios of the given region by getting the
folios of region-internal addresses.  Then, those functions apply the
action to the collected folios at once.  The collection starts from the
region start address and advances the address by the size of the folio
of the address until it goes out of the region.  If the start address is
in the middle of a large folio, and if the next folios are small, some
of the next folios could be skipped.  Fix the issue by advancing the
address to exactly the start address of the next folio.

The user impact is that DAMOS action is applied to less than expected
amount of memory.  Given the best effort nature of DAMON, it is no big
problem, but it is clearly a bug that is better to be fixed.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org

Fixes: 3a06696305e7 ("mm/damon/ops: have damon_get_folio return folio even for tail pages")
Cc: <stable@vger.kernel.org> # 6.15.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 2ab7b3842701e..9ddd1ec8202b7 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -264,7 +264,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	if (install_young_filter)
@@ -302,7 +302,7 @@ static inline unsigned long damon_pa_de_activate(
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	s->last_applied = folio;
@@ -350,7 +350,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 				folio_is_file_lru(folio));
 		list_add(&folio->lru, &folio_list);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	applied = damon_migrate_pages(&folio_list, s->target_nid);
-- 
2.47.3
