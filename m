Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241F5172DB
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905745; cv=none; b=t1MoXQ2u8d3mIkBzkY/Tj1Zton99gusBRwb9kNpLnswJEcz6CIgwgM74XnUPMIEOf9gOpHRuuOBQeVeiaXxqF4ikSUGuoECG3U6GLbRD84fk8hs2+KMyvsbd8SGJHcsyJHC/ehVrg52YFqTWuBwc5X7loeZA28x7p1TckI7atMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905745; c=relaxed/simple;
	bh=5dGnTWbLR7SRTOeL7OWnbowrPVMpGQjjAOSJq0Pe2lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMe0k9REBLFCizpE71enXGIi+NPt4tZ0VJ7LwHd69gui/coJpRbAQxnb9YiMqeXxvC4f/hE9hOdqax8JpQ3duuzuhG8ZHwIQRUfPPrxDfrVe397Q2Vg+gwr1qJgV6CFk651MrfjzoXlSJIKQ7coKcYcMvjbgRc8w4uPo1qb5k3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ++mjUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ++mjUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B911F000FF;
	Tue, 13 Oct 2026 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905743;
	bh=GJ/d+NI8rOxRjODQ527SVxwMmvtP4TJCl2Fq4/oGUHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJ++mjUZfJjuTP4yBqxOzEjeZuM63I5tE9/GzqosPyUVtEWgLkhrAUFb+7oC7FFcf
	 HXuqtw/cbddwSHkJIFZ3JKRmZomzywTm+4Lti0ypwXV5hwS7bXlOYQjSFgZEtPCVvC
	 3e6mEd0sKuRxTIcnaQKekjp45svNK3pLdJ+j+DvEF+S35RAh8i8AyJv65spAWsy2Cr
	 WbE2/PM9RDHih0QtEgnJCPI2qmVJIzn133hRVGkrqaRHI7sPCEvz8sK+5Zv+2EF1xq
	 0l2pk1tiXabw96eKP7V9IMbizF+HnP7PYlUlFfwjOxhpPpZNWGZ2Vg9djvcf6qjmNI
	 SrEbhGGZC5PRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shao-Fu Chen <shf.chen@mediatek.com>,
	Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] optee: register TEE devices only once fully initialized
Date: Tue, 13 Oct 2026 11:35:41 -0400
Message-ID: <20261013153528.287537-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101248-unsorted-startle-21d8@gregkh>
References: <2026101248-unsorted-startle-21d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shao-Fu Chen <shf.chen@mediatek.com>

[ Upstream commit c108feca0a096f8db25d1b69130035025e9e936d ]

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
[ sashal: Adjusted context to match the older OP-TEE probe initialization sequence. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
 drivers/tee/optee/smc_abi.c | 17 ++++++++---------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 927c3d7947f9c..f0ecd931035e3 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -844,14 +844,6 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	}
 	optee->supp_teedev = teedev;
 
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
@@ -871,6 +863,14 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (rc)
 		goto err_close_ctx;
 
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
index e6e0428f8e7be..89ab5323f9fe7 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1467,14 +1467,6 @@ static int optee_probe(struct platform_device *pdev)
 	}
 	optee->supp_teedev = teedev;
 
-	rc = tee_device_register(optee->teedev);
-	if (rc)
-		goto err_unreg_supp_teedev;
-
-	rc = tee_device_register(optee->supp_teedev);
-	if (rc)
-		goto err_unreg_supp_teedev;
-
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
 	optee_supp_init(&optee->supp);
@@ -1531,6 +1523,14 @@ static int optee_probe(struct platform_device *pdev)
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
@@ -1551,7 +1551,6 @@ static int optee_probe(struct platform_device *pdev)
 	optee_shm_arg_cache_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
-err_unreg_supp_teedev:
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
 	tee_device_unregister(optee->teedev);
-- 
2.53.0

