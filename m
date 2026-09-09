Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B11577E57
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964453; cv=none; b=pUGz3h8oieFDumK3mfrNsENLCevJ4AKSsY41oNUK6yDssRqcJ2ifm3xubspmLC5EU2FhxCcyQOo9st+QIN91S9znPx6pgIoFjJ2Zpth4hPyshiiE1Y62QC6L5T9VDq/0I9zpbAWeplFi8ORjNKCndg4nyi6B27iRfbofsbXl4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964453; c=relaxed/simple;
	bh=ASeQOfjeyhdPbLhASuedExfwpFg01VG6A5+dBubdyMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtFWjT4bE1UmaPsfTEBxRt3mZMrymPLOUp68q7TSveJukHah6AF+XmhXTPXIygXr8ISdMYHczDnGlA3eHlAvVdgt2hksh0rGxGvVAgQmbddKvmVpz2tg7BAK+yN5bb99eyOoSJvMieOm6LUVdfO4qK5wYT+JCTuB9TUFrfzNA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf6/u0bp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf6/u0bp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5261F00A3A;
	Wed,  9 Sep 2026 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964452;
	bh=jx3YAjdy1GQxlSPc8lb6fHtwV8KM/1KqI9ZGG5Ve8Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qf6/u0bphZYWzDImDb+9WSv3Q9/wzeJKXzrLsisv9KDy00s51mTFoL7wdH+6TGs75
	 d63bSCjiVjcoI5dm5TS+/woiJbrl9Dpqx2t+vDTycHqsBF1DmajMNDL75X1Ly5TWYn
	 11b4m/hLusXeatg63jqEv5DKmDEm4P1q11tkS+hpjR/zDPOc6wTfbvoH3g/3ENNwMW
	 gVAOOEqWqlRilw/XQxwg0ApNqWdZCIL1rLqteUWsgnZM0ErPWk6wQ66XEEQl8tcb7Y
	 hv3EyZcFHNzXAcQ1N9zl6bvpxQFgtyBCFLaxaMo1Gb9pWmtYh+JO0K+kuBJvknI/Cc
	 0KK5oXZ3wzGvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86: ISST: Validate max level for set feature
Date: Wed,  9 Sep 2026 10:34:10 -0400
Message-ID: <20260909143410.2509213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090311-concept-diagram-32f7@gregkh>
References: <2026090311-concept-diagram-32f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit e45d6b8472861d3bac86bb37f8556a7c5aca3266 ]

Validate the level before setting, so that it fails early instead of
failing later when checking the bit mask for allowed levels.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ Adjusted context for the missing write_blocked/CAP_SYS_ADMIN permission check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index df0b0118b751f..246013b26c953 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -747,6 +747,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (perf_level.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	if (!(power_domain_info->pp_header.allowed_level_mask & BIT(perf_level.level)))
 		return -EINVAL;
 
-- 
2.53.0

