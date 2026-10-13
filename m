Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800904A8FEB
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917916; cv=none; b=J7Vfp8Zrb9fGg/fnTshP9t8nHP6BbYDtqGyDeBEemd8zePrrU0W/EqhdDQQ/AVCALfuPIBp+ISmY9x7g4Zml0qT1nWqNSI6BSujnSivmU/SFsFPvSOhekT9Y+iUlS0wExYBpVk/rBq7pCmSYHUA92JOHhGU+kwsYnyCwy80MvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917916; c=relaxed/simple;
	bh=9BffkYgZXwVi+jcOnbWlyI3TDHDGWmzV/LiL9DGYAio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4Vq89w+GKXF26lLMx3s6rLF1O4J6ha2w0asRD9N/HiyWkDZprMRlzJmkIz66ZGbIUmipZ/XPtbZ2QrGBRyF5KqIGGt0NPtGBGF52a9C6GWUJA7ZTiHHXZ5skdy486wCm1ZooAz3XvR5fXFGywvuh1kWaXHi6Ney0Ha+620IItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr1c6ozm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr1c6ozm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CBC1F000FF;
	Tue, 13 Oct 2026 18:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791917915;
	bh=cMy/yRN2x8M3LLU+ZNeBhku+AENKccXWqQTXj1pMVxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cr1c6ozm0XK19+9TnA0mfzuiA4TuSkHHrbfRLy2cl6t6wLg8UbfGfFngtNephd+jU
	 E7O9d2odTUCKAJ1SEKsUj0ndJt6Q5aGvS/QV8sABuM0arNqR0fkoHh9G0qycXEjPcG
	 LBbJ5zfw0WugC9Z+SgcbIwTJF3HHWA3RBQtz0JJly7Spemv5AeigcW9pq/CaZWFdQe
	 mY931gbADYulXo4NtqtjJvfkMgr8T0PNIcIQaR65jMPMvk+9AJ3E+JGQh/q281Mddt
	 JEKEaJ/WIj2sTjzxpwdf7HoTm5zdP50/1j+VLC869IoPuSArEYJCmAWc0ri70VapyP
	 ftoPcPrh6MpMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAGAIN
Date: Tue, 13 Oct 2026 14:58:33 -0400
Message-ID: <20261013185821.728855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101247-operative-paced-9456@gregkh>
References: <2026101247-operative-paced-9456@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

[ Upstream commit 755c94d178b7e972bb766199d34e4ba4f63a89eb ]

__drm_fb_helper_initial_config_and_unlock() calls
drm_client_modeset_probe() first, which already fills in each
mode_set->mode/num_connectors for every connected output, and only
afterwards calls drm_fb_helper_single_fb_probe() to create
fb_helper->fb and wire it into those mode_sets via
drm_setup_crtcs_fb().

If drm_fb_helper_single_fb_probe() fails with anything other than
-EAGAIN (e.g. dev->driver->fbdev_probe() itself fails), the function
bails out before drm_setup_crtcs_fb() runs and before setting
fb_helper->deferred_setup. The client is left with mode_sets that
have a mode and connectors but mode_set->fb == NULL, and nothing
marks this fb_helper as needing a retry.

__drm_fb_helper_restore_fbdev_mode_unlocked() only skips committing
when fb_helper->deferred_setup is set, so a later .restore() call
(drm_lastclose() on process exit, in this report) commits the stale
mode_set through drm_client_modeset_commit() ->
drm_client_modeset_commit_atomic() -> __drm_atomic_helper_set_config(),
which hits WARN_ON(!set->fb).

Mark fb_helper->deferred_setup on any drm_fb_helper_single_fb_probe()
failure, not just -EAGAIN, so restore keeps skipping the commit until
a later hotplug event successfully re-probes and re-populates
mode_set->fb. The real error code is still returned to the caller
unchanged.

Reported-by: syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca23c8570669ead78867
Fixes: ca91a2758fce ("drm/fb-helper: Support deferred setup")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/20260927075434.72658-1-ngocthang2710.1999@gmail.com
Link: https://patch.msgid.link/20260917154743.1621-1-shechenglong@xfusion.com
[ sashal: adapted the error path to preserve the existing preferred_bpp = bpp_sel assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 8446bd6239c97..9defd4aa213c7 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1802,11 +1802,11 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
 	drm_client_modeset_probe(&fb_helper->client, width, height);
 	ret = drm_fb_helper_single_fb_probe(fb_helper, bpp_sel);
 	if (ret < 0) {
-		if (ret == -EAGAIN) {
-			fb_helper->preferred_bpp = bpp_sel;
-			fb_helper->deferred_setup = true;
+		fb_helper->preferred_bpp = bpp_sel;
+		/* modesets are probed but fb_helper->fb isn't; defer restore too */
+		fb_helper->deferred_setup = true;
+		if (ret == -EAGAIN)
 			ret = 0;
-		}
 		mutex_unlock(&fb_helper->lock);
 
 		return ret;
-- 
2.53.0

