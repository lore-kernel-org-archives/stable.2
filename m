Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79E42B320;
	Fri, 17 Jul 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298896; cv=none; b=Da3PLfx/+3iUyyHNnjbP4kWUjT3N8kAFtRyE6ydDNONzK6GQnyKgxFdLkKQVXZgJMP5/dzfP5H9WNOx78YJdotcolvZGqXJDop7pYwk4Y8tPowTBSZyx3mxyWFTbACzfhtT1tSDKGznt+YGY9TsCGC06E3yXg2rv3efZi+iyUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298896; c=relaxed/simple;
	bh=6cVktXVE8rSuUMJmgI4PsGketuF/LIliSMcwhDwymn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEquGatndc3fvWDnOTFD36NUq9+c4IJI8LYy5arcggY8PVkeRbYhRAczwv0A5wavuKINQi3SJQaH8Nv2LJJvnVY6NvdFtNUnuCMOdlh3FWLSdeH93BDxqD2FGz01Z1P6bVrBd6PA2e6mVdfEHOkaiAMwGVSJB3fHwO02fpSi4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npu9wM/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npu9wM/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27521F00A3D;
	Fri, 17 Jul 2026 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298895;
	bh=VuPFx8TTNBzLXDK2qKBdCiBzn3J3hO3HBSaJVXSFOsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Npu9wM/TLqqMdaAfSdeHwemKOKxjfT9xquH/SBQ26zMAMOE0gMCtf5t0szwG8Esb6
	 poykFcwsr++2y3b61XYNM4ZtqCTntwWmry6eL45jnAM9cacxRqDddpe0DtP1L6h2kb
	 Ox90FQzu37+vqQYUTEkt3oD2W3I5KlGsPqsrtPnrmuSuxEkXB81yTLuCTKo4joNX5G
	 UrsHYdslhn9ry++WIowcwhKq0o1DjvQfjyW9i3nB08avw4UmYX4a72eqUcS8NJuKE+
	 Wnek6HrXSIIdsWTYk+j1sAgQSrI8KKEgmzsM3TwgdXi6VSoS8Si4LFTC8tf1v9DHlj
	 ni1I80XOT1qTQ==
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
Subject: [RFC PATCH v1.1 5/7] mm/damon/core-kunit: skip wrong dest walk in commit_dests_for()
Date: Fri, 17 Jul 2026 07:34:42 -0700
Message-ID: <20260717143445.91207-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717143445.91207-1-sj@kernel.org>
References: <20260717143445.91207-1-sj@kernel.org>
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
index eddf3a0484583..9b8c20a50ad53 100644
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
