Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306022E3F0;
	Wed,  9 Sep 2026 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925752; cv=none; b=azkkne4SbolVEwWUuEDq7c1ozOWH+id6Ov1mX1KOIQBATJ5E10IcTM806yt4m6LoGRt/DxbugBVCsvWu9Nq5A/PvVIknHmaO+MBV9jK0qeDS3h1sv79pLXyR5xA5KCktOs2EG145g6FF3PleabCN0y0ChgV4I2m4ijhWb3Ggbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925752; c=relaxed/simple;
	bh=JNfD9secVjTpbolzoBmoOAqHtw3wJUia9bB7lLetEtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBFwCbJV7K08no+uolqM+RRfxl7N+OF7sPEhmaMZ0wKeFvy/J2YchCZlNIcaysuhIHeyvOOy3krx6Ah3YeFucZCHcURMDtPOzN5f/3mmQkpT8BiSxD2fwemT29abUxGBu2VuvNiskDxMytVQtDy/xPnnMnnXM1kFfrnpXDm2bSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTlehlij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTlehlij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A171C1F00A3E;
	Wed,  9 Sep 2026 03:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925750;
	bh=bYDmN/DpTbMv3SP0cwt+iWlfDXr4gbYExC/IbeN/f/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mTlehlijJHqsEIvH6lMLm+N7/pTDCRSX8xm2bsbJGcdm7FBZE7+JKCnTeWy+ojXEO
	 c3+U2XKwia3CVXxiksneL2vuv2TXgJdu6CD6izbUVyOw6IfEFlM3sS0OycfM+aE3Is
	 wMckNbvZkJNaRO+8Op5g+Vf4+ateYNiZ+MPPhfFtkXRYldvs1J9esx34zQZXSXLSAu
	 GvVo+7QlzA753tzmqNsGljvxMDmWOWAns1LNZzEJ0TkExdb6+UB2/4idigS06yNlAF
	 tThVoZ6VOn2/0HJclaol/KCNLvtwlFF9LYNAF4R6ApUTIcJsuCvbCEnnvxh7JcW42k
	 PeBUnzCkfaFcQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Tue,  8 Sep 2026 20:49:03 -0700
Message-ID: <20260909034903.150500-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090820-shadiness-speculate-ce42@gregkh>
References: <2026090820-shadiness-speculate-ce42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_do_test_apply_three_regions() iterates regions after
damon_set_regions() call assuming the function would succeed at setting
the number of regions the same to the expected one.  It might have failed.
In this case, __nth_region_of() in the iteration could return NULL and
NULL dereference can happen in the test.

The consequent user impact (NULL dereference) is quite bad.  The realistic
user impact would be limited, though.  It would affect only test run
setups.

Fix it by testing if the number of regions was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-4-sj@kernel.org
Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org [1]
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5fea07e460874c8c7cf00f728efbe22abc62c8d8)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 292736d3f3954..c0546447b21e6 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -149,12 +149,17 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 
 	damon_set_regions(t, three_regions, 3);
 
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_expected / 2);
+	if (damon_nr_regions(t) != nr_expected / 2)
+		goto out;
+
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
 
+out:
 	damon_destroy_target(t);
 }
 
-- 
2.47.3

