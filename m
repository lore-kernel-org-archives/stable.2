Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0F47F2CD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329326; cv=none; b=gDqCw4oXy/ewRqBpbzvkNxEn+BALUZ+nX5K46FMrYSPY+1VZv4cqS1NGDgQwNQ9NO5fJfVHZK2UlsI/29YmRHOLz7r1y0KJJHcVsn5ZmtJUR0cmHIckYrxaXzQHOXXrbUl6kBeH2gcRF3KaK2BFSV2ODjqBPWPbBZpdCwI6/20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329326; c=relaxed/simple;
	bh=C+4VO/11X+Kr0oDJtobrwI4nDQO6+A889ZDOWAGvIEE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YuIWs1bfyhndPbdWCLZYtiiKcpi4ALrGX/hZRwE+KG+tHEs98wpX28zcWv95P+hMZV5xBwZxU+mm1juRrGOEWWrTdLMWMaoXJPDZEvS0BH7LPxuINji38v9BQQ2qDI2ZW+lzuuIkC/QeSYljUeWg8r6LU2Ws+zArSwPZqExE0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Saz/aatk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Saz/aatk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922091F000E9;
	Wed, 29 Jul 2026 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329325;
	bh=NgPQaxAoKMZaOWK2oV3L25elItiJqK6urKiGv8N8s+U=;
	h=Subject:To:Cc:From:Date;
	b=Saz/aatkrmAzEZwOoAZEzoSKBOWo+92988GZjdM69z7tLxYpk/EtdyU3AMnsmNokq
	 tEaUsDygSD8PSC6QjU2XeLYqve9T06GIOL265IoPtMo1OmjnuJGVy3QYaCGnVmD4pu
	 bAVrHPmyRJUvjGy1y2SPWTCUXNL2lrrptm6Gw9oA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set native cursor mode for disabled CRTCs" failed to apply to 6.12-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,michel.daenzer@mailbox.org,sunpeng.li@amd.com,viktor_jaegerskuepper@freenet.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:48:18 +0200
Message-ID: <2026072918-yogurt-moistness-2928@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cea54c52d82dd9948126b7518af51ca1de094933
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072918-yogurt-moistness-2928@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

