Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FC23C4F3;
	Wed,  9 Sep 2026 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925247; cv=none; b=aRY8GyiwGevSnemj6hYNszMRsFXC6yhh0UWRrOKlz5EaeAYmW8VwU/Y6j671wPjJUZKMWoKtEsrC4152B2VbTrA6M4AcNEAKxBXfhX5WHRhe7ayT33TOUhpBdZdmOQHYHaCNRzxjFxEK6JF1Pucpeij3prSSCK85XBHfUlTBg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925247; c=relaxed/simple;
	bh=EM2Pdu31aicwyv/mzGzY54WiLWLXFL96aDnk44KZBl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMhyfS4hS4KRnjFZ2rEfuZt4mvJknoYQ0R3GnqpoLaKYTEDJrao9Cj+HXZ/lnj9mCmOLhmMhQBWvfgE96NEkLICH/z9fYaYfj7tfXo5aCmF3tubFuICJejcFY/s2TrVsLl7r35OV4WPTNnwOmOvlvxaIhKCjHISr24MMe8Ppor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nuo58iJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nuo58iJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABA51F00A3A;
	Wed,  9 Sep 2026 03:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925245;
	bh=v1IsxGtC9mUTyunF/BWsPeYhvJkyYW5HoTFhqrUsPQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nuo58iJZhA1ZL+AuM39v2/g6zzl8nHSudH9djsnlyV7lK3F6sDZazBxnwmOkCy1eH
	 F6vP9kp1UG+Xa16gY4LMPe2Vv+FlUrJojYTYLEWzgNahU8jmj/uxUuMA+TbA5oQqEc
	 tChNR5/xoGplu0NnuZ1/+sQjlntKrkIFiiF5pPLu+5hbq1SVugCN7TZDBkrGeTrPTN
	 J8iBnrEE0YtkBTAP2+myTZ+jkLj993vMTOWS7Vgxst3TiKApm0TxpozQqGgKOET72L
	 plK7inFK+R9bKFs6HQwX0dZPYe6zNPx0gk8uMvursyHdOg1NDjv7W4tai1C8xFLqmF
	 2NClCfAAxNrzA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue,  8 Sep 2026 20:40:38 -0700
Message-ID: <20260909034038.133054-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090809-perky-underfeed-c314@gregkh>
References: <2026090809-perky-underfeed-c314@gregkh>
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
index c19da2e3d4936..3350293761c4c 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -251,11 +251,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
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

