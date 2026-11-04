Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807906;
	b=iuAcu4fqMGun9Fq0fbtkrRxGOWd9K6hvCVJ9zTgyww5ZDbZFaGgEARFWxkQU+uXeo6Js
	 84EePAJorwlWBDN/uTINc8CAP5hLgSdxuz8u2Cf96Nv2RKv4PaCc3tnDtdJ0NiS5QYfUL
	 quTL3XfY6dnSOIqwDD4jEDEytOJ8TwKrgfWwUoU/IPyuSgRXKyqox5YBvUu0vuEOSAE/n
	 0AJpSFd+s34Nx1ZzwuUbzitSzL1qdSGCioLr7SNjfQVHUeZgosuhel1IDm2BGYKlDnmTk
	 lPmKOyC0KCQK6FH5yWsNtw4X7nmLpXgSir0R2dKAaHb3sRYkjmqeTcf9w41J+PwQB+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807906;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3QbZH7irDf/PQ11+cahlSP9+Bmain9c/0kalJfMpADU=;
	b=B6cgkJ21scMnRDheDqq4T4Pg3uCNqwt9snbjNPPPDJAzU4yYZzh42TpWi7n+Zs7mcFvn
	 Wy/pKkVJ+psxhIa8N4mLf4jGWnKJHnOH5LToLQcukmV/LcXx1uS5upuw1VI0cj/OUlTyG
	 HTQls7kdKl9P2P+E7o6OUeOSDs2iLJ9iVqy4jtYkLrAAm3ihFES58B0x3Rvd3dDtYJApF
	 VS09V4Mz6aRKwEFdWCGTVydwzFXLmQb6xkWPil8WIzgyQIMuBntR3fxJZnPHKlxIc7OVh
	 g25//DyxGT68j9WZm3a8s8PxgFeuCnhAAipDI9tI2donH9HrjBaz/iVf+YIpgJRNtAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3DqXb7E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AA606A332
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3DqXb7E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF081F000C1;
	Wed,  4 Nov 2026 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807905;
	bh=3QbZH7irDf/PQ11+cahlSP9+Bmain9c/0kalJfMpADU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L3DqXb7EX/DCE8ViXX3uEqcxsXf1xoLtIET0x3FjQ3Qzp5IPuVaKmZEQ4saU7S7uK
	 +jr+gpAVkuy0m5CSMfzSPJTNrBybpjGz3Hp+T1bQjnMTjQvBTjUX+XakUIUh90MDx9
	 a0DfHOp9x4r5mj54QkB4LPI1y4ny22ivGukl3Dp0dmEjNUhlATnSNHPNZQxkd0WeEO
	 oysH7HHYS675JPYhYLMFh8O1Ul3PPkCIR1tYl0nQL5upDpMS5p/5hDZCB576XENXz1
	 aaGDdOQtxVEpeyh8mI3WfgzS/0nVe9FvKpVxg1OazVt5j918YCAY7vzkolYuEnKvXG
	 D3+J5RAZwl7ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] pps: change pps_gen_class to a const struct
Date: Wed,  4 Nov 2026 10:58:22 -0500
Message-ID: <20261104155729.3918440-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110401-glitch-riveting-80d2@gregkh>
References: <2026110401-glitch-riveting-80d2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jori Koolstra <jkoolstra@xs4all.nl>

[ Upstream commit 4dc0c899b14c3ea2c9b5f42b523301040d1c8100 ]

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Change pps_gen_class to be a const struct class and drop the
class_create() call.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Link: https://patch.msgid.link/20260302142436.3292766-1-jkoolstra@xs4all.nl
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: d19552611cb2 ("pps: generators: fix use-after-free when closing a removed device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pps/generators/pps_gen.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
index 5b8bb454913cd..e064ff32c9cd9 100644
--- a/drivers/pps/generators/pps_gen.c
+++ b/drivers/pps/generators/pps_gen.c
@@ -26,7 +26,10 @@
  */
 
 static dev_t pps_gen_devt;
-static struct class *pps_gen_class;
+static const struct class pps_gen_class = {
+	.name		= "pps-gen",
+	.dev_groups	= pps_gen_groups
+};
 
 static DEFINE_IDA(pps_gen_ida);
 
@@ -183,7 +186,7 @@ static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
 				MAJOR(pps_gen_devt), pps_gen->id);
 		goto free_ida;
 	}
-	pps_gen->dev = device_create(pps_gen_class, pps_gen->info->parent, devt,
+	pps_gen->dev = device_create(&pps_gen_class, pps_gen->info->parent, devt,
 				     pps_gen, "pps-gen%d", pps_gen->id);
 	if (IS_ERR(pps_gen->dev)) {
 		err = PTR_ERR(pps_gen->dev);
@@ -207,7 +210,7 @@ static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
 static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
 {
 	pr_debug("unregistering pps-gen%d\n", pps_gen->id);
-	device_destroy(pps_gen_class, pps_gen->dev->devt);
+	device_destroy(&pps_gen_class, pps_gen->dev->devt);
 }
 
 /*
@@ -307,7 +310,7 @@ EXPORT_SYMBOL(pps_gen_event);
 
 static void __exit pps_gen_exit(void)
 {
-	class_destroy(pps_gen_class);
+	class_unregister(&pps_gen_class);
 	unregister_chrdev_region(pps_gen_devt, PPS_GEN_MAX_SOURCES);
 }
 
@@ -315,12 +318,11 @@ static int __init pps_gen_init(void)
 {
 	int err;
 
-	pps_gen_class = class_create("pps-gen");
-	if (IS_ERR(pps_gen_class)) {
-		pr_err("failed to allocate class\n");
-		return PTR_ERR(pps_gen_class);
+	err = class_register(&pps_gen_class);
+	if (err) {
+		pr_err("failed to register class\n");
+		return err;
 	}
-	pps_gen_class->dev_groups = pps_gen_groups;
 
 	err = alloc_chrdev_region(&pps_gen_devt, 0,
 					PPS_GEN_MAX_SOURCES, "pps-gen");
@@ -332,7 +334,7 @@ static int __init pps_gen_init(void)
 	return 0;
 
 remove_class:
-	class_destroy(pps_gen_class);
+	class_unregister(&pps_gen_class);
 	return err;
 }
 
-- 
2.53.0

