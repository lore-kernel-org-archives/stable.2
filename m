Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F88576EA9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963273; cv=none; b=Kgxk2pEphDplK7KinrUh8PLsQnI+YuB801sBy/CL65w8/zEzQFVLgr8FvEo3JvTN/55CN1TTMPNc6vqT6PVZBDs0Vztuwgl/yQwLjFrPhBLm5auvs2RllIV1JBypR3cZGc8pXsTHnZjlaleFzCz5HtHvMrCmiNWCAn50NqYwapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963273; c=relaxed/simple;
	bh=aA0igMpSHfh98ck5uVlFnOSq03LNeL8dR76qNxNQ2dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0CzwnB8FYMaGf+xELUP22RRttPRXfOnFJA3W2BNoLSUvDb6yb2It0Gsq0+J5d0q57e3NkfTFgbxNwdTQl8BA+oBiWpDeZT/xSrWrIp7Nt/TWfrYumNAMwzXCqK+/dAw4Aghwo+Quizp41NR+3wdAY7teoiw5BIs+yIrRfXey8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHhKKdp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHhKKdp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3A71F00ACF;
	Wed,  9 Sep 2026 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963272;
	bh=ho1U4zi45ieRIWZFeA+cjpTs1qkRPuEEQ+0f0+8vsL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oHhKKdp+lR5wlDJslEncv/1XFbwG5iN+vcZ9LgUlUPK+Rf8LLJOel1GbsVkf0QZ31
	 rJ4mIjVYdM6tqgPaOEOejf3wrxjl7Y9KrxV166YWOiv9FzyEe0+8D0M95J8hR+6Hfw
	 YOfuv5taD4KStwsZKfioKIL+DWh1N6LnMqWXDCzklq+0SRg27lW7meLcRg04bpm6Og
	 pWpmpaTYJE9FzqYD3sP0p0M98uqPl7w3R9zbWnirKStcnzOrE6Rc3GV5jCwTvfuVFs
	 uA2evInMkS89X8rv0IJcUqXHleNKproQ/O/FS15SS6i2CVos3DzkCmYAHbJCiszOkl
	 NCPjkatg86oIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] platform/x86: ISST: Check for admin capability for write commands
Date: Wed,  9 Sep 2026 10:14:29 -0400
Message-ID: <20260909141430.2391220-1-sashal@kernel.org>
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

