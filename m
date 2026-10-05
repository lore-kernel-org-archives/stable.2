Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57B25F7A9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187561; cv=none; b=El7TeEi7r66oAHbZ2zC0tn7QW6Wa7RuT93uo3YpwIa3rkWRz/sSHnyeMMq5fNX7nBbdl7FTpMD3COStKIhoDWe10yr38PkNIbPFBzdoMjN9N7JiOVKlTL4Y6qQrSGr1FiInuOq8YGDVUtBjPB6o1E72Ml1/xew9I8uqN6sQNAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187561; c=relaxed/simple;
	bh=gJpyUTF4/aq+96Q7fZBoWt7/TRoKMZQeOxs1Cw7GSfw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=itwu0kJ2COPb+AWmN057AxWBfVuAxNc7klOREvG/234yXTjoO3QpoJ7MyR3HGv8g995wm7SY9nzttkX2uAwtENeQsbk/X5waU8cFBXiF95Nf9IdkpSvnBj6IycJMnMhJzK++87lByL8Qo19O4Ub8STEE6uX8oRpZf+7cB60lWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OfWJDFWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OfWJDFWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9662A1F000FF;
	Mon,  5 Oct 2026 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187560;
	bh=5u4UVjf9PBqkIIDoLV3mTWPFEfIj2vOU4NPc1EpRvsE=;
	h=Subject:To:Cc:From:Date;
	b=OfWJDFWhKnqlWYctGa34ANE9TgubXan9ITD4KJVqR5cBdr+WI2xJzELOuvT7sXNYh
	 DgQaf+IUfKYRENpfbAe3REnZ3jjKSH4lylpYqUCUJAUkHVfqhjBFTkRjqrBASlzjxN
	 sJeYs+Yw24erPxUSzALaz5mwcRImFqk0Jy8/vMiI=
Subject: FAILED: patch "[PATCH] drm/amd/display: check dc_state_create_copy() for NULL in" failed to apply to 6.6-stable tree
To: yijiangshan@kylinos.cn,alexander.deucher@amd.com,daniel.wheeler@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:05:57 +0200
Message-ID: <2026100557-busily-flail-a0c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 015e72cde567d2450e282c2790773463156b2d0a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100557-busily-flail-a0c0@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 015e72cde567d2450e282c2790773463156b2d0a Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Fri, 4 Sep 2026 17:18:17 +0800
Subject: [PATCH] drm/amd/display: check dc_state_create_copy() for NULL in
 dm_suspend

dc_state_create_copy() can return NULL on allocation failure.
dm_suspend() only conditionally skips dm_gpureset_toggle_interrupts()
and continues execution, returning success.  dm_resume() then
dereferences the NULL cached_dc_state in link_enc_cfg_copy() and the
following dc_state->stream_count loop, crashing during GPU reset
recovery.

Return -ENOMEM immediately if the copy fails, so the caller aborts
suspend instead of leaving a NULL cached state for resume.

Fixes: 8092aa3ab8f7 ("drm/amd/display: Add null checker before passing variables")
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 84b6d7932fdd2857795a257f9f258562a3cddcab)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 91fdf3de7202..e0485d76dc59 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1582,9 +1582,14 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		dc_allow_idle_optimizations(adev->dm.dc, false);
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
+		if (!dm->cached_dc_state) {
+			drm_err(adev_to_drm(adev),
+				"Failed to allocate cached DC state during suspend\n");
+			mutex_unlock(&dm->dc_lock);
+			return -ENOMEM;
+		}
 
-		if (dm->cached_dc_state)
-			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		res = amdgpu_dm_commit_zero_streams(dm->dc);
 		if (res != DC_OK) {

