Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC872F49F6;
	Wed,  2 Sep 2026 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308854; cv=none; b=mhIb4XS7gq49WmfSElOZbBbml0xCqBdFXItkrX/Me77gnCB7v3sIUopeF2KQVoyURfFwkWhKxGKrROq2tI30s9MJQrYt7nMrztIlD8PfI9/GEQTH0bpM+PC1x897mgYEs+E4F19zv9m+IfLmxcLyaHTogVsdHo21mvpF4GJ6Lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308854; c=relaxed/simple;
	bh=mblgMYWNs4C+qYuiFnh28aLwABP3tVSSD3iGEowOVSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG2Rh+o8nw8qXMay9lNXXm3RFOBGnDKUnXUs5M43TyN8ngZA6JioMZ+qlYZAqbNctiE4Ez880VIXeNPRwzn1vDws4p7VfIM/dk8wFxC7/YgSH6NdWb5wlLYqQHAdX1yV98ZCPKBBtF2m/u3Wd0r7O/eVoM3mpctLNfrwZX/ayRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBp/q+jh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBp/q+jh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDDD1F00A3D;
	Wed,  2 Sep 2026 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308853;
	bh=4Aq7mCS1n7SM9+gwhZmdlAUpokje7QH5p7CwEaALh/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EBp/q+jhGmoX23PF/KR8yCsXY3rmPIUMsqyxq4V7hhR2ZmeEMYnHNawW7n+XfpQig
	 B1G9yahk9AAoxz0k8lFwwlUpi380TZXoouESL8l8Il9BLlUTCRTtJf2W/jn5dVUywp
	 9eroAfIphosA0O9NWWvBEzwx++PuM+POU6kUJqq8pFOT191rb2OXS7JgYdnz6VWmwn
	 Vyt2pKdhGytPl+2a/LsRz8Ch+GAtbWwtHxrCTo3xzwdwYa8PkzBcpoY7ZtlUko1wSc
	 52cWJM4A6MwNm+AYEKRCq2QYH2Ld46OUbmBLFGBcAh4i0SU6D8CwzCGHyC4+CdSwNY
	 RLaCZ0mXnFshg==
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
Subject: [PATCH 1/4] mm/damon/tests/core-kunit: test committing psi goal to psi goal
Date: Tue,  1 Sep 2026 17:27:20 -0700
Message-ID: <20260902002725.108635-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902002725.108635-1-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
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
index 7071ec277b007..f1e11548c771b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -793,6 +793,13 @@ static void damos_test_commit_quota_goal(struct kunit *test)
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
