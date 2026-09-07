Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BECF472535
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787305; cv=none; b=OkEGwJGPk69Lez8uHxTNdKDom0pUPBI/3QJ73URTgb6VuR4ark7PPFH9gwpzcaTADBkWkvqp52UAEd+JGi1FcwpBMzSqIAkK3OyxJxeswFCDaolSJW5xDzreMPrUicJ/gagxTTPJrldR/LA/JatzuU1snk8tfvAsPuYA2HCweAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787305; c=relaxed/simple;
	bh=T1GH6hItrh3S2bTGYxMz3vhBOz0FujXzWdtsg4c5ifg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lNPkNlpW1jDnnsjq/3s0S0bUYQOer0+KD1aFTXpmOL42C9xAbQOxF49lmlpFr4bmGMkzmryBJtKDtM8q29DxjsprNUMCzTRHAoB5sjOg3gdfwYZE5bHxByMbGBi/7GkuQ01cjvHRvJMMnYWkGZ8uUPgX9euo+ENKmuig8eo+z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtK5B++0; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtK5B++0"
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-4667f43a4ccso1566111fac.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788787298; x=1789392098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QSUCkb2IsxXPufzfD2+/6w1ZlHPJoyK0t/kGTCdaAqA=;
        b=RtK5B++0oE1HuOhYXf4gzgj8BsCro4V6Xj/h3QKp4ZORZsksRt+6lqMFIHqpSjtvo/
         YD8OHYwhUppB/qp+gAbFcdaqJNDSXdUDfsHgQj1zz5fOndzoHPKdUCefaS3n8SHVB9aH
         /Ea3c+pyCXFhKaqui4sLTNZdAC1x7r9h5VOb+ctqGY82CLpbewpcX4IGb1Nm8ArKN9tT
         pRYTR0wfc5qoerDQu7kGnazuugDc6GfLi3k2LRxloQdsZwzh0USFdoCT3iEU5meUDQkl
         uPSvaw9PyBe01tFy4P974Tg5SdCl/BqVwS9oORg0NKhTxffL5ypzRnnDT0aueZz1lyku
         Dswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787298; x=1789392098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QSUCkb2IsxXPufzfD2+/6w1ZlHPJoyK0t/kGTCdaAqA=;
        b=XqCl+wSSS2Pusw7Nys/KRHKS9MgZSfVJLMfhLF/XMOURh211lrUKkAL9ylek1lWYVN
         lwIRshyn56FtmbrJ/QjAmIvZfxxxareokB5SHgET8tWETqXSVYImcwsnvKu+F+mJvRxs
         a9ponz0nzuVjiUQ9CJk3YF9OWRK5oR3PNamxR6gRCDgbhh1MbdY0Q9ZxBp/yPndmwNNq
         RfKPKLV/d0XEO4GD8ZxRDaQ0YezscldrFhJ76UrxFlVysR8Bg3L9Jf7hYeg2lWqzAlaR
         UXRAyMcVewAGZ6WKHy3svLHRFvdDu2EtXoO8mwjUg8L/W3lB9fO37hRipHtTkFM3Qimu
         LNjw==
X-Forwarded-Encrypted: i=1; AKwUvByLcOm26ic1Ym3kY2a5jnnmo69xKC8NdpdFx4FYn/5iXEH6dXn3X1AV04CZ2CDauob7dr06Zv4=@vger.kernel.org
X-Gm-Message-State: AFuF++lnM58ol9yqeAvKmVqdvVI//UawBEeQfwM7M0Tx+VmvPtVgv8tY
	wZ9RbS+Epm1fMOzhYw7qF5ORvUg2kGWYwO5wA6+8VC/XG/SyYGOifGra
X-Gm-Gg: AYBFou1mLYqu7O/S9JKLKr4i6vOyL37IkZ3sQ+Igv689/VjTO5BzjLR/8W41LNbo+ZC
	UE9TQursdVFDWOQ4rbOr6nDyynerJpW2K7j0F6XVO6gzp+2qWaXTRG9t92aLaF8VojiqAIY+kct
	BsY0rgHxQK+2QAgcpqy7erGser1EN1x9IT3HJP9OBJp66KDl4lMrJvA1l7x2P0H2ke5areBy2iE
	CFMic+zja6ikrym8BIg5mOCxcUwNlOcwDb88rSyA0YzontLtQAgtuOEQG5bSm4jSIuQpfgoo/Y4
	I0Slnc+tyNAB9J0XIZnwsJvniog+w7ARMgyPLpJE+WfqZb0xfUWzJbT9rDuPEwZioq+yvAwbaIo
	7NiMYAfKFlLwON3905AjKlCWqqUE9qnjwQm4CmGXN8lg9AJEVR3kOV+HI5cOKL66qNJR0dq8AMa
	HubVRMkfsOBDl15teGPxts+ifAonwHg1/MvD2LE2j4uAtiNZ7OoPIMeuL7XFwyLgVqtAGWq6Mys
	1RCt/A+OUn5Q59rwKlTvhD7dt8gkUEWXtEnXwvG
X-Received: by 2002:a05:6820:2004:b0:6b9:2d62:960c with SMTP id 006d021491bc7-6b92d629902mr6339050eaf.68.1788787298260;
        Mon, 07 Sep 2026 06:21:38 -0700 (PDT)
Received: from HXDQXTDYHN.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm28284062eec.26.2026.09.07.06.21.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 06:21:37 -0700 (PDT)
From: Jinmeng Zhou <jinmengzhou22@gmail.com>
X-Google-Original-From: Jinmeng Zhou <zhoujinmeng@bytedance.com>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wupeng Ma <mawupeng1@huawei.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jinmeng Zhou <zhoujinmeng@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/hugetlb: fix subpool minimum reservation rollback
Date: Mon,  7 Sep 2026 21:20:55 +0800
Message-Id: <20260907132055.26696-1-zhoujinmeng@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a reservation request is partially covered by a subpool minimum and
the remaining global reservation fails, the error path first calls
hugepage_subpool_put_pages() for the subpool-backed portion. It removes the
failed global portion from used_hpages only afterwards.

hugepage_subpool_put_pages() uses used_hpages to decide whether rsv_hpages
should be restored. Since used_hpages still includes the global portion, it
can remain at or above min_hpages and prevent that restoration. It then
reports the subpool reservation as releasable, causing
hugetlb_acct_memory() to incorrectly decrement h->resv_huge_pages.

This was reproduced with four 2 MB huge pages and a hugetlbfs mount with
size=10M,min_size=8M. After a successful three-page reservation, a two-page
reservation which needed one subpool page and one global page failed with
-ENOMEM. HugePages_Rsvd incorrectly dropped from four to three even though
the subpool minimum was still four pages.

Roll back the failed global portion from used_hpages first, so that
hugepage_subpool_put_pages() evaluates the minimum reservation against the
current usage and returns the correct global adjustment.

Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>
---
 mm/hugetlb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 785772845795..3e3cda181e72 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6808,15 +6808,6 @@ long hugetlb_reserve_pages(struct inode *inode,
 
 out_put_pages:
 	spool_resv = chg - gbl_reserve;
-	if (spool_resv) {
-		/* put sub pool's reservation back, chg - gbl_reserve */
-		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
-		/*
-		 * subpool's reserved pages can not be put back due to race,
-		 * return to hstate.
-		 */
-		hugetlb_acct_memory(h, -gbl_resv);
-	}
 	/* Restore used_hpages for pages that failed global reservation */
 	if (gbl_reserve && spool) {
 		unsigned long flags;
@@ -6826,6 +6817,15 @@ long hugetlb_reserve_pages(struct inode *inode,
 			spool->used_hpages -= gbl_reserve;
 		unlock_or_release_subpool(spool, flags);
 	}
+	if (spool_resv) {
+		/* put sub pool's reservation back, chg - gbl_reserve */
+		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
+		/*
+		 * subpool's reserved pages can not be put back due to race,
+		 * return to hstate.
+		 */
+		hugetlb_acct_memory(h, -gbl_resv);
+	}
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
-- 
2.39.5

