Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B445335A8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872272; cv=none; b=kh/3Qhb5TV7eH2JXkQ9EzbtZNwELMNLSAiz148kOpSqXn+ufvoWqC0oSuzWohMMndbaqvgmmNuwrGnhZ/aIQNGWcgfL0atIR+jMj46S644cCBR3LKThfDDZr+0TD/3urmSuFwBonzIboWzEbMGgGEK0qDLRRG5M5qCvvkTE4tRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872272; c=relaxed/simple;
	bh=a4wH3KWISeVlp1Nxrz5TXioQ8wBbs6VL3HU406oY/5U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=byShmvuybti9f/dvKIQ7X+Gb6a/eeJQcQowjpn3mce9XimxKBRs9kRBP3ADbogUzLrMZZivoCKZLYTj399ER/mKCqsI65415adhCN1yzmeFrJw+0Z9Qy//taBMZ0CRB8t+suHNmuuHt1bt9PZUussaaXvrQB1dIsxO9hS1cZ2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZlzYPQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZlzYPQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3091F00A3A;
	Tue,  8 Sep 2026 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872270;
	bh=LwvQlpJ9oOrDHfQcbbPLnMxKHzl+JXU6qHY2AR5fUpI=;
	h=Subject:To:Cc:From:Date;
	b=XZlzYPQEWjtkmgV5nE9qETZvXFclzQsxj7E5kR4pB+jlILY0+6SMtMzsOlvKMNosl
	 iDUzIVuiHEXAuEbcMpJiIOKGo9p1LMhHb+jdSPm7TsdIQD4o5U/PA6fJvYPOiDwGSk
	 y7syJCa73cgI3m/vdnBjG9wwDOZU6B1TnZ/sb8kI=
Subject: FAILED: patch "[PATCH] mm/damon/ops-common: use nr_accesses moving sum for quota" failed to apply to 7.2-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:52:46 +0200
Message-ID: <2026090846-diffusive-headfirst-c45d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 6c25083f7ae7e2660d766169e5b4d3e96010503f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090846-diffusive-headfirst-c45d@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c25083f7ae7e2660d766169e5b4d3e96010503f Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Sun, 19 Jul 2026 09:11:33 -0700
Subject: [PATCH] mm/damon/ops-common: use nr_accesses moving sum for quota
 score

Since commit 42f994b71404 ("mm/damon/core: implement scheme-specific apply
interval"), DAMOS scheme can be applied at any time.  At that time,
nr_accesses may not be fully aggregated.  But the quota prioritization
score is calculated using the not fully aggregated count.  As a result,
the performance of DAMOS could be degraded.  Fix by using
damon_nr_accesses_mvsum() instead.

The user impact of the issue is suboptimum DAMOS performance under certain
setups.  Nonetheless, the bug was there from the beginning of the setup
availability.  In other words, the suboptimum performance is the baseline
of the setup and hence it didn't cause regression.  Also the extent of the
suboptimality was not big enough to be found from users and testers.
Still, this is a clear bug that is better to be fixed, and can be easily
fixed.

Link: https://lore.kernel.org/20260719161136.90191-1-sj@kernel.org
Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index e59f5268d503..d7d7f100389b 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -111,8 +111,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	unsigned int age_weight = s->quota.weight_age;
 	int hotness;
 
-	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
-		damon_nr_samples_per_aggr(&c->attrs);
+	freq_subscore = mult_frac(damon_nr_accesses_mvsum(r, c),
+			DAMON_MAX_SUBSCORE,
+			damon_nr_samples_per_aggr(&c->attrs));
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	if (age_in_sec)

