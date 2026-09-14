Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD410442B15
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384867; cv=none; b=HBQkXpqMeFGPIe0s2r8VtoIaaf6xAaXFF3MtixuHe1seuXwBrCG/BbSkYO+yJiEX1NYshu5LNAhSI0pTn+In4Vu586HxgyWp3MC8CCkxe4qexhttPLt5RGo4xpkxw/YoB6xn6ewaL7YHGBCwTuiAqtW7Morj8MjUWHRG/cSWE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384867; c=relaxed/simple;
	bh=rq5NpiVVURxPEKHZWNKaVlsgTfHHMY+YBVtD98Pr4R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVPw6NgaxOQSqXIn4yM8UWMiTxzZfzKNvdiHT82RiRbylAYS+l9zh2iqKbkQT+zkj75sBuF5pXe/saUYbH0L49QbeMjCYHADMooUo2DuNinhy5oJ+cm86i+6Z+FXGe6OhMkqLiwPFkKV38W8Fmcoy34c507AYETfsvQ25pneuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbAKtKuP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbAKtKuP"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2dd664da0f5so6479235ad.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789384864; x=1789989664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Me43ExR5DmXiMgXrmqqfo5yNv2WAFUvXbHnpJpXOxoU=;
        b=JbAKtKuPrdBdl+o2CcieawUG7iQQCX29AvomNPyCG25El+dd2y+1W7SetawKdzMyXe
         FOkSb06sFc/uqrBT499OH4PKEeU+Q+73PL1VjUCbO4qCSs/WWNq6+ZrpeZAIOXctU9hj
         2S58QYLtpha70MUPxNa8JHfk0YjpQ+/ddAFlj84G1SsUKLt9sG5k1Qxi7Rc0ezOJ2GaT
         4aCzXguHyzhnzLU2FC7ShkauHFouv+d4UODiVceiTCGr5kAMK3NGsDdyCwLpH1aC2Lbi
         dclQg7723eUgA2+uPnVEYfoD8w+x8Kerihn+sZDKBgN3sHkq9fU2H/BTOyG4UYGPzCj9
         oKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384864; x=1789989664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Me43ExR5DmXiMgXrmqqfo5yNv2WAFUvXbHnpJpXOxoU=;
        b=WMi1GidB9paafFfTqeiyhklZ04JDbKGXuCmGgbVRyqtk6du+OXKMKFgZIFvSYKkMFi
         aajOuzY07GaVnP1svsQbqkJsCosWxdh5o7e4NjAaxQ2igmUcbUgvsnUVZadgy7IKRn9W
         nbj5oBSZBRUydB85AO/AdZKuvsr0EJK8Hf3X7QT+fbx/hnS7agtn7NQwGKWw0xMzECUR
         m70XQbwzGmAlH7a7lztJtH9azYeySOadSmEy4yz0fykydzPeZ7RFS3L5VxL803mRFxqd
         1XxI6UM+R1fAcUnv9n2jIAQIe9DWp6x8WBqtQLs0AcWBH+mTH2zt2f3jlxrXXX7MctME
         7hzQ==
X-Gm-Message-State: AFuF++lSZfoWqMehBxI9T44c0uNSO4fz4Jf1YC8AC9DvoMMuOABOYUHE
	JqQ3KWxhF96A0ERozACyf5N40r99XTxlrMntHyG+NFQjLvAeYRxZ3/Es
X-Gm-Gg: AYBFou0w8kOYhYUN7bWZesmcfd8Sgc+6Skh3pIIAd38DEdVggODow7N5ce6sgSv/5/p
	2en8DZKHEANhDD73elnEQ9kEn9i/jO6UdTLGWRW6BnDHM5bNuyFScA8PM1hx7lLh4LUEEp+8zKi
	4ftB6wGB7Bf8Jk311mhdGJU6BmGG38H1KQDPdltFUsLiMcO8HuAz5DBCovTfug6pJdDVPlv35SE
	hVf81FV+WXUL2jsoW9EgA0w9yc0AEV6lDiqurEJXKwOQGS3Gnl/QdlmaGJVjO+hQ9yxF8g4fOjY
	vk+ZP/34taTdJd9sZA+WO+RypZ79SEHac6Hiq5TTsZ6yDOdt6paWrsCntbfLYCe9k4VgtOKhqSd
	ilvXbsjwhBgYGcbiN0PkbO5puNYeQu+Hmv0Su6zhv0Mdx54h8bRFD29N+ZUfW7Urqi+F1gHKvx0
	HBTdgDW82FlGatZzhMZ/RrOHKYaaFOYp/lIsQRMHL0N6+WKIxVqUMk4g==
X-Received: by 2002:a17:902:ce88:b0:2d8:da29:da41 with SMTP id d9443c01a7336-2dd6c707c69mr42713475ad.15.1789384863573;
        Mon, 14 Sep 2026 04:21:03 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd445de320sm35512865ad.8.2026.09.14.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:21:03 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Siratul Islam <email@sirat.me>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
Date: Mon, 14 Sep 2026 19:20:53 +0800
Message-ID: <20260914112053.1686061-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kxcjk1013_probe() enables runtime PM autosuspend with
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

Fixes: 124e1b1d0924 ("iio: accel: kxcjk-1013: support runtime pm")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 166fb786425f..c6b030f64be1 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
+	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.43.0

