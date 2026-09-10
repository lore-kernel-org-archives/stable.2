Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A1A280325;
	Thu, 10 Sep 2026 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000924; cv=none; b=L+Zui2HLjUfjM5cBussq3AhI/5+7wX96tPCc/UoAIlKYInWzCpQKk/kzK+DJMk7ZTmWn+RyvYk3NlmrpNLsxoWLVJZuKYF37VKReo/QwnNO/qxHT3DnYLJkLnqrTgQsNWDLfejBGJ3rxJ5sKbsEt73bE8p0jeL+kziqsXTBByy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000924; c=relaxed/simple;
	bh=p0BFbUYXAsJYo2LTzxYVzx2YF3dtFm2NTDHd2TBwmr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOQxXPZwpRhQWumDL1s6CX+/x+fBwtKpFryd4X/CGX07HfV8WLCVCI+HEE+yXDRo9CPW45dikwPi80NJxZiSbPjOAQ9qtDTW5Za7YQ+fxAYjlCK8E8PLTNKoFg5lcuohFkNbw14FwdwT5KQ51gH9Hna7ym2PRpNotD/6qosb/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7BAH6U0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7BAH6U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2255E1F000FF;
	Thu, 10 Sep 2026 00:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789000922;
	bh=w6EbHxuKPp9FQ0rnWKbJOsjJmu3bAkoGbJhwrr3lxA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7BAH6U07Bfpr9SOXi4Ssc+9tzMb8l8yo7GX7pApWp8JuD/ot3wR/AC90D/scHcgH
	 6n2qguIKkf5KH/lGXKPBTCxQTiMhxqqrkuYPSCz/gjjSTMwpwUKzIfarWvhcjBBR3c
	 FCM2Z3ocpgfggl62UhCBPeFiNeOjZucNWOvvt9WokMi9t7/4V0GwtftYv7vgKeY1wr
	 K5/hHRtz6AnxCZj7RVsU7XxSM7/Nmf0AlnQFLu0uEjJZFY416/6dxnalxLwy7q4ktx
	 LX56D1r+aHlZAgynaLxgH+6PjbL9DzJFW3gDuLp9LUZDCqOLV7GJlg5qAgJ7kBB4am
	 jv8D5jzm3XQMg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/sysfs: read ops_id only once in damon_sysfs_apply_inputs()
Date: Wed,  9 Sep 2026 17:41:53 -0700
Message-ID: <20260910004154.115973-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090858-arousal-getting-ee35@gregkh>
References: <2026090858-arousal-getting-ee35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_apply_inputs() reads ops_id twice.  It could race with
ops_id_store().  As a result, the min_region_sz could wrongly be set up.
Read it once.

The user impact is trivial.  Sane users ain't update the parameter in
parallel.  Even if it happens, the DAMON core layer handles the wrong
min_region_sz (!is_power_of_2()).  Even if somehow the race ended up
making a min_region_sz that is different from the user's intention but
still valid, only monitoring itself runs differently than expected.  No
critical consequences like kernel panic or memory corruption happen

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-7-sj@kernel.org
Link: https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org [1]
Fixes: 8d009da32f13 ("mm/damon/sysfs: set damon_ctx->min_sz_region only for paddr use case")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5adaaa28be8a79ddd7e103b171f9d6e14e7fc26e)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 53f99f05eb38e..7f52470be36e3 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1440,14 +1440,16 @@ static inline bool damon_sysfs_kdamond_running(
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		struct damon_sysfs_context *sys_ctx)
 {
+	enum damon_ops_id ops_id;
 	int err;
 
-	err = damon_select_ops(ctx, sys_ctx->ops_id);
+	ops_id = READ_ONCE(sys_ctx->ops_id);
+	err = damon_select_ops(ctx, ops_id);
 	if (err)
 		return err;
 	ctx->addr_unit = READ_ONCE(sys_ctx->addr_unit);
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
-	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
+	if (ops_id == DAMON_OPS_PADDR)
 		ctx->min_sz_region = max(
 				DAMON_MIN_REGION / ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
-- 
2.47.3

