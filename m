Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A93563E1
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586042; cv=none; b=JINs4Z+rgKMP8WibpP9lfFTPvfuwGnbPJ8Kd7gUkhjORiQEGwcis0z9qMrQV1AIxGG65EDF8nUDULpTJagltTJ4F52HSBbkodC+IHWPRJZYkXjaCKLLWYQ+Ve5R7dHrba8vA0iTSbHd7kCAMJYg9wjpQV7FB5sNhUPxkCXJKN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586042; c=relaxed/simple;
	bh=feHAen9/S8kdng3r1Nxk86tp3STjV64iCb4RWAPegoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuknEfYJdkkDoRmTaEYAVedd5QxFIo9GLEBb03+f9QAqQkwcTKgCw3qb8Ywi1BD0Z5t2DuCGaqGIPPujbmb3hCqUqfMVfCxcwD/vLyETxRFfrIv2yok77AurDzvy6zHgWiNr1u+kj8EEMBtiXKYPR0AA3CGVizFdMfnfa9Kp50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNWYJUq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNWYJUq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0261F00AC4;
	Sat,  1 Aug 2026 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785586041;
	bh=UVg/1kNofGZsqGSSN5eBKSpNZP/beHG7QkMIVJqjKQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FNWYJUq0upP86x6QaAHY9FYUXhvXEfC0ykQ/4AexFJA3cUu5JQCkVLkxHhLXT+EM0
	 2YfhoqtQV01Hm9LBx06KX43Umd3/Mxye6WUPtC2/sgjw14VNmU7+jDoZvxIVtl5dfQ
	 5E4ZhnAG7hLdZtLwvYYWYY2Tr1mhPWZW8rEXad19jJXatzYs587KFpfhyD9mSciuZZ
	 y1B3EWyCszUAs5SX15NCG4+oQg0ZeK7tVrKbM+oIZ1LbYp6qUD+L3RYT8/trAPOFLj
	 D4/wpX8rlUNCP2prGDDlO90Lio1mT8HNqkV7IG4WUFC3pE5aSLeK3M20i5SD+F8Wpx
	 dzuh1FsYldGcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] drm/xe/mcr: Extract reg_in_steering_type_ranges()
Date: Sat,  1 Aug 2026 08:07:14 -0400
Message-ID: <20260801120719.2790871-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072931-mammogram-purposely-1224@gregkh>
References: <2026072931-mammogram-purposely-1224@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Sousa <gustavo.sousa@intel.com>

[ Upstream commit cdf8489533f4dd9639fd0c266dd2ec8f7a543e34 ]

The logic to check if a register falls within one of the ranges for a
steering type is already duplicated in
xe_gt_mcr_get_nonterminated_steering().  We will also want to use that
same logic in another upcoming function.  Let's factor out that logic
and put it into a function named reg_in_steering_type_ranges().

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patch.msgid.link/20260514-rtp-mcr-check-v3-6-30dd47855fee@intel.com
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Stable-dep-of: 60d49ea28bb1 ("drm/xe/rtp: Keep track of non-OA nonpriv slots")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_mcr.c | 35 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mcr.c
index c834f64b0178..6295cd639f5c 100644
--- a/drivers/gpu/drm/xe/xe_gt_mcr.c
+++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
@@ -505,6 +505,20 @@ void xe_gt_mcr_set_implicit_defaults(struct xe_gt *gt)
 	}
 }
 
+static bool reg_in_steering_type_ranges(struct xe_gt *gt,
+					struct xe_reg reg,
+					int type)
+{
+	if (!gt->steering[type].ranges)
+		return false;
+
+	for (int i = 0; gt->steering[type].ranges[i].end > 0; i++)
+		if (xe_mmio_in_range(gt, &gt->steering[type].ranges[i], reg))
+			return true;
+
+	return false;
+}
+
 /*
  * xe_gt_mcr_get_nonterminated_steering - find group/instance values that
  *    will steer a register to a non-terminated instance
@@ -526,26 +540,17 @@ static bool xe_gt_mcr_get_nonterminated_steering(struct xe_gt *gt,
 						 u8 *group, u8 *instance)
 {
 	const struct xe_reg reg = to_xe_reg(reg_mcr);
-	const struct xe_mmio_range *implicit_ranges;
 
 	for (int type = 0; type < IMPLICIT_STEERING; type++) {
-		if (!gt->steering[type].ranges)
-			continue;
-
-		for (int i = 0; gt->steering[type].ranges[i].end > 0; i++) {
-			if (xe_mmio_in_range(gt, &gt->steering[type].ranges[i], reg)) {
-				*group = gt->steering[type].group_target;
-				*instance = gt->steering[type].instance_target;
-				return true;
-			}
+		if (reg_in_steering_type_ranges(gt, reg, type)) {
+			*group = gt->steering[type].group_target;
+			*instance = gt->steering[type].instance_target;
+			return true;
 		}
 	}
 
-	implicit_ranges = gt->steering[IMPLICIT_STEERING].ranges;
-	if (implicit_ranges)
-		for (int i = 0; implicit_ranges[i].end > 0; i++)
-			if (xe_mmio_in_range(gt, &implicit_ranges[i], reg))
-				return false;
+	if (reg_in_steering_type_ranges(gt, reg, IMPLICIT_STEERING))
+		return false;
 
 	/*
 	 * Not found in a steering table and not a register with implicit
-- 
2.53.0

