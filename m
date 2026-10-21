Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594308;
	b=lpSxxaCV7ugsVdkJP+E+nCry7wWTj7fBRvS2QGdTfm4mJQKQUSKk5jxM+Xz5M6w5OV6T
	 Lk31KgMennXyHC6c0j+6JJ+33DTevBfWYJTazpNutcF3mXjeclmckspWSCFg/YHgPYpD/
	 rpjzi5i8bip1dJdpwcRNF9SFYCmjZGbty/R64WqhSj6G3Hrn+mTE12ScJNjqcEhZGvJYq
	 JdgS4AHK4YyfpLYMkcVZ8VvYtUKDzZRY2ii2WMSdk1GtlbYDmgjfDVzKVZ/IB/wG9nmLP
	 /wtobN4cR/AHrJ6nmBpGbWBkBMvdFHRuQMQmAkdNR4juOG2wSbgjd1qb4saqi+hKjQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594308;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yU54UVPcpnSsq6RKdL+Nd4tJCunxe9m/hNl/5OLfcVY=;
	b=l7+epZRpkxblyQecq+J+CZ6+TrEW7ON8bjVSzA3dyWCvEhAWqHdIR8vq6s3uutcmYr88
	 8FZ2Mz10uLbYcRFPWhns4O30sPimZ960xODx5rNFHBQhtx5fO0THP+8hVGUNjmH/mjMd+
	 67MVnbU7PoNamfJ8QdoDZUKgX+6EnbCtVssmYEFrjZijVptBoWgTSPTBeW6ACf2Zrxm1O
	 QwxNNPKJJeakxSLy1r44n7WAVu87wG4i/A98UOjqDHDH8IVh9KaNuUZHXmrw8u+qWCPqz
	 9K9oH5sS4TOcuNET8vURoLMT5knsVqOmupOA60HS7S33I7aVws4OCyPJoBW0W/q2aPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ICuHf7Sg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26191606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ICuHf7Sg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E421F000C2;
	Wed, 21 Oct 2026 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594307;
	bh=yU54UVPcpnSsq6RKdL+Nd4tJCunxe9m/hNl/5OLfcVY=;
	h=Subject:To:Cc:From:Date;
	b=ICuHf7Sg69Ht/k/PMdA9uZYIKQXubn4c+S4NSMn5vt5FtThcWLFy6yBMXawM4yUNv
	 aNvqhrMJatZ/WJ6faFNIJikCHt6Bfhn0eEIZymONqL8apTLrqmXjU64WGGvE1OwdNp
	 vuhoh0eB9/9/2hzHQqx4VoJy3Dw3ZKaiL417Li/Y=
Subject: FAILED: patch "[PATCH] drm/exec: don't immediately add prelocked obj to array of" failed to apply to 6.6-stable tree
To: ckoenig.leichtzumerken@gmail.com,christian.koenig@amd.com,vitaly.prosyak@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:46:42 +0200
Message-ID: <2026102142-thank-kitty-b913@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 26401a4999f1596a515b2e704e7066ac09306488
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102142-thank-kitty-b913@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26401a4999f1596a515b2e704e7066ac09306488 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Date: Wed, 7 Oct 2026 14:46:57 +0200
Subject: [PATCH] drm/exec: don't immediately add prelocked obj to array of
 locked objs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a contention is detected the drm_exec object grabs a reference to
the contended object, unlocks all other objects and pre-locks the
contended one before anything else.

The problem is that it is possible that this pre-locked object was about
to be destroyed and drm_exec is now holding the last reference to it.

So we never actually see this pre-locked object again to be explicitly
locked and so also never reserve a slot for a dma_fence object on it.

Should the driver now use drm_exec_for_each_locked_object() to add a new
fence to all locked objects we eventually see a warning or even a
BUG_ON() to prevent random memory corruption.

Fix this by keeping the prelocked object out of the array of locked objs
until it was explicitly mentioned by the driver again.

If the prelocked object is never mentioned again by the driver
just unlock and drop the reference at the end of the locking loop.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Fixes: 09593216bff1 ("drm: execution context for GEM buffers v7")
CC: stable@vger.kernel.org # v6.6+
Link: https://lore.kernel.org/r/20261007124657.9664-1-christian.koenig@amd.com

diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 2453ec41360f..6fa3568ceba6 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -48,6 +48,16 @@
  * See struct dma_exec for more details.
  */
 
+/* Unlock and put the prelocked obj */
+static void drm_exec_drop_prelocked(struct drm_exec *exec)
+{
+	if (exec->prelocked) {
+		dma_resv_unlock(exec->prelocked->resv);
+		drm_gem_object_put(exec->prelocked);
+		exec->prelocked = NULL;
+	}
+}
+
 /* Unlock all objects and drop references */
 static void drm_exec_unlock_all(struct drm_exec *exec)
 {
@@ -58,8 +68,7 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
 		drm_gem_object_put(obj);
 	}
 
-	drm_gem_object_put(exec->prelocked);
-	exec->prelocked = NULL;
+	drm_exec_drop_prelocked(exec);
 }
 
 /**
@@ -118,6 +127,14 @@ EXPORT_SYMBOL(drm_exec_fini);
 bool drm_exec_cleanup(struct drm_exec *exec)
 {
 	if (likely(!exec->contended)) {
+
+		/*
+		 * The contended and prelocked object might never be passed to
+		 * drm_exec_lock_obj() again. This can happen when the object
+		 * is about to be cleaned up and we now hold the last reference
+		 * to it. Make sure that we don't unnecessarily keep it around.
+		 */
+		drm_exec_drop_prelocked(exec);
 		ww_acquire_done(&exec->ticket);
 		return false;
 	}
@@ -175,16 +192,16 @@ static int drm_exec_lock_contended(struct drm_exec *exec)
 		dma_resv_lock_slow(obj->resv, &exec->ticket);
 	}
 
-	ret = drm_exec_obj_locked(exec, obj);
-	if (unlikely(ret))
-		goto error_unlock;
+	/*
+	 * It is perfectly possible that we see another contention before the
+	 * first one is fully handled.
+	 */
+	drm_exec_drop_prelocked(exec);
 
+	/* We move the reference from contended to prelocked here */
 	exec->prelocked = obj;
 	return 0;
 
-error_unlock:
-	dma_resv_unlock(obj->resv);
-
 error_dropref:
 	drm_gem_object_put(obj);
 	return ret;
@@ -212,35 +229,31 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
 	if (exec->prelocked == obj) {
 		drm_gem_object_put(exec->prelocked);
 		exec->prelocked = NULL;
-		return 0;
+	} else {
+		if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
+			ret = dma_resv_lock_interruptible(obj->resv,
+							  &exec->ticket);
+		else
+			ret = dma_resv_lock(obj->resv, &exec->ticket);
+
+		if (unlikely(ret == -EDEADLK)) {
+			drm_gem_object_get(obj);
+			exec->contended = obj;
+			return -EDEADLK;
+		}
+
+		if (unlikely(ret == -EALREADY) &&
+		    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
+			return 0;
+
+		if (unlikely(ret))
+			return ret;
 	}
 
-	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
-		ret = dma_resv_lock_interruptible(obj->resv, &exec->ticket);
-	else
-		ret = dma_resv_lock(obj->resv, &exec->ticket);
-
-	if (unlikely(ret == -EDEADLK)) {
-		drm_gem_object_get(obj);
-		exec->contended = obj;
-		return -EDEADLK;
-	}
-
-	if (unlikely(ret == -EALREADY) &&
-	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
-		return 0;
-
-	if (unlikely(ret))
-		return ret;
-
 	ret = drm_exec_obj_locked(exec, obj);
 	if (ret)
-		goto error_unlock;
+		dma_resv_unlock(obj->resv);
 
-	return 0;
-
-error_unlock:
-	dma_resv_unlock(obj->resv);
 	return ret;
 }
 EXPORT_SYMBOL(drm_exec_lock_obj);
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index cc2937185a9f..c92d69a2c793 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -73,13 +73,15 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
 
 /* Helper for drm_exec_for_each_locked_object(). Internal use only. */
 #define __drm_exec_for_each_locked_object(exec, obj, __index)		\
-	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); ++__index)
+	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); \
+	     ++__index)
 /**
  * drm_exec_for_each_locked_object - iterate over all the locked objects
  * @exec: drm_exec object
  * @obj: the current GEM object
  *
- * Iterate over all the locked GEM objects inside the drm_exec object.
+ * Iterate over all the explicitly locked GEM objects inside the drm_exec
+ * container, except for the contended and implicit prelocked one.
  */
 #define drm_exec_for_each_locked_object(exec, obj)			\
 	__drm_exec_for_each_locked_object(exec, obj, __UNIQUE_ID(drm_exec))
@@ -94,12 +96,13 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
  * @exec: drm_exec object
  * @obj: the current GEM object
  *
- * Iterate over all the locked GEM objects inside the drm_exec object in
- * reverse locking order. Note that the internal index may wrap around,
- * but that will be caught by drm_exec_obj(), returning a NULL object.
+ * Iterate over all the explicitly locked GEM objects inside the drm_exec
+ * container in reverse locking order. Note that the internal index may wrap
+ * around, but that will be caught by drm_exec_obj(), returning a NULL object.
  */
 #define drm_exec_for_each_locked_object_reverse(exec, obj)		\
-	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
+	__drm_exec_for_each_locked_object_reverse(exec, obj,		\
+						  __UNIQUE_ID(drm_exec))
 
 /**
  * drm_exec_until_all_locked - loop until all GEM objects are locked

