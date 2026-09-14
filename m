Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA94279FE
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426401; cv=none; b=OMq9fX4XAUYeBoE7swXEqYSm1+pX89lYXU52293CSyDapNxXZJJqNRO8O+6sWzWZw9+0qbWGRCGx0m9N6IuVhMaeiBvZ2OhFT9SvpD33aESZJaWoClrHs/IbKViZLQbG9xEIWLTJyxOubAiPwoJXpvv1KHuiHjruekeUbpSXkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426401; c=relaxed/simple;
	bh=v9W246k4i5nC9ZdyWZi1OCDWQVULW5oh4JWWhuxaeuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBmj6oiVL0HcW79KQavCkl/awefmSUQ2laVKK+h4o9LmIcLJT+9GYdEoB3HaoM1xpwu8xEDDQe5aB6TcmRU7u4xn4GuRU0oiEzq0q6x3GBntvf8bBPiZs92EV/V6UmXaO+qjpD8K8Kl78qREBpReshBTaYK7mr2RPpu/MhvliX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dohM/q/L; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dohM/q/L"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1944016a91.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426393; x=1790031193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BN8kNGGOstdu3D+3MzZhZpT0mSPpKY6fG+DlEioFUuE=;
        b=dohM/q/LJrug23wvrlKE9g6q5ylcIts8vsVeDy+4lQjcALywDDRVvFZxop2mzLr6vK
         o6nCS15ea0aMk+8b1ONVpHUFGtT9ef2Pzwr/0te32027H27PXL8j3PERSyY3LJvGgGvJ
         evAzZWdrGBk/Bp2y5zCeS5RO7T0shNFkoH8/0Rwo+W3rMsfXdSknhKIOulHxp7M4p8sG
         xh8hdt58+HON/OTWKwtvsRCwEZ+6M34bDA/XWqUlAyteHMTDTQ0XZ9i1T0Eu+s4cP7t4
         d0/8/a3K8q83fr0qhRpscYfT7XNaQQYY1GwI7Dzxd7Vo54c3mCvD62E4FGitCAU24jfd
         aVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426393; x=1790031193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BN8kNGGOstdu3D+3MzZhZpT0mSPpKY6fG+DlEioFUuE=;
        b=JZqReIeFqyfKPSh+iwJyjABC5qY2USUheyHsLBX6REUXtGe7JEfLzeZocSXKH/YQHN
         5w23fIlHk1oSVLRyLR5k38cOc8X2cMYXIk8mUSPnklNdqWU/mVrzoDTP1qFaGUL/Kz9K
         QUJ6gYQBxwxlmePUA79x7iH0iku4ozqBdrArDreh9q7AM/bumn5ak66+4/ECsK3podGt
         RmTlja892yJ9f+AUKYAmReld1ffstG3uHCGcZiObAkgqrezztaaTy2OtFs59qmekvd3P
         vL+M8zutTtfYU7uoz4LfFTrNKGtv7CDKcKB02EldFfPKSN7iJa+8sS5WDvQyOv9ZDxfI
         IYvw==
X-Forwarded-Encrypted: i=1; AKwUvBxWGy3htogo9ZHGlpbP85of2qwcyi2+ar6ScICItNacepxJpsaC6m6CTsitJQhkmX9kTKli5VU=@vger.kernel.org
X-Gm-Message-State: AFuF++lRyxLqnJNI8Qrq/5TJEsPMl7VWF1KXPWNYqJtVikXhUv13h4ZD
	/qaqZSKrALT5tKuer035eBTAGGEpz/D7Oioy3mX5EfCSqAHYx9K9NtBp
X-Gm-Gg: AYBFou21a+5Ixvgr/qU4kWDOtB08vu5gvxZQhpm26bGrZncBs3nxxLocjpKWqqeajcY
	KZnWGPnYqIZcTsroQa68zCPWKCfsL4HJhryT+UI8sV2T5AutuV9FDyRp0SVyuhPxtOCaca9undf
	IFpiS+jxxbsW09Ovu/DnEzVWJKi8ypbVmuGkzp2osmFIs672vE7WpEQu5C68IECXF8x58ns1mRi
	OLG/vA+SUHPGffC9ammc/YIwVfcyeA4EU0WU+TtI7nUtO34Xh1689BtxVzrqhhxzmcedf+LZ1I/
	7yrClF39vMR/QWre2ac7571taDQjhQSxiRPdxZvZ91CeWSZ/z7GumG9SBjbpxP+zGot0H46zxXG
	P4RqIA7J/RpHgBJ0Wkw0BKqD3d1lqT8EcIGaUNvXvzTAkoShDuPA/rGkB+Bjc816NryNZUxfICX
	zctuL5WRSLdqSLfQa2M7Uxd6bQ15liF0qthN4HHtU2yQI3BDNpxF43Xm4idUpaYXnGzsNWGF6HU
	a1XiDgJTKgCEoyylmtEBO3BR+U2KgHobhOb3v703sgxRkJSwhDA
X-Received: by 2002:a17:90a:1056:b0:39d:ec9a:8f8e with SMTP id 98e67ed59e1d1-39dec9a90b5mr6114824a91.8.1789426393321;
        Mon, 14 Sep 2026 15:53:13 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:12 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 05/10] HID: hid-lenovo-go-s: Add kobject_uevent notify during reset-resume
Date: Mon, 14 Sep 2026 15:52:58 -0700
Message-ID: <20260914225303.868569-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds kobject_uevent notification after setting os_mode attribute on resume.

Fixes: 3524900cc571bd922a ("HID: hid-lenovo-go-s: restore OS_TYPE after resume from s2idle")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index b6850cf2c029..712823e22bea 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1467,6 +1467,7 @@ static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
 	if (drvdata.os_mode != os_mode)
 		return -ENODEV;
 
+	kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
 	return 0;
 }
 
-- 
2.55.0

