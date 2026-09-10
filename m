Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C26F493D3D;
	Thu, 10 Sep 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050536; cv=none; b=eWiAFgR1htiavLqhnRTJH4QrnCrJ0qxquuFF3wuvlMrqeTHx4KxjN35z2gNbet4Oog89Ng8uzc+dOky/74+jHZG1vs7nfhqBs5RG8NEAbt6eDnFgurO3JVbgjIsdrwOgPop/kR4R5ADoMevYWNQnsljTEhlaYHMncd9R1jQwBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050536; c=relaxed/simple;
	bh=Vs4wjfHszeZkCmfK7zEffUP85vyI8R7s0ImJGwV3oe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpsgrlXdJ+UjQ3Ll7FFXgw+4rXWCcBHKIvsZDiYfyJqfZqvzhPT0MZlFF5bMqhidMYASqCROpi4FZTd4V5Q8pvW/l7FJwASDMpByed/HNukxQAYsmD6w6pUrmW9X1IpMrvUZUlFP3tJw76PLmd/Lh53fAaxe3HippZbhrj75PeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USlad1nL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USlad1nL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E81F000FF;
	Thu, 10 Sep 2026 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050535;
	bh=SW8evpy02DamdqiEXgaSrgnCDzWYzeYmnUuButPjW68=;
	h=From:To:Cc:Subject:Date;
	b=USlad1nLJGBwm1TYjCXfWCjFwVc1+yp1yNfaYzaZ2UJTL28VarH9mHjDofJ5U7qdV
	 yWXTkCa/SzEwXLxakf5RFyH7CY7LMTIHvqcYDuegGK7bfn2gk5RbIrWbJEo9S+wlkd
	 4duC0LuhDN3UJH7DgtLTMNm6efHvoqmzIXtCsqlV2EJuoGTzpQS86cY4/CWCYDea6d
	 ALvqaZeSwbE/JQCTCzbYz5E37L/ffg3v3krMg/iF9/p7ZHnAVlAdiMfLGYCJZ6QNLE
	 Pq/2/bKG+mVUCkVR6sQrTfozCGq9RpnpEmVOl5r9zVu8w+8v+y1JYxog7C4jwqlGfq
	 6qqXOstwzJBPg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/damon/core: reset invalid quota->charge_target_from
Date: Thu, 10 Sep 2026 07:28:45 -0700
Message-ID: <20260910142846.172957-1-sj@kernel.org>
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
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260908144246.104162-1-sj@kernel.org
- Drop RFC tag again.
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
index 645cb367019ae..06cf2ab7e97d7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3393,8 +3393,15 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
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
 

base-commit: bd699d8a4388cda037f01797294c834fb422ebe6
-- 
2.47.3
