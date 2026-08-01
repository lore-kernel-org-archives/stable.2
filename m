Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA73148D9
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553417; cv=none; b=J6oZOCgKwEHLW4VhcrTimXWFbYbYmHn0nEBqORddgpLJLbKySEKh1TCvfU3LUvVTexbs6FGTiK13qB2wiWG3EMV/efI2ud61IBi3p60/aw9wdyDf0n1S5N1JPKjfgEiW4hLv82pUE5D8adi6huF+7D51CmY/r0/XpVBn2wxl5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553417; c=relaxed/simple;
	bh=Hu1jRrb86ZPeyY9tIYY5ihiE82ilDmJHEf/o2O8b0fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcsJMh4kq0nroG5LHxnqiTclde+LKp6ttNm/1xVZI3EdNVPXiqko80vqHDt/YIj5XEqZW52RipeAUvYrWmYb5kKdUvNHYIxdP0a1v+c7wz4wi7TNjFLt2lzfVohV+lcyqQMVmhPOrDpyLGTuNfoxrdq138OEw74Lggjr2Plktnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSgq/D8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSgq/D8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C346E1F00ACF;
	Sat,  1 Aug 2026 03:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553416;
	bh=2zqHl1yuJ6COoZK1QhucYKnNOM7qTtGqrZkRut5jkS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSgq/D8spY3xvxkoMIFJgEMbQG1a+BNtmT359QpejS9A2EPrfQG/3rMW9ZU0egJFR
	 U6gzx2hXWrknihLxANxKbiE1mH2V0RQxBRDLZM0iQGC+Rm62SVbO9c2xjKAgmj+9Lf
	 EJQYoe5iOxTBw/HBTctOWsi8q8tLSo0iztgdoa0TiJ3kgGFDz3AniMfKvaax5247w2
	 FehkkYxTz6gLheMG+OhWvYtCbAGJfAhcvMKiB8Erx/PJWZnELLjBUjZSjt+BUkXTQ/
	 aBGqfmeivtAE0ucWmNIRri6JmzX1DvIwerc+0cBY8dCssNtGdclwtBVr2HG0QmZdpE
	 X9Vl/ze7U7QIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] drm/xe/mcr: Extract reg_in_steering_type_ranges()
Date: Fri, 31 Jul 2026 23:03:26 -0400
Message-ID: <20260801030332.859236-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801030332.859236-1-sashal@kernel.org>
References: <2026072913-snap-snuff-32d6@gregkh>
 <20260801030332.859236-1-sashal@kernel.org>
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
Stable-dep-of: 31e243756162 ("drm/xe/rtp: Maintain OA whitelists separately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_mcr.c | 43 +++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mcr.c
index 8fb1cae91724..c7164604846f 100644
--- a/drivers/gpu/drm/xe/xe_gt_mcr.c
+++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
@@ -542,6 +542,20 @@ void xe_gt_mcr_set_implicit_defaults(struct xe_gt *gt)
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
+		if (xe_mmio_in_range(&gt->mmio, &gt->steering[type].ranges[i], reg))
+			return true;
+
+	return false;
+}
+
 /*
  * xe_gt_mcr_get_nonterminated_steering - find group/instance values that
  *    will steer a register to a non-terminated instance
@@ -563,30 +577,21 @@ bool xe_gt_mcr_get_nonterminated_steering(struct xe_gt *gt,
 					  u8 *group, u8 *instance)
 {
 	const struct xe_reg reg = to_xe_reg(reg_mcr);
-	const struct xe_mmio_range *implicit_ranges;
 
 	for (int type = 0; type < IMPLICIT_STEERING; type++) {
-		if (!gt->steering[type].ranges)
-			continue;
-
-		for (int i = 0; gt->steering[type].ranges[i].end > 0; i++) {
-			if (xe_mmio_in_range(&gt->mmio, &gt->steering[type].ranges[i], reg)) {
-				drm_WARN(&gt_to_xe(gt)->drm, !gt->steering[type].initialized,
-					 "Uninitialized usage of MCR register %s/%#x\n",
-					 xe_steering_types[type].name, reg.addr);
-
-				*group = gt->steering[type].group_target;
-				*instance = gt->steering[type].instance_target;
-				return true;
-			}
+		if (reg_in_steering_type_ranges(gt, reg, type)) {
+			drm_WARN(&gt_to_xe(gt)->drm, !gt->steering[type].initialized,
+				 "Uninitialized usage of MCR register %s/%#x\n",
+				 xe_steering_types[type].name, reg.addr);
+
+			*group = gt->steering[type].group_target;
+			*instance = gt->steering[type].instance_target;
+			return true;
 		}
 	}
 
-	implicit_ranges = gt->steering[IMPLICIT_STEERING].ranges;
-	if (implicit_ranges)
-		for (int i = 0; implicit_ranges[i].end > 0; i++)
-			if (xe_mmio_in_range(&gt->mmio, &implicit_ranges[i], reg))
-				return false;
+	if (reg_in_steering_type_ranges(gt, reg, IMPLICIT_STEERING))
+		return false;
 
 	/*
 	 * Not found in a steering table and not a register with implicit
-- 
2.53.0

