Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4EB542EED
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906513; cv=none; b=lZtBCccrEeppIc4KwQrppYmFW7fqIa3wbdcyJQ9zPrj5CyzMR8Ib4NsMxfli/Mzw7M/TwVLum5MiTuqOP8meaUcpBWd2HBgwUTrcAhHND6cRrlbEI/3iKfEPSjEp+n7owATuh/Q3XP1QdrzrDO5UY/dI+Te6Dyxefm7Nyviiako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906513; c=relaxed/simple;
	bh=eEncPETdG+btE4hHADl6X+MPyj5yF9pkYOwyYldL40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJiM6vfPA16OTilOE/NmjfEjNYfZqcJvr+OuyXzLuDYdiXWMKO8Vs8/8YAHlL4/xYr1CRbwF7InW+X1QneMAKQDDJ4jsR5MZxW52Wx73Fes3fj6N4bK3KSXzHqq8zSsgK2iP7eXt9XWB6bjeb1ncKKP+OUT5klwdKQAIT/LUM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9cn6d+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9cn6d+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E211F00893;
	Tue, 13 Oct 2026 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906511;
	bh=MWK0GC/z66VaZePB1RFe2O1Nu61Z52gxUm7fwpUhawM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9cn6d+RVUkZDnv9jGp4vRuj60DhHuKZs6+F3hM+OuD5d7yZ9eGCKhDRTcaOrOEPq
	 BdkrG1MZ0RmEtPrDUkDPshD/0nfJyvWco6semyd7OHrDJa54OL8kHrSpiaJol522iv
	 CEHurSVE8uvplTAiEM31K6ydwaffJb7X0cw93NCSuAvkiq/kTo74FVVoZFFYKaQMH5
	 t0kbs2Jz4rfunzoT1lLVdXG8jAxNHUDweZ5e2bWaokX5wDa6AfZcYleoI3YO7hSHda
	 I373zMRfohub5W+COWry7HJzfq2Qd51AoKkgGv2qBu3KTxCuKTE+n255t/UbvHdK3d
	 FqFTz5FELMFZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shao-Fu Chen <shf.chen@mediatek.com>,
	Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] optee: register TEE devices only once fully initialized
Date: Tue, 13 Oct 2026 11:48:30 -0400
Message-ID: <20261013154808.313464-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101248-triumph-stingray-457f@gregkh>
References: <2026101248-triumph-stingray-457f@gregkh>
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
[ sashal: Adapted the fix to the existing optee_probe() implementation using optee_remove() for cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 50c0d839fe751..a1bb5652d9081 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -707,14 +707,6 @@ static int optee_probe(struct platform_device *pdev)
 	}
 	optee->supp_teedev = teedev;
 
-	rc = tee_device_register(optee->teedev);
-	if (rc)
-		goto err;
-
-	rc = tee_device_register(optee->supp_teedev);
-	if (rc)
-		goto err;
-
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
 	optee_wait_queue_init(&optee->wait_queue);
@@ -744,14 +736,24 @@ static int optee_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, optee);
 
+	rc = tee_device_register(optee->teedev);
+	if (rc)
+		goto err_remove;
+
+	rc = tee_device_register(optee->supp_teedev);
+	if (rc)
+		goto err_remove;
+
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
-	if (rc) {
-		optee_remove(pdev);
-		return rc;
-	}
+	if (rc)
+		goto err_remove;
 
 	pr_info("initialized driver\n");
 	return 0;
+
+err_remove:
+	optee_remove(pdev);
+	return rc;
 err:
 	if (optee) {
 		/*
-- 
2.53.0

