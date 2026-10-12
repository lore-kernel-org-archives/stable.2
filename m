Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136134CFDA
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817078; cv=none; b=AVpvYRgtWYZ1NknJUtaBL5Noue5hYTff5oJlIRomPmqd7vSmQqHd1V3yL594RgSx+qmRUJy0DEHgg8jLiOY5RrXIKtpv+MLSm9RcfFewFv+ml4eNV9VZmWs6OdlFGuu4l2Q27vjtFjtK8lwgasYPP5/Fyr+Wkbdo1Zdepr/JmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817078; c=relaxed/simple;
	bh=htNXCUXaxA2uTH0QJ+HrxDgKi2ovDC8v0cZePRO12bQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TUH2ojsRPXDoij+A/cQojIcpGyx9NJJD54wV2vFbtm8zUBx6dzWGT1zX+2uT6tG+FqfrNXcaQqAoosJ2ZSSoZ2nEpOg8a/uYDgWRhn9tVrMaW2ep/84WiqJ/VwqjT/uEw+cv4h/jxN2d+wQuXmnGWaI98Ey+Vrb469NnZZ+7pME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bQ974Uj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bQ974Uj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7E81F0089B;
	Mon, 12 Oct 2026 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817077;
	bh=5a5lJebLqGrMqd7Dah83XBSOzCEpE5nWnNmejdU7vo8=;
	h=Subject:To:Cc:From:Date;
	b=bQ974Uj2rsz7z5D8jl1TnqpElXwNfXJgj97goNkIk0v+bqrZ3vhy+OLpFmyr+o5WD
	 kDPsAaSo9NpT0JKlR4JuMIjauzwzDwtb0pycudAWFvER2BMFlQESi2dIH5WvmYZvWw
	 zvMCvUC0j/y3lqQL6cXkfAA74VCmhdsvGa283Jao=
Subject: FAILED: patch "[PATCH] optee: register TEE devices only once fully initialized" failed to apply to 5.15-stable tree
To: shf.chen@mediatek.com,jens.wiklander@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:57:49 +0200
Message-ID: <2026101248-triumph-stingray-457f@gregkh>
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
git cherry-pick -x c108feca0a096f8db25d1b69130035025e9e936d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101248-triumph-stingray-457f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c108feca0a096f8db25d1b69130035025e9e936d Mon Sep 17 00:00:00 2001
From: Shao-Fu Chen <shf.chen@mediatek.com>
Date: Fri, 18 Sep 2026 18:10:46 +0800
Subject: [PATCH] optee: register TEE devices only once fully initialized

optee_probe() called tee_device_register() on both the client and the
supplicant device before the rest of struct optee had been initialized.

tee_device_register() calls cdev_device_add(), which does two things at
once: it creates /dev/tee0 and /dev/teepriv0, and it links the device
into the tee class so that class_find_device() can find it. From that
moment on the device is reachable both from user space via tee_open()
and from kernel space via tee_client_open_context(). The only gate in
teedev_open() is tee_device_get(), which merely checks that
teedev->desc is non-NULL, which was already set by tee_device_alloc().
Therefore, there is effectively no gate at all.

A context opened in that window can run against a struct optee where

  - optee->call_queue.mutex is not initialized by optee_cq_init()
  - optee->supp mutex and completions is not initialized by
    optee_supp_init()
  - optee->rpmb_dev_mutex is not initialized yet,
  - the message argument cache is not initialized by
    optee_shm_arg_cache_init()
  - optee->ctx is still NULL

Any open session or invoke during this window takes uninitialized
mutexes and dereferences a NULL pointer.

Fix it by moving both tee_device_register() calls down to the point
where all of struct optee is set up.

Fixes: 4fb0a5eb364d ("tee: add OP-TEE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao-Fu Chen <shf.chen@mediatek.com>
[JW: adding fixes and cc]
Signed-off-by: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 633715b98625..d3cc7c5fc1e9 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -1123,14 +1123,6 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 	optee_set_dev_group(optee);
 
-	rc = tee_device_register(optee->teedev);
-	if (rc)
-		goto err_unreg_supp_teedev;
-
-	rc = tee_device_register(optee->supp_teedev);
-	if (rc)
-		goto err_unreg_supp_teedev;
-
 	rc = rhashtable_init(&optee->ffa.global_ids, &shm_rhash_params);
 	if (rc)
 		goto err_unreg_supp_teedev;
@@ -1159,6 +1151,14 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (optee_ffa_protmem_pool_init(optee, sec_caps))
 		pr_info("Protected memory service not available\n");
 
+	rc = tee_device_register(optee->teedev);
+	if (rc)
+		goto err_unregister_devices;
+
+	rc = tee_device_register(optee->supp_teedev);
+	if (rc)
+		goto err_unregister_devices;
+
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc)
 		goto err_unregister_devices;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b8a2bdac3208..51624443359b 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1849,14 +1849,6 @@ static int optee_probe(struct platform_device *pdev)
 
 	optee_set_dev_group(optee);
 
-	rc = tee_device_register(optee->teedev);
-	if (rc)
-		goto err_unreg_supp_teedev;
-
-	rc = tee_device_register(optee->supp_teedev);
-	if (rc)
-		goto err_unreg_supp_teedev;
-
 	optee_cq_init(&optee->call_queue, thread_count);
 	optee_supp_init(&optee->supp);
 	optee->smc.memremaped_shm = memremaped_shm;
@@ -1916,6 +1908,14 @@ static int optee_probe(struct platform_device *pdev)
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
 		pr_info("dynamic shared memory is enabled\n");
 
+	rc = tee_device_register(optee->teedev);
+	if (rc)
+		goto err_disable_shm_cache;
+
+	rc = tee_device_register(optee->supp_teedev);
+	if (rc)
+		goto err_disable_shm_cache;
+
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc)
 		goto err_disable_shm_cache;
@@ -1942,7 +1942,6 @@ static int optee_probe(struct platform_device *pdev)
 	optee_shm_arg_cache_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
-err_unreg_supp_teedev:
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
 	tee_device_unregister(optee->teedev);

