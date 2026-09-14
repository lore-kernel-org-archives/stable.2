Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1793AA19B
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385103; cv=none; b=sFbxvBhYvszerhaMtNMYxNaQsEeQiWIdPfme68jQgEoDRZH4CG2oM12srrTbtHY8Yr+v8iJHNLPC1U1pncqzipPeuNlHtKU/KfqPVg/8UNI1YTbmte5Qu8G6nFbiIk4R5kVq5BMOPcRRMNr/WTs+EJ1ECUh7C/fA7hONo6gUm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385103; c=relaxed/simple;
	bh=m4FGhaq8a+nWJ/uaFh8Slz+kDyjA89yddHRxow0Aw0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJndUUIiLr9wNm1RMzuax4mrh/3ylQFIMJngjcPbW+gqf/99GDfwiQdFsQ/MPpPRTCxTWR5roiT6qdU/TjXBTygKHRWNaUav0e2RqTCZpMJpb1q/8FCnjkrMewjthP+QFeALYq7BPf2WEj2fcosFy2U6GJEZowCpLRuUrFIAHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJRGU/SL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJRGU/SL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso32847085ad.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385100; x=1789989900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ok3Mywemwoiloo46/07KIkWHT3aySpVf35ol5uj0s9I=;
        b=AJRGU/SLIRnyupW/xdeRu8jWd2r2g98r46bAaTo7KJZB7ouy+INlQWrdjtUDClR7mg
         RfDS8xvCPFDunyD4HQTak3d83PvjNmmhZ/JspQeJ3N6Hhc7EYhY6K5hfmF5SV6Y6f2+o
         mOhESJ2WZXsxqwghXHz7l7QmHRvS7WAQnzoCGc6rF+JMm6Q07CIOwmj2Ozc5CBnHWg5l
         eHMNLmG2mthgVSuoBFZvRtF54a+jTJMs7caxLdOrDry3dPV0n/nyEnl3BZmJbS/rrAyv
         yG3KHgSvYNw1+nPeY484XI5ZTMf6PfNL/bmunPqEIzPtnScnt+G0zINJnCp5P8sZfgbr
         yh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385100; x=1789989900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ok3Mywemwoiloo46/07KIkWHT3aySpVf35ol5uj0s9I=;
        b=ggzhtbhz8TKI+I8gcdOD2+AD4E4vU2p33oZu1dzmt3eT3e6+Y3U3gllvohoUk0TpRu
         zlBsl3YQavFnkyXyDPyKziNCKb1OK69x2XgINt4A04UBAlQ+UAvBa6J6KyEXrwwuiUR3
         dBH2NqEwdSZvVl26ZhXuTRhdA9E4QZ5ro4Yz22SHYpb+3JGuw5sxhiAQZpifplow8Mjw
         b9yJbgJ9kbdilxBnDEDWvBoBGevAb99uro8pMcAjUEiq55H4aeNRvVG2mAc27KzahH3q
         xrpC7WtcurjzA+UUyaoru3UgFNDlhwOZWeX1L8X39Po04zM3m5pJNtmRB1HjVSTQU1pt
         fo0A==
X-Gm-Message-State: AFuF++kuIHnSYnfKWdMEfXAkrYq1U38sftEmfI1cOHFKocHzqoivjt93
	yOFJgVgbY2to6HBQlT6RCQarvou0e3FCpUtaK/OMmlBuA1LFWH72de3l
X-Gm-Gg: AYBFou2HNRxe1hSG0tvkn+u6FkEDEaiJ3VgfjdkXBxduPgOR8uMyLfNCN2qrJphyDoQ
	ZpsRNJJBqoMnm0ZhXUfKNJBSBNj3yzfZovawJBgvIplEVrR7SVwrDoAn+dPKRoIwhLu36fRWgqe
	A3oER5/lGq4lD97ngQuvY1UG0e9dyYvKWd8TIAXEqqybFrpNZ2Lmtp8SwLPLtsQRrlLKmTLmouj
	79d9cd8a304Wh2eBOFAemVxB/geLxIndbcTnjHLo8rkbGXaWEdtDd4FK/Ue/p7W7O2hItjPwAMq
	wUF9zlwxLkkS3JTkB2DbYcdihiYU15e6s3nvlmH7XQpJYihHgRoSWmo6ItTbzyIm1AusEt622EM
	RtqkVxIlGGWn85RrzpYG+UU7aXxHhzx+eDg18MX0tP0JB4oV9n1sSgjmgZ/9FZT1ih/R572FDMu
	WjLtgdo/n4h+4t4ozX2Bz75QA8mUGwd8sVAVQsup93asAKi/hE1JZg5A==
X-Received: by 2002:a17:902:ecc6:b0:2da:eb8f:b4e4 with SMTP id d9443c01a7336-2dd6c5f3a7amr41335295ad.7.1789385100156;
        Mon, 14 Sep 2026 04:25:00 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd69745cb5sm10810585ad.43.2026.09.14.04.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:24:59 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Siratul Islam <email@sirat.me>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <ddvlad@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] iio: accel: mma9551: disable autosuspend on remove
Date: Mon, 14 Sep 2026 19:24:47 +0800
Message-ID: <20260914112447.1686972-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mma9551_probe() enables runtime PM autosuspend with
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

Fixes: 6da93a6710a3 ("iio: accel: mma9551: Add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/accel/mma9551.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 7e01427fd9c4..182f488edab1 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -500,6 +500,7 @@ static void mma9551_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
+	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.43.0

