Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0E45A29F;
	Mon,  7 Sep 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800143; cv=none; b=jJe2oh0K5beIzsWhGPhikLCZXBSEPek54YkSg4ydiRCHU49eZzhENBCrWVJLL0npD2JX7TF8+5zdV2spq5aXiHc6bgpv1wivpGt5rwt+vg5wifG5grWFjL++HilZixT7fusYs86lMs5q328iJqzlc5I+z8h4drUg7CtBllm6eK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800143; c=relaxed/simple;
	bh=iBMXCtu1TKD58drkEDAqlVCxHHOmxA9aOuY5aSL67K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfH+NfU7FDMGEOHgobFB+nbVhEQx2NxxS/1oW2BIzdzemFmar3GXVjKz0E8LnFrWDoTpY5GHV0DKYYc29U4AMb/lRymBTrb2YVRLwRN+XfN+THN5Tw0oEOlaE3UZHCKY9XuBQ9NHOI7beQxHII1HGCcReErQ4bHApPtVmbIxyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+FKirZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+FKirZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5473A1F00A3A;
	Mon,  7 Sep 2026 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788800141;
	bh=N+bAn4jc0lwjR+rXbNhNnyvVby3zOE1/1ScvrFn1ygk=;
	h=From:To:Cc:Subject:Date;
	b=B+FKirZHnhXaavgSwlgh6O9b9B0hJnwriFmFM2u4845ZZmM/movYOcM09H9Wl6MFL
	 csJ6UUcG+bOOhgsIhY8SlLCYRCD3ya4Ex0wI/VSTE2DBJSFVhCZwvPtMfxXh+Gvwl0
	 yim7Hi1eLE53ja8GQ7txd0Yie3Hot86JxoXI1J3A6zFXfeLpxVJ4WU5WmzxRK+VIvD
	 hQC3uQUv5hH2z/SRKmoZz20elCNe93iqE8WT+sbrqoIkXXj+9fBtfSKPDO2yebbaj1
	 shgPJFw7cC1NBW6JvmSy7lhzCr2ZpOBry+jK6lCJB9g/kNGOUPTorDa+0vcVoIUyvq
	 FHjfmjB+H++vA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: reset invalid quota->charge_target_from
Date: Mon,  7 Sep 2026 09:55:27 -0700
Message-ID: <20260907165529.98874-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS can suddenly stop working if a target process that quota just
fully charged in it is terminated.  Fix by catching and processing the
corner case.

When DAMOS quota is fully charged, the target and the region to continue
applying the action in the next round is saved in
damos_quota->charge_{target,addr}_from.  In the next round, DAMOS
iterates targets and regions from the beginning.  It skips applying the
action to the regions until it visits and skips the saved target/region.

Virtual address space targets become invalid if the process is
terminated.  Trying to apply the scheme to invalid target is just a
waste of time.  Hence commit 6e4930e33329 ("mm/damon/core: fix wasteful
CPU calls by skipping non-existent targets") made the logic to skip
invalid targets.  However, it does skip before the charged target/region
skipping/updating.

Let's suppose the user runs DAMOS for multiple virtual address spaces
with a quota.  The quota exceeded in the middle of a virtual address
space.  And the process of the address space is terminated.  Then the
charge_target_from points to the invalid target.  The pointer update
logic is skipped for the invalid target, so the charge_target_from is
never updated.  DAMOS action to every target/region is skipped.  From
the user's perspective, it would look like suddenly DAMOS has stopped
working.

No critical leak or crash can happen.  The user could reinstall the
scheme.  But this makes use of DAMOS under certain setups quite
unreliable.

Catch the corner case and reset the pointer in damos_adjust_quota(),
which is called for adjustment of the quota for every round.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260830064708.40CA61F000E9@smtp.kernel.org

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260906183654.95634-1-sj@kernel.org
- Drop RFC tag.

Fixes: 6e4930e33329 ("mm/damon/core: fix wasteful CPU calls by skipping non-existent targets")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ce8c6f99106ed..2c58be9edbde4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3283,6 +3283,22 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
 	trace_damos_esz(cidx, sidx, quota->esz);
 }
 
+static void damos_reset_invalid_charge_target_from(struct damos_quota *quota,
+		struct damon_ctx *c)
+{
+	struct damon_target *t;
+
+	t = quota->charge_target_from;
+	if (!t)
+		return;
+	if (!c->ops.target_valid)
+		return;
+	if (c->ops.target_valid(t))
+		return;
+	quota->charge_target_from = NULL;
+	quota->charge_addr_from = 0;
+}
+
 static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
@@ -3318,6 +3334,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			damos_trace_esz(c, s, quota);
 	}
 
+	damos_reset_invalid_charge_target_from(quota, c);
+
 	if (!c->ops.get_scheme_score)
 		return;
 

base-commit: 6ce2570ad1f1f4195c8d8b1a460fec2fc276dd65
-- 
2.47.3
