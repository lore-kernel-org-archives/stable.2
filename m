Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0352ED29
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572557; cv=none; b=pyqlpwpWWxuejPRQEXGtYdO77LDAt5S4TUoB39iRDVsyfrqU6/Ayms0oCPKzeEF58oNlkNBSyLBlQF+NUsr2qRWvFF4pr/eYOHGjMzaH5TODoJS8ZirBkoEU6FjcEICbOWkEy9JZvPhDlLDvxr6nOcXr1QikEdRfhtfzvL2DZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572557; c=relaxed/simple;
	bh=NISXJfPQcnHkDBktLMLQM9mSJReGsI6imBIz1J/tWos=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rv4Nz/BZs5tg5CQGtWp/s9wH5l8+7Urfb8eo0752hkx22qePL2MTcf+cWOAZd4WPxPmIurFMga22JofZs7nbSCFNyvssnD7zLRymEpXuSnIwW1DjNOluWfXPCTAvGJSdx0P+JGpcx6ERV0Z3hR8+SN3VhEefdAxY/SwNhOQwdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLmmtRvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLmmtRvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FD31F00893;
	Wed, 16 Sep 2026 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572552;
	bh=0uuaoHKudf6Pw877972Vr3DgFHAmbbKt/C35B9Dssv4=;
	h=Subject:To:Cc:From:Date;
	b=iLmmtRvdCTM9img9p2AbvRWndEmYWGot7v5BO/MrR2W4PKXneDNEQKv3MAET70V7U
	 j+QV3JGoVGF9lHdZaIeARp6pAMALuAbeh6nfXRS4p3Z38HfoBDHghyVadsvuLz7hXQ
	 R3H8yfeko0dYQfqZBQWLTL2QEuJYJi54MjOTXcOE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Consult MCCS FreeSync cap only if requested" failed to apply to 7.2-stable tree
To: mdaenzer@redhat.com,alex.hung@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:19:25 +0100
Message-ID: <2026091625-unlisted-likely-9980@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x cfdcf5571c3107bf636002fc0c16ce93c19bd671
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091625-unlisted-likely-9980@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cfdcf5571c3107bf636002fc0c16ce93c19bd671 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>
Date: Mon, 18 May 2026 17:48:09 +0200
Subject: [PATCH] drm/amd/display: Consult MCCS FreeSync cap only if requested
 & supported
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the do_mccs parameter is false, we don't call
dm_helpers_read_mccs_caps, so sink->mccs_caps.freesync_supported is
unlikely to be true.

Fixes: 6f71d5dd3206 ("drm/amd/display: Read sink freesync support via mccs")
Bug: https://gitlab.freedesktop.org/drm/amd/-/work_items/5286
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ac3aea794fb4156467b4b3b92c3155d95bf435c9)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index c8a1ab8c3b16..d03773887214 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3937,17 +3937,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	}
 
 	/* Handle MCCS */
-	if (do_mccs)
+	if (do_mccs) {
 		dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
 
-	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-		as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
-		(!sink->edid_caps.freesync_vcp_code ||
-		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
-		freesync_capable = false;
+		if (sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)
+			freesync_capable = false;
 
-	if (do_mccs && sink->mccs_caps.freesync_supported && freesync_capable)
-		dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+		if (sink->mccs_caps.freesync_supported && freesync_capable)
+			dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+	}
 
 update:
 	if (dm_con_state)

