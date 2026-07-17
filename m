Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F42459C5;
	Fri, 17 Jul 2026 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248235; cv=none; b=MbafSXJKhWBUL3e7ovn7WPi7IuJaLOQrAmd3IF4vQmGcXj/ff57ZK4hyGjv3FnORXkCjNj3zuQtg9wLL6jom5lUUpeyrqSGbZ2uTM0ih//c9vpLyXDRF7MulsULk1ObdFLzoo1LUwR6shGHwXSarg3hBPk+xpxFWcGxXBnbMbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248235; c=relaxed/simple;
	bh=b6qPxOEcGo0Cve8cMWI+4Y4GfqMfH1uVgkgWSHQqX4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4TpPCe4C+Tew9f3SrsWYc2ZxIy8Rw0jCVzXv2YS8fPe4vQqpvlybHBK6Jt/NQjFutMPW+eY6ySXECo6r021dslsi9W4WqgIo8gCo3OiySEGNnR55OyVz42sbgXiT6SZngpj8W9jcM9Wd6jj9pbc4sK14D4US1IFNJW/rjG3Tf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Vnqaj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Vnqaj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB1A1F00A3F;
	Fri, 17 Jul 2026 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784248234;
	bh=paS1pLTVHYJo6IMXrYXcRnVhCRmTb+pKMWKQvGTyqxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R0Vnqaj1PiEaQ24gvhavkmJo45EQZ7Skd7tkOu3mi/0BMO48S0WkZ72qqvrTydCQr
	 paKVzrOFteVIBL6i1sWXUhMcDmVKJXO4ubKO8JuO5se4bQu7rivEa9KqvqhhOXTvYD
	 Rpe0Nr1SZkB5vZRXSJIvFLIjJu0KShDTgq+TXIeABAuSbF08xaZzJ2HxsPyTdhMdaJ
	 FY/wnx7r0ZT87Q6E1SbZwpk+0b5D0/wYeVVtfEJpH+NR7IEmaWbPJtt9InsiiSBBAV
	 igSb9YueJgSsXacLtaUDIcrRIaDYBmMJYpVUUb5hTNk5uri8flVCpA01F+FhAS39uD
	 7rCw9ylk2QANg==
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
Subject: [PATCH 5/7] mm/damon/core-kunit: skip wrong dest walk in commit_dests_for()
Date: Thu, 16 Jul 2026 17:30:19 -0700
Message-ID: <20260717003022.119437-6-sj@kernel.org>
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

damos_test_commit_dests_for() traverse damos action destinations after
damos_commit_dests().  It assumes damos_commit_dests() made expected
numbers of destinations for source and destination structures.  It might
not.  Because the traversal is made based on destination struct length,
it could do out of bounds access for source value expectation.

The consequent user impact (out-of-bound access ) is quite bad.  The
realistic user impact would be limited, though.  It would affect only
test run setups.

Fix it by exiting early for the number of regions test failure.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org

Fixes: eec573b8dd65 ("mm/damon/tests/core-kunit: add damos_commit_dests() test")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index bd3bbd421392f..ca6ac12a15b24 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1008,6 +1008,8 @@ static void damos_test_commit_dests_for(struct kunit *test,
 	skip = false;
 
 	KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
+	if (dst.nr_dests != src_nr_dests)
+		goto out;
 	for (i = 0; i < dst.nr_dests; i++) {
 		KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
 		KUNIT_EXPECT_EQ(test, dst.weight_arr[i], src_weight_arr[i]);
-- 
2.47.3
