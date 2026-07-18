Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB318B0A;
	Sat, 18 Jul 2026 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784333689; cv=none; b=MJcMx5orhflxeZLNCwCubILTbYyHYINWseDX40kLYENXan7EpR63L+lo+TaA0M3zi0OGZKBLaoVPtz0DwzW3/OX+z8iWrDC84lfg/i6ewWYRMiA8s29IJCRvUEtFOYz7tYRApAkXAXA9CWBc5TaPz+dEitVxdnllPcGPKA0AWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784333689; c=relaxed/simple;
	bh=zOJUHYSF/SfkTCPWN4DkTs3aKPcsBPC82UqmWEWXMmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7XMY9qWo+D88bIXVlBZZ4sXsWvNRQ/q31gH8kiVgMlv0ykD0Gfxc7WimH+bOe0Z2yp1IJdMS+qn3SNqL0vW98cAKIuKlJl197tzVXWS2ZNP+OD11BEhomQKijAKGoDwlslNcR7jGmJx6JhncyMniQBfdKeRbR7Qst3dPjTdvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcZST0Jy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcZST0Jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9137D1F00A3A;
	Sat, 18 Jul 2026 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784333687;
	bh=hlaPqrC6aZ24tUVqmNoMgW7uRiUtt18MWvor7D56nnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DcZST0JyZ+VsKqU9PvOID36E9CRrNSLnOGd8EFTWxNPgb/FkFEKw7G8fsXiPmcgtU
	 Aw8pWXa/P+qt01XtysDSejd52LvREX3r51PgldBJAJkTI55yAnH92FgrZ0CkdVMnEb
	 Vu6V6vKTRiMWDLz7evQItMSQZ5WPpAMRxFipilfAbj4fr7j+FmkqR18ef4u5lr6AoU
	 b6fKlaC1YHNFVRf+en/jSKYQRAz6xfr3IJm/QmICHoIjDEfiRK5f1OGbBQy4v3NswL
	 lStie6B8ySy71K8yKxdIn6i2qT1+Ok/VKVQ/N0o0O3PaqT+qtPQLncD3da9gsrxScq
	 UjnGKstrcxxVg==
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
Subject: [PATCH 7/7] mm/damon/core-kunit: skip wrong region walk in commit_target_regions()
Date: Fri, 17 Jul 2026 17:14:41 -0700
Message-ID: <20260718001442.87129-8-sj@kernel.org>
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
index fbf986aee2dea..4a536d41cdb2d 100644
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
