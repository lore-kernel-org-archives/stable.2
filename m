Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BDC348C63;
	Wed,  9 Sep 2026 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924745; cv=none; b=MyXhjOlc/cttT0Qaw3wScdVyL7JmlH7M6RsBJF2VWR/JkJjen3YtlGVsQAdfCdKwAQcyFX+X+XkfHAcDDHntCfZYPOuyZHi3o+/V8fMsl3HuM/uG3YiUlrHfNRgiiyIyXBSe90TeelkoOwxg+AfuqM76Axkh0ol2t9V3+B5zheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924745; c=relaxed/simple;
	bh=Nll6ZwwPuyr6qoJ3nNwpHXSi+9U4EtB7FAhESeZQMsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhckCdioAl0MNV3grEZq1AN5gEO+JGxOqiI1zHOF2Eg1FacV6+bSeX0MX8lZaD7n7+OVCUSzIsRHONXTOw8R08JpOurxbte04F/73Kx5Gh5K5wgvi+BDSZ0M8ao7CxT7kO5j3R96yqMy3y7YQgvQnLEDtef/BxMlCEiIaXmgBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvqNe6dx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvqNe6dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ACC1F00A3A;
	Wed,  9 Sep 2026 03:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924744;
	bh=3kn+Gctsm96ES4+vGfS+3z35ShTYAttXRKN88Izlnv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fvqNe6dxMGtmeTFl8McuWyzS5MO3WfnBEuLrvf+5dcDjbDWjaM/alVqAA+bp2+2wJ
	 3C/+l8guO/RojW6Udpm7LpzC0KuPGHRDO3iihIPzJjCH74Fb6rVTUmWie2GSMHmewN
	 sOn/gP5m4sVldV0+F0I9g5ooBZgB9yUNx7tRpriyDByZ5KHdJVQGhrNlezrup4QikA
	 i9xTNObYtIxXKw8d+Brc6/CMfDL3BL9GiBJbDvdTEbtyg9jGqyh5lWa2NIynZbgq/V
	 qyQHXgXza3EFsdTCH1jGzr7qAPd0v9iQxsLhyPr+1AvjLbChbLJv6rYXtd0HZTXwQi
	 5Q+zxI+9GwWqA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue,  8 Sep 2026 20:32:16 -0700
Message-ID: <20260909033217.123340-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090808-snowy-dynamic-3f12@gregkh>
References: <2026090808-snowy-dynamic-3f12@gregkh>
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
index d7737f5df6688..1053d7acd8e45 100644
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

