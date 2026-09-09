Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB563AD503;
	Wed,  9 Sep 2026 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935805; cv=none; b=emjigOC4EYiKLLLDxabCH2yPOnjvI2JcOo3xKMjDhkV+F5HWZQDrAEjHDP43nplrUVpQybcw4FMhY8qS1/1hgTIemJif0hggJ7toGDUS7/QDS5zi847oQnOSaQbR3crNpvATWMvuFd4AZVyK0XBaEcQXmoON6PoLCuQ7gLzDzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935805; c=relaxed/simple;
	bh=PKPzdMzSCVZBP3wHda4tWGzp+pSoW0Ic5DmfKs8iXfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqB2z2OINdZFjl228TYFDXfpRDDZNPQvZAq2KBENdKIMn9hIoGAwoHpKaD8Gmnl4igUl+T2/rAjPG7EbzXvWZU8VaOormen2uc/x9cpKJPt0H5EVkOLQP33mGMwXnvDJlD8vnqFl8nHXn226P8OaRywU90dfixXPBBBw/6/pH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbW9CHDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbW9CHDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA75C1F00A3D;
	Wed,  9 Sep 2026 06:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935798;
	bh=lZLVBBRPQBrHS2yRReXDOmfjrW3LfZrwzfaQReVHDCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KbW9CHDAmrgyfMLx+oUFvsFs/eNUDf40txtNBr0qlZdOilbRujACPC1Ain/xZtuE5
	 wbzKAWGSGzzGmhPwVR/b+wfXRs7PP0jP4mdKddUa43w0mK7t3qCxrvOWHNYWrHNL4V
	 wgYyOn9LkC6VBGqSQRKfpyuJ/4qQ653dqj/H+JkPySvLKqkXSQ2X8AYL054NDydOXV
	 bm2OtpAbXrdKQ11QPVLV/S6umdNNA2ScV/PfJwXNgOLB4HN2VtMetaH7Xy3kq7czMH
	 lpmLKGGcf32LSOLyvl+6y1WPZUIGiQc4ApIE/akvoaYejb3g0XfKxtZbNIeozcBqXd
	 rB/NvTM+z6wlw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/core-kunit: check region count before testing in split_at()
Date: Tue,  8 Sep 2026 23:36:31 -0700
Message-ID: <20260909063631.101832-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090820-envoy-endanger-c99b@gregkh>
References: <2026090820-envoy-endanger-c99b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_at() test next region that is assumed to be created by
damon_split_region_at() invocation.  But the split might fail.  In this
case, the succeeding test may dereference invalid pointers returned by
damon_next_region().

The invalid pointer may not cause a really bad user impact, because of the
implementation detail.  It would only read wrong contents in the belonging
damon_target struct.  Depending on the future change of the offset from
the link header to the accessing field, this could also be really
dangerous, though.  Still, the realistic user impact would be limited.  It
would affect only test run setups.

Fix it by testing if the number of regions was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-3-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 9b18ef3c3aa1ce24176e340061caf15fa2742564)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core-test.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index d8fef225930a5..069c9032b98bc 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -162,6 +162,9 @@ static void damon_test_split_at(struct kunit *test)
 	}
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
@@ -169,6 +172,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
 
+out:
 	damon_free_target(t);
 	damon_destroy_ctx(c);
 }
-- 
2.47.3

