Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFD332623
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371508; cv=none; b=ZPcDO4Isjdjht5gyd3E0edlOOBnRa7g0tfp3Qu6OMen1VNzVRdnc1WO9B9KfXN7eKsAQyq/N8eahH74r488RbmjfbQTk0WC6/khRdnIfceJI9sjlxmDRXXCzbB/+y53sEhlTl/g+Dih8eTPcQkb7iNhoNgRQZU9DwgLq7+5o+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371508; c=relaxed/simple;
	bh=cT3Hg/8SGJkDy7HTaTfodhduHUgAnrmxwuYSn134zgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JdUB2QiXYxddq7ZkO5pA/sJWwHg3fOrPp79PPkDJYBgG23vIMJb4BUK//R/Qi1q6BZFW+weMmFBA8O+EsR8Dq8UOm+N1MnUXrvxPy5Dek6+IPAXXtHlEEqWMWRVQFTgJqHr20F0GFbQGbanvkoVxCE6dTpJQVqGNaN356L/id54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIzVGfS3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIzVGfS3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c7f1db3ad4so9701205ad.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782371505; x=1782976305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YyhtrgUl91lDu8t83AeqgjUXFN0xPavBjbeVdqHjXo8=;
        b=EIzVGfS3Vgp01GpDCCjL34+w9eE+VKGTf69sZEXL/HVT52IleoJ06zHIwEwUOQV2Xx
         I7LecKvQ/aLl2n/r7rXTB86seAZLD3wSogtPbsQ1RfIo4nAHQzX8GRVJ8tZiC+grlOuO
         /ZZNsJzPrer7X0gzLfGc8X7as8e0eRddDqDxln1OM8Ax+GU34sc6AVAGWvOGKWTMqrmy
         YPZYM0Hsrakc/R47oqoKzdBMp5td68zL1qCe/jN5KyMwtRcJN7Sj88U0jDjmetgO0tiG
         7r/RBgBe8eZTXO5CMFlks70NF4L9RoUohlZGc+wZVfXZqhcB4vyLnLI/kUjzX/QQaf9k
         eQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782371505; x=1782976305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyhtrgUl91lDu8t83AeqgjUXFN0xPavBjbeVdqHjXo8=;
        b=LD/CrWak9lMkcTlRgeQ1Jxi14CAyDTEsISXsZgfKorxqwnhGoCMsfUOf+pPNpWcuR0
         UJdnw8ezRu30rkRdY5AB1IGXrmQtlL32g4U1nv84D+e9ELZj7RUCHf9VRCFkMM/Hooai
         GTcKcWNtUCSuoZVC7jR0z/yu3g/v+OHY9TLMviZu5JZIUOhPfUr4Hak3YQGw8wDL43Oj
         y32cOdLZ3+Uz39WMFiNH+fa5GzFWIGRrB9LrgK8PdT+RyXukN35rG0j03XridwsO7vBg
         DQ4TFVMK1MVatHqzcxgwSNxo9Jcm2BXiZp0VzR/FVLVLFuikl5kIYHYxSxSa4kvtvj5T
         SQJA==
X-Forwarded-Encrypted: i=1; AHgh+Roc1fFdPA2XO+pCklvXTmDu/dU5JebraNwlGhMMt38HUzCWFgCBdiVnGK2a+SFs7pNnwo+shx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJneelWNLHzpXrglShC5ijdiehUe/uD4NBn/fER/x76EU/Hf0s
	w7nMO2VW9zS5ef2cRzoXJJcwnfOJZLjrlm4N1b9Ekk3Uis7EMQgq9WY7
X-Gm-Gg: AfdE7ck3p5mXA5CJABU0+vNEBUJ71Xvgj44PWLybGq8j7LLYRJSuJHZMrrb3QO5kIzv
	DGVVhpNAss1WaWZGC6nUg7M9OegApH3+AZMSbUwWb0xJQayJScseULUX3pC53HvBw5uriW/n0TZ
	oKj0BFkCbnUn0muI6/YMgV1Ew83G13fjldUZft5DOQLmJ+f2+7rlsKUdfwmbgGO93Uv2ac0V4Uy
	4mT7TbKxynpuRcUveOqd903erjX6SM8GiNbucIw8J2TaZjLuQmC+GOFR3LUy+cPIWIN5dMFQHlz
	1vgoxjR0pdfVN/UZKyoBOGtD7LU/s2EdHUP+XzEP+N9Ly/bIILqmrF2Z7jTBWG5t0QfAUpuCWcu
	untGwJjSmI8qx915jmXlxTdQMbNK1AiOjnKKsJky3C6clhbJ9Y/GOXMp/eEsDQ15Tu5+LXIiSEY
	/TNRfnJQcCBmk=
X-Received: by 2002:a17:902:da92:b0:2c0:d097:51bb with SMTP id d9443c01a7336-2c7fc9bfd9cmr15548495ad.1.1782371505585;
        Thu, 25 Jun 2026 00:11:45 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f58cbe35sm14624385ad.0.2026.06.25.00.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 00:11:45 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Biwen Li <biwen.li@nxp.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liem <liem16213@gmail.com>
Subject: [PATCH] i2c: imx: Fix slave registration error path and missing NULL check
Date: Thu, 25 Jun 2026 15:11:30 +0800
Message-Id: <20260625071130.93544-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two issues that affect the i2c-imx slave handling:

1. In i2c_imx_reg_slave(), i2c_imx->slave is checked at the beginning
   and the function returns -EBUSY if it is non-NULL.  If
   pm_runtime_resume_and_get() fails later, the error path returns
   without clearing i2c_imx->slave, leaving it non-NULL.  Subsequent
   attempts to register a slave will then immediately fail with
   -EBUSY, making it impossible to register the slave again.  Fix
   by setting i2c_imx->slave = NULL on the error path.

2. In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
   disabling interrupts.  However, a pending interrupt might already
   have started a timer (e.g. for slave event processing) before
   the pointer was cleared.  The timer callback
   i2c_imx_slave_event() dereferences i2c_imx->slave without a
   NULL check, which results in a use-after-free / NULL pointer
   dereference.  Prevent this by checking that i2c_imx->slave is
   valid before calling i2c_slave_event() and updating the
   last_slave_event field.

Both issues can trigger a kernel oops or permanent slave
registration failure under certain race conditions.  Add the
missing NULL assignment and the missing NULL check to harden
the slave path.

Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
Cc: stable@vger.kernel.org
Signed-off-by: Liem <liem16213@gmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..4f7bcbeecfd0 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -775,8 +775,10 @@ static void i2c_imx_enable_bus_idle(struct imx_i2c_struct *i2c_imx)
 static void i2c_imx_slave_event(struct imx_i2c_struct *i2c_imx,
 				enum i2c_slave_event event, u8 *val)
 {
-	i2c_slave_event(i2c_imx->slave, event, val);
-	i2c_imx->last_slave_event = event;
+	if (i2c_imx->slave) {
+		i2c_slave_event(i2c_imx->slave, event, val);
+		i2c_imx->last_slave_event = event;
+	}
 }
 
 static void i2c_imx_slave_finish_op(struct imx_i2c_struct *i2c_imx)
@@ -936,6 +938,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 	/* Resume */
 	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (ret < 0) {
+		i2c_imx->slave = NULL;
 		dev_err(&i2c_imx->adapter.dev, "failed to resume i2c controller");
 		return ret;
 	}
-- 
2.34.1

