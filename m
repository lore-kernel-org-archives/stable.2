Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FE44C66A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197816; cv=none; b=TJgj8hKo3xul+75qhkHWGpCmZRF/My3pKfsgAzlWbhrKZco06KbpHh73EBoUmIcVfKJfEwHStlz1L/WjUTGETObakSWrnjwGWqR9+18NiHMKYw7bz2wLy94TF9Dfnzu4kRqolQ084/lV1OYY3Kj7DoNkc1YJbNXXutNQCqGrAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197816; c=relaxed/simple;
	bh=Z0OLiDqaREX1wjYsMWPEv6xs8KzjC804XfUwxMpTT+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvbtskWPor+Wcb6JWJ7MHswX81ccRb5L8WVX40qmXZW7pWJvTrJe0GtgwLd+Tctl6eya4RZoGsNKxX+rCtxFUBIUhWwB4IjaINkOUKgay9IGeemK3HOGKxylucopYMQnflx89YAqeuqJjPgYEse/YKe+WN5PEVa5YwZZuaVq78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogBCnzvv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogBCnzvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1C81F000FF;
	Mon,  5 Oct 2026 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197811;
	bh=wvdcEYPf+LjFKogn5ExfLJnmoiYjN447XgmW7dDyzMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ogBCnzvv49bDao9q/59Ey0FY6Fbxprzs/n9VWV4zKVWEBOhYlX7pv7oCyT/YgvW6P
	 svZZtBdzxzm0jgi768NhUa7eTDdC47k+7uPv+f6DcHoepe5TA2MHnVDOazYh6jNbVO
	 uDnUXjgPaR/9XPDE/faWmHFyp0bjsOo6KuuMmXcLdRjOseDfHwa50wHJRmCeKBsDb4
	 laS3D/8guEbf8JvFhdU+sp2Wxzt7bsmnPGcB8HjmEkV1nnQg1q3tbhxC14dpZA0TiC
	 tsMrzUSVw/96kfmz50JfnGbEukT1fXG/F3fuRmhDAUnzPEEvsipHUSOtODcAxfJVcs
	 EhC4NuDlGsL6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
Date: Mon,  5 Oct 2026 06:56:47 -0400
Message-ID: <20261005105625.1647145-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100559-unboxed-evaporate-2cfb@gregkh>
References: <2026100559-unboxed-evaporate-2cfb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit cd883d0a3937df82a5ea03709ba8ba623b868419 ]

Unfortunately, some desktop boards eg. the FirePro D500
have the HARDWAREDC platform flag set and also have
a battery power state configured in their VBIOS.
This makes no sense for a desktop GPU and results in
incorrect behaviour: the clocks are stuck at lowest.

We observed that the kernel driver can work around
the issue in two possible ways:
1. Set PPSMC_SWSTATE_FLAG_DC on all power states
2. Clear PPSMC_SYSTEMFLAG_GPIO_DC

We think that the PPSMC_SYSTEMFLAG_GPIO_DC flag
makes the SMC assume it's running on battery even
though this is a desktop machine with no battery,
and that's why it doesn't do DPM on power states
without PPSMC_SYSTEMFLAG_GPIO_DC.

Issue was uncovered by "Fix updating clock limits from
power states" because previously the limits for the
battery state were not tracked separately. However,
battery power state has lower frequencies and voltages,
so the kernel doesn't set the DC flag on the current
power state anymore. That causes the SMC to be stuck
on the lowest clocks.

Let's clear PPSMC_SYSTEMFLAG_GPIO_DC on desktop GPUs.
We can use the AMD_IS_MOBILITY flag to determine that.

Fixes: e6c5d36756e7 ("drm/amd/pm/si: Fix updating clock limits from power states")
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/16352
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260923120354.1027996-1-timur.kristof@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 58473c7c49ce9f5f5a4a1c24ffb9aa1d3c8771f4)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index f4bb4d2c3f77b..79e23092c052a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -5164,7 +5164,8 @@ static int si_init_smc_table(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC)
+	if ((adev->flags & AMD_IS_MOBILITY) &&
+	    (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC))
 		table->systemFlags |= PPSMC_SYSTEMFLAG_GPIO_DC;
 
 	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_REGULATOR_HOT) {
-- 
2.53.0

