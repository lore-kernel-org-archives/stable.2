Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01F2EC09B;
	Wed,  9 Sep 2026 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925874; cv=none; b=LQKcDlU18aOL11caZRVemZMp2mIAtFBsqtFYeHMm92kO4IIL7B/emQ3qzbSCSTjKSxNlGZCCWaXnLI0rQl3Y0lnxob5oDXOp5bCQZi5USjuAfG4lTgurXVp7pIlWIN6lcZAm864VEeUgoY/XuTkmetnH0xW1VxD0Zigb08gjr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925874; c=relaxed/simple;
	bh=gK3RNjAxnVXZaXiKo0a9XMo0L5a6C/6xxBLGCPVZAAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJumsWTIzjoGV/mZ5oitGRCfioahXwV0VKwg8y40nSpnSQL1Ydzi6oDI5YVN7wLaI8mif2e/1Y+nqbE8EL9f1E3htGrjjc/rTKyNgbsb1j5kTeHMGdlrCWbhMBCRb3z8c07DHei6NZvJfMx27C4cVot+O/3MCPECmsnkBZwm+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuMixRxG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuMixRxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D01B1F00A3A;
	Wed,  9 Sep 2026 03:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925872;
	bh=JyRhJ4jfUepeczhymR72FdjYEPAnz7x6O343Hbm4Cec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PuMixRxGpGvRekZehDnRWQeA1K/owheuO3v5/on34bWWt+SkcRHamN3oQHFM6n7iK
	 Rv1G7OybIu25XUDHTPpYZXfgP86OkWBHGh+NO1MDIbGaA0MXwQMo15Iqi1jXWsKXxp
	 R4AzBD6ToFAgC/dhrQnxIdJeF8isax3g0sdU5M0bEJ1jmKHj1BZyGN7s0MJiWUhgTr
	 R6EvoT8duprq/zj9wTBZKxn3eO+8sItu/GDNkkAa1adIS2Q9JKFsjxzLDPTfubzXrs
	 brfvzSnFIduknsSHomWiVPbxy4npnwEOLDrcGJutXtIen3zNIRx7stZgjcgm3Hp3hH
	 fFUjE7Lhr7Dow==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Tue,  8 Sep 2026 20:51:05 -0700
Message-ID: <20260909035105.154326-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090821-fancy-avoid-db90@gregkh>
References: <2026090821-fancy-avoid-db90@gregkh>
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
index 72206dda95ecf..ffa76998dd63c 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -155,12 +155,17 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 
 	damon_va_apply_three_regions(t, three_regions);
 
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
 	damon_destroy_ctx(ctx);
 }
 
-- 
2.47.3

