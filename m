Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B39466AE2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931868; cv=none; b=IHPMz3+06uep2fqu7+F3RHAK0jNpQJd63cijB7Su8+Qre8HJJBuHeTTNOkdvMt1cU8ulR/uWPEsQhqRMCnQzvp1aMhjRFsSSIAgqt7aQejISlaTHpWMYaNwRDsE48UuKPaptVA7Vy6wNVjZOufItPSd+P53dRzO1G9XV2foWM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931868; c=relaxed/simple;
	bh=MholY85TXeWgb+AXKzSgBAAPPG+BNAMRLYciq8n+cVE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZVzkmUFb0qTvpr6wivQpS+MJraE3Bov3LgEhwy/2sU0Iow+2NYadBrUrdblukjoJwKAapD4CU6d0Emb+8WfANmTiDuJPMmpshoqJQEGzoZAGlQE/c+1I4PX5qjZhYasOUXdSNzMs8LjC1tGkEaJ+uzBlaEpPJ38L692mMOKml2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dOCGk0pr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dOCGk0pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DBC1F00A3A;
	Wed,  5 Aug 2026 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931866;
	bh=2pPk3K+hut1srvakzqJ1jiwI02bw1xcu8TsK9hnJtV4=;
	h=Subject:To:Cc:From:Date;
	b=dOCGk0prNDm4AbvuiYO9PypaUDXSQlAXY9eUrOIewyG6J2oPCNfXg74xrukzKNj2O
	 NDaK95R4cDz3OMmjD5XTFR3Um09ovjBNgWjxJM3RHkepDj1Xpa4d8Lhv2X6fi/Kw1W
	 RuNdsNzTRygAImgK13LnwoWuWUAKlI91oRntn1WU=
Subject: FAILED: patch "[PATCH] drm/amd/display: check if dml21_add_phantom_plane() is" failed to apply to 6.12-stable tree
To: alexander.deucher@amd.com,daniel.wheeler@amd.com,dillon.varone@amd.com,jerry.zuo@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:10:41 +0200
Message-ID: <2026080541-difficult-synthetic-599f@gregkh>
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
git cherry-pick -x 000acb4ce7fb9feba3072ce468ad681f6585cd5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080541-difficult-synthetic-599f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 000acb4ce7fb9feba3072ce468ad681f6585cd5d Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Mon, 16 Feb 2026 09:32:53 -0500
Subject: [PATCH] drm/amd/display: check if dml21_add_phantom_plane() is
 successful

Verify that the phantom plane was allocated to avoid a later
segfault.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4970
Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5adb54abe5a8e82cbff7f8806db30a5f4924329f)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 835fece1d46a..50e445275b14 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -359,14 +359,13 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 					main_plane = main_stream_status->plane_states[dc_plane_index];
 
 					/* create phantom planes for subvp enabled plane */
-					dml21_add_phantom_plane(dml_ctx,
-							dc,
-							context,
-							phantom_stream,
-							main_plane,
-							&dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]);
-
-					phantoms_added = true;
+					if (dml21_add_phantom_plane(dml_ctx,
+								    dc,
+								    context,
+								    phantom_stream,
+								    main_plane,
+								    &dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]))
+						phantoms_added = true;
 				}
 			}
 		}

