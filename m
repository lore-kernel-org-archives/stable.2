Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0825C6EE;
	Wed,  9 Sep 2026 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926880; cv=none; b=Ml9BITa3Nv9zGOke9bPs42g4bfmyvhefyAc1BG9T0jJKpff+bl8PSA3L/yztpZMnWo5jAdyJTX5mIPdM5U2pvm/ErSt1EDO526d0iXqYMsJHeHi14iLfzDpRHVtFaukMjZGkYAtnJqqUb983TLhi7REJe19jG8pY62B5bOGI+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926880; c=relaxed/simple;
	bh=c66nmFSM8QPg2eH+Rzz9sdB/7tDlvbsuoNZBzK93QCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1EbmZRD0QOZpE2RV2eiBLnH31TyB1y1uPpTC9EMBF++ZNBDeBveWBmhf0Kr9e6CSNtWhIbCDizh9tKEChzrRrtsfOvTpla+wTbSvEYcfPjzfQHz0l6ADM7VUUFYsIvO5vBgYrxmVd5irwokrMQmhquALwoF3cV2N0U10tUlN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3fxTmaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3fxTmaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67A11F00A3A;
	Wed,  9 Sep 2026 04:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926878;
	bh=7Ct9vgYUWyIwmcFkRyxoIExeGvSyKZDIr0yxciZFpN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f3fxTmaFOZpkmMGe1LX06Z3V/rV9z9b4I9J1Z9N6pyC34bncWDpXC6bdl7GL8K2Tj
	 0Sp2tVuhgUDYuNONP+Rxt+EFCDuBKZX3r+rtlBeI6/ndIldDbpgRcYxhhr5RcynZuG
	 NSBIcpVxuB0SnJj5blqZJTIbjNaTwF3r3WCiJK20VIgQiSIkcrnQqS2G6OZx/gPDzn
	 FjQYaaes29CuLKxVT1U9mtb0SfQK2YPyMJj4EvwcVwTshTjamPXHx5cAaU9F2Y5EYF
	 YX7+PfyylM753WT+6toiFsC0u38vM8d0gEgmeeJLGX8dHaaNNBG+WBFbNEgibBvZMX
	 H3Xi/oKMG40VA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Tue,  8 Sep 2026 21:07:51 -0700
Message-ID: <20260909040751.175004-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090831-operative-attribute-934e@gregkh>
References: <2026090831-operative-attribute-934e@gregkh>
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
 mm/damon/core-test.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index a2aa410d6d0d0..853cb8902d5ef 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -497,6 +497,8 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
@@ -510,11 +512,14 @@ static void damos_test_filter_out(struct kunit *test)
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

