Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B936BCDE
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600765; cv=none; b=hXkU/8aTdI4lUDZxHxU8+PPJDKriFcYvoqrME9ByFbX+wvg3gNeQJXsSXJSSbhg0HCUTC/TQLPb+bA6WaenWs0os9KEZ3ery6KhJDYUI9F7YAP+Vo2VyZYBH9a8xDHG/4tBCdg1SiEvm02iLTa2qPPBjqaxWCKKBDv/H3aLeyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600765; c=relaxed/simple;
	bh=tAkOoVppVtW5ZfilPG4JqecXFEoaKahMPq6qEOHi6aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm4yZXlBrawG8K06Woj1nQ9NP4InmbD7M5ykPw71SQ4Yc2wSmIrRF9h+gr1tM9KT0ORls76xzIRLYVZCfnIexNUiQrHDTe9pfeB3JVbVJ93/6BMbhObA8MtO8vuWRQMNT4Re0lbtRTALuEtT2+SLo8MsaVPogUt+b57HzIm0urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Rm4Zu+Pu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rm4Zu+Pu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a765d410so11884395e9.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1780600762; x=1781205562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAxZviULn2zK3b1n4RAX9V0teJYOWoNlX1yHF9qdhs4=;
        b=Rm4Zu+PueoTVCG9qsq9l70qxcXHLNx4oo65lL/C9WR5HUI+TLs2ebgq4cddFucUKQx
         Ve++TcPhCmd6T5zj8oCrtl7drNU/Wj+cto69SonLcsai+rsOy8FsQz9htYMP42W9izT9
         0ExVfWXSvISTFnIV+RyZQ+OgGJs1xxiRQMBWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780600762; x=1781205562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAxZviULn2zK3b1n4RAX9V0teJYOWoNlX1yHF9qdhs4=;
        b=ZFnqJbHD8ztmk1c2ynKx270FIHZ3fZ11bEq/J1YAXfwS46q28Pb2Z7ftgsRSo2BVAH
         mra/1fn38ewJnMHukRL8MDkbKnKIHmq+cFEV6hS6WJarc8bwBVFTMDghmAwsuNfhrJq7
         0a80EoDOE3gnmyvRahVE7PU1/+P4rY7enEIvbWcTKj967kvgjibv7oIUiYvdneS4OXpm
         s1zv5uXtkPVHm+4AzMwkUCpzjTWT09sj4fDEQ3UmJzTTlUG87/I6klKIGqrRJQoa3M7X
         CApilWxdtN0JV6IxJjlqjPLzqWEIUSPuL1z8wJd53CkTpxsD13RllMfYsbodL/COIAdb
         8URA==
X-Forwarded-Encrypted: i=1; AFNElJ973vJKchi5rMR5D1S+3jH6h9ROJ/MwxmuRRpePIRXatCUnyG0wZ4a4G79FREzgoxCEutaxMEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+gqRAS8Spv/bK013oU2S8Ix+B2dybE/3xcn7+VP48wlOlySX
	dSoJGk0a/iQX+WLeeH3N+CUJmNKn3RmGtLUMiLIC6fpcT9DwuALuf1n2abVqnklf1PI=
X-Gm-Gg: Acq92OHWalcZkWhx+mkgHPoRydvNvL/eC9sXww71xomraiYxjV7cDQOaUiOvlLnpFg1
	Uru28ayF8bL5vFbIcB5zKYN07/FL7JX9N/ZcM6xYdWHWnoYiSottCfGPFT8g8x7eJBDMhac8YKY
	v7zxtRkL/VgteIu22KZbQeJFZYS9mZb72U+7atVOtjqdwNzr0yykq2gCh/aUpxl70cGI/KKkTSK
	GtHxveH/MTjpvhBUrS2GsnaHfEuSGLPk7Lr2tjtik+0SnxcGpnt4P3VLyoe5HmP4yI1SDDbe5lt
	LjtYJpd4AVattsIrYLeec9LNfnwOqn25owBxmMWHmiyzZxBwjkooVkW+8y54h7uwwtX+Ed4BIAQ
	3AmSCMa/PpiE6V09epHBCryRBQSN4Kk2bIeTgvkhqzjlCYVdJVvzApN4iejZ4yGBB+CRxsv8FqE
	MtAF4lWGNXOZt08PvyYBUqSI6aitwpAQQZYGpChwq6RcaRLg==
X-Received: by 2002:a05:600c:8712:b0:490:b106:4fe8 with SMTP id 5b1f17b1804b1-490b5ed5d5cmr163913445e9.33.1780600762193;
        Thu, 04 Jun 2026 12:19:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e5a00sm95175445e9.15.2026.06.04.12.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:19:21 -0700 (PDT)
From: Simona Vetter <simona.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	"DARKNAVY (@DarkNavyOrg)" <vr@darknavy.com>,
	syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>,
	Dave Airlie <airlied@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Francis <David.Francis@amd.com>,
	Puttimet Thammasaeng <pwn8official@gmail.com>,
	Christian Koenig <Christian.Koenig@amd.com>,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
Date: Thu,  4 Jun 2026 21:19:16 +0200
Message-ID: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On-list because the cat is out of the bag and we're clearly not good
enough to figure this out in private. The story thus far:

5e28b7b94408 ("drm: Set old handle to NULL before prime swap in
change_handle") tried to fix a race condition between the gem_close and
gem_change_handle ioctls, but got a few things wrong:

- There's a confusion with the local variable handle, which is actually
  the new handle, and so the two-stage trick was actually applied to the
  wrong idr slot. 7164d78559b0 ("drm/gem: fix race between
  change_handle and handle_delete") tried to fix that by adding yet
  another code block, but forgot to add the error handling. Which meant
  we now have two paths, both kinda wrong.

- dc366607c41c ("drm: Replace old pointer to new idr") tried to apply
  another fix, but inconsistently, again because of the handle confusion
  - this would be the right fix (kinda, somewhat, it's a mess) if we'd
  do the two-stage approach for the new handle. Except that wasn't the
  intent of the original fix.

We also didn't have an igt merged for the original ioctl, which is a big
no-go. This was attempted to address off-list in the original bugfix,
and amd QA people claimed the bug was fixed now. Very clearly that's not
the case. Here's my attempt to sort this out:

- Rename the local variable to new_handle, the old aliasing with
  args->handle is just too dangerously confusing.

- Merge the gem obj lookup with the two-stage idr_replace so that we
  avoid getting ourselves confused there.

- This means we don't have a surplus temporary reference anymore, only
  an inherited from the idr. A concurrent gem_close on the new_handle
  could steal that. Fix that with the same two-stage approach
  create_tail uses. This is a bit overkill as documented in the comment,
  but I also don't trust my ability to understand this all correctly, so
  go with the established pattern we have from other ioctls instead for
  maximum paranoia.

- Adjust error paths. I've tried to make the error and success paths
  common, because they are identical except for which handle is removed
  and on which we call idr_replace to (re)install the object again. But
  that made things messier to read, so I've left it at the more verbose
  version, which unfortunately hides the symmetry in the entire code
  flow a bit.

- While at it, also replace the 7 space indent with 1 tab.

And finally, because I flat out don't trust my abilities here at all
anymore:

- Disable the ioctl until we have the igt situation and everything else
  sorted out on-list and with full consensus.

Reported-by: DARKNAVY (@DarkNavyOrg) <vr@darknavy.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
Fixes: dc366607c41c ("drm: Replace old pointer to new idr")
Cc: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
Cc: David Francis <David.Francis@amd.com>
Cc: Puttimet Thammasaeng <pwn8official@gmail.com>
Cc: Christian Koenig <Christian.Koenig@amd.com>
Fixes: 7164d78559b0 ("drm/gem: fix race between change_handle and handle_delete")
Cc: Zhenghang Xiao <kipreyyy@gmail.com>
---
 drivers/gpu/drm/drm_gem.c   | 62 +++++++++++++------------------------
 drivers/gpu/drm/drm_ioctl.c |  2 +-
 2 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e12cdf91f4dc..56fd58a2ddc7 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1019,8 +1019,8 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv)
 {
 	struct drm_gem_change_handle *args = data;
-	struct drm_gem_object *obj, *idrobj;
-	int handle, ret;
+	struct drm_gem_object *obj;
+	int new_handle, ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
 		return -EOPNOTSUPP;
@@ -1028,52 +1028,36 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	/* idr_alloc() limitation. */
 	if (args->new_handle > INT_MAX)
 		return -EINVAL;
-	handle = args->new_handle;
-
-	obj = drm_gem_object_lookup(file_priv, args->handle);
-	if (!obj)
-		return -ENOENT;
+	new_handle = args->new_handle;
 
-	if (args->handle == handle) {
-		ret = 0;
-		goto out;
-	}
+	if (args->handle == new_handle)
+		return 0;
 
 	mutex_lock(&file_priv->prime.lock);
-
 	spin_lock(&file_priv->table_lock);
-
-       /* When create_tail allocs an obj idr, it needs to first alloc as NULL,
-	* then later replace with the correct object. This is not necessary
-	* here, because the only operations that could race are drm_prime
-	* bookkeeping, and we hold the prime lock.
-	*/
-	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
+	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
 			GFP_NOWAIT);
 
-       if (ret < 0) {
-	       spin_unlock(&file_priv->table_lock);
-	       goto out_unlock;
-       }
-
-       idrobj = idr_replace(&file_priv->object_idr, NULL, handle);
-       if (idrobj != obj) {
-	       idr_replace(&file_priv->object_idr, idrobj, handle);
-	       idr_remove(&file_priv->object_idr, args->new_handle);
-	       spin_unlock(&file_priv->table_lock);
-	       ret = -ENOENT;
-	       goto out_unlock;
-       }
-
-	idr_replace(&file_priv->object_idr, NULL, args->handle);
+	if (ret < 0) {
+		spin_unlock(&file_priv->table_lock);
+		goto out_unlock;
+	}
+
+	obj = idr_replace(&file_priv->object_idr, NULL, args->handle);
+	if (!obj) {
+		idr_remove(&file_priv->object_idr, new_handle);
+		spin_unlock(&file_priv->table_lock);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
 	spin_unlock(&file_priv->table_lock);
 
 	if (obj->dma_buf) {
 		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
-					       handle);
+					       new_handle);
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
-			idr_remove(&file_priv->object_idr, handle);
+			idr_remove(&file_priv->object_idr, new_handle);
 			idr_replace(&file_priv->object_idr, obj, args->handle);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
@@ -1086,14 +1070,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 
 	spin_lock(&file_priv->table_lock);
 	idr_remove(&file_priv->object_idr, args->handle);
-	idrobj = idr_replace(&file_priv->object_idr, obj, handle);
+	obj = idr_replace(&file_priv->object_idr, obj, new_handle);
 	spin_unlock(&file_priv->table_lock);
-	WARN_ON(idrobj != NULL);
+	WARN_ON(obj != NULL);
 
 out_unlock:
 	mutex_unlock(&file_priv->prime.lock);
-out:
-	drm_gem_object_put(obj);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ff193155129e..937fc1e2c017 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -660,7 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
-	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0),
 
-- 
2.53.0

