Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76454854FA;
	Mon, 31 Aug 2026 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184985; cv=none; b=lk0TMtmbvPn65W/u9Ay74mPnkKQbeCMKTY0IukSVfHA1lxnrQjh7rNI+xBbENv/0kmmczRBZzfdEpLWbtJtwmKrSFRhXboUoy0+vsif1bkG5G/1dJFH/IiVL1Gqbmwj+vs+bNvzrR/i88XrC1sqdzK34IHA5yQEpHzKp+WPNoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184985; c=relaxed/simple;
	bh=3tuXFYxnY5whCfMb9BBfKAgRQ7zxuSBaL+SQQ8TayGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDSr/2A18taaYQ6m+HVTsHg4G9db8E5NRTZ18pLnDcY2vIRBmbRrGmyUY64awxgOjjpG51uNO4G3IxVWR/aTb68aMtfbKR9/4DnL8tAFT5ovjtJ+HmmEaUcasYlTWc4IpvGB4krAcYmEFc7Ml0o33rKuA120eVc6oL5w1763inY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXnBJtsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXnBJtsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788731F00ACA;
	Mon, 31 Aug 2026 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184983;
	bh=l4DJBfV8Ln2wiu4MTHaklCvhtPpo+9nKnYvuVasq3nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FXnBJtsg4T/jdCIgbGNIC7C9lZLwx9En+qSGSYWcf9S3ezctloyO7ts7ywqdmktJq
	 YWcG5xRWBaNtZq3U/tIOgdKFb33eIS3WW1JOO78jEVYc4Uum6uF7Sg/bglLZ5xy1Ny
	 JqjPHMrVQSr873qz79bpF3N8gA9gcEGlINcxVAnlbZjVSEjlkJLLf7srW4adVF6fh6
	 rwYMfUml2hzc5cnMeebrNnfZn7BOBT70fjdjD7iit+C8LB0ssUQ/yw5TH9u5lVImZX
	 vxlRlhg6nDprdjscFmkvAZYV/mkjjq1jjGXkKExEmuYjEpt3oXhR89WDDIsHUpNgim
	 5QXNf/mkEueVw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 3/8] mm/damon/paddr: respect folio end for DAMOS actions except STAT
Date: Mon, 31 Aug 2026 07:02:42 -0700
Message-ID: <20260831140254.72004-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831140254.72004-1-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
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
