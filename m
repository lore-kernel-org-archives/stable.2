Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114C41DDEA
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377358; cv=none; b=mDzX/igD0khjSfE9LlYenp6sBtsWWsQjy8+nHRkTJTP2/3GSK7awu/DlLXW8+Kz67+mDDM07hNlME6KyRAvm/RNa0uMhGthV45hzq2IPKs5YiuXVw5B+JZPwYI+5v+VJKpopFbOQi9SDwUmSKvgOQOiNNTuSORC7EoVPpXXpZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377358; c=relaxed/simple;
	bh=MEXHfGz4HzaBznx53art+ix5nkCHygSVvo4IcvkNi3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geO4quI+MIE6s/634Uue+6bxYBXKMqYxX+uACdg2Jf3uur3Hm89StUcmEE200F8R/BsZjiIPLnVBugqTlz3grlTMt/feWRgJRTgIsvsoZZ2jR+uDdSnMqADpFQT6tT/RBpIyNQbd0E9ImnIWFSVh3gYXmRZuoh+vFsGdCdhIGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRmHgq2X; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRmHgq2X"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8692be1cda4so2429994b3a.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789377356; x=1789982156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=phiJHwRkepb3+2i8AgNorxLeG3jmpMTw91eiZ14pBcE=;
        b=HRmHgq2X2Z/EGgksdvngFTFse1pON+2eV9Gc9/q8ewPiQfwvTa7DX2O+/bz7iF2Hd1
         eEjYv++yMszZdUD5cvJqpvSGl3vsrDOSxAC+DJqMNrVi59gMlNKZJCURq4m04zEftfue
         EbjJRxWBM8xZ0khbbm4Uib5IHJifQXeB2GgK/BrBO2jWruzHjM63qBNbOxjUqxScaoR0
         39pLUJQJYdjwinNeRAdG93ITFiUxcsZHuYRzNW/c2oBEB8Fkv2IFRrxXSgNlbf98+DIK
         c69jQzR7Cv4E8AYwA4agMhJpxlrY+KpgUTquhNOAd//f3Sb3WEdnI84lmIocNOtTQbCe
         uhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789377356; x=1789982156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phiJHwRkepb3+2i8AgNorxLeG3jmpMTw91eiZ14pBcE=;
        b=CV44fW3tktmASaZr887tpHFK/x135woiVO5+O5TtB5QM6xPzHbugdLnsX12ncR4hrA
         lSXp96qQ02nCLzJUUSn2NUuc9/x6/lRCVSPFw0tmFb7V2jQP09jf4wDPlo3GVUp5y+K7
         ca2/WzwB0DTsbrO9pX5AXRLDpg8Ql/UCUi89wrd841vCJzKB8CfQZ2M+usUjYHtW1FPz
         N/0gOQJ8BYNuG5/ZySVNT+RzOhdu8YpwW5O9cCgBKCiHBBA4DYLPf9ayoHIDNWyWOsUA
         grRO4mwQ9vjbLSS8t9tImKoXt/YUx6fpkuMAGXrzLz9iaDokRfjrKxC+SspPHwVx3M/W
         QgVw==
X-Forwarded-Encrypted: i=1; AKwUvByUmI9N3Q9+E4N63SyTj/C66hQXSUZTZVw2XV2kMSfd3cU3ElPbmUB99ZDz3fhibZ8ObtlEMss=@vger.kernel.org
X-Gm-Message-State: AFuF++kiyPyZNJOwPw0SbNWFnmBvIlCylJqir9XbAO+R3Fhe1U98+dSg
	GndR79YvJ5+glPAKbWLKZpDhYSPFlg4pE92BhXhiK8MEAecwUj4wh59o
X-Gm-Gg: AYBFou05HHTYif9DBF6P7oYF8oxwPZzgo/AZBok9EXhaqueGepawnuSRaPv8t6UcFNX
	eECtUTy8/KjWOENEbgNRhJg4m0P77j6WbvwqIx7BtL6Y6hUYVrAYgQvodCxYrjBhoc6vzB2kdHs
	XKO+VBhtiACSarhirpIyYdhMYtBIDVvdj7PQaOgij5dzxj6kdZtN/iQd62DvSJkSigVtQeAma7V
	11ZIgIruCPiTZ4I6lCDGIpGomQEJO5fOambjWoqKmvb+KmEVf9JdnirxjMqumCQ9wKTiTu9KnQ+
	fyEGU1km0bkImJTXTJHAKZ3u6gY3oOxpdP8D5zvJJ3xIj11L3daEC+Yq9I+5sb/9LfjwhXfX11h
	/a0ScFZnncOXfLZs0gSlLu161nqhhqfNG4XCFvY0/dwM7WdYMJXuOTQ/twuM8s8ZJhVodm9f+4L
	dLqKKsunrAQTUwNcXmASyiEWy4mDBe2I+DW9edbgnNL/BjuTVCNmHO7Q==
X-Received: by 2002:a05:6a00:4288:b0:845:c694:5c3d with SMTP id d2e1a72fcca58-86f83346552mr3922964b3a.1.1789377355574;
        Mon, 14 Sep 2026 02:15:55 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b287c0762sm4480614b3a.13.2026.09.14.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:15:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Gao Pan <b54642@freescale.com>,
	Fugang Duan <B38611@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: imx: disable autosuspend on remove
Date: Mon, 14 Sep 2026 17:15:44 +0800
Message-ID: <20260914091544.1667137-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_imx_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
set therefore leaves the runtime PM state incompletely cleaned up after
the driver is unbound.

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the performance")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 19ec056b00af..4dc3df6a41a4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1920,6 +1920,7 @@ static void i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int i2c_imx_runtime_suspend(struct device *dev)
-- 
2.43.0

