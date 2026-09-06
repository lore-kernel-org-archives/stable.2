Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8535DA7B;
	Sun,  6 Sep 2026 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719824; cv=none; b=btPrnEFaTJ5UUgiXCqUtt4uh1pwwTFEd9CR8xECSg7D68smK7v9QLZBiO5JnhP3zjOS6wFa8JWq015I8YpqFMecxKKbjFeI9sijgKvzkstTq0LEX5Ngo7y9d8yuJ2+ngaJSfOnr0EC6DZ8sJrzMhv781NrDXUZZZSypGURlFF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719824; c=relaxed/simple;
	bh=3wiM7WEt1lH28Oba676UHfY+FWMqbto7oH8GgKR+7ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q//4k1sL3XfzmExumFOGrP8s0IQDrCdXJn0qfHwpQdnx4TOtocqITHx8/tQ4SeCaOyclzYWbz6NfpxcJjVklIXKYC3Y4xceWjr8jgF+//2+nlOXxUXlRjqmOn2AFyzcLsHSqO8OLGG6g6pIZxGB629zoPu45cgcTFgFDba4E1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPvD/Ofu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPvD/Ofu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227151F00A3A;
	Sun,  6 Sep 2026 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788719822;
	bh=zhQNwRYEIS4kE/CvLbGr7B/xSZlKygyBMw9AdWBN80M=;
	h=From:To:Cc:Subject:Date;
	b=EPvD/OfuoevHCK7mt42e9YBPXAB3eu7jlX3A97CwVt8yRfNwcGk3HJCwmSQRSyOLK
	 SvOFyw6XWSkRC18AOBekLM87MOBgeeuumRQ8hJCkmMBkd7acmqF7pELC1JDOSMGrVj
	 7z1CSAJB1I1HIxPB4aEfnbvcUzC8xs8Nf0xAxS+q6ukTqWV43di8ky6JdzzvkJAA1v
	 VlDtK8dqgrPmy/CCZB6yNRJ6EX7ysEYaWLrQN+hp4bfgOEZWQ4om9GAOmWeeNqqJY+
	 F4kwS7ls29EmxQPR3ED/ga/0padmKWz476l2+nUacd5/wmExJSSnHX9pbQimXlOz4N
	 VW+BVPNNU6lGQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: reset invalid quota->charge_target_from
Date: Sun,  6 Sep 2026 11:36:53 -0700
Message-ID: <20260906183654.95634-1-sj@kernel.org>
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
 

base-commit: 98a7a286b6060dce5e93b37e28f2e0be80304027
-- 
2.47.3
