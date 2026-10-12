Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEA492512
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816871; cv=none; b=I3hn3zC4glcslsMlfHArPdh2I3/5Lw7uukyT6XcWd1oqNQmcC273ilUEOv+CCHzj0QJgsDSffPnTSAUmhjVOY4KSecbf4praZPuf3aYlchhU66e4hZK46viPXpad9I8jSvpk6mqg7Gi4XtV2GutaD/h7NcSEEFsqQyzFQqUnOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816871; c=relaxed/simple;
	bh=ALkNEJoS/YiROdPWEySyeuKia2WTHUW7RjWGnjGZsto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ksZHaysqoP8Xa+dK6iCwtHVcF6F3AbINDkme/1trTYhFN/pevGmyfCzE1UD7kvo9yUV7BDMrKwt2CyYfrsl0RSGWU2BwcKy/ntQCOiMMw/LmrbUjb2hS/j8vzJJ87fzLG7AxUbr+VcMBw3LBBZbQgBaxKI2xSGSJ2xAvgk6VtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CjkDikzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CjkDikzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5001F0089B;
	Mon, 12 Oct 2026 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791816869;
	bh=7rhH+1Tw43rikr5sI8Qa7d8g9DSAdPK/DYZb0lGFcME=;
	h=Subject:To:Cc:From:Date;
	b=CjkDikzwQYDB3nzFys8L89STff609IKaFpdTur7WIcpfGuV0cG4K8BA/KhSiKnKeC
	 XN67l/1lWLANL6c+MFRb86pQWaFMUHxaADlePKUNl7e+qB4IG/jfLclcm09ZCvya1S
	 YjThm5GjCW7hvpoNcexaw+x8JxIMxtlzVDC9ZVuo=
Subject: FAILED: patch "[PATCH] dm: fix reading free memory in do_resume" failed to apply to 5.10-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:54:24 +0200
Message-ID: <2026101224-cough-approval-fc0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c9417c1c5269e2bd0570fbe53e4ec03a8d31f008
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101224-cough-approval-fc0f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9417c1c5269e2bd0570fbe53e4ec03a8d31f008 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 23 Sep 2026 12:40:16 +0200
Subject: [PATCH] dm: fix reading free memory in do_resume

When do_resume calls dm_table_get_mode(new_map), the call is done without
holding any locks (it only holds a reference to the md). It may be
possible that another concurrent ioctl on the same device will swap table
after dm_swap_table and before dm_table_get_mode. In this case,
dm_table_get_mode(new_map) reads freed memory.

This race condition was triggered by syzbot.

This commit fixes the race by reading mode of the new table before
dm_swap_table. Note that new_map is also passed to dm_ima_need_measure,
but this function doesn't attempt to dereference it, so this call should
be safe.

Note that this is not a security bug because only root can trigger it and
the commonly used tools such as lvm or cryptsetup do not call the ioctls
concurrently, so that they can't trigger it acceidentally.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: syzbot+bdff1ecf726d2af66afd@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index a005f124d706..8f945f0aeda5 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1273,6 +1273,7 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
+		blk_mode_t new_map_mode;
 
 		dm_ima_context_table_op(md, ima_context, DM_IMA_TABLE_SAVE);
 		/* Suspend if it isn't already suspended */
@@ -1305,6 +1306,7 @@ static int do_resume(struct dm_ioctl *param)
 			}
 		}
 
+		new_map_mode = dm_table_get_mode(new_map);
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);
 		if (IS_ERR(old_map)) {
@@ -1320,7 +1322,7 @@ static int do_resume(struct dm_ioctl *param)
 		if (old_size && new_size && old_size != new_size)
 			need_resize_uevent = true;
 
-		if (dm_table_get_mode(new_map) & BLK_OPEN_WRITE)
+		if (new_map_mode & BLK_OPEN_WRITE)
 			set_disk_ro(dm_disk(md), 0);
 		else
 			set_disk_ro(dm_disk(md), 1);

