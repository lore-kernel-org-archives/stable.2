Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366F4F4735
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872278; cv=none; b=NnijZEQNx6KfQxpWb2mZoohhwOIj9J+DxkWdZ1PqxvAvxR1Dxq4IIFEWrKfWgIOgkmevPb5m9rVjQRZRvz0sG5Sy/RJ/rJ1MhJjYoA2XmtEr9SlBSilKE+qvng8yU5yadpZSmwvvxnSPVRF5r43EStambrziMKkgiq49a3xJFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872278; c=relaxed/simple;
	bh=TFuRky0xcT6BHZJYiOgZ0pwSBT8gY4vvtB5Og7qJTNc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AUVkSr1tcrgQYsN8BXomo/9cMgPVygmOjPDFUkRvp3OAd2ojLzVlBKbg0ir/MKzv5mnCOzcDuk40Z+gvYbnHspLVKXR5Sae7A5Gy8keIogmeA91XCfigBUxSGlhaL4UFh3uwbnWAtSAz6BmS7S8caEEpzJyRSX+FIDfNC0XCLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t8pSbR+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t8pSbR+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8778D1F00A3A;
	Tue,  8 Sep 2026 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872276;
	bh=6ZG7HYZmKgo8wlsVZv4UktXErpTW0dhOpX0zBBwwhq4=;
	h=Subject:To:Cc:From:Date;
	b=t8pSbR+mRBMOtcudQw5lPaBwX68AY8FnyFgOL4lvbDIE/rGnfH2ZRz9XsKloWXWqI
	 IoFzFDoIoXqb35VZRzhBXHEY5gY87KPdzzX2KeqLwcc2ZvyeG63o53B53mNIuTu0v5
	 3L+1SsEm4m/SjC6VBpPYXul4JPp46IqZl5Qf4caw=
Subject: FAILED: patch "[PATCH] mm/damon/ops-common: use nr_accesses moving sum for quota" failed to apply to 6.12-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:52:47 +0200
Message-ID: <2026090847-penknife-trout-eb12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6c25083f7ae7e2660d766169e5b4d3e96010503f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090847-penknife-trout-eb12@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

