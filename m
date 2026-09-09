Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB7492E34;
	Wed,  9 Sep 2026 03:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925518; cv=none; b=eZL66w3ImErzMenHrRDxODTujzwNq/DBragzaztXuqo1sHI510U1C9AhfGJMzHEhQwjZU6nxASJKcrX1ncuDpAlrOxb/QDf0vAcr9bdNzeSj9k932TOfYzJI67NDxexpqod4swy2l2PtqCEIKAf4PppO3zBEavKf+TdYJ3MHGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925518; c=relaxed/simple;
	bh=OgBdTMiOSO4mWM0NMai55l/3o3ESJIjHRlBT0NFiQeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnZfyCaOP8jX024B0F/56wgnensAElO8p0Azjqb7Okf+YLykuQ7nLvjNFch3EkenaB+ABa/4DKzzzZI1mf8J/3/QszPBiVEh0fAFJwx0FshJQUDoGy8jV2lG/mhX2ilwvmm26bI3z01k0exmAKB6DBrkUfL2bg8T4nnQF6pa/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNv+1JOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNv+1JOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752111F00A3A;
	Wed,  9 Sep 2026 03:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925516;
	bh=sgl4dOjid3ViaesF0HbPp1/4EKDbGxPZqbY+ws8lPS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oNv+1JOPCzl6RLHCgd3x9J0sdTPuirk2eoXGZ2p0A+n1wJr3MFV64go1Prw3+U+Jg
	 o5FQkP0BB04agobr7dAkpshMvT0QIYlpnu+H0vjL4F2MEQqgJg512X0bd9ZB98l5xZ
	 eNBW5PMPbg6OXJHiZtzjOMLfREft8Q6gTav37UWGTKJeOv3m+gSt7eWhWph9xQxuSf
	 YEmUHSAY6nItBJfJYkfQQnQmI7ZJ9Q3ean4c+j43F3LPpyuAajKqDSeeUb8W9pT+JV
	 V2hN0/06wiOblpIc6LujWF0mWJW9bz4sORgImR/Pj1fr6yv+Koa9wpa+6z8DbgwF5X
	 iZj/swqzGTW2w==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Tue,  8 Sep 2026 20:45:09 -0700
Message-ID: <20260909034509.142303-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090819-haiku-machinist-83fa@gregkh>
References: <2026090819-haiku-machinist-83fa@gregkh>
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
 mm/damon/tests/vaddr-kunit.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index ed2845d9f9a95..9eead9882dcce 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -149,12 +149,17 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 
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

