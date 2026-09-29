Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD95452A0;
	Tue, 29 Sep 2026 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703907; cv=none; b=EgBt/2XqKFpqf0+uXXk4ChMHlWaeqxVb6aLziE2r4RcTQv9wZuHm8JwDci2/tr15BPiRukJtVoRKFkoiH5e97PgnlONzCIdPYbGCsSyrgd1+BcBDflYe+V4ifj1EONY4dxi220B7uMn6M+9k26t34o1jcq23cYvF69qfpXIwY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703907; c=relaxed/simple;
	bh=sWonrjviaj1u2Kuk73gM+VSeW7Z4YpSH5hX5WeCvLIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FjhXn5Ud5sgKUljRoBEtivTgxFGenPvgghS/leylktLGp4o2V+CDEJanPNerF5AVukr3eY+sqIiWbjpP2qv46inRXlgVoS+qGWs3xHypY7v4mTbsUZJA8xIS4MsQ6cHeMmjFjw6iYoE7L+PARJhC2JqWgs3hTs6noV3ywjALybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+7G/Zzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+7G/Zzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03F71F00893;
	Tue, 29 Sep 2026 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703906;
	bh=/f1L1WXhS/CTZ8vm1vu+UDBVGgRupRevOzOvLXe9Jo4=;
	h=From:To:Cc:Subject:Date;
	b=I+7G/ZzcTmdTkf5lon4xQVfCbdOLOeMtBc0ck+epfO01yRMTZoeabXsoamwWorEvg
	 3tQkeTS1dV5nAyLKfAyIadPingLepYNOy+GLfXldap9lm8MpX+BUBqnQb1xNaN//mE
	 E6gyutQZpzX+TiBbSHD0hlguX5c+bqKTYFLyDnIabQK+OEosGH3cX9BBxvj0VRC+4T
	 ocpa/oOvYAYS3nrcJbTD+mUTKd8PCLgg121WKuQ5hKzrrywJHAHg2k8dpUkWwnCEzH
	 7ZPaSkCa9WppJvob/T9XygHp6nOHEBq19e47UWxPeXrSNKqNUcSjVsAVqeBAAMec2B
	 /Zy46d8izc80g==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y 1/2] mm/damon/core: allow esz to be set to zero
Date: Tue, 29 Sep 2026 10:44:55 -0700
Message-ID: <20260929174456.9251-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

When the temporal quota goal tuner determines that the goal has been
achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
zero.  However, damos_set_effective_quota() clamps the esz to
min_region_sz when quota->ms is set.

This is a minor issue, the main problem is that it doesn't match the
description in the documentation, which state that if the goal has already
been [over-]achieved, the quota will be set to zero.

Fix this by set quota (esz) as minimum as possible.

Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # v7.1.x
(cherry picked from commit 90179da203ba8b708c84a12a07cd44be0f346334)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6fa02025d2af1..facb1fa1f695f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2191,6 +2191,7 @@ static void damos_set_effective_quota(struct damos_quota *quota,
 {
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
+	unsigned long esz_time;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -2212,8 +2213,8 @@ static void damos_set_effective_quota(struct damos_quota *quota,
 							quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
-		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_sz_region, esz);
+		esz_time = max(throughput * quota->ms, ctx->min_sz_region);
+		esz = min(esz_time, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
-- 
2.47.3

