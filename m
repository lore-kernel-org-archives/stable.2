Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871349EC7A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819427; cv=none; b=hNWigYkj38wp5Pl4nykVlg9lRsudOYDiGAbjxQilsiwyKvMn1nkhfNBzZIu8kVNrREXO+wJLhz5PQz5KlfpTpKOvdKYDcxnJpRA5yOEAf13PLHYKdjwX7E8QbduY33czhDn9W34BepHR1lYdAeeGz+zBeeVBqnODkunogvOsGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819427; c=relaxed/simple;
	bh=XIiZiPXveMQw/f8nw7tt2fFKt/tifZazpmmzZ4KmXKo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IKkQK63BRHCSl3H5HcLSN6Co8C3UBkXckZGVtZaATdBJjiDqzKmRHoCQetXv2VLvAeswQYCsijdB9gMUmzfIhUYyvjdjhBwZFQn6sJ+NNMy+mEsXLQzFd6z4x1DoC68JWg5FY8DJloskeJDKL23CaEYJaOQt6qumhmf53ji8mIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=upQzkQ2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="upQzkQ2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FE11F0089B;
	Mon, 12 Oct 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819426;
	bh=EjZQByzS+O7q3c3xXsRwi6H/blSULYR5yuYViEGaDWI=;
	h=Subject:To:Cc:From:Date;
	b=upQzkQ2xAe9wxZJ2eliRLAO8gSDApC1ypZkdDBAMBqyCZN2lpL2odINBWOQ8XuHMX
	 4azcp6iv4HZcIODrQRZwnw1ix4EPNvIzBdyOhvVInuKMB7Sz8/FbH3CYC2iv6956pZ
	 cLwyhNH9a0q6dLRmtDm90Gtf1H0bZSQ3k8qNFF6U=
Subject: FAILED: patch "[PATCH] drm/amd/display: disable self-refresh on tearing flips" failed to apply to 6.12-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com,timur.kristof@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:37:03 +0200
Message-ID: <2026101203-cottage-snowstorm-def0@gregkh>
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
git cherry-pick -x 2e54a92e0136c3ff5c7b542b95bf0940ad6687bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101203-cottage-snowstorm-def0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

