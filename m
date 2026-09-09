Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AA492E46;
	Wed,  9 Sep 2026 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924303; cv=none; b=hlzuuM7kgW6MIhtJmht/zayKcSidrlSGI+BgJSxqKo1anYIgmJHzfIBBQ0qk/FVIoUKM1+1WqAqxIJopyA1/S4fHkqFQFzsmKoo0dbk85U9SwyjMFo81/sjEYlNT4J6NVyrbojdlvNR3SseHPHQTf77Yl0iUHzv/J/endyCwEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924303; c=relaxed/simple;
	bh=ypoKuL7h2Kn07lvWbuTU+eneSMWhz7FCOvIdBUAiFAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj2xcDP+F++mRbUt3GGSalMYVGO0RRm48t0gdudxlY4XqF+REHUDrLKn4sviiuWs7iOYXlx3te6YrYGbswDFsss3Ci4b5pN98vGfIbpukR78SbyYYfMDH2kpUWWl3QyoXn8wYZsVA98TBE12kYAlsIwR9BlGA0BePk19EOPdIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crqD5s8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crqD5s8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33081F00A3A;
	Wed,  9 Sep 2026 03:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924301;
	bh=YRbwIiygaHDP4aB4VmiSkOvOnZ+mdSsCmAyL3oBTIWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crqD5s8/hlG5hcXRnKOqareKYr9L8/2js0f3fX7vkIuaZU7WUVaWLLEXjaYXhTf+n
	 astdG/EvbsYO4DDEYop7d7lCq/KCMeLZFlhuSnazf7yiWy0aJArK7uIKklwCHll+2B
	 uQd8Hk1+tvn6yhEGBtSSPoBy8k5SDOJw3qdTMac7JopuDILKDt4Onnj/6eEloo6Uqm
	 Cr74MXUSmqwWDT+gpIAARRLHGmc6sqX55uZlv7Po7E6y7WlSEs767MpIQPjMK0S6cN
	 uOb1v5VJ4WwQweTAjRCuVUX0+YexSEJHO86bDUAhruPZyjW72JDAhg2Zqfy2EGoJVm
	 VfxLH42C4AMcg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/sysfs: read addr_unit only once in damon_sysfs_apply_inputs()
Date: Tue,  8 Sep 2026 20:24:52 -0700
Message-ID: <20260909032452.118744-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090850-untried-sanctity-a00c@gregkh>
References: <2026090850-untried-sanctity-a00c@gregkh>
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

Link: https://lore.kernel.org/20260715031002.108504-6-sj@kernel.org
Link: https://lore.kernel.org/20260714142950.100711-1-sj@kernel.org [1]
Fixes: 540a2aebc657 ("mm/damon/sysfs: implement addr_unit file under context dir")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit ab4d9358e32316fa39b5f1f5360292135978c3d9)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index a6c3e83a3dad5..0b14e342ccf61 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1437,11 +1437,11 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_select_ops(ctx, sys_ctx->ops_id);
 	if (err)
 		return err;
-	ctx->addr_unit = sys_ctx->addr_unit;
+	ctx->addr_unit = READ_ONCE(sys_ctx->addr_unit);
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
 		ctx->min_sz_region = max(
-				DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
+				DAMON_MIN_REGION / ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-- 
2.47.3

