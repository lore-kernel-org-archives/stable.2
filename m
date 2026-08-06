Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE53859CB
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785995722; cv=none; b=hPaKK2huXDwdCtHosNgXHaIDQtIEL3GPcWzSVvYWs2XfIUQi8A06d6UR5dGZPl3yhBYBRxrFO8OB7RlumrBJ6nfLv05f2K7HHyQO4dt3QO1cHyXZeGrsf+bTT4E+W7PiG+HDf7D/aiixFWchdljMH3NDoPf4uMjWWucGXF1NtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785995722; c=relaxed/simple;
	bh=DxfQm9W4krPzpEfAtVVVWIinLMUehnOesKs+H9lg9S4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXNmry8nm1kbrqKqFp//RZ21W28ZBC0vXUj+47dk3s3Hje3juaMAOzuhLazVgUo35+OFllYk6/LPmlzbDMz3DVJlGstJxHcqH9C9r2mYisoFcxBY1Gkn5bkYxnevUZ3oTzjeSJyRNhIomO+jx7JZEYqZ0i4ZUoPoENPqUs8XL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f7ey23pR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f7ey23pR"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1206409a12.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 22:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1785995720; x=1786600520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dGhdRgIgIMHfR7vy1rI13brOXOjVKrzvUJgGFI1i9XI=;
        b=f7ey23pRqiD7Hcc55I48Q8HZazhZ/uJkAXQ+HPgUUnLblc3Qv9TBBDTqXc24tM6CUk
         ZbCB/9/eq6X3Wd5QMsDgFMgKEaJeV+Yn62onww1z848qWikdwRi2jAPPqL0i5G1ILMdL
         pRCq8rUuWNT9YgfmMcGtXYtZ84Mb+hhUrfeo/cM0xGWM4oZn7G6mrBGJu5dHnwvELVDY
         355u7KKrEEecW1VdxD0cyd/HAZR8pUp3ZdOOt4qnpK+Jf5m9NVYBgtAJ1nOCvPaekFXc
         yFM4s4IcJoOJ2TwaIf90+0HHmFWHdd4UxmE0mjYlHlSpJUinH1LH8W+/KwU1g1e8cHh0
         N4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785995720; x=1786600520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dGhdRgIgIMHfR7vy1rI13brOXOjVKrzvUJgGFI1i9XI=;
        b=gJG7tpYKvteTzlgLF1cDs3QYJzec0X92hKrC7iX10T2VmrxAcgD9cY4j6mqQyHMsQs
         1vRwzGh1MV97bYZN6KeROkOEIKAy458EbrZaCt+CXVuBgJMOU6f/d+1Q6bdR365uvjFM
         3fMRhEDr3XdE6ymtiLqKAK6tCu234yH+hLYbP23hcr9gxAyTb0Kpk8d+F6+NZdL/fTZF
         B/k6trxg0s7s8/DfCo9COkDTrAshoZJgmX5Z8tiF0iF2HxBsxfs2hbCg4bUlehhcpeQ7
         ZUhhDXl8YEJzJ7xMYmTxRaNdFNN2u4kuBeCHmF96RffBRJU1ukW1/679Wt7lKTugkhOU
         oLdg==
X-Forwarded-Encrypted: i=1; AHgh+RqLAlIHlzvRILHTGjHXZYlhTFxwkNXjvpfRDw+IkMyAvZod2+TqyfYGGQs605ooW5cwHhhC/Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rq0vpN8rnPdY7Cu3v+U0k8vkgEmmZIW3XZ8U6we/jqkFnq4Z
	9trn0rglSG/1UFHt/Os+tpHLSiFU1XFUq+3wbmKrMxV5W0ZBs47ieWjgD8nBC7dNCrBJGHbCiO1
	6V+gRV/Y=
X-Gm-Gg: AR+sD13HHdr2yiyC8Gq4H+JJSU1EH/eZMnOQ2qrUKL9BoERgpVB/dlicEVCrEpPp9CB
	/4v5JPhEimESWJuKyw5aayofkteAmLj+uOYOgcqxWsHbTS1QvrfH1iWiV5xJx3yKN30RfGV7j2j
	vJyVFNI3ExO5bIUoobdlKaTVEyo+mUYtxNfvbfn44ThNP9ije7DiubzpDhqdCHbMY3teBhCcYYq
	ImX4q9U4F7/ryvPqOjEJyHZMUYR0MgziXJPKQiKaMhPVY5sKKPlrGBwZmx7eV63ssuq+ejxTIiO
	yFEny56XmaTIVIFmQpVj2hoBC8M/jSNaJWV4FmMJ6DBLnBVZA/hfZLtmY2TY5Bi/BNliZHba8gA
	ekQPZRCWg0h/yMKW2bt0p6FcCGH2YWja/5mqX8CK6q+yE4KOuK4oabedlp4ldmK27L621zXAKUb
	J15MTDzdENsIwXrFnNDSrU+Zsxg6wx07jxKa+vhHmU4ZGZL72mNyo8WQaoR2Knt5lsFG5l0/ge2
	oVzIOJSu2sct9iOtfmjb8Ew6i07gb7m/CsJoA==
X-Received: by 2002:a05:6a20:43a9:b0:3c3:8651:b302 with SMTP id adf61e73a8af0-3cb85f60443mr15100884637.28.1785995719569;
        Wed, 05 Aug 2026 22:55:19 -0700 (PDT)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158644a195sm21906471eec.13.2026.08.05.22.55.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 22:55:19 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	00moses.alexander00@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/madvise: avoid skipping pages after splitting large folios
Date: Thu,  6 Aug 2026 13:55:01 +0800
Message-Id: <20260806055501.56761-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

madvise_inject_error() advances through the requested range using the
size of the page returned by get_user_pages_fast(). Saving the size
before error injection is required for hugetlb pages because successful
soft offlining can dissolve the source huge page.

That stride is incorrect for non-hugetlb large folios in system memory.
The memory failure handlers split such a folio and handle only the base
page for the supplied PFN. Advancing by the pre-split folio size then
skips the remaining pages in the requested range while madvise() still
reports success.

Advance by PAGE_SIZE for non-hugetlb folios in system memory. Retain
folio_size() for hugetlb and ZONE_DEVICE folios, as compound Device DAX
folios are handled as a whole.

Fixes: 19bfbe22f59a ("mm, hugetlb, soft_offline: save compound page order before page migration")
Cc: stable@vger.kernel.org
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 mm/madvise.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 5a09cc24f04a0..e9d4c3bbc5290 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1455,20 +1455,25 @@ static int madvise_inject_error(struct madvise_behavior *madv_behavior)
 
 	for (; start < end; start += size) {
 		unsigned long pfn;
+		struct folio *folio;
 		struct page *page;
 		int ret;
 
 		ret = get_user_pages_fast(start, 1, 0, &page);
 		if (ret != 1)
 			return ret;
+		folio = page_folio(page);
 		pfn = page_to_pfn(page);
 
 		/*
-		 * When soft offlining hugepages, after migrating the page
-		 * we dissolve it, therefore in the second loop "page" will
-		 * no longer be a compound page.
+		 * Non-hugetlb large folios in system memory are split and only
+		 * the addressed base page is handled. Hugetlb folios may be
+		 * dissolved and ZONE_DEVICE folios may be handled as a whole,
+		 * so save their size before error injection.
 		 */
-		size = page_size(compound_head(page));
+		size = PAGE_SIZE;
+		if (folio_test_hugetlb(folio) || folio_is_zone_device(folio))
+			size = folio_size(folio);
 
 		if (madv_behavior->behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
-- 
2.39.5

