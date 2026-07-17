Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD721E98EF;
	Fri, 17 Jul 2026 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248236; cv=none; b=R8SC1t6DMW8LyKQilkvS1NC0dwDFon1RcpVEb0xiWLddnzO23rG3xUCyUWzl+hdCuylcYWLhcji+7eWJWOVQQY+LV8PPbrHV7yX1I5lilfaS1tzYzpQnNdzINZjAhr6NEPPVpDCtdb7EfbszBCPq5QbW5qYcRtdrUtfVOZMRKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248236; c=relaxed/simple;
	bh=429dxDWsLoZqs3hLsuraUj4utp4t2KIte1wMXhahrBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcQsM2FVE5oHWP5QIz/pvVzL8IxJau/Y+r8V1yQ4FBhPQVu3LQrnZWfbNMTZ3uHyuf6wnE1K21mgfchf5hCs054jn48CNMTlmhzDiHKALA23AHVbpQODRfilO1Nb4kSis85WD47RYBtHCNPUvrd3QUg8jMXpr7HoMcWSYQvJX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqolhtq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqolhtq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61691F00A3A;
	Fri, 17 Jul 2026 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784248235;
	bh=f7BiQZV1zrUqjFiVsCPj2Z4br9MeBNP7ID/eB73kzGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqolhtq3pNMNCV6TzxvelK3yiflgKnSTGhs8DriQEmCP7BXbeP6k7IY1RXlfOhhIe
	 F1kIvO8YwVovdkAl/R0KGff+TwEU8nRp1e/xwnHYkhbt3lCZQPIOa6ZRHXuJ8beLD5
	 HExug7NiAVnfZ/Y65FhtLbbe4iwBHsdUDdKPvDHZ24vZ/X4WePwAzs+He7jTrfRHsc
	 5lKwSDxin7ncC41nAoxcJ3ZcsVKd8gd20s/Ratm+rLD4cupNU/NeywlQU0Hp1i6qH1
	 KhGlKZ8gD1Li5XDZGNwngrpG/lgXJC5lVop4aUWG7u3DV+olPmEZ2y5S1Fb5jkPo06
	 Kx6V/SfZ7wdug==
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
Subject: [PATCH 7/7] mm/damon/core-kunit: skip wrong region walk in commit_target_regions()
Date: Thu, 16 Jul 2026 17:30:21 -0700
Message-ID: <20260717003022.119437-8-sj@kernel.org>
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

damon_test_commit_target_regions_for() traverses expected values array
after damon_commit_target_regions() call.  It assumes
damon_commit_target_regions() made expected number of regions.  It might
not.  Because the traversal is made based on the region count, it could
do out of bounds access to the expectation value array.

The consequent user impact (out-of-bound access) is quite bad.  The
realistic user impact would be limited, though.  It would affect only
test run setups.

Fix it by testing if the number of regions was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org

Fixes: 603f67eb91e0 ("mm/damon/tests/core-kunit: add damon_commit_target_regions() test")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c0fc903a6a259..805d15a64500d 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1277,14 +1277,19 @@ static void damon_test_commit_target_regions_for(struct kunit *test,
 		kunit_skip(test, "src target setup fail");
 	}
 	damon_commit_target_regions(dst_target, src_target, 1);
+
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(dst_target), nr_expect_regions);
+	if (damon_nr_regions(dst_target) != nr_expect_regions)
+		goto out;
+
 	i = 0;
 	damon_for_each_region(r, dst_target) {
 		KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, expect_start_end[i][1]);
 		i++;
 	}
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(dst_target), nr_expect_regions);
-	KUNIT_EXPECT_EQ(test, i, nr_expect_regions);
+
+out:
 	damon_free_target(dst_target);
 	damon_free_target(src_target);
 }
-- 
2.47.3
