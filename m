Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CF3B71AC
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651871; cv=none; b=M41sKeCIp/Px8mDtWdJkv1yI0/qy4RYQ+PnD4QhVmQKVKu7T8G9o/gMJqr12ulb4ymQNmFbZIPavBr4S80Xx1boW/h6NgSi/Xn66DGOt9tYYtBBFfHaQ5bNDBAgHcT3AU3bHcnPlOOg3BGFkzsbepkFDg8tO/y3IZ9UpPTfrVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651871; c=relaxed/simple;
	bh=WRwWYM/HJy3p2AemE+lfaujPFj9HjhIAvqJI43ah/60=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ViVVqhTq7xy9++yy6EaMj5eIwb9Nm+Rc+IfGBWbf84bm3eJxCvFZmQW5G13fgu3n9E+izGWJLnuTZf7pUQX9A5mAVR83dEcp51JHUEoPEMXXOE/lZJE7scfKz8rLxmvpfUbAlcVBw7s9pOK3q/H5/kP+Jvwl++ajCXGujzKpRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=PQ1AiOSE; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="PQ1AiOSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PQ1AiOSEjAd/iTllT3zawXCezSvQx75HppttMzappKF8Nr4QxSIzLJ3maB7jX8Q51Xo3cF3H8cpNC
	 KbEdioYJdHODJRKU+AoQc2iXRHvG7W/nDgJc9K8adPo4sqx+I26jSww69pp0fJyj+KWH+4YEkIG3Ky
	 Ld8e8tYEkXlKBTWw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.249.24])
	by rmsmtp-lg-appmail-40-12054 (RichMail) with SMTP id 2f166a22974cfcf-faba0;
	Fri, 05 Jun 2026 17:30:55 +0800 (CST)
X-RM-TRANSID:2f166a22974cfcf-faba0
From: Rajani Kantha <681739313@139.com>
To: herbert@gondor.apana.org.au,
	karin0.zst@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] hwrng: core - use RCU and work_struct to fix race condition
Date: Fri,  5 Jun 2026 17:30:47 +0800
Message-Id: <20260605093047.1672-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Lianjie Wang <karin0.zst@gmail.com>

[ Upstream commit cc2f39d6ac48e6e3cb2d6240bc0d6df839dd0828 ]

Currently, hwrng_fill is not cleared until the hwrng_fillfn() thread
exits. Since hwrng_unregister() reads hwrng_fill outside the rng_mutex
lock, a concurrent hwrng_unregister() may call kthread_stop() again on
the same task.

Additionally, if hwrng_unregister() is called immediately after
hwrng_register(), the stopped thread may have never been executed. Thus,
hwrng_fill remains dirty even after hwrng_unregister() returns. In this
case, subsequent calls to hwrng_register() will fail to start new
threads, and hwrng_unregister() will call kthread_stop() on the same
freed task. In both cases, a use-after-free occurs:

refcount_t: addition on 0; use-after-free.
WARNING: ... at lib/refcount.c:25 refcount_warn_saturate+0xec/0x1c0
Call Trace:
 kthread_stop+0x181/0x360
 hwrng_unregister+0x288/0x380
 virtrng_remove+0xe3/0x200

This patch fixes the race by protecting the global hwrng_fill pointer
inside the rng_mutex lock, so that hwrng_fillfn() thread is stopped only
once, and calls to kthread_run() and kthread_stop() are serialized
with the lock held.

To avoid deadlock in hwrng_fillfn() while being stopped with the lock
held, we convert current_rng to RCU, so that get_current_rng() can read
current_rng without holding the lock. To remove the lock from put_rng(),
we also delay the actual cleanup into a work_struct.

Since get_current_rng() no longer returns ERR_PTR values, the IS_ERR()
checks are removed from its callers.

With hwrng_fill protected by the rng_mutex lock, hwrng_fillfn() can no
longer clear hwrng_fill itself. Therefore, if hwrng_fillfn() returns
directly after current_rng is dropped, kthread_stop() would be called on
a freed task_struct later. To fix this, hwrng_fillfn() calls schedule()
now to keep the task alive until being stopped. The kthread_stop() call
is also moved from hwrng_unregister() to drop_current_rng(), ensuring
kthread_stop() is called on all possible paths where current_rng becomes
NULL, so that the thread would not wait forever.

Fixes: be4000bc4644 ("hwrng: create filler thread")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Lianjie Wang <karin0.zst@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/char/hw_random/core.c | 172 +++++++++++++++++++++-------------
 include/linux/hw_random.h     |   2 +
 2 files changed, 108 insertions(+), 66 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index a182fe794f98..08d6d08e0c59 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -20,23 +20,25 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/random.h>
+#include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
 
 #define RNG_MODULE_NAME		"hw_random"
 
 #define RNG_BUFFER_SIZE (SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES)
 
-static struct hwrng *current_rng;
+static struct hwrng __rcu *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */
 static int cur_rng_set_by_user;
 static struct task_struct *hwrng_fill;
 /* list of registered rngs */
 static LIST_HEAD(rng_list);
-/* Protects rng_list and current_rng */
+/* Protects rng_list, hwrng_fill and updating on current_rng */
 static DEFINE_MUTEX(rng_mutex);
 /* Protects rng read functions, data_avail, rng_buffer and rng_fillbuf */
 static DEFINE_MUTEX(reading_mutex);
@@ -77,18 +79,39 @@ static void add_early_randomness(struct hwrng *rng)
 	}
 }
 
-static inline void cleanup_rng(struct kref *kref)
+static void cleanup_rng_work(struct work_struct *work)
 {
-	struct hwrng *rng = container_of(kref, struct hwrng, ref);
+	struct hwrng *rng = container_of(work, struct hwrng, cleanup_work);
+
+	/*
+	 * Hold rng_mutex here so we serialize in case they set_current_rng
+	 * on rng again immediately.
+	 */
+	mutex_lock(&rng_mutex);
+
+	/* Skip if rng has been reinitialized. */
+	if (kref_read(&rng->ref)) {
+		mutex_unlock(&rng_mutex);
+		return;
+	}
 
 	if (rng->cleanup)
 		rng->cleanup(rng);
 
 	complete(&rng->cleanup_done);
+	mutex_unlock(&rng_mutex);
+}
+
+static inline void cleanup_rng(struct kref *kref)
+{
+	struct hwrng *rng = container_of(kref, struct hwrng, ref);
+
+	schedule_work(&rng->cleanup_work);
 }
 
 static int set_current_rng(struct hwrng *rng)
 {
+	struct hwrng *old_rng;
 	int err;
 
 	BUG_ON(!mutex_is_locked(&rng_mutex));
@@ -97,8 +120,14 @@ static int set_current_rng(struct hwrng *rng)
 	if (err)
 		return err;
 
-	drop_current_rng();
-	current_rng = rng;
+	old_rng = rcu_dereference_protected(current_rng,
+					    lockdep_is_held(&rng_mutex));
+	rcu_assign_pointer(current_rng, rng);
+
+	if (old_rng) {
+		synchronize_rcu();
+		kref_put(&old_rng->ref, cleanup_rng);
+	}
 
 	/* if necessary, start hwrng thread */
 	if (!hwrng_fill) {
@@ -114,47 +143,56 @@ static int set_current_rng(struct hwrng *rng)
 
 static void drop_current_rng(void)
 {
-	BUG_ON(!mutex_is_locked(&rng_mutex));
-	if (!current_rng)
+	struct hwrng *rng;
+
+	rng = rcu_dereference_protected(current_rng,
+					lockdep_is_held(&rng_mutex));
+	if (!rng)
 		return;
 
+	RCU_INIT_POINTER(current_rng, NULL);
+	synchronize_rcu();
+
+	if (hwrng_fill) {
+		kthread_stop(hwrng_fill);
+		hwrng_fill = NULL;
+	}
+
 	/* decrease last reference for triggering the cleanup */
-	kref_put(&current_rng->ref, cleanup_rng);
-	current_rng = NULL;
+	kref_put(&rng->ref, cleanup_rng);
 }
 
-/* Returns ERR_PTR(), NULL or refcounted hwrng */
+/* Returns NULL or refcounted hwrng */
 static struct hwrng *get_current_rng_nolock(void)
 {
-	if (current_rng)
-		kref_get(&current_rng->ref);
+	struct hwrng *rng;
 
-	return current_rng;
+	rng = rcu_dereference_protected(current_rng,
+					lockdep_is_held(&rng_mutex));
+	if (rng)
+		kref_get(&rng->ref);
+
+	return rng;
 }
 
 static struct hwrng *get_current_rng(void)
 {
 	struct hwrng *rng;
 
-	if (mutex_lock_interruptible(&rng_mutex))
-		return ERR_PTR(-ERESTARTSYS);
+	rcu_read_lock();
+	rng = rcu_dereference(current_rng);
+	if (rng)
+		kref_get(&rng->ref);
 
-	rng = get_current_rng_nolock();
+	rcu_read_unlock();
 
-	mutex_unlock(&rng_mutex);
 	return rng;
 }
 
 static void put_rng(struct hwrng *rng)
 {
-	/*
-	 * Hold rng_mutex here so we serialize in case they set_current_rng
-	 * on rng again immediately.
-	 */
-	mutex_lock(&rng_mutex);
 	if (rng)
 		kref_put(&rng->ref, cleanup_rng);
-	mutex_unlock(&rng_mutex);
 }
 
 static int hwrng_init(struct hwrng *rng)
@@ -219,10 +257,6 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 
 	while (size) {
 		rng = get_current_rng();
-		if (IS_ERR(rng)) {
-			err = PTR_ERR(rng);
-			goto out;
-		}
 		if (!rng) {
 			err = -ENODEV;
 			goto out;
@@ -309,7 +343,7 @@ static struct miscdevice rng_miscdev = {
 
 static int enable_best_rng(void)
 {
-	struct hwrng *rng, *new_rng = NULL;
+	struct hwrng *rng, *cur_rng, *new_rng = NULL;
 	int ret = -ENODEV;
 
 	BUG_ON(!mutex_is_locked(&rng_mutex));
@@ -327,7 +361,9 @@ static int enable_best_rng(void)
 			new_rng = rng;
 	}
 
-	ret = ((new_rng == current_rng) ? 0 : set_current_rng(new_rng));
+	cur_rng = rcu_dereference_protected(current_rng,
+					    lockdep_is_held(&rng_mutex));
+	ret = ((new_rng == cur_rng) ? 0 : set_current_rng(new_rng));
 	if (!ret)
 		cur_rng_set_by_user = 0;
 
@@ -378,8 +414,6 @@ static ssize_t rng_current_show(struct device *dev,
 	struct hwrng *rng;
 
 	rng = get_current_rng();
-	if (IS_ERR(rng))
-		return PTR_ERR(rng);
 
 	ret = snprintf(buf, PAGE_SIZE, "%s\n", rng ? rng->name : "none");
 	put_rng(rng);
@@ -423,8 +457,6 @@ static ssize_t rng_quality_show(struct device *dev,
 	struct hwrng *rng;
 
 	rng = get_current_rng();
-	if (IS_ERR(rng))
-		return PTR_ERR(rng);
 
 	if (!rng) /* no need to put_rng */
 		return -ENODEV;
@@ -439,6 +471,7 @@ static ssize_t rng_quality_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t len)
 {
+	struct hwrng *rng;
 	u16 quality;
 	int ret = -EINVAL;
 
@@ -455,12 +488,13 @@ static ssize_t rng_quality_store(struct device *dev,
 		goto out;
 	}
 
-	if (!current_rng) {
+	rng = rcu_dereference_protected(current_rng, lockdep_is_held(&rng_mutex));
+	if (!rng) {
 		ret = -ENODEV;
 		goto out;
 	}
 
-	current_rng->quality = quality;
+	rng->quality = quality;
 	current_quality = quality; /* obsolete */
 
 	/* the best available RNG may have changed */
@@ -506,8 +540,20 @@ static int hwrng_fillfn(void *unused)
 		struct hwrng *rng;
 
 		rng = get_current_rng();
-		if (IS_ERR(rng) || !rng)
+		if (!rng) {
+			/*
+			 * Keep the task_struct alive until kthread_stop()
+			 * is called to avoid UAF in drop_current_rng().
+			 */
+			while (!kthread_should_stop()) {
+				set_current_state(TASK_INTERRUPTIBLE);
+				if (!kthread_should_stop())
+					schedule();
+			}
+			set_current_state(TASK_RUNNING);
 			break;
+		}
+
 		mutex_lock(&reading_mutex);
 		rc = rng_get_data(rng, rng_fillbuf,
 				  rng_buffer_size(), 1);
@@ -535,15 +581,14 @@ static int hwrng_fillfn(void *unused)
 		add_hwgenerator_randomness((void *)rng_fillbuf, rc,
 					   entropy >> 10, true);
 	}
-	hwrng_fill = NULL;
 	return 0;
 }
 
 int hwrng_register(struct hwrng *rng)
 {
 	int err = -EINVAL;
-	struct hwrng *tmp;
 	bool is_new_current = false;
+	struct hwrng *cur_rng, *tmp;
 
 	if (!rng->name || (!rng->data_read && !rng->read))
 		goto out;
@@ -558,6 +603,7 @@ int hwrng_register(struct hwrng *rng)
 	}
 	list_add_tail(&rng->list, &rng_list);
 
+	INIT_WORK(&rng->cleanup_work, cleanup_rng_work);
 	init_completion(&rng->cleanup_done);
 	complete(&rng->cleanup_done);
 	init_completion(&rng->dying);
@@ -565,16 +611,19 @@ int hwrng_register(struct hwrng *rng)
 	/* Adjust quality field to always have a proper value */
 	rng->quality = min_t(u16, min_t(u16, default_quality, 1024), rng->quality ?: 1024);
 
-	if (!current_rng ||
-	    (!cur_rng_set_by_user && rng->quality > current_rng->quality)) {
-		/*
-		 * Set new rng as current as the new rng source
-		 * provides better entropy quality and was not
-		 * chosen by userspace.
-		 */
-		err = set_current_rng(rng);
-		if (err)
-			goto out_unlock;
+	if (!cur_rng_set_by_user) {
+		cur_rng = rcu_dereference_protected(current_rng,
+						    lockdep_is_held(&rng_mutex));
+		if (!cur_rng || rng->quality > cur_rng->quality) {
+			/*
+			 * Set new rng as current as the new rng source
+			 * provides better entropy quality and was not
+			 * chosen by userspace.
+			 */
+			err = set_current_rng(rng);
+			if (err)
+				goto out_unlock;
+		}
 		/* to use current_rng in add_early_randomness() we need
 		 * to take a ref
 		 */
@@ -604,7 +653,8 @@ EXPORT_SYMBOL_GPL(hwrng_register);
 
 void hwrng_unregister(struct hwrng *rng)
 {
-	struct hwrng *old_rng, *new_rng;
+	struct hwrng *old_rng;
+	struct hwrng *cur_rng;
 	int err;
 
 	mutex_lock(&rng_mutex);
@@ -612,7 +662,10 @@ void hwrng_unregister(struct hwrng *rng)
 	old_rng = current_rng;
 	list_del(&rng->list);
 	complete_all(&rng->dying);
-	if (current_rng == rng) {
+
+	cur_rng = rcu_dereference_protected(current_rng,
+					    lockdep_is_held(&rng_mutex));
+	if (cur_rng == rng) {
 		err = enable_best_rng();
 		if (err) {
 			drop_current_rng();
@@ -620,20 +673,7 @@ void hwrng_unregister(struct hwrng *rng)
 		}
 	}
 
-	new_rng = get_current_rng_nolock();
-	if (list_empty(&rng_list)) {
-		mutex_unlock(&rng_mutex);
-		if (hwrng_fill)
-			kthread_stop(hwrng_fill);
-	} else
-		mutex_unlock(&rng_mutex);
-
-	if (new_rng) {
-		if (old_rng != new_rng)
-			add_early_randomness(new_rng);
-		put_rng(new_rng);
-	}
-
+	mutex_unlock(&rng_mutex);
 	wait_for_completion(&rng->cleanup_done);
 }
 EXPORT_SYMBOL_GPL(hwrng_unregister);
@@ -721,7 +761,7 @@ static int __init hwrng_modinit(void)
 static void __exit hwrng_modexit(void)
 {
 	mutex_lock(&rng_mutex);
-	BUG_ON(current_rng);
+	WARN_ON(rcu_access_pointer(current_rng));
 	kfree(rng_buffer);
 	kfree(rng_fillbuf);
 	mutex_unlock(&rng_mutex);
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index 136e9842120e..3f88cc518fe7 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/kref.h>
+#include <linux/workqueue_types.h>
 
 /**
  * struct hwrng - Hardware Random Number Generator driver
@@ -49,6 +50,7 @@ struct hwrng {
 	/* internal. */
 	struct list_head list;
 	struct kref ref;
+	struct work_struct cleanup_work;
 	struct completion cleanup_done;
 	struct completion dying;
 };
-- 
2.17.1


