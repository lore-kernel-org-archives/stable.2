Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81E58E2B8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963523; cv=none; b=KAXNSsCAhNPzM783EctTSr6FYpxobK2q4Nnvebk1KPqPHPHgLmec66p4wkmo16Jwdk5gWYXUtoAFiPF+A7Mw7icabVKNEcdH8Qor9BDm6q19kqyWvJzeBl0moUzuKAkEc4ngoZCB80OlABvm1DyXAoM0aQPYFg/ps+to2exu6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963523; c=relaxed/simple;
	bh=aA0igMpSHfh98ck5uVlFnOSq03LNeL8dR76qNxNQ2dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oreVcVZg0vDAu8ztjAjtrh3RPExyTwgD8H4Jlt9mJQxJZPnvEl/0xIWyTjkT/Eo5ZRk5aDrOcDxTbojeiXwxzYvEqT5bDWKPeblcnEnm+fUfdo62e6Ef+mI8jmujBFKN1icWShy+7Jy1IHtp3+I9ku/bB/FXQLTDCPy4HaSYMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1LIDnpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1LIDnpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4791F00A3E;
	Wed,  9 Sep 2026 14:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963522;
	bh=ho1U4zi45ieRIWZFeA+cjpTs1qkRPuEEQ+0f0+8vsL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a1LIDnpyaxgUw5XO0aQ0ESfr0poZmNu0qp3yS8Oq9s16EvXnhgutaICleErXxup94
	 f1udv7HbNutoeSD4j3tTc/kbwdCwNc45FnK/nqippR9JmOkbyfVRIbH15Wj08IXMI1
	 zkqfQyNHYi275zEY9MM1yyQ20tlFJ/lRa/OTSUOcVYC43YIpB+9/SiY5oh3+TwfYkD
	 0bgYNCzMgtGxEOc+wfiXf91XaKaXVEFwEeyTuScN91xv0dsdBbawFJXtOKMr5bobfI
	 aaORec6vb2PHHCLCOw+Q0ES9oRhbw17DOj8L8u5J9Mr3EDho8g6mqz0J8C9zfUTQ6d
	 wDT4fsZo2kLkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] platform/x86: ISST: Check for admin capability for write commands
Date: Wed,  9 Sep 2026 10:18:39 -0400
Message-ID: <20260909141840.2422032-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090311-unboxed-worrier-de27@gregkh>
References: <2026090311-unboxed-worrier-de27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 69cd1ca440a96c85dcedcddfa5e0af6012f60b8b ]

In some SST deployments, administrators want to allow reading SST
capabilities for non-root users. This can be achieved by changing file
permissions for "/dev/isst_interface", but they still want to prevent
any changes to the SST configuration by non-root users.

This capability was available before for non-TPMI SST. Extend the same
capability for TPMI SST by adding a check for CAP_SYS_ADMIN for all
write commands.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260107060729.1634420-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: e45d6b847286 ("platform/x86: ISST: Validate max level for set feature")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c        | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 9d376306e1e23..3c8fda948b651 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -620,7 +620,7 @@ static long isst_if_core_power_state(void __user *argp)
 		return -EINVAL;
 
 	if (core_power.get_set) {
-		if (power_domain_info->write_blocked)
+		if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
 		if (core_power.enable > SST_CP_MAX_ENABLE ||
@@ -679,7 +679,7 @@ static long isst_if_clos_param(void __user *argp)
 		return -EINVAL;
 
 	if (clos_param.get_set) {
-		if (power_domain_info->write_blocked)
+		if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
 		if (!in_range(clos_param.min_freq_mhz / SST_MUL_FACTOR_FREQ, 0, SST_MAX_FREQ + 1))
@@ -790,7 +790,8 @@ static long isst_if_clos_assoc(void __user *argp)
 
 		power_domain_info = &sst_inst->power_domain_info[part][punit_id];
 
-		if (assoc_cmds.get_set && power_domain_info->write_blocked)
+		if (assoc_cmds.get_set && (power_domain_info->write_blocked ||
+					   !capable(CAP_SYS_ADMIN)))
 			return -EPERM;
 
 		offset = SST_CLOS_ASSOC_0_OFFSET +
@@ -968,7 +969,7 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
-	if (power_domain_info->write_blocked)
+	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (!(power_domain_info->pp_header.allowed_level_mask & BIT(perf_level.level)))
@@ -1028,7 +1029,7 @@ static int isst_if_set_perf_feature(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
-	if (power_domain_info->write_blocked)
+	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (perf_feature.feature & ~SST_PP_FEATURE_STATE_VALID_MASK)
-- 
2.53.0

