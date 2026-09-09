Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8F242D70;
	Wed,  9 Sep 2026 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935528; cv=none; b=oceGJX+BahEBkOdIHfVAzCaktH7k4q7OTsfP9fCuyienzT/KHNs/N0WXbwJO0jwdqa+/RaRBQ1PUNf242h7lMx2D0V8cfG/9Hh4R7AHmhGvUbMiG+O0nSPerfjxkS8he/kUqIyGQLO0fltxynMe6kp6xu+iPAKB1j5N89/He4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935528; c=relaxed/simple;
	bh=yELPdQF+Omw0vXyXjLn6OVDxsNcoeiFYUd60ADXbfWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4xXctG8uvzpv9K9Q5COgEXm/IORGU/KAEA0pAQL1XdiDwFxjH8dFoBLjjJuQSBHYXdJwl3y52IqOfqL1YyxmvncPF0Q5PmejvfkSYcwGacl6ewQxDuIngMJ+sicsOrNGmoQcZbClIo+ga6Dy2Nmi6bBY63ak1B2lTCuPH+/xfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exmYd2tN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exmYd2tN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52A91F00A3A;
	Wed,  9 Sep 2026 06:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935527;
	bh=2Vx7xmWYbur/vutWySXxlaNJStJPVrPK1WxT4I2dRPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exmYd2tNjEbrS1XtaMLE9kNLuT8VBUKX5uE/hqET+uGz5dPFE2QkTf8nqtc7S8OE3
	 K9OooDSh+Bb3k0z5ogSsd7JXJcfAYSwZwSFomq686AFHxnf1l7mopqD8EtUrsQ8DaS
	 bvCUyLcnpHC0CQyq6HFmzhgJXnlLgbZk6RBTrFm4J8sLk7FTWA7YtycTlCGD1ndlTt
	 17rb40gbipT05Bl7C+e/2te/j5UAixCG/5IP8hLv4/Mq+R1IjossXU59N3mTxqhPQh
	 KiS5fTod8ahSOhzIJHVewyLI3KTQRsUKa22igQG2wjIQRsMF1kJKon/j/WLsw9TSZn
	 59G9DipAm4qQg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue,  8 Sep 2026 23:31:59 -0700
Message-ID: <20260909063159.63420-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090808-phoniness-repaying-46f0@gregkh>
References: <2026090808-phoniness-repaying-46f0@gregkh>
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
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6687778752728..7a3a923dec7cf 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -264,11 +264,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
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

