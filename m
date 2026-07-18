Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDF3C07A;
	Sat, 18 Jul 2026 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784333687; cv=none; b=FjMKX/Fr18HZNTfT6mXab6oDQkeGtJQU1vEVaMyOArx6qGo4I9bwTWzb5yKX8AgKyIktIitc9B2r2VzU9cjBr0ceqYtJ5otQZFhttA5Uu0BGL+ORZ2Xw6emxYYUDDRDrwZY6A/M7bWd8ToLV4dq7xSub+zg6+CHOaai+vEoeLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784333687; c=relaxed/simple;
	bh=ILjTYHuIfdw7uvX4Y1fhjhJEasaEw8iiRHuJ4SiGEnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtAOr7WvWxsHpYgZFA8JRXLidAGQCgSMF0xPYpeAlxgG8mQJRlFYcUa3DuLtueo0muhVA7x4o5xSRdFfF8wc6NZVkDlhgIqL8j9NI7Ox1iMbu93XUA+9xuTi9GFCKDP2gdTY9/DHUPpGqKpBPTKQKL+V6CZCaWj3Pz62V54YwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCj3AtKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCj3AtKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C181F000E9;
	Sat, 18 Jul 2026 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784333686;
	bh=cUz2au4OyIrV9kPXUAznd25PGFTMj7HneR6m36jCxn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eCj3AtKTOWh8nwQAmfmA+VQ82bpReRimwkqApgoi4pVQ/HsvlN+yZHblj8TcRlGUw
	 tDETKiD2M6IRi5Q5yjrpbxdAaCASAGdrussfsQabdATc0B8ncyq49ArJGyb4dP87IE
	 OpEELBOety5Bg0/VDJ1OUn01wVfVpdcrHGQqVVY/8TQ1Vl6cbfPQ9jmI6865zaqwmY
	 kKrocI7c3gHhWJUiZZwZTH86jQQ6kH469emNKPNBU+Lvhk1Q4r/VIU2b2EfC5Ab4L5
	 lkEW5JzgBD+gPRMUdbYXfXYE1ypd0V5GZHUNcr5ohFmRl/tjlMX6La3brUOTWbZ5NU
	 o2C5ggz61+K4A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Fri, 17 Jul 2026 17:14:38 -0700
Message-ID: <20260718001442.87129-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718001442.87129-1-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dasmon_test_filter_out() test checks if damos_filter_match() of an
address filter splits the region as expected under a given condition.
But, the test continued regardless of the split successes.  As a result,
the later part of the test could dereference invalid pointers that
returned from damon_next_region().  Further, it could corrupt memory
from damon_destroy_region().

The consequent user impact (memory corruption) is quite bad.  The
realistic user impact would be limited, though.  It would affect only
test run setups.

Fix it by exiting early for the number of regions test failure.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org

Fixes: 26713c890875 ("mm/damon/core-test: add a unit test for __damos_filter_out()")
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 322a295ac2cec..eddf3a0484583 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1365,6 +1365,8 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
@@ -1379,11 +1381,14 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, 6);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, 8);
 	damon_destroy_region(r2, t);
 
+out:
 	damon_free_target(t);
 	damos_free_filter(f);
 }
-- 
2.47.3
