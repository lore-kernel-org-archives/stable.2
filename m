Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F2382F15
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586047; cv=none; b=KHcPPqpoXePaAUaLXUPam71QuIK5VZ6cFyFEzDyfOHa2GvDesQKQbYCgxrP8UKkcC9wKrTm0ZyA/2L4uT28IZ5rHTFM/nXGmV6TC2GIMyUJnn7fEaZqv25rjHyUvep8jmz6IrbGR072pIRyQoIcAdI3fXUvcGwaXXn5p3snPx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586047; c=relaxed/simple;
	bh=hbG/pWJENGmAe24BijS4pzPtTFFDss6Ih5AJOxDkKfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbxtaS3VPigG76EGPmym3UpFrq9SkroZLkvNqHv0Yl1t+JSxXKTkRVU0Fz0St3nj9JH46Y1nGMURtn2J5I6cLZdHATpmv6421svdMzEgbPWe9Sg31/ZtKKAHOV8Cd+az+xIG+uqabZbR5Ezwc8qSqrJ31T9ERhRkmpjqS1uV2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LARuwrBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LARuwrBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95A81F00ACF;
	Sat,  1 Aug 2026 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785586046;
	bh=ztU3WYTQ5lct9weRuqDSjmSF5u/gy0olAfCFwkAKWZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LARuwrBh0nxk3dDph6ra1LzAGXyXH3MDctTR10z0sf/6ntmwWeAZko25Li/orYxC1
	 YBNvXQ5O++Eg/dO5kI5yk1FOZJWAQxAJTRe8wudQw+yC0BODQyfDkpSVKaM8OlhJ0+
	 ooBXVIOmUo4v4eM0r3l0NiqFoAL+lg0wfcr/Tyab7Gy3Az1SBoAxZT/DFXD/FrY2ba
	 RRr6sjBQGql3q+ZdfaMMLluXkUTg39nkguqo8zaZA5Gl0qIXueHKy5zguCbVYZf0V3
	 y1plPt0qhKOxw9lOzncEbcaLW3+CzIHnoOuxFRk9LM60+L4+qvrXrU45PWz0aQMhfu
	 e/0DPsoyYXlpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] drm/xe/mcr: Extract reg_in_steering_type_ranges()
Date: Sat,  1 Aug 2026 08:07:19 -0400
Message-ID: <20260801120724.2790990-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072935-vicinity-override-18e2@gregkh>
References: <2026072935-vicinity-override-18e2@gregkh>
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
Stable-dep-of: 4fe2844b0f0c ("drm/xe/rtp: Generalize whitelist_apply_to_hwe")
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

