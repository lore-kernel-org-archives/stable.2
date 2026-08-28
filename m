Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A272628D;
	Fri, 28 Aug 2026 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881629; cv=none; b=MEgTETqzZIalChimgRspcC+zxuxCynKEHzK77kYsMn6I8DuDw82r6alt+pGcr6OdMBB8evCctEzUDX7jy4iSgAEDOXb0X29yH52dy/Kg9xC53xdzOwWBd0w5jQpQTWWF7pZRigGiul1gK4ZHsdP+soALm/4Yu2pkncxiB/GyoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881629; c=relaxed/simple;
	bh=zYSmy5K+uBSKqiQ6mGp6GOZRIgNJU5Mho+lWnM8XtL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yg9G3NBiqT3RAh94A0X+5pbA7rLjwVLE7dnXgbZN1Yeajjs0wWtnjEC2nAU6sFaLb6lishV4aoy2QR4/qTdhW0PciBhPkM1RPxQ/d7cxgaeY3y6ICxHdBINJJhihIQthYcVp61TnzgkzoUx78Qhe677nAn+Q688ocTXDvQVw+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xuo+8fAJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xuo+8fAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B031F00A3A;
	Fri, 28 Aug 2026 01:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881627;
	bh=+fW2+xE2H0LI68hS7+oEWra7KzRlcB7nNxeFxWmibVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xuo+8fAJDcKr1s7ptBMW97qvPXuQTQ65OajmrPGEFKN623syOp6xjrvpubpt0jmc1
	 jdvV00hac6IQW6Byo/XvHu9tX4NVxv280ZtBgWUEPuvcpqipr0iYGaP3SKWE8wAPlD
	 o1SOjcUA46v9x1Zz9O7fZGzkdF/M5nRTZtVPY0eZ+yZF/ezYBNY7hhaPvYUL2ES9W3
	 XhXIm6QNPHU/riWefABzT80ZfFpJLn97V2emD1UN77lPARQ63gYzwdCvR5aCVJR4vK
	 cHdZGlguq4hteRUTjG0oNaQlqR5V+OYItH8WewHHH3IHo7Jc+E7cDl2ULk482q8N7I
	 LYyQxo0baIP0Q==
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
Subject: [RFC PATCH v1.2 1/4] mm/damon/tests/core-kunit: test committing psi goal to psi goal
Date: Thu, 27 Aug 2026 18:46:55 -0700
Message-ID: <20260828014659.121058-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828014659.121058-1-sj@kernel.org>
References: <20260828014659.121058-1-sj@kernel.org>
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
