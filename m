Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167515;
	b=PuTk7/U9Lx/HWsHmXYPO6lDaRGmeTVr57P1G6F0SvIkJXQidepg3Y6G5xk9u9slGg4k/
	 zB4sRccuFiAajZa0m4zNR5bCZ5IxWYlJCdgBCBq6JVl8oLqhoP/leUwZ4//N4hDxDmxMC
	 nXWz8nAbeCO4gbCIT4jo2DLYqXWGCAck8+9SN/J7AK5sZfsWhK25d+C99gJI8gxTc7lBs
	 +P0g1V71rP83wbAl81KIhqr2CIAmo+amydekYatoB5zGQYr8jmSGMDMjtwTCKrGKt+/LF
	 5EhXId+JbLfsPmF5klCIlvXFj+wJR4PdWlPnaJqmUZh7HR1SXGt9E9Lxtq3138Kmx4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vOx4qL3rBGLSIPXxU4NuO61z7Gu3DhBSLmuQAAlPYBc=;
	b=dXYsezBEgUCbG+xPvxoAmz4xWPAAIijikoMTxQVasdPGVBXvef0h8vbLpWEqJVLSUtft
	 hfVmUu4YBTPct2zWAnUIoGsBlTMT9k8rVnFmmRB/+s1aTswOj6L390S05OYxHgOXX+IJM
	 7+1bjUqsm3fYNXMScCy4sU1lBswSxvTbQSGUMuoyThMwrC6tijNr+o/19jkNRS8y5asTu
	 6dUnRclqemkuPnjDVZ1yW8P590YO00rPaZ9zzutlGRvevNZgf79Q+2Bk0RNl0tRFBOgh6
	 pHyZ+oUMHaDaK84ZZ77TUyFwTR5VqRym5hLoK9bP0CBVEB2mpgwT8howFZ6xxlcQWpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIr3NXWU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AD606D806;
	Sun,  8 Nov 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIr3NXWU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCE41F008A7;
	Sun,  8 Nov 2026 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167514;
	bh=vOx4qL3rBGLSIPXxU4NuO61z7Gu3DhBSLmuQAAlPYBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NIr3NXWUDIdw/+SRCAsv7EOx4DwRXcDU8pn2MgfKWuJYGlWoulDCBI3EwsRNI8Yc/
	 zYgvJ61JemS+pT7jxFxDClBaG8obLC8ff2gScdPW0OEwsORpvKJOGY66S+NsQUeQr0
	 ZYI5C6YtFFOopdUEQrAeJk1IwJRRe+UAgShJ6gJ6UplJbj2Y0U7IjNqgii2IgUfCN3
	 N2jN/8XBZ0nOfh0j/LAST7lSAK02ZjYGE+hTyxVLGNof3lFzpgwPIW28E2SMRd/pFc
	 m1J0KO+9Kyg8sehCsZPu6fbZ67MMN5sbAtFu/OIfgMC0ewWxDuibcCEyKiQTLDMR7E
	 8zMl15LR7qCCg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 6.12.y 3/5] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Sun,  8 Nov 2026 11:51:42 -0800
Message-ID: <20261108195145.115792-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108195145.115792-1-sj@kernel.org>
References: <20261108195145.115792-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
delta for the feedback loop is calculated using
damos_quota_goal->last_psi_total.  However, it is initialized only after
the first feedback loop.  The first iteration of the loop uses the
uninitialized value.  As a result, the feedback loop can change the
effective quota in an unexpected way at the first iteration.

The user impact of the issue is not big, because the issue impacts only
the first iteration of the feedback loop.  The feedback loop also has an
internal cap of the quota adjustment.  The wrong adjustment will soon be
corrected over a few iterations.  For this reason, doing no initialization
at commit time was intentional.  It is also explicitly commented.  That
said, nobody likes behaviors that are unexpected or difficult to be
expected.

Check last_psi_total initialization and skip the tuning round when it is
not initialized.  For this, initialize last_psi_total with U64_MAX in the
goal creation and the goal commit time.  U64_MAX means the field is not
initialized.  The tuning round shows the value and adjusts it to guarantee
the current quota is maintained for the round, and last_psi_total is
correctly initialized on the next round.

Before this change, committing a new PSI goal on an existing PSI goal with
goal-only DAMON sysfs command (commit_schemes_quota_goals) just worked.
After this change, the tuning round right after the commit will be
unnecessarily skipped, because last_psi_total is unconditionally marked as
not initialized in the damos_commit_quota_goal_union().  This is an
intended tradeoff for simplicity.  Skipping just one round of tuning is no
problem.  Meanwhile it makes both the code and the behavior simple to
understand.

Also update the quota goal commit unit test for changed last_psi_total
setup behavior.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org
Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org [1]
Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Tested-by: Lian Wang <lianux.mm@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Quanmin Yan <yanquanmin1@huawei.com>
Cc: <stable@vger.kernel.org> # 6.9.x
(cherry picked from commit 29c6084658af41b5b1fefd873d26d441830ced34)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6ef77741b783b..52f01a6508b66 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -324,6 +324,8 @@ struct damos_quota_goal *damos_new_quota_goal(
 		return NULL;
 	goal->metric = metric;
 	goal->target_value = target_value;
+	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		goal->last_psi_total = U64_MAX;
 	INIT_LIST_HEAD(&goal->list);
 	return goal;
 }
@@ -705,7 +707,8 @@ static void damos_commit_quota_goal(
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
-	/* keep last_psi_total as is, since it will be updated in next cycle */
+	else if (dst->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		dst->last_psi_total = U64_MAX;
 }
 
 /**
@@ -1608,7 +1611,12 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 		break;
 	case DAMOS_QUOTA_SOME_MEM_PSI_US:
 		now_psi_total = damos_get_some_mem_psi_total();
-		goal->current_value = now_psi_total - goal->last_psi_total;
+		/* uninitialized last_psi_total; make no effect this round */
+		if (goal->last_psi_total == U64_MAX)
+			goal->current_value = goal->target_value;
+		else
+			goal->current_value = now_psi_total -
+				goal->last_psi_total;
 		goal->last_psi_total = now_psi_total;
 		break;
 	default:
-- 
2.47.3
