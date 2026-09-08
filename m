Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6652ED25
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872221; cv=none; b=Z50ORWWd0jfabQE1v8dzq6PJNq3c+KXufF/flLWm1nJcJuVs6qixCgsLLLLtchLzBC6GjRuPzpzmcF2JDoNdzUTbZkZgogrRmR4JrZZOi3jzWpib5ll+94Sd4EpdQddpqROJakjNu1VZaxcilwVcTeY5tuwpUDQVzGOxSM4oupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872221; c=relaxed/simple;
	bh=+NwXQ04I8KUGe3NhOOjSor1LB1I2JRQuDLXoZgSrO+M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dl/zdPhv+AQ7esHbBY/6HwnbjNuECiD3QIOEY+oDZHWlem1IANpH+ShHi+riBPem/OKuawoN+7HB4fkNl2HEs4bnda+GlUfBcHPcsetDJua+dAKhESGe2MJkBZ74F1hl3azrcI2GKDDzJUTEqPyYJxRl9XJ5pBV5Y6zg5j4L4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izzbo0X2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izzbo0X2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50F41F00A3A;
	Tue,  8 Sep 2026 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872218;
	bh=DAF7uJJeKSgyWms66PZuihKJr5cJVUIw4vDNhr7tUS4=;
	h=Subject:To:Cc:From:Date;
	b=izzbo0X27WjvLSKg+vXJ6Dc3z0gkiNq6Rer8r7qwOnVBBnb4ocGouCWujqFQQDu38
	 68HOMZQ47FG1akuXAXp+nlgO8k2cVAnDslUxFdvDrULcQbyepHkNJoVUBxmAp2oB26
	 iUp/ezqjnE0PSxQxXHz5zsVEJLVgvXAkUV7GgXUU=
Subject: FAILED: patch "[PATCH] mm/damon/core: initialize damos->last_applied" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:52:05 +0200
Message-ID: <2026090805-evoke-tiring-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x af5f76aeb9c9aa9c77d5e1d94e0ee4618c805239
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090805-evoke-tiring-a0dd@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af5f76aeb9c9aa9c77d5e1d94e0ee4618c805239 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Fri, 17 Jul 2026 17:14:35 -0700
Subject: [PATCH] mm/damon/core: initialize damos->last_applied

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

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 603b102ff80f..20d267c615fa 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -705,6 +705,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	INIT_LIST_HEAD(&scheme->ops_filters);
 	scheme->stat = (struct damos_stat){};
 	scheme->max_nr_snapshots = 0;
+	scheme->last_applied = NULL;
 	INIT_LIST_HEAD(&scheme->list);
 
 	scheme->quota = *(damos_quota_init(quota));

