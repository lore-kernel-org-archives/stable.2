Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B847ECC8;
	Wed,  5 Aug 2026 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963974; cv=none; b=V/pO10V6La2UKhWZKJj1fiIajnoWgpAbvBhr20wxBfFZ68suS/bL3I9flH/ok+0dEgDZx/v1keVnEtSgAemHkzI7D/bT51E6V0u2iL8czgrOgyVbtNz5T+ZR6s5nPf9ep9fnTONkKIu+rj+iGpFwr+vz+JsgKH7TtBZqRkQ4I5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963974; c=relaxed/simple;
	bh=W87PURLsCUKnUlEcXXgZCM+qmQhX1yTxSPIEDk5nBD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qe0V3rB1s5veVuQk5P3kfuG+fQkfA9hMo2HFaD6ipj4WTMVsw7GSWGwLm8euLQojuSL6dszBmW2i5ZMmSqY4OEt3QEGHe48ebt+3yDlwHd41zY79sDwUQI71aokntrOZ/lgbC2udlmDL88B7R6fNL8UVEdgBdowR3w0bb/9kSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b8iyLogG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b8iyLogG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=57pqVUBnNmX4cL7er9o4/zfu8e545pjnuaBSHsFeFDE=; b=b8iyLogGZWsewW/fwjv9PC7QQ1
	K4q20HeVSAYmtkIesVcvUexqCSW3n98569Yc/t+a/acUUPw+brfYCuDNjkK6P9UhkLUFpkuRJGMhG
	zrsY3vxhU774pTVDkESi40r+Ihz0VJYpyGfkSPBTAwT//WTu5prLiqkEfETryGeNY0r4v9yzWK5Ii
	5Ez9efFZW14/UXRW3IQk2LX2ZuPHBnC1pIejfuapERWhujUB936JuzTbplSQRy2Ls5meXVfqpU1gu
	OHIkVVE25WG3liME5CcoVyBxKaOFdttxO1+6S1hhTARTqizWZWcijiSMQfAjUzh4+IE/6CRnkTe2Z
	8maT5eSg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrioJ-00000004h65-1IK8;
	Wed, 05 Aug 2026 21:05:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH v9 01/15] memory-failure: Fix hardware poison check in unpoison_memory() again
Date: Wed,  5 Aug 2026 22:05:41 +0100
Message-ID: <20260805210557.1118966-2-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805210557.1118966-1-willy@infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The earlier patch (6c54312f9689) that attempted to fix unpoison_memory()
was incorrect for hugetlb folios.  Before a6fddef49eef, we checked
the head page for poison (which was correct for hugetlb and incorrect
for THP).  We are currently incapable of unpoisoning pages (other than
the first page) in a hugetlb folio.

Use is_page_hwpoison() which handles hugetlb pages sufficiently well for
this purpose.  This is racy as we don't have a reference on the folio at
this point, but fixing that properly requires deeper surgery and this
is a CAP_SYS_ADMIN path only so this will do for the moment and can be
easily backported.  It's no worse than the situation before a6fddef49eef.

The other bug in a6fddef49eef is that we currently clear the HWPoison
flag on the precise page, which is wrong for hugetlb.  Fix that too.

Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51508a55c405..944e6e1d4971 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2695,8 +2695,8 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (!PageHWPoison(p)) {
-		unpoison_pr_info("%#lx: page was already unpoisoned\n",
+	if (!is_page_hwpoison(p)) {
+		unpoison_pr_info("%#lx: page is not poisoned\n",
 				 pfn, &unpoison_rs);
 		goto unlock_mutex;
 	}
@@ -2748,6 +2748,7 @@ int unpoison_memory(unsigned long pfn)
 				folio_put(folio);
 				goto unlock_mutex;
 			}
+			p = &folio->page;
 		}
 
 		folio_put(folio);
-- 
2.47.3

