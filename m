Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41C372056
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187554; cv=none; b=Av4X7t9XgkMuVqs0T+wDMtYTGhmIMohl2YuvZG01vZEjsiQtVAAIAXd2ZCqowR0GJCnneZatZmkGoPkQyrrMXZFx8aRhLnyrCw/CDNscgjL3/dSoxY/m568QYQW3pCCcjQZgipmB2kX5SO0QVevHhIElBeCVuClSs1nYB64amGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187554; c=relaxed/simple;
	bh=G7zFdB+2Y6fEYkP5Sr3pD2iES6lOXBvOLUjjMDAWZw8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CJZLxVc/mfrDlAKZ3tp8b3A60XSVWnILvl1DUM2yVkc15xAQWPodtfFmVZ6sjwLnrB6t/jP2gNAKOjlrLIHrP8LT4hZwh8yKw3UeQ69TOsG/CZMR8IxPYNW+qcbNIyXHyaA1OQcxPtEMYsnmprPpBXFuH/Llt+95Jege3hV3EGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xiBjIFap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xiBjIFap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE941F000FF;
	Mon,  5 Oct 2026 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187552;
	bh=k7aalcL/ahIlx7YLY6QrvX0+YB5F/RCfpJEEdIBfRnk=;
	h=Subject:To:Cc:From:Date;
	b=xiBjIFapXK6a/jg372TApf23RRsvyj9X6tXXTjXGOtXpfceu0JNzNfKMuC48dFIRS
	 rkhIV6LJ2lhZDaShyb7o94OBp0awcQFzzj4LqXDKxDdrGKAkB3JOHJK9YVkpaeLggd
	 QIIfcGRpAkHWGZ2yf0SJbLVHqesO276eCJIPTji4=
Subject: FAILED: patch "[PATCH] drm/amd/display: Preserve eDP mode on initial ASSR failure" failed to apply to 6.12-stable tree
To: arthur@aheymans.xyz,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:05:41 +0200
Message-ID: <2026100541-wages-celibate-8917@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5e08102d1d336593160d1434261d50b0c0f6cbe6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100541-wages-celibate-8917@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e08102d1d336593160d1434261d50b0c0f6cbe6 Mon Sep 17 00:00:00 2001
From: Arthur Heymans <arthur@aheymans.xyz>
Date: Sat, 12 Sep 2026 17:11:37 +0200
Subject: [PATCH] drm/amd/display: Preserve eDP mode on initial ASSR failure

Commit 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when
reinitializing hardware") made ASSR failure fall back to the default panel
mode unless eDP mode had previously been applied.

However, dc_link is zero-initialized and DP_PANEL_MODE_DEFAULT is zero.
Before the first call to dp_set_panel_mode(), panel_mode therefore looks
like a previously applied default mode. If ASSR setup fails during the
first link training attempt, the driver incorrectly trains the eDP link
using the default scrambling mode.

On a Google Vilboz Chromebook running self-built coreboot firmware and
PSP verstage, this leaves the panel mostly black with corrupted output
along the top edge.

Track whether panel_mode has actually been initialized, and only consult
the saved mode after it has been applied. This retains the recovery
behavior while preserving eDP mode during initial link training.

Fixes: 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when reinitializing hardware")
Assisted-by: Pi:gpt-5.6-sol
Reviewed-by: George Zhang <george.zhang@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ccb6c2702033f1002b45807fb3cc938760f26f78)
Cc: stable@vger.kernel.org # 6.4.x

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 705c500ad711..871063f809dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1905,6 +1905,7 @@ struct dc_scratch_space {
 	struct ddc_service *ddc;
 
 	enum dp_panel_mode panel_mode;
+	bool panel_mode_initialized;
 	bool aux_mode;
 
 	/* Private to DC core */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 16951a9550f2..21dd91fc8010 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -93,6 +93,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 	}
 
 	link->panel_mode = panel_mode;
+	link->panel_mode_initialized = true;
 	DC_LOG_DETECTION_DP_CAPS("%d eDP panel mode supported: %d, enabled: %d\n",
 				 link->link_index,
 				 link->dpcd_caps.panel_mode_edp,
@@ -1297,7 +1298,8 @@ void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 
 		result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
 
-		if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
+		if (!result && link->panel_mode_initialized &&
+		    link->panel_mode != DP_PANEL_MODE_EDP)
 			*panel_mode = DP_PANEL_MODE_DEFAULT;
 	}
 }

