Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2636728D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005324; cv=none; b=GvFRj5WuR41GUKj39NkfXXETa8pszof82yUgbMKgw7/GtDXYd4ENLWsxbJCphVajvHpyI2GXK9+41jtSeZSHHVNQe+uC5Xom59ZukG+Nh9iHt5bg6Tir6ZRouoJ3d0sHJ2Jda41CSS3k9fCMLNVQ9DOP3gkcKyCayJkxlpeMPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005324; c=relaxed/simple;
	bh=cdqIv/oW4EqYRCTi8P3cCy3bfaIVYJiow1lGaRHS4K4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rzi7K80LZUU3c5jjRb1XRaAoRcvS4MW4OcYCte9Nz+h/GxiRJVZutPRfgURVPDJwdRT5ZFKHsB0gpABExplVzQl5ak9Im7Se9+ia5cDDdbE4VdpbmZCOrRaI3fEzsaD/RdHgHbUBrGaNjl69B1Sh86KXL4/RBmlgfflEO12LRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ofa9+hBJ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ofa9+hBJ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8699b293a80so196930b3a.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 18:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789005317; x=1789610117; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jv8lmq9dzzbUxwG3IMt124PYeUH8gDxWI8uW5PP9r1I=;
        b=Ofa9+hBJZnWq3p1x1kklqa535Ee7bi0J7oHUDB2KhLekhkEupOsZx5+bKAfTiVnBhu
         pVYvsSHBWGAkU/T76g3rYPqEkEJIQYfrDvyecq8sBfpV121g0kGIwJEwNj7R1gI4Smir
         eFmwRNFpdloH5EQSdt6qaN/6zgMKILQ7gvmF+MfPvOriyTeZhRUtLu4RZE5YcDEzBB3y
         t9p+DCCqVkljanJXGB+XQvdCro1tzFKzXYmxVbxutH5YF3jTv5d93B8KuY2XX+x+TtpB
         LD2x4c2W33acRtD9SbED3PfDRj414UOAqqvQjJJYR9GpO+geFvBD2MYSDkRZYnGF0p6e
         adMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789005317; x=1789610117;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jv8lmq9dzzbUxwG3IMt124PYeUH8gDxWI8uW5PP9r1I=;
        b=tN2/VnwQc5dsmJxNPnLHMWuMxNGyZSxqL/oiSqzNBE6lQ35CellRm97VHpKa60qCEI
         x1UvwQHExarN8cIUGdEab1/5CxBMpBAtglOuvfNMraDd4mAJhROuTzm2xLHtsgQ7TK5t
         4O40VDYszJ2ux3w98tC9PN3mbGvBOE6MGEizAq1WA0LFEEsiQ1+mWUdD2+YdkL0EMOrf
         8kDjF6inLsWeSDf006XheDhTEg8g2p1Y/hlSDftAxxtIaOHZyZql3vggatgsdc5VyRCi
         zzxPmCrSaDO91r32CtEWxdy2zQKylnUMdnQ/BOgpyE+IytGyS2h4xlT0olWRWRINXdih
         kcZw==
X-Forwarded-Encrypted: i=1; AKwUvByloo0MDPsOqbjDQd6bRDRDwGL9kD7Ia2Btmt79oa4kHxuxVSer8Qnwr28/F6iqr987VAZnSg8=@vger.kernel.org
X-Gm-Message-State: AFuF++lisVrf0TzLcqnoFSCmLBLpLyOBfMmlqNZZn7XaVTASlXKSb60M
	FAqmLA1vW1rh4nRbFNgaNPdzq1P40Ps7oH0211NIjYYLuRhObKlCJY36G0l9OlGa9Y/lUZkJKSq
	ZGM5RxLmqIRMxoR9xNkrFOg==
X-Received: from pfbdk11.prod.google.com ([2002:a05:6a00:488b:b0:848:401c:994])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2185:b0:84e:909:ac03 with SMTP id d2e1a72fcca58-86168198ab5mr48340486b3a.10.1789005316829;
 Wed, 09 Sep 2026 18:55:16 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:55:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910015515.1991789-1-stanleyjhu@google.com>
Subject: [PATCH v3] rpmb: core: Guard frame requests and teardown with mutex
From: Stanley Jhu <stanleyjhu@google.com>
To: Jens Wiklander <jenswi@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Brian Kao <powenkao@google.com>, Ulf Hansson <ulfh@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a storage host unbinds or card is removed, the RPMB provider
unregisters the RPMB device via rpmb_dev_unregister(). However, lockless
access in rpmb_route_frames() races with provider teardown, risking
frame dispatch against an unpowered or torn-down host controller.

Furthermore, within a single route_frames() request, provider drivers
dispatch multiple discrete security protocol commands to the underlying
host (for example, Security Protocol Out followed by Security Protocol
In on UFS). Without locking at the RPMB core entry point, concurrent
callers can interleave low-level command sequences.

Fix these concurrency and teardown issues:
- Add a mutex and a dead flag to struct rpmb_dev.
- Guard rpmb_route_frames() with the mutex and reject requests with
  -ENODEV once the device is marked dead.
- In rpmb_dev_unregister(), acquire the mutex to drain in-flight
  requests and mark the device dead before proceeding to device_del().
- Ensure mutex_destroy() is called in rpmb_dev_release() and in the
  registration error unwind path.
- Clarify kerneldoc for rpmb_dev_unregister() to advise calling from
  the provider's remove/unbind path, not a device release callback.

Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subsystem")
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Cc: stable@vger.kernel.org
---
Differences from v2:
- Scope lock boundary to discrete protocol frames under route_frames().
- Drop redundant parent device pinning in favor of mutex drain.
- Add Context: Might sleep to rpmb_route_frames() kerneldoc.
- Fix misleading kerneldoc for rpmb_dev_unregister().

Tested:
- Verified clean probe, RPMB I/O, and unbind on QEMU ARM64 without UAF.

Note: A companion series fixing the UFS cyclic refcount in ufs-rpmb.c
has been submitted to linux-scsi.

 drivers/misc/rpmb-core.c | 34 +++++++++++++++++++++++++++++-----
 include/linux/rpmb.h     |  5 +++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index ecf14acf230a..bbc3c404ad6f 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -45,16 +45,28 @@ EXPORT_SYMBOL_GPL(rpmb_dev_put);
  * @rsp:	rpmb response frames
  * @rsp_len:	length of rpmb response frames in bytes
  *
+ * Context: Might sleep.
+ *
  * Returns: < 0 on failure
  */
 int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 		      unsigned int req_len, u8 *rsp, unsigned int rsp_len)
 {
-	if (!req || !req_len || !rsp || !rsp_len)
+	int ret;
+
+	if (!rdev || !req || !req_len || !rsp || !rsp_len)
 		return -EINVAL;
 
-	return rdev->descr.route_frames(rdev->dev.parent, req, req_len,
-					rsp, rsp_len);
+	mutex_lock(&rdev->lock);
+	if (rdev->dead) {
+		mutex_unlock(&rdev->lock);
+		return -ENODEV;
+	}
+
+	ret = rdev->descr.route_frames(rdev->dev.parent, req, req_len,
+				       rsp, rsp_len);
+	mutex_unlock(&rdev->lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rpmb_route_frames);
 
@@ -62,6 +74,7 @@ static void rpmb_dev_release(struct device *dev)
 {
 	struct rpmb_dev *rdev = to_rpmb_dev(dev);
 
+	mutex_destroy(&rdev->lock);
 	ida_free(&rpmb_ida, rdev->id);
 	kfree(rdev->descr.dev_id);
 	kfree(rdev);
@@ -123,8 +136,9 @@ EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
  * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
  * @rdev: the rpmb device to unregister
  *
- * This function should be called from the release function of the
- * underlying device used when the RPMB device was registered.
+ * This function should be called from the remove or unbind callback of the
+ * underlying device used when the RPMB device was registered, never from
+ * a device release callback.
  *
  * Returns: < 0 on failure
  */
@@ -133,6 +147,14 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev)
 	if (!rdev)
 		return -EINVAL;
 
+	mutex_lock(&rdev->lock);
+	if (rdev->dead) {
+		mutex_unlock(&rdev->lock);
+		return 0;
+	}
+	rdev->dead = true;
+	mutex_unlock(&rdev->lock);
+
 	device_del(&rdev->dev);
 
 	rpmb_dev_put(rdev);
@@ -164,6 +186,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	rdev = kzalloc_obj(*rdev);
 	if (!rdev)
 		return ERR_PTR(-ENOMEM);
+	mutex_init(&rdev->lock);
 	rdev->descr = *descr;
 	rdev->descr.dev_id = kmemdup(descr->dev_id, descr->dev_id_len,
 				     GFP_KERNEL);
@@ -194,6 +217,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 err_free_dev_id:
 	kfree(rdev->descr.dev_id);
 err_free_rdev:
+	mutex_destroy(&rdev->lock);
 	kfree(rdev);
 	return ERR_PTR(ret);
 }
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
index ed3f8e431eff..ca66a80ab888 100644
--- a/include/linux/rpmb.h
+++ b/include/linux/rpmb.h
@@ -7,6 +7,7 @@
 #define __RPMB_H__
 
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 
 /**
@@ -48,15 +49,19 @@ struct rpmb_descr {
  * struct rpmb_dev - device which can support RPMB partition
  *
  * @dev              : device
+ * @lock             : protects in-flight operations against teardown
  * @id               : device_id
  * @list_node        : linked list node
  * @descr            : RPMB description
+ * @dead             : set to true when device is unregistered
  */
 struct rpmb_dev {
 	struct device dev;
+	struct mutex lock;
 	int id;
 	struct list_head list_node;
 	struct rpmb_descr descr;
+	bool dead;
 };
 
 #define to_rpmb_dev(x)		container_of((x), struct rpmb_dev, dev)
-- 
2.55.0.1007.g17ff1f9808-goog

