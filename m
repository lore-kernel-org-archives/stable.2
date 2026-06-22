Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559693B840E;
	Mon, 22 Jun 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137444; cv=none; b=oHxiZl5PKMjNrI1eCyqJFs7pwrLZ611Cz/hbQq4Fdf/rdxqs0BWNYakkSXMEiIintlEBBm01NBfxB/xyuPr2Vm+++iRgutOllqnxBEO2BUTFAIbchfZO7fuwrDXBuTGulUId7bBEjAC5/+RG155Qycq1ZikDSzHVsKzn+ysq0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137444; c=relaxed/simple;
	bh=i64uFeNZXP3jrE9BkeGNcZxdbjLnd7A9BSpNv11HClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvQ8BhyO0nnjI1OUqfDkjPpJZR5INNK+ASJxjslhkiZDdSxH1WkfF65uLIpPBpioh3ZFgurz3Kb0xwhFtJzWQhvFwZFR+iUwHURBKGM4LuXcTrVfONOQrfsuALm2HIorW5loI7E2Spx99Q9vG7LAIAVulHhqRChUIeEEOYgYYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0TLhcOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0TLhcOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC161F00A3F;
	Mon, 22 Jun 2026 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782137443;
	bh=SJM/0XTBV4bkcxgnv4dRGM4IPEuvuQll1XDjuKhJgOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K0TLhcOz0QO6auoiihEfednChAH/dux6kSknrgWaApka8AHQo/V47SKGdJX74O/5r
	 Sm7Mv6gRnBzZNO9VsQCcCA4tx9Aqrdv+C6qYbpfoQUBn7BoY468r+nLCdbCT3lz0B7
	 GAUcTMMN36GRH4DdjuUt7sgMsTi8S/sFkAwLDO3mOH+W5mZW7Looh6rPPFhQnGL8Pz
	 /gdlmRALZsu5ssDCtcoFoEo1Hd3pgWBaRG9JhJSndAjIJvEXy/QLTOy52EHbZt/MD+
	 yseAOINCiRNPyITvIlHjOrakbtPosUlZufzVa94DdAv2O20sQIa+Sy+9EzuboJDJLn
	 M4w+/W3uTidlA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 2/2] mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore
Date: Mon, 22 Jun 2026 07:10:25 -0700
Message-ID: <20260622141027.29145-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622141027.29145-1-sj@kernel.org>
References: <20260622141027.29145-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a zero sampling interval and a zero aggregation interval are
online-committed, damon_max_nr_accesses() will return 1 right after the
update.  damon_update_monitoring_results() skips updating nr_accesses of
regions for zero intervals, though.  As a result, some regions could
have nr_acceses values that are larger than damon_max_nr_accesses() for
the remaining aggregation window.  Note that the remaining aggregation
window will be quite short.  It is just the remaining execution of the
kdamond_fn() main loop body, since the aggregation interval is zero.

If damon_hot_score() is called during the remaining aggregation window,
the function can calculate freq_subscore that is larger than
DAMON_MAX_SUBSCORE.  Depending on the score weights and age/size scores,
damon_hot_score() can now return a score that is higher than
DAMOS_MAX_SCORE.

damos_adjust_quota(), which is an indirect caller of damon_hot_score()
uses the score as an index to regions_score_histogram array.  The
array's size is set to only DAMOS_MAX_SCORE + 1.  As a result, an
out-of-bound array access can happen.

The issue is expected to happen only rarely in the real world.  After
all, zero aggregation interval is not supposed to be common.  Also, the
online commit of zero intervals should be made on exactly when the DAMOS
scheme will be triggered.  I was unable to trigger this on my own.
Nonetheless, it is possible in theory and the consequence is bad.

Fix the problem by applying an upper bound of the freq_subscore.  This
is a short term fix.  In the long term,
damon_update_monitoring_results() should be modified to update all
monitoring results even in case of zero aggregation interval.  Add that
as a TODO.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260621175849.91990-1-sj@kernel.org

Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 5c93ef2bb8a97..8d516851a69e4 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -115,6 +115,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
 		damon_max_nr_accesses(&c->attrs);
+	/* TODO: update monitoring results always to avoid this. */
+	if (freq_subscore > DAMON_MAX_SUBSCORE)
+		freq_subscore = DAMON_MAX_SUBSCORE;
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	if (age_in_sec)
-- 
2.47.3
