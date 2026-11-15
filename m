Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754290;
	b=dz8G8Sqo6JopQPLmHCRtZDC+Mjv4ILMS1brDQewM6BrXducA4wAwJcymu4mhoactxWB+
	 a8EFp+/0J7hDmn4X7sC2mXOW49KvtJ+2uVEFaBnFpPFUKGLeWmWu/R8ULYH4CxO1NzEpx
	 8W1pWVvSFI06INYDxrQdR/NUTasUoO1vVIlfVw+AYD3tpET6rT4GtAKTnNOgqYymSQdY8
	 H0hk6io+Qgf93Rz31IUjstkvzky6/ohvXKeWiBC/kJVcWsezSQv3kjSZiYZvvGtNat1mK
	 4eUy/xWIaD+9sh83+uvE2rgbHxDJeazCrV8sUyzO8ybvBYP+fYOtzWmw5VguqwSEMuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1ZfYp2fVOAsovMDBuZ6IFcNyy3aPY7Zpal+R9H3Fzo8=;
	b=vr89ypLEbH9d4X8QTrxw1kQWN3avrHaQQSGnJZ2uzkg/o320hDgOB/2g3WGQRR/pEuaZ
	 1j48Mn61AdF9HkrTIoqpodiQrWGL1YZEcz2hqRkVFdPJDWbNsmOrE/GvDYCpGmswaMROj
	 e9K+SgbPUXqQUSgi146PnMGCeshDOVvHKreIpQtvUlJvXG9hGIxGVIa/46gpnhI5l8Gh/
	 G/uXpdAw2OHVIPbX9pVUVmEYqiD8+0aqZ+2zWyuqGrsmOb2gHCjqOT42lZn+GqlAxESOK
	 IHnpXWOmrj1sMf/k/2KnWtPvg1Ld6GTUivDitLVhnEAJEBglb42QnKjjFPnn424/FDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9SIedi3;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74920606A31F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74920606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9SIedi3
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1342416a91.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 06:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754290; x=1795359090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ZfYp2fVOAsovMDBuZ6IFcNyy3aPY7Zpal+R9H3Fzo8=;
        b=a9SIedi3C6EHJCF1iS7LlJ9JTawYnDP3geGbLahyMmZbYrRcciEIC5LWSZov4Y4nrU
         EnIp44EKasSUXQILotvPIDflq2Mq2xRA7WmbmxFmA2JccePPAdK1VCbsUeZYE2Ew2LB+
         TB6XSaDhRBVzJ9gGln7vw7Nv8zzVIFRPyiz4CHMSgbpxeq9LTLNDlxY6OCky8pyOcmUW
         xLyt6jqpxoY1DIWqkhsd5j+KsbLfr/7gv/PgfMqSQUxI7V0OTMnpyGgpcf3oT1Ib3E8Y
         zLw18kCeVI9c6ee8KcvdYtGF5d9j+gpTf3L4i9gMPKLqUppZGKUxN/hUmP1e/MRDhLM+
         FZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754290; x=1795359090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZfYp2fVOAsovMDBuZ6IFcNyy3aPY7Zpal+R9H3Fzo8=;
        b=1rtb86it+VU7RPCQQkRS5iq2WEQP2axCtvHLI8ddwD7eKlqoZGNiQpHB0TVWHOLjpm
         1mfNTpJm46wIr99YHVn37CCM3LbPboi5+VDJXsp701Yim7NynuJTjBpFYV7Gqa3PVLbl
         +N+EUtc1tcHnCXEDO6KKCwv/2yrlBV/h1vptjwiyutV6lkw4TA+9QI641HenHQ8Vu+kv
         W3hwpGflqJsAN6pUkin8HSZJvyHo+/14DdqDaD2Mb/aIC6bcoSiusQnH1ZOkDBQCe0wk
         Mja/lp2zfCm5XLI3N38mO3AjtaN69S3h8fxFqjip1URJbyVCa1XgKlVujJYUQ5XzRqdM
         57ug==
X-Forwarded-Encrypted: i=1; AL+hErF2Iy2fBuTo+D6zatenNj80lYsQFCXrHUiDbpO5kMCmEtycxLYBCyuSVAFpB5wb6Z2Oluq0tds=@vger.kernel.org
X-Gm-Message-State: APuU4Z+StMoQzaxbidYnvVFisbNcnpefuulz/jyLILIV6NMtdwwp30f3
	z2gyDocxBURQJtRYclrq4A7Yv9O+HZroSt+6Wv+wvAdDFYinbWlaJonM3Wwi+LRzoTU=
X-Gm-Gg: AYBFou3xj/Vta86wEU/9IFPlHbE62KNYbGQ6NoNc+rTik63GUnD7VGCcfCCQYnpjKN/
	8wCzr5scgSazDO7Uc/bgMo9Sf6klXOv+KLpkYZQXPpGuwPY0TxzndHd97bABs+dc6X8rZlmCoAq
	P4a46ac0ck9vrhpRucTzpEBlgBiZTqr4kRJzCBd8J6ZH4/dLVY+QdoD2FL4ShN5OJOesXGc0u+Q
	BTTht1Tm2ckwrskP+mnxrjTh6HRCNmjyBfTMPDe8lUE12sZuQfAYv69+W3vuquNBrfQHMJok4T9
	lJ4mP/pMSuV8Kp14Q1p2RStaKqNzmDcS86bxPqVeROsyXrehWaSgKiAYj8nnaudVu2xcHmw4RDF
	uNH0BtmMeb7As7TUgge3qFSz6HTJyImL2nUI9nPoJJ8t3lz2WG7B1t+n9pdmiz+pufdvT370iqd
	VzsjlI8jXW2cNhQNdnvzh6IB8anbEYU48dTnU4JH2zwxbcbWx8iXImLO+lETbhI0/6Zpl+wvToX
	Lk0nBDMgWWQkhI7WecjnjyFahcqgKtQucQdR7cQjJertOOHybAMdayapaVQvxIZ71MShxTUR7rO
	9GlHDAKNyDaosoEObwbG9gEkMoct0PChxS9fxT3A+hCiz+Jd
X-Received: by 2002:a17:90b:1650:b0:3b1:8396:ebf8 with SMTP id 98e67ed59e1d1-3b1b0a4fe2emr7626437a91.36.1794754289600;
        Sun, 15 Nov 2026 06:51:29 -0800 (PST)
Received: from localhost.localdomain ([115.76.89.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d32ea0sm17353559a91.15.2026.11.15.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:51:29 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Olivia Mackall <olivia@selenic.com>,
	Deepak Saxena <dsaxena@plexity.net>
Cc: linux-crypto@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwrng: omap - Unregister hwrng before disabling the device on remove
Date: Sun, 15 Nov 2026 21:50:50 +0700
Message-Id: <20261115145050.88427-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Commit 3e75241be808 ("hwrng: drivers - Use device-managed registration
API") switched omap-rng to devm_hwrng_register() and dropped the
hwrng_unregister() call from the start of omap_rng_remove(). Since then
the hwrng is unregistered by devres only after omap_rng_remove() has
returned, i.e. after the device has been runtime suspended and its
runtime PM disabled.

When the omap-rng is the current hwrng, hwrng_unregister() drops the
last reference and schedules cleanup_rng_work(), which calls
omap_rng_cleanup() and in turn omap4_rng_cleanup(). That reads and
writes RNG_CONTROL_REG while the module clock is gated. On a
BeagleBone Black (AM335x) unbinding the driver triggers:

  # echo 48310000.rng > /sys/bus/platform/drivers/omap_rng/unbind
  Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa310014
  Internal error: : 1028 [#1] SMP ARM
  Workqueue: events cleanup_rng_work
  PC is at omap4_rng_cleanup+0x14/0x24
  LR is at cleanup_rng_work+0x30/0x48
  Call trace:
   omap4_rng_cleanup from cleanup_rng_work+0x30/0x48
   cleanup_rng_work from process_scheduled_works+0xf0/0x518
   process_scheduled_works from worker_thread+0x140/0x2f0
   worker_thread from kthread+0xfc/0x134
   kthread from ret_from_fork+0x14/0x28

The worker dies before it completes rng->cleanup_done, so the unbind
also never returns because hwrng_unregister() waits for that
completion. The same window lets the hwrng fill thread call
omap_rng_do_read() on the suspended device.

Restore the original teardown order: register with hwrng_register()
and call hwrng_unregister() first in omap_rng_remove(), while the
device is still powered.

Fixes: 3e75241be808 ("hwrng: drivers - Use device-managed registration API")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
 drivers/char/hw_random/omap-rng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 49d7f021fd31..e5b14ab1b7e4 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -493,7 +493,7 @@ static int omap_rng_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_register;
 
-	ret = devm_hwrng_register(&pdev->dev, &priv->rng);
+	ret = hwrng_register(&priv->rng);
 	if (ret)
 		goto err_register;
 
@@ -520,6 +520,7 @@ static void omap_rng_remove(struct platform_device *pdev)
 {
 	struct omap_rng_dev *priv = platform_get_drvdata(pdev);
 
+	hwrng_unregister(&priv->rng);
 
 	priv->pdata->cleanup(priv);
 
-- 
2.25.1

