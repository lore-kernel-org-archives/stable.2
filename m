Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5439483BF2
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452399; cv=none; b=a3AnsP+ZbSmfzW7o0IZAK+ESaQwtN+qpPnh3m7WOJNawx43V+Fx+77RBew5IU7Yx5i5k7Z0opD8y+8CmBYUnXMDmsY8vg6T5pVA0yk3zMm8eh6DnQaKjp0rin0jwm3NYk/5MIR/AzI6vex0tftx31gLR/pEu0BNQljaoqIUchcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452399; c=relaxed/simple;
	bh=s7TN/7DaZSQtAFpuMU7K2xGC/Cz7TyKSI0wxoOHf2yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNWK6Us5Ry+CXYIOF8UGdoYzwKj7LfVyf9223mYloyuTJyrFtLteryEbrHF8QCJhEpoWze8v9PBXbTSQP3DAZk8w8JZHzaNWtkzRjkVwFLIuYekH1fVkvEyIY0nwg31u1ykQhOuFYi4Rgs3cKU1vlPr2Ey5Ck+UjolDjfUvGNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPzuBL0V; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPzuBL0V"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so4330462eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452396; x=1792057196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGNeCe/ZoKzEMv+TkjDlhnFjoO5jcCxTWVNHD8J+Fqo=;
        b=JPzuBL0Vr4uPsuTFB3IcHo4A2ZedbzlTH8cuXpjRoTih5uuZc2BmGUPvLbM2Y+45ux
         Ayz5tn7GT3cyfoHUS09yoV+KnXIGuHSEC4DYhu0QojABWXqvAOyGsFYY3cX27bfFboS6
         5+0iuy9XHlTpEXpaj0ZI92h2yqsyA2TTiDAHCxn/ZMjNSjU5qR+R98/p2nYwTFVa8NJb
         IRSNbbEMlQKIHrV+xZRCPxT920GUen6FDXwYWh1PItUF0IyaGUky/FIWaOZrn1fQWGJ7
         0iWhUe/3VpkC43Pccj5YQxsHH/uQdZuoDyV9Z65lFJPjwkcDBLk4KcGW1TRB4xITswl2
         gwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452396; x=1792057196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGNeCe/ZoKzEMv+TkjDlhnFjoO5jcCxTWVNHD8J+Fqo=;
        b=xbGcY5t43djfUrCLGW/amwCRLS2G52fGDBJuOYou7kr76FlW0lAj2IVRfasFn8NBDQ
         L0NrTipfr7vBaPyk2e0SLSHrkpo4vX1uNLhzXSM5PpVVBcWH2ZYue3t3qRynzvjG8akW
         ZxgtgBBpXJTv2EsR3PiYb5dRargqCiK6ho+GxJWTv7Ch3NnoEvDAphxXF7YdMzpbiJGm
         A/yjpP1AGQcMGe/zhPlv2clzTzZrJaB8eRZl9wVP58FiSE2pBQht1WKPX/tf1BhSNxc1
         PCA5V7DaeTW4f0OfW82jLFi+JTuh0ipFJYi6BtJjFS3JUaxRRtOHGa0zVDNZ5XQQq7nF
         yXRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmNWEX/saVJyW/Xyg+a0jP5NuU0O0rm66m+6CFcgVHFPMGw9h36CWlK9GwjCl41wKmEKaACP4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaAWjSDhBzPtkoDVukeMx5f2k2cA+kXvnAslGPkzQGYhfJ9l4Y
	t4fvcaXYrkZkD5WERX8qPnU+FhATrag84E/sM4herBdn7cgc4+sB3tqc7he6AwLyXalKzw==
X-Gm-Gg: AYBFou2HQyHo8mquW7Dm3XaUZp0PxHI32iZZInw/x0QkchRW/nv5FR997IOLhCfVM/0
	48PZoGj/6Ms278/YTXdlIqXR/4DZqbjHhZazTJUAuIiHO4uBb8hvcAFDCwt9fvaDLwzudFdF/6F
	h1ZbfMvlS6CxUoDKSQX34m0cB4uAjo7q0mNBOl2CHfO92oyPvBfA9PqYNAohpjrAoBkJgA/RZ7J
	A8N4X0JqTX3KjtLHqjJ9r0c0SxPQk2cq48SFqp8/+OONpS+jWdnIqR8RDXMf99fGVUG2EFoC8jW
	E1Ynnlu5gywsRZ1ffNBtA5MFieeOMbNbcJJbusqyV1Fp7q1gl3MhYXHvAgm8bGu7ZNb3VfIaYc9
	QDztR8cg+u6qafJGWN9mfXGUXtNut/315mkRWBpFy2hzOoCFUiFOpgo2nxTxRoKLJSL8pGK0ZYF
	T0aHJvdtF2dCs39+EcRFPMtJgkgJHEmZwpp4oDEV3sdJbXkm6lpDYSb2WGjaUq4/z/DcPIuitbD
	toyocjVbR+YFI+M3LrwdRZfH9H01oQ0GRcTA6KLB6ATWZ/iKRB7p9Ao1EvLg/E=
X-Received: by 2002:a05:7301:7187:b0:351:1c52:3869 with SMTP id 5a478bee46e88-3515de76802mr5767814eec.41.1791452395823;
        Thu, 08 Oct 2026 02:39:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm6873252eec.17.2026.10.08.02.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:39:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 08 Oct 2026 02:39:43 -0700
Subject: [PATCH v2 2/2] wifi: carl9170: Revert "carl9170: devres-ing
 hwrng_register usage"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-carl9170-reverts-v2-2-3ecb12089797@gmail.com>
References: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
In-Reply-To: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>, 
 Kalle Valo <kvalo@kernel.org>
Cc: Christian Lamparter <chunkeey@gmail.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e6826

This reverts commit 23de0fa0d2a05ff71c7bc8df9d12c9f23be83f13.

carl9170_usb_disconnect() frees struct ar9170 inside .disconnect()
before devres release (and devres on &ar->udev->dev is not released
on interface unbind), leaving the embedded struct hwrng registered
on rng_list in freed memory. Furthermore, if carl9170_rng_get() fails
in carl9170_register_hwrng(), the HWRNG also remains registered while
ar is freed on the error path. Revert the devres conversion to restore
explicit HWRNG unregistration.

Fixes: 23de0fa0d2a0 ("carl9170: devres-ing hwrng_register usage")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
 drivers/net/wireless/ath/carl9170/main.c     | 29 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index e66e3e2ae952..03a94a5a209b 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -454,6 +454,7 @@ struct ar9170 {
 # define CARL9170_HWRNG_CACHE_SIZE	CARL9170_MAX_CMD_PAYLOAD_LEN
 	struct {
 		struct hwrng rng;
+		bool initialized;
 		char name[30 + 1];
 		u16 cache[CARL9170_HWRNG_CACHE_SIZE / sizeof(u16)];
 		unsigned int cache_idx;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 702b6d113b18..8ca76e9044de 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1545,7 +1545,7 @@ static int carl9170_rng_get(struct ar9170 *ar)
 
 	BUILD_BUG_ON(RB > CARL9170_MAX_CMD_PAYLOAD_LEN);
 
-	if (!IS_ACCEPTING_CMD(ar))
+	if (!IS_ACCEPTING_CMD(ar) || !ar->rng.initialized)
 		return -EAGAIN;
 
 	count = ARRAY_SIZE(ar->rng.cache);
@@ -1591,6 +1591,14 @@ static int carl9170_rng_read(struct hwrng *rng, u32 *data)
 	return sizeof(u16);
 }
 
+static void carl9170_unregister_hwrng(struct ar9170 *ar)
+{
+	if (ar->rng.initialized) {
+		hwrng_unregister(&ar->rng.rng);
+		ar->rng.initialized = false;
+	}
+}
+
 static int carl9170_register_hwrng(struct ar9170 *ar)
 {
 	int err;
@@ -1601,14 +1609,25 @@ static int carl9170_register_hwrng(struct ar9170 *ar)
 	ar->rng.rng.data_read = carl9170_rng_read;
 	ar->rng.rng.priv = (unsigned long)ar;
 
-	err = devm_hwrng_register(&ar->udev->dev, &ar->rng.rng);
+	if (WARN_ON(ar->rng.initialized))
+		return -EALREADY;
+
+	err = hwrng_register(&ar->rng.rng);
 	if (err) {
 		dev_err(&ar->udev->dev, "Failed to register the random "
 			"number generator (%d)\n", err);
 		return err;
 	}
 
-	return carl9170_rng_get(ar);
+	ar->rng.initialized = true;
+
+	err = carl9170_rng_get(ar);
+	if (err) {
+		carl9170_unregister_hwrng(ar);
+		return err;
+	}
+
+	return 0;
 }
 #endif /* CONFIG_CARL9170_HWRNG */
 
@@ -2053,6 +2072,10 @@ void carl9170_unregister(struct ar9170 *ar)
 	}
 #endif /* CONFIG_CARL9170_WPC */
 
+#ifdef CONFIG_CARL9170_HWRNG
+	carl9170_unregister_hwrng(ar);
+#endif /* CONFIG_CARL9170_HWRNG */
+
 	carl9170_cancel_worker(ar);
 	cancel_work_sync(&ar->restart_work);
 

-- 
2.56.0.385.gd3acb90ef8-goog

