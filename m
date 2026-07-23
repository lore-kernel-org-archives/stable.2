Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3748B37A;
	Thu, 23 Jul 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817080; cv=none; b=m6V6nELUXRglkQR/LakLt4mNVOQmxgfJEgPZcbIXPNh0wtUS6LQA2zwsLZWEL2fy/N6XIhLgQNZHo+eybC6OIQylej7OulckHQR6t/W/Xxbcn6Cl6Szin/QbOW5i17PBWuhI1pbXQTZXes3Ce8G7ls3UIfVsMX7kxf/LKeAUAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817080; c=relaxed/simple;
	bh=M2KSLYYNbLF9loGD0Sq3/5LKFq762/1KseQ7d6xoicU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twfb6lT8fyjIchAqJidJSvZPCEMSrQzTNf4EaIeCkdeyx4d1T1P3PffqDHonu0dSlXbqPzB0SfdZzRgvEmNRtz53R7MXu0zsXsIZ6vGLVgz8Yh+Sn/kJ+++u/1blyZebZeLtfMR/k1+lTO/2WXMfUHdGIE5SLJR7l5lL2pDTE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FWIGKo9+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FWIGKo9+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vE4+w4YDu9n7GIhNK4fpCQW3h/DoqyUfQ4ETqQ3wP4Q=; b=FWIGKo9+zfnBtutgnryH3E5NSn
	RqNQ4rozFGMzQZf7dewKfC/HQk6yYfj6KNChiak1ZVnYyvrELs0jnIcxy2JEc4caqHRNT+ofRwEQM
	VAU2TLl2FHOP1kXkATIes6CJB4Wjc8VCI88lrMzWKj3bFrV+UJIZwMtP3itCwJfXdxCZxbGlH8jE+
	LbCb8f/ESXIRUTTxZLYCp8lL+aLU5YJSDi+w7c8Ig0/hBzVcXwJyHZbNcpP2AfdBOCotfAJ8wZPaA
	XEkvv5dZH6va+Xt0LzfcAGgdpYzzA+VMtIFMvoAnfg6PH/75Gqzd6GUbfR0+eML8e54xXTeMbeTM2
	lQ+PhiKg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuRY-00000000jhp-1k2i;
	Thu, 23 Jul 2026 14:30:36 +0000
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
	Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: [PATCH v4 01/14] memory-failure: Fix hardware poison check in unpoison_memory() again
Date: Thu, 23 Jul 2026 15:30:18 +0100
Message-ID: <20260723143034.175661-2-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143034.175661-1-willy@infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
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
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

