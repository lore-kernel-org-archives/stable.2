Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C413388866
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507957; cv=none; b=E7dL+1DK7lCdDZ9c8Lh1ispV5IwYpyXElhFr2eOlALIQLP+YWgiJy4wBQy1GKdzhHyiYw5mxxy2BYHkbh/59XVcw2n53wHp8+Af0346FwZWROoISZwNgAmBMn4AEIRLIFfIx6orPBAtpq4arjuKrKh0Ihxbze7KVJRAevwOPvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507957; c=relaxed/simple;
	bh=jbfRCvEVo3PuhpBjVfzgqvGIah0vGZmzLa1w2pHljmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcT+kibOQnHbphMfEu/3D1wbYbGD1x2I+J0Bk/mB7fZyvRJyG9vSrSojjVLZM65EbKJ2arre+EPOD7FlkQ7hGUwtrGTVOlEvQ+AuRlR1WyKwFMXq1paw4C/vRttEDeSvK/uHq/FxDCZoWfgl0J9TjhSp7isLcbbV96WnAYN6J6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToSssXnG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToSssXnG"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so6832877a12.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507953; x=1788112753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XaxU4abLJpeHOJBbZvBLa6ziYwQVZqgnY4S91187WoU=;
        b=ToSssXnG0mCLd+DAZaIjQ7mA1+ADwbshb61Y2uZNZ++SPJ2hee56NmYUGbezaAaiWL
         dJ6nakiZiBeUuTzTUENt5BZSQKYkXetqoiz6+wsYsUPrbwUCHQUI5KpJ1cFXQdMuFBVK
         gcjZTHH1YR6BEiC9L98+lxhQa7VbHNyIdsuzlQms+g4GBCuwUfwxdgqn3dOwJE7nVIT0
         sichXPr4YJ/+RUep35To4YcZJl6tekPPDVvet4TYy8yL6RPp1qjvs8BaGPCpei7jD/uL
         t4goqf6EQNDaQiFP2iTo7gZ3Iwf0cHNQB0fKlPE7GVbEgZyoFm4Bo1ZkpIJsrmFn2dl0
         RXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507953; x=1788112753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaxU4abLJpeHOJBbZvBLa6ziYwQVZqgnY4S91187WoU=;
        b=Sp3DTtvP3OwSC+N6PPSqHhZJzG3/V3TSm8VpnccmBXX/SMoSE/n6KC596UAWOGYSRi
         lHkt/zC/Yrjcy91oJgHKJfEBML0gTjLY1WeOrALlhuomRh8+omn/gwmmqbMEavu04yca
         0JQOSkqUB394uRsC81HtIeZ6r7EYLfuJge8UcYHPVFs1naAhPYZSpPuJlNuShuVF3O5L
         X8uIycwO5Z8NnnX5mXSoZmKpbdC7h+SBn5tMVd235H52N+by44yWTZEryqXIPOR5ogE0
         wQciqAg1KOEVRYhcNbUKyOuRN1omZ5UEGwA4HDGDyMQv6wYyAHmqNIOM8jgWmK2FXDzL
         OesA==
X-Forwarded-Encrypted: i=1; AHgh+Rqlfq+xUe3ByCltPItQiniWEhrllLdp6nWzFuJ7GBGPmvIQTmcV5dTwUz4+R7wCyxE4uQ6e5iI=@vger.kernel.org
X-Gm-Message-State: AFuF++nmTSV4Jec6TMVVsH7+loKna4u3pEeu4VBNoRr6XSGqmDxKYAAx
	RlpQF1O67hWXjbcRl6W9tMAbgrzNCtm9Mo4MccSMkoHg7j6c7Euh5/kn
X-Gm-Gg: AR+sD10WOe9yoeQAdnZehHliuSbAVqhR46swC89soXA5C+hXPA+fPWNoAs1WKmd/vYB
	mMmkslO+k7yZHoGlblvCRn62eKNIoxDcJq4r49kGUB1UQfYTACzf4LJxYzK2zr0PRZuyU/OYxUQ
	XOrUIQd+32Mju+zi9CE9SKRqUMWA1NBx3krqTdH0wCMEmdBS90K/uODj4fVgtO6pHhre/gFFiQ2
	en8o3qIWxmlgT5fkTjnPoj7SOyyAVKgYGOJ4BuK8sL1CB9mCD9Q9GCn3hSeFF/Y9kF4YTUIv75l
	NiiSUsJ/RadxtXl7FQOZOHg9UZ/FUwfALs0E1hpYCJm1t9gBAjtjL56DR8n6fPC9Ij8nCiZ01Sd
	acFAsZJz/LwUb1mos9tmVmSDlYYrKWdNh98Ly1N++Xpx6CH6sCBFcpMz8idekk2mIR9ftQnflZ7
	ynolVzD4o2jhcrqvFuL85pwv+mD3bktIZgYUjz++w63eOW2IkBE1DbVwIOhmsdi12bQl6ZInAJN
	gJsDAdMAhFleuY9
X-Received: by 2002:a05:6402:321b:b0:69f:c929:b88 with SMTP id 4fb4d7f45d1cf-6a430debb60mr20778691a12.5.1787507952817;
        Sun, 23 Aug 2026 10:59:12 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:9afb:38d7:b606:f380:289e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199cb8sm4153933a12.16.2026.08.23.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:11 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 23 Aug 2026 19:59:03 +0200
Subject: [PATCH v2 3/4] hwmon: chipcap2: enable IRQ processing when
 regulator is already enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-chipcap2_locks-v2-3-6a26c8e9e2fc@gmail.com>
References: <20260823-chipcap2_locks-v2-0-6a26c8e9e2fc@gmail.com>
In-Reply-To: <20260823-chipcap2_locks-v2-0-6a26c8e9e2fc@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787507945; l=1283;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=jbfRCvEVo3PuhpBjVfzgqvGIah0vGZmzLa1w2pHljmU=;
 b=kwvqnY0uG0GB80exLrAofUbi7prlQZmWnSwEK59YHfIqnudHlnvBDtNFttK/K2rgEvp1vUqjj
 8Vfg7za3iyuCxZ4rwuKc4797TshpHKEyMmCTfORZwH1Jg7EMC/yJzQq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

cc2_enable() returns early when the regulator is already enabled.
This can happen if a previous regulator_disable() failed or if the
regulator was configured as always-on.

In this case, process_irqs remains false, causing the ready interrupt
to be ignored. Subsequent operations waiting for the ready completion
then time out.

Set process_irqs before returning when the regulator is already
enabled, so that the driver continues to process ready interrupts.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 15630d1dd90a..57d22d65612c 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -119,8 +119,10 @@ static int cc2_enable(struct cc2_data *data)
 	int ret;
 
 	/* exclusive regulator, check in case a disable failed */
-	if (regulator_is_enabled(data->regulator))
+	if (regulator_is_enabled(data->regulator)) {
+		data->process_irqs = true;
 		return 0;
+	}
 
 	/* clear any pending completion */
 	try_wait_for_completion(&data->complete);

-- 
2.43.0

