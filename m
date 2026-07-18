Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8819ADA4;
	Sat, 18 Jul 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784397702; cv=none; b=izd5rncBbjJ1jD6PfL01S818Ip/nqVN4TgTbY5sXDbh7/jDIIBh2tBDskROkISY8yUGn/5W5IQlkN++JtYkl5G2+gfr8NRwrl7QnSaOND298x+cEYoB3m5f3Ef66mVYdYcqsOlFXVIjTlvaekwtKs9od9PcA1Wy7CiMsxP6QYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784397702; c=relaxed/simple;
	bh=Ok33Usa3YcK/7WZlRkN6patYalKWmFolfO3OufD4kSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXe9zYUmn+mb2g5JrpPSJVUwo1qyxWyna0i8kKqW35mZ5mrmpfC2qbHNVqz5aqAHt5UPUn4sxax7WUEffMzxx81pkDNdoL499eOCwbaeBzrCiEyHOb9RnmCCcqBvMZJ7P1TogRsf+S+hnQfiLlfrT/1CSSOu5Sw4fToaH3ppNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiceMZQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiceMZQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B84B1F000E9;
	Sat, 18 Jul 2026 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784397700;
	bh=2IbAUH8vvEqTVq3Kv7LkPD2EJ8inp4L5kOOT6/GvUrE=;
	h=From:To:Cc:Subject:Date;
	b=QiceMZQPi9XoLF95Aj9MzE0I9PycT+95RnRuaYLQzb+nVf9k9Xy/MJ8iZjJ4mUuA+
	 5LDAo3/7kkrubpepXObYOlvKOgRGZ6Uq/RIuNDm3p4q+s6A7sABfqYzIIOp557Ggsu
	 UZKKDRVM7KwNz5J228ffT8BToaEng4gvbgmtyMEJExXGHfwKsnuAGbgNGDIIXsEtZC
	 BeoSzHmCdISCvrDaueuGc+Ntiq2TtN4GlC668ez/hu1tYkfZf9F+kTDVz5ypIia85q
	 1vV3Dn2XqiFdqz6gGJzW+YuoQtPX53t+pTzb8wfTUPRkCCFf4ZUoFic+5Jyoqt8fWD
	 3OmPHdRfUSTpg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/ops-common: use nr_accesses moving sum for quota score
Date: Sat, 18 Jul 2026 11:01:18 -0700
Message-ID: <20260718180121.94759-1-sj@kernel.org>
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

The user impact is suboptimum DAMOS performance under certain setups.
The issue was there from the beginning of the setup availability.  Hence
it was the baseline for the setup.  Probably that's why people didn't
notice the suboptimality so far.

Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Given the user impact, this is not an urgent hotfix in my opinion.  This
is rather a good improvement that is better to eventually be merged into
stable kernels, though.

 mm/damon/ops-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index de9a104e88321..e59f77eca83b2 100644
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

base-commit: 6f1af14da2daf85f73375ffcabcf82255970e2b5
-- 
2.47.3
