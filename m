Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DC377A9E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187570; cv=none; b=dmkIlFq6guau8d+Z0cfn3rnvsWpH87YKFAtYNEgXB7XsBLr84Byxj61wAvnz4abnftOhnM2M8sgPZZl7gLCFkWeR4fT8xvpR+Fpj7q3JkdNinIBkQEOTl7shWGb8z7Tlf0MqGM/Xs0OzjUlu4dD4HvGz9A3g1Gy9T6toHN4mvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187570; c=relaxed/simple;
	bh=xTKo/nSpKmYQosF7qt95d32ptuWzimQ4SLZNxI8mohE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kI+2JWEjgN/zkm7W4+qkuBqHpV9LwuRUUoGAK+w5BQMD77eBDO8LTTdpZzlfRXrEhq85vVBuzJ2Aw24N3XW0B4mLUkQRRsKXDknqYUKfjbRvRBGBHL4auUHkr6dJhSqKjh/Xabo2bq6VI42a0Tk6WD0R5jhY6gpAAbBhFR50ddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=opr5N/0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="opr5N/0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3479B1F000FF;
	Mon,  5 Oct 2026 08:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187568;
	bh=LvXbBd8E9ukeiIFYmUUJIb3DzCCq36n2vdxwRuSzJ/I=;
	h=Subject:To:Cc:From:Date;
	b=opr5N/0GU5aJYPAu56H3DX7xO30P1BOHfW3uKLxl+nNWT3G9pg++CWQYHMiNwVdLC
	 vEt0SX1bfK0KAXs93QXs1j9v7UL9lqlSsGY0SRHa8EqYJ8Jo+HY9OcmH95Xx4mcjR6
	 cvic1BfAV4RfF2zkL9sF61F36A7RAk5zwn4kYgJE=
Subject: FAILED: patch "[PATCH] drm/amd/display: check dc_state_create_copy() for NULL in" failed to apply to 6.1-stable tree
To: yijiangshan@kylinos.cn,alexander.deucher@amd.com,daniel.wheeler@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:05:57 +0200
Message-ID: <2026100557-droplet-spousal-f396@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 015e72cde567d2450e282c2790773463156b2d0a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100557-droplet-spousal-f396@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

