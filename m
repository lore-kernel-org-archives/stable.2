Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CE3C13E7
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602283; cv=none; b=C6m4ub7RMy49XHBOab+cT9vmW95UhSjrKrL3cGPgOcPJ/Hzdo7G1m03dPhfd1HnOBKoL4OTQvmwMEjhpCmoTwpL+So1NRKbEwTia+vKvPrLcH687MiGnL5kCV0zqpz45WBritM4R62trrcgIvjo1jP98dY51a2DhNc6yzb4MXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602283; c=relaxed/simple;
	bh=s2o4YltOnwXabMbrwjXXPv4huzSvgf4LGvhOEfN+rFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NY0Zi7sbnDIj58GQ9v0bt+IJfx9JkrFO/KJutAxVJ5fXsc+jp2KhsK4n0JyQyZ6KHozPdvUgxYYou/Bbbeb2AQFfqMAiZCjZ6ehGBsvyK1KCiLJUU83jMdVq/utLA32UrEGibBtMwnoQ0UZonYjrRpRoZZ7yDxbBhEluNjvG9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Qrf1vPPt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Qrf1vPPt"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef616daf6so1041436f8f.3
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1780602279; x=1781207079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3Mz5gFS0uICYS8oUauxnCGzN+B8DWW7+Ft4l095als=;
        b=Qrf1vPPthaFZbMF5I1pS3yeypCST5e9qn2gzcIxR12pCG6V+IR0F8ES0kn60uZIV8C
         bigSJmpeFdRgOD3ZoW61syMDZTPD6HNSA0ZT6J2RnPnxQKMZbbWGGpmEBN9uWkPvLXeR
         NEZ1gFebaiVH44+FAT0udvUjY7Z/7nmW5aHYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602279; x=1781207079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S3Mz5gFS0uICYS8oUauxnCGzN+B8DWW7+Ft4l095als=;
        b=grKsCO6tLIVFpLLbitl80JYsKGhoYuou6JiZ/7AJF0yoTwaU3ZYt0mAJEE1DSNPadf
         rTqA6ToneE6iCTYkkdKbSMaS/sBPn7bPPgI5eLCaeAbYghRxq0pS4ztcQpULOyOU1gTF
         FP5WekL9r05TsSl36Tppkh3AB/Ggy+jlghiqEtTHTn/PLj4RCZ8jOxdl4HZMybuo9djG
         9aNaZvgWX/Zvp2/pcQQgjleElVkYtspbUEw/3x+HgxOas+fYUgyf4Kc6QvwCyJ8oa5Fs
         JJ4sKosSkiL30/M8fssTm20v/0ndeORIKzp0GFQt+IxY+Xv1qHfTIuT8Eq2nUuoB2KXU
         MR4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/dwogME3ahm2F3A4uyT3QsO9i+EYevnLkVjswCslYmo8G331y+kW9uDiwlMq7kASibsdXR4+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAwM8A1vO4l1IGxPsdZW+TjyMJ8TlG5FwPbccGZCaxjirVo3m
	nTRDYJgqfOJy/pSCH+u0saS1eI1e+EfuKZ7cDHBU5MixTp/mIbcx8pEnH+MEXQHMBpc=
X-Gm-Gg: Acq92OFa44/PlC2ntzG8rMJ+SfBceOBSKrYrXvihSJJ+UvHwYkG40NlAKsA6mzDjnqa
	8KJM7+/9d4vGpz2LXDchg8TCsQFPd9gqQEwsLpWEug1KZ1FMWUOMIMsm9ypAl7Aut1JfiWMLnif
	+R/MfWXWl2QBPpbbI4dwqaLnojjbmS8COs5YGlSx9Z6tr10OtfMnGcL72ksE3F0jWfGLDbBbeP4
	GmXhQkbluxvvuwy8rTnqgC26Yia6sVz+IvVSg54aYJoBWAe+i2Op7MWJZ9PWPbOp4qLhRsBsWry
	5EijvYHvdkQKyHXyR30fVIfzPbvVnTB0HMUriRZUgq8b9Piv30jlJRIQ5UcuzaAxGmNoLZgvspg
	BNPOTY/w8rt/HVpEwf7RVGmV7dm5RE8w1847+f0EOC5+JDzbJg7HqOUFWWAkOhlup0fK8L+khwd
	F+dxgh1B+6sWTOvpQBIyLvnZaFqOEkgbpQrd/KQU5jwnqXSQ==
X-Received: by 2002:a05:600c:34ca:b0:490:9df1:f0cf with SMTP id 5b1f17b1804b1-490c2592042mr668855e9.2.1780602279616;
        Thu, 04 Jun 2026 12:44:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm96489005e9.6.2026.06.04.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:44:39 -0700 (PDT)
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
Date: Thu,  4 Jun 2026 21:44:37 +0200
Message-ID: <20260604194437.1725314-1-simona.vetter@ffwll.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
References: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
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

v2:

Sashiko noticed that I didn't handle the error path for idr_replace
correctly, it must be checked with IS_ERR_OR_NULL like in
gem_handle_delete. So yeah, definitely should just the existing paths
1:1 because this is endless amounts of tricky.

Also add the Fixes: line for the original ioctl, I forgot that too.

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
Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
---
 drivers/gpu/drm/drm_gem.c   | 62 +++++++++++++------------------------
 drivers/gpu/drm/drm_ioctl.c |  2 +-
 2 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e12cdf91f4dc..f49f1724eda5 100644
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
+	if (IS_ERR_OR_NULL(obj)) {
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

