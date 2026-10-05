Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56403A641D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188997; cv=none; b=hP4E5fCwvra00WQIFC5ci1cU7jyUrRO7aGIYzYwEl05v0/Y+lP241rfc2op7tqGVcggPJKAM9+dCO5ITjlhl/z1qZ+oU/yNa+JK61LdsqU7xIdCzDmE3/dYcS84dp8X3/inqKSoW5Tfux+LeOTO6wzbMnlmXmfVbOnwoyHDiFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188997; c=relaxed/simple;
	bh=2yhIXKseAlEP0hRB0DLxmVWC6VgCdcldJpP3vAG67HA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FK0kFHY7rfLJRUi5F/UiTePKyNov7MV2vhXPcOGZrobFw3PfFyPpvjiBfYKeaTkmTrGvku0P0BQEuYY1ACaotf92slIE3++bob4GVTz2DqGTZccdMvvvG6EhQEDviqi13tvvNoxAEkxnGhyrVeBn5K4tripir9feKHu5laMAXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FWBNO20w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FWBNO20w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19531F00893;
	Mon,  5 Oct 2026 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791188992;
	bh=wiajOhu6DZBHzP8OosKi70dlKNDgW2wa943DQZWvOTo=;
	h=Subject:To:Cc:From:Date;
	b=FWBNO20wY0bMW1qF+DVuGr2kxpNSgeGQ6Ly6rezdH7lFelX7AyQxWH3Ud4W/3oM7y
	 bdfmpD0aHJkwJqBlz2Xs8P4xruxW5aXlSSlyDIq3JCKfYBfe4RPpts7TDc9V//+SeZ
	 FM3yS41Iv3pekcrUUsHNDQsV0ckuCf0SLHAGHf9g=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix fast updates on DCE 8.1" failed to apply to 6.18-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:29:49 +0200
Message-ID: <2026100549-unselfish-oven-e619@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 687d31ea9ac76b299817060fa1e5582d6c752ae0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100549-unselfish-oven-e619@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 687d31ea9ac76b299817060fa1e5582d6c752ae0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Wed, 23 Sep 2026 14:20:32 +0200
Subject: [PATCH] drm/amd/display: Fix fast updates on DCE 8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DCE8 should use legacy fast updates.
This was already set for DCE 8.0 and 8.3, but it seems
that DCE 8.1 (found in Kaveri chips) was forgotten.

This fix should be backported to all kernel versions that
have "Refactor fast update to use new HWSS build sequence",
but this patch won't apply cleanly to older kernels due to
another refactor in "Remove dc param from check_update".

Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260923122033.1046651-2-timur.kristof@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 57605379559e3b5044c8274a1010ec658e5e73af)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 26820d35478a..2f4de697ec4b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -1148,6 +1148,8 @@ static bool dce81_construct(
 	dc->caps.max_cursor_size = 128;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *

