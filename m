Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2493AB27F;
	Wed, 15 Jul 2026 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085016; cv=none; b=SnrR9bkifgDnLIKRRItH7s4/Bsz/qEm1Oh5nO8WiPPuxhIKJn+Lz04z1HBFbkHrultaDhTljXxuM7KceSq+mNvjInS8lK8EMNNzSV61S5TzhETWkm4yV926W//k0MiZpeq+JwwX8Jmoopraxn3hb+zcJxu6ofm0QEVjTh6qOoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085016; c=relaxed/simple;
	bh=nD/7BLwhckJ2VrbOKHww4GOUnGL9WSDMxtLvVNd99/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FadhbZdUJfW0dV815mjBIfdeFXkZaMeVFhYylYKSfrNnifzVDMWVqaAELtidfMGhRpzebxlj50jEZKoSVxxnoR5yj5g7bSqQOZNUxooTntLP8++MaPbfc6A1RCkM9XlZKDBn2V1vWr8LLXrXkVPdwxGZZzfHY4+J0AfEBTflYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMMF0rtj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMMF0rtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AAE1F00A3A;
	Wed, 15 Jul 2026 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784085014;
	bh=OZlM1xLtscWm6r5E9re97Un+lNNnhMeBCpTniJTuHyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMMF0rtjKzOj0NNvQBnEZPkh8CNIg1ZQIhxvDGhbBTy52EkzBm+3e/8x2Gnzj6Nsf
	 6JdD3stcnyBiFwEMkFGMjBoB8/1rpHvUZEJIp8GfgSDkdu5qbhFDbhc1rFv6FIDUdb
	 I0oASfLvYVVqGqRlhbySFBlqa/S6A2xwZtSa6v3RHhl7Z5R/2OkdsSuCpphyhzhK5A
	 oZMVmL7hEPWSPhDuJInt53pgNVmyltHbjgSiDItpav0q/hMrlqnE4f0tjzEmPrIPp4
	 THGzI+Km+xtK61uFANf0yvaKZxb+YJpaqcz4xaUzCegDhRuAzJfyxmTiN76AGEoGiK
	 I5wFy6TESpYIQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 5/6] mm/damon/sysfs: read addr_unit only once in damon_sysfs_apply_inputs()
Date: Tue, 14 Jul 2026 20:10:00 -0700
Message-ID: <20260715031002.108504-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715031002.108504-1-sj@kernel.org>
References: <20260715031002.108504-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_apply_inputs() reads addr_unit twice.  It could race with
addr_unit_store().  As a result, the min_region_sz could wrongly be set
up.  Read it once.

The user impact is trivial.  Sane users ain't update the parameter in
parallel.  Even if it happens, the DAMON core layer handles the wrong
min_region_sz (!is_power_of_2()).  Even if somehow the race ended up
making a min_region_sz that is different from the user's intention but
still valid, only monitoring itself runs differently than expected.  No
critical consequences like kernel panic or memory corruption happen.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260714142950.100711-1-sj@kernel.org

Fixes: 540a2aebc657 ("mm/damon/sysfs: implement addr_unit file under context dir")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b5fe036f78015..65a502c7746c0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2099,11 +2099,11 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_select_ops(ctx, sys_ctx->ops_id);
 	if (err)
 		return err;
-	ctx->addr_unit = sys_ctx->addr_unit;
+	ctx->addr_unit = READ_ONCE(sys_ctx->addr_unit);
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
 		ctx->min_region_sz = max(
-				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
+				DAMON_MIN_REGION_SZ / ctx->addr_unit, 1);
 	ctx->pause = sys_ctx->pause;
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
-- 
2.47.3
