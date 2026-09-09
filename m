Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C657C735
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963044; cv=none; b=pycT1WCKxSEZl+znntKKnm+mfp7Pl1y+3HvNLp5HFcIULZKB0iQ83dXcm3l8eWFtebka2mk9xGXmlB+vMCyOsOnga9D5mMPEplsNJzUe1+XSTIKoRHXo4Aeij+tK+lIzCal9A06OdDEAuYilYm57jmUFyuo7LvtGWUsRfIMCW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963044; c=relaxed/simple;
	bh=Beo9ObEad9s3iZPBJU+t3oGP7BSgtK3hdf1KkbQ78io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmdYAs4Q/HFb1blSBAURTm89QiV86yram7/fUzk6ol+qlZmdhSVTpDol0C8N8pqL/Lp1GMLCWR9nBaHDjdDE1yzNXnrepXzUP7uJ0up8mE8nT0mbw/VEDFKPeobSpTM/8oWLXcNNkzgsIKuWVOjeBChpd9ru1G0yoFk2v/0W4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH2og/EM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH2og/EM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09121F00A3A;
	Wed,  9 Sep 2026 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963043;
	bh=BN+iboPILznTxMllliS/NnD3fT4KDqUoiARbI/ePGHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oH2og/EMy7f1UHgQffXEMFiHZxgkW0XYsGNCrtHzyrae+0l8BdLj7yXJuNOx7szVt
	 YmDR9qqYAVNyr8OuvDuMG2fm5BZUH6UhXuDqgBSoVqStU/xyUuII7FHCy3XCyaSNgR
	 dD0vYvLpSURz4Juve0ROV78100V0x2xUZ18RbvvzmzGlF7I1zH4hGyTGJaMZR8B1Kp
	 oiNMeKHp4UeU7fxv5qRKXaUHlQtvMDWbAB53sUMDihF+rbDIkDA9JJFlHfRGbaybk2
	 IxVArPl0kuNCL6xGWsmWFcfVF4XfXWqqXpBaoDbNiVk7ewN1SNophl/75D44hda5f1
	 kwG2m6PJi+q0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] platform/x86: ISST: Check for admin capability for write commands
Date: Wed,  9 Sep 2026 10:10:40 -0400
Message-ID: <20260909141041.2381301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090310-gawk-vivacious-d6f7@gregkh>
References: <2026090310-gawk-vivacious-d6f7@gregkh>
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
index 2e2e168d301c3..317738d5b0668 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -625,7 +625,7 @@ static long isst_if_core_power_state(void __user *argp)
 		return -EINVAL;
 
 	if (core_power.get_set) {
-		if (power_domain_info->write_blocked)
+		if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
 		if (core_power.enable > SST_CP_MAX_ENABLE ||
@@ -684,7 +684,7 @@ static long isst_if_clos_param(void __user *argp)
 		return -EINVAL;
 
 	if (clos_param.get_set) {
-		if (power_domain_info->write_blocked)
+		if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
 		if (!in_range(clos_param.min_freq_mhz / SST_MUL_FACTOR_FREQ, 0, SST_MAX_FREQ + 1))
@@ -795,7 +795,8 @@ static long isst_if_clos_assoc(void __user *argp)
 
 		power_domain_info = &sst_inst->power_domain_info[part][punit_id];
 
-		if (assoc_cmds.get_set && power_domain_info->write_blocked)
+		if (assoc_cmds.get_set && (power_domain_info->write_blocked ||
+					   !capable(CAP_SYS_ADMIN)))
 			return -EPERM;
 
 		offset = SST_CLOS_ASSOC_0_OFFSET +
@@ -973,7 +974,7 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
-	if (power_domain_info->write_blocked)
+	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (!(power_domain_info->pp_header.allowed_level_mask & BIT(perf_level.level)))
@@ -1033,7 +1034,7 @@ static int isst_if_set_perf_feature(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
-	if (power_domain_info->write_blocked)
+	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (perf_feature.feature & ~SST_PP_FEATURE_STATE_VALID_MASK)
-- 
2.53.0

