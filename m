Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014B4FDE47
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698881; cv=none; b=UR7n9HAy1AyZjPrJ+UfksvaiygcCwtHMBzxBQ2ZImIBrvBQ7lhVC5uwNCE+yvu3iSbAu1pCBOGxXlimIHnP63u1R836gOcJdKlR2dUpNB+TqDLLktj50K968nDrbD9sVNixuJVVzTQuKLOC11Z9uJK+p8AZ1j6yqQ8ZxqXPtOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698881; c=relaxed/simple;
	bh=b8JlDRC2Xvp6bqNptSrPEqW8M7IjxHGUOcuPku8TSVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwbeCdxNGW4NIg3bZqmobHmavxKg0FglXzMxzJpQJtA64izz1r/gGVVO/98aot0LUFyTiQUJoWyPgB62vVPDWWt+N+XIsY/z1LedrcymlgawWytNnAUIQWnTjBlNz4etDWOlqkunqEYow7QPNV/aJcFjukS6bU1P82l9RWH9SJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG6blVwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG6blVwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762E61F00898;
	Tue, 29 Sep 2026 16:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790698878;
	bh=fE54lW1S8NzkYIRaJrxOz02/+eCUts6YuT2nNXHlyjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OG6blVwV/8oXDl4w/Y8F75u94iNyS1hLYULEUCd8srTm1JdBWdHQljWXMpclr+B2D
	 /3FoYVjNkgZO0wPf9zl43D3P4CiPx+EMiYH/nfHpEGvgM8hNuNAHwJPGj/AlXgc2zg
	 fBDGEPEnB1JecXcZZnDVLQO2GyvqsEtKdD/kBpb6xALaeTzg5Fzk6Y/q8eYhxeGX40
	 Inl5sRWjnDy7QKj9Ib30QqOoTlv7kFSiQR97NxRIWvZiELtxi0CF6b0PavfNCza6gA
	 QGkomStx2Ez6Gtok1OM0kyd9TE5KxlNuN7E4/H/t6RCQKJVdb8GAlgh+DN3TQLqYCI
	 FqssywiMA/cug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: shechenglong <shechenglong@xfusion.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/client: fix restore of partially initialized client
Date: Tue, 29 Sep 2026 12:21:16 -0400
Message-ID: <20260929162116.4190216-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929162116.4190216-1-sashal@kernel.org>
References: <2026092903-cofounder-fineness-3637@gregkh>
 <20260929162116.4190216-1-sashal@kernel.org>
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
 drivers/gpu/drm/drm_fbdev_client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_fbdev_client.c b/drivers/gpu/drm/drm_fbdev_client.c
index 175c5eade6860..91a7659ec1c8a 100644
--- a/drivers/gpu/drm/drm_fbdev_client.c
+++ b/drivers/gpu/drm/drm_fbdev_client.c
@@ -29,6 +29,14 @@ static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
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

