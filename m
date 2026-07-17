Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB941F1304;
	Fri, 17 Jul 2026 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248234; cv=none; b=hzX2SjkpW7Kwj6fPg5sr0u4S93rq8Ju3yt2sT1pM67tMX6on2fA5N5bhAnkTu20Cj8hS1gGNAdLOih8L2IxOYK/Y9yZi9Lp4NwhmQu9KtUWCQisHHgA4ncn2lsoDVMguc1U1cCnrv7nZdnQHJwH/65P3/QsFdhUst8LiG/5tF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248234; c=relaxed/simple;
	bh=m0vrFx60LsajtXXWvXeyGJ4ELnn46NTe35fJet7iEZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFcc4fiO/lANxa8ckMQffmUnNJimZJW0Srl8CSppieXulKNizTOI/dNYYewGe8rXwheRieezWtEuzzTf2jLAFu2qBDtxNu8afyMoHW6oP6hwshERs0GYfofPK06maRmduQ8VCSag+E0pR1MBnf5gto75A7IcRkq7eKMq26IiwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqisgCPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqisgCPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50681F00A3E;
	Fri, 17 Jul 2026 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784248233;
	bh=BYUt77gOaLnD9RIh57O9y6iLCV8DgyWvyhX78FkqqnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CqisgCPZUl48Ou9z48ijZHhC5VH6czNR2JUuXEuTjLYfK+ABnTZ1WYUSJBBEaJViq
	 8rcL20cpZE6eakFxXsNYDoCnNmbsUQuBDPFL5BJBrKsm1n9bNaN+QMZc39NeuAQ6Q9
	 t86qtkDK9Az16D6N8+psM/fNs2WLzHfhND0FtkqFUfUTq7RdNMJlHpKguDa/Qiwrih
	 Timl+MUwRCOrDdUSg1dIKaGW8mDwEGssjBW7epSJimjnAvHa0yuFAZDKkBgDfpAQ+P
	 nRzjhDyTymsNH1CqxnykxkbQbZE9DGveByiWJjSIMkjP6TNkAAu0mBTeIJ6jMXO3DO
	 w4dwIU8QJYudw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Thu, 16 Jul 2026 17:30:17 -0700
Message-ID: <20260717003022.119437-4-sj@kernel.org>
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

damon_do_test_apply_three_regions() iterates regions after
damon_set_regions() call assuming the function would succeed at setting
the number of regions the same to the expected one.  It might have
failed.  In this case, __nth_region_of() in the iteration could return
NULL and NULL dereference can happen in the test.

The consequent user impact (NULL dereference) is quite bad.  The
realistic user impact would be limited, though.  It would affect only
test run setups.

Fix it by testing if the number of regions was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 61f844336ffb5..6a95441d193ae 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -158,12 +158,17 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		kunit_skip(test, "second damon_set_regions() fail");
 	}
 
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
 	damon_destroy_target(t, NULL);
 }
 
-- 
2.47.3
