Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF383932D8;
	Sat, 25 Jul 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995274; cv=none; b=Y7SX1W2Q8jJDGj/TbKDgGKPmQ3uBIxp0+cBgQ4FTKae4ndKq4vPQLqhy+ZfrzHMQJ2/qBDNAoUFwtZKYlndzu6kBeT8hK4d0jcnC4aVmMKSLQqeaBdvM4wFJkzNX57WnglpnyWy+zQCn3oaP3YxOKWI6bLm61aF2fdppcXgnmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995274; c=relaxed/simple;
	bh=M2KSLYYNbLF9loGD0Sq3/5LKFq762/1KseQ7d6xoicU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVWT+XrgPcF5q2wHpQT1xGuPCZO7xiD707iwZBv1XiNvjix81fOjkELiiW0XnvlLF10Q+3bDpwnDGXHjoCt8TW0E1VhVEX/PB2mWb5CqbeOKL7AhxfeVZMqoO7veQpkB2zwiKTqgEDBYs2loMAC2+huo5y5RT8u7z6Xvh9e1+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K0+BwlvQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K0+BwlvQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vE4+w4YDu9n7GIhNK4fpCQW3h/DoqyUfQ4ETqQ3wP4Q=; b=K0+BwlvQru8VRTKFdo+d8i4CLo
	WNDazIVTll6eWp2HGZ2BVShFa23keBkBpmSPHV8jhtRuwlBpNxBuhdSR7qMOPR0TwWTJ8qs7+lmOx
	VX4JtrNeCbpMlSaLgetpYoz6Hb5mVuga1itqayrx7rl3oDDoOd/cQ5aWTlHxm9Vb5H6jF8xJ7s1Q8
	ZVZx9tLgYfyEX+V08eSLaxcUjyZKwyVXAsgR6iHsxayvlXtdbgVRVbh7OonurnB6UyB1Svme0E32z
	50aqiVX49vI3gw7a1neodIFd36vFokJt5OfRQDv3eCLN8vQU24xwy86qaRyJ9XgCXngCbTSUFvJvo
	hkg/XarA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnenr-00000006X7Q-1dIR;
	Sat, 25 Jul 2026 16:00:43 +0000
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
Subject: [PATCH v5 01/12] memory-failure: Fix hardware poison check in unpoison_memory() again
Date: Sat, 25 Jul 2026 17:00:29 +0100
Message-ID: <20260725160042.1557264-2-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725160042.1557264-1-willy@infradead.org>
References: <20260725160042.1557264-1-willy@infradead.org>
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

