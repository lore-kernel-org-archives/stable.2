Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047368;
	b=2pHEPLxhCG/O6ZH3KjCI0I08TGO2cS6kKPhSIpD5V34yQeCWhehmqCUtM+0B7TdfJl7I
	 E8NRpqlZY52TU1MSMnDjPQcz/g7KSTt4XtHFFbXdaLlW0KU3wFS8Y58oJyttJTcMDS/hR
	 IMRTvXN/g/XUu4KRolAh0p6fyWgwtEHtKtpAbS2PZDAdu87fk+n+FQdx2v4apLUwWAhHp
	 iReDQ4PTDAIUjOFnRMD9RZtSC4AyQQUr9ZIfSBgrG1XHWC2K3Ds7i/jtXlDyiN50LonIm
	 PML6gjqfiTVeMKSZvwoz0FKChOlkLyrMQnGZmc7paNLq3anFSx7ni+7wPRGe7dbCc5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047368;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2IPEFODy4kflh9ZdkpOqP+Z5MLguGSwZnQBPSHaKzJk=;
	b=uxYZ/7x0xFi7oWUPWWbsbfKCW0qv+A5Qwq1oXPZiqNZTmMmqBMnJvsth2ZsxhfoGdGv4
	 IB6T43l5+gTwIB76/i4tu1iWt4oIwau0e2Cy5nQ9TpMK55h0/FcXf24JyPmlm4Hfz9j4a
	 KbN4ujmBXIPr8/HBfC/Xyx9UAVc5mquxpetaK3B975B9mrl7WSq0pw5uQzIn9AC70cla7
	 e+l1hwJL1AW48dAgNOMgH8anJ4JXxS0+HF33K0zAIXoVcE46io+Mvtk4jnZnFry07EjKM
	 ztF/MHK46Atvj3rivHa9iRj5PHna5pbtZpRqCCnecJjPeWx2YUjz9LnYh47KS2uFL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASeDOsWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212B606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASeDOsWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412421F0089F;
	Sat,  7 Nov 2026 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047367;
	bh=2IPEFODy4kflh9ZdkpOqP+Z5MLguGSwZnQBPSHaKzJk=;
	h=From:To:Cc:Subject:Date;
	b=ASeDOsWbO8bWqt/c2t/r1p4RLf3EKB9wTsOSVy/MMa9nF1YHUeYIK3Qmto5SIBPss
	 Y11dRXp5lxhkBtUcCkKD8MVz+iYQ+AHFdPgSPiVgl0XhCfZkSBo5uTIdMSHVTQ48sJ
	 CvWEgSKRbya7icXOTw0emQRZvXMxAv1RaZ5JjVqeHM05MF9dhUcH+SSpnHdaDNCwbQ
	 lT6EAloyR+lLj0b72dKuZL8ujYfBgOIS8oSY4YDJ5AJhypNXJrfIk+vZjfR17gyZX3
	 d8hLEiThtfK916YLt6Xa55I8IziQJxECqrJbv43e43hEfZILUFH3+mm2O7WBNUucMY
	 rP2G0IBpoozjQ==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-des - fix crypto engine cleanup" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:26 -0500
Message-ID: <20261107052926-failed-6.6-5d69ed4cd4f9@kernel.org>
X-Mailer: git-send-email 2.53.0
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
git cherry-pick -x 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052926-failed-6.6-5d69ed4cd4f9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 12 Sep 2026 22:41:16 +0800
Subject: [PATCH] crypto: omap-des - fix crypto engine cleanup

omap_des_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: f1b77aaca85a ("crypto: omap-des - Integrate with the crypto engine framework")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 3b7104cb4487b..4b5a8d13f505e 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1082,6 +1082,8 @@ static void omap_des_remove(struct platform_device *pdev)
 
 	omap_des_unregister_algs(dd->pdata);
 
+	crypto_engine_exit(dd->engine);
+
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.53.0




