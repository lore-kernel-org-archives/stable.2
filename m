Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816529;
	b=XvYfDLYf5skGdNJC8ql/zwNYQGOC1X938KI4ARI4N7PqbGy4p2aSnbT8KxWUmnE6gkj0
	 cVTR6xydivSduNFwT86/0XA14S3CCf9YRGVdP8Pv7QuPM4YGDvqwXKNpDJjqGoKw61Qjw
	 9PNeyUosVbzyqjTE1NZcZ51elDE9sck5xpoFaLKzIklEYyfAADfSYt1s0xPlpabWCdpPZ
	 FTemyI1fonhrvTI1aTrphkuUtk4ORekxj2HppE4rFNa9ML8GaOGZqOMIqp/ooQ6l59mAM
	 r6+UJEdCJA4z4MHIo0LhttHsN+JNMu+uH6+4TucOebzLNZAuAshWYvyJHx7gOMAV1UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tKZ99yrY5MwjJg6mbBHdYITDM8HO7rTF9ZUJ5jgSrtE=;
	b=EywvljzzKkEqimYoR+6Rq8rDjhYOo+zCOS7IHGkWTVvydpkVehQCi35CXM9APTXOt8sI
	 2LXwxl0QXpwdXSwNfswFax0RMW8OxJzH3LYJF8asXkI4FxpbtbqJG8g5ex7huhIcusmxh
	 mGeIwr2o9jTMk8mtg2j/oRx24KmuBV1JadxCmX2WVMkjBPK0s3u+VzgazH9T8SmFkvxnB
	 Rn4VCI6reUs7qPza9YfWUpEvxSA3w5MgUg7/ks6cYuEqm+Tocmpimbsf6FZztsbCHz4KK
	 /tFb4Y1w/UVi6LVHyCwaLgske2mZCAwPMklXbBegkLY7MVpt8ORchiJ/gk0OzY4+ocw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkFlMoZa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79496083613;
	Wed,  4 Nov 2026 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkFlMoZa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8A61F0093A;
	Wed,  4 Nov 2026 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816528;
	bh=tKZ99yrY5MwjJg6mbBHdYITDM8HO7rTF9ZUJ5jgSrtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TkFlMoZakaOAg8ky4ucULLy9xFmOWcZnDHOV2mS3j5XC0wUC1q/PoCV++kMnfkOEQ
	 TUqS2Dw5zrSNBAgL44c5nR7fb/rlwVn/crSMgqEogrQqnGyWBP1dKzg06JKNs8yDU7
	 0huHLzjp6YLouavcfQg2jc4ib3CV0pmBkRw6FsrgoI91LsR2ekKVsJUbqLgkHmaS6P
	 pb+hBlpEU61GTKahFiI0hOYyfcMf9+2Rh5gltvGMqDMFazpBt1s5PkIi/Dw0FYlJQ0
	 xlL1WTndlGPwQmz+9BMkyI6nqSfZQV4NaF3gm2FEz42XeclJkV4XEVIeSz3qeY5lqe
	 kKnoFe4jXg9SA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] regulator: arizona-ldo1: Avoid double gpiod_put() on enable GPIO
Date: Wed,  4 Nov 2026 18:20:52 +0000
Message-ID: <20261104182148.1176116-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing config.ena_gpiod to devm_regulator_register() transfers ownership
of the GPIO descriptor to the regulator core, which releases it via
gpiod_put() in regulator_ena_gpio_free() upon registration failure or
when devres unregisters the regulator.

Calling gpiod_put(ldo1->ena_gpiod) in arizona_ldo1_remove() prematurely
frees the enable GPIO while the regulator is still registered and causes
a second gpiod_put() when devm_rdev_release() runs.  Drop the redundant
remove callback and ena_gpiod field so the regulator core manages the
descriptor lifetime exclusively.

Fixes: a9191579ba10 ("regulator: arizona-ldo1: Use correct device to get enable GPIO")
Closes: https://sashiko.dev/#/bug/linux-7988402e-ca08-4bd3-9488-5779d6da0450
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 501843996faa..981e047167ea 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -35,8 +35,6 @@ struct arizona_ldo1 {
 
 	struct regulator_consumer_supply supply;
 	struct regulator_init_data init_data;
-
-	struct gpio_desc *ena_gpiod;
 };
 
 static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
@@ -262,8 +260,6 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 	if (IS_ERR(config.ena_gpiod))
 		return PTR_ERR(config.ena_gpiod);
 
-	ldo1->ena_gpiod = config.ena_gpiod;
-
 	if (pdata->init_data)
 		config.init_data = pdata->init_data;
 	else
@@ -287,8 +283,6 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, ldo1);
-
 	return 0;
 }
 
@@ -339,14 +333,6 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void arizona_ldo1_remove(struct platform_device *pdev)
-{
-	struct arizona_ldo1 *ldo1 = platform_get_drvdata(pdev);
-
-	if (ldo1->ena_gpiod)
-		gpiod_put(ldo1->ena_gpiod);
-}
-
 static int madera_ldo1_probe(struct platform_device *pdev)
 {
 	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
@@ -375,7 +361,6 @@ static int madera_ldo1_probe(struct platform_device *pdev)
 
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
-	.remove = arizona_ldo1_remove,
 	.driver = {
 		.name = "arizona-ldo1",
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
@@ -384,7 +369,6 @@ static struct platform_driver arizona_ldo1_driver = {
 
 static struct platform_driver madera_ldo1_driver = {
 	.probe = madera_ldo1_probe,
-	.remove = arizona_ldo1_remove,
 	.driver = {
 		.name = "madera-ldo1",
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
-- 
2.56.0.385.gac671c819a-goog

