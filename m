Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278268;
	b=T3bnTI+6ufVejzfAOqBj8wgYvafYtlo2Js1jCQUJxbdfy/ffvuuXoO7PyZ3JofNuXgct
	 F7zrCVAkh5iWysBUlktoa0n35SxWMzO2JXi969brez+8EWpOifrfASc6oxcIxQUPD/9lC
	 fBbcsFCJ8wpoYXCPGuhzA2rZAHF+RhNcengwZRk9kInUlQsL0gYtwqULvBwN1g49JLgpf
	 CTzvAjTOCH/DkPmcx9hum5bGA5VbFMSoXxdilOWjdCI7wa/b1Z2OgIi8dq8MYifRpyURP
	 0FitwEy1TMPoJqZdzLhgoyzVxlbvAIExZTcJF3lxw/UeSN/ztp1tMhGvjd2tYy7srTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278268;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gYI4vNqj1hLHNlqiuEw0CSvZniqka1PdNJbJhocAPEE=;
	b=kk1wX7Sa1CUEwEMIhtzs4gObTeyV7tTQ4qVAPeebp19akq6t0bKsBMt9mH4jJM5Eezuh
	 RQ8k+Ufl79frWQO11RV3xhrTmsszaL4R2NHRmFbArcFDlZKj1i9fL6cNoOknfFx9mfOVp
	 zEEaUbceNcHHphNr2vQUCOFWjqDTrYa0L+gJdjlh34z32yJKtItSLUSqsA01m15szWL9A
	 Xm1/9lxSo1KMvdSBNIPhmXNS116LFFIF9Y+NHLM2ntJI5SOVC12+yQG/+Dz0ax707Wmj4
	 I54QwGxuldjcfm2XDE8wMNwviw0ZHBqX+R+zQDElbq2G7EvKLJqiuGoXFMSUhUd3cWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lvU1tp/P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D35606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvU1tp/P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043D91F0089F;
	Tue, 10 Nov 2026 02:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278267;
	bh=gYI4vNqj1hLHNlqiuEw0CSvZniqka1PdNJbJhocAPEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lvU1tp/PgaGxi/uSkl/3qF+v90u8V6yQe55BaWoteLksY/HYv5/o2Iv4ZIVdpK2KN
	 9eTXtkRxc6JaimZI4Cpqp2ZolQmkAlglO/ienSzRd/Id1C8Fp+G2W30A2bn1s9IbpC
	 c29AlM6MQ0YthqX66BY9jnZctEvxmJvquWV6BaZ4yHF7Qyb529oJ/gXrXUXgWfGs3V
	 FeaAwsmdo6a9asPC86f/kjEB07VrnB8Z512bcMHsRkvcFstnkLpP17F5U0Br+gjPNF
	 Nq7FOD+iW0JDMi9O8ufDOSxkkQIKHTrZLDi+okYHosMBaQpHLqUYQQGziEYP8HGQs8
	 hmioLTnVXwTHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: light: ltr501: Power down chip if request irq fails
Date: Mon,  9 Nov 2026 21:37:45 -0500
Message-ID: <20261110023735.3850926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051617-failed-6.12-8a9bcd587d7d@kernel.org>
References: <20261107051617-failed-6.12-8a9bcd587d7d@kernel.org>
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

From: Esben Haabendal <esben@geanix.com>

[ Upstream commit 8a9bcd587d7d768e6c8e9fff88bb89645e412731 ]

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Preserved the existing IRQ failure diagnostic and surrounding braces that were removed upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8c0b616815b22..3c9e1dc019514 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1558,7 +1558,7 @@ static int ltr501_probe(struct i2c_client *client)
 		if (ret) {
 			dev_err(&client->dev, "request irq (%d) failed\n",
 				client->irq);
-			return ret;
+			goto powerdown_on_error;
 		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
-- 
2.53.0

