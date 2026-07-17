Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EEC233929;
	Fri, 17 Jul 2026 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248234; cv=none; b=ghHbPrMqTtOhK3dNUKR8fLTENpctS2OLtoKBy4TvwQwkzx11zKgUx4nql9LVYG+y3p3TW109w8PguIi0FaRPzvjfCgBZPLiCa0UPSe4KaZ8m0vIBRbV4PDwrUaty6WcYmhsW3nAoWKWeoNRniAU5YPEdjS4bvPDLYjbjCITLPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248234; c=relaxed/simple;
	bh=TeVi2a5VA6swQGzoHEeH3UFNCp1Li381UGVD5rPx9wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yz4TCpTxKhu6A6BWk8ReyAtoQWY3dSrDGHgHo8upqmQdsKr2QQlANJjGDQWUw6CvHYooeCwGilsGMgiXaSqGrSswdOAs6TZ6P3cmBWIqLebSy7MWOIwQF5G7etsxMkDUldJsnfpZWF2YalazgJ3+cUFtMnbjkcwUOcI1YQgM2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfAbMLTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfAbMLTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4292E1F000E9;
	Fri, 17 Jul 2026 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784248233;
	bh=rj9Z5Y27iRqji8iRGMFfcJYv5ZbfjmRp4XJwmqUyuks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfAbMLTf558lsnXavsBfIowovwZYqHiUt4jX3iHP9sYrYd8xvWyRsvrpSvw0MSTWY
	 nTcbokmih6UEEtk7TKjAgq6PEtBt7VusLCyE6/gkskuqKzlKEPlo6tHYl6nQ1TAkVa
	 j+Srwx13jxoE3PzjlTZiqIb2fplrrza5feZkxkcAMJ9HLGRwnHSzv/5XpJPGIf8vRA
	 6sP2WNThsPfP5+a28TQJ9obpiIl6Zkye1TLUF3f/2wVAmTBrMqaDmdGjTKt0AqbSkx
	 97tj/l2r23MalKc/ingRhKlRlXWkRW1pjllfd7rXyMGpOatQYwoI+Yo4upeXu0ROJX
	 SrEmPADQFTI7g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Thu, 16 Jul 2026 17:30:18 -0700
Message-ID: <20260717003022.119437-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717003022.119437-1-sj@kernel.org>
References: <20260717003022.119437-1-sj@kernel.org>
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
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 322a295ac2cec..bd3bbd421392f 100644
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
@@ -1384,6 +1386,7 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r2->ar.end, 8);
 	damon_destroy_region(r2, t);
 
+out:
 	damon_free_target(t);
 	damos_free_filter(f);
 }
-- 
2.47.3
