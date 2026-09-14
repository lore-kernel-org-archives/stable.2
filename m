Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE241A4FD
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376854; cv=none; b=SQXtc6I2GxfkK+YqVf/lN2hRdTrdoq6Miy1t3mKDRgvCp0Lj12LN9m3rzvVJpN5sJihrSbkMUfLd4nBjIzPKYTNQU1/d1X342TUkeNytJOdtM88gOv8+fS1MSNvoDIdxviSqgQ4we3FFEmVhjLobXSqgDjaEaIQeSUPaDO7V8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376854; c=relaxed/simple;
	bh=FN6z/whQjCJR5PJ9elVbNUyC4Aww99HqmqaHahztQls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbpYULbRk7zKmhJFl13Yha8CYEC2LvPnqEOXLcoWRM0+46HCheHBojnISNQHu9tShVRUFl+TwomhM5HTzCpDRKdFBdMBrVvCIjCWUX/ExDhhCW9v31IzVXwZMLSm8haGGHnUzsg1URRHd4YN31iVqSlE7SYfEz3H0t/frXH63WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWG3Lrso; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWG3Lrso"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8692be1cda4so2424475b3a.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376851; x=1789981651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wvFBiMkRGjwoloZbq9nwDlVvLI1OyRNq467fT53sktU=;
        b=RWG3Lrso78cHLp3V0uvJIbc5+X4QEHaDstNSaqtrl/dx0WaGnuyajTaW214twt0kDc
         PreTvb9aL1TR2rncRrmpmodlAWsqlYEpCVZVO6W/17srI+fffWM7zM9D0YihjVkFEuwm
         IglCZ2zWZnf3HCD79Qmf/BRC2L0Xi/WQecWeajwAtmx63Gyi4vnbs/qHwi+a3Tsn+GmK
         yxknl76WTU3vlGldJRSJaV/EC6Koatk7/8etYt78j5w715BaRQk7//Vh2Fm9CZYOFMH3
         mGEtVkihni7fWlTxzdH8fBCwfQwLfhYUqrcWS0pPvkLWuOQ/rbff/SHQIr2YTQJ+eU6V
         zpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376851; x=1789981651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvFBiMkRGjwoloZbq9nwDlVvLI1OyRNq467fT53sktU=;
        b=tILTzhelMULiW15cXmTh1aT7i+OBJiWzkB7u0RosCZqdCpuCeUfEOL1MI8MXRpUafz
         CGUWSLmbcuYQfRMV7hhM7zxYjJGklT36Tikl6h66YyCcnrScirzJeXotch4Ol4IAmReZ
         wOgSwTfrK+Ca3xzLgYOeU41voaYS7JNwe4X+XiXkRFd8yUpeUs7QZ35NSBpW5q751mta
         U+2sednoP5VNWf6RxKWSXknG4DcvDLK5ONPFo+7BaF1mdg/spRxPc7mdas7ZzeoyznaD
         EX3mkFR/e74YdG0Zj7AuC0Xktqa+akJdouO/+fZXdlxaiv4ErkhyZTRBz62xYffUSce0
         67MQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAKmmXU9C89K0SkrVQQnYBJEzrcdTBpZ3xk/OUU11nOj7pwsAbLChnjRoic5H1G+nSacHW5Lo=@vger.kernel.org
X-Gm-Message-State: AFuF++kOH1VdycaCgXsyHkxsEtl5IqVWb24pdu03hm33dDjuxsD/A5Co
	cRqhYxYVjdSDjdc7Gu1/NZegQ3kV33g/YHI0iojZd0NjJucV4RFxTaPx
X-Gm-Gg: AYBFou3HaLNHK5u2SfuxwTYo8L1HgF9P0SipuD9CVnSYgzP8PC2hE9m+k5o59gJV9J6
	6m4uxOaIuYOhi75BZJYHenEoUl9aBQnnXlpEgqJgc0r7qv1QqtJFxXxJzKS5oirNzwQeXuHMUz9
	TCTJjiwKWk/JakZ+h/NsHaThvZ6zoejJ3ADNoCHwK6o8qbCo6yJeXAZ8qFYHwNpfmpzj8hFI65N
	ikjxoBzNi9c41S3KiNdha5k+eVKWHa5FgdCjG/NKRhbWZ/mjXArpgY0E1zgA2mKyhWwAQgFE/XN
	Qy6PpiLGkS6nZp2ObqCsLY8iUX+3KZC31eBsvDjUWltZ36lkP8qra/7KWo3o5Kaj17Lbw8Eipta
	LmuhAKX3BCS0KIRKtlvurbyNP3n7rtWzS3DzNuWge1JCLvEhICjZfy+Fg6Y5ZrdEXZYGM0G2mGG
	fT99eMPm3uW18Selfn/yYlZ6vu8SD8XGIQEPLhLgbFq9icp0LLYGgDaDk=
X-Received: by 2002:a05:6a00:8d8e:b0:84e:909:ac03 with SMTP id d2e1a72fcca58-86f83b3b22fmr3682395b3a.10.1789376850775;
        Mon, 14 Sep 2026 02:07:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b291c1601sm4365005b3a.31.2026.09.14.02.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:07:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dong Aisheng <aisheng.dong@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wolfram Sang <wsa@kernel.org>,
	Fugang Duan <fugang.duan@nxp.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: imx-lpi2c: release clocks on remove
Date: Mon, 14 Sep 2026 17:07:18 +0800
Message-ID: <20260914090718.1666333-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lpi2c_imx_probe() prepares and enables the controller clocks before
enabling runtime PM. After probe succeeds, clock management is handed
over to the runtime PM callbacks.

However, lpi2c_imx_remove() only disables runtime PM and autosuspend.
It does not ensure that the device is active before teardown or drop
the clock references acquired during probe.

For platforms which do not require clock prepare/unprepare in the
runtime PM callbacks, runtime suspend only disables the clocks, leaving
the prepare references held for the lifetime of the driver. Since the
remove path never unprepares them, these references are leaked when the
driver is unbound.

For platforms which prepare and unprepare clocks during runtime PM, an
unbind while the device is still runtime active can similarly leave
the clock prepare and enable references outstanding.

Resume the device before disabling runtime PM so that the clocks are in
a known enabled and prepared state. Then drop the temporary runtime PM
reference and disable and unprepare the clocks during final teardown.
Mark the device suspended after the hardware resources have been
released.

This issue was found by manual code inspection.

Fixes: 13d6eb20fc79 ("i2c: imx-lpi2c: add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e1a4338bc51e..481950004b2a 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1604,8 +1604,13 @@ static void lpi2c_imx_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&lpi2c_imx->adapter);
 
+	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
+	clk_bulk_disable_unprepare(lpi2c_imx->num_clks, lpi2c_imx->clks);
+	pm_runtime_set_suspended(&pdev->dev);
 }
 
 static int __maybe_unused lpi2c_runtime_suspend(struct device *dev)
-- 
2.43.0

