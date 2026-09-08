Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A149EC69;
	Tue,  8 Sep 2026 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878584; cv=none; b=dXl/qPq+FV9/sHPoAxspCrpPiv6+2nKRvTlzmO5hTbywZg6m0TIxarcygfL+ITg1kMr69SoCy8wgxQGSxkwYk+JG/8vadI9sGq279wH0wrFaNYHQuBJj404Tip6ed3UtHj/WrkLBNNOS5PjAP9GR6lSJYWFb/hhQayXkQmA/sF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878584; c=relaxed/simple;
	bh=8I4SJYLaWlCODfgGIIihvoylnRMJJuun9WzbuneMutE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Abjmmz5wV9Ytve3hq8wJ//TvbdCxjOB6MUCJhh3yiFfUENFL8GvOu7whAUqs9np56bcPdbFGeszilHbQwmjETY/lbPh5iuYYtk0U/Wyfoff+JJBm04UXW6qkRHPCmPkZV0SFTyv/mOQcobkn1lVS1uN10kb3P+JJLApIcJB1wrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz51TJq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz51TJq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3A11F00A3A;
	Tue,  8 Sep 2026 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878574;
	bh=jNxvFKt4UGJwKbXlYaf84gFPggvY9g3V38ihxwf2lM8=;
	h=From:To:Cc:Subject:Date;
	b=Lz51TJq/mLh0SOQWb50eZFJzbQhGHKJc5jizpRNUWLtlYghmUsHLlz7VUn2nmVaHn
	 PPEhEdOtcobvJfaCFckPbFhXzZjyP5DsE6uAP6lbzYBrcrk9hzuF8n8TVxRHhFNl+R
	 zZR7/V8OIrpLE9ji89C2nhPBMFrwBNYS/TVq+tMAr6MQdoyY5YE24JPjoww2ahRZPs
	 NkTcKG8s4dfB0MCugKnrPX666QGVF6y5LCq9HDrcVghJ3Qj8GMLkcYqKWg4KRModJk
	 UUr5mE/VAvZNUOGeNEDG5UCHf9M+ER9a03dJVu8+oVriCPIEYk6Mag+W8/c5o0IKDF
	 Me4RIGqmuTfdQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2] mm/damon/core: reset invalid quota->charge_target_from
Date: Tue,  8 Sep 2026 07:42:44 -0700
Message-ID: <20260908144246.104162-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS can suddenly stop working if a target process that the quota is
just fully charged on is terminated.  Fix by catching and processing the
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

When the invalid target is found, further check the corner case and
reset the pointer.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260830064708.40CA61F000E9@smtp.kernel.org

Fixes: 6e4930e33329 ("mm/damon/core: fix wasteful CPU calls by skipping non-existent targets")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260907165529.98874-1-sj@kernel.org
- Move the corner case check to invalid target found case, to handle
  dynamic quota uninstall case.
- Add RFC tag again.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260906183654.95634-1-sj@kernel.org
- Drop RFC tag.

 mm/damon/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ce8c6f99106ed..a360c41cda89c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3389,8 +3389,15 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);
 	damon_for_each_target(t, c) {
-		if (c->ops.target_valid && c->ops.target_valid(t) == false)
+		if (c->ops.target_valid && c->ops.target_valid(t) == false) {
+			damon_for_each_scheme(s, c) {
+				if (s->quota.charge_target_from != t)
+					continue;
+				s->quota.charge_target_from = NULL;
+				s->quota.charge_addr_from = 0;
+			}
 			continue;
+		}
 		damos_apply_target(c, t, max_region_sz);
 	}
 

base-commit: 4c152875952628604696dbba38cd487fdfde28ea
-- 
2.47.3
