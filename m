Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2548F835
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819419; cv=none; b=Y/R+MOKEfJUU1HMfdwP9Od0P+RsPh7QQ5YZ3EIaJAlfHazfZOJoa9I+5hIYqC+XOmUrmMVxidWMfzxtQKi6xmWcXynrGpgQgE1akUJLTeSY0/IR2w7tmd+XJeSOEuuzDtviqiiCio07xOEjBcXmjeX2cQ5dTM65KC8P4tSUEJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819419; c=relaxed/simple;
	bh=PsZs6uSEv6ovg5gyJHRBKi9v5OOsk/8PcwNcxleadMI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ixdNvfb1Rh/QBEdYGEUAg/WX5bB3n6FoxGJvbNNImK9Jpb9ZOL051u+UHpi3Gg+XP2XWnJQrE3v5bUeNab2Eg2GM/SMGDebONnCsmZ5lSvbUj75SHtioW4qWWWDJuu9dKQU6qbuJ0fbkAHzzgseVt0eW64FHSuxRVWa8/7pxsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWbxCwRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWbxCwRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BF91F0089B;
	Mon, 12 Oct 2026 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819417;
	bh=WVylQfd6FymZIKBQzxZEnoOMwXkXLqM4y4riAUWS4a8=;
	h=Subject:To:Cc:From:Date;
	b=vWbxCwRG6e08K4p0U96DWQMrXGyV+dYCvdxzWekbCpjBnPCphOYPhBcmw8nHZx8+f
	 OvwditXonssuQ0mGR6X4P0Np2/zRZ+QnZnVRzn6qHfTHxWCASYSVHiMAqVS6bnrr7H
	 x3lA0ivyD35x0c9/UbRBqAZhHTcMOhJqJ+mcDC64=
Subject: FAILED: patch "[PATCH] drm/amd/display: disable self-refresh on tearing flips" failed to apply to 6.18-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com,timur.kristof@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:37:03 +0200
Message-ID: <2026101203-unfrozen-cannon-c4df@gregkh>
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
git cherry-pick -x 2e54a92e0136c3ff5c7b542b95bf0940ad6687bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101203-unfrozen-cannon-c4df@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e54a92e0136c3ff5c7b542b95bf0940ad6687bf Mon Sep 17 00:00:00 2001
From: Leo Li <sunpeng.li@amd.com>
Date: Wed, 30 Sep 2026 12:30:52 -0400
Subject: [PATCH] drm/amd/display: disable self-refresh on tearing flips
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Why & How]

Immediate (tearing) flips breaks self refresh state machine assumptions,
so disable PSR/Replay for them.

Tested-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit acbdd213b37e095f15685f3e3ee6d35defa05616)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1b42c4606002..47a0ff2ed035 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3708,6 +3708,13 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 	struct amdgpu_dm_connector *aconn =
 		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
 
+	if (!acrtc_state->base.async_flip) {
+		amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
+			psr_event_immediate_flip, false);
+		amdgpu_dm_replay_set_event(dm, acrtc_state->stream, false,
+			replay_event_immediate_flip, false);
+	}
+
 	/* Decrement skip count when SR is enabled and we're doing fast updates. */
 	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
 	    (psr->psr_feature_enabled || pr->replay_feature_enabled)) {
@@ -4118,6 +4125,18 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 		mutex_lock(&dm->dc_lock);
+		/*
+		 * Tearing (immediate) flips cannot work with panel self-refresh
+		 * features. The event is cleared by
+		 * amdgpu_dm_enable_self_refresh() once async flips stop.
+		 */
+		if (immediate_flip) {
+			dc_exit_ips_for_hw_access(dm->dc);
+			amdgpu_dm_psr_set_event(dm, acrtc_state->stream, true,
+				psr_event_immediate_flip, true);
+			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
+				replay_event_immediate_flip, true);
+		}
 		update_planes_and_stream_adapter(dm->dc,
 					 acrtc_state->update_type,
 					 planes_count,

