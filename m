Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E03AFCE1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669710; cv=none; b=Qm+Z1+xPvicfYx726SGZkjLTsvqXOcKB1FZLEp8IT5hGqOQzEl3dEXq+md4u7DD8MJGY0UMI2bIaZinrzD+WNzg8rP5rFrWJgSHCOaQ1T7JwyaWvjQn1GlPAa18Kg5Le/IY7r9tblSCt3TWI0KIJn9MzMvEUYMhvnvS3GIFHHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669710; c=relaxed/simple;
	bh=aUiC6PE+4D6dtI8Hixj1SBXZ8lB1RMWTS8YGjHtTBpM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hB0G2wBPv6JQrF6/Z4ljXSnLP+cJU2Uw/rBPIWR5qPBVlh8H83OGzWA5F9zEz0ObjwQ7PRpFqTiQZ7kR63vMB2Xsbo4e8ja1yIIBANYICUDvr8c7OZsRukcD9Sg9ZsUgENHgIS7lpOeOQtLmOp1Y/gP+EEpSCh/vCr/E1VyV8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O34btJnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O34btJnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D961F000FF;
	Tue, 29 Sep 2026 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790669708;
	bh=DSaVu7lc71o/XQeiaLsvH0s9yoXO69gF/VLsVpY89I8=;
	h=Subject:To:Cc:From:Date;
	b=O34btJnLnoMjvFgOsUUa9zr3UoaJdrDaq0Vd7JpV72QxtPPA1kD7FrK0zg9FY/iHD
	 5bS6/0fHJesWH2MXFsRdC9j6Ro1G3QY3cWsHfn81mx7C9Uto68f5ZaUcvLkZlLOpnc
	 cLmRt3gfr8lCii+09mPdioKVQ6/MCGfh8f73V2Og=
Subject: FAILED: patch "[PATCH] drm/client: fix restore of partially initialized client" failed to apply to 6.18-stable tree
To: shechenglong@xfusion.com,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:15:02 +0200
Message-ID: <2026092902-autistic-bonnet-dcb5@gregkh>
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
git cherry-pick -x 1fca688e9443003e33cf30453e7a7560367656c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092902-autistic-bonnet-dcb5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1fca688e9443003e33cf30453e7a7560367656c9 Mon Sep 17 00:00:00 2001
From: shechenglong <shechenglong@xfusion.com>
Date: Mon, 7 Sep 2026 11:51:47 +0800
Subject: [PATCH] drm/client: fix restore of partially initialized client

I got a null-ptr-deref report when closing a DRM file descriptor:

WARNING: drivers/gpu/drm/drm_atomic.c:2031 at
__drm_atomic_helper_set_config+0x18e/0x1b0 [drm]

Call Trace:
drm_client_modeset_commit_atomic+0x16b/0x220 [drm]
drm_client_modeset_commit_locked+0x56/0x160 [drm]
drm_client_modeset_commit+0x21/0x40 [drm]
__drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x7b/0x80
drm_fbdev_client_restore+0xe/0x20 [drm_client_lib]
drm_client_dev_restore+0x9f/0xc0 [drm]
drm_release+0xc5/0xe0 [drm]

The warning is followed by a NULL pointer dereference:

BUG: kernel NULL pointer dereference, address: 0000000000000008

RIP:
__drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x41/0x80
[drm_kms_helper]

Call Trace:
drm_fbdev_client_restore+0xe/0x20 [drm_client_lib]
drm_client_dev_restore+0x9f/0xc0 [drm]
drm_release+0xc5/0xe0 [drm]
__fput+0xdc/0x2b0
__x64_sys_close+0x39/0x80
do_syscall_64+0x8d/0x460
entry_SYSCALL_64_after_hwframe+0x76/0x7e

drm_client_register() adds the DRM client to the device client list
before invoking the initial hotplug callback. If the hotplug callback
fails, the client remains registered.

For the fbdev client, a failure during drm_fb_helper_initial_config()
causes the partially initialized fbdev helper to be cleaned up.
drm_fb_helper_fini() releases fb_helper->info and leaves it NULL.

The fbdev client therefore remains registered even though there is no
fully initialized framebuffer device.

Later, when userspace closes the DRM file descriptor, drm_release()
can invoke the restore callbacks of registered DRM clients:

drm_release()
drm_client_dev_restore()
drm_fbdev_client_restore()
drm_fb_helper_restore_fbdev_mode_unlocked()

drm_fbdev_client_restore() currently restores the fbdev state
unconditionally. For a partially initialized fbdev client this can
submit an incomplete modeset state and subsequently access fbdev
state which has not been initialized, resulting in the warning and
NULL pointer dereference above.

drm_fbdev_client_unregister() already uses fb_helper->info to
distinguish a fully probed framebuffer device from a partially
initialized client.

Use the same condition in drm_fbdev_client_restore() and skip restore
if no framebuffer device has been successfully initialized.

Signed-off-by: shechenglong <shechenglong@xfusion.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 5d08c44e47b9 ("drm/fbdev: Add memory-agnostic fbdev client")
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.13+
Link: https://patch.msgid.link/20260907035147.1339-1-shechenglong@xfusion.com

diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
index 91d196a397cf..1c16bc1084c4 100644
--- a/drivers/gpu/drm/clients/drm_fbdev_client.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
@@ -42,6 +42,14 @@ static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
 {
 	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
 
+	/*
+	 * The client is registered before the initial fbdev probe.
+	 * If probing failed, the client remains registered but there
+	 * is no valid fbdev framebuffer to restore.
+	 */
+	if (!fb_helper->info || !fb_helper->fb)
+		return 0;
+
 	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
 
 	return 0;

