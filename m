Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EE42049B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934235; cv=none; b=PzejwS00Xe5egK7qZmmu8KZ+yBglvZa8BgcaPLxzcXxBMTagQB2N/+T2JbCYjlWmGugBF2Ax/HxUSWH3jmB7Ufjy2/krmwpu0R9Gp7Eb5l53+MIvSS3pKaLK9RRRkhuxrrOtEk6fGNyJ97p/rbBqFmkRKM97IkwxYAI57SQWimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934235; c=relaxed/simple;
	bh=JND0DIxNPheDV3c+Rk7qBx9BtfRRxaI/6bOm2Exdgts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lGKg/v186DDKWq+eWEqVhZ+jtwJS2WExyHImjggpYKeRgqL3mQ76PvMTLeY9A+bbRv8aeRnxit2kp/GLkzebhPvnwAkzMDxv+S/TMoGB/ofdG7cmvLqtE+JK7xD4exmWEDQ8HaAWOwJvOydpb94Oh2lBsrwMkZXncU2Nu+GuTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dVmiKXFb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dVmiKXFb"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1411481b3a.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1785934233; x=1786539033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVNKoUyYIF3h0gmseuybz7+MdTC/satf3XbsBQnLJSI=;
        b=dVmiKXFbdhcQAtHVg83X1pH0LfYNJ7gPd6V5WIv0tc7CByMWWMfovv4QkjxqvM9T/8
         9VIFst1Koh28ThxOpERCf6YWX75CPYhgtGYkQDOhbbD/xIpL9G61scyjaah2x9rTfQoq
         uFCEOpTrWwVsQ7EtK9drgYSWfZC/SbQEPZO00g1uZsJWiLKfHpfmG4lB9O6XUcHHe16r
         XLcBAxV25bEFBRDNr35I30/mOQ19WCV2PXCjinMFzT2hCDfhTG9FD3NRr5QDTBRmtvEm
         4uQ8wSydIzsbIHRrMeaRIxnUNZMhvcOtLcV57lVq1zvKRXyqUiUyiYSQczspZ0FNSojh
         m9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934233; x=1786539033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BVNKoUyYIF3h0gmseuybz7+MdTC/satf3XbsBQnLJSI=;
        b=qltIdU/PWrMrLja34F4DTh0vzpBT8pFpNFNCAzVuKpPee0CW2jFCyFib3woGlcDXw1
         srbwGPV9u9rp9Eg02cAzrJ4KuhIwTcv/mmGfXI+iNgvNamHbjNz7o1UB+uwfftwUR60e
         7FOF0Bz3rDBxsA1SCdgwBq1oVIA0IxdHcYhVobJqv4set2TY5zMGrqM2f8L3ZU8/zkSX
         C0Y0u4fsTTT7bcHpxLrrZ+AmNyRf3bBZGldiYJJHKvISsJf7JvMGsizGq1ZjSKIp/qe3
         /n3Oykv+5doR5Pup/k1QSBSiab4ThFur51dmCj0qK9G77PdSOK8bFiKpgkEkHI7MySCh
         t3dg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7/wJtS6k5hJhUX5HAovGOV9W/ODluu46HL38a8tArgwfixaZporY8IJeuP/unk/GfCpYWrvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkfpE5qWPiuh5Gfn6oUoOhV+SmR3lUa+bXIh5mQEl4TPUAAvz
	4quZeDX3TzrUycIyXT/yzogTeN3+R+38ViK95JlP10K12qV5zPRHmYE+QGF9kGqV8ZM=
X-Gm-Gg: AR+sD10KF9GfT1wr+z/TZkvIPn7vOibAkBAD0xt1ibcHDAjugqJJ9u4RVMu8uYm7WyJ
	ruMV3cT9jlCXa0b4btk20U9u2RJ+4EP5xwFdYcqu16c8iwo4ZKwGCWasAXVRUDfzrv+z27alF/f
	4qM9R/H1qEbLwGkeyDKEzQwkZ+VyrEH51IBD7XOmjEYSwv5v5JFwEm3akYWMl67UH6u3Yc2yJMR
	BA9NTMNDwOVqlHMzvw7X0yJ1/+W2Dl71Rf3ANxZFcPMWPYBCWOSHbe8lCVW16yToIEBUXnGa9m7
	N+WVvdSQeS/qCYj5WDlcHBE2kY1ztlgtlQFA/Xt+psKp8w4dc/ePQL2+YFzvbCdHLXhF6ojLTJH
	hIzkcndQFx4qNaZQ32hg8Na9zzrGDMkJVQzyDVbww7GxFBZa5s8jx3TycM0d9ZjuMOSs67xcm7T
	sw4C5lOXsmjuZwzvbgmmnvAPvOttVerrQKZTM8RvCGARYxb63VWjM6iSXyXFWxesvgLEPlne6DX
	GiigkHrTRIANAUwyDlfmvfBMk4=
X-Received: by 2002:a05:6a00:298d:b0:84e:7ec:aa42 with SMTP id d2e1a72fcca58-84f2dfb511emr8027091b3a.10.1785934232776;
        Wed, 05 Aug 2026 05:50:32 -0700 (PDT)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2e3089sm794446b3a.19.2026.08.05.05.50.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 05:50:32 -0700 (PDT)
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
Subject: [PATCH] mm/madvise: avoid skipping pages after splitting large folios
Date: Wed,  5 Aug 2026 20:49:57 +0800
Message-Id: <20260805124957.91325-1-cuiyunhui@bytedance.com>
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

That stride is incorrect for non-hugetlb large folios. The memory
failure handlers split such a folio and handle only the base page for
the supplied PFN. Advancing by the pre-split folio size then skips the
remaining pages in the requested range while madvise() still reports
success.

Advance by PAGE_SIZE for non-hugetlb pages and retain the whole-page
stride for hugetlb pages.

Fixes: 19bfbe22f59a ("mm, hugetlb, soft_offline: save compound page order before page migration")
Cc: stable@vger.kernel.org
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 mm/madvise.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 07a21ca31bad4..f37abed29445b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1464,11 +1464,12 @@ static int madvise_inject_error(struct madvise_behavior *madv_behavior)
 		pfn = page_to_pfn(page);
 
 		/*
-		 * When soft offlining hugepages, after migrating the page
-		 * we dissolve it, therefore in the second loop "page" will
-		 * no longer be a compound page.
+		 * Non-hugetlb large folios are split and only the addressed
+		 * base page is handled. Hugetlb folios are handled as a
+		 * whole and may be dissolved, so save their size beforehand.
 		 */
-		size = page_size(compound_head(page));
+		size = PageHuge(page) ?
+			page_size(compound_head(page)) : PAGE_SIZE;
 
 		if (madv_behavior->behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
-- 
2.39.5

