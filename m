Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1C3BB48;
	Sun, 19 Jul 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477501; cv=none; b=UmhMDRSRvmyrjWuVy2GpNSpHDr7r1O8ybI8f/E0kVj3b6vUxilIPY+Qv9LaQYBM03FvatLNPRMYJoB2zku30S1mXrir1OrPnOlEOzE7bkYTz3ZSOKU855P2Dt/944v8MjFdefvRjPZu7JIXnRQ+5x+8EYpab7NDcTIelcofZEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477501; c=relaxed/simple;
	bh=9GhFOgzKFFkGKsEpQjqtlqRSLWAlbX8z9M3CGCCv5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JH08SDBf9SGIWouyN4L33dzKivDEl8o9IU75OiBmCFXdSgD5KDWIsWbTz4gZxoJ9byJi+8dxPQgSXxoS38jBcqWuB+OZOLyjMLW8hejzDgGnVWDTEYasNi2IFY2bNLvi4dR0rdqrSNcPEJMLAO5w+ifysFmE8j3H9Ylc74KuHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwpLxcVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwpLxcVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAB51F000E9;
	Sun, 19 Jul 2026 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784477500;
	bh=VMwzI12Qt5ciKjfitMVlDvecEgiGz82xEPDSiEP7R1Y=;
	h=From:To:Cc:Subject:Date;
	b=OwpLxcVL0NbruJq45iPw5bucNh7UZpY9Z1sMn3fwP7QHhpN2ZEZYdVR+OsU8aXWtU
	 mYbv1X7eiURQDL3JgD/1+P1e+kYLQN7YxTjisusyVVECxgCchYWqIX0O3FCi0oWFKd
	 XaoXCIV4Ns0uWSLtEO8IjBK/wLvdkSNzn2ZQkboO6sd5mtgEzx0YZy7O7ZurXDj53c
	 +u2BHG4OXooGSpx7izvsVV/2jTLfNOnrOWqEkv/V6xdMRRlUOe5h4EUwJBE2MCOpmQ
	 Y1zonEfjR7lDnbtLzPl3xoDflZ2pbby3xKWAXf2quFQrpVhFQHOvjSDyHWbkKnJI5B
	 VWSy39zrbZlnA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/ops-common: use nr_accesses moving sum for quota score
Date: Sun, 19 Jul 2026 09:11:33 -0700
Message-ID: <20260719161136.90191-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 42f994b71404 ("mm/damon/core: implement scheme-specific
apply interval"), DAMOS scheme can be applied at any time.  At that
time, nr_accesses may not be fully aggregated.  But the quota
prioritization score is calculated using the not fully aggregated count.
As a result, the performance of DAMOS could be degraded.  Fix by using
damon_nr_accesses_mvsum() instead.

The user impact of the issue is suboptimum DAMOS performance under
certain setups.  Nonetheless, the bug was there from the beginning of
the setup availability.  In other words, the suboptimum performance is
the baseline of the setup and hence it didn't cause regression.  Also
the extent of the suboptimality was not big enough to be found from
users and testers.  Still, this is a clear bug that is better to be
fixed, and can be easily fixed.

Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Given the user impact, this is not an urgent hotfix in my opinion.  But
this is still a clear bug fix that is better to eventually be merged
into stable kernels.  Hence Cc-ing stable@.

Changes from RFC:
- RFC: https://lore.kernel.org/20260718180121.94759-1-sj@kernel.org
- Drop RFC tag.
- Rebase to the latest mm-new.

 mm/damon/ops-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index e59f5268d503c..d7d7f100389b0 100644
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

base-commit: cd3ddd04256381e4874c14e644c9d263e323e777
-- 
2.47.3
