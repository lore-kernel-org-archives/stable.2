Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8A3BB669;
	Fri, 28 Aug 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942219; cv=none; b=M71kxZ94cTp4flR/C8cEfhzuwvL5LdOv2OFT0CnzFNwIaksN6+ju6f8eqKORYE39sBjECg5q24vOCZH96yjZBVDXQqUijOxuJm8gzXukytVLswfcX5BdH1VDTp0dmWUBbAAhFD6ZLh3cfN1yw8QG+kyad+fBOYhOlFZynl3LR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942219; c=relaxed/simple;
	bh=zYSmy5K+uBSKqiQ6mGp6GOZRIgNJU5Mho+lWnM8XtL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3kJhE1fcfuAbn+HNlpVb8q6BHr5pwtFdRK1WIPADDupfi9OuPQo3JnMG4gSbwtOCav3SqFR1Mf3P5k9OIhHbhJGhfGs6Io6bSoxVesG+DhpoEnNLq1h5XNkoy8C3TSuJFX39UphoPt3OlpsP1GvuoXNB+tGlfokf53ez8gkOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T05ammM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T05ammM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555551F00A3F;
	Fri, 28 Aug 2026 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942218;
	bh=+fW2+xE2H0LI68hS7+oEWra7KzRlcB7nNxeFxWmibVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T05ammM8ldq+G6bXx1kNn1wOtHyf0oeGDeu71AbtcDekKRYIydOLwGmjIc9uhk9X5
	 Ir3MfGZmKvcqnkGMsfP8dOUx4l/yB+CvyNAfA3lDzGNCMD6g2BPsqrTtwdNJVnoCvx
	 x1C585X5TVS6xngWNLwcL2NnOeE6d7obk61ADtzwmfTa+0WnSTIjclPNl+itxnCpcT
	 mRSGfb1O64QAV7SL4PK/Szh24CsX3fnmtH/wtaGh+HCbK+a/AVTQwgQzNpUCLY83SI
	 EmDj1bcECwJxe8t9cIV8/9Mqx8I4Y0Lxjh0L9855tu+uInpjH5wGvgdwEQS1SVkFl/
	 kCjORItPBKqAg==
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
Subject: [RFC PATCH v1.3 1/4] mm/damon/tests/core-kunit: test committing psi goal to psi goal
Date: Fri, 28 Aug 2026 11:36:45 -0700
Message-ID: <20260828183649.71192-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828183649.71192-1-sj@kernel.org>
References: <20260828183649.71192-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_commit_quota_goal_for() is set to test committing a new psi
goal on an existing psi goal.  However, damon_test_commit_quota_goal()
is mistakenly not covering the test case.  Add the test case.

Fixes: 99f89debafc5 ("mm/damon/tests/core-kunit: add damos_commit_quota_goal() test")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4a536d41cdb2d..b643f9a83f14a 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -787,6 +787,13 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 		.last_psi_total = 456,
 	};
 
+	damos_test_commit_quota_goal_for(test, &dst,
+			&(struct damos_quota_goal) {
+			.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
+			.target_value = 234,
+			.current_value = 345,
+			.last_psi_total = 567,
+			});
 	damos_test_commit_quota_goal_for(test, &dst,
 			&(struct damos_quota_goal){
 			.metric = DAMOS_QUOTA_USER_INPUT,
-- 
2.47.3
