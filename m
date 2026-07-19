Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BE17D6
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784419738; cv=none; b=UGgulTEzvRdub+rg+F9azrxOyhwXEVNVunkHweeupxmIGnlB43YxdFN2fvuCMsXITk4+DidUzWeNsDlHJetIayxN+7/t2KLdFNm/uQgFv8Xku2s2+rICR7FMpNEO8FmX6ENeWDMVjmN10mSUA/FG3tb18C/wwcjg8crBYY6GtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784419738; c=relaxed/simple;
	bh=7D8/SUNsLqJeWmAc6/7M650HPOnCtrqgAwDdxP/Awdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDtW/wunH4rU0u4Y6VrlHe15tTzpe/WBS2uWiWD/6jxnIvKurcJ2tNFAQRIx+1tZrQs5plaHxNym1zoR8yJx/AVFjRSkEluAcsr4cUim7aeVvcHQsg5N0euGR745Q+Mk5eRMvawU0j6fo7VpVPRTp61ZFzmoCu7SLxyWOiyJ5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAev/fB0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAev/fB0"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b021916bd3so7999466e87.3
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 17:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784419735; x=1785024535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V3noO0sro3v6wdXAQL9ZZ57Lcl83tArU5b36o7WZkR8=;
        b=HAev/fB0kBpxx5GaHOp3B9ae33qHPRuRa84ShYV1ZHuA7nxmbzxQZq6EY1Z1Z1hLrg
         dI4xxNsX4E1VsPYmOBM0RM8Gj8nswZ45qWaZBlYakDRuR34kop39dfagaXu+RU2s/DdA
         9TazQQsswYgNAN04ApAD7DN7uI7qIKubJugSdkv/S3gJlxvcU3MHcqF4nB6Cos1Lq3oc
         JHl+OPTGlwKqc3Es6hQG5pUxGs8SWP+Est+3d4yIPN0VncIqTpYtjITY9+3GI07cOIHI
         iv46o2qAvONIbz2vGX1quoLre+dS3McElK9iDPHjYYK4zyerpn+1EEkXY2Os4cFF/K02
         RqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784419735; x=1785024535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3noO0sro3v6wdXAQL9ZZ57Lcl83tArU5b36o7WZkR8=;
        b=iFkGxSfn6GRyASsOYtqKDZ/6pyrz0mYEs/jV7wRplGLPxjnVCqcF2rLAwox79pSoIQ
         U9y4ILw/MK0b/Tjf3BJ7Gbv2zzC0ieMk+epGh5KEsj7j83mAOqBe4FyDbu2N+AZkZwW8
         u+O810xfc5hFryQNLr+S7771f0QtFgyJamq5BUzgtcSqldHA0dBaDwPTo4A6SyFLxri1
         UcOGhEruWNQbSxgksDr4guARBlXW/xS03YtJvVmRHrwzFeb13JefJyOXDxNaRFjkxgZ1
         t7wxZ1fcVoGYDV91lCFZa6nqNcIgaiiL1oF+EYver3p5vRtQYRbluIlJQ7Omnu9RA2fZ
         ilbw==
X-Forwarded-Encrypted: i=1; AHgh+RpAtTTrY17DcTds6uQWELda6oAQpVejKKXnVBzH8L+go71/pImE1U3R7pUleLBMijyAB2FjKgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/1tMW/K9hz1f3b8TVaXATtvx8TU65i0NUzuK1hNGjhy0l2lvr
	UgPYMb4+Q5rF97V5ZNMnm00H2q8uivIR3j4Po5RKLvXpcpGiM1MmHZSZ
X-Gm-Gg: AfdE7cnK/pM2hGW8v16bvo7IXWMddVdfXc5VMOMLGaefzc4xr6o7sW7tf1MkmPg6eJ3
	jm8C8AlxWQraX9KOQXA3je5dVm0MUeqmsH/pNxmu1bTdJKqtDSuA7A4V2MWZ2cUan87GRgBlxlA
	CvGk09C4KEOpn+9cQx/duTN/Mk5HeBBexhixzu4MDbODSnQHSIPmm7wF1IrYbsaZ2tbw+bgVXX6
	680sJH1U7Gn8WOnx6wNIGNI0P+3YJ71FE7Dg7bq41FxY+EMywztos5FazNycKI0Sb2qZoU2lQYf
	JXcPXFFoVpsRt6Nktjp4lN7cAYEgVpExHBGLVb3G+NFg1g4B4eBmOlocv4KyctUbosMByF1VUYX
	ttYfaf3a+smI4mIRZBhy9H6E2nzhWeWRCnaDrTktbHCPg9rQjF24qwFLjOWm5cZwYvuZxu2XBpp
	szrQWKNxwQ6AYPGmtxLztyxAn7QSBuWYm9x6AkNwYA/gvPl61LDAI5oppo/UmhrpBFP2BjXoYzr
	A==
X-Received: by 2002:a05:6512:15a7:b0:5b0:215b:5de8 with SMTP id 2adb3069b0e04-5b28fabd8f0mr1772058e87.64.1784419734986;
        Sat, 18 Jul 2026 17:08:54 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e0eaccsm1324841e87.38.2026.07.18.17.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 17:08:53 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	stable@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: pressure: dps310: fix NULL pointer dereference on ACPI probe
Date: Sun, 19 Jul 2026 03:07:52 +0300
Message-ID: <20260719000752.75936-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the device is enumerated through its ACPI HID (IFX3100),
i2c_client_get_device_id() returns NULL: the ACPI-derived client name
does not match the driver's i2c_device_id table. dps310_probe() then
dereferences that NULL pointer in "iio->name = id->name" and crashes the
kernel during probe.

The IIO device name is always "dps310", so set it directly and drop the
now-unused device-id lookup.

Fixes: 72ff282819d0 ("iio: pressure: dps310: Add ACPI HID table")
Cc: stable@vger.kernel.org
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f45af72a0554..45bdb8c7670f 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -845,7 +845,6 @@ static const struct iio_info dps310_info = {
 
 static int dps310_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct dps310_data *data;
 	struct iio_dev *iio;
 	int rc;
@@ -858,7 +857,7 @@ static int dps310_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
-	iio->name = id->name;
+	iio->name = DPS310_DEV_NAME;
 	iio->channels = dps310_channels;
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;
-- 
2.43.0

