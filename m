Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8739A06B;
	Tue, 21 Jul 2026 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610166; cv=none; b=kWVkn+xmyB/2vwWhvdH6JmvXU77nPuyrHtpu6NgmpM2Kxe9PY5ZIBrQNPo1qQGuxyJvDnvnG7Osh7uK31t5GKQ4HEzuAF+vgCwVDByNwKl/m2J4PDBe5E2PLbGGHWwzEro69PDhOyGGTrDcvD1UOuV1ovrI5sHhyeKwFkDyP2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610166; c=relaxed/simple;
	bh=OlmEQz5D7YedgkQ9mNeO1hFANhWbXmk2P6UPxbX70xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blTuuykMETTxLCInFSl6CINWDM6hGZd9mWDzFSdd831WI5CAuA/yJv4iQA0GcuAhb6nvvY6W/11vMJArvcb9psW6cK4BmkVLwsG3TlhAXvHpyD6J4U5HpHE5m5EFTyIcu+AQwHEMtckJ13KCYsv/1iGz7m4/t3bkjnfgd6BQVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi8Qakup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi8Qakup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DDE1F000E9;
	Tue, 21 Jul 2026 05:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784610165;
	bh=EeEHuBn7hSKVkCw08NIuO6JQM862xQHx7uSjOf4z+BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mi8QakupYcXnejviUwrsDw4Goe6wimm+FiGIpUzbINY6Piu0mDmdn58HfOdqUxcU3
	 AmBuLYOY28urvzdGlTVDBGFiCh7act9chizmPyQw/bpS/ZOOTvR4PzZ/MMOKblkHGY
	 8Wwk3XYYCdcN9/ilUfPI1D2p+aGXzH+kNshILJBnijmkKDGYrj5RP4sdwqp1xMrzir
	 I132VCGsv3YtOVX++Vl+rLlFLsLPFiPdLxavcRsrLphw5reu/HT6Blvxm0IXpJR3hY
	 GrvxvNjoRj5HuSMXBe43mwEno6EatXZmKnLgp9i6A3pi0lWOEm7pmcwS+HSAF0uT72
	 GKC82zHlF78tg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/sysfs-schemes: fix dir put orders in access_pattern_add_dirs()
Date: Mon, 20 Jul 2026 22:02:37 -0700
Message-ID: <20260721050237.159205-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072054-throwing-myth-2a13@gregkh>
References: <2026072054-throwing-myth-2a13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Patch series "mm/damon/sysfs-schemes: fix wrong directories put orders in
error paths".

Error paths of damon_sysfs_access_pattern_add_dirs() and
damon_sysfs_scheme_add_dirs() functions put references to directories in
wrong orders.  As a result, uninitialized memory dereference and/or
memory leak can happen.  Fix those.

This patch (of 2):

In access_pattern_add_dirs(), error handling path puts references starting
from setup failed directories.  If the failure happpened from the initial
allication in the setup functions, uninitialized memory dereference
happen.  The allocation failures will not commonly happen, but the
consequence is quite bad.  Fix the wrong reference put orders.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260618005650.83868-2-sj@kernel.org
Link: https://lore.kernel.org/20260617060005.86852-1-sj@kernel.org [1]
Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit d58fdbe37a829fd2e5803dd4e5a72992dd8c5368)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index bdcf895a29a78..bb2f4650741fa 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -679,22 +679,19 @@ static int damon_sysfs_access_pattern_add_dirs(
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->sz, "sz");
 	if (err)
-		goto put_sz_out;
+		return err;
 
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->nr_accesses, "nr_accesses");
 	if (err)
-		goto put_nr_accesses_sz_out;
+		goto put_sz_out;
 
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->age, "age");
 	if (err)
-		goto put_age_nr_accesses_sz_out;
+		goto put_nr_accesses_sz_out;
 	return 0;
 
-put_age_nr_accesses_sz_out:
-	kobject_put(&access_pattern->age->kobj);
-	access_pattern->age = NULL;
 put_nr_accesses_sz_out:
 	kobject_put(&access_pattern->nr_accesses->kobj);
 	access_pattern->nr_accesses = NULL;
-- 
2.47.3

