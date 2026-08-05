Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B63FA5EF
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924115; cv=none; b=MPQvqHQJ2yfV8go57VF1HeE1hhZTqVx6Ttr6KhLopYSvvKDalVplVTWEhlQw9BF0eb+Zt8szPh3UShkC9EjMBQjWSGi2zxKVgCgsX9ciUKKH1GhMlFg0r1bxOzjAIPJw2DoVvAmbj4TX1S7zi0TPg8ekqAQEKxBCXZEvblCFxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924115; c=relaxed/simple;
	bh=NBtOrpbopUFriHHzTeFilMe81NURVCzMvf4Gk5LjoaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlylH485ehMVJuHpV7LnWQX4goHCTjhYy3dXozRPGy7Zlf/j1OA9oIDpt+BmHVdlATCJBDXGOlNkUpgeIG819jDFsTqDe0r17KdJkK95nXFArDOeVrGHDE3lx/LGtJRCeuoCYBMyN7KmIN5uvZei+w06c02Mz0kYnNA2apw/p5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g92xf8FF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g92xf8FF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fe89fb333so458731f8f.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785924112; x=1786528912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpW9ahejzMAV7yB3Jv8UiH8Q3JA7f2h2Kt2WTy+0YGA=;
        b=g92xf8FFVjC7P9uWO+cCk1ggBX2AyVOjMoCqBaQRs6RF8CF6k6AfODoAiC0zvEAzHV
         in63OQGnvqdnOnRPQ6yKZ+cwPs0Njr5dqZEq0rKem8+r+goTgoRPBhAXcr1F+cNtVybi
         wsL4EIQ2nEJIU9FJrvVzVHh9UzhHc2CSN+Sio0GtvpgIBX5heABY6mEkasWraQeP0yGL
         v5P4XtfGLU6OaTYA7q8wenHRZ1rQSIT12gVdha6/CbMg26ucs7CS3Ev9QurvE1yVCoz9
         efcuJZeKkFjXAi5rQ5+Bul5lhbLhTmeAzq1uFNuHeR2ZhivI/8gLvLfrsURY4G1Hcoln
         6s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924112; x=1786528912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpW9ahejzMAV7yB3Jv8UiH8Q3JA7f2h2Kt2WTy+0YGA=;
        b=sWRVjx5H29GbV8ES8axCcpLcm06P9YZ7PNmOgE66ZrVZwWKlcvRDxjN2ngQ6IzAmGs
         raTy6ubUD3FlQ4yrkj4kLIVYALHHwWN9l3buuSVhc/VgD+pGtPtTuWeOG3+OaTtkBZD1
         EUflPsWamgKG51a+KilOy+lG51xF73iM9/QrQdLD17SKH0F9dazi9n5liA3CajkKD8Cx
         HFVKulveIcBdJ2Uvw3qW0NF0VSaAZMV4Dt8RGUN2PyPYVfmioBtWoFgeQt8vi1PdhSE9
         PmJNp2DaGjnkKq7aMpiBOwupa87n55eKYus5OLWo+ZewGgSK8b03LTQZ+U6KQTImcgHy
         jV+A==
X-Gm-Message-State: AOJu0YxSWcWAzvjgWudYk3chfO/jZyMX7yBWF1NA7AYV0mMgCsQwxeWi
	eiHWneR8ZvY8+DWnRvt0RLqQ1YvVnXiv8gD8avYCV5Uo80K6GJes7EEm1arl9j/a
X-Gm-Gg: AR+sD10xQppXu7f/ex6WJ91i0eR8x4emEfTaCB9ZodwcVAO+I5Q+qeSpiqSp+NGKECX
	E18udTcETpmKoCrnMboanUnOcACB+oR4HB9ejGB8lI8OVVNaVGio9Hernzej1LBWZZW97hT4HW3
	x1O2NCGHTp4LTnizj/0Ds6e4oBH62Pcek0JRQEtqQMosN/FkgpzC+RZ8FuYjneRNUOUG+6OBGHS
	fd4r5wPk7lRloaBW/MVr/kVfokAowSFLAx+Lnssqlc4kLhAEkKTuYhuUVGN39X3zJLhKqbjZXAt
	Rq4vgKydAK7GHisRmr1+Vk4bANYXkUc7O4rkzs7PJ6GL+bNyb6Yvgy2r+Z1A15qSxkU6/YxjetM
	dyExLt2UQSk5nb0rQ4RZqrrsOsenm5OGPEaMEDr1Oys0GwCrH+D1wSu9hM30hTZEBqpAnwUVqO0
	vuH8ZFqa/9KVgHZrLBqfup3usvzmuvjydj7SEB04qgZMODj3ymO5QtjVN+l+dcCe5YNA/ouC/CU
	LZY
X-Received: by 2002:a05:6000:1844:b0:47f:9c6f:8844 with SMTP id ffacd0b85a97d-47fec4f8017mr8223459f8f.9.1785924112223;
        Wed, 05 Aug 2026 03:01:52 -0700 (PDT)
Received: from arbab-X395.dbs.corp ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec249a5fsm7344776f8f.33.2026.08.05.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:01:51 -0700 (PDT)
From: Arbab Haider <arbabhaider649@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0.y 4/5] net: cpsw_new: unregister devlink on port registration failure
Date: Wed,  5 Aug 2026 15:01:35 +0500
Message-ID: <20260805100136.59101-4-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805100136.59101-1-arbabhaider649@gmail.com>
References: <20260805100136.59101-1-arbabhaider649@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

cpsw_probe() registers devlink before registering the CPSW ports.

If cpsw_register_ports() fails, the error path only unregisters the
notifiers and then releases the lower level resources. It does not undo
the successful cpsw_register_devlink() call, leaving the devlink instance
and its parameters registered after probe has failed.

Add a devlink cleanup label for the path where devlink registration has
already succeeded, and use it when port registration fails.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260604043115.1409134-1-lgs201920130244@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Upstream commit b64f763b607426ac97e44b114f0b8844ac3b86dd ]

---
 drivers/net/ethernet/ti/cpsw_new.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index c5be359f3c66..b6e25a4658d1 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2050,7 +2050,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	ret = cpsw_register_ports(cpsw);
 	if (ret)
-		goto clean_unregister_notifiers;
+		goto clean_unregister_devlink;
 
 	dev_notice(dev, "initialized (regs %pa, pool size %d) hw_ver:%08X %d.%d (%d)\n",
 		   &ss_res->start, descs_pool_size,
@@ -2062,6 +2062,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	return 0;
 
+clean_unregister_devlink:
+	cpsw_unregister_devlink(cpsw);
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
 clean_cpts:
-- 
2.53.0

