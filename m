Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE73B47F1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696562; cv=none; b=u67dcK+F+uiR94oT/C0l62hUZKBLzCizl9Nix/YjcossT8C6KHwjDNo93V5CwHfGG6gzM4iUXIrmkIccr0JLsFC4yFWZsoBt0Z54K81r5tonRBUBE/BIF1T462TR4vmGk7Se2hAdlWbNX2EiY+62RfRaD7AJy05h3UP4Gnz0uX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696562; c=relaxed/simple;
	bh=uGeossOX1aGKK7thuud9mTVGEMLVtdKzFI/wYtSeWNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSYAtljwBRTpMVJ2J3mcUQBWrGaKHps+mKutlAl/Re4MjqgQMh3J+Qa+POxsA75bliDz+8dL6Vz3UcO53sgtGCrxb6pqvd/D+qP22vSEym9MbORl13ef4eORfDHQhCXKzz/iuiEk51C2imELEa5DV+hu+Dd6dTezRq3e3tQZlv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4QHmuAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4QHmuAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E545C1F00899;
	Tue, 29 Sep 2026 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696560;
	bh=hQlnbSnLaVXXEN6yTtVVEJm4Csf8AKlf7RIYXRl3Y9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4QHmuAL2TXdb/IeXf2wX9EPNIEN/dgZjCjZ+XZLtsWrkCXJjBcXFwp1jOirGTaLT
	 hjszYF4/eq6zVgG4xf+cDaO4bz1IEKX3luqu4xBaTkfv3U15qCEzMPJxBs57QsQpaL
	 r4nD1dFvgCHLnKY3AWknH45cgYYWwUHUNAk4kC0W7D+58Dpfxqvpw1lbFwmYnxAJ+5
	 XYBPTbgycQ0Diav3Ad5anL920MkDyHApOttMtGydOvCI0AuI0gsg7sD++5jAMWtq5P
	 Q+oYIVfmK7D0nWfP7WpqslNZIpGO4T3cVCwOMnw/nX04E0A2X3nGdMfAu5b6bXM2NA
	 8VjinuMyxvJqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: shechenglong <shechenglong@xfusion.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] drm/client: fix restore of partially initialized client
Date: Tue, 29 Sep 2026 11:42:36 -0400
Message-ID: <20260929154236.4087907-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929154236.4087907-1-sashal@kernel.org>
References: <2026092902-autistic-bonnet-dcb5@gregkh>
 <20260929154236.4087907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shechenglong <shechenglong@xfusion.com>

[ Upstream commit 1fca688e9443003e33cf30453e7a7560367656c9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/clients/drm_fbdev_client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
index c8327c66a4abc..935cd85032229 100644
--- a/drivers/gpu/drm/clients/drm_fbdev_client.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
@@ -30,6 +30,14 @@ static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
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
-- 
2.53.0

