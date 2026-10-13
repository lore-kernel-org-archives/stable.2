Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA851AFC4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907187; cv=none; b=n4DKlrPBbnWB3AFe0CLfNA81xdxUJ8/CldotLcYs6GCmLT+sbWfdX7Gl6iqPbZpItkxNYJg/BtR0qiOcwr3FyJ3Box965vhxKV1KVj5PvA9c/sBZJ7D77ZhC66sqwpBHXg1eoadREcLCU31oGF4FB5rCP/l0eOePeNhshTo2G8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907187; c=relaxed/simple;
	bh=RvaXYm8wZ2JDfhwrQXjn11ARtE9n/OPJ0874z6wIv+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl1s4D+AG7gvItq6YYtT8qlzb+6mlPkzSetwf1B6jiFx7nhR0X7vvtgSmt3oy7F549p2U0hcuvoLweP/dVR7qwAfNFMDbGwrgAyLRW5hMjylG06DidTmWweJa17B8M4RHXTiw+AypNJwvzTQvP5pQuiWPhsb4rZEoPvdukW2hm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/VhUbFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/VhUbFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469FD1F000FF;
	Tue, 13 Oct 2026 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907185;
	bh=Dj5MzxactpzSA6jqBaLbnyomZMH/uFrMHHwNiz2caHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/VhUbFG+QVKQnRE+5miUyctjx2yy2ucQzCqBKFPUG/2/YfKemxuJRbs9OFgP4gbv
	 Pvv+zo/Nnm1HX6vm1IeBqrroUAbeIq1wG+DBc8TEip3C1JUSxjHChH5Aagj/uyf/3V
	 jIUODjJRfSo/wWYI/HKHoMInJC0bjHg38EaCWelB5CE7e77xDtHF8rNPKMvDRcH8EC
	 9Ac8rp8rjbypMmjtAm6y3NFhR5P95BuMaJHXaxACmul40p9g9Jb5l0b5ngGAkFoSl3
	 UfArJsR5Ga3XToygVEHH9DakdTuphohzKNsg8aALrIh0xt3G60624v3NKDpvLJyzHg
	 0TANr1h20U34g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shao-Fu Chen <shf.chen@mediatek.com>,
	Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] optee: register TEE devices only once fully initialized
Date: Tue, 13 Oct 2026 11:59:44 -0400
Message-ID: <20261013155927.379947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101249-squiggle-overprice-f654@gregkh>
References: <2026101249-squiggle-overprice-f654@gregkh>
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
[ sashal: adapted separate FF-A and SMC probe changes to the unified optee_probe() with optee_remove() cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 6ea80add7378f..f45883476b122 100644
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

