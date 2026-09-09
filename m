Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20489492E34;
	Wed,  9 Sep 2026 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925631; cv=none; b=jwa22iNUpUer6l8E2P5EZ2gCCJkIPOvxr33gJLClcyS6GaocWRMNopmCMtNlCP0xjZvF2EVKV8E0CPgmNLe2gsUMHl3pozm7vfWeGerZtsN3BRJ2bydeJsJ0Kzeu/3MxyQ+6Ml/ZQOW+g97Taf18iLSk91RVLBcbPWs+GxSNi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925631; c=relaxed/simple;
	bh=Tq1CZh79u121R46oMDK2BmnZ9E5vFTRyu4DxZV+3rsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckuWQLweiP9t8E3Ii73GfJtF02/8mhYHhDdvmj93RK7mftTR+HhNseKNmwcpWb72csmf6MhWPYLRh1CEJu6GQo27+CjjbZaUIvK/NqaEWSilUlKx6+sR04roREqz7TK28Shr2g7Gu8vOIzBGpYpXnnI2FmyCb6K6GM+VMj8N2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEDn7J0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEDn7J0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DD91F00A3A;
	Wed,  9 Sep 2026 03:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925629;
	bh=BFnUsL64K4Z0Kps8b70WtN7VjB1InEm9DU2/SnjETWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VEDn7J0a3X7s2d76edMpHjyhBBa9/UiGekxuoEJIfHZ1wNBwM/280XwhPcFrJCGC1
	 463V6dj6/jayBg01ykJXXfCopVywUVe9gfH5m8e4dKbdxJrztmZdeuq8/KpcxfdPdt
	 yObAYNeR2JtpoDuVplq4Lb2oRSYRvB0FAyNY6EaAUOyG4jw1xGGNKpbNNAFSH5MziZ
	 q/RhR0ui6VsiDBpypvDyt/K5q9V9a2ehWDh9fXqUx3KjHiCQ6IFPzw6lSt5krajQVc
	 ASjFCEBbqEKBwB22DxMsc/xHOGCWYCmvVlQk3pzJD7eI4KwZjeknPLL8GBXKSIGYkr
	 QuiYsh0klozag==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Tue,  8 Sep 2026 20:47:02 -0700
Message-ID: <20260909034702.147367-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090820-flakily-douche-e51f@gregkh>
References: <2026090820-flakily-douche-e51f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_do_test_apply_three_regions() iterates regions after
damon_set_regions() call assuming the function would succeed at setting
the number of regions the same to the expected one.  It might have failed.
In this case, __nth_region_of() in the iteration could return NULL and
NULL dereference can happen in the test.

The consequent user impact (NULL dereference) is quite bad.  The realistic
user impact would be limited, though.  It would affect only test run
setups.

Fix it by testing if the number of regions was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-4-sj@kernel.org
Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org [1]
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5fea07e460874c8c7cf00f728efbe22abc62c8d8)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index dda3c186ffefe..bed92599e9782 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -141,12 +141,17 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 
 	damon_set_regions(t, three_regions, 3);
 
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_expected / 2);
+	if (damon_nr_regions(t) != nr_expected / 2)
+		goto out;
+
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
 
+out:
 	damon_destroy_target(t);
 }
 
-- 
2.47.3

