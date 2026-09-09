Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0A1C3BFC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964457; cv=none; b=gzhyQIBJiBqCraz8dDox/wO2/Ux47ZNnwkd54jS2GkPcyXWtmLByv0/9Jw9fAPQfr915D1nSw9luP1Kit2atHRjykkAH5i2RiGda82auQ541uFsY2A7QO8YMe23k2IkDCeKK51u8hIIxRboYiV4GER5mInKpQDTaMYPDfDlgrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964457; c=relaxed/simple;
	bh=se0OlPWvN83Eoc5aUEWyoPygHbH0++NbKfSOeOjGftw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd5oUTepPT+McHHZDIkL7NDFZtSwBRh60w3iViwPBg/8aZdSRoqrMqE6BfoUssQ32HUJeGYEwDdD4DS83CAI9FHgo1NG8wpQQt/4orlUV6jT9teozYmrIUO0tYkfJdwtprberrSdH7DUfj956l8RmMYbG45QXrV5RzHLVbfpBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2fLsr9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2fLsr9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE781F00A3A;
	Wed,  9 Sep 2026 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964456;
	bh=YdME++twSnxstgmm+Cos2nU46t0v8q3DjNkmY5UaWsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2fLsr9I57Y78b+SgpVFKqVu8dTKzCrpNBcYNIDGdugRp1Zn6a+Vp1y0bYpUcn3Re
	 H59kobkZCgC/arBjbdnVHwpiRouPFoomTq6xUHJkiZh7IjsCbTk9bHKROn4yJ5+oC4
	 2UVyuF9E5mwCsSCBmZiurvcIysRtdr38GyNo+R7vGrv1X/ep3vcVVFc/QH71lM0yD+
	 V54+3lzJA3eEJS7wp2vKcl7D8+N75KX9Fev650f3MyEeJJE6/dpzZcf3ybSIodGl/i
	 AtGQiJiQP3QM77xpwIYJ5vgnQji9fAXbmLmOVT8T88bcwLh+0CvOc3FmGuGr1kNRs5
	 VzMPN4w/IONBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86: ISST: Validate parameter for core power state
Date: Wed,  9 Sep 2026 10:34:14 -0400
Message-ID: <20260909143414.2509704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090321-shock-prewashed-03da@gregkh>
References: <2026090321-shock-prewashed-03da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 1700b4f804555467b7eff58dff7acc11d508b3a1 ]

Allow only 0 or 1 for core_power enable and priority_type parameters.

Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-4-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ adjusted context for the missing write_blocked/CAP_SYS_ADMIN permission check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/x86/intel/speed_select_if/isst_tpmi_core.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index df0b0118b751f..64a7eefb99674 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -450,6 +450,9 @@ static bool disable_dynamic_sst_features(void)
 #define SST_CP_PRIORITY_TYPE_START	1
 #define SST_CP_PRIORITY_TYPE_WIDTH	1
 
+#define SST_CP_MAX_ENABLE		1
+#define SST_CP_MAX_PRIORITY_TYPE	1
+
 static long isst_if_core_power_state(void __user *argp)
 {
 	struct tpmi_per_power_domain_info *power_domain_info;
@@ -466,6 +469,10 @@ static long isst_if_core_power_state(void __user *argp)
 		return -EINVAL;
 
 	if (core_power.get_set) {
+		if (core_power.enable > SST_CP_MAX_ENABLE ||
+		    core_power.priority_type > SST_CP_MAX_PRIORITY_TYPE)
+			return -EINVAL;
+
 		_write_cp_info("cp_enable", core_power.enable, SST_CP_CONTROL_OFFSET,
 			       SST_CP_ENABLE_START, SST_CP_ENABLE_WIDTH, SST_MUL_FACTOR_NONE)
 		_write_cp_info("cp_prio_type", core_power.priority_type, SST_CP_CONTROL_OFFSET,
-- 
2.53.0

