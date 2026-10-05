Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558183A1A5D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188972; cv=none; b=jf0NACY9/oO3xJZ1r0J0ytDd0sOhxhCiP5TyXeiu5QuI6M1Xh9Hs6nGLJ6ZlgF+zpVGs9H9XSTw+N+awFc3m01gOKVk65xOiy2/+47Y2UfHTyjcF8kKM40R0eVHAn3S1lf2qPVq47GngqOGs/z5sF0i8eglX0gAVidprO48iQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188972; c=relaxed/simple;
	bh=6kspJLA8awciulT1Vo7Lcs1JM5E6hI2k92HDbaoTbtk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WiJ+mIbhCIU5DCkdDB/YveR8TzKbJwxthj4K+WW23fsePBS2iL/+febdlR0PUs1pX934usIeEFP9lu2fWHHQbxYEeHvGYx6wS2D2cnpP2Vvx5637fKRxzBLwrJKWmU52peZLJjUCeET2Y2BhH9qjFtlNFHLOSbNz4gjXOLdU9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sVn4Fr6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sVn4Fr6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8CD1F000FF;
	Mon,  5 Oct 2026 08:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791188970;
	bh=Az+RJu1aYfIwyNpKk/FyymBchHvtTaRpgc2JzENk/p4=;
	h=Subject:To:Cc:From:Date;
	b=sVn4Fr6eThEe04BoKzPId78aEnMIwGypSZ1AEm0dds6J+b0Vx9ipTz89vaBJxa6LZ
	 SQ7d01J6MAewBaVYtamN+XZVfeXEx8njMViwwO5xYIPVmOPDaMcJ8rkuIiN1+4G5Eu
	 0vdOtamHQ+/jqNYiWsDTU1fIx5bkzi+k4OTnl9J0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix fast updates on DCE 6.x" failed to apply to 6.18-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:29:27 +0200
Message-ID: <2026100527-bondless-probe-a271@gregkh>
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
git cherry-pick -x 88427119e1f039c8cdffd63726c136a986ef519f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100527-bondless-probe-a271@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88427119e1f039c8cdffd63726c136a986ef519f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Wed, 23 Sep 2026 14:20:31 +0200
Subject: [PATCH] drm/amd/display: Fix fast updates on DCE 6.x
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DCE6 should use legacy fast updates, just like all DCE8 - DCN2.
Set that flag for DCE 6.0, 6.1 and 6.4 (all DCE6 versions).

Technically DCE6 should have been included when the fast update
code was refactored, but it just happened to work until now.

A recent commit "Attach only plane updates that actually changed"
has exposed this issue because with that commit, DC accidentally
took the new fast update code path for DCE6 as well, which caused
it to boot into a black screen with a flip done timeout.

This fix should be backported to all kernel versions that
have "Refactor fast update to use new HWSS build sequence",
but this patch won't apply cleanly to older kernels due to
another refactor in "Remove dc param from check_update".

Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260923122033.1046651-1-timur.kristof@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 698fda6e360625850413a2d1a90b72ae5f03073d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index d2d56a1c4b8b..8612cc66a6ba 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -448,6 +448,12 @@ static const struct dce_abm_mask abm_mask = {
 		ABM_MASK_SH_LIST_DCE110(_MASK)
 };
 
+static const struct dc_debug_options debug_defaults = { 0 };
+
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 #define CTX  ctx
 #define REG(reg) mm ## reg
 
@@ -937,6 +943,8 @@ static bool dce60_construct(
 	dc->caps.max_cursor_size = 64;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
@@ -1134,6 +1142,8 @@ static bool dce61_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
@@ -1332,6 +1342,8 @@ static bool dce64_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *

