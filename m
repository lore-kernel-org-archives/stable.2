Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278859;
	b=3derwPg1HVsLsb763QH0YaNIRUidk8oJ/llDyT0xQm8h+7ltLNWn0nWZvVFy6hukQkWi
	 Bt5AophOceehuIxLnKit1bgLxHzt/QjbtkHomCIlFmOpZbIzDbTaba6fE5K4cCJ3MAJa7
	 CDLibzxyAJtIM5JsM/OX7VCiW0wK3Fb6GERc6g7WVLWmYP7UgPyFhjWS8GAdbXby+VllE
	 V+yUC29V3TuplWpuGU24SGF2A9oBlgS3fepEdkl5bu+vcGLZoJhX6LPa2sOK/0e2+KQNG
	 za95M/jDQGtb22JKmyiIiSFGouAa8jHkDp35NOnrggbt5YFYImny7CcdCYJWtTDO2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TdTIV+Y3exMBVeF+7kXrvBvVpPT1bYexYHSy6d81+QY=;
	b=DwBQdUZz4Z5gpNLgPqTUM8p39Z42UCxGVu+lwxUSCdlN4gPTsVxcc4GsN5RnxirACWTJ
	 gjTsYCuK2lMDdfUA4qGZH/gOOW3onpvXrOknaE3HEqoI+4jVambrc3PnnhwxIO6Dqr6LV
	 ZNDCx82ZnvRx3suKE0J6hfCstBM4fxdJhaYAO0uaX67xeK+K8b5b6GQibr0a14Otodzza
	 ZgO0hs5k0zRFwXQHrLS6Q4iOfdCIGYgUtPii3dGhHormo8b/nZz0PfhFMtkq/QHEJxk/d
	 0TnFFGWmANx+ZWeK6+wzaoBa6oYUNQIa9WA46TDxjMxgcjAkUIG/YKhKHYwUTo/o3pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjglWTdG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjglWTdG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D551F0089F;
	Tue, 10 Nov 2026 02:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278858;
	bh=TdTIV+Y3exMBVeF+7kXrvBvVpPT1bYexYHSy6d81+QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjglWTdGKEoNTH6bR0y4W4yZL2Po7ZjgAA8/QxMSoLD4mLSk2fnWxdNr9NOGhZu6R
	 fns2FFM2P+btJQ4jreQ1QTFTnKdHgGzlXTFxjcR72jSONbcD4WMgeLm5pvKalw8uto
	 CQCGGEm/GMxX652Q4kAhQD75U9pYBVKv0Dw6l/yWWGGi5v1y5wgIelPiQBjKbDsaep
	 ZTwooC/bft9xcHyXIrTpZUkLLikilKB+rDwl60xFVnuKIK5qge6fmR3vAtPeHqM/2p
	 wehmr0upFRT7Bq2tkR1eRpRNauYqkbprhRg2QoWjNPk3lZRG39k9t42ir76+1tsM9L
	 9z0cCzhyVI7Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: light: ltr501: Power down chip if request irq fails
Date: Mon,  9 Nov 2026 21:47:36 -0500
Message-ID: <20261110024707.3989689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055712-failed-5.15-8a9bcd587d7d@kernel.org>
References: <20261107055712-failed-5.15-8a9bcd587d7d@kernel.org>
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
[ sashal: adjusted context for the existing IRQ request failure logging block ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index f0bd0ad34f222..a5275165d7fe2 100644
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

