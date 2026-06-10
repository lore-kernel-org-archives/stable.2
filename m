Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7B1D63F3
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052443; cv=none; b=KnvWclmy5QiMxNNZH7+jzFwXToLKNIW8ky5Eoz2WVkOyIkvF5qvsF2Tu/gC1T1thIzJSsFz+z9pTdQK3ChBajyogXDv4pHioWPsnXz8Wqjp3VW4thSxw0VqXEinT1h+M6bs3GhYOA4fjfNC52xzQC4K//rUN3wZlPMOcSzYCtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052443; c=relaxed/simple;
	bh=fGob3JVUZGkEum9KaAUgmRoicK0r6yh/pk/op3mTzhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQRuf2fiiYZQ+LPkBOKgXG+OBCGqJaUC1Nqou6uoNvI9GrzeAr8fhyZmaS+AgxeFBxNYY6EzzlPqdlbQw2utLRj3TZjgOWQyO9oNMKov9su7N7iZQms4K7Ohe9iUwu0p0TAtOyyhSrMH0yark8Gaf4KBFVfxZhjvWJWHPZqfnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=EoIjze18; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="EoIjze18"
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6C0FE3F1F5
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781052434;
	bh=8rCjqGa9OfdcImGk1J17YrL/GWXF/+Y5ltD2+mu6quU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=EoIjze18UqUTB27aXsguV1dDeUOIg7QG9Xsf0q75KmQjaoIwFhKnSy0+fbfsZW9nb
	 6koGE5k9C5nFoYWL/FNu6HMOxVUKsWrm2iBTuq22gJTBVhqTj0qoo3MwIoIir/s2pS
	 IPOMl23PcHIf7JG0mpDm+ZTl1pyTTrNA3vHlxgJR11e2b5Xj3iujZ/B4qYtWc5PMba
	 KRupzhcJP+hODByBCpRLR2Sn0HfoBzPVA6F8nVW23582EHvH/veLXaSBvy+U8Xvrb/
	 CC6ivbqOuxVBI+vou4QIT6+TzAMOYd9rGly+gqnAyJIneb2mVts/gsJBAfvk6E5V9S
	 GHoxY92lW4Fr1REVmiMDFGVuaH1glueWj+xgMwVx2pVWMvX8Jtxkt47IoMRA9Eymw+
	 ELwj3ZSCtcoe5IcIHrIru+1hH9B+eMcAuKC5HvrcuOCH7MoghtmQDE6rn+AvSDg5GW
	 OtQ5j7Q724EG9Vmw6x4eY7G0Zqkx7nUahbsmzNVmq9J/EUgBtJn7LpWABRWcQlIdgE
	 liPOdK3qcrm96F17w5KUuZzaaVPJEqWWMVWa6IyMK3LHOJ4qQVdLq1LabhGar3b8fz
	 vb77H/fSuQs1PIS8CyYl+22psRgoeS7YHEwwCIEVpkMWgvxZfn38RyRuuihskoWFud
	 qxJ1Y96JL6RsXxbbcPP0IZvA=
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304b8d0ee63so8592370eec.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 17:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052433; x=1781657233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rCjqGa9OfdcImGk1J17YrL/GWXF/+Y5ltD2+mu6quU=;
        b=hly8+4H7FcXRDVdx3n3EPny+LKcqSv4yWgkVxUhuNy+h6Mgw2/WE6DU/GBdLo+Gcqe
         mDEBIJJCsVSdhpPToGPnIL6W+GdJMRjGXkezG1+rf2W+fxccKOAQS31Uxenx1lzJ9MO9
         sHQ+3Q90fnri5lQvIeFUl6t7iDDktY/svcitPpLV9xM0NiN/nz1Z7uGNNPQ4u1OH7gIN
         czyGH4qkT/mE+JAiunoirPemsdvS/lIa9qxmRq7Z3qo/vXzvz8PZlResR4hPsbmSNS1J
         10eCelUtJ+LZKwCm5DPodf1lo+9AhnOavhx7yqAaxTzgP4VFyrWIXYAHAATwqkdU+D+Z
         BB/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hrqEvolGuxhAW1A1e7DwsQ4EUW7lPxlq66Q+q4nQ91h7Jabkx2Lp4yl88jjWNm7eLGs4WNBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXAif/yvzMqoP5d++IxUvWymYEbsqxVuD4qQ2t4285brjBIgR
	P/kXrPQqdSXCwjqNF43E9E1OzyM+aOlaKMI3HPjRBvJUYFIm34NFKr4RGpgmedUIFIQRtt7HumW
	wo6a9AwtYh5UTfsWuSXFwJ8M6rSRLpH9EqivQwX15s3AyjjMLD7VErFLOV+DK0X/pbql3DQXRyA
	==
X-Gm-Gg: Acq92OF5caCQMCDtaiwKkeT7on0cEYoAnNCtU5BLn4Nght0jDtGVdqplN0onTLOvPcI
	xazEDkLhAP1zDWvPb8xQa4ty2+TmNXK255lCRPEYmVfZxe5MjVZbp7WT3L0bDtG+lj1CtRhLLu7
	TAi4ktthHuf555MAt2nH8rnpgu5IlsRerw1MfpJl+4hHVJDWT61G9rYIwv3NGa87mwOY6uw4S0K
	zOXQWQEbXSR+/mtJS01BD9bolCQC/mJSsJ/xedndOPyr6iLCnx2ImUc4h2H83R8GSOP08mh9RAa
	34f6AYZGv0EoIS4JtENTR/C8+OVZSv9cEeQyUXyfQUdWsWX5VfsM26inZwMKnAzkGyZlNN1UBKs
	ieF7CT9bEGdMgwpV0EDiT1I/iLeri3IARyBJZr67S0FTurEHevGupS28ElILr4/sIuyUxM3mh2h
	uKTa2C/IjmhlPlkZ6VOkfDctgFVA==
X-Received: by 2002:a05:7300:80ce:b0:2ea:4228:ab11 with SMTP id 5a478bee46e88-3077af32497mr13934423eec.3.1781052432879;
        Tue, 09 Jun 2026 17:47:12 -0700 (PDT)
X-Received: by 2002:a05:7300:80ce:b0:2ea:4228:ab11 with SMTP id 5a478bee46e88-3077af32497mr13934404eec.3.1781052432313;
        Tue, 09 Jun 2026 17:47:12 -0700 (PDT)
Received: from localhost (2403-5803-7ed2-0-44ce-9172-4c63-78c1.ip6.aussiebb.net. [2403:5803:7ed2:0:44ce:9172:4c63:78c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3078c1ac378sm15679307eec.1.2026.06.09.17.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 17:47:11 -0700 (PDT)
From: Stewart Hore <stewart.hore@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	vijaikumar.kanagarajan@gmail.com,
	stable@vger.kernel.org,
	stewart.hore@canonical.com
Subject: [PATCH 1/1] extcon: ptn5150: Request IRQ after device init
Date: Wed, 10 Jun 2026 10:47:05 +1000
Message-ID: <20260610004705.265619-2-stewart.hore@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610004705.265619-1-stewart.hore@canonical.com>
References: <20260610004705.265619-1-stewart.hore@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptn5150_i2c_probe() requests the threaded INTB IRQ before the extcon
device is registered and before ptn5150_init_dev_type() has run. An
interrupt arriving during probe can therefore run ptn5150_irq_work()
against an extcon device that is not yet registered.

Request the IRQ as the final probe step, once device initialisation is
complete, just prior to the initial state read. Deferring the request
until after devm_add_action_or_reset() also lets devm free the IRQ
before the work is cancelled on unbind.

Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stewart Hore <stewart.hore@canonical.com>
---
 drivers/extcon/extcon-ptn5150.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 4616da7e5430..1af5c6aaa2c5 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -275,16 +275,6 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 		}
 	}

-	ret = devm_request_threaded_irq(dev, info->irq, NULL,
-					ptn5150_irq_handler,
-					IRQF_TRIGGER_FALLING |
-					IRQF_ONESHOT,
-					i2c->name, info);
-	if (ret < 0) {
-		dev_err(dev, "failed to request handler for INTB IRQ\n");
-		return ret;
-	}
-
 	/* Allocate extcon device */
 	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
 	if (IS_ERR(info->edev)) {
@@ -320,6 +310,16 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;

+	ret = devm_request_threaded_irq(dev, info->irq, NULL,
+					ptn5150_irq_handler,
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					i2c->name, info);
+	if (ret < 0) {
+		dev_err(dev, "failed to request handler for INTB IRQ\n");
+		return ret;
+	}
+
 	/*
 	 * Update current extcon state if for example OTG connection was there
 	 * before the probe
--
2.54.0

