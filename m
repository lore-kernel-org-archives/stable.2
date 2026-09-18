Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB704E2F33
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729527; cv=none; b=Swpw3/Cm2oLG0gW9px8Y7l7fGpAcPmYBO3VQvqAAtweqbeIrY5ljNi0K12KgvWTNhmyiNPaPISunkrHYJwc8ckuLNqAYV7jVKCqef8EG0hNa+NSJXFSxxARRCRbyX9K2gq1mhpykQ2ZzOFgIcLRvRJsegzJak/XFwaBIXg5Th6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729527; c=relaxed/simple;
	bh=hUcoqwH/HxxZ783HKyQpgJVCFgXZ5I76kDE2zpLnBQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqQ288LrPI8Sz5L53TB1eydOfjeD8MOcVBJgT7mPNQPIM/qNVzsFmmLdRQ28K25zsQh4Msavc0G+8DEqwSmXeaBN8DDkBgo4idAzaj2ClNv3Nl1ymoNYLXE67dguNoCiQ9Rv9Dydv3UQMO2L5M4SNtllj0o+aT6ua//vQEsx7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLi67qLz; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLi67qLz"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f38so5401835ad.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789729517; x=1790334317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Df5rt+V5n08gio2qwrmwg+kssDbj2qjq7f0a+gBkW+g=;
        b=QLi67qLzXQ85mrbI2AI/wwldKikbDnMDDPtKdofJ77bEJvOxOyQPrdy7YfXX6+RQfl
         nIPEHws/7O9CHcvAeEgTHyA0OFeZHLKtITCQfdWxc5oQwRggl/sK5sNjv5d18pc3+CzA
         V9PMqlqvPmbCGzn9VySQJRjD3tK3d4qs40tBkbNWePhML8IQsOyOJf/ijHwT+/n0ESkM
         AxBE9uw3EBGiOVkPgbLwP41PqHNhz8KbJ0iMhMPu1HnNk5DxlHNKlQNJte8BFPoOmoCM
         IK2eYCRoqDUCBI4C5g0MF1v7fDWNZGLiy+OwJZU2/SO54VRPi8AmsdOAQhHK4YwuMM3i
         LkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789729517; x=1790334317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Df5rt+V5n08gio2qwrmwg+kssDbj2qjq7f0a+gBkW+g=;
        b=0QBLXyG/hVTd+MHcHnIFC9fPw0dOsnOtEESOvHEsWHuB70DBLD4hI70pL91Eq4m7Aw
         BtY8JsUqqlpb7VU10L9gQPxTXjsZ5mX2UYuGEDc43gQgQDJfSSvT8n3oPRr0XOidGMdM
         CMIK5CvdzBiC8bLlnZvD4zFP4Vfr4TfTkM3eYhhxO9aprHbtMGPWzA3p9erCrOubOkPb
         wKRK+Q4so43yZRVNkCqPLD7lycNCFFT0frkrCUGFiW32Izw1z2hlWXJ8DafdAL/XF+GR
         oOGi8DFYZXgtRj93A+VjSEiL4pa3glRL438/LsjdLacydxJ0hAzt/39Rosmd6xLhJtqi
         refQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlZOz57161Cwsu7pWlNxZqZ8whb7yI2RcG4SxkbJhhwCIU3bJG6Hiptk209g3KZeo9rnfM8c4=@vger.kernel.org
X-Gm-Message-State: AFuF++nMVVrXfet5/IEy2kyVp2kk3+GbqtXDWuOQfrirT80Kpl50iGx9
	MOzc5SbFo5C2dUqbR6zn//iQkTlXX0odObx/NI1kLtkV4cLr5Lh41O+rs0W9n6/i
X-Gm-Gg: AYBFou31QTK+0DG4pYelCK01z0IjZYklKbsEIrM4ERzCQHZCLfi38VFpemQIKkzh3Da
	FD/tQW8ANClySG1xdGewY+cNQZzo2AH+HLwwpdV5FsqHABKTZv7E8jpSSYu774FLLQuZCJn5JIe
	Nxzhas5XeBZEzSMSXd0qk3FTjIOAggZIoezMtAWoXb41YNIND3imnqsUvCiAGRLseAPIJ9d8U6T
	9vEcomQTs9fNLV+qIrNjAahUMjbBjJYkh03tkZ7+pe5YLKRo4fDHFGWsPo+p2eIT23ym4am1nnY
	mZ0FpADV3CnNBjR7/xyqQTJYeD08zS7G3e+Kt4mYVn7HgUnvK2SVQR5kUeyDt4qQuuEDtEj+qOr
	lmtXa71kjNQcsu5JolXDPUoymJzkV79yNyrs3H/euDZe3zROCxDcpVlkzTQazKd3rBhVZNp/1/x
	ADR9Hsro1MpOBcQCmudBXaC6cTqyAeAzOlSjepoP7TMMlceJqydzu1LWbXefWxXWX7e/LxQ4ehI
	Y1f8bkCMQH5BtNwYfA=
X-Received: by 2002:a17:903:3d06:b0:2dd:ad73:5b73 with SMTP id d9443c01a7336-2ddb1d5bd18mr43767255ad.35.1789729516398;
        Fri, 18 Sep 2026 04:05:16 -0700 (PDT)
Received: from kernel ([103.219.206.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c28180a4dsm4721501eec.0.2026.09.18.04.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:05:15 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: clabbe@baylibre.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: amlogic: Fix IRQ handler return value and fallthrough logic
Date: Fri, 18 Sep 2026 16:35:04 +0530
Message-ID: <20260918110504.7207-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In meson_irq_handler(), when an interrupt matches a flow but the status
register is empty, the driver prints an error but doesn't return. It
falls through the loop and incorrectly prints an `unknown irq` message.

Fix this by returning immediately. For empty status registers, return
IRQ_NONE instead of IRQ_HANDLED to avoid masking spurious interrupts and
allow the kernel to detect interrupt storms. Also use
dev_err_ratelimited() to prevent console lockups during an interrupt
storm.

Additionally, the handler return IRQ_HANDLED for genuinely unknown
interrupts. Return IRQ_NONE instead for unhandled interrupts.

Cc: stable@vger.kernel.org
Fixes: 48fe583fe5417 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
I have addressed the IRQ specific issues in this v2. The other
pre-existing issues mentioned by Sashiko are already addressed in my
separate patch.

Changes in v2:
- Return IRQ_NONE instead of IRQ_HANDLED when status register is empty
  to avoid masking spurious interrupts.
- Use dev_err_ratelimited() to prevent console lockups.

 drivers/crypto/amlogic/amlogic-gxl-core.c | 38 ++++++++++-------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 169c6eeb51e5..d5d84524c110 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -37,12 +37,13 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
 				complete(&mc->chanlist[flow].complete);
 				return IRQ_HANDLED;
 			}
-			dev_err(mc->dev, "%s %d Got irq for flow %d but ctrl is empty\n", __func__, irq, flow);
+			dev_err_ratelimited(mc->dev, "%s %d Got irq for flow %d but ctrl is empty\n", __func__, irq, flow);
+			return IRQ_NONE;
 		}
 	}
 
-	dev_err(mc->dev, "%s %d from unknown irq\n", __func__, irq);
-	return IRQ_HANDLED;
+	dev_err_ratelimited(mc->dev, "%s %d from unknown irq\n", __func__, irq);
+	return IRQ_NONE;
 }
 
 static struct meson_alg_template mc_algs[] = {
@@ -243,34 +244,30 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->base))
 		return PTR_ERR(mc->base);
 
-	mc->busclk = devm_clk_get(&pdev->dev, "blkmv");
+	mc->busclk = devm_clk_get_enabled(&pdev->dev, "blkmv");
 	if (IS_ERR(mc->busclk)) {
 		err = PTR_ERR(mc->busclk);
-		dev_err(&pdev->dev, "Cannot get core clock err=%d\n", err);
+		dev_err(&pdev->dev, "Cannot get/enable core clock err=%d\n", err);
 		return err;
 	}
 
+	err = meson_allocate_chanlist(mc);
+	if (err)
+		return err;
+
 	for (i = 0; i < MAXFLOW; i++) {
 		mc->irqs[i] = platform_get_irq(pdev, i);
-		if (mc->irqs[i] < 0)
-			return mc->irqs[i];
+		if (mc->irqs[i] < 0) {
+			err = mc->irqs[i];
+			goto error_chanlist;
+		}
 
 		err = devm_request_irq(&pdev->dev, mc->irqs[i], meson_irq_handler, 0,
 				       "gxl-crypto", mc);
 		if (err < 0)
-			return err;
-	}
-
-	err = clk_prepare_enable(mc->busclk);
-	if (err != 0) {
-		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
-		return err;
+			goto error_chanlist;
 	}
 
-	err = meson_allocate_chanlist(mc);
-	if (err)
-		goto error_flow;
-
 	err = meson_register_algs(mc);
 	if (err)
 		goto error_alg;
@@ -289,9 +286,8 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	return 0;
 error_alg:
 	meson_unregister_algs(mc);
+error_chanlist:
 	meson_free_chanlist(mc, MAXFLOW - 1);
-error_flow:
-	clk_disable_unprepare(mc->busclk);
 	return err;
 }
 
@@ -306,8 +302,6 @@ static void meson_crypto_remove(struct platform_device *pdev)
 	meson_unregister_algs(mc);
 
 	meson_free_chanlist(mc, MAXFLOW - 1);
-
-	clk_disable_unprepare(mc->busclk);
 }
 
 static const struct of_device_id meson_crypto_of_match_table[] = {
-- 
2.53.0

