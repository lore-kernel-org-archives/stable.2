Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C547986A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329320; cv=none; b=UbRIYSCM966Pt5hPQ8JRlTRt2WuC0fhntv04jEoiQuAVSmEOaIxKBnxVMHHlcSaGiEP+q7eH1vKso/8NpHyhs+GXne/WP2Kg7UHbl0AumxxNWG6dgZflGA3kD1P1VA9h0t4nR32FtRVtDXV81lJqoz3pKAGtEwqT4i2cvB04eVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329320; c=relaxed/simple;
	bh=N68WtpdyyQ/5/m6r2BS5Bu6tBEvgLSguQzVKha+0SFg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r00IkmHSP2L21cfgwE7AyHw7J62unwY+eQc+Ao99RjnWpKrzjEvwPPVIRiHMkmsJh1bJDIMnWxPuA9+8+EDfXwRWc5elE8G/tntaSppP2YlNLz21VkwjUBEh/eEQMHG+7k6nDlMOCLPeDPGRGhkubwzeOAwaVP32M+eV1TGG+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtdvR4di; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtdvR4di"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C399A1F00A3A;
	Wed, 29 Jul 2026 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329319;
	bh=O3EOz0ALeXUIz8nO2WtjHWZI1FMfCCozzG579OEq0sc=;
	h=Subject:To:Cc:From:Date;
	b=JtdvR4dipDvWxd99c2i/+TVILPz8WAeGS22omGrQzW7xhehWERMOPtpTkQF3eyWKC
	 tMtn5khaYL2pYysyVkmzoCauOkfQ9M6Pv8oGeYGa03gpuamXtC7aehhdt0de8KR+TB
	 GjJ3/vtwPrwrcJgzkv+Sf9b9EpFKjBanfGg3+WH0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set native cursor mode for disabled CRTCs" failed to apply to 7.1-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,michel.daenzer@mailbox.org,sunpeng.li@amd.com,viktor_jaegerskuepper@freenet.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:48:17 +0200
Message-ID: <2026072917-requisite-outer-9b7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x cea54c52d82dd9948126b7518af51ca1de094933
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072917-requisite-outer-9b7b@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cea54c52d82dd9948126b7518af51ca1de094933 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Sat, 11 Jul 2026 13:34:35 +0200
Subject: [PATCH] drm/amd/display: Set native cursor mode for disabled CRTCs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Always set native cursor mode when the CRTC is disabled,
to make sure it doesn't cause atomic commits to fail when
they are trying to disable the CRTC.

Fixes: 41af6215cdbc ("drm/amd/display: Reject cursor plane on DCE when scaled differently than primary")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5432
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Michel Dänzer <michel.daenzer@mailbox.org>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2f79f0130f828cf26fe2dcf45291821616af7b47)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ff337de44f7a..fe6eea28d119 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12814,10 +12814,15 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	/* Overlay cursor not supported on HW before DCN
 	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
 	 * as previous DCN generations, so enable native mode on DCN401/420
+	 *
+	 * Always set native cursor mode when the CRTC is disabled,
+	 * to make sure it doesn't cause atomic commits to fail when
+	 * they are trying to disable the CRTC.
 	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1)) {
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
+	    !dm_crtc_state->base.enable) {
 		*cursor_mode = DM_CURSOR_NATIVE_MODE;
 		return 0;
 	}

