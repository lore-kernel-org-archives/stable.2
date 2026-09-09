Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D6581241
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963524; cv=none; b=jPNzBuMbXNljfifoD13w7FMME3Dhwg+9TsvF4Y0+nSKlWSufK3+Qj7GZOyXAmHWp4GX+iR05E7VYDSt23wbqCBua/TdYd00+8JFiiXSnRLRe010mD1uRH8Y/ihM+5w6MfGIlJ3zkqNZqYw/qdXPylIHdjFsZiCBifxaKgynGF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963524; c=relaxed/simple;
	bh=t0iLNaIX5wRq+gf9Z9nAE0WMx0OvHbkY2L2hJ1Lm+0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFo78mejoT4vZ1RYUMxaV6JzIr7MvN6Dyjn4OzRa7P3AcDedhKQPZ/kdVsBs+LOYJWPOeWhFexjQs1yPhiDtZqv/Ae6k7BrxLex1/Q0dG3yhTs7Rnyt4yWNiyfcCVFuFDSWdKsMD2HKTaGynFu7hSTs8RUwdIca8M9VWeSeOYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T20kHQsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T20kHQsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55F51F00AC4;
	Wed,  9 Sep 2026 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963523;
	bh=aKOlHnqY7jsLDFcReZPqgT7L/y1YarRiySnpdPhFeDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T20kHQsAiSjZX+2O58xCnIbMgHM6u3iW1kgYGTuRICQWuOv8AP6/d4I8mBig4nKsC
	 Xz7nBfOKAibfM8AQk32j374feSA97kpyS5s1u/pbdlzMh4FjorAukAVMWbUW45I/jW
	 21v5zPY37g8SpJHcYWnl+1h1JDR8IIS805j4Bl3rTr0OCYG6zgLEByj+VyftYbH2Bn
	 hm0bkcnQl7mT29qQK4McrxwOy8YMXoch2gxwy+NBbpyBI4uP1uzyywuDKSq5YiUGU9
	 Eg3885FI1FDQCZmikDM5HiVVOqzn0Rn/2KzA1wIA8QYes6GGluABumTpd0dusE8uX1
	 yiIvDXblgpcvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] platform/x86: ISST: Validate max level for set feature
Date: Wed,  9 Sep 2026 10:18:40 -0400
Message-ID: <20260909141840.2422032-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141840.2422032-1-sashal@kernel.org>
References: <2026090311-unboxed-worrier-de27@gregkh>
 <20260909141840.2422032-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 3c8fda948b651..7f1885fb4a34b 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -969,6 +969,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (perf_level.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.53.0

