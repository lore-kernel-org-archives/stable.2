Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125FF1AC45D;
	Wed,  9 Sep 2026 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925387; cv=none; b=n/oWT3INJ1TTWgXLWRjj2ec1eLcHxJ2D1dUsO5mzBQMdWC8ZPOsFhxE23F5+sE+zro4WzbngxFDKCw6cavrtDT2Pm9ZXkMsxcBNJF3yZlM4/uedBO/CLiaHf/GErRpRw2kply07x5uH9Mc/w89q6c3xS47CZ5TGn/X5xvMxOB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925387; c=relaxed/simple;
	bh=vIN6pI5hrdWIMTi1O7LAZdqJI3QU39qxnIGpSh5VUIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrLvEnItpZ7sAjdCFs41FrM2zR/syPT4QCoq9284vBELlPE7v/bPjp79tuaE5q1zgkjgUawWeKso3eWS7pn+m1CyXnPIOBrk+mATXh8PNSws/Kp34X3nH3n/ktnTcwx/5FM2k3/R2cIP9TL3CqRpi4jtEcrDZLEvSMuWWp1fnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfd0iem3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfd0iem3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7177C1F00A3A;
	Wed,  9 Sep 2026 03:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925385;
	bh=e9FpkvDmp3PEnqr6wgedx3qxEpGcs0a2EfmabuK1U7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfd0iem30Injxw5n6GXcMj8HPgqRMjEEEQzlRL0HCJwfRY2WBS03wZK0zM27Avef6
	 4khfyBcuhH7RrPmTNkCH6CoW86Bl0s1+XF8qYgrnWMlVRRPMfPSun0GFLge96ofFak
	 1OjNmvnso4Zps06MwLuTnLgN8ohiMxvargudzuoKOHPpqz9mE3QNimY5KQp9EM5WhX
	 AuACYW4lUgcC3ySmxmLh1po6KB8y+lOOs6m4egeWRc9sLIPUvO8EHS/LEp8cMhoj1l
	 ThDOEcKBdjQLQgknwVOHjOu2P0+ZIhksMCOeJr2Y0NaeFhpYFlimyzez2dP7HU9kqh
	 fz1m0pe1O69Zw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue,  8 Sep 2026 20:42:57 -0700
Message-ID: <20260909034257.139428-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090809-vice-ribbon-cf5a@gregkh>
References: <2026090809-vice-ribbon-cf5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met.  But damon_test_merge_regions_of() code after its
initial KUNIT_EXPECT_EQ() call assumes the expectation is met.  It does a
per-region test with a hard-coded number of regions that is correct only
if the expectation was met.  As a result, __nth_region_of() could return
NULL, and the test code can dereference NULL pointers.  Fix the issue by
catching the expectation failure and skip the per-region tests.

The user impact on realistic setups should be negligible, as it is a unit
test.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit b640708929aa956235866bf7717d89018c661083)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core-test.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index d8fef225930a5..094714172e581 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -253,11 +253,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	damon_merge_regions_of(t, 9, 9999);
 	/* 0-112, 114-130, 130-156, 156-170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
+	if (damon_nr_regions(t) != 5)
+		goto out;
 	for (i = 0; i < 5; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
 	}
+out:
 	damon_free_target(t);
 }
 
-- 
2.47.3

