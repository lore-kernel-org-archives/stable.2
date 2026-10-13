Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976143B42FC
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911003; cv=none; b=lgT6bHgKqOielHDa3jmL3b6dgXW0pSAm+aQgIip7AGTfWOZzQukdLk+Cfs0lYSnaOv/OKnkPZdnQ/ITJhaVJv+RYq8cF4JuX0BQLSHt1SiSyaFrxRfe3pT/ATXw4Z/hQ2DqqXrotPlaI3tPUBDAcrUcvn5jQUbflXuH4I2y6K7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911003; c=relaxed/simple;
	bh=nGtEsFPmo1lMbRzF0qFl6lf7ZGOj0bXizioQ3LbuTz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS+XLILk2gXfai3iHR0/iDDJOcDKtdgWb5SiEgp2A8RnSv6JkuqHNPSmmEswucIHSV+LpiYir0LhLTOetvvWoYXTf8rU0CGj3ucOK5v+Ih2l2i1lrcjGGS1omCaeaFo2AfMPUA1ptTiRs8yPlKrGruqaDiwCXOn9pAymAGCdkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA7C6vYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA7C6vYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9717B1F000FF;
	Tue, 13 Oct 2026 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911002;
	bh=yioia+bVMC9IwzRhQiPymg/dvZ51Ssg67WVfi8HZhPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hA7C6vYdkc0azvepJhI4QXJ/4FAHeDd6v2aFxgNZsmYnMQGoPPtaIHftecco/h1vs
	 XPr2ugGiYSvOCPuIWVXaAKXsDR/xcYb96Fp+4JtObcDakakh5AVhnVdwB5WOcOPQ8d
	 P4ZmBITmedYBuKa1S+bpDvqhWlt/rkumrOPv13YxzB4qaQcG4qUBbaF2loQ29W/jve
	 3owNlrmtdbImedFYXgmE528SvH8aOHUoECk4R03raTsOtEOX9uqPVK8tZDSKzD9Ia1
	 K4fvqGUU1SGnzi29cT5X6OBHTja9/cXevI80IqU4Ck6R4U+CEnvFqx/i0koTwO8/c3
	 lbnoNRIWTma5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAGAIN
Date: Tue, 13 Oct 2026 13:03:20 -0400
Message-ID: <20261013170308.397883-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101246-encourage-caboose-cffc@gregkh>
References: <2026101246-encourage-caboose-cffc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ sashal: Moved the existing preferred_bpp assignment alongside deferred_setup because upstream’s earlier initialization is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index a0abfb3f05f04..954ca9215fb88 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1942,11 +1942,11 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
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

