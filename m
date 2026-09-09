Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951323392C;
	Wed,  9 Sep 2026 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924520; cv=none; b=YVyZsLwnoVxClqxW1oy8Uc+LWDsLgKhebBmMULHQ8wY6f88JRL5YkHEdPWtE0pB4g4zskky+WhclQqERHOxT+1MG1cVRMEvj0wk4m+djnxeo44OWL9GxCH63izS5z7e+S/dlVvcZ7bAsCOxjBkIB3gAdrvwq1NoZyslqyDBrLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924520; c=relaxed/simple;
	bh=/3l9nix2vwQHuWPT09u1txRbdDv/fksbBSmM5lh94Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM1LAVNJwQQGuKI7EbJXSA+8dra8i6K6o95T6+4MN2IRKubt6VW774erccjebWpJ/c01Mq5M8cgheJj552eDzJsrIHFIj9pKKCHTx/7ISPTRAl50KOWJEMaH3Jnzx5kZQJ3S0VP8T4rvGd/nccsTJttCvFtugiTCz9mVGQ4mVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHI6ygB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHI6ygB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11DC1F00A3A;
	Wed,  9 Sep 2026 03:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924519;
	bh=WRF4vjxuZ288Rcm2qjPqcfwaoWiMQ2Hzut+AO/bkIEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mHI6ygB+sjhAlL/8eAf4YwEIUYMJoxMqgTH1Ywd/DZ5VFSK/e+DRBuRKAg6PpecKs
	 5DUK/AvZWUnLRs4gAwEYQqJ274d/XNMPWXKbLB3cZKliH9xvcLgOwRqzwBlH39DmKT
	 sh956HPXZ+9hic/Tc74tgj/DUTyOUX3f1kNtV1i+KnhK9b43LwIMuYzAcNRltIFIJj
	 RmAp1qEAsNyIRjw4fKy5L6TyAHEeA8v5sVBMI9gGWav1zXCiFkTgnkvWYUyzb6EjpX
	 KC7mT+JydsmYG1afJ2kQWvvC+hC+7+hKBKv1NKyDLCDtS7djhhXh9DnowdPOtx6jvw
	 u6WiUrnvDivLQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/sysfs: read ops_id only once in damon_sysfs_apply_inputs()
Date: Tue,  8 Sep 2026 20:28:30 -0700
Message-ID: <20260909032830.119383-1-sj@kernel.org>
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
index a6c3e83a3dad5..655e4de69bee8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1432,14 +1432,16 @@ static inline bool damon_sysfs_kdamond_running(
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
 	ctx->addr_unit = sys_ctx->addr_unit;
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
-	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
+	if (ops_id == DAMON_OPS_PADDR)
 		ctx->min_sz_region = max(
 				DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
-- 
2.47.3

