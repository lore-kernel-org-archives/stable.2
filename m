Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6E27281E;
	Wed,  9 Sep 2026 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926980; cv=none; b=FlRZA64EkxSozblFjUMrJirOgQeyZEqekQjziYC8hSzAhA6mmQw+//21p+7Mt3cpDzL4gBx3TqqwNk1KNI03e52oIV45dt6OyJCJSDmWbI8vxSWmC9Kn5Xr9ij29mywP+ULR2VIXOwOy6AMqOjZggWbkYwcy9p3YyktGrNzHpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926980; c=relaxed/simple;
	bh=eJcGx5IEw7ePoCqRjOh5r8V1vKbpaDtv+9MlXawLmdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRDC4NH0cgmCluCCt31GlL++t4wmSZi1yoUzMlXdo/iK3CIupagSHIfdln6L/6OE7nW7Zhh0fWhRV7wxtHWckDDrrePVuHgyJr8xbfQEx44c1/Q1CF/J0Bvo5RXzYwzKuLI3OG4OOtNo2qJ0WYgONPZgSJ7/nsh8AS39GLnDwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxbcnux1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxbcnux1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236B81F00A3A;
	Wed,  9 Sep 2026 04:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926979;
	bh=ZlXS/KIO8QDthOJQHijofPigl+DKHN618yIn11FZKwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jxbcnux1IHbiHBOXpLlwpcJqqC7G5JZo7TnBuiX5/2SmYrbiDEo+22UY8cYM5XtW+
	 M7bE6heUZNY+I2wa3ZpsqPkc5hVQWT6F2BxIFygKt4wbK6EJDEFEukxmKDEIZJvv9a
	 4g63sbPYi8aEXtv1v6pGb61hKLy23MPB9QWBhuYo/bziAayA8eW+kh+UuLA8ydJvyW
	 C0/oHSNV+lhT8liTLDqH1/Hn5Pgzg0XjM2oyiL/rsSXRaXgn9PXrOwam3GZe1piNzL
	 oYQH0Fr7H1T+Q2KPcwP1VXvq0974u8vGKUhXsRq3hJLO96aGAuBgg/FsS/pgKxcyf2
	 mJ21Ww4E5G7vQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Tue,  8 Sep 2026 21:09:31 -0700
Message-ID: <20260909040931.177877-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090831-handshake-cytoplasm-0b8a@gregkh>
References: <2026090831-handshake-cytoplasm-0b8a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_test_filter_out() test checks if damos_filter_match() of an address
filter splits the region as expected under a given condition.  But, the
test continued regardless of the split successes.  As a result, the later
part of the test could dereference invalid pointers that returned from
damon_next_region().  Further, it could corrupt memory from
damon_destroy_region().

The consequent user impact (memory corruption) is quite bad.  The
realistic user impact would be limited, though.  It would affect only test
run setups.

Fix it by exiting early for the number of regions test failure.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-5-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
Fixes: 26713c890875 ("mm/damon/core-test: add a unit test for __damos_filter_out()")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3423fe70395210e2f0cd795270292f6a27cd57b5)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index d7737f5df6688..a9d852e666657 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -552,6 +552,8 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
@@ -565,11 +567,14 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
 	damon_destroy_region(r2, t);
 
+out:
 	damon_free_target(t);
 	damos_free_filter(f);
 }
-- 
2.47.3

