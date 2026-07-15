Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786BE3ACA70;
	Wed, 15 Jul 2026 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085015; cv=none; b=iEDvYWt06b2HbNO1alMfjkebSIMEh2Suq6QGh/gAhoMTbPZcdS+t/3NtAwyJl35SgsWjn/RdblTIferzjRerLKhTbBz1dqXgl1ueI3RR7n4wisMkZTd9kNkrxOgsYqFQOv8Ngy/OG1M+mRtTHeJw7nHV0hSIW7tr2X6/1L7TVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085015; c=relaxed/simple;
	bh=8EAZYoQVxXJWP2LY9Eji3Og75kTEnJ3aHhWisdL4r9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb7C65SwJEezuxK+PnPhoVXgft3qb+tQoPGiPsfowOGrIpTzuWe5NfGYauq9luUlUGLyMY8FqVa9E38j9wuo7Ugwe/NglPzmXUfglTGqTnJDdjCb5Zqs+s6d6SP6mH2nmGu+J68r3HhSf0I8DfnTw/uzjv+/qA730Ec8Bg9gUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApGedlzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApGedlzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312081F000E9;
	Wed, 15 Jul 2026 03:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784085014;
	bh=r5eHq92k38jxsVe2qYUSBxPPKXWBRjXR/oltUI6KEm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ApGedlzt4TB8XMMtRUBW5laM9bbzhhkdz8thJzqOnktxgQs//OWRRMHJ5FgccyqmJ
	 k7/H/bjiH0ndpsKb09xLw9h25j/Rg6BmTsKDAAwLsCJaWdkn3lFo2Arz68emF1zzWK
	 ta3Q9h7L8icauUyQJmW+2XPi8PT8zPIOxqSp9WtPjwHpt3QQxmZogxn9fcxgit5Br9
	 o4WczTRKgDtfGAyVG1D0Sjz0bZGKSvRi13FFlFONO3rmh+olvMNgURIw878AEYi9K8
	 AOIessjPfXioxFtpiFsSnbGhezs+/1XXTQqfHMBvZagOS77+INLoc/Q22y9J4A36UE
	 ixzE/qKTRlp+w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 6/6] mm/damon/sysfs: read ops_id only once in damon_sysfs_apply_inputs()
Date: Tue, 14 Jul 2026 20:10:01 -0700
Message-ID: <20260715031002.108504-7-sj@kernel.org>
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

[1] https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org

Fixes: 8d009da32f13 ("mm/damon/sysfs: set damon_ctx->min_sz_region only for paddr use case")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 65a502c7746c0..d777411f851c8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2094,14 +2094,16 @@ static inline bool damon_sysfs_kdamond_running(
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
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / ctx->addr_unit, 1);
 	ctx->pause = sys_ctx->pause;
-- 
2.47.3
