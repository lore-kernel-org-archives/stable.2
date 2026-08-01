Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413123C8AE
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553417; cv=none; b=LYceZHhklGTEpW17lgPh2AAfCG4WBi+8zyXdH/gcPtCEP+qnqQHBB0BUkkh5lfXsYmbcH1W8xsL7W9fRfxcGGXDQp1hB7psMfBkNMSwLHVK4OKCxQJxoNm8YMFdKeToaeokHVEz5tZfNZqB9LpyxqEBn7aQROEPSW1ZYs+r7d5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553417; c=relaxed/simple;
	bh=MGjQbmLabuuC6baKlryMEJxjxCVDIObAJAX27s1KS7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1ypxrGZiGGL2GDNmqFShpbpivx9DbAkTVniBSgF8A6CLrqIs815Hf5S5QxB6NSHuT/Zt2iTecKmCaoGm8C7Z1UJbMvGHLNPDE8bWxn/xjU6bfSUH9LBzDQ/4364KdZIB86/I6CuQbu9wCzmlW8/vZNlmri76jxKw2eWDT7HSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYKfCFpi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYKfCFpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC331F00AC4;
	Sat,  1 Aug 2026 03:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553415;
	bh=GBlned1Wvv3L8SbfBoz9QobMG8I6GcqpTvEqqjM6sz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYKfCFpix/zVckfhtlu07GCrqZYev2+GfdjcCppQBEkYW3HztESw0KbIYyhaXzV+X
	 alRgiOH+UTadiJpGaDcuqAewvSuuz99KdpwpbbKcokhH6BuPoJ83HlTF9G14MqCtcp
	 OfAHPfaFMUDa5Mi5yfKIipH3Tbt+vQyo0+czEqktPGNZ56Lyjv0SBL8fdUni8m7ReC
	 657wVMwN950J/raJeFtEavCeTKR/RycsEJMB3VXUJbSgd60hDmp5hPVUXmt+t8kUPK
	 ZcOAxvnE3H15g6NTKGOh/zRGZ5u6nh+hhfBoNfcX9bTLjqswQy4OgBynRtQo2wcFjG
	 R78Zd65dHnkIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/6] drm/xe/lrc: Refactor out engine id to hwe conversion
Date: Fri, 31 Jul 2026 23:03:25 -0400
Message-ID: <20260801030332.859236-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072913-snap-snuff-32d6@gregkh>
References: <2026072913-snap-snuff-32d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>

[ Upstream commit e3a9c46fc3a29b8d7f62a7bd73bf20975037dc82 ]

We need to define more helpers that read engine ID specific register, so
move that logic outside of get_ctx_timestamp().

Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Reviewed-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Link: https://patch.msgid.link/20260507162016.3888309-20-umesh.nerlige.ramappa@intel.com
Stable-dep-of: 31e243756162 ("drm/xe/rtp: Maintain OA whitelists separately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_lrc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 9f29dbe890f6..17f31b032216 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -2324,17 +2324,27 @@ void xe_lrc_snapshot_free(struct xe_lrc_snapshot *snapshot)
 	kfree(snapshot);
 }
 
-static int get_ctx_timestamp(struct xe_lrc *lrc, u32 engine_id, u64 *reg_ctx_ts)
+static struct xe_hw_engine *engine_id_to_hwe(struct xe_gt *gt, u32 engine_id)
 {
 	u16 class = REG_FIELD_GET(ENGINE_CLASS_ID, engine_id);
 	u16 instance = REG_FIELD_GET(ENGINE_INSTANCE_ID, engine_id);
+	struct xe_hw_engine *hwe = xe_gt_hw_engine(gt, class, instance, false);
+
+	if (xe_gt_WARN_ONCE(gt, !hwe || xe_hw_engine_is_reserved(hwe),
+			    "Unexpected engine class:instance %d:%d for utilization\n",
+			    class, instance))
+		return NULL;
+
+	return hwe;
+}
+
+static int get_ctx_timestamp(struct xe_lrc *lrc, u32 engine_id, u64 *reg_ctx_ts)
+{
 	struct xe_hw_engine *hwe;
 	u64 val;
 
-	hwe = xe_gt_hw_engine(lrc->gt, class, instance, false);
-	if (xe_gt_WARN_ONCE(lrc->gt, !hwe || xe_hw_engine_is_reserved(hwe),
-			    "Unexpected engine class:instance %d:%d for context utilization\n",
-			    class, instance))
+	hwe = engine_id_to_hwe(lrc->gt, engine_id);
+	if (!hwe)
 		return -1;
 
 	if (lrc_to_xe(lrc)->info.has_64bit_timestamp)
-- 
2.53.0

