Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6030503BF2;
	Wed, 16 Sep 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566639; cv=none; b=jT4ECJnssWymwQQyjXX3C68LdnJI9Vwoy3CY6D/FpbZzj2YFeXf2B7lMJSVy2HPUGnfIRZ3Pf0din1KppoMW0qntDKr08IpwDLcPPzHqHifbqQ2XYPIRlkW7kdwHQtyVs+p80M/bKj+TP8+kBJcxwD3YwOgD58SFRZe9dTx5DpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566639; c=relaxed/simple;
	bh=IkfVaa8l2Zo84kHBBcbyfcY+K3uT8TGj8SSC6+9EgdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=px/yZN3xfUdY3EyqKdAw21eJhY/THYWlE+X41xRP63opZpfMqILTr+OfdwzS5TBLph4X3wxHRgMqCdjqauE3jjtqNHlIQoI5p7jPatyW9JOcYnut2zSIuqdb/mYv752gnu685PZRbXbhQclHP8Pb/WLXQFYGheAPZPfesfNTMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auO/EBP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auO/EBP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244511F000FF;
	Wed, 16 Sep 2026 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566628;
	bh=K7T1QVABApjQc8vlsE5UVS8mdXdQEDKvwmurJLYEtzg=;
	h=From:To:Cc:Subject:Date;
	b=auO/EBP1rEr/ZeaA/kfaI2Ze7jAgE0bqMYMop/sNILRJgcDKgdrIRT3mv9qqoonwI
	 lh92WtYuup4avrhPSZzOzIXhPGZw1v+jC+jH32pSaTH8yVJYjcHt7HA5A3qlzPQPFs
	 4iKDA8RqdRQ7Xd+imVlL98EqFNVzYFT4gdC9wD1tek804VIYlEwPXaRCecXlQ5Dohp
	 lXAfdjTtyF6/Qn34nJPHO1FkVRTpl4QYlbGmdP3P3y7etr5Glv1254Mh08iEu54XmU
	 4wfKu0Cza7C9G0wH7IDnGMTaS6MuvS4bJJM4osBblhXuMJViHLhHIHFgKo4waEoq3Z
	 ougYNPlqyZ1kA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Wed, 16 Sep 2026 06:50:19 -0700
Message-ID: <20260916135020.86483-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS could unexpectedly stop working when a user disables quota using
the online parameters commit feature.  Fix it by correcting a wrong
quota unset check in damos_adjust_quota().

DAMON users could disable all quotas by unsetting time and size quotas,
and removing all quota goals.  The intention of disabling quotas would
be making DAMOS run at full speed.  When such quota disabled setup is
detected, damos_adjust_quota() skips all its work.  The skipped works
include effective size quota (damos_quota->esz) updates and charged
quota amount (damos_quota->charged_sz) resets.  The intention is to
avoid doing unnecessary work when quotas are disabled.

However, users could do the setup while effective size quota is
non-zero, by doing the disabling with the online DAMON parameters commit
feature.  In this case, because the effective size quota exists, DAMOS
will keep working with the quota until it is fully charged.  After the
effective quota is fully charged, the charged quota amount
(damos_quota->charged_sz) cannot be reset because damos_adjust_quota()
skips it.  Then, DAMOS stops working until the quota is newly set or
DAMON is entirely restarted.

The problem happens because damos_adjust_quota() assumes the user setup
for disabling quota immediately disabled it.  In reality, the quota is
still working until the effective size quota is also updated to zero.
Other logic for catching that uses damos_quota_is_set(), which
understands the fact and therefore checks the effective size quota in
addition to the user setup.  Fix the issue by using damos_quota_is_set()
in damos_adjust_quota() to determine if its works should be skipped.

The user impact is a non-deterministic and unexpected DAMOS stop
behavior.  That is, users would disable quotas using the online
parameters commit feature, expecting DAMOS will run at full speed.
However, depending on the timing, the setup can be updated while the
effective size quota is non-zero.  Due to the above mentioned internal
mechanism, DAMOS stops working instead of running at full speed.  It is
unexpected behavior.  It is also non-deterministic because sometimes the
setup is done when the effective size quota is zero, depending on the
timing.  It doesn't cause critical issues like crashes or leaks.  Users
can simply set a reasonable quota again, or restart DAMON.  But
definitely it is an unexpected and non-deterministic behavior that makes
it difficult to reliably use.  Also investigating the root cause of the
behavior would be quite difficult.

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260916041409.106926-1-sj@kernel.org
- Collect R-b: from Kunwu.
- Drop RFC tag.
- Rebase to latest mm-new.
Changes from RFC
- RFC: https://lore.kernel.org/20260912200814.145612-5-sj@kernel.org
- Split out from the cleanup series for taking hotfix path.
- Describe the real issue.

 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dd4317df42ff4..444c97c184027 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3348,7 +3348,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz, cached_esz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
+	if (!damos_quota_is_set(quota))
 		return;
 
 	/* First charge window */

base-commit: 8d713ff18bb27903ec1e19e54eecdda4168fe440
-- 
2.47.3
