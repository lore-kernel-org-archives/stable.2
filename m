Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0013DA7F9
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817075; cv=none; b=joEG8KIoh89vjSUZ69Oo47bu/wpK6wKCo0wLH1F6sJ1smtNIeg8EUPkORJ3/4oGkRdjWX6iPBER78CkheZmr6XrmIyv3xNkLbMGryxD1FgK/6Eh7RXjeaNl5MT7SRGAXU3vE2K2c9Lg20D2B5g1gVLUJFPwpmRhTDFutkXCyoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817075; c=relaxed/simple;
	bh=xbFfTAJOQoezNoBYUo2BQWhDxjUACjRbN/i45VVWj3A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=moZB72JEK0EpFDsAsyqUVRd8VO/AQOumRp6AzcWX36MOqFiW+RQYmqOGmUNAuIERvBPJHpu0ra3KZNWAbUnNMgQc2tmg7D3ycBEvZWRsdSS5XTBDR6+N7WCncOS5LZR13Sce2w/HgkyueezEVCdR2kt7i+HIzakCIfhgAXm+gu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pEhzGnXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pEhzGnXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941DD1F0089B;
	Mon, 12 Oct 2026 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817074;
	bh=KSL2r/YkI5fYoVTy9aydWg95tB1rmjUm5cxj76WKEpU=;
	h=Subject:To:Cc:From:Date;
	b=pEhzGnXbBeA/j6q6JIgIxZuvtTnXNe3sDov2Vcon8Ku9xbccovOo8eDqilbP4H46+
	 AugHYzM14eWz8HvsKzq8FzVmlY0OKw+tk2RzchYwQkYtrb94e53cGZoM9SNRHU/tov
	 f7oS/gwvpVLHe5xmsj/kgbuNWUiQsWlCABzlBwyo=
Subject: FAILED: patch "[PATCH] optee: register TEE devices only once fully initialized" failed to apply to 5.10-stable tree
To: shf.chen@mediatek.com,jens.wiklander@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:57:49 +0200
Message-ID: <2026101249-squiggle-overprice-f654@gregkh>
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
git cherry-pick -x c108feca0a096f8db25d1b69130035025e9e936d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101249-squiggle-overprice-f654@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

