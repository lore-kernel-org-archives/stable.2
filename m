Received: from mail-pz2-f18.google.com (mail-pz2-f18.google.com [74.125.228.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E644C64C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068876; cv=none; b=Hn9d+2E8fr7hHwJXnO/+xpffNX8DiddnKP1Lh18nX8T1mP695cxjEodBNaXfJOkdG40f1vNa1nWfVVifdFZxP2WpJ2oS8vGabZ0P93wfPAQyhqmBINSFMhz5rfZarUIL9rjM3N3ZGZIy9eRyRPzZxEp55gxbrkFFui7tM2h6lDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068876; c=relaxed/simple;
	bh=QwgutwokZ3b0qwkGY6l4hQt9JqC8neMMcSvmNTqPuqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duktn2b5oMBuvuxWNUPp0MW+puCcmaNlQCoYG8WzhD/LCnRE3AG5qrN3FecSY40sKVBMebq4dVM3Wbf6GRMxD1n1XWcRKQd65M0YpxbffdE4juwDll+E6y1u3bpIirZulUkjwcMaegxmnI+pSrvcYgUyTLnysycMIN0ysYVvkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG6M8SOG; arc=none smtp.client-ip=74.125.228.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG6M8SOG"
Received: by mail-pz2-f18.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso3193985a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790068873; x=1790673673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VhqwyCXWCrR9ZsZI79xSj7TfrvM5uh6vx6A8zPKncw8=;
        b=aG6M8SOGcJZfavB4ZpeKV6X4E1aIu1Wtd1lllaL3XcYPExup7XC/7Sy6LoRQ8MdJ2X
         3TtZSJ74pVC8+2nhy+6T4LML2GvA5wlTyNewTXRXMIbOsEmd1ZvEWTxwfEfBS86MDPNW
         ozz3tMk3iUh7/0NbAAf7TeUKmjYHMBy6PS8FhJnCG86pPTYSADEBvVg9htupuH5NoQ9g
         QXUbY+z+xQ4Th7ezB5NJ3rTYLhw9KWwXRdhsIJZyuzqNJYY16V7dS+Q8Y8ZH/+cFitgD
         Rt/RQvceVtT9RiB0PIg3+V75ZzWBoisY8axXq7rNyk7coRuCaSKSeAigJX5tkfNRfQ/z
         cBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068873; x=1790673673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VhqwyCXWCrR9ZsZI79xSj7TfrvM5uh6vx6A8zPKncw8=;
        b=2wA31HNc/3TtIGBjHGkHBP444Xd1dxIOEI+5OmdYSzpxpniDYQfHIlN3+tOGoTJSX0
         NW8v26yNFhZkN018ZInDdVz/TzbY9xnPyp2G1wB3ZbtOCWga2WSI/lCsFYYDDlgueaWI
         d4AIM1tqt3AAkJzvSRGF7kpcf9HKnaop/MJ0YplKddq4YXHYrNvc9N7JYUkfFx13tZmw
         mjOL5iCpxDxoAH0vD0hRL5Z9iPuQdCYD0nJdsYxYGKjf7SkwPme7LjjkymZXpnSKuZ9L
         rWk9CQsfguhK8cUAl4n8niXXcciJdElBbgEo90nEhixDIoSV03TXa+Ec4ob65pI6gr2Q
         TJwA==
X-Forwarded-Encrypted: i=1; AKwUvBzUOK59CgbA4zx2x1mKUerWas3KjJrFiPdxBHB5plc0d70p2273Bg2l2aufsqTn7hOhaEsW1/I=@vger.kernel.org
X-Gm-Message-State: AFuF++niMKh2GFlCHY1l6q9+cprfdCcfB+TbaUEwlusJbeOQgeHIyLFy
	qXwttxxe6SSpQOLxOnJOBMkpMlJgDbrSDUr80wP4i+JwDaItgaoF+EId
X-Gm-Gg: AYBFou3w+0i4c1D2m0MQZOgwUUr6fRJgq6iyvoLHc9QjuNCn8eIBpSKyLO/FsBrZbHe
	cG1csG0pMuh8m+M8Ixo6N0MEBlV9R2SqKjzSsZXrvV+z/r0JpG6ZJau2W1njtLWb7K3YjcbQQz0
	RDKlngsEmW9wjzsQ3ZJwOeYBx8MYgWf5Z+nB5sOw27QTn95kY7cbyo0UTrTYOShzJM7R6PZUU97
	1PlDUS2xqRVET0hVtcYc0+vommDEsPOajUOQNkMYHH4gcfXgPCNs2DYpdNixCQmGCa0g5SsAQ52
	BL0IAr1dY0Jv5zhDV9YQDC3dqwOix6zr24czWWz9ULD3hfECOMkItOZFPxUWvnqnV0/sb4HSiCJ
	WChdlNrL8Ec56PwpgkXAbU3Pu/wCWZ6ETivmZPExidDZgvRL/Mw/Sh+nAk6Fm6cowml/HUrR/0f
	xF/OowL1yTqNktfoMZPRU9Lw+NnoasCanMA07NBu7uzyDuaIkTJXXhulux+a4pfq8zEhhOGlwCk
	TRusA+7K/EVjBMZm9o=
X-Received: by 2002:a17:90b:2686:b0:39e:4546:fb26 with SMTP id 98e67ed59e1d1-3a072e96de0mr714758a91.0.1790068873149;
        Tue, 22 Sep 2026 02:21:13 -0700 (PDT)
Received: from cfarm424.jing.rocks (cfarm424.jing.rocks. [2600:3c18:e002:2e11::c424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06caf4a73sm899819a91.2.2026.09.22.02.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:21:12 -0700 (PDT)
From: Ridham Khurana <khurana.ridham222@gmail.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	Ridham Khurana <khurana.ridham222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: zynq: fix runtime PM leak on request error path
Date: Tue, 22 Sep 2026 09:20:58 +0000
Message-ID: <20260922092102.1053513-1-khurana.ridham222@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync() leaves the usage counter incremented even when it
fails, and zynq_gpio_request() returns the error without dropping it.

gpiolib does not call ->free() when ->request() fails, so zynq_gpio_free(),
which holds the only matching pm_runtime_put(), never runs. The reference
is leaked and the controller can no longer runtime-suspend, so its clock
stays enabled.

Switch to pm_runtime_resume_and_get(), which only increments the usage
counter on success.

Fixes: 3242ba117e9b ("gpio: Add driver for Zynq GPIO controller")
Cc: stable@vger.kernel.org
Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>
---
Build-tested on arm64 with CONFIG_GPIO_ZYNQ=m. Not tested on Zynq hardware.

 drivers/gpio/gpio-zynq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 15a79d9a2e9e..13e4c5f0e297 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -798,15 +798,7 @@ static int zynq_gpio_runtime_resume(struct device *dev)
 
 static int zynq_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	int ret;
-
-	ret = pm_runtime_get_sync(chip->parent);
-
-	/*
-	 * If the device is already active pm_runtime_get() will return 1 on
-	 * success, but gpio_request still needs to return 0.
-	 */
-	return ret < 0 ? ret : 0;
+	return pm_runtime_resume_and_get(chip->parent);
 }
 
 static void zynq_gpio_free(struct gpio_chip *chip, unsigned int offset)
-- 
2.47.3

