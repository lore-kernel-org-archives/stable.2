Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8293FE35D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931860; cv=none; b=T7H4+ItV4VAm+yQUIb6O+dd7KARLzzbWOzEnNtkHyb/e68LkancNYcaMj6s8x20kDzWfuk0g8vUhSxjRtX0IVQ0epYolr9GUbfZaOQXg+Iu0VoHLa5V0g9lxNz4XuaXrkUHy7BI6IaedqTGEWFG4mp6CpRKfggLMJT+tQ+iAbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931860; c=relaxed/simple;
	bh=RAztDgXgXpRfr0poNKDxQvpp84XC7ph3cDIpvDmcn7M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dB9l88KAZ0u+sMG8E9unVP6uGthcITHXqZZywGH4ZiK6suyOBx1bDSpKaOJjp4KyEbgh4onYgCxxOhx/+5KHJcFv2xcWZi0MgrTYp7OY76VHVN5mfaIAbg/poD4R3kORVfrfGDmSt1R7zctGhWEojgnXpVpAEkOpHYj5tF/fZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d7I9MSfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d7I9MSfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E064A1F000E9;
	Wed,  5 Aug 2026 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931858;
	bh=jF4NU8nWW/3iswJMqH0rcgR2jIirnR8b5UBphQpxsis=;
	h=Subject:To:Cc:From:Date;
	b=d7I9MSfAJdZxAcSLVMNnuKSFXrTFVCrEarXds+3niLy4E/Ja0aLWoXkuFNvmPFBPj
	 y0y5JJzoWMY+WoFV7idaOfxZ48RqXxFuD5eP9ExH5ZMNa8O4bwRdaFZqhSBOOwkgA7
	 rSKIjq5IEqJu4pFlfsHFhTddQGtLhgDRn0cLgeOg=
Subject: FAILED: patch "[PATCH] drm/amd/display: check if dml21_add_phantom_plane() is" failed to apply to 6.18-stable tree
To: alexander.deucher@amd.com,daniel.wheeler@amd.com,dillon.varone@amd.com,jerry.zuo@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:10:41 +0200
Message-ID: <2026080541-agonizing-work-8714@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 000acb4ce7fb9feba3072ce468ad681f6585cd5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080541-agonizing-work-8714@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

