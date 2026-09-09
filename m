Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13624492E34;
	Wed,  9 Sep 2026 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926566; cv=none; b=WyyRQZNi9XEvNSdjEtW31QVTB3GrlAqWp9uKssgVBKbuT3dMHHghu33FQvy2S9lsAlaag36JX1RrM33M2ctvdCddiVMWZuqkZblJIcwbe6ej6IqMSpXzoatBZWrvW9/tDfuSUH8hi3eKJB2m5N8IcVBSGY7EqvwI81tnit4Icu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926566; c=relaxed/simple;
	bh=thxMlwaHSJO0OHbljNtpAGFVFk3qPK92LMUqAEUTtZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFsR355qZHYTJ26YW5RpZwXXXX1/8SvWRrCTPu1+OuFs3rkBTNufmT3FFXZUTmfQS6csYHyglASNDBamVN3A7PtJRrDUWIJ+GB4Ha2aPQNC8HBz+G/rQZT3OzIaDm32mnDc6JKRb4dKHy5qElkuMmtoNyhUgx62qedrcEppIUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISTpwQXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISTpwQXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821191F00A3A;
	Wed,  9 Sep 2026 04:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926564;
	bh=ssfUn9zGYQlOb2IaC7l4YQaZS6oj0CRgJEZPehzgQhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ISTpwQXWQdwzyyyx9zJv1q49yDYyjuZDd7ub6wq2zgIkew10VoKSOZx2OLQaY8o6/
	 kA/j1aIT36gxeLrEY8zeoJuG9ISguRnv+C6TRWJ4RiL9xqM3BgwYNpYwkFyS8EhSN8
	 MYCJmSisv9eQITsdImKxHlRpOhTTguv7BvH4CT/uIcO9P+w7/XCCf8KMsXy0ZjSFEX
	 2JdUbQUuDp4RqPmz9exf4lerGN7qP31nIiieJ/9o4FmgLjL/Y/e8geh4bG0WxK0WV7
	 A/cbGXohDrej7CbkaO/9TagTCnuFV0xPH3PXfI2/c/mwY5ZYYeFff+vEGpFBUgNFOr
	 eoJRYHiQKaTbw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/core-kunit: check region count before testing in split_at()
Date: Tue,  8 Sep 2026 21:02:37 -0700
Message-ID: <20260909040237.169081-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090821-graded-oversold-80b2@gregkh>
References: <2026090821-graded-oversold-80b2@gregkh>
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
 mm/damon/core-test.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index c19da2e3d4936..b0d11a208fcd3 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -160,6 +160,10 @@ static void damon_test_split_at(struct kunit *test)
 	}
 	damon_add_region(r, t);
 	damon_split_region_at(c, t, r, 25);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
+
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
@@ -167,6 +171,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
 
+out:
 	damon_free_target(t);
 	damon_destroy_ctx(c);
 }
-- 
2.47.3

