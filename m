Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D6477E2E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196984; cv=none; b=cSn6Yu/GjzXtdUOEM2Hrx7HpNbcOTGP22JL//GNNTBezEEwQSE2QYfMEVDBh7rDW0gj9/2wB/spNJyQgrkHm8/WfaLMoSVu1Ggamy96XrKGHlpsbXlexB+IBum2m89m1taAOYKlPeZcombqDvsPi5yO8xaJCsuIht+MFszXykEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196984; c=relaxed/simple;
	bh=SAR9dgr4+EXhj93uqEzSXls5BNFL+50Ud2uM/7Eimcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQTaxiE9c/hDdv+vJciRGusM4azHuwd/TOrv3s65VpPiX4mJMbPVnA01REFQtNKNPnIy4qwCI6NAzoR6USTwpHx6iCrB5tGypvuKXjRpziiT1GtWn699bwQCY/UZkSDxgktvdKtDXKMGl3n/eII+L9gSubBYV2xaKrVv6TUZcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyxXPxXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyxXPxXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE311F000FF;
	Mon,  5 Oct 2026 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791196983;
	bh=WipYD8H8D0uihJfKuHMjAiADyhEf9WwTgm/ryo0FeBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JyxXPxXY9F88uHMk0TkfHQhDdqoltAd1xGHbyCIm8Puw3W8bmT4oSyPrDXG61DwfO
	 AuXcIr0IsESm88zxeSctCk4NM6qfGG0bQOl/ZERbGaZtSMd7XFd5VTKHFiYArVQyG0
	 4h5RFdbsranOPjAA24F2U5mt7qPqx/R9kXJjwuR78SWjc+hby0ASLidbRwJWpLe5J7
	 biQ3/jwBJmbbB/CI96CeFh9sJ7Zw77aa7jQQMR6+flqeSKlgzxLVP3r2BYkNFneKfO
	 vHIX8KEriX3gCQsYh9ff/N3GHVDC+bEndXzwsAxJKeWGwTqMD0YN+LP9aJ5mYSAuuS
	 PBtqF2h+SP3Yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
Date: Mon,  5 Oct 2026 06:42:59 -0400
Message-ID: <20261005104243.1561435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100558-skimming-septic-47b8@gregkh>
References: <2026100558-skimming-septic-47b8@gregkh>
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
index 8cf2ad07ce620..be459903139fb 100644
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

