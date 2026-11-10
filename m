Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283820;
	b=Pb+90vxXXuRurGBodX0fkaqwdTzQOEW0Fwi/LBrFEZ6sLZrsS/WE4QwlnV3EJWYFP9X8
	 h66/g6Q6hnafBaHQYuLJZyZQCEt8/hwSpToowwEyZqbVRijinIcHQulrMasNm/T6h8iMg
	 lsDRStwE6FzobqsHNRwQMd5S1O7hthHxIAvup1U/N2SMNCiZB5+VZ6h9zolwdj5A93HDI
	 6Vv2Eg4s4Ku2nutWZC94pt/EJ7wVaEwnyElR5L43WFSjI/Y0HrKrRVK20b1VKd4kH0Spv
	 ji/6p34PIQTt8ePSOLeQVd91+AQNR/38qOobV50m1CEykYHckpCMlJcELdmUoVm//ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283820;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qn25Dw8i8n3ICbelYvOJYiedvZKnS5YUhUoqH1/KllQ=;
	b=smUXEXMPuqOtzXI0kaUEhGrJTbWjucmYbxOpEFkmEbbkV8OlDTCfIIuK8CFO2R7IEF9C
	 yZNifwF59eDZLJYDu1ndvri8Hu5pLA7+RZpFMJSL3MVjcLHWPSXUdGWOm/cHZqI8yvi2k
	 fBDbRIGcvl2mlJsJr/2YLRV58Z7JoLOTfwqzseO/Z/EQtmN+vhktJKeqq3h3IOq1dRbZy
	 ZLPhQiwYApAdXeLFqtgW/0Kw1JRTMofEqmA4nQLG5eCM8stYVmoWcycpmXaVxwa66KrJJ
	 OI2yk2wW33mS/ocIHOikpYS6pJ57SI4mEj17JbUWKl0kdW/ozXjgjFBaVj/GRABA9ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbNCkRQK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B8606CF03
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbNCkRQK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B731F00907;
	Tue, 10 Nov 2026 04:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283819;
	bh=Qn25Dw8i8n3ICbelYvOJYiedvZKnS5YUhUoqH1/KllQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YbNCkRQKTzGwIoASWFHXhY5Lj0eKyM8QsBCPHBTMOMCNSACElOkqPTBwfKNJpJ6D5
	 /PcvJYoW4II1pX1JMXIxxJwAtZjaaic+3Mwj2f839pZGitMHqjSYTD9XFt2XSo8jcq
	 8y5yYlZCkSqJ8EVlvDqkHjNolMjv4I+GqhkVXyRRtPRp7QJiwsZRHT/J3bWCLom70g
	 wvhOwPDxNPpulNqmnw0NhIiHOG6vZ+oGT2DVvhIJ3KtAdVPFYA00xKo2bvhkP9fH7G
	 r+1i65xy2gHomEyyCZHNI90Y/bi5FjPEKPRktKtDjF3oGwjwNc3WTUxo9sLGK1zHyM
	 ZJiCX9zgmdp2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: light: ltr501: Power down chip if request irq fails
Date: Mon,  9 Nov 2026 23:10:17 -0500
Message-ID: <20261110041005.4067822-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061415-failed-5.10-8a9bcd587d7d@kernel.org>
References: <20261107061415-failed-5.10-8a9bcd587d7d@kernel.org>
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
[ sashal: adjusted context for existing dev_err() logging in the IRQ failure path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 379236a806fac..77cb094d5753c 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1510,7 +1510,7 @@ static int ltr501_probe(struct i2c_client *client,
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

