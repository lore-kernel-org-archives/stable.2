Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE934D3B2;
	Wed,  9 Sep 2026 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927092; cv=none; b=UuHsUiU7fFkSL4UOvUckUUuC7vVbkzQk4nlU0PpZH9+SaYahGRFzrov3dyK69SYBB/r9NGjhzmKXjNFyLr3HlJDsmAI6sDhCpAGmf+BuboUjbht+O4RfTDVmgmczd7xeI2aHcqejgM6rrZQi6HZJaRWlGmXcbwaAiuVnfgU43Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927092; c=relaxed/simple;
	bh=cfxBESO+NQDgLPD6ZCftkntInERsAv/ZFMhKqQb6kXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7Ml349M18WauoYwCoN4v8Y9MtpmpqmdLkgTtYBPzwMqwdkVSLe/dcB7mG70dqXrKMCOTwL+jdyipA1jB6tHt3z8FzbXhi5M4B96Yu2rW8R80HMOSCf7005WKmVTdl3UcVVCc/DK7nW/dLOjP+0506B/FKl6HXpVr9ZzHkBBn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXuolGJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXuolGJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA881F00A3A;
	Wed,  9 Sep 2026 04:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927089;
	bh=IdiNhjuOFT3hKSr1ASzf37Xn8tlWY2qq5j/sRaXGm/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YXuolGJPqBeAlRwABkApdqswW5xPkpvIkCbw3j887zz0PDZSsbm5Y8FVhD9bTxhIB
	 0gecUQRlckJQC+TjiX1E3nFxnTnJOnZEu42u1XyUC/5bH2fayoUIeWJCHReZoWS8xr
	 voNrUtS0cvExCcQFiLX1UI0A8aQMI1yrb7+UkdsbraOUQ+LQSsdPov8tS9hsIXUubP
	 TTxsY6vi8sCJgjuDUOcLIXY0KwXE3SHD2uB+rI0soexYIF1TRhva7mCoMhIzrBu7fX
	 le+jxdF9zgWNf31Dc8CpNP142aq6dEHq6I4SYo0O7m11e3Hmwu11U5GJ19MJYBXsYO
	 fV4ZoUwwVmXJA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core: initialize damos->last_applied
Date: Tue,  8 Sep 2026 21:11:22 -0700
Message-ID: <20260909041122.180644-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090805-evoke-tiring-a0dd@gregkh>
References: <2026090805-evoke-tiring-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch series "mm/damon: fix uninitialized DAMOS field and kunit exec
expectation bugs".

Fix a few Sashiko-found unurgent bugs.  Patch 1 fixes use of uninitialized
damos->last_applied field.  Patches 2-7 fix DAMON kunit tests that do
invalid memory access under test failures.

The bugs are better to be fixed and eventually merged into stable@ kernel.
That said, the fixes are arguably not urgent.  Patch 1 only introduces
negligible DAMOS efficiency degradation in occasional cases.  Kunit fixes
could introduce quite bad consequences but those are test code that affect
only test run setups.

This patch (of 7):

Multiple DAMON regions could exist across a folio.  If they fulfill the
condition to apply a DAMOS scheme, the scheme could be applied multiple
times to the folio.  To avoid this, each DAMOS scheme stores the folio
that the scheme was applied to last time in the damos->last_applied field
and skips repeatedly applying the same scheme to the same folio.

The field is being used without initialization, though.  Hence, the
mechanism could wrongly skip applying a scheme to a folio at the very
first time of DAMOS run.

The user impact is trivial.  DAMON might unexpectedly skip applying DAMOS
action for one folio for the first time per scheme.  In the DAMON's
best-effort world, this is never a real problem.  No critical consequences
such as kernel panic or memory corruption happen.

It is a clear bug, though, and the fix is straightforward.  Fix the issue
by initializing the field in DAMOS scheme creation function,
damon_new_scheme().

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-1-sj@kernel.org
Link: https://lore.kernel.org/20260718001442.87129-2-sj@kernel.org
Link: https://lore.kernel.org/20260714055436.120034-1-sj@kernel.org [1]
Fixes: 94ba17adaba0 ("mm/damon: avoid applying DAMOS action to same entity multiple times")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 6.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit af5f76aeb9c9aa9c77d5e1d94e0ee4618c805239)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 70ac1f08753d1..02aebbc5d98e3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -412,6 +412,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	INIT_LIST_HEAD(&scheme->filters);
 	INIT_LIST_HEAD(&scheme->ops_filters);
 	scheme->stat = (struct damos_stat){};
+	scheme->last_applied = NULL;
 	INIT_LIST_HEAD(&scheme->list);
 
 	scheme->quota = *(damos_quota_init(quota));
-- 
2.47.3

