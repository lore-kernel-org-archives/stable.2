Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58384A4403
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819091; cv=none; b=uE/xqZwyVUaAC2i7tgxtrms1tYnmNWZf/eRJiWLo1vlNGTXUKNIs5EkMZU+6bOCyb31TAZ940TjdI1242ioRJz2OOVGcj07MW8Q/vI2nV7yieLk22DzbaF3iGXafCWUbbv/gP05phdyHoltjJ8DobE6TsQGv5Qc0ywcrugzKY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819091; c=relaxed/simple;
	bh=p8RGc8nZEBfsHnXUYFqxwzxjn02qqHlV+T1VVSFrHaw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F7wh6/tvGGoke4kq5o3hvMZhl6k1MoIsV8cr2Zep5/qI6GJUdUWZrtlFJgqat6hVpQdk4W9v09I+zMdR/XVa1unHDeikjhxMrIh8Rv3QItNCOvN7aaKCwAGi99cztapOsPOeGSRNQtlk4Ltcu/d6kErykPVOcZK5YW76W2ZMuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o0yE4W9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o0yE4W9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63511F0089B;
	Mon, 12 Oct 2026 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819090;
	bh=qfvoKGTs/nY/O2zevP/IK3KLELgOiLnEwInSzeHCuio=;
	h=Subject:To:Cc:From:Date;
	b=o0yE4W9MDOH2rkn965FWHpIryT8zFjegtYVPN8/PU5H8kdnJ7fst9Xd4AZEqc5fzn
	 5aj1w11cIwGGPqIEfx4jokaL3lJ9ELyqFcyi70l9miarO+OzSc8AIXyxo+k0EOjPs9
	 DssAESHTuqZhRIn19xNIvnvgP8OjZVeFfar7eF9s=
Subject: FAILED: patch "[PATCH] drm/fb-helper: defer setup when fbdev_probe() fails, not just" failed to apply to 5.15-stable tree
To: ngocthang2710.1999@gmail.com,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:29:46 +0200
Message-ID: <2026101246-reason-finished-ac79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 755c94d178b7e972bb766199d34e4ba4f63a89eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101246-reason-finished-ac79@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 755c94d178b7e972bb766199d34e4ba4f63a89eb Mon Sep 17 00:00:00 2001
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Date: Sun, 27 Sep 2026 14:54:34 +0700
Subject: [PATCH] drm/fb-helper: defer setup when fbdev_probe() fails, not just
 on -EAGAIN

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

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d4664ed468b2..0817b639b3fa 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1724,10 +1724,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper)
 
 	ret = drm_fb_helper_single_fb_probe(fb_helper);
 	if (ret < 0) {
-		if (ret == -EAGAIN) {
-			fb_helper->deferred_setup = true;
+		/* modesets are probed but fb_helper->fb isn't; defer restore too */
+		fb_helper->deferred_setup = true;
+		if (ret == -EAGAIN)
 			ret = 0;
-		}
 		mutex_unlock(&fb_helper->lock);
 
 		goto err_drm_fb_helper_release_info;

