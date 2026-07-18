Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43217BA2;
	Sat, 18 Jul 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784333688; cv=none; b=Jug6Ssioztc8iJc1y6+wzrhxE71kaxO2p+H+CjATEEGqqxuE16ZA81cOEu0RWhXqdLlYYVOFw3yIp0hFGxPVRBEIllGwvaaHIZvC1m8NATvFm9nwBHiWD/DHZSePis57XttZkB2PkZUNsEWDzD8jFB8S/e3YCbrXS5geDHdQzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784333688; c=relaxed/simple;
	bh=6cVktXVE8rSuUMJmgI4PsGketuF/LIliSMcwhDwymn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duXSftHgVdNkIZZP/bh3G0yuc5nHVtyQ88vjuGhc09WCOE8GtgKkZnx0sWhL7V1lV207nAFDjAzRkKn1bQNbYEDd0/GV3DFxZ+d4yaB769dSAHB9ivK9Ibke/Nm+LYiH6Dggb3j82XKIbhX00wBPTWamx00Qivxo0MLNyHSS3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEiU48dQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEiU48dQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5D71F00A3D;
	Sat, 18 Jul 2026 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784333687;
	bh=VuPFx8TTNBzLXDK2qKBdCiBzn3J3hO3HBSaJVXSFOsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eEiU48dQasMg4plbYEWGNgKVXJ5EpuET9reLcOHgUZc/673efrBRai0hWabxe9XhO
	 A6jsgZ9ZXiEFpmf8ku/81CuxtgTVkf00XX8dF2vZRV61SJuqfYbhzL4r7Jt6rk806i
	 miduKUOtGaIMwB+rY8c8DRkQKoTIDASZ7RlRZkaGgVAl8XkUOhvl+M98n2J3pKEmdB
	 1HAeQUfI5xAOZiL4dhbW/6oUq2CzsRrb8RCcwcxrBYfdjyIZqT0m8o0VHquzWxFwi8
	 v3s/cTEElQySXsW+N5kft/xyq0LX8WjmSgbiC9oRm3yP1J4WgluIovftrTz19V7Usg
	 AtBsEX8sXX+ng==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] mm/damon/core-kunit: skip wrong dest walk in commit_dests_for()
Date: Fri, 17 Jul 2026 17:14:39 -0700
Message-ID: <20260718001442.87129-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718001442.87129-1-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
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
