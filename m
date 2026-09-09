Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A33546E4;
	Wed,  9 Sep 2026 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926425; cv=none; b=EwU596dRd7WK4BFRJdUtiLMGZLwLj604XdhAnKIO8Y/f/cTSQKq/KpYLnGKDV7Mcm3n0FJJL2RwkwYkZLbq+8mgnx4rkGUJE+79gtPEOk8rbiAgNXn0K0CuoCWf7IXPJOq6IEFRlR9u86CEpSBy3Up2rXCOlMjFXG/wlhsMa0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926425; c=relaxed/simple;
	bh=Izh8nFGCrYRuI9cJ9/oXXn1lyeBJJo+L7iFMIfA5Ats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blpBvsy3f/cujqGdAb1MAtWUnHShB++07sIYFhoPaBpN1eY7QZdzqoGRLFIPpkqHtGly8dhjiGBQWo1w/F99wYnt1tYcRzEwE5/abgSCncrTQeJ+502Vqb3OGnXLHXOaRvXQi5lLFOsFaDcTZ8fR4mRfmnaYJl9XxDK3X/V8yGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5v0nivs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5v0nivs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6361F00A3A;
	Wed,  9 Sep 2026 04:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926423;
	bh=rSaknwu6P4+tcrb9zhZBWOD4Vc2DO9fw58kZ3Ev0YyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5v0nivsqBUw2uWCgVeyLakW5Vj8wBEQd2TB/WMF9I+wiRSN9QEIt7BHskTSN9MpL
	 9sypQ0XxWwbGpMeJixdA4vSlbM1WwC7C19Kjd0oQs0w0ncQwl39oMJG7pLq6AgWsB6
	 reZ/qCmdXndRYLS9XffVrqhir5q6kyLxK9PtZ2wWUX7HsG1+sNykj/dmlXWDGkMHov
	 QSEfkepRYZpHa/ElmWX+sF1aVtyWWikZlXv5g/E46VBn6ck/Oo1MuKv/dKxrFCx7Rj
	 iJk6cG/gsuhQAjpAyDzraBcfdKdLAvGqQv1ogAktJSuBvdjy/K0R/hRVrkP6eMHhW3
	 NjSePhmC0qO0Q==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core-kunit: check region count before testing in split_at()
Date: Tue,  8 Sep 2026 21:00:16 -0700
Message-ID: <20260909040016.165245-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090820-attest-sheep-bc32@gregkh>
References: <2026090820-attest-sheep-bc32@gregkh>
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
index a2aa410d6d0d0..f2f0978495086 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -162,6 +162,10 @@ static void damon_test_split_at(struct kunit *test)
 	}
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
+
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
@@ -169,6 +173,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
 
+out:
 	damon_free_target(t);
 	damon_destroy_ctx(c);
 }
-- 
2.47.3

