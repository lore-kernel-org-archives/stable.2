Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B537B3E4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187687; cv=none; b=ZJxYl9++pHtnuvIFau/Ryns9RIVpY5NGX11+/Wbn4Ev9V/6i+dmIDygULyrhBfP1bAtq7CwMpSFkXa2b66CR8e1LmAHLeGhyc3q4scygIy2S1+Y5Ka8LmVwFAVeLysHlM1apFMZ4w/YOMy96U0UPEhMhoHfIwXhlTOOd3njxWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187687; c=relaxed/simple;
	bh=DAdvX4eL727HF05trlhQ8gTcwTwNSDG3KUSM1Dwzf88=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VVU6s+9q/DqKEVbN4Gjt4CAYmhAVvAXJbokqw4fUt5/imq0V9C3kuJB+w3YElLanHQR7+joI95ZH1xCXm0gk0oPEGn18tDIwlZJiqcRefbQCqZZK9ojE7ykG+jeZ9PsaD1HzrNJSouHH6EKi96LSSWVl2yWWWH8ErBWGl6HhIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKbMBzDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKbMBzDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E28A1F000FF;
	Mon,  5 Oct 2026 08:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187685;
	bh=PYm4kuYJnbfH5N4ZottAMUz5o3A2240X+3leJbyRiD0=;
	h=Subject:To:Cc:From:Date;
	b=ZKbMBzDoBTRuXQxr0psgjYUMJvPnPEnAWXi2oiFb/CHuNq6j+ULOkyGVujvR178HL
	 yDZZi+J+YXVP0BRKmGo5b8Lm/D+/oFCBoZWixq/T8U93Ndf6lZ7eOC3wX7utMjIoCS
	 26Y5zMrHA/0NViV9v59QWpXJkS4xoffugQZbq5d4=
Subject: FAILED: patch "[PATCH] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for" failed to apply to 5.10-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:07:59 +0200
Message-ID: <2026100559-unboxed-evaporate-2cfb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cd883d0a3937df82a5ea03709ba8ba623b868419
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100559-unboxed-evaporate-2cfb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd883d0a3937df82a5ea03709ba8ba623b868419 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Wed, 23 Sep 2026 14:03:53 +0200
Subject: [PATCH] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for
 PPSMC_SYSTEMFLAG_GPIO_DC
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 012227c70600..064f7615759c 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5263,7 +5263,8 @@ static int si_init_smc_table(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC)
+	if ((adev->flags & AMD_IS_MOBILITY) &&
+	    (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC))
 		table->systemFlags |= PPSMC_SYSTEMFLAG_GPIO_DC;
 
 	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_REGULATOR_HOT) {

